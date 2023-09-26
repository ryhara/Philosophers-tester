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

test_die=(
    "5 800 200 200"
    "5 600 150 150"
    "4 410 200 200"
    "100 800 200 200"
    "105 800 200 200"
    "200 800 200 200"
)

test_not_die=(
    "1 800 200 200"
    "4 310 200 100"
    "4 200 205 200"
)

test_stop=(
    "5 800 200 200 7"
    "4 410 200 200 10"
)

echo "---------------- die -------------------"
for ((i=0; i<${#test_die[@]}; i+=1)); do
    args=${test_die[$i]}
    run_test_case "$args"
done

echo "-------------- not die -----------------"
for ((i=0; i<${#test_not_die[@]}; i+=1)); do
    args=${test_not_die[$i]}
    run_test_case "$args"
done

echo "--------------- stop -------------------"
for ((i=0; i<${#test_stop[@]}; i+=1)); do
    args=${test_stop[$i]}
    run_test_case "$args"
done
