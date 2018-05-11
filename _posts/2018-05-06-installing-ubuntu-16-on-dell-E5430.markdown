---
layout: post
comments: true
title:  " Installing Ubuntu 16 and setting it up on Dell E5430"
date:    06-05-2018 08:39
categories: The Beginning
permalink: /:title.html
published: True
---

## Installing Ubuntu

[Install ubuntu using this link for instructions](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-desktop#5)

The whole installation overwrote a Windows 10 pro edition, which was slow AF for doing normal actions. 

A message inbetween pointed out that the installation would happen with UEFI. Basic search pointed out there might not be any difference on whethere it is UEFI or Bios installation.

Upon completion, it restarted to give me SquashF errors, just like I
have always observed some errors in my old PC. I didn't take any
picture. Switching off secure boot seems to have done the trick.

### Secure boot on

As we are Linux users we cannot really have completely "signed"
drivers for many of our hardware. This being the case, I guess (from
my reading online) that we should turn off secure boot.

Use F12 to go to menu upon reboot adn find your way to switch off
secure boot.

## Installing 3rd party softwares as necessary by UBUNTU	

During installation I had selected "install all 3rd party software"
Because of this secure boot switched on, I am not convinced it all happened smoothly.

So I did [this](https://askubuntu.com/questions/290293/how-can-i-install-the-third-party-software-option-after-ive-skipped-it-in-the), 

	sudo apt-get install ubuntu-restricted-extras

## Emacs installation	

Look at [this post](Emacs-introduction.html) by me for more info on emacs
and setting it up, but primarily:

	sudo add-apt-repository ppa:kelleyk/emacs
	sudo apt-get update
	sudo apt-get install emacs25

## Chrome 

Get chrome [here](https://askubuntu.com/questions/510056/how-to-install-google-chrome) (mainly due to legacy use and page translate). Reproduced for convinience:

	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

	sudo apt-get update 

	sudo apt-get install google-chrome-stable	

## Drive on laptop

Followed instructions as per [how to geek](https://www.howtogeek.com/196635/an-official-google-drive-for-linux-is-here-sort-of-maybe-this-is-all-well-ever-get/):

1. Install Gnome-control-centre
   
   sudo apt install gnome-control-center gnome-online-accounts

2. Settings-> online accounts -> Add Account-> Files (should be on for google)

One needs Gnome-control-centre; install it and manipulate it and see
how that goes!

## Internet speed on panel

Based on [Stack](https://askubuntu.com/questions/866990/system-monitor-how-to-display-net-speed-on-panel?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa), 
	
	sudo -i
	add-apt-repository ppa:nilarimogard/webupd8
	apt update && apt install indicator-netspeed

Run

	indicator-netspeed &
	
After this you never need to run it on a terminal, it will be on for
the rest of the time. One needs to jsut check out the options on the
panel bar before one sees the actual numbers.

## Chrome with Emacs shorcuts?

Based on [answer here](https://askubuntu.com/a/233539/443958) and if you have gtk3:

Switching on as follows,

	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

Switching off as follows,

	gsettings set org.gnome.desktop.interface gtk-key-theme "Default"

For convinience, paste this in your .bashrc_aliases file:

	alias on-chrome-emacs-binding='gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"'
	alias off-chrome-emacs-binding='gsettings set org.gnome.desktop.interface gtk-key-theme "Default"'


Make sure the following is present in the .bashrc file ([stack](https://askubuntu.com/a/17537/443958)):

	if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
	fi

Not all keybindings work, only cut and copy works, not so good! 


## Problems with the new/old Dell Latitude E 5430

Mouse pad seems to be less sensitive and there are regions where the
mousepad barely works.

Sleep time seems to be taking up a lot of battery. My hp g6 pavillion
can last a few days without turn off, but not this one. It doesn't
seem to last even a day.


## Boot time 

may6 2018- Dell Latitude E5430- 39 seconds until login screen-  74 s until terminal opens -
94 s until chrome opens - 1-2 s for gedit

may 10 2018 - HP Pavillion G6- 54 s - 86s terminal - 106s until chrome - 4s for gedit 

## Performace

Performance wise it is ok for sure. Things are fast enough. 
