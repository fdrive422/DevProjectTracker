# Deploying DevProjectTracker (Google Cloud Run + Supabase Postgres)

This app is a Spring Boot **WAR with server-rendered JSP** (embedded Tomcat). It runs
as a container on **Google Cloud Run** and stores data in **Supabase Postgres**. Both
have real free tiers.

---

## ✅ Current live deployment

| Item | Value |
| --- | --- |
| **Live URL** | https://www.devtrackr.app (custom domain) · https://devprojecttracker-173332298123.us-west1.run.app (Cloud Run) |
| Custom domain | `www.devtrackr.app` — CNAME → `ghs.googlehosted.com`, mapped to Cloud Run, Google-managed TLS. Registrar **Vercel** (DNS stays on Vercel). The bare `devtrackr.app` redirects to `www` (Vercel apex is locked, so it can't point at Cloud Run directly). |
| GCP project | `devtracker-app-2026` |
| Cloud Run service | `devprojecttracker` (region `us-west1`) |
| Supabase host | `aws-0-us-west-1.pooler.supabase.com:5432` (session pooler) |
| DB user | `postgres.poqghcdbjpnwtghglzve` |
| DB password | stored in **Secret Manager** as secret `db-password` (not plaintext) |
| Scaling | `min-instances 1` (always-warm), `max-instances 1` (session consistency) |

### Redeploy after code changes

```bash
cd /Volumes/SSD-T7/Coding/DevProjectTracker
gcloud run deploy devprojecttracker \
  --source . --project devtracker-app-2026 --region us-west1 \
  --allow-unauthenticated --port 8080 --memory 512Mi \
  --min-instances 1 --max-instances 1
```

Env vars and the `db-password` secret persist across redeploys — you don't re-pass them.

### Cost knob — go back to free (scale-to-zero)

`min-instances 1` keeps one instance always running, which exceeds the free tier (~a few
$/month at idle rate) in exchange for no cold starts. To return to **truly free** (idle =
$0, but a ~5–10s cold start on the first request after inactivity):

```bash
gcloud run services update devprojecttracker --region us-west1 --min-instances 0
```

### Rotate the DB password later

```bash
printf '%s' 'NEW-PASSWORD' | gcloud secrets versions add db-password --data-file=-
gcloud run services update devprojecttracker --region us-west1 --update-secrets DB_PASSWORD=db-password:latest
```

(Also reset it in Supabase → Project Settings → Database so the two match.)

---

## Reference: how it was set up from scratch

## What changed to make it deployable

| Change | Why |
| --- | --- |
| `mysql-connector-java` → `org.postgresql:postgresql` in [pom.xml](pom.xml) | Moving to Supabase (Postgres) |
| [application.properties](src/main/resources/application.properties) now reads `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`, `PORT` from the environment | No credentials in the repo; Cloud Run injects `PORT` |
| Hibernate dialect → `PostgreSQLDialect`, `ddl-auto=update` kept | Hibernate creates the schema on first boot |
| AJP connector (port 9090) in `DevProjectTrackerApplication` now gated behind `app.ajp.enabled=true` (off by default) | Cloud Run routes a single port; an unsecured AJP connector is a risk |
| [Dockerfile](Dockerfile) rewritten as a multi-stage Java 11 build that runs the WAR on `$PORT` | The old one used a Java 8 base and an invalid run command |

No entity/query changes were needed — the models use `GenerationType.IDENTITY` and plain
JPA, which Hibernate maps cleanly to Postgres.

---

## Step 1 — Create the Supabase database

1. Sign up at [supabase.com](https://supabase.com) → **New project**. Pick a region close
   to where you'll run Cloud Run (e.g. `us-west-1`). Save the **database password** you set.
2. In the dashboard: **Connect** (top bar) → **Connection string** → **JDBC** tab, and choose
   the **Session pooler** (Supavisor, port **5432**).

   > ⚠️ Use the **Shared Pooler / Session mode**, *not* the Direct connection. Cloud Run
   > egresses over IPv4, and free Supabase projects expose the direct connection over IPv6
   > only. The shared pooler is IPv4 and supports all Postgres features in session mode.

3. You'll get a host like `aws-0-us-west-1.pooler.supabase.com` and a username of the form
   `postgres.<your-project-ref>`. You now have the three values Cloud Run needs:

   ```
   DB_URL       = jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres?sslmode=require
   DB_USERNAME  = postgres.<your-project-ref>
   DB_PASSWORD  = <the database password from step 1>
   ```

## Step 2 — (Optional) test locally against Supabase

```bash
export DB_URL='jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres?sslmode=require'
export DB_USERNAME='postgres.<your-project-ref>'
export DB_PASSWORD='<password>'
./mvnw spring-boot:run
```

Open http://localhost:8080 — Hibernate will create the tables in Supabase on first boot.
(You can verify them in the Supabase **Table editor**.)

## Step 3 — Deploy to Cloud Run

**Prerequisites** (one time):

```bash
# Install the gcloud CLI, then:
gcloud auth login
gcloud config set project YOUR_PROJECT_ID          # a GCP project with billing enabled
gcloud services enable run.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com
```

> Cloud Run's free tier requires a billing account on file, but hobby usage stays within
> the always-free allowance (2M requests + 180k vCPU-seconds / month).

**Deploy** — Cloud Build reads the `Dockerfile`, builds the image, and deploys it:

```bash
gcloud run deploy devprojecttracker \
  --source . \
  --region us-west1 \
  --allow-unauthenticated \
  --port 8080 \
  --memory 512Mi \
  --min-instances 0 \
  --max-instances 1 \
  --set-env-vars "^@^DB_URL=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres?sslmode=require@DB_USERNAME=postgres.<your-project-ref>@DB_PASSWORD=<password>"
```

Notes on the flags:
- `^@^…` tells gcloud to split env vars on `@` instead of `,`, so the JDBC URL is safe. If
  your **password** contains an `@`, use Secret Manager instead (below).
- `--max-instances 1` — **important.** Login state uses in-memory `HttpSession`. With more
  than one instance, requests can land on a different instance and appear logged out. One
  instance keeps sessions consistent (fine for a hobby app).
- `--min-instances 0` — truly free; the instance scales to zero when idle and cold-starts
  (~a few seconds for the JVM) on the next request. Set it to `1` to avoid cold starts
  (small always-on cost, may exceed the free tier).

When it finishes, gcloud prints a `https://devprojecttracker-….run.app` URL — that's your
live app.

### Harden the password with Secret Manager (recommended)

```bash
echo -n 'YOUR-DB-PASSWORD' | gcloud secrets create db-password --data-file=-

gcloud run deploy devprojecttracker \
  --source . --region us-west1 --allow-unauthenticated \
  --port 8080 --memory 512Mi --min-instances 0 --max-instances 1 \
  --set-env-vars "DB_URL=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres?sslmode=require,DB_USERNAME=postgres.<your-project-ref>" \
  --set-secrets "DB_PASSWORD=db-password:latest"
```

If the deploy reports the service account lacks access to the secret, grant it:

```bash
PROJECT_NUMBER=$(gcloud projects describe YOUR_PROJECT_ID --format='value(projectNumber)')
gcloud secrets add-iam-policy-binding db-password \
  --member="serviceAccount:${PROJECT_NUMBER}-compute@developer.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

---

## Redeploying

Just rerun the same `gcloud run deploy --source .` command after committing changes.

## Troubleshooting

- **Startup fails with a connection/timeout error** → you're likely using the Direct
  connection (IPv6). Switch `DB_URL` to the Session pooler host (`…pooler.supabase.com:5432`).
- **`FATAL: Tenant or user not found`** → `DB_USERNAME` must be `postgres.<project-ref>`,
  not just `postgres`, when using the pooler.
- **SSL errors** → keep `?sslmode=require` on the JDBC URL.
- **Out-of-memory / slow start** → bump `--memory` to `1Gi`; the JVM baseline is ~250 MB.
- **View the logs** → `gcloud run services logs read devprojecttracker --region us-west1`.
