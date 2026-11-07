# CLAUDE.md

## Task

Implement the course registration application specified in `docs/`. Read every file in `docs/` before you start.

## Rules

- Work autonomously. Do not ask questions.
- When the specification does not answer a question, make a decision and record it in `docs/assumptions.md`.
  Write one entry per decision with: an id (A-001, A-002, ...), the requirement or document it belongs to, the
  question, and your decision. Record every decision that changes the behavior a user sees or the data that is
  stored. Do not record pure technical choices (class names, package layout).
- Do not change any other file in `docs/`.
- Write tests for the behavior you implement (Vaadin browserless tests for the UI, integration tests with
  Testcontainers for the database access).
- Finish when `./mvnw verify` passes.
- As the last step, after `./mvnw verify` passes, write `session-log.md` in the project root (not in `docs/`) with
  the session length (start, end, duration) and the token usage (input, output, cache creation, cache read, total).
  Take the values from the session transcript, do not estimate them: the newest `*.jsonl` file in this project's
  folder under `$CLAUDE_CONFIG_DIR/projects/`, plus the transcripts of any subagents in its `<session id>/subagents/` folder.
  Use the first and last `timestamp` for the length and sum `message.usage` of the `assistant` entries, counting each
  `message.id` only once. If you continue after writing the file, update it before you stop again.

## Project

- Generated from the [vaadin-jooq-archetype](https://github.com/martinellich/vaadin-jooq-archetype):
  Spring Boot, Vaadin Flow, jOOQ, Flyway, PostgreSQL (Testcontainers), Playwright.
- `./mvnw compile` starts a PostgreSQL container, runs the Flyway migrations in `src/main/resources/db/migration`,
  and generates the jOOQ classes into `ch.martinelli.demo.courses.db`. Docker must be running.
- Run the application from the IDE with `TestApplication`.
- Users for development (see `src/test/resources/db/migration/afterMigrate.sql`): `user` / `user` (role USER),
  `admin` / `admin` (roles USER and ADMIN).
- `ArchitectureTest` enforces the layers (ui, domain) and the modules (core plus feature modules). Put the new feature
  into its own module package, for example `ch.martinelli.demo.courses.course`.
