function selectRecord {
	. ./scripts/listTable.sh $database
	
	echo -e " - Please enter table name to select data: \c"
	read table_name

	#^ check if the table exist or no
	if [[ -f ./mydb/$database/$table_name ]]; then
		echo $'\t'

		# To print the table heads
		awk ' BEGIN{FS=";"}
		{
			if (NR==1) {
				for(i=1;i<=NF;i++)
					{printf "--|--"$i}
				{print "--|"}
			}
		}' ./mydb/$database/$table_name

		echo -e $" - Would you like to print all records? [y/n]: \c"
		read printall

		if [[ $printall == "Y" || $printall == "y" || $printall == "yes" ]]; then

			echo -e $" - Would you like to print a specific field? [y/n]: \c"
			read cut1

			# if need to print a specific field
			if [[ $cut1 == "Y" || $cut1 == "y" || $cut1 == "yes" ]]; then
				echo -e $" - Please specify field number: \c"
				read fieldno

				echo "-----------------------------"
				awk $'{print $0\t}' ./mydb/$database/$table_name | cut -f$fieldno -d";"

				echo "-----------------------------"
			else
				# To print all the table
				echo $'\n'

				echo "-----------------------------"
				#column comand in Linux is used to display the contents of a file in columns.
				#-s : Defines the column delimiter for output.
				#-t : Applied for creating a table by determining the number of columns.
				column -t -s ';' ./mydb/$database/$table_name
				echo $'<----------------------------->\n'
			fi
		#---------------------------------------------------------------------------------------------------------------------------------#
		else
			echo -e $" - Please enter a search value to select record(s): \c"
			read value

			echo -e $" - Would you like to print a specific field? [y/n]: \c"
			read cut

			if [[ $cut == "Y" || $cut == "y" || $cut == "yes" ]]; then
				echo -e $" - Please specify field number: \c"
				read field

				echo $'<----------------------------->\n'
				# find the pattern in records |> for that specific field
				#awk using the -v option -> you can pass shell variables to it
				awk -v pat=$value $'$0~pat{print $0\n}' ./mydb/$database/$table_name | cut -f$field -d";"

			else
				echo echo $'<----------------------------->\n'
				# find the pattern in records |> for all fields |> as a table display
				awk -v pat=$value '$0~pat{print $0}' ./mydb/$database/$table_name | column -t -s ';'

			fi
		fi

		#---------------------------------------------------------------------------------------------------------------------------------#
		#^ To check if need to make another query?
		echo -e $" - Would you like to make another query? [y/n]: \c"
		read answer

		if [[ $answer == "Y" || $answer == "y" || $answer == "yes" ]]; then
			echo $'<----------------------------->\n'
			selectRecord
		elif [[ $answer == "N" || $answer == "n" || $answer == "no" ]]; then

			. ./scripts/tablesOperation.sh $database
		else
			echo $'Invalid choice\n'
			echo " << Redirecting to main menu.. >> "
			sleep 2
			./startView.sh
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
			. ./scripts/selectRecord.sh $database
			;;
		*)
			echo " << Incorrect answer. Redirecting to main menu.. >> "
			sleep 2
			pwd
			./startView.sh
			;;
		esac
	fi
}

selectRecord
