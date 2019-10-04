#!/usr/bin/env bash
. /usr/local/bin/wtrunner                           # load wtrunner

tr_h1 'Test 1 Example'
tr_comment 'A simple test of echo commands. Above is a tr_h1 command and this is a tr_comment.'

tr_onfailcontinue
tr_vverbose
tr_test 'An Echo Test'   'echo 1'           0 1 '1'     # tests that the output of echo is 1, with no errors
tr_verbose
tr_test 'An Echo Test 2' 'echo 1 2'         0 1 '1 2'   # tests that the output is 1 then 2, with no errors
tr_test_skip 'Skip this Test2' 'echo 1 2'   0 1 '1 2'   # skips with easy to add text
tr_test 'An Echo Test 2' 'echo 1 ; echo 2'  0 2 '1' '2' # tests that the output is 1 then 2, with no errors
tr_test 'Test Error'     'bash -c "exit 1"' 1 1 ""      # expects 0
tr_test "Query Test" \
  'echo 1' 0 1 '[ "${result}" != "0" ]'             # result is 1 which is not equal to 0
mkdir -p t
tr_comment 'Change directory, make a file and pop out'
tr_dir t
echo "1" > 1.txt
tr_protectfile "1.txt" diff:postcat
tr_popdir
tr_test "contents of file is 1" "cat t/1.txt" 0 1 "1"
tr_run  "set file to 2" "echo '2' > t/1.txt"
tr_test "contents of file is 2" "cat t/1.txt" 0 1 "2"
tr_comment 'Replaces the protected file manually (normally runs on exit) and does a cat and diff (set with tr_protectfile command)'
_tr_onfinish
tr_test "contents of file back to 1" "cat t/1.txt" 0 1 "1"
tr_results
