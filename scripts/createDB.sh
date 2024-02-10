var='@~#$%!^_&*()/?.\|'

while true; do

    echo "-----------------------------"
    read -p " - Enter the name of the DB: " database 

    database=$(echo $database | tr ' ' '_') #^ to replace the space with _

    #? Validating Name
    if [[ -d ./mydb/$database ]]; then
        echo '-----------------------------------------'
        echo " << The $database is already exist >> "
        echo '-----------------------------------------'
    elif [[ $database =~ ^[0-9]+$ ]]; then
        echo '-----------------------------------------'
        echo "<< Invalid input! name of table can not be numbers! >>"
        echo '-----------------------------------------'
    elif [[ $database =~ [$var] ]]; then
        echo '-----------------------------------------'
        echo "<< Invalid input! name of table can't contain Special chars! >>"
        echo '-----------------------------------------'

    elif [[ -z "$database" ]]; then 
        echo '-----------------------------------------'
        echo "<< Invalid input! name of taple can't be empty >>"
        echo '-----------------------------------------'
    #? Create table
    else
        mkdir ./mydb/$database
        echo '-----------------------------------------'
        echo " << Your Database >> $database  <<  created succesfully  ... Done >> "
        . ./startView.sh
    fi
done
