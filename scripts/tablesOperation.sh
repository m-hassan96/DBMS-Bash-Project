PS3="- Please choose an option: "
echo '-----------------------------------------'

echo -e " - What you want to do in $1:- \n"
select action in 'Create Table' 'List Tables' 'Drop Table' 'Insert into Table' 'Select From Table' 'Delete From Table' 'Update Table' 'Main Menu' 'Exit'; do
	case $action in
	'Create Table')
		. ./scripts/createTable.sh
		;;
	'List Tables')
		. ./scripts/listTable.sh
		;;
	'Drop Table')
		. ./scripts/dropTable.sh
		;;
	'Insert into Table')
		. ./scripts/insertRecord.sh
		;;
	'Select From Table')
		. ./scripts/selectRecord.sh
		;;
	'Delete From Table')
		. ./scripts/deleteRecord.sh
		;;
	'Update Table')
		. ./scripts/updateRecord.sh
		;;
	'Main Menu')
		cd ..
		. startView.sh
		;;
	'Exit')
		echo $'\n << OKay, Good Bye >>\n'
		exit
		;;
	*)
		echo "Incorect answer, Redirecting to main menu.."
		sleep 2
		cd ..
		. startView.sh
		;;
	esac
done
