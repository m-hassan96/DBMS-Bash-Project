. ./scripts/listTable.sh $database

function updateRecord {

	while true; do

		echo -e $' - Please enter table name to update: \c'
		read table_name

		table_name=$(echo $table_name | tr ' ' '_') #^ to replace the space with _

		#? Validating table name
		if [[ -f ./mydb/$database/$table_name ]]; then

			echo $'<------------------------------->\n'
			# find the pattern in records |> for all fields |> as a table display
			column -t -s ';' ./mydb/$database/$table_name
			echo $'<------------------------------->\n'

			echo -e $" - Please enter the value that want to change: \c"
			read value

			echo -e $" - Please specify field number: \c"
			read field

			findex=$(awk -v pat=$value $'$0~pat{print $0\n}' ./mydb/$database/$table_name | cut -f$field -d";" 2>>/dev/null)

			if [[ $findex > =1 ]]; then
				changeData
				echo $'<------------------------------->\n'
				# find the pattern in records |> for all fields |> as a table display
				column -t -s ';' ./mydb/$database/$table_name
				echo $'<------------------------------->\n'
				. ./scripts/tablesOperation.sh $database

			else
				echo '-----------------------------------------'
				echo " << False inputs not found >> "
				echo '-----------------------------------------'
				. ./scripts/tablesOperation.sh $database
			fi

		else
			echo " << Table doesn't exist >>"
			echo -e $" - Do you want to create it? [y/n]: \c"
			read answer

			case $answer in
			y)
				. ./scripts/createTable.sh $database
				;;
			n)
				. ./scripts/tableOperation.sh $database
				;;
			*)
				echo " << Incorrect answer. Redirecting to main menu.. >> "
				sleep 2
				cd ..
				./startView.sh
				;;
			esac
		fi
	done

}

function changeData() {

	echo -e " - Enter new Value to set: \c"
	read newValue

	oldValue=$(awk -v pat=$value $'$0~pat{print $0\n}' ./mydb/$database/$table_name | cut -f$field -d";" 2>>/dev/null)

	sed -i 's/'$oldValue'/'$newValue'/g' ./mydb/$database/$table_name 2>>/dev/null

	if [[ '$oldValue' == '$newValue' ]]; then #Status Last Command (0-->last Command Run Sucessfuly)
		return 0
	else
		return 1
	fi
}

updateRecord
