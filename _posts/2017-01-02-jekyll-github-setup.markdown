---
layout: post
comments: true
title:  "How to make jekyll work with github for your blog site"
date:   2017-01-10 23:54
categories: posts
permalink: /:title.html
---

## setting up gh-pages with jekyll

### Jekyll 
Start [here][jekyll_welcome] to understand what jekyll is and move on to the next
page to see some instructions on how to get started. We need jekyll
and bundler installed via gem. I found a nice help on [this stack
website](https://stackoverflow.com/a/34523631/5986651):

	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

	\curl -sSL https://get.rvm.io | bash # install RVM (development version)

	rvm get head # Make Sure RVM up to date
	
Got some errors here. Apprently the license was not updated. followed
exactly what the error msg suggested me to do. 

	GPG signature verification failed for '/home/eghx/.rvm/archives/rvm-installer' - 'https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc'! Try to install GPG v2 and then fetch the public key:

	gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

	or if it fails:

	command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

	the key can be compared with:

	https://rvm.io/mpapis.asc
	https://keybase.io/mpapis

	NOTE: GPG version 2.1.17 have a bug which cause failures during fetching keys from remote server. Please downgrade or upgrade to newer version (if available) or use the second method described above.

I didn't compare the key though. Just checked if the next steps
worked.

	rvm get head
	
	rvm install ruby # will install latest version of ruby

	rvm list # Listing install rubies will you get versions of ruby which is installed by RVM

	rvm use < ruby-version > # for instances ruby-1.9.3-p125
	
	gem install jekyll bundler


After installing Jekyll(fingers crossed):

	$ jekyll new my-awesome-site # initiates jekyll into current folder named "my-awesome-site"	
	$ cd .../.../my-awesome-site # go to that folder we just created "my-awesome-site"
	$ jekyll serve  # hosts site locally

Should serve a local website (details in the terminal) that you can open and see on your browser. Yes you already have a local website! Congratulations!


**On a fresh terminal RVM does not work**

Jekyll might not work the next time you open a new terminal [like here.](https://stackoverflow.com/questions/23963018/rvm-is-not-a-function-selecting-rubies-with-rvm-use-will-not-work?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)

The above has the solution that brings back the use of jekyll rvm
etc...

	Open console
	Select Edit -> Profile Preferences
	Select tab: Title and Command
	Check box 'Run command as a login shell'
	Restart terminal

Jekyll would be smoothly installed.

--- 

### gh-pages setup

This has been been tested on okt 18th.

1. Repository name: "username.github.io"
2. branch: Master/Main
3. Don't choose theme
4. No readme or anything to be added

Following are the commands that need to be executed based on [gh-pages](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/creating-a-github-pages-site-with-jekyll):

	jekyll new my-awesome-site
	cd my-awesome-site
	jekyll serve

More about Jekyll file structure on the [Jekyll website](https://jekyllrb.com/docs/themes/).

	cd my-awesome-site # go inside the jekyll folder
	git init # initializes the local repository into a git recognizable.
	git add . 
	git commit -m "First commit" 
	git push # won't work

	git remote add origin "remote url of repo"
	git push -u origin main
	git status
		
Add this @ some point (the terminal will most likely suggest the
following two):
	
	git config --global user.email "agent18@github.io"
		
	git config --global user.name "agent18"
	
	git config --global push.default simple


### restoring sites folders

[Jekyll main](https://jekyllrb.com/docs/themes/)

[There is a way here](https://stackoverflow.com/questions/59913903/how-to-run-bundle-exec-jekyll-new)

[gh-pages instructions on how to do it](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/creating-a-github-pages-site-with-jekyll)

### Adding favicon

Source: [how to add favicon to your site](https://medium.com/@xiang_zhou/how-to-add-a-favicon-to-your-jekyll-site-2ac2179cc2ed)

Find out where minima is:

	bundle show minima
	
copy the `head.html` you wanna change to `_includes` and then add
after `<meta name="viewport"...` line.

``` html
<link rel="icon" type="image/png" href="./images/favicon.png"/>
```

### Removing Jekyll website names based on categories and date

Source: [permalink on jekyll site](https://jekyllrb.com/docs/permalinks/)

Add this to every post `front matter`: 

	permalink: /:title.html
	

### adding math capabilities

Source: [how to use math with github pages and jekyll](https://stackoverflow.com/a/46765337/5986651)

Add the following to the end of the `head.html` file.

``` html
  <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'],
        inlineMath: [['$','$']]
      }
    });
  </script>
  <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script> 
```
[Here](https://stackoverflow.com/a/30389289/5986651) are ways you wanna do it.

1. Write between two Dollar signs to get inline output. 

$\frac{2}{3}$, $$\frac{2}{3}$$,

1. Following gives very neat output and centered:

\\[ \frac{1}{n^{2}} \\] 

1. or suggested. I have always used the dollar sign and it has worked decently.

{% raw %}
$$a^2 + b^2 = c^2$$ --> note that all equations between these tags will not need escaping!  
{% endraw %}

### Discuss comments

Source: [link 1](https://desiredpersona.com/disqus-comments-jekyll/), 

1. You can create different "shortnames" for different sites with the
   same account. I have `agent18` and `another-name`.
   
2. Find `post.html` using `bundle show minima` in the right
   folder. Copy and past.
   
3. `Post.html` already has this:

	``` html
	{%- if site.disqus.shortname -%}
		{%- include disqus_comments.html -%}
	{%- endif -%}
	```
4. `config.yml` add:

	``` yml
	disqus:
    # Leave shortname blank to disable comments site-wide.
    # Disable comments for any post by adding `comments: false` to that post's YAML Front Matter.
    shortname: "another-name"
	```
5. Add the `universal code` from disqus.

6. Finally paste the `counter-thingy` at the end of `post.html`. Not
   fully sure how to get it working or what exactly it does. But just
   wrapped it up.


### changing repository name

Source: [changed repository name](https://stackoverflow.com/a/30443593/5986651)

Updating local folder with changes on the repository name.

	git remote rm origin
	git remote add origin [updated link]

### adding a general image to every post
### changing formatting?
## starting up with **existing** gh-pages

So I have fastpages setup on the github. Apprently it uses
jekyll... How convinient?

	sudo apt-get install git

	git clone https://github.com/agent18/agent18.github.io.git myblock
	
	git add -A
	
	git commit -m "empty testing git on new pc"

	git config --global user.email "agent18@github.io"
	
	git config --global user.name "agent18"
	
	git config --global push.default simple
	
	git config --global credential.helper cache

	git commit -m "empty testing git on new pc"
	
	git push

That's it. Git will start working, in combination with jekyll.

	jekyll serve


## Deprecated

#### **Entry question** : How to get a static-blogging-site up and running using jekyll and Github pages.
This is supposed to be a guide based on my experience with trying to use github and jekyll within an **ubuntu** environment. This is definitely not the complete guide. Several issues are not discussed in detail. But please hit me up in case you are stuck. Maybe I am able help. I am more than glad to help.

---

#### **What do we want to do?**

We want to write some posts in simple-plain-text-based Markdown and then magically want it to show up in a site username.github.io, which is also the name of our repository(folder) on github. To get this to work, we need to install jekyll, write 3 commands and then setup github pages and write ~7 more commands and then we should have a working site. I warn you now and I warn you hard that it took me quite some time to get it to work. Especially getting jekyll running was a pain. For now don't delve too much into what each command does and run with the flow. We figure out things as and when we hit a road block.

--- 

#### **Github pages**
[Github pages][github_pages] helps to host our site along with this epic time machine called git (read about it). All you need to do is to "upload" the contents from "my-awesome-site" to github pages and bam, username.github.io shows the site as you saw locally. Ofcourse you need to setup git and github_pages. Look down!

#### **Github repository**
Create a new Github repository using this [page's][github_pages] exact instructions. Make sure to call the repository "username.github.io". Be careful with instruction #5 on that page - like it says, because you will be importing contents into the repository, you should not do any of those three things - README, etc. Also, ignore instruction #7. You will now have a new empty Github repository called "username.github.io". In my case it is [agent18.github.io][agent18id].

#### **Setting up a first connection between online (http://github.com/agent18) and local (my-awesome-site)** 

Go inside topmost jekyll folder (my-awesome-site) - the one that
contains \_posts/, \_site/, etc. Now, we will make this folder into a
git repository. This folder is what should go up on Github. Follow the
instructions on [this page][github_add_existing]. Step 1 is already done, so skip
it. The commands are reproduced for convenience:

	$ cd my-awesome-site # go inside the jekyll folder
	$ git init # initializes the local repository into a git recognizable.
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

We have now created the repository online and synced with my-awesome-site locally. Check your repository page ("github.com/username") to see if you see the contents of my-awesome-site. We can display the site on our browser locally ($ jekyll serve) and upload ($ git push) to see the changes online @ username.github.io .

#### **From now on!**
Go to \_posts folder in my-awesome-site. Look at the basic post and emulate future posts. Look around and the one thing that helps is to go through the [jekyll docs][jekyll_usage] as and when required, but patiently. Spend some time and make the changes you want to the site. From now on the work flow will be as follows: 

	$ git add -A
	$ git commit # dialog window opens to receive info on the commit
	$ git push 

Type Username and password and then go to username.github.io and it works like a charm. Wait a few minutes before you see the changes on your site.


#### **Existing repository setup on new PC**

Install Jekyll (as above), and then do the following:

	sudo apt-get install git

	git clone https://github.com/agent18/agent18.github.io.git myblock
	
	git add -A
	
	git commit -m "empty testing git on new pc"

	git config --global user.email "agent18@github.io"
	
	git config --global user.name "agent18"
	
	git config --global push.default simple
	
	git config --global credential.helper cache

	git commit -m "empty testing git on new pc"
	
	git push

That's it. Git will start working, in combination with jekyll.

	jekyll serve

---

####  **Disqus comments**
Disqus offers a simple system so that people can comment in your
posts. All you need to do is copy paste a universal code into
/layouts/\_post and register your site with Disqus. Refer [here][jekyll_disqus]
and [here][jekyll_disqus_2] and be blessed. Good luck and big balls!

#### Writing Math equations!

https://stackoverflow.com/a/10197062/5986651

> M-x set-input-method RET TeX will allow you to write e.g. \beta to
> get β, \sum or \Sigma to get Σ etc.

> It can be toggled on and off with toggle-input-method, bound to C-\
> and C-<.

https://stackoverflow.com/a/46765337/5986651


  ``` html  
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'],
        inlineMath: [['$','$']]
      }
    });
  </script>
  <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script> 
  ```

> add the above in the file _includes/head.html, and then your GitHub Pages site
> will support MathJax


#### **Thank You**

Thanks to an [STM][STM] for the overall layout, details and continuous help with which I made this post and got working an actual simple-plain-text-based-Markdown-using-static-blogging-site working. Congratulations once again! 


[agent18id]: http://agent18.github.io
[github_pages]: https://help.github.com/articles/creating-a-new-repository/ 
[jekyll_welcome]: https://jekyllrb.com/docs/home/
[jekyll_structure]: https://jekyllrb.com/docs/structure/
[github_add_existing]: https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/#platform-linux
[jekyll_usage]: https://jekyllrb.com/docs/usage/
[jekyll_disqus]: https://help.disqus.com/customer/portal/articles/472138-jekyll-installation-instructions
[jekyll_disqus_2]:http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/
[STM]: http://pradeep90.github.io/
