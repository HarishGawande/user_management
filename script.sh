#!/bin/bash

# ************** USER MANAGEMENT SCRIPT *******************

echo -e " \n Hello! $(whoami)"

echo -e "  \n ================================================"
# To get present users & groups.
PUL=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | tail -n 3)
PUG=$(awk -F: '$3 >= 1000 {print $1}' /etc/group | tail -n 3)

echo -e "  \n PRESENT_USERS_LIST: \n $PUL"
echo -e "  \n ================================================"
echo -e "  \n PRESENT_GROUP_LIST: \n $PUG"
echo " "
########################################################################

# **********************To create a new user.
crt_usr() {

	# To get primary input from user.
	echo "Enter new username here"
	read NEW_USERNAME

	echo "Enter the password here"
	read PASWORD

	# To check if user is already present.
	if id $NEW_USERNAME &>/dev/null; then
		echo "User name $NEW_USERNAME already exists, Try another username."
		create_user
	else
		sudo useradd -m -s /bin/bash $NEW_USERNAME

		# To set password for new_ user.
		echo $NEW_USERNAME:$PASWORD | sudo chpasswd
		echo "The user $NEW_USERNAME & password: $PASWORD has been created successfully."
	fi

}

# To start user creation.
#crt_usr



###################################################################################

# **************************To delete user.
del_usr() {

	# To get which user you want to delete.
	echo  "Enter one of the username here, from above users"
	read DELETE_USERNAME

	# To check if it's main user.
	if [ $DELETE_USERNAME == $USERNAME ]; then
		echo "Given username:$DELETE_USERNAME is main user, it can't be Deleted."
	else
		sudo userdel -r $DELETE_USERNAME
		echo "User:$DELETE_USERNAME is deleted successfully."
	fi
	echo "$PPL"
}

# To Start user deletion.
#del_usr


####################################################################################

# ******************************To create usergroup.
usr_grp() {

	# To get present user group list.
	PUG=$(awk -F: '$3 >= 1000 {print $1}' /etc/group | tail -n +3)
	echo "$PUG"

	#To get usergroup name to be create.
	echo "Enter the usergroup name here"
	read USER_GROUP

	#To chek if group is already present.
	if id $USER_GROUP &>/dev/null; then
		echo "User group:$USER_GROUP is already exists, Try another name"
	else
		sudo groupadd $USER_GROUP
		echo "User group:$USER_GROUP created successfully."
	fi
}

# To Start  User group creation.
#usr_grp


##############################################################################


# ***********************************To Add user in another group.
usrt_ngrp() {

	# To get input as user name.
	read -p "Enter the User name: " USR_NAME
	read -p "Enter the Other Group name: " GRP_NAME

	# To print present user_id & group_id.
	id $USR_NAME

	# To move user from present group to given.
	sudo usermod -g "$GRP_NAME" "$USR_NAME"

	# To print user_id with new_group.
	id $USER_NAME
	echo "The User: $USR_NAME is moved to Group: $GRP_NAME, Check the group_id."

}
#usrt_ngrp



################################################################################################################

# ******************************************To Change user name.
chng_uname() {

	#To get input as user_name  & group_name.
	read -p "Enter the User name: " USR_NAME
	read -p "Enter New user name: " NEW_NAME

	# To print present Name of User.
	id $USR_NAME

	# To change the new name.
	sudo usermod -l $NEW_NAME $USR_NAME

	# To print new user name.
	id $NEW_NAME
	echo "The User name changed $USR_NAME TO $NEW_NAME, Successfully"
}

#chng_uname

#############################################################################


# ****************************************To chnage Directory of User.
chng_udir() {

	# To get input as user_name & new_directory.
	read -p "Enter the User name: " USR_NAME
	read -p "Enter the New directory: " DIR_NAME

	# To print current direcotory.
	eval echo ~$USR_NAME

	# To change directory of user.
	sudo usermod -d /home/$DIR_NAME $USR_NAME
	eval echo ~$USR_NAME

	echo "The Directory of User: $USR_NAME is changed, successfully"

}

#chng_udir


#############################################################################

# ************************************To delete usergroup.
del_grp() {

	# To get input as group name.
	echo "Enter Group_name here."
	read GRP_NAME
	sudo groupdel $GRP_NAME
	echo "The User_group: $GRP_NAME, is deleted successfully."
}

# To start User group deletion.
#del_grp


############################################################################

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"

echo -e "  \n What do you want to do!"
echo -e "  \n-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
echo -e "  \n A : *CREATE_USER* \n B : *DELETE_USER* \n C : *CREATE_GROUP* \n D : *DELETE_GROUP* \n E : *CHANGE_USER_NAME* \n F : *CHANGE_USER_DIRECTORY* \n G : *MOVE_USER_TO_ANOTHER_GROUP*"
echo -e "  \n ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ \n  "

read -p "Choose from above:" O

if [ $O == A ] || [ $O == a ]; then
	crt_usr

elif [ $O == B ] || [ $O == b ]; then
	del_usr

elif [ $O == C ] || [ $O == c ]; then
	usr_grp

elif [ $O == D ] || [ $O == d ]; then
	del_grp

elif [ $O == E ] || [ $O == e ]; then
	chng_uname

elif [ $O == F ] || [ $O == f ]; then
	chng_udir

elif [ $O == G ] || [ $O == g ]; then
	usrt_ngrp
else
	echo " Enter valid input, Exited"
fi






echo "Thanks!"

