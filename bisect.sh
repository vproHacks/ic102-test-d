#!/bin/bash
# bisect.sh: tell `git bisect run` whether the commit it has checked out is good or bad.
# git bisect run runs this script from the top of the repository at every commit it tests, and
# reads only its exit status:
#
#   exit 0     the test ran and passed       (good)
#   exit 1     the test ran and failed       (bad)
#   exit 125   the test couldn't run at all  (skip: neither good nor bad)
#
# Copy this file to the top of your ttsky-ic102-d-bisect clone as bisect.sh and fill in Part 2's TODO.

# The test job's tools, installed in Lab 01 (labs/common/tt-tools).
TT=/foss/designs/modules/ic102-d/labs/common/tt-tools

# run-test.sh runs `make clean`, `make` and check_results in test/, as the test job does. Its
# output goes to a log per commit, so you can read what happened at any commit afterwards.
rm -f test/results.xml
"$TT/run-test.sh" . > /tmp/bisect-$(git rev-parse --short HEAD).log 2>&1

# TODO (Part 2): exit 0, 1 or 125, decided from test/results.xml.
if [ ! -f test/results.xml ]; then
    exit 125
fi
if grep -q "<failure" test/results.xml; then
    exit 1
fi
exit 0
