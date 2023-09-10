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

# Prompt the user for Tomcat admin credentials
echo "Please enter Tomcat admin credentials:"
TOMCAT_USER=$(prompt_for_input "Username")
TOMCAT_PASSWORD=$(prompt_for_input "Password")

# Add user roles to tomcat-users.xml
if sudo sh -c "echo '<role rolename=\"manager-gui\"/>' > /tmp/roles.xml"; then
    if sudo sh -c "echo '<user username=\"$TOMCAT_USER\" password=\"$TOMCAT_PASSWORD\" roles=\"manager-gui\"/>' > /tmp/users.xml"; then
        sudo sed -i '/<\/tomcat-users>/ { r /tmp/roles.xml' -e '}' /opt/tomcat/conf/tomcat-users.xml
        sudo sed -i '/<\/tomcat-users>/ { r /tmp/users.xml' -e '}' /opt/tomcat/conf/tomcat-users.xml
        echo "Tomcat admin user added to tomcat-users.xml."
    else
        echo "Error: Failed to add Tomcat admin user to tomcat-users.xml."
        exit 1
    fi
else
    echo "Error: Failed to add role to tomcat-users.xml."
    exit 1
fi

# Prompt the user for database configuration
echo "Please enter database configuration:"
DATABASE_HOST=$(prompt_for_input "Database Host")
DATABASE_USERNAME=$(prompt_for_input "Database Username")
DATABASE_PASSWORD=$(prompt_for_input "Database Password")

# Create setenv.sh with database environment variables
if sudo sh -c "cat <<EOL > /opt/tomcat/bin/setenv.sh
#!/bin/sh
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

# Remove the specific Valve block from context.xml
if sudo sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/<\/Valve>/d' /opt/tomcat/webapps/manager/META-INF/context.xml; then
    echo "Valve configuration removed from context.xml."
else
    echo "Error: Failed to remove Valve configuration from context.xml."
    exit 1
fi

echo "Installation and configuration completed."
