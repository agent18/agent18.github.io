---
layout: post
comments: true
title:  " Installing Ubuntu 16 on Dell E5430"
date:    06-05-2018 08:39
categories: The Beginning
permalink: /:title.html
published: False
---

[Install ubuntu using this link for instructions](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-desktop#5)

The whole installation overwrote a Windows 10 pro edition, which was slow AF for doing normal actions. 

A message inbetween pointed out that the installation would happen with UEFI. Basic search pointed out there might not be any difference on whethere it is UEFI or Bios installation.

Upon completion, it restarted to give me SquashF errors, just like I have always observed some errors in my old PC. I didn't take any picture. 

**Secure boot off and then it seems to work pretty good.** No squash errors

One of the most peaceful boots I have seen in my home laptop usage

## Secure boot on

The imppression I get with all this UEFI, Secure boot and shit, was
that third-party softwares would not be installed/ or something wierd happens as a result. With Ubuntu, my life is with 3rd party softwares as we don't have "signed" drivers in many cases So, fuck secure boot is the impression I got.

Use F12 to go to menu upon reboot adn find your way to switch off secure boot.
## Upon reload

Get chrome [here](https://askubuntu.com/questions/510056/how-to-install-google-chrome) (mainly due to legacy use and page translate). Reproduced for convinience

	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

	sudo apt-get update 
	sudo apt-get install google-chrome-stable
	
	
## Installing 3rd party softwares as necessary by UBUNTU	

During installation I had selected "install all 3rd party software"
Because of this secure boot switched on, I am not convinced it all happened smoothly.

So I did [this](https://askubuntu.com/questions/290293/how-can-i-install-the-third-party-software-option-after-ive-skipped-it-in-the), 

	sudo apt-get install ubuntu-restricted-extras

## Update and restart to finish installing updates

## Problem tabs

Mouse pad seems to be less sensitive and regions with actual non-working mouse arrow


## Boot time 

may6 2018- 

## Performace

Seems fast. Windows key seems to work well as the apps are quickly shown. 


C-M-t works super fast. I am happy about the initial startup and of course with comparison to the shit that is my old laptop with ubunut and new laptop with windows 10. Get out of here.
