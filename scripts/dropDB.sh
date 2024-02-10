./scripts/listDB.sh

read -p " - Enter DB name to be deleted: " database
echo $'\t'

database=$(echo $database | tr ' ' '_') #^ to replace the space with _

if [[ -d ./mydb/$database ]]; then
	rm -r ./mydb/$database
	echo "-----------------------------"
	echo " >> $database <<  removed ... Done"
	./startView.sh
else
	echo " << Sorry This is name of DB  Not Exist >> "
	./startView.sh

fi
