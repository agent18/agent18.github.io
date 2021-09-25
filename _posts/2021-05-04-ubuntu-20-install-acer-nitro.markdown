---
layout: post
comments: true
title:  "Documentation of setting up my ubuntu 20 in 2021"
date: 04-05-2021
categories: notes
tags: gaming
permalink: /:title.html
published: true
---

## Current config

**Acer Nitro 5 laptop**
- Acer Nitro 5 AN515-51-5048 - Gaming Laptop - 15.6 inch
- NVIDIA GeForce GTX 1050 (4096MB)
- Initially 8gb ram, but currently 24gb (23.4)
- Interl core i5
- DDR4 soddimm
- 1000 gb HDD
- 128 gb SSD
## things to do before starting

1. take backup of stuff (done tboa)
2. upload everything to github (done)
	- init file for emacs (done)
	-  blog (done)
	- CV related shizz (done, made a backup on drive but also have on git)
	- stray files (taken care off as much as possible)
	- desktop files need to be reviewed (reviewed including downloids)
	- fastblog (all uptodate)
	- and other tkravi blog (all uptodate)
3. understand memory management and understand how to extend the memory (doneish)
4.  I will keep 500gb and possibility to extend with the new config...
5. Make ubuntu 20 copy and let's go?
6. remove call of duty from windows... (not necessary)
7. Measure current boot time. (done)

## Customizations I need to keep track of

- Numpad as keys
	- keyboard shortcuts --> Navigation --> Shift workspace to left --> keypad up
- .bash aliases for different things (saved to github)
- alt-N to move thigns from one screen to the other (use compiz config manager settings)
- hpmor customizations... done
- keys etc... done
- anaconda config? Skipped have instructions to install.

## apps I want

- okular
- document viewer
- emacs with R and pythiath capabilities
- anaconda
- chroath & firefox
- maybe (hamster indicator)
- spotify

## goals

This time I want more battery
This time I want a faster boot time (NOT @ mins)
Measure current boot time
fix lan connection issues (doesn't seem to exist)
github issues with authentication to be fixed

## re-installation projess 

1. According to [here](https://www.howtogeek.com/141818/how-to-uninstall-a-linux-dual-boot-system-from-your-computer/)   and [here](https://askubuntu.com/a/727130/443958), it is suggested to delete the partition from windows disk management. Partitions to be deleted have "NO" `FileSystem`
2. checked what boot mode I have and made sure `secure mode` is disabled. [here](https://itsfoss.com/disable-secure-boot-windows/)
3. Went to windows to reduce partition
Now have windows files followed by unallocated followed by ubuntu
4. checking in install if the unallocated objects are seen?
5. installed regularly with swap root and home partitions, and installation worked out of th e box... Really wierd.

## adding unity

Based on [linuxbabe article](https://www.linuxbabe.com/ubuntu/install-unity-desktop-environment-ubuntu-20-04)
Really having wierd vibes with gnome. Need to install something to tune it... Even workspaces are not available off the bat. Am happy with unity. It's ok.

	sudo apt update
	sudo apt install ubuntu-unity-desktop

Select `lightdm` and ok.

	sudo shutdown -r now
Adding tweak tool

	sudo apt install unity-tweak-tool

Check available desktops
	
	ls -l /usr/share/xsessions/

Remove gnome

	sudo apt remove gnome-shell

and check available desktops again

## remove indicator messages (mail icon on top panel)

	sudo apt-get remove indicator-messages

## chrome

[link](https://linuxconfig.org/how-to-install-google-chrome-web-browser-on-ubuntu-20-04-focal-fossa)

sudo apt install gdebi-core wget  
wget
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  
sudo gdebi google-chrome-stable_current_amd64.deb  



## Graphics card

All installed automatically and `nvidia-smi` works spot on.


### Second screen suddenly stops working Monitor after restart

I think some updates happen and shit goes to hell. For ubuntu20, I
never did anything to begin with but worked straight out of the bat. I
have faced this thing before.

Checked `Software updates` and that seemd to be using xorg. So first
red flag and the second red flag was that `nvidia-smi` wouldn't work.

+ there were some issues with my upgrade or something. I needed to
  partial upgrade, said ok to everything. 
  
+ on top of it `sudo apt-get update`, `sudo apt-get upgrade`.

+ Check out what is latest launchpad driver available (470 was
  available but went with 460, as I think that is what I was using
  before.
  
+ So, `dpkg --get-selections | grep nvidia`, `sudo apt-get purge
  nvidia*` and then went to `Software-updater` and then clicked on
  `460` in `additional drivers`. 
  
+ Restart and finally open the display settings and switch new monitor
  on and `keep changes` I think.

## indicator on taskbar system monitor

https://askubuntu.com/a/907807/443958

	sudo apt install indicator-multiload
	
	
	
## workspaces

Appearnaces--> enable workspaces, toggle hiding of side bar, add desktop icon

That was it... Gnome had this whole shabang of shit... Now for the last part with compiz manager

## move window from one screen to another

Shift-Alt-N is the shortcut we would like... Do the following:

	sudo apt-get install compizconfig-settings-manager
	sudo apt-get install compiz-plugins

Go to Put, tick the check box and set the shortcut for `put-to-next-output`.

## ubuntu media codecs

Not sure why it is required, but installing it as per [here](https://www.youtube.com/watch?v=GrI5c9PXS5k&list=WL&index=3&t=226s).

	sudo apt install ubuntu-restricted-extras

## add github accounts

1. myblock

```
sudo apt-get install git

git clone https://github.com/agent18/agent18.github.io.git myblock

git add -A

git commit -m "empty testing git on new pc"

git config user.email "agent18@github.io"

git config user.name "agent18"

git commit -m "empty testing git on new pc"

git push
```

2. fastblock
3. cvblock
4. emacs init
5. 

**Emacs init**

Folder already has something after installation of emacs. So we can't just do `git clone https://github.com/agent18/emacs-config.git`.

According to [here](https://stackoverflow.com/a/16712245/5986651), the following were needed:

	git init
	git remote add origin https://github.com/agent18/emacs-config.git
	git pull origin master
	git config user.email "thetj09@gmail.com"
	git config user.name "agent18"
	git push --set-upstream origin master

Now need to setup the permanent PAT as follows: only one command as the other aspects are done earlier.

	git config credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

## fastblock

1. Create PAT 

2. clone and test connection

3. fix github modified time issues

3. use PAT using credential helper

4. add gcm core as shown below

5. get it to work?

Instructions are [here](https://github.com/fastai/fastpages/blob/master/_fastpages_docs/DEVELOPMENT.md).

6. install docker as per [here](https://docs.docker.com/engine/install/ubuntu/)

7. Install docker compose as per [here](https://docs.docker.com/compose/install/)

7. sudo make server (takes a full 5 mins) to run...
   

### write to git

How to store multiple PATs/passwords for use by git?

I wanted to store my credentials "safely" so I did as instructed
[here](https://askubuntu.com/a/959662/443958). This way I don't have to input password/PAT every single
time.

1. Install `libsecret` using `sudo apt-get install libsecret-1-0
   libsecret-1-dev`
   
2. Build the "credential manager" using `sudo make
   --directory=/usr/share/doc/git/contrib/credential/libsecret`
   
3. and then configure my local git folder using `git config --global credential.helper \
   /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret` 
   
Works superb.
   
What I don't get is **how to do the same for many passwords** associated
with different accounts/repositories. I was suggested to use gcm core

I tried installing `gcm core` as instructed [here](https://github.com/microsoft/Git-Credential-Manager-Core).

1. Download .deb package

2. `sudo dpkg -i <path-to-package>
git-credential-manager-core configure`

3. configure the "credential store" `git config
   credential.credentialStore secretservice` (as I use libsecret).
   
4. I removed the `Credential helper` pointing to
   `/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret`
   from the local git config file.


   
It still doesn't work. When I try to push a repo, I get a garbled
message with how to use `git config` followed by request to fill in
credentials (shown [here](https://pastebin.com/K1Lqt7tX)).  I don't understand what I am doing? namely
`credential store`, `credential manager`, and `gcm core`.

I looked [here](https://stackoverflow.com/a/40312117/5986651) and [here](https://stackoverflow.com/a/51505417/5986651) and I still don't get it.

## latex installation to work with auctex

I have some instructions on my site. Teh init file is set, so no changes there... Need to install other packages I think..

Started and found that latexmk was missing.

	sudo apt-get install latexmk
Now xetex is missing

	sudo apt-get install texlive-fonts-extra

	sudo apt-get install texlive-latex-recommended
	sudo apt-get install texlive-xetex

This is it... Generates the pdf required. :)

## okular

sudo apt install okular

## fixing issues with github modified-time

When you clone, all the modified times are missing as it is not recorded in git. The way around is to use some script to match modified times with commit time (which is somewhat good enough.

we start [here](https://stackoverflow.com/a/21735986/5986651) which has 2 solutions which is pointed to. We choose [this one](https://stackoverflow.com/a/13284229/5986651). 

**check pre-reqs**
[Pre-reqs](https://github.com/MestreLion/git-tools#install)

Need badh, python3, git

**install and run**

	sudo apt install git-restore-mtime
	git restore-mtime --test
	git restore-mtime #works in the folder you are in and other sub folders (GREAT)
	
Currently at 66mb and now about to test and then `jekyll serve` Let's go... Now it is 69.4mb

cvblock at 696.8 before doing nythin... 

## github tackling the deprecation notice

> Hi @agent18,      You recently used a password to access the
> repository at agent18/[agent18.github.io](http://agent18.github.io/)
> with git using git/[2.7.4.](http://2.7.0.4/)      Basic authentication
> using a password to Git is deprecated and will soon no longer work.
> Visit
> [https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)
> for more information around suggested workarounds and removal dates.  
> Thanks,   The GitHub Team

1. Create a token from github: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token
2. Copy your token : deleted...
3. How to save the password and use it when I want?
4. Can I do it for different accounts?
5. Most useful answer: http://gmacario.github.io/2017/08/08/cmdline-git-with-github-2fa.html

I currently use `git config credential.helper cache` to save the credential briefly

Securely saving the password with libsecret... 

1. https://askubuntu.com/a/959662/443958

**Tested on** Ubuntu 20.04, almost fresh install, with Git 2.25.1 and unity 7.5.

**Authentication basics**

Github needs an authentication key (with certain rights tied to authentication key). In theory others can contribute to your repo with just an auth key. A particular auth key has certain rights, (read private repos, read write public repos etc...).

**Personal Access Token**

1. We start with making a [PAT](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token). I.E., Settings --> Developer Settings--> Persaonl access tokens --> Generate new token --> Note --> set permissions (repo,repo_hook maybe) --> generate token
2. `git push` the repo and type the generated token(very long password) as password when asked.

**Storing the password in different ways**

3.  - Can be done in a file and then using `xclip` to bring it back to clipboard and paste it everytime (Screw this)
	- Cache with the [help of git commands][1] `git config credential.helper cache <time-limit-of-cache>`. But you still have to somehow clipboard the password after the timelimit.
	- Store it permanently in a file [with git commands][1] `git config credential.helper store` (don't use --global). This is NOT ENCRYPTED. You can open the file and read it. (e.g., If someone gets access to your laptop they can pretty much read the Password using a bootable USB (assuming your whole system is not encrypted)). 
	- Or go the encryption route as per [here](https://askubuntu.com/a/959662/443958). It is not complicated at all. 3 simple steps.

```
sudo apt-get install libsecret-1-0 libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
    
git config credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```
This allows to store the pw in an encrypted format. The `git config` file can be found in the `.git/config` file in your loca repo as shown [here](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Where-system-global-and-local-Windows-Git-config-files-are-saved), if you ever need it.

P.S.
There are many places that suggest the use of [Gnome-keyring](https://blog.scottlowe.org/2016/11/21/gnome-keyring-git-credential-helper/) but that is apparently [deprecated](https://askubuntu.com/a/959662/443958).
Also answered the above [here](https://stackoverflow.com/a/67360592/5986651)


**Storing passwords/PATs for more than one account**

This becomes tricky and it appears as @VonC suggests that we need a `Git-Credential-Manager core` (GCM core). This answer is enhanced based on my findings in [this answer][2].

1. First [install GCM core][3]

   1. Download [latest .deb package](https://github.com/microsoft/Git-Credential-Manager-Core/releases/tag/v2.0.394-beta)
   2. `sudo dpkg -i <path-to-package>`
   3. `git-credential-manager-core configure`
   4. `git config --global credential.credentialStore secretservice` as we use `libsecret`

2. Get latest git

	In my case I had git 2.25 and got error `error: unknown option
   'show-scope'`. It appears that GCM core is using higher git
   (atleast 2.26).
   
   So install the latest and greatest `git` as per [here](http://lifeonubuntu.com/upgrading-ubuntu-to-use-the-latest-git-version/):
   
	   
		sudo add-apt-repository ppa:git-core/ppa
		sudo apt-get update
		apt list git # shows the latest git currently 2.31
		sudo apt-get install git #or sudo apt-get upgrade
   
   
3. Update git remote path with username built in

	GCM core needs this to identify the different accounts.:(

		git remote set-url origin https://user1@github.com/user1/myRepo1.git
		git remote set-url origin https://user2@github.com/user1/myRepo1.git
                                      ^^^^^

 Your `~/.gitconfig` file will thus have the following :
 
 ```
 [credential]
	helper = /usr/bin/git-credential-manager-core
	credentialStore = secretservice
[credential "https://dev.azure.com"]
	useHttpPath = true
 ```
 

## installing jekyll


**Ruby 101** https://jekyllrb.com/docs/ruby-101/#gems

Ruby is a programming language. Gems are code you include in ruby projects, Something like packages. Jekyll is a Ruby Gem. Many Jekyll plugins are also gems.

Gemfile is a list of gems used by your site. `gem` is the "package manage" to install different gems (pacakges such as jekyll and bundler)

Bundler is a gem that installs all gems in your Gemfile in the local folder.

Bundler is even more powerful with it's "environment" type of behavior (seen in `conda`). `bundle install` installs the gems specific to `GEMFILE.lock` file in your local folder. And to invoke those installed "gems", all you need to do is prefix `bundle exec` in front of that command. 

	bundle exec jekyll serve

If you don't have a gemfile here. Then just go for `jekyll serve`

rbenv and RVM both help decide which ruby to select. They are both ruby version managers. RVM however modifes some basic functions and "might cause some issues" as suggested [here in reddit](https://www.reddit.com/r/rails/comments/f009mb/there_are_two_ruby_version_manager_rvm_vs_rbenv/)

**check pre-requisites**

ruby and gem already exist with the right versions. Look [here](https://jekyllrb.com/docs/installation/)

	ruby -v # needs to be greater than 2.4.0
	gem -v
	gcc -v
	g++ -v
	make -v

**install jekyll and bundler**

	gem install jekyll bundler
Maybe start with it one by one.

**errors for bundler I think**

    ERROR:  While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /var/lib/gems/2.7.0 directory.

It seems like `sudo gem install jekyll bundler` helps out on this.

	gem info bundler

seems to show that bundler is installed.

**Errors for Jekyll**

    ERROR:  Error installing jekyll:
	ERROR: Failed to build gem native extension.

    current directory: /var/lib/gems/2.7.0/gems/eventmachine-1.2.7/ext
    /usr/bin/ruby2.7 -I /usr/lib/ruby/2.7.0 -r ./siteconf20210502-70458-175i32k.rb extconf.rb
    mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h
    
    You might have to install separate package for the ruby development
    environment, ruby-dev or ruby-devel for example.
    
    extconf failed, exit code 1

Looks different to issue I had in 2016. The "header" files are said to be missing and usually `dev` files have such information and found something similar in [this answer](https://stackoverflow.com/a/11699715/5986651).

	sudo apt-get install ruby-dev
	sudo gem install jekyll

Check if there are packages using `dpkg -l | grep ruby-dev`

DONE, works well. :)

## emacs installation

GNU.org says latest version is: 27.2. Kellyk says 28.0.50 (dev version). but 26.3 on focal.

Current repositories say that the latest version is 

1. [Instructions to compile latest version](https://www.gnu.org/software/emacs/manual/html_node/efaq/Installing-Emacs.html)
2. Instructions to install after adding ppa is given [here](https://linuxways.net/ubuntu/how-to-install-emacs-editor-in-ubuntu-20-04/)
	
	sudo add-apt-repository ppa:kelleyk/emacs
	sudo apt-get update
	apt list emacs*
	sudo apt install emacs27 # as 27 is a stable release and dev is happening in 28.

Once I cloned the repo to the `.emacs.d` folder and opened emacs, then I got several errors saying `auctex-` was missing. This didn't make sense.  Also when I was looking up `package-list-packages` I got that `marmalade-repo` certificate is out of order. Looked it up online and that seemed to be the issue. commenting the marmalade repo off was enough. Everything I setup up such as wordcount-mode time winner and ibuffer seem to work, without me doing absolutely anything. Which is Fucking Amazing. As I have jumped from emacs 25 to 27 and ubuntu 16 to 20. :) inshaller inshaller.

Need to tell emacs which abbrev-mode file to choose. Working on it.

[Here is info](https://www.gnu.org/software/emacs/manual/html_node/elisp/Abbrev-Files.html) on how abbrev-mode file works. So the way I have set it up is correct. All I needed to do is restart. Great! :)

Not sure about latex and python. But that is for another day, when I need to do it. But maybe I should already set it up to that point... Cause when I need it I might not have time.

setup the cv block and add latex setup and see what all I need to dag... inshallah


## battery management

Fresh install currently gives 100% to 50% in 45 mins.

Look at tlp stuff.

also add preload

## why is my ubuntu slow

could be otherthings like verbose mode maybe, hte "clean" command that comes after or look at `systemd-analyze blame`

## timing of current ubuntu 16.04 [20.04 fresh] [unity] [[unity clean]]

Power on to grub --> 11s  [4.5s] [4.5s] [[4.5s]]
Power on to password screen --> 80s (1.5mins) [58s] [80s][[60s]]
Power on to loading computer before seeing iconds --> 163s (2.5mins) [80s] [102s][[80s]]
Power on to chrome loading and showing first page --> 220s (3.5mins)  [94s] [128s] [[115s]]


## Creating a bootable usb drive in ubuntu

[Link to create bootable usb drive](https://ubuntu.com/tutorials/create-a-usb-stick-on-ubuntu#3-launch-startup-disk-creator)
1. open startup diskcreator and just follow instructions.
2. There is not really anything you can change or make mistakes with.

**Above method doesnt work, Use Disks instead**

> Startup Disk Creator is known to having issues. Use the  **Disks**  tool to create the Ubuntu USB installation medium. Open  **Disks**  and select the USB drive (on the left) to be used as medium.
> Then select  **Restore Disk Image**  from the menu on the top right of the application. Choose the  
> Ubuntu installation  **ISO file**  - check if the USB drive to write it to is correct and  **Start restoring**.---[using disks to make image](https://askubuntu.com/a/711621/443958)

I had to format the device first in `Disks` before I went forward with making the bootable disk. It has 3 partitions for some reason, one is the bootable part, one is the empty part and the other is the *4mb of ubuntu 20 EFI FAT version*

## understanding ubuntu partitions and my current partitions
[Understanding linux partitions link](https://linuxbsdos.com/2014/11/08/a-beginners-guide-to-disks-and-disk-partitions-in-linux/#:~:text=The%20first%20hard%20drive%20detected,the%20installer%20%E2%80%93%20sda%20and%20sdb.)

**Naming convention**
We often see **Sda**, sda2, sdb etc... What this stands for is the number of disks on your system. In my current system I have a 128 gb SSD and 1000GB HDD.

This means I have `sda` and `sdb`, i.e., `Disk0` and `Disk1` in windows.

**Partitioning**

There are two partition table standards – MBR (Master Boot Record) and GPT (GUID Partition Table). MBR, also know as **ms-dos**, is what you might call the first standard.

1. Do `sudo fdisk -l` to find out the `DiskLabel` to be GPT or MBR. New computers with windows 8 onwards usually have GPT partitioning.

2. You can also tell whether GPT or MBR is in use by accessing the UEFI setup utility. Under the **Boot** menu, look for **PCI ROM Priority**. You should see two options – **EFI Compatible ROM** and **Legacy ROM**. The latter indicates MBR.

**Current Split**
	
	sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
or 
		
	df  -h

HDD 1kGb
sdb             931,5G                              
├─sdb4 ext4     111,8G /home                        
├─sdb2 swap      14,9G [SWAP]                       
├─sdb3 ext4      23,3G /                            
└─sdb1 ntfs     581,5G /media/eghx/Data             Data    (windows dater

SSD 128 Gb
sda             119,2G                              
├─sda4 ntfs         1G                              Recovery
├─sda2             16M                              
├─sda3 ntfs     118,1G /media/eghx/Acer             Acer  Program files
└─sda1 vfat       100M /boot/efi                    ESP

```
eghx@eghx-nitro:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb3        23G   19G  3,3G  85% /
...
/dev/sda1        96M   54M   43M  57% /boot/efi
/dev/sdb4       110G   75G   30G  72% /home
...
/dev/sda3       119G   73G   46G  62% /media/eghx/Acer
/dev/sdb1       582G   99G  483G  17% /media/eghx/Data

```





## disk partition Steps

based on: [link 1](https://askubuntu.com/questions/871825/add-more-disk-space-for-linux-from-windows-in-a-dual-bootable-machine), [link 2](https://askubuntu.com/questions/727112/give-more-hard-disk-space-to-ubuntu?rq=1). link 2 has many links to solve
issues for you.

>if you care about windows then do it in windows management, if you don't care then you can manage windows partition from gparted itself.

1. go to windows "Disk Management" and then look at the large
   partition that you wanna split and then unallocate it.
   
2. Make a live USB of Ubuntu so that you can manipulate Ubuntu. Follow
   [these instructions](https://ubuntu.com/tutorials/create-a-usb-stick-on-ubuntu#1-overview) word-for-word and that is good enough.

3. Make Back up in your original Ubuntu on your Google Drive. Just the
   important stuff
   
4. Restart! and Boot live USB stick using F12 for ACER. Sometimes this
   might not work, in which case you need to go to the system menu
   somehow (available in the grub boot menu) and change there in
   "Main" to enable "F12 boot".
   
5. F12

6. Open live USB and go to "Gparted".

7. Move as per requirements. Here is a [nice tutorial](https://www.howtogeek.com/114503/how-to-resize-your-ubuntu-partitions/) from
   "how-to-geek"
   
8. If unallocated part is not next to the part you want to expand,
   this then involves moving all the partitions so that the
   unallocated is next. This has the "Warning-danger" message even for
   "moving" a partition. Do AT YOUR OWN RISK.


### Caveats

- "Unallocated" needs to be close to the partition you are interested
  in. 
  
- Moving partitions is as "dangerous sounding" as re-sizing
  partitions. In my case I had to move partitions so that the
  unallocated space came in the end... But this is not worth the
  FAILURE if it does happen now... 
  
  I will cross the bridge when the time comes. I am confident about
  reinstalling. I mainly need emacs for now and everything related to
  that is on the cloud, like my blog and the init settings. So I
  should be gucci.
  
  



## UEFI and legacy bios before installing, secure boot shit?, windows fast start up

> Secure boot forces both Windows and Ubuntu to require that all system
> level drivers are "signed", proving that they approved as authentic
> software. The idea is fairly good, and on Windows, Microsoft signs
> most of the drivers. --- [askubuntu](https://askubuntu.com/a/843678)

So they say it's no big deal, just disable secure boot.

Current settings in my system having installed 16 already is: 
Boot mode: UEFI
Secure Boot: Disabled

As of Apr 2021, `It's foss` continues to recommend to disable `secure boot` [here](https://itsfoss.com/disable-secure-boot-windows/)

## Partitions needed research

> Generally speaking, unless you're dealing with encryption, or RAID,
> you don't need a separate /boot partition.
> 
> That said, I  _occasionally_  find a use for adding a separate /boot
> partition as a FAT partition. This allows your dual-boot system to
> make alterations to your GRUB config, so you can create a batch file
> to shut down windows and alter the default menu choice so that it
> boots something else next. Most people don't need this, but I've had a
> few projects which required switching back and forth, and it allows it
> to be done entirely by script. ---[ling](https://askubuntu.com/a/47793)

[This guy](https://fossbytes.com/install-ubuntu-20-04-with-windows-10-dual-boot/) suggests to have root, home and swap.
In my old installation I also do have root (ext4), home (ext4) and swap (swap)...

[askubuntu 2013 answer](https://askubuntu.com/a/343370) suggests that root home and swap are enough and to choose already existing bootloader device  (sda or sdb and not just the partitions)

Order: Swap root home in one example and root swap home in another seems to be ok. swap root home is the askubuntu answer, and we stick to it.

Choosing primary or logical partition doesn't seem to matter for UEFI + GPT


