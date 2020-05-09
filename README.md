# AppShore

This CRM software was designed in 2004 and commercialy ran online until 2019 with nearly no modification. 

After a 10 months wind down period to ease the migration of remaining customers, the CRM service was shutdown definitively April 30, 2020.

This software source code is provided as is without warranty nor service. 

## Stack

- PHP 7
- MySQL/MariaDB
- Lighttpd


## Installation instructions

Create a folder for the project
```
$ mkdir appshore
$ cd appshore
```

Retrieve the git
```
$ git pull https://github.com/appshore/v23Japan.git
```

 In the project's directory, run the following commands in 3 different terminals:
```
//start mysql/MariaDB server
$ mysql.server start

// set /etc/hosts
$ cat /etc/hosts
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
127.0.0.1       backoffice.appshore.local
127.0.0.1       phpmyadmin.appshore.local
127.0.0.1       v23.appshore.local
127.0.0.1       www.appshore.local
255.255.255.255	broadcasthost

// start
$2 cd ~/Dev/v23  // or whatever folder where the V23 files are installed
$2 php -S v23.appshore.local:8000

// start backoffice
$2 cd ~/Dev/v23  // or whatever folder where the V23 files are installed
$2 php -S backoffice.appshore.local:8001

// start phpMyAdmin
$ cd ~/Dev/phpMyAdmin   // or whatever folder where the phpMyAdmin files are installed
$ php -S phpmyadmin.appshore.local:8002


Visit `http://localhost:3000`

```
