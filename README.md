# PHP in MySQL

Make your apps clearer for reading. Use functions you know from PHP in your MySQL queries. Learn differencies and how MySQL works

## Install
Installation is really simple. Every MySQL function and procedure is stored in database. So you must include to it only. And it is. Every function you can install separately.

### Installing with database manager
> MySQL Workbench / phpMyAdmin / Adminer / Emma / Webmin MySQL module / ...

- Browse src directory in this repository for a function you want and copy the source to a clipboard.
- Select final database in your DB manager.
- Paste the copied source of a function to DB manager direct input and execute.
- Happy using :)

### Install from terminal
- Download a function you want and execute following command (with uppercased text replacement):
- mysql -uUSER -pPASSWORD DATABASE < ./PATH/FUNCTION_NAME.sql

### Install from MySQL command line
- Download a function you want and execute following commands (with uppercased text replacement):
- use DATABASE;
- source ./PATH/FUNCTION_NAME.sql