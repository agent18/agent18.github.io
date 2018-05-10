## Emacs

https://askubuntu.com/questions/851633/emacs-25-on-ubuntu-16-10?noredirect=1&lq=1

dont do this

https://askubuntu.com/questions/598985/how-to-upgrade-to-the-latest-emacs

as we do not know what the fuck nightly packages are!
## Git setup

	sudo apt-get install git

	git clone https://github.com/agent18/agent18.github.io.git myblock
	
### Establishing contact with agent18 server and agent18 local

## Installing jekyll
my first attempt http://agent18.github.io/jekyll-github-setup.html; to
be updated! 

I need jekyll installed to this level: 
https://jekyllrb.com/docs/quickstart/

installing jekyll
https://stackoverflow.com/questions/34521806/installing-jekyll-on-ubuntu-14-04/34523631#34523631

after step 3


error:

Downloading https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
Verifying /home/eghx/.rvm/archives/rvm-installer.asc
gpg: Signature made za 31 mrt 2018 23:47:44 CEST using RSA key ID BF04FF17
gpg: Can't check signature: No public key
Warning, RVM 1.26.0 introduces signed releases and automated check of signatures when GPG software found. Assuming you trust Michal Papis import the mpapis public key (downloading the signatures).

GPG signature verification failed for '/home/eghx/.rvm/archives/rvm-installer' - 'https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc'! Try to install GPG v2 and then fetch the public key:

    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

or if it fails:

    command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

the key can be compared with:

    https://rvm.io/mpapis.asc
    https://keybase.io/mpapis

NOTE: GPG version 2.1.17 have a bug which cause failures during fetching keys from remote server. Please downgrade or upgrade to newer version (if available) or use the second method described above.

end of error ! 


getting into the error! followed stpes in the error and did 

rvm get head again

in the end

gem install jekyll bundler

jekylls appears to be setup!



###  Testing it

as per this https://jekyllrb.com/docs/quickstart/

it seem to work

## Setting up drive 

https://www.howtogeek.com/196635/an-official-google-drive-for-linux-is-here-sort-of-maybe-this-is-all-well-ever-get/

One needs Gnome-control-centre; install it and manipulate it and see
how that goes!

## Setting up internet speed
