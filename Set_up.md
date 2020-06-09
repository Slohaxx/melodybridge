Enter the VM instaces page from google cloud - https://console.cloud.google.com/compute/instances

Launch SSH with the newly created VM instance, it will open a new terminal with access to the machine.

For ease of access, we will set up SSH access with a new user to remote from putty.

If you dont have putty, it's available here; https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

Become Root user and then give root a complex password. you can use https://passwordsgenerator.net/ 

      sudo su
      passwd 
      Password example: ^5Ha8z_MeM.-a^j"

Create a new user and password and give user bash shell. Also with visudo we give the user sudo permissions 

      useradd lolz
      passwd lolz
      [enter password]
      [confirm paasword

      chsh -s /bin/bash lolz
      visudo

Add the new user under Root
      lolz ALL=(ALL:ALL) ALL

Now edit the SSH config file to allow for password authentication. Find option PasswordAuthentication to yes on line 52
nano ssh /etc/ssh/sshd_config
      service ssh restart

Find your IP Address then connect with the new user on putty
      curl icanhazip.com
      104.155.171.240

once connected we continue the set up. Update and upgrade the machine

      sudo apt-get update
      sudo apt-get upgrade

Create user the user directories, and one for our ssh keys

      sudo mkdir /home/lolz
      sudo mkdir /home/lolz/.ssh
      sudo chmod 700 /home/lolz/.ssh

Install Fail2ban. Fail2ban is a daemon that monitors login attempts to a server and blocks suspicious activity as it occurs. It’s well configured out of the box.

      sudo apt-get install fail2ban

Require public key authentication

Run Puttygen and generate a new key. Once generated copy the public key and paste it in the below text file. This is where our public key will be help and matched publically with our private key. It needs to be formatted in a specific way, so its best to directly copy then paste into text file, save and exit. Save the private key, as that will be needed to use with putty when logging in

      sudo nano /home/lolz/.ssh/authorized_keys

      sudo chmod 600 /home/lolz/.ssh/authorized_keys
      sudo chown lolz:lolz /home/lolz -R

Test The New User & Enable Sudo. Enter lolz as auto login and the private key in the auth tab of putty

Now test your new account logging into your new server with the lolz user (keep the terminal window with the root login open). 

Lock Down SSH

Configure ssh to prevent password & root logins and lock ssh to particular IPs:

      sudo nano /etc/ssh/sshd_config

Add these lines to the file, inserting the ip address from where you will be connecting:

      LoginGraceTime 10
      PermitRootLogin no
      PasswordAuthentication no

Now restart ssh:

      service ssh restart

Set Up A Firewall

No secure server is complete without a firewall. Ubuntu provides ufw, which makes firewall management easy. Run:

      sudo ufw allow 22
      sudo ufw allow 23
      sudo ufw allow 80
      sudo ufw allow 443
      sudo ufw allow 6667
      sudo ufw allow 6697
      sudo ufw allow 8000
      sudo ufw allow 8005
      sudo ufw enable

Thats it, for now. A very basic set up. 

We now have a new user and ssh key access with other access being denied. 
