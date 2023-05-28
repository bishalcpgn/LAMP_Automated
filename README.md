<a name="readme-top"></a>

## About The Project

* A script that can save time by automating manual installation of LAMP in debian.

* It automates mysql_secure_installation too. :smile: 
 
          
### Installation

1. Clone the repo
   ```
   git clone https://github.com/bishalcpgn/LAMP_Automated.git
   ```
   
2. Make it executable
   ```
   chmod +x LAMP.sh
   ```
   
3. Execute it 
   ```
   ./LAMP.sh
   ```
   
4. <a href="https://localhost/phpmyadmin" target="_blank">Click here</a> to test credentials.

          Username : root
          Password : root
          
5. Check PHP module in Apache


* If module is added, php information page will open in localhost. 

    ```ssh
    echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.html
      
    sudo mv /var/www/html/index.html /var/www/html/index.php
      
    xdg-open http://localhost
    ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### More Tips 

1. Start apache server 
   ```
   sudo service apache2 start
   ```
   
2. Stop apache server 
   ```
   sudo service apache2 stop
   ```
   
3. Check status of Apache 
   ```
   sudo systemctl status apache2
   ```

4. Start MariaDB ( An open-source fork of MySQL )
   ```
   sudo service mysql start
   ``` 
   
5. Stop MariaDB 
   ``` ssh 
   sudo service mysql stop
   ``` 
   
6. Check status of MariaDB
   ```ssh
   sudo systemctl status mysql
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>












