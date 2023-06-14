#!/bin/bash

# Set the source directory where the files are located
SOURCE_DIR="/var/www/html"

# Set the destination directory where the files will be copied to on each instance
DEST_DIR="/var/www/html"

# Set the list of EC2 instances to copy the files to
INSTANCES=(
    "IP Address 01"
    "IP Address 02"
    # Add more instances as needed
)

# Set the path to the SSH key file for each instance
SSH_KEYS=(
    "/ssh/key_file_01.pem"
    "/ssh/key_file_02.pem"
    # Add more key files as needed
)

# Loop through each instance and copy the files using SFTP
for (( i=0; i<${#INSTANCES[@]}; i++ )); do
    INSTANCE="${INSTANCES[i]}"
    SSH_KEY="${SSH_KEYS[i]}"
    
    echo "Copying files to $INSTANCE..."
    
    # Use SFTP to copy the files to the instance
    sftp -i "$SSH_KEY" "ec2-user@$INSTANCE" <<EOF
        put -r "$SOURCE_DIR" "$DEST_DIR"
        bye
EOF
    
    echo "Files copied to $INSTANCE"
done
