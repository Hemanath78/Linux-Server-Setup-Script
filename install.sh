#!/bin/bash

# Function to prompt for user input securely
prompt_for_input() {
    read -p "$1: " -r
    echo "$REPLY"
}

# Check if JDK 17 is already installed
if ! type "java" > /dev/null 2>&1; then
    echo "JDK 17 is not installed. Installing..."
    if sudo yum install -y java-17-amazon-corretto-devel; then
        echo "JDK 17 has been installed successfully."
    else
        echo "Error: Failed to install JDK 17."
        exit 1
    fi
else
    echo "JDK 17 is already installed."
fi

# Check if Tomcat is already installed
if [ ! -d "/opt/tomcat" ]; then
    # Download and extract Tomcat (adjust the version as needed)
    TOMCAT_VERSION="9.0.80"
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
    if tar -xf apache-tomcat-$TOMCAT_VERSION.tar.gz; then
        echo "Tomcat has been extracted."
    else
        echo "Error: Failed to extract Tomcat."
        exit 1
    fi

    # Move Tomcat to /opt/tomcat
    if sudo mv apache-tomcat-$TOMCAT_VERSION /opt/tomcat; then
        echo "Tomcat has been installed."
    else
        echo "Error: Failed to move Tomcat to /opt/tomcat."
        exit 1
    fi
else
    echo "Tomcat is already installed."
fi

# Copy tomcat-users.xml and context.xml from the cloned Git repository
REPO_DIR="/home/ec2-user/Linux-Server-Setup-Script" # Replace with the actual path
if [ -d "$REPO_DIR" ]; then
    if sudo cp "$REPO_DIR/tomcat-users.xml" /opt/tomcat/conf/tomcat-users.xml && \
       sudo cp "$REPO_DIR/context.xml" /opt/tomcat/webapps/manager/META-INF/context.xml; then
        echo "Configuration files copied from the Git repository."
    else
        echo "Error: Failed to copy configuration files from the Git repository."
        exit 1
    fi
else
    echo "Error: Repository directory not found."
    exit 1
fi

# Prompt the user for database configuration
echo "Please enter database configuration:"
DATABASE_HOST=$(prompt_for_input "Database Host")
DATABASE_USERNAME=$(prompt_for_input "Database Username")
DATABASE_PASSWORD=$(prompt_for_input "Database Password")

# Create setenv.sh with database environment variables
if sudo sh -c "cat <<EOL > /opt/tomcat/bin/setenv.sh
export DATABASE_HOST=$DATABASE_HOST
export DATABASE_USERNAME=$DATABASE_USERNAME
export DATABASE_PASSWORD=$DATABASE_PASSWORD
EOL"; then
    echo "setenv.sh file created with database environment variables."
else
    echo "Error: Failed to create setenv.sh file."
    exit 1
fi

# Make setenv.sh executable
if sudo chmod +x /opt/tomcat/bin/setenv.sh; then
    echo "setenv.sh made executable."
else
    echo "Error: Failed to make setenv.sh executable."
    exit 1
fi

# Prompt the user for Tomcat admin credentials
echo "Please enter Tomcat admin credentials:"
TOMCAT_ADMIN_USER=$(prompt_for_input "Tomcat Admin Username")
TOMCAT_ADMIN_PASSWORD=$(prompt_for_input "Tomcat Admin Password")

# Create tomcat-credentials.properties file with Tomcat admin credentials
if sudo sh -c "cat <<EOL > /opt/tomcat/conf/tomcat-credentials.properties
tomcat.admin.username=$TOMCAT_ADMIN_USER
tomcat.admin.password=$TOMCAT_ADMIN_PASSWORD
EOL"; then
    echo "tomcat-credentials.properties file created with Tomcat admin credentials."
else
    echo "Error: Failed to create tomcat-credentials.properties file."
    exit 1
fi

echo "Installation and configuration completed."
