PS3="> $1 < choose an option >> "
#PS3=" - Please choose an option: "
echo '-----------------------------------------'

echo -e " - What you want to do in $1:- \n"

select action in 'Create Table' 'List Tables' 'Drop Table' 'Insert into Table' 'Select From Table' 'Delete From Table' 'Update Table' 'Main Menu' 'Exit'; do
	case $action in
	'Create Table')
		. ./scripts/createTable.sh $1
		;;
	'List Tables')
		. ./scripts/listTable.sh $1
		;;
	'Drop Table')
		. ./scripts/dropTable.sh $1
		;;
	'Insert into Table')
		. ./scripts/insertRecord.sh $1
		;;
	'Select From Table')
		. ./scripts/selectRecord.sh $1
		;;
	'Delete From Table')
		. ./scripts/deleteRecord.sh $1
		;;
	'Update Table')
		. ./scripts/updateRecord.sh $1
		;;
	'Main Menu')
		./startView.sh
		;;
	'Exit')
		echo $'\n << OKay, Good Bye >>\n'
		exit
		;;
	*)
		echo "Incorect answer, Redirecting to main menu.."
		sleep 2
		./startView.sh
		;;
	esac
done
