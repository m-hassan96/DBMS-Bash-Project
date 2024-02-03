column -t -s ';' ./mydb/testing/test

echo -e $" - Please enter a search value to select record(s): \c"
read value

echo echo $'<====================>\n'
# find the pattern in records |> for all fields |> as a table display
awk -v pat=$value '$0~pat{print $0}' ./mydb/testing/test | column -t -s ';'

echo -e $" - Please specify field number: \c"
read field

awk -v pat=$value $'$0~pat{print $0\n}' ./mydb/testing/test | cut -f$field -d";"

findex=$(awk -v pat=$value $'$0~pat{print $0\n}' ./mydb/testing/test | cut -f$field -d";")

echo $findex

function updateRecord {

	echo -e " - Enter Table Name: \c"
	read table

	awk 'BEGIN{FS=";"}{if (NR==1) {for(i=1;i<=NF;i++){printf "--|--"$i}{print "--|"}}}' ./mydb/$database/$table

	echo ' - Enter Column name: \c'
	read field

	findex=$(
		awk 'BEGIN{FS=";"}{
			if(NR==1){
				for(i=1;i<=NF;i++){
					if( $i == $field ) 
					print i 
					echo $i
				}
			}
		}' ./mydb/$database/$table
	)

	echo $findex
	pwd
	if [[ -z $findex ]]; then
		echo " << Not Found >> "
		. ./scripts/tablesOperation.sh ./mydb/$databasu
	else
		echo -e" - Enter Value: \c"
		read value
		result=$(
			awk 'BEGIN{FS=";"}{
				if ($'$findex'=="'$value'") 
				print $'$findex'}
				' ./mydb/$database/$table 2 >>/dev/null
		)

		echo $result
		pwd
		if [[ -z $result ]]; then
			echo "Value Not Found"
			. ./scripts/tablesOperation.sh ./mydb/$database
		else
			echo "Enter new Value to set:"
			read newValue
			NR=$(awk 'BEGIN{FS=";"}{if ($'$findex' == "'$value'") print NR}' ./mydb/$database/$table 2>>/dev/null)
			echo $NR
			oldValue=$(awk 'BEGIN{FS=";"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$findex') print $i}}}' ./mydb/$database/$table 2>>/dev/null)
			echo $oldValue
			sed -i ''$NR's/'$oldValue'/'$newValue'/g' ./mydb/$database/$table 2>>/dev/null
			echo "Row Updated Successfully"
			./scripts/tablesOperation.sh $database
		fi
	fi
}

#updateRecord
