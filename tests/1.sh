#!/usr/bin/env bash

. /usr/local/bin/wtrunner                           # load wtrunner

tr_vverbose
tr_test 'An Echo Test'   'echo 1' 0 1 '1'           # tests that the output of echo is 1, with no errors
tr_test 'An Echo Test 2' 'echo 1 2' 0 2 '1' '2'     # tests that the output is 1 then 2, with no errors
tr_test 'Test Error'     'bash -c "exit 1"' 1 1 ""  # expects 0
