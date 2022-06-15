# qbr-management

New qbr-bossmenu / qbr-gangmenu converted into one resource using qbr-menu and qbr-input, with SQL support for society funds!

## Dependencies
- [qbr-core](https://github.com/qbcore-redm-framework/qbr-core)
- [qbr-smallresources](https://github.com/qbcore-redm-framework/qbr-smallresources) (For the Logs)
- [qbr-input](https://github.com/qbcore-redm-framework/qbr-input)
- [qbr-menu](https://github.com/qbcore-redm-framework/qbr-menu)
- [qbr-inventory](https://github.com/qbcore-redm-framework/qbr-inventory)
- [qbr-clothing](https://github.com/qbcore-redm-framework/qbr-clothing)

## Screenshots
![image](https://i.imgur.com/9yiQZDX.png)
![image](https://i.imgur.com/MRMWeqX.png)

## Installation
### Manual
- Download the script and put it in the `[qbr]` directory.
- Import `qbr-management.sql` in your database
- Edit config.lua with coords
- Restart Script / Server

## ATTENTION
### YOU NEED TO CREATE A COLUMN IN DATABASE WITH NAME OF SOCIETY IN BOSSMENU TABLE OR GANG IN GANGMENU TABLE IF YOU HAVE CUSTOMS JOBS / GANGS (UPDATE THY ARE IN THE SAME TABLE NOW)
![database](https://i.imgur.com/JZnEK4M.png)

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
