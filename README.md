Unitec Cloud Application and development ISCG7444
Semester one, 2020

This repository has been built to hold the source and guide to set up.

# MelodyBridge 

Melody Bridge has been created to give space online, for a small internet music community. The idea is to have an all in one spot for the community to listen, share and communicate about music. We use Google Cloud Platform to host our services.

## Introduction

To run this community we will use the GCP to launch an instance inside the compute engine.

The services needed will be:
  - User Account 
  - Remote access
  - Web Server
  - Icecast Server
  - InspIRCD Server
  - Liquidsoap
  
Once singed up to google cloud and loaded in the GCP console, select from the left menu 'Compute Engine, VM Instances' then create an instance. We updated the name and changed the drive settings. We loaded Ubuntu 16.04 LTS as the machines operating system an extended the hard drive to 50gb

Next step was to open the firewall of the VPC 'Virtual Private Cloud'. 

We open the following:
  - 22 SSH
  - 23 Telnet
  - 6667 IRC non ssl connection
  - 6697 IRC ssl connection
  - 8000 Icecast 
  - 8005 Live DJ port

You can find the firewall settings here, and create a new firewall rule with the above ports enabled. We also have to do this on the server later

-   [Google Cloud Firewall][1]


## Initial Server Configuration

Bryan Kennedy has written a guide from March 2013 that still holds strong today. Check it out fro a great walk through.
The next steps are based off his guide, a link is below

[First five mins on a server][2]


Download [Set_up.md][3] and follow the steps for Initial server set up 

## Dowload the project

Download melodybridge git

    cd ~
    git clone https://github.com/Slohaxx/melodybridge.git

## inspIRCD Server

Ispircd docs located [docs][4]

To install from source, find and download the latest version
** you can leave most options default when the configuration script runs at ./configure

    wget https://github.com/inspircd/inspircd/archive/v2.0.29.tar.gz
    tar xvf v2.0.29.tar.gz
    cd inspircd-2.0.29/
    sudo apt-get install gcc
    sudo apt-get install build-essential
    ./configure
    make
    make install

    cp ~/melodybridge/inspircd.conf /home/lolz/inspircd-2.0.29/run/conf/
    nano /home/lolz/inspircd-2.0.29/run/conf/inspircd.conf

Now update the melodybridge html file with new IRC server connection

    nano /home/lolz/melodybridge/html/index.html

## Icecast server

Install the dependincies

    sudo apt-get update
    sudo apt-get install libvorbis-dev
    sudo apt-get install libxslt-dev
    sudo apt-get install libogg
    sudo apt-get install pkg-config
    sudo apt-get install libcurl4-gnutls-dev

Download the latest release from icecast's official website. [Latest Version][5]

    wget http://downloads.xiph.org/releases/icecast/icecast-2.4.4.tar.gz
    tar xvf icecast-2.4.4.tar.gz
    cd icecast-2.4.4/
    ./configure
    make
    sudo make install

Edit icecast config file with user credentials and host IP address

    nano conf/icecast.xml

Create log directory and files

    mkdir log
    nano log/error.log
    nano log/access.log

Then to run icecast

    screen -S icecast

    icecast -c conf/icecast.xml

## liquidsoap

make new music directory 

    cd ~
    mkdir music
    mkdir music/jingles
    mkdir music/main

You will need to poulate these directories with music you wish to play over the stream. Remember to have to correct emergency mp3 file loaded in sad.liq. This track will play if something goes wrong. I name a track emergency.mp3 which is easily found among a playlist of music.

Install Liquidsoap, change logging ownership and edit sad.liq from the git with your server and credentials 

    sudo apt-get install liquidsoap
    sudo chown -R lolz /var/log/liquidsoap/
    nano melodybridge/sad.liq

Edit the stream and metadata outputs to this server IP

    nano /home/lolz/melodybridge/html/index.html

Open a screen session and run liquidsoap

    screen -S liquidsoap
    cd /home/lolz/melodybridge
    liquidsoap sad.liq

## Webserver

Install Apache2

    sudo apt-get install apache2

remove the default html directory of apache and move melodybridge to /var/www/html

    sudo rm -rf /var/www/html/
    sudo mv /home/lolz/melodybridge/html/ /var/www/

    sudo service apache2 restart










[1]:https://console.cloud.google.com/networking/firewalls
[2]:https://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers
[3]:https://github.com/Slohaxx/melodybridge/blob/master/Set_up.md
[4]:https://docs.inspircd.org/
[5]:https://icecast.org/download/
