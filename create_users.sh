#!/bin/bash

# Exit if script is not run with root privileges
if [ $UID -ne 0 ]; then
	exit 1
fi

# Store CLI-arguments as USERS array
USERS=("$@")

# Create user and setup home folder
create_user() {
	# Create the user
	useradd --create-home "$1"

	# Setup directory structure in Home catalogue
	mkdir "/home/$1/Documents" "/home/$1/Downloads" "/home/$1/Work"

	# Set owner and group of the directories to the user
	chown "$1:$1" "/home/$1/Documents" "/home/$1/Downloads" "/home/$1/Work"

	# Set read/write/execute permissions for owner only
	chmod 700 "/home/$1/Documents" "/home/$1/Downloads" "/home/$1/Work"

	# Create welcome message
	echo "Välkommen $1" > "/home/$1/welcome.txt"

	# Add list of users to the welcome message
	for user in "${USERS[@]}"; do
		echo "$user" >> "/home/$1/welcome.txt"
	done

}


# Create the users
for user in "${USERS[@]}"; do
	create_user "$user"
done
