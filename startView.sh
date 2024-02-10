#! /usr/bin/bash

# Get the path of the script itself
parentDir="$(dirname "$0")"

echo "PATH=$PATH:$parentDir" >>~/.bashrc
cd $parentDir

if [[ -d $parentDir/mydb ]]; then
echo "-----------------------------"
	echo " << Your Directory for Database already Exit : >> "
else
echo "-----------------------------"
	echo " << Your Directory for Database created done >> "
	mkdir /mydb
fi

# Choosing an option
PS3='> Main < Choose an option >> '

echo "-----------------------------"
echo $'\n << Welcome to our DBMS >>\n'
echo $' << We love linux ^_^  >>\n'

select menu in 'Create DB' 'List DB' 'Connect To DB' 'Drop DB' 'Exit'; do
	case $menu in
	'Create DB')
		. ./scripts/createDB.sh
		;;
	'List DB')
		. ./scripts/listDB.sh
		;;
	'Connect To DB')
		. ./scripts/connectDB.sh
		;;
	'Drop DB')
		. ./scripts/dropDB.sh
		;;
	'Exit')
		echo $'\n << OKay, Good Bye >>\n'
		exit
		;;
	*)
		echo "-----------------------------"
		echo " << Not valid option choice! >> "
		echo "-----------------------------"
		. ./startView.sh
		;;
	esac
done
echo $'\n'
