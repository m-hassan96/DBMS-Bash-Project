./scripts/listDB.sh

read -p " - Please Enter database name to connect it: " database

if [[ -d ./mydb/$database ]]; then
    #cd ./mydb/$database 2> /dev/null
    echo '-----------------------------------------'
    echo -e "\t  << Connected to  $database >>\t"
    . ./scripts/tablesOperation.sh $database
else
    echo -e "\n - no database with $database name"
    read -p " \n - Do you want to create it? [y/n]: " answer 
    case $answer in
    y)
       . ./scripts/createDB.sh $database 
        ;;
    n)
       . ./scripts/connectDB.sh $database 
        ;;
    *)
        echo " - Incorect answer, Redirecting to main menu.."
        sleep 2
       . ./startView.sh
        ;;
    esac
fi
