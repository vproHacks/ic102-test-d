# Diagnosis

One entry for each breakage. Fill in the prediction before you push, and the rest from the run's
log before you change anything. Copy the first error line from the log exactly, without its
timestamp; don't paraphrase it.

## Breakage 1

- Prediction: docs and gds go red, test stays green; docs finishes red first.
- Job that failed first: docs
- Step: Build docs, section "Check info.yaml and docs/info.md"
- First error line: - Project title cannot be empty
- Fix: Put the project title back in info.yaml.
- Fix commit: bf7a3fc

## Breakage 2

- Prediction: only docs goes red, because only the docs check reads docs/info.md.
- Job that failed first: docs
- Step: Build docs, section "Check info.yaml and docs/info.md"
- First error line: - Missing 'How it works' section in docs/info.md
- Fix: Put back the two sections I wrote in Lab 01 (docs/info.md from the commit before the breakage).
- Fix commit: 42c5311

## Breakage 3

- Prediction: test fails, because the testbench still names tt_um_example; gds should build.
- Job that failed first: test
- Step: Run tests
- First error line: /home/runner/work/ic102-test-d/ic102-test-d/test/tb.v:31: error: Unknown module type: tt_um_example
- Fix: Name the new module on line 31 of test/tb.v (keep the rename, which the template asks for).
- Fix commit: c81b926

## Breakage 4

- Prediction:
- Job that failed first:
- Step:
- First error line:
- Fix:
- Fix commit:

## Breakage 5

- Prediction:
- Job that failed first:
- Step:
- First error line:
- Fix:
- Fix commit:

## A value no workflow catches

- Value:
- Why every workflow passes with it:
