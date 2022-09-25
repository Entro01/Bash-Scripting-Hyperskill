#!/usr/bin/env bash
echo "Welcome to the basic calculator!"
echo "Welcome to the basic calculator!" >> "operation_history.txt"

counter=1
while [ "$counter" -eq 1 ]; do
echo "Enter an arithmetic operation or type 'quit' to quit:"
echo "Enter an arithmetic operation or type 'quit' to quit:" >> "operation_history.txt"
reg='^-?[0-9]+\.?[0-9]* [-+*\/^] -?[0-9]+\.?[0-9]*$'
read input
echo "$input" >> "operation_history.txt"
if [[ "$input" =~ $reg ]]; then
    arithmetic_result=$(echo "scale=2; ($input)" | bc -l)
    printf "%s\n" "$arithmetic_result"
    echo "$arithmetic_result" >> "operation_history.txt"
elif [ "$input" = quit ]; then
    echo "Goodbye!"
    echo "Goodbye!" >> "operation_history.txt"
    counter=0
else
    echo "Operation check failed!"
    echo "Operation check failed!" >> "operation_history.txt"
fi
done
