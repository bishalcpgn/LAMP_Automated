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
    mysql_secure_installation << input
         
        y
        root
        root
        y
        y
        y
        y
input
    check_status $? "MYSQL_Secure_Installation"

    #Enabling login with root
    mysql -u root -proot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"

#Using heredoc
#sudo mysql -u root -proot <<EOF
#     ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';    
# EOF
    
    systemctl stop mysql #mysql stopped
    systemctl reload mysql
    apt install php -y
    check_status $? "PHP"

    
    apt install phpmyadmin 
    check_status $? "phpMyAdmin"

    export DEBIAN_FRONTEND=noninteractive

# Pre-seed Debconf values for phpMyAdmin installation
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | sudo debconf-set-selections

apt install phpmyadmin -y 

# Enable phpMyAdmin site in Apache
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/phpmyadmin.conf
# Enable phpMyAdmin site in Apache
a2ensite phpmyadmin
systemctl reload apache2
unset DEBIAN_FRONTEND

    echo -e "\nTask Completed Successfully.\n"
fi