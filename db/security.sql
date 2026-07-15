-- Close the Supabase Data API surface on the public schema.
--
-- This app reaches Supabase purely as hosted Postgres over JDBC (see
-- src/main/resources/application.properties) and connects as the `postgres` role, which
-- carries BYPASSRLS. It never uses PostgREST, the anon key, or Supabase Auth. Supabase
-- nonetheless publishes every public-schema table over PostgREST, readable and writable
-- with the anon key -- which is public by design. Hibernate (ddl-auto=update) created
-- these tables with RLS off, leaving them open to anyone holding that key.
--
-- RLS is therefore enabled with NO policies: default-deny for PostgREST, no effect on the
-- Java app. auth.uid() policies would be meaningless here -- there are no Supabase Auth
-- JWTs in this system, and users.id is a bigint identity column, not a uuid tied to
-- auth.users.
--
-- Run this in the Supabase SQL editor AFTER the app has booted at least once (Hibernate
-- creates the tables). Pair it with Settings -> API -> Exposed schemas -> remove `public`;
-- that dashboard setting is the layer that survives Hibernate adding new tables later.
--
-- Re-run after adding any new @Entity: ddl-auto=update creates new tables with RLS off.

-- Revoke PostgREST role access to the current objects.
REVOKE ALL ON ALL TABLES    IN SCHEMA public FROM anon, authenticated;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM anon, authenticated;
REVOKE ALL ON SCHEMA public                  FROM anon, authenticated;

-- Apply the same revoke to anything Hibernate creates from here on.
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE ALL ON TABLES    FROM anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE ALL ON SEQUENCES FROM anon, authenticated;

-- Default-deny.
ALTER TABLE public.users    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.joins    ENABLE ROW LEVEL SECURITY;
