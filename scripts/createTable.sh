PS3="- Please choose an option: "

var='@~#$%!^_&*()/?.\|'

#? Creating Table
function taple_name_constrain() {

    while true; do

        echo '-----------------------------------------'
        echo -e $' - Please enter table name to create it: \c'
        read table_name

        table_name=$(echo $table_name | tr ' ' '_') #^ to replace the space with _

        #? Validating Name
        if [[ -f ./mydb/$database/$table_name ]]; then
            echo '-----------------------------------------'
            echo -e "\t << table already exists $table! >> \t"
            echo '-----------------------------------------'

        elif [[ $table_name =~ ^[0-9]+$ ]]; then
            echo '-----------------------------------------'
            echo "<< Invalid input! name of table can not be numbers! >>"
            echo '-----------------------------------------'
        elif [[ $table_name =~ [$var] ]]; then
            echo '-----------------------------------------'
            echo "<< Invalid input! name of table can't contain Special chars! >>"
            echo '-----------------------------------------'

        elif [[ -z "$table_name" ]]; then
            echo '-----------------------------------------'
            echo "<< Invalid input! name of taple can't be empty >>"
            echo '-----------------------------------------'
        #? Create table
        else
            touch ./mydb/$database/$table_name
            echo '-----------------------------------------'
            echo " << Table created succesfully in >> $database <<  >>!"
            echo '-----------------------------------------'
            #./tablesOperation.sh $database
            create_column
        fi
    done
}

#? Creating column
function create_column() {

    #table_name="track"
    while true; do

        echo -e " - Please enter Number of fields: \c"
        read fields_num

        if [[ $fields_num =~ ^[0-9]+$ ]]; then

            # PK flag
            flag="true"

            for ((i = 1; i <= $fields_num; i++)); do

                while true; do

                    echo '-----------------------------------------'
                    echo -e " - Please enter name for field no.$i: \c"
                    read col_name

                    col_name=$(echo $col_name | tr ' ' '_') #^ to replace the space with _

                    #? Validating Name
                    if [[ $col_name =~ ^[0-9]$ ]]; then
                        echo '-----------------------------------------'
                        echo "<< Invalid input! name of column can start with numbers! >>"

                    elif [[ $col_name =~ [$var] ]]; then
                        echo '-----------------------------------------'
                        echo "<< Invalid input! name of column can't contain Special chars! >>"

                    elif [[ -z "$col_name" ]]; then
                        echo '-----------------------------------------'
                        echo "<< Invalid input! name of column can't be empty >>"

                    else
                        break
                    fi
                done

                #^ <------set PK------>
                while [ $flag == "true" ]; do
                    echo -e " - Is this a PK? [Y/N] \c"
                    read pk
                    if [[ $pk == "Y" || $pk == "y" || $pk == "yes" ]]; then
                        flag="false"
                        echo -n "(PK)" >>./mydb/$database/$table_name
                    else
                        break
                    fi
                done

                #^ <------set column data type------>
                while true; do
                    echo -e " - Choose data type from (int , string): \c"
                    read datatype

                    case $datatype in
                    int)
                        echo -n $col_name"($datatype);" >>./mydb/$database/$table_name
                        ;;
                    string)
                        echo -n $col_name"($datatype);" >>./mydb/$database/$table_name
                        ;;
                    *)
                        echo '-----------------------------------------'
                        echo " << Data type incorrect! >>"
                        echo '-----------------------------------------'
                        continue
                        ;;
                    esac
                    break
                done
            done

            echo $'\n' >>./mydb/$database/$table_name #end of table header

            echo '-----------------------------------------'
            echo " << Your table $table_name created >>"
            . ./scripts/tablesOperation.sh $database
        else
            echo '-----------------------------------------'
            echo " << $fields_num is not a valid input (numbers only) >>"
        fi

    done
}

taple_name_constrain
