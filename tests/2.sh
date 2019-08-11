#!/usr/bin/env bash

. /usr/local/bin/wtrunner                           # load wtrunner

tr_vverbose

tr_h2 'Testing testrunnger'

{
  tr_section 'multiline'

  tr_test 'Compare multiline' \
    'echo 1 2 3' 0 1 "1 2 3"
  tr_test 'Compare multiline' \
    'echo 1 ; echo 2; echo 3' 0 3 "1" "2" "3"

  tr_section '/multiline'
}

{
  CURDIR=`pwd`
  tr_section 'Directories'
  tr_test_skip 'a placeholder'
  tr_test "curdir is ${CURDIR}" 'pwd' 0 1 "${CURDIR}"
  tr_dir subdir
  tr_test "curdir is ${CURDIR}/subdir" 'pwd' 0 1 "${CURDIR}/subdir"
  tr_popdir
  tr_test "curdir is ${CURDIR}" 'pwd' 0 1 "${CURDIR}"
  tr_results
  tr_reset_results
  tr_section '/Directories'
}
