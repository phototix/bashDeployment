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
    REMOTE_USER="serveruser"
    
    echo "Copying files to $INSTANCE..."
    
    # Use rsync to copy the updated files to the instance
    rsync -avz --delete -e "ssh -i $SSH_KEY" --exclude=".DS_Store" --exclude=".git*" --exclude="node_modules" --exclude="*.log" $SOURCE_DIR/ $REMOTE_USER@$INSTANCE:$DEST_DIR
EOF
    
    echo "Files copied to $INSTANCE"
done
