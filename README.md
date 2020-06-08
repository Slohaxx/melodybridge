Unitec Cloud Application and development ISCG7444
Semester one, 2020

This repository has been built to hold documents and guides on how to set this up and for code reference.

#MelodyBridge 

Melody Bridge has been created to give space online, for a small internet music community. The idea is to have an all in one place spot for the community to listen, share and communicate about music. We use Google Cloud Platform to host our services.

##Introduction

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

https://console.cloud.google.com/networking/firewalls

##Initial Server Configuration

Bryan Kennedy has written a guide from March 2013 that still holds strong today. Check it out fro a great walk through.
The next steps are based off his guide, a link is below
https://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers

Download https://github.com/Slohaxx/melodybridge/blob/master/Set_up.txt and follow the steps for Initial server set up 


