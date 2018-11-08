---
layout: post
comments: true
title:  "Setting up Latex with Emacs"
date:    06-08-2018 08:39
categories: notes
permalink: /:title.html
published: True
---

## Goal

I would like to write my resume and cover letter in Emacs. With this
post I want to log what all I did to setup Emacs and how to get Latex
working.

I would I ideally want a pdf on the right (within or not within
Emacs), and left side to have the text.

How to easily install auctex?

How to manage packages within auctex?

How to display the pdf output?

how do make a simple document with hello world.

## Info

>The AUCTeX package provides more advanced features for editing TeX
>and its related formats, including the ability to preview TeX
>equations within Emacs buffers. Unlike BibTeX mode and the RefTeX
>package, AUCTeX is not distributed with Emacs by default.


[AUCTeX also provides auto-completion for TeX commands](http://www.gnu.org/software/auctex/manual/auctex.html#Completion).

>AUCTeX provides some LaTeX specific commands which you should learn,
>make sure to checkout the commands for creating macros, C-c Enter,
>and environments, C-c C-e, LaTeX-math-mode and the RefTeX commands
>for inserting citations and cross-references

Apprently there is this thing called YASnippet as described in [Working
with templates](https://tex.stackexchange.com/questions/51204/working-with-templates/51250#51250).

### Compiling

>When it comes to compiling you can use latexmk as described above but
>you can also use AUCTeX built-in compiling method which is quite good
>(C-c C-c). To view the output of the current buffer simply do C-c
>C-v.

## Latex for linux

I started with this [simpletons guide, which was not
really simple](https://tex.stackexchange.com/questions/50827/a-simpletons-guide-to-tex-workflow-with-emacs).

>If you're using a distro which packages LaTeX (almost all will do)
>then look for texlive or tetex. TeX Live is the newer of the two, and
	>is replacing tetex on most distributions now. -[stack](https://stackoverflow.com/a/1017170/5986651)

[Latex for linux ](https://stackoverflow.com/a/1017170/5986651) stack website suggests the use of `texlive`
package. This allows for the use of latex in all its glory. There are
[different packages](https://tex.stackexchange.com/questions/245982/differences-between-texlive-packages-in-linux/246215)/types of installations such as:

> texlive-full
> texlive-latex-base
> texlive-latex-extra
> texlive-latex-recommended
> texlive-generic-extra

`texlive-full` probably has everything. `texlive-latex-base` contains
essential packages and so on.

>You can always just start with texlive-latex-base and then just
>install the collections you need. (To find a collection with a
>package in use `apt-cache search pacakge`) There is no good way yet to
>install individual packages in Ubuntu, as `tlmgr` will run in user mode
>(installing packages only for one user). - [stack](https://tex.stackexchange.com/questions/245982/differences-between-texlive-packages-in-linux/246215)

Point being that I might run into problems later if I need this for
more than one user. Unlikely to be my case. If that is what happens
then I can always remove and install the full thing. For now I see
this as an opportunity to understand and install what I need, to get
knowledge regarding this. 

So I think I did

	sudo apt-get install texlive-latex-base

To check if a package is installed use

	apt list --installed texlive-latex-base
	
output:

	texlive-latex-base/xenial-updates,xenial-updates,xenial-security,xenial-security,now 2015.20160320-1ubuntu0.1 all [installed]
	N: There is 1 additional version. Please use the '-a' switch to see it

	
## Configuring emacs to work with AUCTeX

How this whole thing will look is shown as in the video [here](https://www.youtube.com/watch?v=UjprbZl_m6Y), it is a good start to
get a feel of what is happening!

Apparently you need latexmk

	sudo apt-get install latexmk
	
But it is a package in emacs? I thought and I removed it along with
dependencies using

	sudo apt-get purge latexmk
	sudo apt-get purge --auto-remove latexmk
	
But it turns out you need latexmk (latex make)

>LatexMk is a Perl script for running LaTeX the correct number of
>times to resolve cross references, etc; it also runs auxiliary
>programs (bibtex, makeindex if necessary, and dvips and/or a
>previewer as requested) --- [emacswiki on latexmk](https://www.emacswiki.org/emacs/LatexMk)

So I don't know any more about it other than that it is needed for
something and everyone seems to be using it. In case I had bib or
something, it would take care of running Latex the necessary number of
times.

So 

	sudo apt-get install latexmk
	
Add to init file based on the [git repo](https://github.com/tom-tan/auctex-latexmk). Install `auctex-latexmk`
and then 

	(require 'auctex-latexmk)
    (auctex-latexmk-setup)

In the case of my init file this is accomplished by adding
`auctex-latexmk` to the list of packages to be installed and then
adding `(auctex-latexmk-setup)` to the `packages-init.el`. 

## Running emacs
This seems to be the basic setup that you need to type `C-c C-c` and
start with `latexmk` to make all the necessary files. And then `C-c
C-c` with `View` to display PDF. Viewing is only done once to open a PDF.

	TeX-evince-sync-view
	
[souce](https://tex.stackexchange.com/questions/106889/change-view-command-in-emacs-and-auctex-pdf-mode)

## Hooks

- Line number

		(add-hook 'LaTeX-mode-hook 'linum-mode)

- folding

		(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1))); Automatically activate
					; TeX-fold-mode.

There are a lot of hot keys to remember if you want to fold using
TeX-mode-hook [as mentioned here](ftp://ftp.tu-clausthal.de/pub/mirror/gnu/www/software/auctex/manual/html_node/Folding.html)

- folding like `org-mode` with `outline-minor-mode` or `Latex-extra`
  as explained [here](https://emacs.stackexchange.com/a/362/17941)
  
  (add-hook 'LaTeX-mode-hook #'latex-extra-mode)
  (add-hook 'LaTeX-mode-hook #'outline-minor-mode)

The keybinds it defines are a little hard to use for `outline-minor-mode`, so you might want to change some of them.

	C-c @ C-a       show-all
	C-c @ C-c       hide-entry

For `Latex-extra`

>Similar to how org-mode hides and displays of subtrees, if you hit
>TAB on a section header latex-extra will hide the contents of that
>section for you. Hitting tab twice will expand it again.  This will
>not interfere with whatever with other keybinds you have set for TAB,
>such as yasnippet or auto-completion.  Shift-TAB will do the same for
>the entire buffer.  Of course, the same goes for chapters,
>subsections, etc.

This is what I want! 


## preview-latex

`AUCTeX` already comes with `preview-LaTeX` apparently. The power of
it can be seen in this [video](https://www.youtube.com/watch?v=atIhEDQSI1U). It apprently can preview within the
editor how say equations will acutally look, how plots will actually
look.


## Info- engines/ compilers

> Engines: TeX, pdfTeX, XeTeX, LuaTeX, … These are the actual
> executable binaries which implement the different TeX dialects. The
> LaTeX format is implemented with both the pdfTeX (pdflatex) and
> XeTeX (xelatex) engines, for example. When someone says “TeX can't
> find my fonts”, they usually mean an engine.

> Formats: LaTeX, plain TeX, pdfLaTeX, … These are the TeX-based
> languages in which you actually write documents. When someone says
> “TeX is giving me this mysterious error”, they usually mean a
> format.
>
> At a high level, the output format that gets used depends on the
> program you invoke. If you run latex (which implements the LaTeX
> format), you will get DVI; if you run pdflatex (which also
> implements the LaTeX format), you will get PDF.

>pdflatex is a terminal command that tells the pdfTeX engine to use
>the LaTeX format.
> --- [stack](https://tex.stackexchange.com/a/63995/97901)

According to the source mentioned below, you can choose engine by 

	M-x customize-variable RET
	TeX-engine RET
	
Also you can check which engine is being used now:

	C-h v TeX-engine

[Source](https://tex.stackexchange.com/questions/53530/how-to-change-default-compiler)

### Diff type of engines and meanings and usage in emacs

[Source](https://tex.stackexchange.com/a/13601/97901)

[How to choose other engines/compilers](https://tex.stackexchange.com/questions/21200/auctex-and-xetex)

## Resume

### 1 page academic CV's

https://www.quora.com/What-are-some-elegant-serious-LaTeX-templates-for-an-academic-CV

Widely known 1 column CV 1 page

http://www.tjansson.dk/2009/03/writing-a-cv-in-latex/

MIT format

https://github.com/sb2nov/resume


## Error handling with latexmk

Dealt with as and when the need arises! After a compile if you get errors.

	C-c `
	
Look for error online and then go 
### finding things in a package

On http://packages.ubuntu.com/ you can search for packages containing
some file.

[Source](https://askubuntu.com/questions/822996/error-message-when-compiling-latex-in-ubuntu)

### Package missing

- `marvosym` missing, 

	sudo apt-get install texlive-fonts-recommended
	
[Source](https://tex.stackexchange.com/questions/4264/latex-error-file-marvosym-sty-not-found)

- `fonstpec.sty` not found

	Found that it was in `texlive-latex-recommended` from
    http://packages.ubuntu.com/. and installed it.
	
		apt list --installed texlive-latex-recommended
		sudo apt-get install texlive-latex-recommended
	
- At this point I get an error : `“Latex: problems after [0] pages”`

No use searching online. So I changed to `luatex` with `C-h v
TeX-engine` and then I got these and followed the same way as above.

- `luaotfload.sty` is missing 

	installed `texlive-luatex`
	
- `xunicode.sty` is missing

	install `texlive-xetex`??? but it works
	
	[Source](https://tex.stackexchange.com/a/328221/97901)
	



## bib

Currently I have nothing setup for it. Read here for more info:
https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib

`*.bib` file is what we need with the bib info which is then converted
by Latex appropriately with the appropriate commands!
	
## Reflection

I probably spend too much time just trying to understand things too
well (parkinsons law). I am making notes, if I have to do this
again. I suspect I might have to do this every 5 years once I loose
the LTS of ubuntu. I am trying to understand on a high level what
exactly I am doing. I suspect it to be useful in debugging and keeping
track of what I have done to my pc, adding packages and removing them
in case of conflicts as and when necessary. Learning in some sense,
just-enough and possibly also more than just-enough.


I look at these notes after 3 months and I feel like I am on track,
all knowledge is saved in a seemingly clear format to pick up
from. Although maybe I could regain this knowledge, but also I think
it is painful to search your ass off and start again.

## References

[Emacs-wiki](https://www.emacswiki.org/emacs/AUCTeX)
[Guide to emacs, as stack question](https://tex.stackexchange.com/questions/50827/a-simpletons-guide-to-tex-workflow-with-emacs)
[auctex key-bindings](https://tex.stackexchange.com/questions/20843/useful-shortcuts-or-key-bindings-or-predefined-commands-for-emacsauctex)
[quick start to Auctex by GNU](https://www.gnu.org/software/auctex/manual/auctex.html#Quick-Start)
[AucTeX extension for TikZ](https://tex.stackexchange.com/questions/19856/auctex-extension-for-tikz)
[my init file / config](https://github.com/agent18/emacs-config)

## Appendix: What is memoir, beamer and tix

I see this word appearing now and then in the [Guide to emacs, as
stack question](https://tex.stackexchange.com/questions/50827/a-simpletons-guide-to-tex-workflow-with-emacs), "memoir". A [quick investigation](https://texblog.org/2012/07/03/fancy-latex-chapter-styles/) shows that it
is a document class which is more flexible in terms of chapter styles,
than 'report' or 'book'.

[Beamer ](https://www.sharelatex.com/learn/Beamer) is for creating powerful presentations.

[Tikz](https://www.sharelatex.com/learn/TikZ_package) is for creating graphics elements. Such as adding plot
details legends etc.. with data points or, even just creating and
drawing lines as necessary.
