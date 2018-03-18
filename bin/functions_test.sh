#!/usr/bin/env bash

# Test from correct context location
cd ..

# import functions
. ./bin/functions.sh


test() { # $1 test; $2 is expectation
     if [ "$1" == "$2" ]; then
         echo "Success"
     else
         echo "Fail: $1 != $2"
     fi
}
# test pre slash
test "$(pre_slash "/foo/bar/baz")" "/foo/bar/baz"
test "$(pre_slash "foo/bar/baz")" "/foo/bar/baz"
test "$(pre_slash "foo/ /baz")" "/foo/ /baz"
test "$(pre_slash foo/\ /baz)" "/foo/ /baz"


# test end_slash
#set -x
test "$(end_slash "/foo/bar/baz/")" "/foo/bar/baz/"
test "$(end_slash "/foo/bar/baz")" "/foo/bar/baz/"
test "$(end_slash "foo/ /baz")" "foo/ /baz/"
test "$(end_slash foo/\ /baz)" "foo/ /baz/"

# Test combi of pre and end slash

test "$(end_slash "$(pre_slash "foo")")" "/foo/"