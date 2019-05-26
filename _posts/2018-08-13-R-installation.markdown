---
layout: post
comments: true
title:  "R installation and setup (Linux and Emacs)"
date:    13-08-2018 08:39
categories: notes
permalink: /:title.html
published: True
---

## Uninstalling R

Lets start here.

	$ R
	> .libPaths() 

Delete these folders that you see as output,


	sudo apt-get remove r-base-core
	sudo apt-get remove r-base
	sudo apt-get autoremove

[Source](https://stackoverflow.com/questions/24118558/complete-remove-and-reinstall-r-including-all-packages)

	sudo apt-get purge r-base
	sudo apt-get purge r-base-dev
	sudo apt-get purge r-base-core
	sudo apt-get purge r-base-recommended
	
[Source](https://askubuntu.com/questions/423644/re-install-r-in-ubuntu)
	
Just found this somewhere, not sure if this is needed. But I did it.

## Installing R 3.5 for Ubuntu 16.10

	sudo apt-get install r-base
	
This installs R version 3.2.3. But the latest version is 3.5. But it
appears as of jun 10 that [problematic (stack answer)](https://askubuntu.com/questions/1031597/r-3-5-0-for-ubuntu). Might be
unstable!!! If this is the first time you are installing R then follow below.

>It installs 3.2 because that's the default in the Ubuntu 16.04
>repository. If you want the most up to date version of R for Ubuntu
>it's best to follow the instructions at the [cran page for R on
>Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/). - [stack](https://stackoverflow.com/questions/44567499/install-r-latest-verison-on-ubuntu-16-04)


Based on [cran page for R on Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/) && [Stack](https://stackoverflow.com/a/48518006/5986651): add `deb
https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/` to
`/etc/apt/sources.list`. Run the following commands:

	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
	E084DAB9
	
	sudo apt-get update
	sudo apt-get install r-base
	
	R --version
	
That is it. If that didn't go right, go to the section 're-installing
R for Ubuntu 16.10'

## Installing R-studio

Its a [yak shave](https://mikewilliamson.wordpress.com/2016/11/14/installing-r-studio-on-ubuntu-16-10/) to install it due to the [Gstreamer
dependency](https://mikewilliamson.wordpress.com/2016/11/14/installing-r-studio-on-ubuntu-16-10/). But thanks to the [Mike Williamson and his blog](https://mikewilliamson.wordpress.com/2016/11/14/installing-r-studio-on-ubuntu-16-10/)
and the further answer in [stack](https://askubuntu.com/a/862520/443958), it was a very smooth install for
Ubuntu 16.10 as per [this stack answer](https://stackoverflow.com/a/48518006/5986651).

**Preparing to install R Studio**

	sudo apt install libjpeg62

**Specifically installing for Ubuntu 16.10** (For other versions refer
to the stack answer):

	wget --tries=3 --timeout=120 http://ftp.ca.debian.org/debian/pool/main/g/gstreamer0.10/libgstreamer0.10-0_0.10.36-1.5_amd64.deb
	wget --tries=3 --timeout=120 http://ftp.ca.debian.org/debian/pool/main/g/gst-plugins-base0.10/libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
	sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5_amd64.deb
	sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
	sudo apt-mark hold libgstreamer-plugins-base0.10-0
	sudo apt-mark hold libgstreamer0.10

**Installing R Studio**

	wget --tries=3 --timeout=120 https://download1.rstudio.org/rstudio-xenial-1.1.383-amd64.deb
	sudo dpkg -i rstudio-*-amd64.deb
	
	rstudio
	
Thats it! 


**Note:**

>i386 refers to the 32-bit edition and amd64 (or x86_64) refers to the
>64-bit edition for Intel and AMD processors.- [stack](https://askubuntu.com/a/54298/443958)

## Re-Installing R 3.4 for Ubuntu 16.10

But the latest version is 3.5. But it appears as of jun 10 that it
could be [problematic (stack answer)](https://askubuntu.com/questions/1031597/r-3-5-0-for-ubuntu). ~~I didn't have problems
until I had to install xlsx and then shit went south that all other
packages got fucked.~~I thought I had problems and took on a path of
multiple installing and uninstalling, when the syntax for
`xmlTreeParse` was wrong from my side. Without realizing this (much
later), I went for R 3.4 only!

	sudo apt-get install r-base
	
>It installs 3.2 because that's the default in the Ubuntu 16.04
>repository. If you want the most up to date version of R for Ubuntu
>it's best to follow the instructions at the [cran page for R on
>Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/). - [stack](https://stackoverflow.com/questions/44567499/install-r-latest-verison-on-ubuntu-16-04)


Based on [cran page for R on Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/) && [Stack](https://stackoverflow.com/a/48518006/5986651): add `deb
https://cloud.r-project.org/bin/linux/ubuntu xenial/` to
`/etc/apt/sources.list`. Run the following commands:

	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
	E084DAB9
	
	sudo apt-get update
	sudo apt-get install r-base
	
It didn't work for me for some reason. I got dependency error that
looked something like this.

	r-base : Depends: r-recommended (= 3.4.4-1xenial0) but it is not going to be installed

	E: Unable to correct problems, you have held broken packages.
	
After hours of trying I stumbled on this [stack page](https://stackoverflow.com/questions/45951385/unable-to-install-r-base-in-ubuntu-16-04). This page
didn't have an answer but one of the comments took me to [Unable to
correct problems, you have held broken packages](https://askubuntu.com/questions/223237/unable-to-correct-problems-you-have-held-broken-packages). From the [answer
here I tried](https://askubuntu.com/a/223267/443958) (apparently aptitude will try harder to give us a
solution! Amazing!):

	sudo aptitude install r-base
	
This gave me these options

	 Keep the following packages at their current version:
	1)     r-base [Not Installed]                             
	2)     r-cran-foreign [Not Installed]                     
		3)     r-recommended [Not Installed]                      

     Leave the following dependencies unresolved:         
	4)     r-base-core recommends r-recommended 

I didn't know what leaving following dependencies meant so I said
`n`. Then I got another set of options:

	The following actions will resolve these dependencies:

     Install the following packages:            
	1)     r-cran-foreign [0.8.69-1xenial0 (xenial)]


Thats it, it appears it also installed `r-base-dev` by
itself. Apparently according to the [Cran page](https://cran.curtin.edu.au/bin/linux/ubuntu/) it is also needed
if we are going to use `install-packages()`, which we are.

	R --version

All Good!

Now let's see [how the packages installation](/learning-R.html) will go.

## Setting up R with Emacs

[R-bloggers](https://www.r-bloggers.com/using-r-with-emacs-and-ess/), suggests to install package `ESS` and
`ESS-smart-underscore` and some other `org` and `org-ref` type of
packages. The org stuff seem to be unnecessary for me, so I skip them
for now. Further more [r-bloggers](https://www.r-bloggers.com/using-r-with-emacs-and-ess/) link to their github repository
and the [minimum-working-init-file](https://github.com/pprevos/r.prevos.net/blob/master/Miscellaneous/BodyImage/init.el) for our reference.

The [init-file ](https://github.com/pprevos/r.prevos.net/blob/master/Miscellaneous/BodyImage/init.el) linked above shows that we need to add `require
ess-site`. I don't understand what it is and why we need it. I stick
to installing the required packages `ESS` and
`ESS-smart-underscore`. This can be manually installed with `M-x
package-list-packages RET` or you can add it to the init file. In my
case I add the packages to my `package-init.el` file which will
automatically install it. Furthermore the following is added to the
`init.el` based on [r-bloggers-init-file](https://github.com/pprevos/r.prevos.net/blob/master/Miscellaneous/BodyImage/init.el):

	;; Line numbers
	(add-hook 'ess-mode-hook 'linum-mode)

This allows for line numbers during the usage of ESS.

### Testing if the above works

Yes it works.

To get a console simply do:

	M-x R
	
The setup we now want to have is R editor on the left and R console on
the right. Create `testing.R` file. Run `C-x 3` to split the
window. Go to the other window (`C-x 0`). Open the console using `M-x
R`. The [following command](https://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/) will run the file in the console:

	C-c C-l

Toodles! Some more helpful configuration things are given in
[here](https://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/). This shall be taken into account later if needed.

### Writing R code

`_` key is bound to `<-` by default in the `ESS`
mode. `ESS-smart-underscore` tries to overcome this issue (I have not
yet tested how).


		
### Time taken to understand and install and procrastinate

	1hr 35 mins.
	
## Upgrading R 3.4.4 to next version for MASS library

From [this stack answer made on may 18](https://stackoverflow.com/a/10476798/5986651),

	sudo nano /etc/apt/sources.list    

	deb https://cloud.r-project.org/bin/linux/ubuntu/ version/
	
	gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9

	gpg -a --export E084DAB9 | sudo apt-key add -

	sudo apt-get update && sudo apt-get upgrade

It appears that R has already upgraded!

	sudo apt-get install r-base-dev

``` terminal
Reading package lists... Done
Building dependency tree       
Reading state information... Done
r-base-dev is already the newest version (3.6.0-1xenial).
r-base-dev set to manually installed.
The following packages were automatically installed and are no longer required:
  cdbs libaio1 libevent-core-2.0-5 snapd-login-service
Use 'sudo apt autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
```

**Seemless integration into ESS emacs**

### But packages are missin!

But all packages are missin! BUT!!!!!

	library(ggplot2)
	
	NOT FOUND!

For this we follow [the same guy on this answer](https://stackoverflow.com/a/10476798/5986651)!

> Recover your old packages following the solution that best suits to
> you (see this). For instance, to recover all the packages (not only
> those from CRAN) the idea is:
>
> -- copy the packages from R-oldversion/library to
> R-newversion/library, (do not overwrite a package if it already
> exists in the new version!).
>
> -- Run the R command update.packages(checkBuilt=TRUE, ask=FALSE).

So we first look at `.libPaths()` in R to see where 3.6 packages are!

and we get 

	[2] "/usr/local/lib/R/site-library"               
	[3] "/usr/lib/R/site-library"                     
	[4] "/usr/lib/R/library"  
	
And found that `/usr/lib/R/library` has the packages of the current
folders of packages. I test many of them using `library(MASS)` for
example! It works!

When you ask to update packages (also install packages I think), it
puts in a different folder which is writable. I found 3.4 packages in
`/home/eghx/R/x86_64-pc-linux-gnu-library/3.4` and 3.6 packages go
into `/home/eghx/R/x86_64-pc-linux-gnu-library/3.6` when you 

	update.packages(checkBuilt=TRUE, ask=FALSE)

#### Conclusion

In conclusion, what needs to be done is, 

	sudo cp -rn R/x86_64-pc-linux-gnu-library/3.4/ggplot2 /usr/lib/R/library/ggplot2

for all folders 

**or**

just copy paste from `R/x86_64-pc-linux-gnu-library/3.4` to
`R/x86_64-pc-linux-gnu-library/3.6`. Do not replace any folders in 3.6
and then type in R

	update.packages(checkBuilt=TRUE, ask=FALSE)

You will have a lot of warnings, maybe errors even. But thats how it's
going to be! But I guess it's ok!
