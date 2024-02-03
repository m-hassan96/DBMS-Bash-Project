#!/usr/bin/bash

# Get the path of the script itself
parentDir="$(dirname "$0")"

# echo "PATH=$PATH:$parentDir" >>~/.bashrc
cd $parentDir

# Choosing an option
PS3=' - Choose an option >> '

echo "-----------------------------"
echo $'\n << Welcome to our DBMS >> \n'
echo $' << We love linux ^_^  >> \n'

select menu in 'Create DB' 'List DB' 'Connect To DB' 'Drop DB' 'Exit'; do
	case $menu in
	'Create DB')
		. ./scripts/createDB.sh
		;;
	'List DB')
		. ./scripts/listDB.sh
		;;
	'Connect To DB')
		. ./scripts/listDB.sh
		. ./scripts/connectDB.sh
		;;
	'Drop DB')
		. ./scripts/listDB.sh
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
		./startView.sh
		;;
	esac
done
echo $'\n'
