---
layout: post
comments: true
title:  "Learning Data science- Notes"
date:    13-08-2018 08:39
categories: notes
permalink: /:title.html
published: True
---

## Installation of R and Rstudio in Linux and setting it up with Emacs

Refer [here.](/R-installation.html)

## Asking a data science question

- What is the question you are trying to answer ?

- What steps or tools did you use to answer it?

- what did you expect to see?

- What did you see instead?

- what other solutions have you thought about?

- What is your system info

[Coursera course on data sceince](https://www.coursera.org/learn/data-scientists-tools/lecture/KPkZz/getting-help)

## Help sources

- `Crossvalidated` is some sort of forum to ask for DS questions.

[Source: Coursera ](https://www.coursera.org/learn/data-scientists-tools/lecture/6zxii/finding-answers)

[r-help@r-project.org](r-help@r-project.org) is the mailing list that could be for
	questions on R if needed as part of the DSS course.
		
## Installing R packages required

Packages are usually found on CRAN or Bioconductor Project. More info
on `c1-w2-installing-R-packages` file. To install a package:

	install.packages("package-name1")
	
It also installs the dependencies automatically.

In case you want to use Bio conductor:

	source("http://bioconductor.org/biocLite.R")
	biocLite()
	
	biocLite(c("package-name1","package-name2"))

You can also install packages directly on RStudio. `Tools --> install
R package`.

To load a library use:

	library(package-name)
	
To look at what functions are there in the library:

	search()
	
## How to share data

Using data to share

	www.figshare.com

or 

use [www.github.com/jtleek/datasharing](www.github.com/jtleek/datasharing) github page to learn more
about data

## R important commands

Useful for discovering new commands

	> help.search("concatenate")

