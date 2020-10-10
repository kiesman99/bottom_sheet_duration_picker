#!/bin/sh
./coverage_helper.sh picky
flutter test --no-pub --coverage --test-randomize-ordering-seed random
rm ./test/coverage_helper_test.dart

# Starts server if argument is passed
if [ -n "$1" ]; then
    genhtml -o coverage coverage/lcov.info
    cd coverage && python3 -m http.server
fi