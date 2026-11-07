# Scoring: Run <blind code>

| Field           | Value |
|-----------------|-------|
| Blind code      |       |
| Variant         | user-stories / user-stories-full / use-cases (fill in after the oracle check) |
| Run             |       |
| Date            |       |
| Agent and model |       |
| Duration        |       |
| Continue prompts |      |
| `./mvnw verify` passes | yes / no |

## Oracle

Mark `✔` (matches), `✘` (the scenario can be run, and the behavior differs), or `–` (the function does not exist).
Fill in **Result** blind. After unblinding, classify every `✘` and `–` in **Classification**: `violation`, the
assumption id from `docs/assumptions.md`, or `silent`. See [protocol.md](protocol.md).

| ID   | In | Result | Classification | Note |
|------|----|--------|----------------|------|
| O-01 | S  |        |                |      |
| O-02 | S  |        |                |      |
| O-03 | S  |        |                |      |
| O-04 | S  |        |                |      |
| O-05 | U  |        |                |      |
| O-06 | U  |        |                |      |
| O-07 | U  |        |                |      |
| O-08 | U  |        |                |      |
| O-09 | U  |        |                |      |
| O-10 | U  |        |                |      |
| O-11 | U  |        |                |      |
| O-12 | U  |        |                |      |
| O-13 | S  |        |                |      |
| O-14 | S  |        |                |      |
| O-15 | S  |        |                |      |
| O-16 | S  |        |                |      |
| O-17 | S  |        |                |      |
| O-18 | S  |        |                |      |
| O-19 | U  |        |                |      |
| O-20 | S  |        |                |      |
| O-21 | U  |        |                |      |
| O-22 | U  |        |                |      |
| O-23 | U  |        |                |      |
| O-24 | U  |        |                |      |
| O-25 | U  |        |                |      |
| O-26 | U  |        |                |      |
| O-27 | U  |        |                |      |
| O-28 | S  |        |                |      |
| O-29 | S  |        |                |      |
| O-30 | S  |        |                |      |
| O-31 | S  |        |                |      |
| O-32 | U  |        |                |      |
| O-33 | U  |        |                |      |
| O-34 | U  |        |                |      |
| O-35 | U  |        |                |      |
| O-36 | U  |        |                |      |
| O-37 | U  |        |                |      |
| O-38 | U  |        |                |      |
| O-39 | U  |        |                |      |
| O-40 | S  |        |                |      |
| O-41 | U  |        |                |      |
| O-42 | U  |        |                |      |
| O-43 | U  |        |                |      |
| O-44 | U  |        |                |      |
| O-45 | S  |        |                |      |

Add one row with `H` in column **In** for each holdout rule in [oracle.md](oracle.md).

## Summary

| Metric                         | Value |
|--------------------------------|-------|
| Oracle match, S rules (of 17)  |       |
| Oracle match, U rules (of 28)  |       |
| Oracle match, H rules          |       |
| Spec violations                |       |
| Silent assumptions             |       |
| Silent rate                    |       |
| Recorded assumptions           |       |
| Extra behavior                 |       |

## Extra Behavior

-
