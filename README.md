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

1. Clone this repository to your local machine or cloud machine:
 ```
 git clone https://github.com/Hemanath78/Linux-Server-Setup-Script.git
```

2. Change to the repository directory:
```
cd Linux-Server-Setup-Script
```

3. Make the script executable:
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

### Tomcat Admin User

The script will prompt you to set up a Tomcat admin user with the following roles:

- manager-gui: Allows access to the Tomcat Manager GUI.

### Database Configuration

You will be asked to provide the following database configuration details:

- Database Host
- Database Username
- Database Password

These details are used to configure the setenv.sh script for your specific database connection.

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



