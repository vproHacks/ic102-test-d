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

- Prediction: test fails, and later gl_test, because the test still expects the sum.
- Job that failed first: test
- Step: Run tests
- First error line: AssertionError: assert LogicArray('11110110', Range(7, 'downto', 0)) == 50
- Fix: The design is meant to subtract now, so the test expects 246 for 20 - 30, and checks 30 - 20 = 10 as well.
- Fix commit: 9126c83

## Breakage 5

- Prediction: docs and gds go red as in breakage 1, because 50MHz isn't a number.
- Job that failed first: docs (gds finished red in the same second)
- Step: Build docs, section "Check info.yaml and docs/info.md"
- First error line: - Invalid value for 'clock_hz' in 'project' section, must be an integer
- Fix: clock_hz: 50000000, a whole number of hertz.
- Fix commit:

## A value no workflow catches

- Value: clock_hz: 50
- Why every workflow passes with it: 50 is an integer, so the validator accepts it, and nothing checks it against the clock the design was meant to run at; it says 50 Hz where the commit meant 50 MHz.
