#!usr/bin/env bash

control=1
file_name="definitions.txt"


echo "Welcome to the Simple converter!"

while [ "$control" -eq 1 ]
do
num="$(wc -l < $file_name)"
control2=1
echo "Select an option"
echo "0. Type '0' or 'quit' to end program"
echo "1. Convert units"
echo "2. Add a definition"
echo "3. Delete a definition"

read input

case $input in
    0 | "quit")
        echo "Goodbye!"
        break;;
    1)
        if [ "$num" -ne 0 ]; then
            LINES=$(cat $file_name)
            itr=1
            ctr=1
            echo "Type the line number to convert units or '0' to return"
            for LINE in $LINES
            do
                if [ "$ctr" -eq 1 ]; then
                    echo -n "$itr. $LINE"
                    ctr="$((ctr-1))"
                else
                    echo " $LINE"
                    itr="$((itr+1))"
                    ctr="$((ctr+1))"
                fi
            done
            control4=1
            while [ "$control4" -eq 1 ]; do
            read line_number
            declare -a entry
            entry[0]=$line_number
            if [ "$line_number" -le "$num" ] && [ "$line_number" -ge 1 ]; then
                  itr2=0
                  for LINE in $LINES
                  do
                     const=$LINE
                     itr2="$((itr2+1))"
                     loc="$((line_number*2))"
                     if [ "$itr2" -eq "$loc" ]; then
                        break
                     else
                        continue
                     fi
                  done


                  echo "Enter a value to convert:"
                  reg2='^[0-9]+\.?[0-9]*$'
                  control5=1
                  while [ "$control5" -eq 1 ]
                  do
                     read -a input2
                     va2="${input2[0]}"
                     if [ "${#input2[@]}" -eq 1 ]; then
                        if [[ "$va2" =~ $reg2 ]]; then
                           value="$va2"
                           result=$(echo "scale=2; $const * $value" | bc -l)
                           printf "Result: %s\n" "$result"
                           control5=0
                        else
                           echo "Enter a float or integer value!"
                        fi
                     else
                        echo "Enter a float or integer value!"
                     fi
                  done
                  control4=0
            elif [ "${#entry[@]}" -eq 0 ]; then
               echo "Enter a valid line number!"
            elif [ "$line_number" -eq 0 ]; then
               control4=0
            else
               echo "Enter a valid line number!"
            fi
            done
        else
            echo "Please add a definition first!"
        fi;;

    2)
        while [ "$control2" -eq 1 ]; do
        echo "Enter a definition:"
        read -a input
        if [ "${#input[@]}" -ne 2 ]; then
            echo "The definition is incorrect!"
        else
        reg='^[a-zA-Z]+_to_[a-zA-Z]+ -?[0-9]+\.?[0-9]*$'
        va="${input[0]} ${input[1]}"
            if [[ "$va" =~ $reg ]]; then
               echo "$va" >> "$file_name"
               control2=0
            else
            echo "The definition is incorrect!"
            fi
        fi
        done;;
    3)
        if [ "$num" -ne 0 ]; then
            echo "Type the line number to delete or '0' to return"
            LINES=$(cat $file_name)
            itr=1
            ctr=1
            for LINE in $LINES
            do
                if [ "$ctr" -eq 1 ]; then
                    echo -n "$itr. $LINE"
                    ctr="$((ctr-1))"
                else
                    echo " $LINE"
                    itr="$((itr+1))"
                    ctr="$((ctr+1))"
                fi
            done
            control3=1
            while [ "$control3" -eq 1 ]; do
            read line_number
            declare -a entry
            entry[0]=$line_number
            if [ "$line_number" -le "$num" ] && [ "$line_number" -ge 1 ]; then
               sed -i "${line_number}d" "$file_name"
               control3=0
            elif [ "${#entry[@]}" -eq 0 ]; then
               echo "Enter a valid line number!"
            elif [ "$line_number" -eq 0 ]; then
               control3=0
            else
               echo "Enter a valid line number!"
            fi
            done
        else
            echo "Please add a definition first!"
            control3=0
        fi;;
    *)
        echo "Invalid option!";;
esac

done
