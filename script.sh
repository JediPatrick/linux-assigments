while true; do 
	read -p "Do you want to download the package? Enter y for yes and n for no." yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) echo "script terminated";exit;;
		* ) echo "Try again. Enter y for yes and n for no.";;
	esac
done

while true; do 
	read -p "Do you want to install from source code or dpkg/rpm? Enter 1 for source code and 2 for dpkg/rpm." yn
	case $yn in
		[1]* ) echo "source code selected";packagetype="source";break;;
		[2]* ) echo "dpkg/rpm selected";packagetype="dpkg";break;;
		* ) echo "Try again. Enter 1 for source code and 2 for dpkg/rpm.";;
	esac
done
echo "Please type in link to package"
read LINK
echo "Checks/changes permission of folder"
permiss=$(stat -c %a /usr/local/src)

if [ "$permiss" == "775" ]; then
	echo "Permissions didnt need to be changed"
else
	sudo chmod 777 /usr/local/src
	echo "Permissions changed"
fi
cd /usr/local/src
wget $LINK
filename=$(basename "$LINK")
echo $filename

if [ "$packagetype" == "dpkg" ]; then
	echo "dpkg/rpm."
else
	echo "source code."
	tar -xzvf $filename
fi
