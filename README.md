

# wtrunner - a bash testing framework

> A bash script for running bash unit tests.

## Install

`make install`

## Usage

- In your test script, source the wtrunner script: `. /usr/local/bin/wtrunner`

- write the test cases (see below)

- Run the script

## Example

A test script (tests/1.sh):
```
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
```

Results in the output:

```

*********************************************************************
Test 1 Example
*********************************************************************
*********************************************************************
COMMENT: 'A simple test of echo commands. Above is a tr_h1 command and this is a tr_comment.

OUTPUT : VERYVERBOSE

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'An Echo Test' (./1.sh:line 11)
  CMD    : 'echo 1'
  RETVAL : expected(0} returned(0)
  EXPECT : (0) 1
  STDOUT2: '1
  ✓ PASSED

OUTPUT : VERBOSE

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'An Echo Test 2' (./1.sh:line 13)
  ✓ PASSED

SKIP T : ⚠ 'Skip this Test2' (./1.sh:line 14)

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'An Echo Test 2' (./1.sh:line 15)
  ✓ PASSED

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'Test Error' (./1.sh:line 16)
  ✓ PASSED

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'Query Test' (./1.sh:line 17)
  ✓ PASSED
COMMENT: 'Change directory, make a file and pop out

DIR    : 'cd t'
PROTECT: '1.txt' : /Users/cwingrav/code/wtrunner/tests/t/1.txt : diff:postcat

POPDIR : 'to /Users/cwingrav/code/wtrunner/tests'

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'contents of file is 1' (./1.sh:line 26)
  ✓ PASSED

RUN    : 'set file to 2' (./1.sh:line 27)
  CMD    : 'echo '2' > t/1.txt'

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'contents of file is 2' (./1.sh:line 28)
  ✓ PASSED
COMMENT: 'Replaces the protected file manually (normally runs on exit) and does a cat and diff (set with tr_protectfile
             'command)
RESTORE: '1.txt' : /Users/cwingrav/code/wtrunner/tests/t/1.txt : diff:postcat
  ...diffing file: 1.txt
1c1
< 1
---
> 2
  ...postcat file: 1.txt
2

--------------------------------------------------------------------------------------------------------------------------------------------
TEST   : 'contents of file back to 1' (./1.sh:line 33)
  ✓ PASSED

RESULTS
--------------------------------------------------------------------------------------------------------------------------------------------
  × 0 Failed   (0 checks)
  ✓ 8 Passed   (9 checks)
  ⚠ 1 Skipped
  ⚠ 0 Todo
    9 Total    (9 checks)
```



## Docs

### Config Options

- **tr_onfailexit** - if a test case fails, exit. (DEFAULT)
- **tr_onfailcontinue** - if a test case fails, continue on until end.
- **tr_tests_off/on** - starts/stops skipping tests (on is DEFAULT).
- **tr_vverbose/tr_verbose/tr_quiet** - the logging/output level (verbose is DEFAULT)
- **tr_runfile** - sources another test file. Uses the relative directory to this file.
- **tr_dir X** - change the current directory for your test cases. Can be full or relative path.
- **tr_popdir** - undoes the last directory change from *tr_dir*
- **tr_protectfile** - moves the file out of the way and restores it after the test. Options to delete before run or diff after.

### Logging / Documentation

- **tr_section X** - hierarchical sections in tests can related common tests. they are logged and displayed in headings. To end a section X, do tr_section '/X' or just '/'.
- **tr_comment X** - prints a comment to STDOUT.
- **tr_h1/h2/h3/h4/h5 X** - prints a header section with X title with section information if you have sections.

### Test Commands

#### tr_results / tr_reset_results

Displays the results of the tests that have been run. The *tr_reset_results* clears the results.

#### tr_test_skip

Skips this test. Useful for turning off *tr_test* without deleting it. Shows up as skipped.

#### tr_test

Then make your tests: `tr_test TITLE COMMAND EXITVAL N EXPECTED1 EXPECTED2 ... EXPECTEDN`

- **TITLE** - a nice readable title for your test

- **COMMAND** - a quoted command to run

- **EXITVAL** - the expected exit value of the COMMAND from above

- **N** - the number of outputs

- **EXPECTEDX** - output number X to compare against the COMMANDs' output
  - These can also be tests themselves like: `[ ${result} -eq 1]`
```
```

