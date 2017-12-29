---
layout: post
comments: true
title:  "Notes on emacs"
date:    18-12-2017 19:39
categories: The Beginning
permalink: /:title.html
published: False

---

org-mode by using indirect buffer,~ vertical split screen~, and visibility cycling. All handled via hotkeys.

clone window direct buffer... split screen?

reg-x split screen
org  bullets

google from within emacs


abbrev mode stuff

search files within directory, oh how convinient rgrep

back ground and foreground color 

---

### Notes from the emacs document



	C-x C-f		Find file
	C-x C-s		Save file
	C-x s		Save some buffers
	C-x C-b		List buffers
	C-x b		Switch buffer
	C-x C-c		Quit Emacs
	C-x 1		Delete all but one window
	C-x u		Undo


replace text!

>> Move the cursor to the blank line two lines below this one.
   Then type M-x repl s<Return>changed<Return>altered<Return>.

COPY

C-Spc to select
M-w to copy
C-y to Yank



Dont worry about saving... trust in auto save mode for every 300 characters--> check this???

quit by C-x and C-c so that you save everything before you get aat a here!

C-x o to switch between visble buffers

C-h for help

C-h m for help regarding the current mode

C-x k to kill a buffer without saving

C-x 1

C-x 2 horizontical split
C-x 3 vertical split

C-x 4 C-f opens new file in the horizontal split


C-x o to move to move cursor to other visible buffers!
C-x s,r to search forward and revers!
echo area is the area which echoes percentage of document

mode line!

auto-fill-mode useful for breaking lines of 70 characters automatically
use C-x f to inform the number of characters! to refill the paragraph use M-q

to check what minor modes are running and what major mode scene is, we need to to C-h m



frames- windows basically new wiondow... M-x make-frame, delete-frame
echo area
buffer
mini buffer
mode line



help
C-h c C-p small description in mini buffer
C-h k C-p opens help buffer
C-h f org-mode help in buffer
C-h a search for commands meta only I think
C-h i primary documentation to use accroding to help!



Look in the manual for dired and see how to handle files if need be!

### Things I want to do

- split screen
- org mode
- be able to enlarge and shorten parts

- color for markdown texts! markdown mode or sumpin!

~- search in file~
- search for file using key words (https://www.emacswiki.org/emacs/Icicles_-_File-Name_Input)
- redo
- copy how to witin emacs and externally

- reading browser in emacs due to percentage setup 
- switching to other buffers using key bindings and creating functions!

- number of words and variations via org-mode
- change all things in screen to required character count 
C-x 100 for example,, without having to M-q
until now spent about 7 hrs

