# DevProjectTracker

**🔗 Live app — https://devprojecttracker-173332298123.us-west1.run.app**

Developer Project Tracker is an application used to manage software projects from planning to deployment... add projects, update, and manage tasks.

## Tech stack

- **Language / runtime:** Java 11
- **Framework:** Spring Boot 2.7 (Spring MVC, Spring Data JPA)
- **Persistence:** Hibernate / JPA over **PostgreSQL** (hosted on [Supabase](https://supabase.com))
- **Views:** JSP + JSTL (server-rendered), embedded Tomcat
- **Front end:** hand-written CSS design system (no Bootstrap) + vanilla-JS light/dark theme
- **Auth:** jBCrypt password hashing
- **Build:** Maven (`war` packaging)
- **Deploy:** Docker image on **Google Cloud Run**, secrets in Secret Manager (see [DEPLOY.md](DEPLOY.md))

## Theme

The UI uses a "warm dev-tool" theme — a cream/coral palette with monospace accents.

- **Light + dark mode.** The theme follows the operating system's preference by
  default, with a manual **☾ / ☀** toggle in the header (a floating toggle on the
  sign-in page). The choice is saved in `localStorage` and applied before first
  paint, so there's no flash on reload.
- **No Bootstrap.** Styling lives entirely in [`views/css/main.css`](src/main/webapp/views/css/main.css);
  the theme logic is in [`views/js/theme.js`](src/main/webapp/views/js/theme.js),
  loaded in each page's `<head>`.
- **Design tokens** (light / dark) are defined with the CSS `light-dark()` function,
  which needs Chrome/Edge 123+, Firefox 120+, or Safari 17.5+.

  | Token   | Light                 | Dark                  |
  | ------- | --------------------- | --------------------- |
  | bg      | `#faf7f2`             | `#1c1917`             |
  | surface | `#ffffff`             | `#26221f`             |
  | border  | `#e7e0d6`             | `#3a3430`             |
  | text    | `#292524`             | `#f0edea`             |
  | muted   | `#78716c`             | `#a8a29e`             |
  | accent  | `oklch(0.60 0.15 40)` | `oklch(0.73 0.13 40)` |

- **Phase chips** default to one neutral coral tone. If a project's phase matches
  `Planning`, `Design`, `Development`, `Testing`, or `Deployment` (any casing), the
  chip is tinted per-phase; any other value falls back to coral.

## Project Images

![alt text](<assets/Developer Proset Tracker.png>)

![alt text](<assets/Pasted Graphic 2.png>)

![alt text](<assets/Pasted Graphic 3.png>)

![alt text](<assets/Pasted Graphic 4.png>)

![alt text](<assets/Pasted Graphic 5.png>)

![alt text](<assets/Pasted Graphic 6.png>)

![alt text](<assets/Pasted Graphic 7.png>)
