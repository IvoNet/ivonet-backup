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

