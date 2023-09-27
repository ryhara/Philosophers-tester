#!/bin/bash

print_params() {
    param_value=$1
    param_name=$2
    echo "$param_name: $param_value"
}

check_philo() {
    if [ ! -x "../philo/philo" ]; then
        make -C ../philo re
    fi
}

process_with_4_args() {
    num1=$1
    num2=$2
    num3=$3
    num4=$4

    check_philo
    echo -e "\033[0;34mRunning test case: $num1 $num2 $num3 $num4 \033[0m"
    ../philo/philo $num1 $num2 $num3 $num4 > result &

    program_pid=$!
    start_time=$(date +%s)
    SECONDS=0
    while [ $SECONDS -lt 5 ]; do
        if ! ps -p $program_pid > /dev/null; then
            end_time=$(date +%s)
            elapsed_time=$(($end_time - $start_time))
            echo -e "\033[0;31m[philo die]\033[0m"
            exit 0
        fi
        sleep 1
    done

    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    echo -e "\033[0;32m[philo not die]\033[0m"
    echo "The program ran for 5 seconds. Force exit.（time: $elapsed_time s）"
    kill -9 $program_pid > /dev/null
    grep died result > result2
    grep -o "[0-9]* [0-9]*" result2 > result3
    id=$(cat result3 | awk '{print $2}')
    cat result | grep " $id "

    rm result result2 result3
}

process_with_5_args() {
    num1=$1
    num2=$2
    num3=$3
    num4=$4
    num5=$5

    check_philo
    echo -e "\033[0;34mRunning test case: $num1 $num2 $num3 $num4 $num5\033[0m"
    ../philo/philo $num1 $num2 $num3 $num4 $num5 > result

    eating_count=$(cat result | grep 'is eating' | wc -l  | tr -d ' ')
    expected_count=$(($num1 * $num5))
    if [ $eating_count -ge $expected_count ]; then
        echo -e "\033[0;32m[Success]\033[0m"
        echo -e "\033[0;32mEating count is greater than or equal to expected:\033[0m"
        echo -e "\033[0;32mResult: $eating_count (Expected: $expected_count)\033[0m"
    else
        echo -e "\033[0;31m[Fail]\033[0m"
        echo -e "\033[0;31mEating count is less than expected:\033[0m"
        echo -e "\033[0;31mResult: $eating_count (Expected: $expected_count)\033[0m"
        cat result | grep 'is eating' > log
    fi

    rm result
}

if [ $# -eq 4 ]; then
    process_with_4_args $@
elif [ $# -eq 5 ]; then
    process_with_5_args $@
else
    echo "Usage: $0 number_of_philosophers time_to_die time_to_eat time_to_sleep [number_of_times_each_philosopher_must_eat]"
    exit 1
fi
