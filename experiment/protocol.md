# Protocol

## Variants

| Variant             | Prefix | Specification                                                       |
|---------------------|--------|---------------------------------------------------------------------|
| `user-stories`      | `us`   | User stories with the acceptance criteria a typical team writes     |
| `user-stories-full` | `usf`  | The same user stories with every rule of the use cases in the criteria |
| `use-cases`         | `uc`   | Use case specifications, no user stories                            |

`user-stories` to `user-stories-full` shows the value of the **information**. `user-stories-full` to `use-cases`
shows the value of the **format**, because both contain the same rules.

## Setup

- Same agent, same model, same settings for every run. Write them down in the results.
- Run each variant at least 3 times. LLM output is not deterministic, one run proves nothing.
- Every run starts in a fresh session with no memory of earlier runs.
- Run the agent without your own plugins, skills, memory, and global instructions. Skills such as `/use-case-implement`
  react to `UC-XXX` ids, so they would help only one variant. Use a clean configuration, sign in once, and check it:

  ```bash
  export CLAUDE_CONFIG_DIR=/tmp/claude-experiment
  claude plugin list    # must report that no plugins are installed
  ```

- Commit every change to the project folders before you start. The runs export them from `HEAD`.
- Complete the holdout rules in [oracle.md](oracle.md) before the first run.

## Run

1. Export the project folder, so the agent cannot see `experiment/`, the other variants, or local build output:

   ```bash
   mkdir /tmp/run-us-1
   git archive HEAD:user-stories | tar -x -C /tmp/run-us-1    # or: user-stories-full, use-cases
   cd /tmp/run-us-1
   git init && git add . && git commit -m "Start"
   ```

2. Start the agent in this folder, with `CLAUDE_CONFIG_DIR` set as above, and give it exactly this prompt:

   ```text
   Implement the application as described in CLAUDE.md.
   ```

3. Do not answer questions and do not help. When the agent stops before `./mvnw verify` passes, write
   `Continue.` and nothing else. Count how often you had to do that.

4. When the agent is done, commit the result.

## Evaluate

Copy [scoring.md](scoring.md) for each run and fill it in. The oracle check comes first and is blind: the scorer must
not know the variant.

1. **Blind the runs.** Somebody other than the scorer creates a blinded copy of every run and keeps the key file:

   ```bash
   experiment/blind.sh /tmp/run-us-1 /tmp/blind /tmp/blind-key.txt
   ```

   The copy has a random code as its name. It has no `docs/`, `CLAUDE.md`, `session-log.md`, or Git history, and the
   specification ids are replaced by `REF`. Comments can still give the variant away, so the scorer should test the
   behavior of the application and only look into the code when that is not possible.

2. **Oracle check.** For every rule in [oracle.md](oracle.md), run the scenario of the rule and mark it:
   - `✔` the behavior matches the oracle
   - `✘` the scenario can be run, and the behavior differs. A missing check is a `✘`: when the application accepts a
     capacity of 150, O-05 is `✘`
   - `–` the scenario cannot be run, because the function it needs does not exist

3. **Unblind.** Only now open the key file and fill in the variant.

4. **Recorded assumptions.** Count the entries in `docs/assumptions.md`.

5. **Classify every `✘` and `–`.** Use the table below to find out if the specification of the variant states the rule:
   - The specification states the rule: a **spec violation**. The agent had the rule and did not follow it.
   - The specification does not state the rule, and `docs/assumptions.md` mentions it: a **recorded assumption**.
   - The specification does not state the rule, and `docs/assumptions.md` does not mention it: a **silent assumption**.
     This is the number that matters most: it is the gap the agent filled without telling anyone.

   | Rule group        | `user-stories` | `user-stories-full` | `use-cases` |
   |-------------------|----------------|---------------------|-------------|
   | S                 | stated         | stated              | stated      |
   | U                 | not stated     | stated              | stated      |
   | H (holdout)       | not stated     | not stated          | not stated  |

6. **Extra behavior.** Note features the specification does not ask for (for example, sending emails, editing or
   deleting courses, a payment step).

## Metrics

| Metric                 | Meaning                                                                             |
|------------------------|-------------------------------------------------------------------------------------|
| Oracle match (S rules) | Share of `✔` among the rules in every specification                                 |
| Oracle match (U rules) | Share of `✔` among the rules in `user-stories-full` and `use-cases` only            |
| Oracle match (H rules) | Share of `✔` among the holdout rules, which no specification states                 |
| Spec violations        | Number of `✘` and `–` on rules the specification of the variant states              |
| Silent assumptions     | Number of `✘` and `–` on unstated rules that `docs/assumptions.md` does not mention |
| Silent rate            | Silent assumptions divided by all `✘` and `–` on unstated rules                     |
| Recorded assumptions   | Number of entries in `docs/assumptions.md`                                          |
| Extra behavior         | Number of features nobody asked for                                                 |
| Continue prompts       | How often the agent had to be told to continue                                      |

The variants have different numbers of unstated rules, so compare the silent rate, not the raw count. The holdout
rules are the only group that is unstated in all three variants, so they give the most direct comparison of how an
agent behaves in a gap.

## Threats to Validity

- **The use cases contain more information than the user stories.** `user-stories-full` controls this. It answers
  whether the format matters when the information is the same. It does not answer whether the use case template makes
  you find more rules, see the follow-up experiments.
- **The author wrote all specifications.** Ask somebody else to review the user stories, so they are not weaker than a
  good team would write them, and to check that `user-stories-full` and `use-cases` contain the same rules.
- **The oracle is the author's intent.** Rules marked `U` may be decided differently by a reasonable agent. That is
  why the silent assumptions count more than the raw score: recording a different decision is fine, hiding it is not.
- **The S rules and U rules come from the use cases.** Every one of them is in the use cases by construction. The
  holdout rules exist so that the use cases can also fail.
- **The agent may not ask questions.** A user story is a promise of a conversation, and this setup removes the
  conversation, see the follow-up experiments.

## Follow-up Experiments

- **Product owner.** Let the agent ask a simulated product owner who knows the oracle and answers only what is asked.
  Count the questions. This measures the trade-off between writing the rules down and asking for them later.
- **Elicitation.** Give two authors the same vision, the same product owner, and the same time. One writes user
  stories, the other use cases, and neither sees the oracle. Count the oracle rules each specification contains. This
  tests the claim that the template makes you ask the questions a user story leaves open.
