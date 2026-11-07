# Protocol

## Setup

- Same agent, same model, same settings for every run. Write them down in the results.
- Run each variant at least 3 times. LLM output is not deterministic, one run proves nothing.
- Every run starts in a fresh session with no memory of earlier runs.

## Run

1. Copy the project folder out of this repository, so the agent cannot see `experiment/` or the other variant:

   ```bash
   cp -r user-stories /tmp/run-us-1    # or: cp -r use-cases /tmp/run-uc-1
   cd /tmp/run-us-1
   git init && git add . && git commit -m "Start"
   ```

2. Start the agent in this folder and give it exactly this prompt:

   ```text
   Implement the application as described in CLAUDE.md.
   ```

3. Do not answer questions and do not help. When the agent stops before `./mvnw verify` passes, write
   `Continue.` and nothing else. Count how often you had to do that.

4. When the agent is done, commit the result.

## Evaluate

Copy [scoring.md](scoring.md) for each run and fill it in.

1. **Oracle check.** For every rule in [oracle.md](oracle.md), check the running application (or the code and the
   tests) and mark it:
   - `✔` the behavior matches the oracle
   - `✘` the agent implemented a different behavior
   - `–` the behavior is missing
2. **Recorded assumptions.** Count the entries in `docs/assumptions.md`.
3. **Silent assumptions.** For every `✘`, check whether `docs/assumptions.md` mentions it. A wrong behavior that is
   not recorded is a silent assumption. This is the number that matters most: it is the gap the agent filled
   without telling anyone.
4. **Extra behavior.** Note features the specification does not ask for (for example, sending emails, editing or
   deleting courses, a payment step).

## Metrics

| Metric                  | Meaning                                                                  |
|-------------------------|--------------------------------------------------------------------------|
| Oracle match (S rules)  | Share of `✔` among the rules written in both specifications              |
| Oracle match (U rules)  | Share of `✔` among the rules written only in the use cases               |
| Silent assumptions      | Number of `✘` that are not recorded in `docs/assumptions.md`             |
| Recorded assumptions    | Number of entries in `docs/assumptions.md`                               |
| Extra behavior          | Number of features nobody asked for                                      |
| Continue prompts        | How often the agent had to be told to continue                           |

## Threats to Validity

- **The use cases contain more information.** That is the point of the claim: the use case template (alternative
  flows, postconditions, business rules) makes you ask the questions a user story leaves open. The experiment
  measures the result of writing use cases, not a magic effect of the format. To separate the two, add a third
  variant: user stories whose acceptance criteria contain every rule of the oracle.
- **The author wrote both specifications.** Ask somebody else to review the user stories, so they are not weaker
  than a good team would write them.
- **The oracle is the author's intent.** Rules marked `U` may be decided differently by a reasonable agent. That is
  why the silent assumptions count more than the raw score: recording a different decision is fine, hiding it is not.
