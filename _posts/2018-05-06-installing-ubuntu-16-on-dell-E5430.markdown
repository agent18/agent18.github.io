---
layout: post
comments: true
title:  " Installing Ubuntu 16 and setting it up on Dell E5430"
date:    06-05-2018 08:39
categories: drafts
permalink: /:title.html

---


## installing ubuntu dual boot windows 10

[seems like a nice video for following](https://www.youtube.com/watch?v=qNeJvujdB-0&t=183s); also following [random page](https://itsfoss.com/install-ubuntu-1404-dual-boot-mode-windows-8-81-uefi/)

PC on time starts at 16;58 rea; time!

[how to di install a pre-installed
windows with wifi](https://askubuntu.com/questions/221835/how-do-i-install-ubuntu-alongside-a-pre-installed-windows-with-uefi?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa) ask ubuntu page!

Secure boot UeFI Fast boot; current system runs on UEFI mode-->
MSinfo32 on run gives the info....

Space > 20 gb

Windows ont shutdown in 'fast-startupmode' (basically hibernation!)

Dont understand "if installing on gpt type partition and you need to
leave UEFI enabled"?

--> powershell--> Confirm-SecureBootUEFI

true imples secure boot is there and enabled!

current boot mode is UEFI, need to boot ubuntu in UEFI, and only
disable secure boot.....  [boot mode should match](https://help.ubuntu.com/community/UEFI)

secure boot is avoid malware to use the boot loader

UEFI is an alternative to BIOS that can support larger systems and is
hence somehow prefered by microsoft


Suggestions based on uefi ubuntu page and ask ubuntu page

Keep secure boot on UEFI on fast boot swtiched off  and try ubuntu first, if good, then install, if
still not good, then try boot repair

We might need to create some space for EFI''''' might!

Getting grub and repairing the boot will be seen later or dealt with
later!

now to tht real installation?
#### Partitioning 

for now i allowcate 150gb, if needed later, i will refer to [this](https://askubuntu.com/a/812653/443958)
and follow the instructions to increase the size of the partition as
and when required.

#### disable fast startup

control panel--> power options-->choose what buttons do--> change
unavilable settings--> turn off fast boot--> save changes

#### disable secure boot?
F2
[set password in bios to change secure boot](https://itsfoss.com/disable-secure-boot-in-acer/)
now disable boot

#### Try ubuntu 

unable to diable intel srt tech, as it is not there --> suggested by
uefi page

Based on [the video](https://www.youtube.com/watch?v=qNeJvujdB-0&t=183s)
	`check disck for errors defects`

one error found! no help online,, might be due to graphics drivers!
might be realted to squashfs (previously seen as a problem with secure
boot) 

moving further anyway then

first try --> didn't work; black screen 

second try based on updating to [nomodeset](https://askubuntu.com/questions/832163/black-screen-when-loading-ubuntu-live-usb/832173?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)

	e to edit grub
	replace `quiet splash` by `nomodeset`
	
This is done as some hardware might have issues.

ubuntu looks good so far!

Checked if partition was GPT or mBr, looks like uefi and gpt go hand
in hand, but i checked it using [the link shown](http://www.thpc.info/how/gpt_or_mbr.html)

>The 4-partition limit no longer exists with disks that use the GUID
>Partition Table (GPT). GPT supports up to 128 partitions by default
>and does not include the concepts of primary, extended, or logical
>partitions (although many tools refer to all GPT partitions as
>"primary partitions," simply because those tools were written with
>the older MBR system in mind). [-askubuntu](https://askubuntu.com/questions/149821/my-disk-already-has-4-primary-partitions-how-can-i-install-ubuntu?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)


--------------------

- partitions of the free space
	- swap 2x ram 16gb (swap)
  - root 25gb ext4 journouling system (/)
  - home 120gb ext4 journouling system /(home)
  
---- 

#### Installation complete

restart now hangs -- could be the graphics? lets wait and see

hard reset

#### Grub not showing

changed somehting in the bootorder to `windows boot manager` and it
went stright to grub.. need to check if I can make this better

#### ubuntu booting

hangs with quiet splash

takes way too long with  nomodeset, don't know why?

it boots into ubuntu, 

takes so much time before 


#### Nvidia stuff

[Possible Nvidia support ](https://github.com/rdjondo/TensorFlowGPUonUbuntu/wiki/Installing-Ubuntu-16.04-LTS-in-Dual-Boot-with-NVIDIA-GPU-support) for system with dual boot, suggesting
removal of secure boot

[Latest Long Lived Branch version for Linux x86_64/AMD64/EM64T,](https://gist.github.com/wangruohui/df039f0dc434d6486f5d4d098aa52d07) to
be used!

[installation guide 1](http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux)

sudo apt-get install nvidia-390

cehecked 390 support for 1050 and moving on. restart

testing if system works without nomodeset
System works,seems to take less time than before 

login screen -33s from selection 
screen- 47
mozilla - 61s



Much better than old systems i have used, but still! the fact the
windows boots to login in <10s is painful.

[Possible Nvidia support ](https://github.com/rdjondo/TensorFlowGPUonUbuntu/wiki/Installing-Ubuntu-16.04-LTS-in-Dual-Boot-with-NVIDIA-GPU-support) says to try 

	nvidia-settings

to open the settings menu as a check as well


different display settings open up finally to allow to use the
different resolutions!


[this askubuntu post](https://askubuntu.com/questions/760934/graphics-issues-after-while-installing-ubuntu-16-04-16-10-with-nvidia-graphics) covers basics of graphics and not
	particulars, refer to the above for details succh as which and
	what!
	
#### boot time slow

No problem with UUID [UUID check with /etc/fstab](https://askubuntu.com/questions/760694/really-slow-boot-on-16-04?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)

checking out DE, Xorg to see if it might have anything to do with it
followed by `system-analyze-blame`


removed network waiting (14s)

login screen -33s from selection 
screen- 43
chrome - 61s
---------------------------------------------------------

aspci vishnu said something

and also sleep is taking a long time, check it with using the nvidia swtichoffer!
## Installing Ubuntu overwriting windows 10

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
