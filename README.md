# Bash Script: Installation and Configuration Automation by [Hemanath M](https://github.com/Hemanath78)

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Error Handling](#error-handling)
- [Contributing](#contributing)

## Overview

This Bash script simplifies the installation and configuration of essential components on a Linux system, including:

- JDK 17 (Amazon Corretto)
- Apache Tomcat
- Tomcat Admin User Configuration
- Database Credentials Configuration
- Removal of a Specific Valve Configuration in Tomcat's context.xml file

The script automates these tasks and provides interactive prompts for user input when required.

## Prerequisites

Before using this script, ensure you have the following prerequisites:

- A Linux system (tested on CentOS)
- Superuser (sudo) privileges
- Internet connectivity for downloading software components
- Familiarity with your system's configuration and database connection details

## Installation

1. Install the git in the system using the below command
```
sudo dnf install git
```

2. Clone this repository to your local machine or cloud machine:
 ```
 git clone https://github.com/Hemanath78/Linux-Server-Setup-Script.git
```

3. Change to the repository directory:
```
cd Linux-Server-Setup-Script
```

4. Make the script executable:
```
chmod +x install.sh
```

## Usage
### Run the script:
```
./install.sh
```
Follow the on-screen prompts to provide the necessary information and make selections.

The script will perform the following tasks:

- Check for JDK 17 and install it if not found.
- Check for Apache Tomcat and install it if not found.
- Prompt for Tomcat admin credentials and configure them.
- Prompt for database configuration (host, username, password).
- Create a setenv.sh script with database environment variables.
- Remove a specific Valve configuration from Tomcat's context.xml file.
- Display status messages and handle errors gracefully.

## Configuration

### Database Configuration

You will be asked to provide the following database configuration details:

- Database Host
- Database Username
- Database Password

These details are used to configure the setenv.sh script for your specific database connection.

## After Configuration

Return to the root directory using the below command

```
cd ~
```

Set the shortcuts to start or stop the tomcat by using this command

```
source ~/.bashrc
```

### Start the tomcat server
```
start-tomcat
```

### Stop the tomcat server
```
stop-tomcat
```

### How to Deploy the war file after the configuration
- First copy the Public IP from the EC2 Elastic IP.
- Then go to any web browser and paste the IP address with the 8080 port number.
  ```
  eg.
  127.0.0.1:8080
  The above example shows how exactly it looks when you paste your IP into a browser.
  ```
- Then it'll redirect you to the Tomcat Homepage Refer to the below Screenshot.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/b20c66b1-5f26-4045-b799-634066540910" alt="tomcat-home-page" width="700"/>

- Now you can see the Manager App on right side Refer below Screenshot.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/4a6aea83-de41-4652-85a6-c24ebb10a1f7" alt="tomcat-home-page" width="700"/>

- After Clicking the Manager App it asks you for your Username and Password refer below Screenshot for Reference.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/c9829584-3bd0-4a3a-8ddb-7e738c970571" alt="tomcat-tomcat-cred" width="700"/>

- Use the below Credentials to manage your Tomcat Server.
```
USERNAME: admin
PASSWORD: fssaadmin
```

- Once you log in using the above credentials you can see this page 
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/82631599-9059-4861-ba84-7cf312973c7e" alt="tomcat-tomcat-cred" width="700"/>

## ⚠IMPORTANT‼
- Before you deploy your WAR file into the cloud Machine make sure these things;
- Check your Connection Util It should look like the below code snippet.
```
  // For database credentials
		url = System.getenv("DATABASE_HOST");
		userName = System.getenv("DATABASE_USERNAME");
		passWord = System.getenv("DATABASE_PASSWORD");
```
- If everything is fine then clean the Maven WEB project by using the Maven Clean command.
- After successful execution of the Maven clean command run the Maven Install Command.
- Maven Install command should execute without any error and BUILD SUCCESS.
- So that you'll get the updated WAR file for your project.

- ### Make sure that you didn't face any errors during the above process.

- Now come back to the Previous step where you opened Tomcat Manager.
- In that, you can see the column called WAR file to deploy.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/cbe2c777-3f3f-4c57-89bd-c8633f34d896" alt="tomcat-tomcat-cred" width="700"/>

- Go to Eclipse and in Project Explorer right-click on your WEB project. Eclipse>>Project Explorer>>Your WEB project>>Right click>>Show in>>System Explorer.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/115ae582-2d54-4752-9dc7-768dfd7cd0b0" alt="tomcat-tomcat-cred" width="700"/>

- Once you open System Explorer you can see all the project folders Select your web project folder and open it there you can see the target folder.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/68257c6c-8c9e-4419-a9c4-7217736fb400" alt="tomcat-tomcat-cred" width="700"/>

- Now in the target folder you'll find your WAR file.
<img src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/bfc51495-2428-4222-93f4-5b4efc2dd601" alt="tomcat-tomcat-cred" width="700"/>

- That's the WAR file you need to deploy in the Tomcat manager's page.
- Now on  the tomcat manager's page, WAR deploy section choose the WAR file you want to deploy and upload the WAR. Refer above steps to find your WAR file.
 <img width="700" alt="image" src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/2330554b-98ad-4a3e-a8b9-159c6d980621">
 
- After choosing your WAR file click on Deploy It'll take some seconds and reloads automatically.
- This how the application section will look like before Deploying.
 <img width="700" alt="image" src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/b2c1f92a-374c-44b9-a9cb-001cc3e147f9">


- This how the application section will look like after Deploying your war. It show one new application with your WAR file name.
 <img width="700" alt="image" src="https://github.com/Hemanath78/Linux-Server-Setup-Script/assets/83415968/43f12df9-6626-4f42-a5de-ea97600a1e9c">



## Customization

You can customize the script by modifying the [install.sh](./install.sh) file according to your specific requirements.


## Error Handling

The script includes error handling to ensure that it behaves gracefully even in case of failures. If an error occurs during any step, an error message will be displayed, and the script will exit with a status code of 1.

## Contributing

If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your changes.
3. Make your changes and test them.
4. Commit your changes with clear commit messages.
5. Push your branch to your fork.
6. Create a pull request.
