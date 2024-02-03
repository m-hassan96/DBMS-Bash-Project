. ./scripts/listTable.sh $database

function insertRecord() {

	echo -e " - Please enter table name to insert data: \c"
	read table_name

	if [[ -f ./mydb/$database/$table_name ]]; then
		x=$(grep 'PK' ./mydb/$database/$table_name | grep -o ";" | wc -l) # number of fields

		for ((i = 1; i <= x; i++)); do
			columnName=$(grep PK ./mydb/$database/$table_name | cut -f$i -d";")
			echo $'\t'
			echo -e $" - Please enter data for field no.$i [$columnName]: \c"
			read data

			checkType $i $data	# call  checkType function 

			if [[ $? != 0 ]]; then 	#Status Last Command (0-->last Command Run Sucessfuly)
				((i = $i - 1))
			else
				echo -n $data";" >>./mydb/$database/$table_name	#to insert in record
        	echo '-----------------------------------------'
			fi
		done
		echo $'\n' >>./mydb/$database/$table_name #end of record
		echo $'<------------------------------->\n'
		echo " << insert done into $table_name >>"
		echo $'<------------------------------->\n'

		# find the pattern in records |> for all fields |> as a table display
		awk -v pat=$value '$0~pat{print $0}' ./mydb/$database/$table_name | column -t -s ';'
		. ./scripts/tablesOperation.sh $database
	else
		echo " << Table doesn't exist >> "
		echo -e " - Do you want to create it? [y/n]: \c"
		read answer
		case $answer in
		y)
			. ./scripts/createTable.sh $database
			;;
		n)
			. ./scripts/insertRecord.sh $database
			;;
		*)
			echo " << Incorrect answer. Redirecting to main menu.. >>"
			sleep 2
			cd ../
			. startView.sh
			;;
		esac

	fi

}

function checkType() {

	datatype=$(grep PK ./mydb/$database/$table_name | cut -f$1 -d";")

	# colname(int) => get in the () only
	if [[ "$datatype" == *"int"* ]]; then
		num='^[0-9]+$'
		if ! [[ $2 =~ $num ]]; then
			echo " << False input: Not a number! >> "
			return 1
		else
			checkPK $1 $2  # to call  checkPK function 
		fi
	elif [[ "$datatype" == *"string"* ]]; then
		str='^[a-zA-Z]+$'
		if ! [[ $2 =~ $str ]]; then
			echo " << False input: Not a valid string! >> "
			return 1
		else
			checkPK $1 $2	# to call  checkPK function 
		fi
	fi
}

# checkPrimaryKeyExistance fieldno. data_for_that_field
function checkPK() {
	header=$(grep PK ./mydb/$database/$table_name | cut -f$1 -d";")
	if [[ "$header" == *"PK"* ]]; then
		if [[ $(cut -f$1 -d";" ./mydb/$database/$table_name | grep -w $2) ]]; then
			echo $'\n << Primary Key already exists. no duplicates allowed! >> '
			return 1
		fi
	fi
}

insertRecord
