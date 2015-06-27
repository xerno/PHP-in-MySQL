# PHP functions in MySQL

Make your apps clearer for reading. Use functions you know from PHP in your MySQL queries. Learn differencies and how MySQL works.

## Compatibility
All functions are tested on MySQL 5.1, 5.5 and MariaDB 5.5, 10. Many functions are universal and can run without any problem in another versions. If problems in any version major 5 or greater, please inform me. Contributions are welcome.

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

## Same functions
Many of PHP string functions are in the MySQL too, with same or very similar usage but with another name:
- LENGTH() -> strlen()
- CHAR_LENGTH() -> mb_strlen()
- TRIM() -> trim(): [see documentation](https://dev.mysql.com/doc/refman/5.0/en/string-functions.html#function_trim) for options
- REPLACE() -> str_replace()
- REPEAT() -> str_repeat()
- REVERSE() -> strrev()
- LOWER() -> mb_strtolower(): strtolower without mistakes :)
- UPPER() -> mb_strtoupper(): the same as above
- INSTR() -> strpos()
- SUBSTRING() -> mb_substr(): point starts at 1, not 0

> And more...
