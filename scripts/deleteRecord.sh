# Delete Record steps
# 1. list all records => PK
# 2. check PK to delete its record
# [ file => copyFile 		]
# | clear file				|
# [ copyFile =Filter=> file	]

function deleteRecord {

	. ./scripts/listTable.sh $database

	echo -e " - Please enter table name to delete from it: \c"
	read table_name

	if [[ -f ./mydb/$database/$table_name ]]; then

		# To print the table head
		column -t -s ';' ./mydb/$database/$table_name

		echo -e $" - Please enter the value to select record(s): \c"
		read value
		echo $'-----------------------------\t'
		# find the pattern in records |> for all fields |> as a table display
		awk -v pat=$value '$0~pat{print $0}' ./mydb/$database/$table_name | column -t -s ';'
		echo $'-----------------------------\t'

		echo -e $" - Please specify field number: \c"
		read field
		NR=$(awk 'BEGIN{FS=";"}{
				if ($'$field'=="'$value'") 
					print NR
				}' ./mydb/testing/test 2>>/dev/null)

		# To delete the Row
		sed -i ''$NR'd' ./mydb/$database/$table_name 2>>/dev/null

		#To print the new table
		echo $'-----------------------------\t'
		echo " << Your table  $table_name after delete this row >> "

		column -t -s ';' ./mydb/$database/$table_name
		echo " << Row  Deleted Successfully >> "

		. ./scripts/tablesOperation.sh $database
	else
		echo " << Table doesn't exist ! >>"
		echo -e $" - Do you want to create it? [y/n]: \c"
		read answer

		case $answer in
		y)
			./scripts/createTable.sh
			;;
		n)
			./scripts/selectRecord.sh
			;;
		*)
			echo " << Incorrect answer. Redirecting to main menu.. >> "
			sleep 2
			cd ..
			./startView.sh
			;;
		esac
	fi
}

deleteRecord
