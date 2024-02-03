
echo -e $' - Please Enter database name to connect it: \c'
read database

if [[ -d ./mydb/$database ]]
then 
        #cd ./mydb/$database 2> /dev/null
        echo '-----------------------------------------'
        echo -e "\t  << Connected to  $database >>\t"
     . ./scripts/tablesOperation.sh $database
else 
    echo -e "\n - no database with $database name"
    echo  -e $'\n - Do you want to create it? [y/n]\c'
    read answer
    case $answer in
        y)
        ./scripts/createDB.sh;;
        n)
        ./scripts/connectDB.sh;;
        *)
        echo " - Incorect answer, Redirecting to main menu.." ;
        sleep 2
        ./startView.sh;;	
    esac
fi	