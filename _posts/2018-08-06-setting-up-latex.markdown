---
layout: post
comments: true
title:  "Setting up Latex with Emacs"
date:    06-08-2018 08:39
categories: drafts
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

## Configuring emacs to work with 

Apprently you need latexmk

	sudo apt-get install latexmk
	
## Testing

First test 


## Reflection

I probably spend too much time just trying to understand things too
well (parkinsons law). I am making notes, if I have to do this
again. I suspect I might have to do this every 5 years once I loose
the LTS of ubuntu. I am trying to understand on a high level what
exactly I am doing. I suspect it to be useful in debugging and keeping
track of what I have done to my pc, adding packages and removing them
in case of conflicts as and when necessary. Learning in some sense,
just-enough and possibly also more than just-enough.



## References

[Emacs-wiki](https://www.emacswiki.org/emacs/AUCTeX)
[Guide to emacs, as stack question](https://tex.stackexchange.com/questions/50827/a-simpletons-guide-to-tex-workflow-with-emacs)
[auctex key-bindings](https://tex.stackexchange.com/questions/20843/useful-shortcuts-or-key-bindings-or-predefined-commands-for-emacsauctex)
[quick start to Auctex by GNU](https://www.gnu.org/software/auctex/manual/auctex.html#Quick-Start)
[AucTeX extension for TikZ](https://tex.stackexchange.com/questions/19856/auctex-extension-for-tikz)

## Appendix: What is memoir, beamer and tix

I see this word appearing now and then in the [Guide to emacs, as
stack question](https://tex.stackexchange.com/questions/50827/a-simpletons-guide-to-tex-workflow-with-emacs), "memoir". A [quick investigation](https://texblog.org/2012/07/03/fancy-latex-chapter-styles/) shows that it
is a document class which is more flexible in terms of chapter styles,
than 'report' or 'book'.

[Beamer ](https://www.sharelatex.com/learn/Beamer) is for creating powerful presentations.

[Tikz](https://www.sharelatex.com/learn/TikZ_package) is for creating graphics elements. Such as adding plot
details legends etc.. with data points or, even just creating and
drawing lines as necessary.
