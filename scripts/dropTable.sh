./scripts/listTable.sh $1

while true; do

	echo -e " - Table name to be deleted: \c "
	read table_name

	if [[ -f ./mydb/$database/$table_name ]]; then
		rm ./mydb/$database/$table_name
		echo '-----------------------------------------'
		echo " << $table_name is deleted! >> "
		. ./scripts/tablesOperation.sh $database
	else
		echo "  << No matching table name >>"

	fi

done
