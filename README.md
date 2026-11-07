# User Stories vs. Use Cases

**Claim:** User stories are not enough as input for an AI coding agent. The agent fills the gaps with assumptions
that nobody asked for. Use cases close these gaps before the code is written.

This repository makes the claim testable. It contains the same application three times:

| Folder                                     | Functional specification                                   |
|--------------------------------------------|------------------------------------------------------------|
| [`user-stories/`](user-stories)            | User stories with the acceptance criteria a team typically writes |
| [`user-stories-full/`](user-stories-full)  | The same user stories with every rule of the use cases     |
| [`use-cases/`](use-cases)                  | Use case specifications, no user stories                   |

`user-stories` and `user-stories-full` differ in the information, `user-stories-full` and `use-cases` only in the
format.

Everything else is identical: the vision, the non-functional requirements, the constraints, the glossary, the code
skeleton, the build, the `CLAUDE.md` with the instructions for the agent.

```bash
diff -rq user-stories use-cases -x target -x node_modules -x generated
# Files user-stories/docs/requirements.md and use-cases/docs/requirements.md differ
# Only in use-cases/docs: use_cases
# Only in use-cases/docs: use_cases.puml
# Files user-stories/pom.xml and use-cases/pom.xml differ
```

The `pom.xml` files differ only in the artifact id.

## The Application

A course registration: course administrators create courses, participants register for them, join a waiting list
when a course is full, cancel their registrations (with a cancellation fee), and see their registrations.

The skeleton is generated from the [vaadin-jooq-archetype](https://github.com/martinellich/vaadin-jooq-archetype):
Spring Boot, Vaadin Flow, jOOQ, Flyway, PostgreSQL, Testcontainers, Playwright. It contains only login, user
management, and a hello world view. The agent builds the rest.

## The Experiment

1. Export one project folder from this repository and let an AI coding agent implement it with the same prompt,
   without your own plugins and skills.
2. Compare the blinded result with the [oracle](experiment/oracle.md): the 45 rules the product owner has in mind,
   plus the holdout rules that no specification states.
3. Count the **silent assumptions**: behavior on a rule the specification does not state that differs from the oracle
   and that the agent did not record in `docs/assumptions.md`.

The details are in [experiment/protocol.md](experiment/protocol.md), the form for each run is
[experiment/scoring.md](experiment/scoring.md).

Of the 45 rules in the oracle, 17 are in every specification. 28 are only in `user-stories-full` and `use-cases`:
boundaries, alternative flows, and rules that come up when you ask "what happens if ...?".

## Results

| Run | Variant | Oracle S (of 17) | Oracle U (of 28) | Oracle H | Spec violations | Silent assumptions | Silent rate | Recorded assumptions |
|-----|---------|------------------|------------------|----------|-----------------|--------------------|-------------|----------------------|
|     |         |                  |                  |          |                 |                    |             |                      |

## Background

- [AI Unified Process](https://unifiedprocess.ai)
- Ron Jeffries, [Essential XP: Card, Conversation, Confirmation](https://ronjeffries.com/xprog/articles/expcardconversationconfirmation/)
- Alistair Cockburn, *Writing Effective Use Cases*, Addison-Wesley, 2000
