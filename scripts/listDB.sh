echo $'\t'
echo $' - These are the current database:- '
echo $'\t'
echo "-----------------------------"
ls -F ./mydb | grep / | tr '/' ' '
echo "-----------------------------"
echo $'\t'
