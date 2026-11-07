# User Stories vs. Use Cases

**Claim:** User stories are not enough as input for an AI coding agent. The agent fills the gaps with assumptions
that nobody asked for. Use cases close these gaps before the code is written.

This repository makes the claim testable. It contains the same application twice:

| Folder                           | Specification                                                         |
|----------------------------------|-----------------------------------------------------------------------|
| [`user-stories/`](user-stories)  | User stories with acceptance criteria, glossary                       |
| [`use-cases/`](use-cases)        | The same user stories, acceptance criteria, and glossary, **plus** use case specifications |

Everything else is identical: the code skeleton, the build, the `CLAUDE.md` with the instructions for the agent.

```bash
diff -r user-stories use-cases
# Only in use-cases/docs: use_cases
# Only in use-cases/docs: use_cases.puml
```

## The Application

A course registration: course administrators create courses, participants register for them, join a waiting list
when a course is full, cancel their registrations (with a cancellation fee), and see their registrations.

The skeleton is generated from the [vaadin-jooq-archetype](https://github.com/martinellich/vaadin-jooq-archetype):
Spring Boot, Vaadin Flow, jOOQ, Flyway, PostgreSQL, Testcontainers, Playwright. It contains only login, user
management, and a hello world view. The agent builds the rest.

## The Experiment

1. Copy one project folder out of this repository and let an AI coding agent implement it with the same prompt.
2. Compare the result with the [oracle](experiment/oracle.md): the 45 rules the product owner has in mind.
3. Count the **silent assumptions**: behavior that differs from the oracle and that the agent did not record in
   `docs/assumptions.md`.

The details are in [experiment/protocol.md](experiment/protocol.md), the form for each run is
[experiment/scoring.md](experiment/scoring.md).

Of the 45 rules in the oracle, 14 are in the user stories and acceptance criteria. 31 are only in the use cases:
boundaries, alternative flows, and rules that come up when you ask "what happens if ...?".

## Results

| Run | Variant | Oracle S (of 14) | Oracle U (of 31) | Silent assumptions | Recorded assumptions |
|-----|---------|------------------|------------------|--------------------|----------------------|
|     |         |                  |                  |                    |                      |

## Background

- [AI Unified Process](https://unifiedprocess.ai)
- Ron Jeffries, [Essential XP: Card, Conversation, Confirmation](https://ronjeffries.com/xprog/articles/expcardconversationconfirmation/)
- Alistair Cockburn, *Writing Effective Use Cases*, Addison-Wesley, 2000
