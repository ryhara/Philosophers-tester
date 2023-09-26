#!/bin/bash

# test case

# no one shoud die
# 5 800 200 200
# 5 600 150 150
# 4 410 200 200
# 100 800 200 200
# 105 800 200 200
# 200 800 200 200

# die
# 1 800 200 200
# 4 310 200 100
# 4 200 205 200

# stop
# 5 800 200 200 7
# 4 410 200 200 10

# error
# -5 600 200 200
# 4 -5 200 200
# 4 600 -5 200
# 4 600 200 -5
# 4 600 200 200 -5

run_test_case() {
    args=$1

    echo -e "\033[0;34mRunning test case: $args\033[0m"
    ./test.sh $args
    echo "----------------------------------------"
}

run_test_category() {
    category_name=$1
    test_cases=("${@:2}")

    echo "-------------- $category_name -----------------"
    for args in "${test_cases[@]}"; do
        run_test_case "$args"
    done
}

test_die=(
    "1 800 200 200"
    "4 310 200 100"
    "4 200 205 200"
)

test_not_die=(
    "5 800 200 200"
    "5 600 150 150"
    "4 410 200 200"
    "100 800 200 200"
    "105 800 200 200"
    "200 800 200 200"
)

test_stop=(
    "5 800 200 200 7"
    "4 410 200 200 10"
)

if [ $# -eq 0 ]; then
    echo "Running all test cases"

    run_test_category "die" "${test_die[@]}"
    run_test_category "not die" "${test_not_die[@]}"
    run_test_category "stop" "${test_stop[@]}"
else
    case $1 in
        d)
            run_test_category "die" "${test_die[@]}"
            ;;
        n)
            run_test_category "not die" "${test_not_die[@]}"
            ;;
        s)
            run_test_category "stop" "${test_stop[@]}"
            ;;
        *)
            echo "Invalid argument. Use 'd' for die, 'n' for not die, 's' for stop."
            ;;
    esac
fi
