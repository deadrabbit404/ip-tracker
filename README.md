# iptracker
Created by: [deadrabbit404](https://github.com/deadrabbit404)
## Description
A tool to track and gather ip address information and geolocation

![image](https://raw.githubusercontent.com/deadrabbit404/ip-tracker/main/images/iptracker.png)

## Features
iptracker will gather and display the following ip address information:
* IP Address
* Country
* Region
* City
* Latitude
* Longitude
* ISP
* ASN
* Country Code
* Calling Code
* Currency
* Timezone

## Requirements:
* git
* curl

**Note:** If you're using termux, you can install git and curl by typing:
```
apt update && apt install -y git curl
```
## Download and Install
Open a terminal (or termux if on android) and type the commands below.
* `git clone https://github.com/deadrabbit404/ip-tracker.git`
*  `cd ip-tracker`
* ` bash setup.sh`

**Note:** setup.sh will also integrate iptracker to t-ui launcher if it is installed on your device. This will create two aliases:
* `myip` - will track your own ip address
* `iptrack` - will track a given ip address specied via argument

## How to run
**Option 1: Via terminal/termux**  

You can execute the script on a terminal and it will run in interactive mode (menu driven). Just type `iptracker`.

![screenshot](https://raw.githubusercontent.com/deadrabbit404/ip-tracker/main/images/iptracker_termux.png)

**Option 2: Via t-ui launcher**  

On t-ui launcher, there are two aliases created: `myip` and i`ptrack`. Type `myip` - to track your own ip. Type `iptrack ip_address` - to track a different ip.  
Example: `iptrack 8.8.4.4`

![screenshot](https://raw.githubusercontent.com/deadrabbit404/ip-tracker/main/images/iptrack_tui.jpg)

