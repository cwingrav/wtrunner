#!/usr/bin/env bash

. /usr/local/bin/wtrunner                           # load wtrunner

tr_vverbose

tr_h2 'Testing testrunnger'

{
  tr_section 'Arrays'

  tr_test 'Compare array' \
    'echo 1 2 3' 0 3 "1" "2" "3"
  tr_test 'Compare array and expect to fail' \
    'echo 1 2 3' 1 2 "1" "2" "3"

  tr_section '/Arrays'
}

{
  CURDIR=`pwd`
  tr_section 'Directories'
  tr_test_skip 'a placeholder'
  tr_test "curdir is ${CURDIR}" 'pwd' 0 1 "${CURDIR}"
  tr_dir test1
  tr_test "curdir is ${CURDIR}/test1" 'pwd' 0 1 "${CURDIR}/test1"
  tr_popdir
  tr_test "curdir is ${CURDIR}" 'pwd' 0 1 "${CURDIR}"
  tr_results
  tr_reset_results
  tr_section '/Directories'
}
