#!/bin/bash

# Author: Caleb Bhyun

# Create a list of shares in a format like:
# \\HOSTNAME\SHARE1
# \\HOSTNAME\SHARE2
# ...

# ./forced_authentication_clean_up.sh 'FQDN/USERNAME' 'PASSWORD' FILENAME

# Check if username, password, and filename were provided
if [ $# -ne 3 ]; then
    echo "Incorrect number of arguments provided. Usage: ./test.sh USERNAME PASSWORD FILENAME"
    exit 1
fi

# Define the username and password
username="$1"
password="'$2'"

# Define the commands to run after connecting
cmds="
rm @test.scf
rm @test.url
rm @test.library-ms
"

# Read each line from the input file
while IFS= read -r line
do
  # Replace single backslashes with double backslashes
  line=${line//\\/\\\\}

  # Add double quotes around the line
  line="\"$line\""

  # Define the command to connect to the SMB share
  cmd="smbclient -U $username%$password $line"

  # Pass the commands to smbclient
  echo "$cmds" | eval $cmd
done < "$3"
