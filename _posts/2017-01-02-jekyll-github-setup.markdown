---
layout: post
comments: true
title:  "Jekyll gh-pages fastpages Docker github workflow"
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


### restoring sites folders and files?

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

	git config user.email "agent18@github.io"
	
	git config user.name "agent18"
	
	git commit -m "empty testing git on new pc"
	
	git push

Might need to do it sometimes on a fresh pc perhaps.

	git config --global push.default simple
	
	git config --global credential.helper cache
	
Check with this shows all the important info:

	git config --list
	
	

That's it. Git will start working, in combination with jekyll.

	jekyll serve

## Gem, rubygems, bundler, jekyll 

### Basics

> RubyGems is a package manager for the Ruby programming language that
> provides a standard format for distributing Ruby programs and
> libraries (in a self-contained format called a "gem"), a tool designed
> to easily manage the installation of gems, and a server for
> distributing them.---[What is a Ruby Gem](https://stackoverflow.com/a/5233948/5986651)

`Gems` seem to be individual `packages`. `RubyGems` the package manager
like `apt-get` I guess. `Bundler` is an overarching package manager
giving the seeming feel of `conda` and its different
environments. `Bundler` allows you to select the "envs" using
`Gemfile.lock` and `bundle exec` commands.

**Gemfile & Gemfile.lock**

First time you run `bundle install` in a folder where `Gemfile` is
installed, you create a file `Gemfile.lock`. This file contains all
the packages and dependencies installed verbatim to version number. 

**Transferring the files**

When you hand over someone the whole folder, if that person runs
`bundle install` he gets all the exact versions installed as per the
`Gemfile.lock` file and not the `Gemfile`.

**Updating gems**

Now when I want to add some other `gems` such as a `Javascript
runtime`, all I have to do is add this to the `Gemfile` (`gem
"therubyracer"`) and then `bundle install` and only that
`therubyracer` is added. 

The `env` part of `bundler` kicks in now. I want to run `jekyll serve`
based around the `Gemfile.lock` file. So `bundle exec jekyll serve`
makes that happen.

The beauty of `bundler`, `gems` and everything coming together with
the "envs" is explained in [bundler rationale](https://bundler.io/v1.12/rationale.html) and summarized in
[this stack answer](https://stackoverflow.com/a/10959764/5986651).

### Bundler: can't find gem bundler (>= 0.a) (Gem::GemNotFoundException)

`bundle install` gives this error:

While installing [fastpages](https://github.com/fastai/fastpages) and cloning it to my PC and running it
locally, I got the following error.

As per [this stack answer](https://stackoverflow.com/a/54088452/5986651), did `gem install bundle`. I had version
`1.something`, but the `Gemfile.lock` file had.

	BUNDLED WITH
	2.1.4

### Jekyll “Could not find a JavaScript runtime” error

Once I ran `bundle exec jekyll serve --trace` there were no error
messages anymore.

``` terminal
: Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
```

Tried adding `gem "therubyracer"` to the `Gemfile` which one of the 7
mentioned [in the error link above](https://github.com/rails/execjs) and `bundle install`. No more
errors with `bundle exec jekyll serve`

### Installing fastpages

1. clone
2. install docker
3. sudo make server

If you just want to get markdown parts running then the following is
enough: First running `gem install bundle` and then doing `bundle
install` to install from `Gemfile.lock` and then `bundle exec jekyll
serve` to use run in the context of the existing bundle.

### Useful gem commands

`gem list --local` lists current gems installed (including all
versions), i.e., `jekyll (4.1.1, 3.8.7, 3.8.4, 3.8.3)`.

`gem env` lists all the versions things like `rubygems` and `bundler`
etc...



### Making ipnb notebooks work with Docker

After installing docker, all I need to do is `make server` according
to [fastpages](https://github.com/fastai/fastpages/blob/master/_fastpages_docs/DEVELOPMENT.md).

docker installed all good with make 

but when I tried makefile got docker error that `docker-compose` is
not there. After that:

``` terminal
Traceback (most recent call last):
  File "urllib3/connectionpool.py", line 677, in urlopen
  File "urllib3/connectionpool.py", line 392, in _make_request
  File "http/client.py", line 1252, in request
  File "http/client.py", line 1298, in _send_request
  File "http/client.py", line 1247, in endheaders
  File "http/client.py", line 1026, in _send_output
  File "http/client.py", line 966, in send
  File "docker/transport/unixconn.py", line 43, in connect
PermissionError: [Errno 13] Permission denied
```

Based on [this](https://docs.docker.com/compose/install/)

Just use `sudo make server` and the rest is ok for now. It takes more
than 5 mins to host... wait patiently? Yes for now.

More info about [fast yaml front matter is here](https://github.com/fastai/fastpages#customizing-blog-posts-with-front-matter)
