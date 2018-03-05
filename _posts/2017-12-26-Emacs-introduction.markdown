---
layout: post
comments: true
title:  "A new beginning- Emacs"
date:    26-12-2017 15:00
categories: The Beginning
permalink: /:title.html
published: True

---

  
##  Why Emacs

An STM suggested to me that if I am looking for something over the long term (20
years or more) I should check out EMACS. [This video][emacs_video] showed how
emacs could be used by writers, people who are not programmers, people who would
like their writing to be not clumsy AF, people who would like to free their mind of
the all the things that could be hindering thier progress. 

[emacs_video]:https://www.youtube.com/watch?v=FtieBc3KptU

You want to be at your creative best and not be bogged down by things like
formatting and the like (for example writing in word and bleeding from your eyes
as you struggle hard to format). Plus the things that org-mode can do are really fancy
as mentioned in [the same video linked above][emacs_video], they give us better
control over what we are writing with simple key strokes.

In summary, 

- you don't have to move your hands to the right (dark) side of your keyboard.
  - emacs has keybindings (shortcuts) for basic movement, without moving to the
  right side of your keyboard 
- we write in plain text and plain text only.[^1]
- org-mode allows to see just the headlines, minus the text with simple
  keybindings
- You can split the screen which ever way you want (all with hot keys) and
  screens can be mirrored with one side showing outline of the doc and the other
  showing everything else.
- Writers, programmers, academicians all praise this software and claim to have
  switched from other editors because EMACS is that good. 
  
>Yes, my friends, it is true. After more than fifteen years using Vim, teaching
>Vim, proselytizing about Vim, all the while scoffing in the general direction
>of Emacs, I’ve seen the light. The light of Lisp… Or something. -
>Aaron bieber

- I have started using emacs for the past few days. I have only
  scratched the tip of the iceberg I suspect. I should be able to do
  much much more with it.

There is a whole community out there. Some special metions with
creation of decent documentation and some interesting modes would be
Ian Barton and Carsten Doiminik.

[^1]: Plain text is the format that will probably never be 
	unsupported. It is the simplest form of storing data and can be read
	back decades to come follow. That's one of the reasons we prefer plain
	text instead of softwares like word. Integrating with version
	control such as git is super light as a result of keeping it in plain
	text, instead of some binary formats.



---

## Getting started

### Installation basics

Installing from the ubuntu software centre is possible, but for some
reason it didn't install the latest version. I followed the
installation procedure [here][ask-ubuntu-installation]. I am
replecating the information here for convinience. 

	$ sudo add-apt-repository ppa:ubuntu-elisp/ppa
	$ sudo apt-get update
	$ sudo apt-get install emacs-snapshot

In case you already installed an older version of emacs use the
following to remove the current running version:

	$ sudo apt-get remove --auto-remove emacs

I ran into [this error][emacs-stack-error-thej] whence I had the old
installation (from software centre). Many packages including Helm and
Markdown-mode didn't install. So, I installed the latest version of
emacs as above.

[emacs-stack-error-thej]:https://stackoverflow.com/questions/47983227/helm-installation-package-emacs-24-4-unavailable/47985613?noredirect=1#comment82941695_47985613

[ask-ubuntu-installation]: https://askubuntu.com/questions/598985/how-to-upgrade-to-the-latest-emacs

### Things to know 

One of the ideas behind emacs is to allow you to write efficiently
without having to do silly key strokes to move around, that would involve moving your
entire arm to another location. Emacs, offers a different solution to
moving through a document. Bear with the initial discomfort, and
it will pay off. 

We are not going to use the up, down, left, right, delete, home, end
page up buttons when we are in emacs. 

I would imagine it best to go through the emacs tutorial (the tutorial
you can find as soon as you open emacs) first to get the basics of emacs, but if you don't have
4-5 hrs maybe try this document.

#### Basic navigation

In this document as well as in every other documentation in the world
on emacs `C-x` stands for `Hold Ctrl and type x`. Similarly
keybindings (or shortcuts) with the Alt key/Meta key is denoted as
`M-x` for example, where `M` stands for the `Meta/Alt` key.


| Cmd               | What it does                      |
|:------------------------|:----------------------------------|
| C-v                    | Page down                         |
| M-v                    | Page up                           |
|                        |                                   |
| C-f                    | move forward                      |
| C-b                    | move backward                     |
| C-p                    | Move one line up                  |
| C-n                    | Move one line down                |
| C-a                    | Move to beginning                 |
| C-e                    | Move to the end of the line       |
|                        |                                   |
| C-g or Esc (3 times) | To cancel any command you started |
|                        |                                   |

Using `M` instead of `C` for the last 4 commands shows a different
but similar usage of the command. Check it out!

#### Terminology

buffer: Every space where we type or help is displayed is called a
buffer. A file opens into a buffer.

Frame: the whole graphical screen with all the different buffers if
any is called the frame.

Mode line: This is the line you see at the bottom with the file name,
percentage scrolled in the file, line number and other things.

Modes: In the Mode line you will see something like this,
`Fundamental`. This denotes the mode in which you are writing. Think
of modes as the way emacs understands how the file should be indented
and colored, speaking in a lay way. Check out `C-h m` to get more
information about your current mode.

Once you press `C-h m` you will see two things, a major mode and several
minor modes. Major mode defines how certain indentations happen with
emacs and the colour scheme etc... If I am using markdown I will use
Markdown mode. If I wan't to use ORG I will use ORG-mode. Minor modes
are additions that can be added to any Major mode. For example, say I
want to count the number of words in my doc. Then I am looking at the
minor mode `WC` which can be added to any major mode.

Echo area: When ever we type any commands they will appear in the
bottom empty space. It is also called the Mini buffer sometimes.


#### Commands related to Files

| Cmd     | What it does                                                      |
|:---------|:------------------------------------------------------------------|
| C-x C-f | Find file                                                         |
| C-x C-s | Save file                                                         |
| C-x s   | Save some buffers                                                 |
| C-x C-b | Switch buffer                                                     |
| C-x b   | Switch buffer                                                     |
| C-x C-c | Quite emacs offering to save                                      |
| C-s     | Searches within a file                                            |
| C-x f   | Sets character count per line                                     |
| M-q     | Aligns the current paragraph to the latest column character count |
|         |                                                                   |



#### Help related commands

| Command   | what it does                                    |
|:----------|:------------------------------------------------|
| C-h c C-p | small description in mini buffer                |
| C-h k C-p | opens help buffer                               |
| C-h f     | type function and get help in buffer            |
| C-h a     | search for commands (only meta I think)         |
| C-h i     | primary documentation to use accroding to help! |
| C-h m     | Informs about the current mode in a buffer      |
| C-h a     | allows to pattern search commands               |
| C-h b     | Opens buffer to search for keybindings          |
|           |                                                 |

#### Buffer related features

| Command   | what it does                                 |
|:----------|:---------------------------------------------|
| C-x o     | Move cursor to other buffer                  |
| C-x 1     | keep only current buffer open                |
| C-x 2     | Split screen horizontally with duplicate     |
| C-x 3     | Split scree vertically with duplicate        |
| C-x 4 C-o | Display different buffer in the other buffer |
|           |                                              |



#### Interesting options 

The `Meta/Alt-x` is the Meta key followed by x.

| Command                | What does it do                                             |
|:-----------------------|:------------------------------------------------------------|
| M-x org-mode           | toggles to org-mode                                         |
| M-x Markdown-mode      | toggles to corresponding mode                               |
| M-x auto-fill-mode     | toggles to the corresponding minor mode                     |
|                        | Auto fill makes sure the character-column-width as constant |
| C-x C-+                | Zoom in                                                     |
| C-x C--                | Zoom out                                                    |
| C-/                    | undo                                                        |
| C-f followed by C-/    | [redo][redo-stack]                                          |
| C-g or <Esc><Esc><Esc> | To cancel any command you started                           |
| C-x f                  | to inform                                                   |
|                        |                                                             |


[redo-stack]:https://stackoverflow.com/questions/3527142/how-do-you-redo-changes-after-undo-with-emacs

**Quick P.s** I was blown away while writing this table in Markdown
mode. The fact that someone actually thought about it in this way, and
the naturalness of using a table with a tab and the whole self
adjusting nature of the table... Kill me!

This is what I constantly see online, people madly in love with this
invention. And people crying and preeching to others to use this madness
that is Emacs.

### Configuration

This is the part that is sort of hard to grasp within emacs. I make a
quick attempt to list out the important things.

**1 reason why we care about configuring:**

Sometimes we might need to install some packages to our system to
improve or have access to other functionality that is not preshipped
with the installation. For me I wanted the `markdown-mode` that I saw
online to write in markdown in emacs. FYI, `markdown-mode` has org-mode
like features for using tables and visbility cycling (we will talk
about this later). 

Typing `M-x markdown` followed by `tab` didn't list anything in the
minibuffer. So we don't have it installed and so what you need to do
is `M-x package-list-packages`. This shows a list of packages that we
can install. My problem was I didn't find anything close to
markdown-mode or the like. That is why kids, we need to do this
configuration thingy.

Configuration/setting up the init file implies manipulating a text
file. Emacs has this init file that can have Lisp code, to perform
some tasks at start up.

>For GnuEmacs, your init file is ~/.emacs, ~/.emacs.el, or
>~/.emacs.d/init.el. You can choose to use any of these names. ‘~/’
>stands for your home directory. -[emacs init wiki][emacs-init-wiki]

And so, I created a text file as `~/.emacs.d/init.el` as I didn't have the file
already created. I guess thats how it's supposed to work. BTW, I didn't have
a `.emacs` file already created either. 

[aabi-emacs-from-vim]:https://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html

Based off of [Aaron Biebers introduction to
emacs][aabi-emacs-from-vim] , here is my init file (just copy it):

	;; https://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html 

	(require 'package)

	(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
	(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
	(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
	(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

	(setq package-enable-at-startup nil)
	(package-initialize)
	
I added the marmalade line as well (which is not there in Aaron
Biebers init file), for [some
reason](https://stackoverflow.com/questions/19361068/missing-packages-from-gnu-emacs).
Stongly recommend adding it. With this I was able to install all the
packages I wanted easily using the method described below.

Load the init file without exiting by simply typing:

     M-x load-file "filename"
     
To install a package all you need to do is type

	M-x package-list-packages
	
This opens a buffer with all packages. With `C-s` you can search for
your package and then click it using a mouse and install it by
clicking on the `install button` or just type `M-x package-install <package name>`.

[emacs-for-beginners]:http://orgmode.org/worg/org-tutorials/org4beginners.html


Links like [this][emacs-for-beginners] also say I need to add
other things in my init file, but I suspect the data is outdated in
some parts, and I suggest that as you need you shall add to your init
file. Keep track with comments what you are putting in your init file.
Right now my computer works just fine this way with the installation
as explained above. The version I have now is `26.0.50.2`. I am a bloody
noob. If you are reading this, then you are probably a bloddy noob as
well. This document hopes to just get you started and I detail out
some of the things I spent a lot of time on, and hope you don't have
to. :)

[Aarob Bieber's page][aabi-emacs-from-vim] also shows other ways of
installation. But it went over my head and I will get back to it
later.


[emacs-init-wiki]:https://www.emacswiki.org/emacs/InitFile

If you want to install markdown mode for example,

[Markdown-mode-MAN][markdown-mode-jblevins]


[markdown-mode-jblevins]: https://jblevins.org/projects/markdown-mode/

If you want to set global key bindings, then you will find in [Rules of
thumb to overide global commands](https://emacs.stackexchange.com/questions/27926/avoiding-overwriting-global-key-bindings) that `C-c <letter>` is available
for usage for end users. And [this website]( https://emacs.stackexchange.com/questions/3488/define-controlshift-keys-without-kbd) gives the right syntax.

## Org mode, the farthest I have come

>Org mode is for keeping notes, maintaining TODO lists, planning
>projects, and authoring documents with a fast and effective plain-text
>system.- orgwiki

Check out this [video][google-org-mode-talk] for a nice introduction
to orgmode and its capabilities. In short, the idea of org-mode along
with emacs makes writing easy, allows us to focus straight on content
and less on setting up and formatting and thinking about other
things. How ever there is learning curve. It took me about 10 hrs
before I got anywhere with emacs. I spent another 10hrs working with
it, trying to make things work, ask for help and get replies etc...

[google-org-mode-talk]:https://www.youtube.com/watch?v=oJTwQvgfgMM

If you have already come this far, then pat yourself on the
back, you have a working emacs and a basic understanding that is going
to probably propell you on a journey of emacs-epicness. Honestly the
hype that people who use it gives me enough enthusiasm to echo their
feelings. Also, it's been a week since I started using emacs. I really
love it and I think I am going to stay here for a long time, purely
because it much much better than the text editors I have used all my
life (these are primarily gedit and atom).

[org-mode-for-writers]:https://www.youtube.com/watch?v=FtieBc3KptU

ORG-Mode and other modes (such as markdown mode) associated with it,
really take plain text to a whole new level. Writing tables has never
been this easy. Org-mode is not just for computer programmers, it is
for writers, poets, bloggers, anyone who writes text. Check this
[video][org-mode-for-writers] by Jay Dixit, who is a writer,
psycologist. It gives an introduction to how a writer got into emacs
who will probably never leave this space. My plan with emacs is to use
it for all my personal work, right from logging workout data to
writing my blog. I have successfully converted all my logging data
files to plain text, over which I can operate later using unix
commands on a linux terminal. For references to what I am talking
about, check out [unix-for-poets][unic-for-poets] for manuplating
text.

[unix-for-poets]:https://web.stanford.edu/class/cs124/kwc-unix-for-poets.pdf

For blogging I was having some issues. I was not able to get certain
things working. 

### Blogging

My setup with blogging is that I write posts in plain text markdown
format and [jekyll][jekyll] subsequently converts it to html and just
pushing this to git allows me to have a static website online via github.

[jekyll]:https://jekyllrb.com/docs/github-pages/

The problem now is that I would like to write in org mode and have the
workflow as described
[here](http://orgmode.org/worg/org-tutorials/org-jekyll.html) and
[here](http://www.grantschissler.com/blog/2015/04/10/org-jekyll-github.html). I did as suggested with adding the text to
the init file. The workflow suggested was to write in org-mode and
then subsequently export html to the right location with one click  and the site
should work as it used to. I don't know what went wrong, somehow it
didn't work the way it was supposed to. 

I also tried writing in org mode and then exporting it to markdown
into the folder I wanted (all with one click to export), but it was much more
involved and complex. Having spent quite some time and having had some issues, I
gave up on it. 

With its foot quite deep into the philosopy of org-mode, comes another
mode called Markdown mode.



---

## Markdown mode

Markdown mode is the currently what I use. Installation is simple as
explained in the above sections. This mode has the basics that I need,
such as visibility cycling and highlights the headings, although not in
different colours according to their level (as in org-mode).

Check [this link](https://github.com/defunkt/markdown-mode), for more info.

	



---

## Conclusion

Emacs as hyped by everyone who uses it, who have jumped to using it
after 15 years is crazy. My current usage of emacs already shows me
the power it has. 

I conclude my current learning with emacs and how I started up. I love
it and I am sure I would like to customize so many things. For now I
have markdown mode and a word counter installed, with which I can set
writing goals. Other things I wanted to do are as in the todo list
below. For example icicles, apparently allows [to search for commands
in a neat
way](https://emacs.stackexchange.com/questions/37763/lazy-find-search-for-commands-within-emacs/37790?noredirect=1#comment59514_37790),
w3 a web browser within emacs allows to just extract the links I
need. But all these are quite involved and I don't know how to install
them yet. They don't come as packages. They seem to have a particular
method of installation, which I need to explore and try, something that has to do with
the `%PATH` variable.

Otherwise, I find emacs really interesting, I wouldn't go back to my
old editors such as gedit and atom. 

The overall journey until my current understanding would be estimated
at ~20 hrs. Currently I would have spent about 30-40 hrs including
writing and editing this post.

P.S
google and stack will always be your friends. Feel free to ask
questions on stack, once you have done your due research. The
community is active and amazing. Please stick to their code of
conduct while writing questions.

Peace. 


---

## TODO's

* TODO figure out how to install other things as per emacswiki
* TODO Figure out how to use the web browser from emacs
* TODO figure out how to write similar to org mode and convert it to
	markdown or html.
