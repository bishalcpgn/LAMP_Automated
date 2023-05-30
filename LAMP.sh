#!/bin/bash

# Function to check installation status
check_status() {
    if [ $1 -eq 0 ]; then
        echo -e "\n$2 installed successfully.\n"
    else
        echo -e "\nFailed to install $2.\n"
        exit 1
    fi
}

# To check root permissions
if [ "$EUID" -ne 0 ]; then
    echo -e "\nThis script must be run as root.\n" 
    exit 1   
else 
    apt update && apt upgrade -y
    check_status $? "Package updates"

    apt install apache2 -y
    check_status $? "Apache"

    # systemctl status apache2

    apt install mariadb-server -y
    check_status $? "MariaDB"

    # systemctl status mariadb

    #mysql started for mysql_secure_installation
    systemctl start mysql

    sudo mysql_secure_installation << input

        y
        root
        root
        y
        y
        y
        y
input
    check_status $? "MYSQL_Secure_Installation"

    systemctl stop mysql #mysql stopped

    apt install php -y
    check_status $? "PHP"

    
    apt install phpmyadmin -y
    check_status $? "phpMyAdmin"

    echo -e "\nTask Completed Successfully.\n"
fi
