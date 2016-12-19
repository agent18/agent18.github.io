---
layout: post
comments: true
title:  "How to make jekyll work with github for your blog site"
date:   2015-10-04 23:54
categories: The Beginning
permalink: /:title.html
---
<!-- <img src="/images/git.png" width="200" height="200" /> --> 
---

#### **Entry question** : How to get a static-blogging-site up and running using jekyll and Github pages.
This is supposed to be a guide based on my experience with trying to use github and jekyll within an **ubuntu** environment. This is definitely not the complete guide. Several issues are not discussed in detail. But please hit me up in case you are stuck. Maybe I am able help. I am more than glad to help.

---

#### **What do we want to do?**

We want to write some posts in simple-plain-text-based Markdown and then magically want it to show up in a site username.github.io, which is also the name of our repository(folder) on github. To get this to work, we need to install jekyll, write 3 commands and then setup github pages and write ~7 more commands and then we should have a working site. I warn you now and I warn you hard that it took me quite some time to get it to work. Especially getting jekyll running was a pain. For now dont delve too much into what each command does and run with the flow. We figure out things as and when we hit a road block.

--- 

#### **Jekyll** 
Start [here][jekyll_welcome] to understand what jekyll is and move on to the next page to see some instructions on how to get started. The instructions are reproduced here for convinience.

	$ gem install jekyll bundler # installs jekyll and required programs 

Get this previous command runnning and you are almost there in the setup. I spent around a full day (5-6 hrs atleast) getting this to work. My direction to a future me and readers is to first type this command. This command will give you whats the problem. Either some programs are missing or some other error shows up. In either cases I just google it, preferably use only stackoverflow domains and I am good to go. Sometimes putting a sudo in front of the commands could just be the solution, in case it asks for permissions in the error. It took me a while to catch on to the game. I had to just follow the errors meticulously and solve them one by one, try different things etc... But **you** can. It has been done in the past. A silly ass noob, to ruby rvm gem, and jekyll, did it. You can too. Do it yourself! After installing Jekyll(fingers crossed):

	$ jekyll new my-awesome-site # initiates jekyll into current folder named "my-awesome-site"	
	$ cd .../.../my-awesome-site # go to that folder we just created "my-awesome-site"
	$ jekyll serve  # hosts site locally

Serves a local website (details in the terminal) that you can open and see on your browser. Yes you already have a local website! Congratulations!

--- 

#### **Github pages**
[Github pages][github_pages] helps to host our site along with this epic time machine called git (read about it). All you need to do is to "upload" the contents from "my-awesome-site" to github pages and bam, username.github.io shows the site as you saw locally. Ofcourse you need to setup git and github_pages. Look down!

#### **Github repository**
Create a new Github repository using this [page's][github_pages] exact instructions. Make sure to call the repository "username.github.io". Be careful with instruction #5 on that page - like it says, because you will be importing contents into the repository, you should not do any of those three things - README, etc. Also, ignore instruction #7. You will now have a new empty Github repository called "username.github.io". In my case it is [agent18.github.io][agent18id].

#### **Setting up a sync connection between online (http://github.com/agent18) and local (my-awesome-site)** 
Go inside topmost jekyll folder (my-awesome-site) - the one that contains \_posts/, \_site/, etc. Now, we will make this folder into a git repository. This folder is what should go up on Github. Follow the instructions on [this page][github_add_existing]. Step 1 is already done, so skip it. The commands are reproduced for convinience:

	$ cd my-awesome-site # go inside the jekyll folder
	$ git init # initializes the local repository into a git recognisable.
	$ git add . 
	$ git commit -m "First commit" 
 
This is the time machine part. Every commit that you make helps you travel back in time to the commit. A commit you made 3 years ago has a certain structure of files and content. You can revisit how your folders and content were 3 years back. Every commit is a point of time in history you can go back to.

	$ git push # uploads to github.com i.e., your repository.

You will be asked for your credentials, please type it in.
	
	$ git config --global credential.helper cache

You can save these credentials for a period of 15 minutes (by using the above command), i.e. you do not have to type in your username every single time you upload your contents. 

At the top of your GitHub repository's Quick Setup page, click "pad-with-left-arrow" symbol to copy the "remote repository URL".

	$ git remote add origin _remote repository URL_
	# Sets the new remote
	$ git remote -v
	# Verifies the new remote URL

	$git push origin master
	# Pushes the changes in your local repository up to the remote repository you specified as the origin

We have now created the repository online and synced with my-awesome-site localy. Check your repository page ("github.com/username") to see if you see the contents of my-awesome-site. We can display the site on our browser locally ($ jekyll serve) and upload ($ git push) to see the changes online @ username.github.io .

---

#### **From now on!**
Go to \_posts folder in my-awesome-site. Look at the basic post and emulate future posts. Look around and the one thing that helps is to go through the [jekyll docs][jekyll_usage] as and when required, but patiently. Spend some time and make the changes you want to the site. From now on the work flow will be as follows: 
	$ git add -A
	$ git commit # dilog window opens to recieve info on the commit
	$ git push 

Type Username and password and then go to username.github.io and it works like a charm. Wait a few minutes before you see the changes on your site.

---

####  **Disqus comments**
Disqus offers a simple system so that people can comment in your posts. All you need to do is copy paste a universal code into \layouts/\_post and register your site with Disqus. Refer [here][jekyll_disqus] and [here][jekyll_disqus_2] and be blessed. Good luck and big balls!

#### **Thank You**

Thanks to an [STM][STM] for the overall layout, details and continuous help with which I made this post and got working an actual simple-plain-text-based-Markdown-using-static-blogging-site working. Congratualations once again! 


[agent18id]: http://agent18.github.io
[github_pages]: https://help.github.com/articles/creating-a-new-repository/ 
[jekyll_welcome]: https://jekyllrb.com/docs/home/
[jekyll_structure]: https://jekyllrb.com/docs/structure/
[github_add_existing]: https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/#platform-linux
[jekyll_usage]: https://jekyllrb.com/docs/usage/
[jekyll_disqus]: https://help.disqus.com/customer/portal/articles/472138-jekyll-installation-instructions
[jekyll_disqus_2]:http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/
[STM]: http://pradeep90.github.io/
