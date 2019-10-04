

# wtrunner - a bash testing framework

> A bash script for running bash unit tests.

## Install

`make install`

## Usage

- In your test script, source the wtrunner script: `. /usr/local/bin/wtrunner`

- write the test cases (see below)

- Run the script

## Example

A test script:
```
#!/usr/bin/env bash

. /usr/local/bin/wtrunner                           # load wtrunner
tr_vverbose
tr_test 'An Echo Test'   'echo 1' 0 1 '1'           # tests that the output of echo is 1, with no errors
tr_test 'An Echo Test 2' 'echo 1 2' 0 2 '1' '2'     # tests that the output is 1 then 2, with no errors
tr_test 'Test Error'     'bash -c "exit 1"' 1 1 ""  # expects 0
tr_test "Query Test" \ 
  'echo 1' 0 1 '[ "${result}" != "0" ]'             # result is 1 which is not equal to 0
```

Results in the output:

```
TEST   : 'An Echo Test' (line 6)
  CMD    : 'echo 1'
  EXPECT : 1
  OUTPUT : '1
  PASSED

TEST   : 'An Echo Test 2' (line 7)
  CMD    : 'echo 1 2'
  EXPECT : 1
  EXPECT : 2
  OUTPUT : '1 2
  PASSED

TEST   : 'Test Error' (line 8)
  CMD    : 'bash -c "exit 1"'
  EXPECT :
  OUTPUT : '
  PASSED
  
TEST   : 'Query Test' (line 9)
  CMD    : 'echo 1'
  EXPECT : [ "${result}" != "0" ]
  OUTPUT : '1
  PASSED
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

