#!/bin/bash

print_params() {
    param_value=$1
    param_name=$2
    echo "$param_name: $param_value"
}

check_philo() {
    if [ ! -x "./philo" ]; then
        make -C philo re
    fi
}

process_with_4_args() {
    num1=$1
    num2=$2
    num3=$3
    num4=$4

    check_philo
    echo "---------------------------"
    print_params $num1 "number_of_philosophers"
    print_params $num2 "time_to_die"
    print_params $num3 "time_to_eat"
    print_params $num4 "time_to_sleep"
    echo "---------------------------"
    ./philo $num1 $num2 $num3 $num4 > result &

    program_pid=$!
    start_time=$(date +%s)
    SECONDS=0
    while [ $SECONDS -lt 10 ]; do
        if ! ps -p $program_pid > /dev/null; then
            end_time=$(date +%s)
            elapsed_time=$(($end_time - $start_time))
            echo -e "\033[0;31m[philo die]\033[0m"
            exit 0
        fi
        sleep 1
    done

    # 10秒以上経過してもプログラムが終了しない場合は、強制終了
    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    echo -e "\033[0;32m[philo not die]\033[0m"
    echo "プログラムは10秒以上実行されました。強制終了します（ 経過時間: $elapsed_time s）"
    kill -9 $program_pid
    kill -9 $program_pid
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
    echo "---------------------------"
    print_params $num1 "number_of_philosophers"
    print_params $num2 "time_to_die"
    print_params $num3 "time_to_eat"
    print_params $num4 "time_to_sleep"
    print_params $num5 "number_of_times_each_philosopher_must_eat"
    echo "---------------------------"
    ./philo $num1 $num2 $num3 $num4 $num5 > result

    eating_count=$(cat result | grep 'is eating' | wc -l  | tr -d ' ')
    expected_count=$(($num1 * $num5))
    if [ $eating_count -ge $expected_count ]; then
        echo -e "\033[0;32m[Success]\033[0m"
        echo -e "Eating count is greater than or equal to expected:"
        echo -e "Result: $eating_count (Expected: $expected_count)"
    else
        echo -e "\033[0;31m[Fail]\033[0m"
        echo -e "Eating count is less than expected:"
        echo -e "$eating_count (Expected: $expected_count)"
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
