---
layout: post
comments: true
title:  "A new beginning- Emacs"
date:    26-12-2017 15:00
categories: The Beginning
permalink: /:title.html
published: True

---
## TODO's


##  Why Emacs

An STM suggested to me that if I am looking for something over the long term (20
years or more) I should check out EMACS. [This video][emacs_video] showed how
emacs could be used by writers, people who are not programmers, people who would
like their shit to be not clumsy AF, People who would like to free their mind of
the all the shit that is hindering your progress. 

[emacs_video]:https://www.youtube.com/watch?v=FtieBc3KptU

You want to be at your creative best and not be bogged down by shit like
formatting and the like (for example writing in word and bleeding from your eyes
as you get shit done). Plus the things that org-mode can do are really fancy
as mentioned in [the same video linked above][emacs_video], they give us better
control over what we are writing with simple key strokes.

In summary, 

- you don't have to move your hands to the right (dark) side of your keyboard.
- emacs has keybindings (shortcuts) for basic movement, without moving to the
  right side of your keyboard 
- we write in plane text and plane text only.
- org-mode allows to see just the headlines, minus the text with simple
  keybindings
- You can split the screen which ever way you want (all with hot keys) and
  screens can be mirrored with one side showing outline of the doc and the other
  showing everything else.
- Writers, programmers, academicians all praise this software and claim to have
  switched from others because EMACS fucking kills. 
- I am sold!
- I have only scratched the tip of the iceberg I suspect. I want to do much much
  more with it.

>Yes, my friends, it is true. After more than fifteen years using Vim, teaching
>Vim, proselytizing about Vim, all the while scoffing in the general direction
>of Emacs, I’ve seen the light. The light of Lisp… Or something. -
>Aaron bieber

There is a whole community, some special metions with creation of
documentation and some interesting modes would be Ian Barton and
Carsten Doiminik.

## Getting started

### Installation basics

Installing from the ubuntu software centre is possible, but for some
reason it didn't install the latest version. I followed the
installation procedure [here][ask-ubuntu-installation]. I am
replecating the infor here.

	$ sudo add-apt-repository ppa:ubuntu-elisp/ppa
	$ sudo apt-get update
	$ sudo apt-get install emacs-snapshot

In case you already installed an older version of emacs use the
following to remove the current running version:

	$ sudo apt-get remove --auto-remove emacs

I ran into [this error][emacs-stack-error-thej] whence I had the old
installation. Maybe it is not necessary to fix do it right away, but
keep it in mind. Many packages including Helm and Markdown-mode didn't work.

[emacs-stack-error-thej]:https://stackoverflow.com/questions/47983227/helm-installation-package-emacs-24-4-unavailable/47985613?noredirect=1#comment82941695_47985613

[ask-ubuntu-installation]: https://askubuntu.com/questions/598985/how-to-upgrade-to-the-latest-emacs

### Things to know 

One of the ideas behind emacs is to allow you to write efficiently
without having to do silly key strokes that would involve moving your
entire arm to another location. Bear with the initial discomfort, and
it will pay off. 

We are not going to use the up, down, left, right, delete, home, end
page up buttons when we are in emacs. 

I would imagine it best to go through the emacs tutorial (the tutorial
you can find as soon as you open emacs) first, but if it is too big
this one works as well.

#### Basic navigation

In this document as well as in every other documentation in the world
on emacs `C-x` stands for `Hold Ctrl and type x`. Similarly
keybindings with the Alt key/Meta key is denoted as `M-x` for example,
`M` stands for the `Meta/Alt` key.


| Command                | what it does                      |
|------------------------|-----------------------------------|
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
| C-g or <Esc><Esc><Esc> | To cancel any command you started |
|                        |                                   |

Use Using `M` instead of `C` for the last 4 commands shows a different
but similar usage of the command.


Thats the basics of navigation


#### Terminology

buffer: Every space where we type of help is displayed or anything is
displayed is called a buffer. A file opens into a buffer.

Frame: the whole graphical screen with all the different buffers if
any is called the frame.

Mode line: This is the line you see at the bottom with the file name,
percentage scrolled in the file, line number and other things.

Modes: In the Mode line you will see something like this,
`Fundamental`. This denotes the mode in which you are writing. Think
of modes as the way emacs understands how the file should be indented
and colored, speaking in a lay way. Check out `C-h m` to get more infor about your current mode

Once you press `C-h m` you will see two things a mjor mode and several
minor modes. Major mode defines how certain indentations happen with
emacs and the colour scheme etc... If I am using markdown I will use
Markdown mode. If I wan't to use ORG I will use ORG-mode. Minor modes
are addiations that can be added to any Major mode. For example, say I
want to count the number of words in my doc. Then I am looking at the
minor mode `WC` which can be added to any major mode.

Echo area: When ever we type any commands they will appear in the
bottom empty space. It is also called the Mini buffer sometimes.




#### Files related

| Command | What it does                                                      |
|---------|-------------------------------------------------------------------|
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



#### Help features!

| Command   | what it does                                    |
|-----------|-------------------------------------------------|
| C-h c C-p | small description in mini buffer                |
| C-h k C-p | opens help buffer                               |
| C-h f     | type function and get help in buffer            |
| C-h a     | search for commands meta only I think           |
| C-h i     | primary documentation to use accroding to help! |
| C-h m     | Informs about the current mode in a buffer      |

#### Windows

| Command   | what it does                                 |
|-----------|----------------------------------------------|
| C-x o     | Move cursor to other buffer                  |
| C-x 1     | keep only current buffer open                |
| C-x 2     | Split screen horizontally with duplicate     |
| C-x 3     | Split scree vertically with duplicate        |
| C-x 4 C-o | Display different buffer in the other buffer |


#### Interesting options

The `Meta/Alt-x` (Meta key followed by x)

| Command                | What does it do                                                   |
|------------------------|-------------------------------------------------------------------|
| M-x org-mode           | toggles to org-mode                                               |
| M-x Markdown-mode      | toggles to corresponding mode                                     |
| M-x auto-fill-mode     | toggles to the corresponding minor mode                           |
|                        | Auto fill makes sure the character-column-width is constant       |
| C-x C-+                | Zoom in                                                           |
| C-x C--                | Zoom out                                                          |
| C-/                    | undo                                                              |
| C-f followed by C-/    | [redo][redo-stack]                                                |
| C-g or <Esc><Esc><Esc> | To cancel any command you started                                 |
| C-x f                  | to inform                                                         |

[redo-stack]:https://stackoverflow.com/questions/3527142/how-do-you-redo-changes-after-undo-with-emacs

**Quick P.s** I was blown away while writing this table in Markdown
mode. The fact that someone actually thought about it in this way, and
the naturalness of using a table with a tab and the whole self
adjusting nature of the table... Kill me!

This is what I constantly see online, people madly in love with this
invention. And people crying and preeching others to use this madness
that is EMacs.

### Configuration

This is the part that is sort of hard to grasp within emacs.

#### First things first

From [init-wiki][init-wiki],

>For GnuEmacs, your init file is ~/.emacs, ~/.emacs.el, or
>~/.emacs.d/init.el. You can choose to use any of these names. ‘~/’
>stands for your home directory.

[init-wiki]:https://www.emacswiki.org/emacs/InitFile




#### Pacakages installation



## Org mode the farthest I have come

## Markdown mode




