---
layout: post
comments: true
title:  "Learning R"
date:    06-10-2018 
categories: notes
tags: R, learn
permalink: /:title.html
published: TRUE
---


## R on emacs

Look [here for the installation and setup of R on Emacs](/R-installation.html).

### Using R basics

To get a console simply do:

	M-x R
	
The setup we now want to have is R editor on the left and R console on
the right. Create `testing.R` file. Run `C-x 3` to split the
window. Go to the other window (`C-x 0`). Open the console using `M-x
R`. The [following command](https://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/) will run the file in the console:

	C-c C-l

Some more helpful configuration things are given in
[here](https://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/). This shall be taken into account later if needed.

`_` key is bound to `<-` by default in the `ESS`
mode. `ESS-smart-underscore` tries to overcome this issue (I have not
yet tested how).

https://stackoverflow.com/questions/15289995/how-to-get-help-in-r

### Useful Keybindings, shortcuts

	C-c C-v Help for object
	
[Source](http://ess.r-project.org/refcard.pdf) has lots of other R ESS Emacs Key bindings

## R packages and needed installation

When R is downloaded from CRAN we get the "base" R system. Primary
location to obtain 

### Installing R packages required

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
### Installing xlsx 

This is particularly painful to get, considering something about my R
version being 3.5. 

`install.packages(xlsx)` will give an error saying you have error with
rJava. In order to install rJava follow the procedure below:

	sudo apt-get install default-jdk
	sudo R CMD javareconf
	
	sudo apt-get install r-cran-rjava

This is where you will have more errors something like this:

	the following packages have unmet dependencies:
	r-cran-rjava : Depends: r-api-3.4
	E: Unable to correct problems, you have held broken packages.

So I followed this answer from [stack](https://stackoverflow.com/a/51267282/5986651). Which would the following
on the terminal:

	sudo add-apt-repository ppa:marutter/c2d4u3.5
	sudo apt-get update

Then coming back to the rjava installation:

	sudo apt-get install libgdal-dev libproj-dev
	
And finally in your R console (Rstudio or terminal)

	install.packages("rJava")
	
This followed by `install.packages("xlsx")` should do the trick. For
the main installation of `rJava` I looked [here](https://github.com/hannarud/r-best-practices/wiki/Installing-RJava-(Ubuntu)).

### installing XML 

From [Stack-answer here](https://stackoverflow.com/a/7765470/5986651), Go to terminalR* and do:

	sudo apt-get update
	sudo apt-get install libxml2-dev
	
followed by `install.packages("XML")`. It works!

Sometimes `RCurl` might also be needed. 

Looks like I broke my R installaiton or 3.5 is unstable?

### installing RCurl

from [this answer ](https://github.com/sagemath/cloud/issues/114#issuecomment-230481254), go to terminal and do:


	sudo apt-get install libcurl4-openssl-dev
	
It works! after this.


### installing MySQL

According to [here, we can use APT to install](http://dev.mysql.com/doc/refman/5.7/en/installing.html), nothing more is
given. So I try based on [digitalocean](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04):

	sudo apt-get install mysql-server
	
	
Running security script,

	mysql_secure_installation
	
>This will prompt you for the root password you created in Step 1. You
>can press Y and then ENTER to accept the defaults for all the
>subsequent questions, with the exception of the one that asks if
>you'd like to change the root password. You just set it in Step 1, so
>you don't have to change it now.
	
	mysql_install_db    # before 5.7.6
	mysqld --initialize #for 5.7.6
	
You are supposed to get this error:

	2016-03-07T20:11:15.998193Z 0 [ERROR] --initialize specified but
	the data directory has files in it. Aborting.
	
But I got this:

	[Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).

According to [fromdual](https://www.fromdual.com/node/1279), the suggestion is to just follow the
advice of the error. Some functionality is being deprecated.

>Our advice is to enable the variable explicit_defaults_for_timestamp
>now on your testing systems so you can see if your application behave
>well and then you are prepared for the next release when this feature
>will become the default.

>In short term this warning is NOT dangerous. In the long term you
>have to be prepared for the deprecated functionality. You get rid of
>the warning my setting explicit_defaults_for_timestamp = 1 in your
>my.cnf [mysqld] section.

You can [find the `my.cnf`](https://stackoverflow.com/a/2485758/5986651) file in the following locations, and in
this order the values override each other:

- /etc/my.cnf
- /etc/mysql/my.cnf
- $MYSQL_HOME/my.cnf
- [datadir]/my.cnf
- ~/.my.cnf

You can also [find your file](https://stackoverflow.com/a/2482474/5986651) by 
	
	find / -name my.cnf

I added the following in /etc/mysql/my.cnf
	
	[mysqld]
	explicit_defaults_for_timestamp = 1

Now try 

	mysqld --initialize

And I got a reduced error without Timestamp stuff

	mysqld: Can't create directory '/var/lib/mysql/' (Errcode: 17 - File exists)
	2018-11-12T20:13:45.024116Z 0 [ERROR] Aborting

Is this good? Not sure so I look deeper. According to this [accepted stack
answer for the error](https://askubuntu.com/a/797696/443958) you need to

	sudo -i #log into root
	cd /var/lib/mysql
	rm -r *
	
	su username  # get back to the original user

	mysqld --initialize 
	
This, still gave me the exact same error.

	mysqld: Can't create directory '/var/lib/mysql/' (Errcode: 17 - File exists)
	2018-11-12T20:13:45.024116Z 0 [ERROR] Aborting
	
I am not sure the accepted answer helped at all with the removing the
`/var/lib/mysql`, but `sudo` helped:

	sudo mysqld --initialize
	
worked... No error at all!


Testing:

	systemctl status mysql.service
	
additional check:
	
	mysqladmin -p -u root version
	

In R,

	install.packages("RMySQL")
	
### installing for hdf5

This will install packages from Bioconductor http://bioconductor.org/,
primarily used for genomics but also has good "big data" packages Can
be used to interface with hdf5 data sets.  

	source("http://bioconductor.org/biocLite.R")
	biocLite("rhdf5")

[Source:jtleek github](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/02_02_readingHDF5/index.md)

### other packages installed

	"plyr", "Hmisc", "reshape","jpeg", "stringr", "lubridate",
	"quantmod", "reader", "rafalib","kernlab", "rmarkdown"
	
## Learning R

I am currently doing the Data Science Specialization at 40€/month on
Coursera (Course 2: R Programming).

My [DS repository](https://github.com/agent18/data-science-coursera) is on github.


### R commands that might be useful

- Useful for discovering new commands

		help.search("concatenate")
		
- syntax of new commands

		str(function)

- DATE 

		as.Date(Sys.time())
	
	Unclass removes all the formatting and stores the date as an
    integer from 1970-01-01.
	
		unclass(as.Date(Sys.time())

- TIME

	Used for storing in data frames

		p <- as.POSIXct(Sys.time())
		## [1] "2013-01-24 22:04:14 EST"
		y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")

	Used for getting difference.	

		p <- as.POSIXlt(Sys.time())
		p$sec

- strptime

		x <- strptime(datestring, "%B %d, %Y %H:%M")
		
- factor, table, attr

```R
> x <- factor(c("yes", "yes", "no", "yes", "no"))
> x
[1] yes yes no yes no
Levels: no yes
```
```R
attr(,"levels")
[1] "no" "yes"
```
- Missing values

	- is.na(); could be integer NA or character NA
	- is.nan(); NA is not NAN, but Nan is also NA
	
- clear variable space based on [this stack question](https://stackoverflow.com/questions/11579765/how-to-clean-up-r-memory-without-the-need-to-restart-my-pc)

		rm(list=ls())

- str 

	Gives one line info about a function. Compactly displaying large lists
	
		str(x)
		num [1:100] -1.87 -2.51 7.07 -1.93 3.53 ...

		> f <- gl(40,10)
		> str(f)
		Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1

	str is really useful to get quick info on structure of object. 

- summary

	    summary(x)
		Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
		-8.560  -1.445   1.225   1.583   4.454  13.904 
		
- loading and unloading libraries ([source)](https://stackoverflow.com/a/38416975/5986651)

		library(library_name_not_in_courts)
		detach("package:RMySQL", unload=TRUE)


### Calculating memory

According to [stack and the coursera course](https://stackoverflow.com/a/25675555/5986651), 

> memory required = no. of column * no. of rows * 8 bytes/numeric
>
> so for example if you have 1,500,00 rows and 120 column you will
> need more than 1.34 GB of spare memory required


### Loop functions

- apply 

		rowSums = apply(x, 1, sum)
		rowMeans = apply(x, 1, mean)
		colSums = apply(x, 2, sum)
		colMeans = apply(x, 2, mean)

- lapply (list): takes a list and applies a function over every element. Example to get the first column of each matrix in the list:
	
		lapply(x, function(elt) elt[,1])
	
- sapply: simplifying output of lapply
- mapply (list): `mapply(fun,variable_1_range,variable_2_range,...)`

``` R
>mapply(rnorm,1:3,c(4,4,4),c(0.5,0.5,0.5))
[[1]]
[1] 3.310842

[[2]]
[1] 3.369922 3.665328

[[3]]
[1] 3.917087 4.670286 3.666672
```
- tapply (list) : X has to be a vector; be careful 

	`tapply(X, level&index, function)`/ `lapply(split(x,
  f), mean)`

```R
> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> f
[1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3
[24] 3 3 3 3 3 3 3
Levels: 1 2 3
> tapply(x, f, mean)
1
2
3
0.1144464 0.5163468 1.2463678
```

- split: `split(dataframe, dataframe$month)`

	- Splitting more than one level can be done using interaction
	
			interaction(gl(2,5), gl(5,2))


### Examples using Loop functions

1. There will be an object called 'iris' in your workspace. In this
dataset, what is the mean of 'Sepal.Length' for the species virginica?


		library(datasets)
		data(iris)
	
	The answer is got by:
		
		iris$Sepal.Length[iris$Sp=="virginica"]
		
		mean(iris$Sepal.Length[101:150])
		
		s <- split(iris,iris$Speci)
		lappy(s,function(x) mean(x[,"Sepal.Length"]))
	
	sapply will simplify the results into a data frame which is cool
	
		s <- split(iris,iris$Speci)
		sapply(s,function(x) mean(x[,"Sepal.Length"]))
		
	tapply cannot be used as X needs to be an atomic vector, not
    DataFrame, not list, but an [atomic vector](http://arrgh.tim-smith.us/atomic.html). But you can use it
    like this:
	
		tapply(iris$Sepal.Length,iris$Sp,mean)
		
	with `with`: Need to use full names of columns!
	
		with(iris,tapply(Sepal.Length,Species,mean))

### Debugging

Mostly you wont need them or you can get much far without using them

> Actually, I was using R for 6 years and didn't know about any of
> these functions - the teacher from Coursera

- traceback: Which function call you are in and where error occured
		
		traceback()
		
- debug: You say `debug(mean)` in your code and any time `mean()` is
  executed, it will stop at the first line and allow you to go line by
  line in a `browser`
  
		debug(mean)
		

- browser: In the console window you get this browser which doesn't
  need much explanation

- trace : allows you to insert debugging code into a function a specific places

- recover : allows you to modify the error behavior so that you can
  browse the function call stack *at the actual point of the error
  happening*. More importantly,
  
		options(error=recover)
		options(error=NULL)
		
	This will get you to the line just before the error gets
    triggered, and you can do somethings from there, what exactly you
    can do is not fully clear.
  
		



### Functions

- Lazy evaluation happens with functions where it returns and prints
  the last line, i.e., 

		f <- function(a, b) {
			a^2
		}
		f(2)    

	In case you don't want to print the returned value then use
    `invisible(a^2)` for example.
		
- Argument matching happens based on 
  
  - Check for exact match for a named argument
  - Check for a partial match
  - Check for a positional match
  
- you can also pass `...` as arguments, which will be passed on!

### Static or lexical scoping
	
- Basically it looks for the variable in the environment in which the
  function was defined. functions can be defined in either the global
  environment or the function environment.
  
``` R
y <- 10
f <- function(x) {
	y <- 2
	y^2 + g(x)
}
g <- function(x) {
	x*y
}
```
f(3) is 34.

As explained [here](https://darrenjw.wordpress.com/2011/11/23/lexical-scope-and-function-closures-in-r/) in better detail. Consider:

``` R
a=1
b=2
f<-function(a,b)
{
  return( function(x) {
    a*x + b
  })
}
g=f(2,1)
g(2)
```

Here `g=f(2,1)` **returns** a function which looks like:

``` R
g <- function(x){

	2*x+1
	
	}
```	

This is what happens in Lexical scoping.

### "<<-"

Apparently `<<-` this is used:

>The operators ‘<<-’ and ‘->>’ are normally only used in functions,
> and cause a search to be made through parent environments for an
>existing definition of the variable being assigned.  If such a
>variable is found (and its binding is not locked) then its value
>is redefined, otherwise assignment takes place in the global
>environment. --from the help


As said above, which is absolutely not clear, unless you read the
greatest explanation of all time, i.e., the man page. The basics of
Lexical scoping is fine. So when you have a function(parent) inside a
function(child), then the child inherits the variables defined in the
parent. [I.e.](https://darrenjw.wordpress.com/2011/11/23/lexical-scope-and-function-closures-in-r/),

``` R
a=1
b=2
f<-function(a,b)
{
  return( function(x) {
    a*x + b
  })
}
g=f(2,1)
g(2)
```
But, say you want to modify the parent variables from within the child
function, then you have to use `<<-` to gain access to modify the
parent variables. I.e., the example below from the R man page on
Scope. Excellent example, and description. Copied verbatim for future
direct reference.

>The special assignment operator, <<-, is used to change the value
>associated with total. This operator looks back in enclosing
>environments for an environment that contains the symbol total and
>when it finds such an environment it replaces the value, in that
>environment, with the value of right hand side. If the global or
>top-level environment is reached without finding the symbol total
>then that variable is created and assigned to there. For most users
><<- creates a global variable and assigns the value of the right hand
>side to it23. Only when <<- has been used in a function that was
>returned as the value of another function will the special behavior
>described here occur.

``` R
open.account <- function(total) {
  list(
    deposit = function(amount) {
      if(amount <= 0)
        stop("Deposits must be positive!\n")
      total <<- total + amount
      cat(amount, "deposited.  Your balance is", total, "\n\n")
    },
    withdraw = function(amount) {
      if(amount > total)
        stop("You don't have that much money!\n")
      total <<- total - amount
      cat(amount, "withdrawn.  Your balance is", total, "\n\n")
    },
    balance = function() {
      cat("Your balance is", total, "\n\n")
    }
  )
}

ross <- open.account(100)
robert <- open.account(200)

ross$withdraw(30)
ross$balance()
robert$balance()

ross$deposit(50)
ross$balance()
ross$withdraw(500)

```

The following example shows more meaning about `<<-` from [this ](https://stackoverflow.com/a/2630222/5986651)
stack answer.


``` R
new_counter <- function() {
  i <- 0
  function() {
    # do something useful, then ...
    i <<- i + 1
    i
  }
}

counter_one <- new_counter()
counter_two <- new_counter()

counter_one() # -> [1] 1
counter_one() # -> [1] 2
counter_two() # -> [1] 1
```



### Probability distributions

>Every distribution that R handles has four functions. There is a root
>name, for example, the root name for the normal distribution is
>norm. This root is prefixed by one of the letters

> - p for "probability", the cumulative distribution function (c. d. f.)
> - q for "quantile", the inverse c. d. f.
> - d for "density", the density function (p. f. or p. d. f.)
> - r for "random", a random variable having the specified distribution
> --- [Random website](http://www.stat.umn.edu/geyer/old/5101/rlook.html)

>For the normal distribution, these functions are pnorm, qnorm, dnorm,
>and rnorm. For the binomial distribution, these functions are pbinom,
>qbinom, dbinom, and rbinom. And so forth.
>
> For a continuous distribution (like the normal), the most useful
> functions for doing problems involving probability calculations are
> the "p" and "q" functions (c. d. f. and inverse c. d. f.), because
> the the density (p. d. f.) calculated by the "d" function can only
> be used to calculate probabilities via integrals and R doesn't do
> integrals.
>
> For a discrete distribution (like the binomial), the "d" function
> calculates the density (p. f.), which in this case is a probability
>
> f(x) = P(X = x) and hence is useful in calculating probabilities.
> --- [Random website](http://www.stat.umn.edu/geyer/old/5101/rlook.html)

Distributions' are Normal, Poisson, binomial etc...


- dnorm: gives the [probability density function](https://www.khanacademy.org/math/statistics-probability/random-variables-stats-library/random-variables-continuous/v/probability-density-functions), i.e., p.d.f,
  which is the value of probability for a given range of x, in P(~x)=F(x)
		
- pnorm: gives F(x) in P(X<=x)=F(x) i.e., c.d.f cumulative
  distribution function

- qnorm: gives x for a given P. based on x=F(P)^(-1) i.e., i.c.d.f,
  inverse cumulative distribution function

- rnorm: gives random variables in that distribution for given mean
  and standard deviation.


### Lists
**Quick aside - lists**


```r
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
```

```
$letters
[1] "A" "b" "c"

$numbers
[1] 1 2 3

[[3]]
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    6   11   16   21
[2,]    2    7   12   17   22
[3,]    3    8   13   18   23
[4,]    4    9   14   19   24
[5,]    5   10   15   20   25
```


[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

**Quick aside - lists**


```r
mylist[1]
```

```
$letters
[1] "A" "b" "c"
```

```r
mylist$letters
```

```
[1] "A" "b" "c"
```

```r
mylist[[1]]
```

```
[1] "A" "b" "c"
```


[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

[Source](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_01_editingTextVariables/index.md)

### Dataframe

- reading data with header column (default)

		outcome <- read.csv("outcome-of-care-measures.csv", colClasses
        = "character")
		head(outcome)
		
- quick look at data

		str(outcome[,11:16])
		head(outcome[,11])
		nrow(outcome)
		ncol(coucome)
		names(outcome)
- important need to actively remove NA if doing something like this:

		dim(data[data$val==24,1])
		
otherwise NA is also counted for some stupid reason!

### DataTable

- Much, **much faster** at creating sub-setting, group, and updating
  than DataFrame it appears.

- All functions that accept data.frame work on data.table
  

- creation (simple installation)

		library(data.table)
		DT =
		data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
		
- read and write table

	    write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
		system.time(fread(file))

- Sub-setting columns

		DT[,c(2,3)]

- subsetting rows
		
		DT[c(2,3),]
		DT[c(2,3),]

- and difference between DF and DT

		DF[c(2,3)]!=DT[c(2,3)]
		
	- If only the first argument is present `DF[c(2,3)]` gives
      columns. **and `DT[c(2,3)]` gives ROWS**

- Functions on columns

		DT[,list(mean(x), sum(z))]

	Result is still a DT.

		DT[,table(y)]

- Adding new columns

		DT[,w:=z^2]
		DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
		DT[,a:=x>0]
	
	- function `by`/based the column 'a'. A can be boolean, character
    (these make most sense, but probably even number can be used)
	
			DT[,b:= mean(x+w),by=a]
			
	- counting elements based on a factor

			DT[,.N, by=x]

- setting key helps in merging

	    DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
		DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
		setkey(DT1, x); setkey(DT2, x)
		merge(DT1, DT2)
		
	Merge happens based on X
	
		   x y z
		1: a 1 5
		2: a 2 5
		3: b 3 6
		
- help

		The latest development version contains new functions like
melt and dcast for data.tables
https://r-forge.r-project.org/scm/viewvc.php/pkg/NEWS?view=markup&root=datatable
Here is a list of differences between data.table and data.frame
http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table
Notes based on Raphael Gottardo's notes
https://github.com/raphg/Biostat-578/blob/master/Advanced_data_manipulation.Rpres,
who got them from Kevin Ushey.

^^copied from
[https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/01_09_dataTable/index.md](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/01_09_dataTable/index.md)


### expressions

	{
	x = 1
	y = 2
	}
	k = {print(10); 5}
	print(k)
	
	[1] 10
	[2] 5
	

## Handling different Data

- popular databases where data is stored SQL, MongoDB.

### file, downloading, directory
- geting and setting working directory

		getwd() 
		setwd()

- does file exist or not 

		file.exists("directoryName")
		dir.create("directoryName")

		if (!file.exists("data")){
			dir.create("data")
			}
			
- downloading a file from the internet


		download.file(fileUrl, destfile="./data/camera.csv", method="curl")
		list.files("./data")
		
- keep track of dateDownloaded

		dateDownloaded <- date()

- tab separated files or just normal text files with data are very
  well automatically loaded with this command.

		read.table("") 
		
- comma separated with `header=true`

		read.csv("")
		read.table("", sep="", header=TRUE)
		

	- other parameters that might be useful:
	
		- quote: tell r whetehre there are quoted values `quote=""`
          means no quotes
		  
		- na.strings: set character that represents a missing value
		- nrows: how many rows to read from the top
		- skip: how many rows to skip from the top



### Read and write text files

### fixed width files fwf
According to this [stack which is a question directly from
coursera](https://stackoverflow.com/questions/14383710/read-fixed-width-text-file), `read.fwf` is a function used to clean a fixed width
file.

The same thing can be done in several ways:
	
``` R	
library(readr)

x <- read_fwf(
  file="http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for",   
  skip=4,
  fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))
```

``` R
x <- read.fwf(
  file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
  skip=4,
  widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
```

'-' in -1 removes the columns quickly.

``` R
df <- read.fwf(
  file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
  widths=c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4),
  skip=4
)
```

``` R
x <- readLines(con=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"))

# Skip 4 lines
x <- x[-(1:4)]

mydata <- data.frame(var1 = substr(x, 1, 10),
                     var2 = substr(x, 16, 19),
                     var3 = substr(x, 20, 23),
                     var4 = substr(x, 29, 32)  # and so on and so on
                     )
```

However, having the header is a problem. Accorrding to `?read.fwf`
when using the `header` argument, you also need the `sep` argument.

The problem is discussed [here](https://stackoverflow.com/questions/21592616/error-in-read-fwf-when-header-true). If necessary the header and the content
can be separately attached. or go to the extent of modifying the data
to have useless delimiters.


### Excel

- installation was fucking intense. Look in the above sections for it.
- reading excel files uses package `xlsx`
		
		library(xlsx)
		read.xlsx("./data.xlsx", sheetIndex=1,
		header=TRUE,colIndex=7:15, rowIndex=18:23)
		
- writing 


		write.xlsx
		
- tips

	- `read.xlsx2` faster but unstable for subsets than `read.xlsx`
	
	- XLConnect package has more options for manipulating Excel data.

### XML

- example of XML [from w3schools](www.w3schools.com/xml/simple.xml)


``` XML
<breakfast_menu>
<food>
<name>Belgian Waffles</name>
<price>$5.95</price>
<description>
Two of our famous Belgian Waffles with plenty of real maple syrup
</description>
<calories>650</calories>
</food>
<food>
<name>Strawberry Belgian Waffles</name>
<price>$7.95</price>
<description>
Light Belgian waffles covered with strawberries and whipped cream
</description>
<calories>900</calories>
</food>
```
- for installation look in above sections on installing
  packages. Some work needs to be done for this package and it takes
  10-15 mins to install!
  
- Reding the file library is `XML`. The following **does not work**:

		library(XML)
		fileUrl <- "http://www.w3schools.com/xml/simple.xml"
		doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
		rootNode <- xmlRoot(doc)
		xmlName(rootNode)
		
		[1] "breakfast_menu"

		names(rootNode)


- Reading the file; file library is 'XML', from 
[this stack answer ](https://stackoverflow.com/a/23584617/5986651) and not the DSS course from coursera!

``` R
library(XML)
library(RCurl)
fileURL <- "https://www.w3schools.com/xml/simple.xml"
xData <- getURL(fileURL)
doc <- xmlParse(xData)
rootNode <-xmlRoot(doc)
```

- Also this works from the discussion formus of Coursera

``` R
library (XML)
library(httr)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(GET(fileUrl),useInternal=TRUE)
rootNode <- xmlRoot(doc)
```

`doc` variable has all the text in the xml file. `rootNode` has only the relevant XML info. 
	
- extracting info from `rootNode` or `xmlRoot(doc)`

		xmlName(rootNode)

		names(rootNode)

		
		rootNode[[1]]

		
		<food>
		<name>Belgian Waffles</name>
		<price>$5.95</price>
		<description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
		<calories>650</calories>
		</food> 

		rootNode[[1]][[1]]


		<name>Belgian Waffles</name> 
		
		xmlSApply(rootNode,xmlValue)
		
		
		"Belgian Waffles$5.95Two of our famous Belgian Waffle ...


- XPath is the language of XML or something like that. The following
  can be used to extract info from `rootNode`:


	- /node Top level node
	- //node Node at any level
	- node[@attr-name] Node with an attribute name
	- node[@attr-name='bob'] Node with attribute name attr-name='bob'

			xpathSApply(rootNode,"//price",xmlValue)
		
		
- Another example for XPath extraction based on
  [http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens](http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens)
  

		fileUrl <-
		"http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
		doc <- htmlTreeParse(rawToChar(GET(url)$content),
		useInternalNodes = TRUE)
		xpathSApply(doc, "//title", xmlValue)
		xpathSApply(doc,"//div[@class='score']",xmlValue)
		teams <- xpathSApply(doc,"//div[@class='team-name']",xmlValue)

Even if http moved to https it can handle. Another example is as
follows:

	library(XML)
	library(httr)
	url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
	html <- htmlTreeParse(rawToChar(GET(url)$content), useInternalNodes = TRUE)
	xpathSApply(html, "//title", xmlValue)
	xpathSApply(html, "//td[@class='gsc_a_c']", xmlValue)

Another way to do it is:

```R
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
```

This shit doesn't work `doc <-
htmlTreeParse(getURL(fileUrl),useInternal=TRUE)`.  
You are able to extract the elements in **tags** `div` of **class**
i.e., the teams and scores from the website. *The team-name doens't
work anymore as it is not a class anymore*


- help

	- [outstanding link to XML](https://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf)
	
	- [short link (wayback machine)](https://web.archive.org/web/20140906181450/http://www.omegahat.org/RSXML/shortIntro.pdf)
	
	- [long link (wayback machine)](https://web.archive.org/web/20141113153333/http://www.omegahat.org/RSXML/Tour.pdf)

#### Things that don't work with XML and html parsing

``` R
 url<- getURL("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en", ssl.verifyPeer=FALSE)
html<- htmlTreeParse(url, useInternalNodes = TRUE)
doc<-xpathSApply(html, "//title", xmlValue)
doc
[1] "302 Moved"
```

### JSON

- Similar to XML but different in syntax and format. 

- Simple installation in R using `install.packages()`. Has `curl'
  dependency though.
  
- It is a text file consisting of dataframes, each cell in the DF can
  also be a DF! 
  
- getting data

		library(jsonlite)
		jsonData <-
		fromJSON("https://api.github.com/users/jtleek/repos")
		
- getting the "column" names

		names(jsonData)
		
- getting certain "columns" from the data

		jsonData$id
		jsonData$column_name
		
- accessing jsondata nested data across all rows

		jsonData$owner$login

- Writing DF to json

		myjson <- toJSON(iris, pretty=TRUE)
		cat(myjson)

- help or further resources


	- http://www.json.org/
	- a good tutorial on jsonlite -
      [http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/](http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/)
	  
	- [json cran page](https://cran.r-project.org/web/packages/jsonlite/vignettes/json-mapping.pdf)
   






### MySQL

MySQL is a type of database software. Frequently used in internet
based applications. You need to install MySQL and install RMySQL for this.

>The MySQL™ software delivers a very fast, multithreaded, multi-user,
>and robust SQL (Structured Query Language) database server.
> --- [Source](https://dev.mysql.com/doc/refman/5.7/en/introduction.html)

Anyways, it looks like you need a server and client way of work. So
databases are stored in the server and accessed by the client. Still
very vague. but moving on. 

So I think what we are doing is we are running the server from within
out pc and that is what the installation of the server was all about.

- mysqld is the server executable (one of them)
- mysql is the command line client
- mysqladmin is a maintainance or administrative utility

#### Basics

Starting and stopping and checking status

Status:

	systemctl status mysql.service

Start: 
	
	sudo service mysql start
	
or

	sudo /etc/init.d/mysql start

Stop: 

	sudo service mysql stop
	
Accessing as the client once the terminal once the server is running is done by:

	mysql -u root -p


#### Connecting to servers online and using their stuff



[UCSC server](http://genome.ucsc.edu/) and instructions are [here](http://genome.ucsc.edu/goldenPath/help/mysql.html). 

**Library**

	library("RMySQL")

**Connecting:**

	ucscDb <- dbConnect(MySQL(),user="genome", 
                    host="genome-mysql.cse.ucsc.edu")
	result <- dbGetQuery(ucscDb,"show databases;");
	dbDisconnect(ucscDb);
	
	[1] TRUE

Result contains list of all databases.  **You can connect to a
particular database and extract its info.**

	hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                    host="genome-mysql.cse.ucsc.edu")
	allTables <- dbListTables(hg19)
	length(allTables)
	
Gives a list of tables in this database.  

Identifying info about the table in a particular database.

	dbListFields(hg19,"affyU133Plus2")
	dbGetQuery(hg19, "select count(*) from affyU133Plus2")


**Reading the table:**

	affyData <- dbReadTable(hg19, "affyU133Plus2")


**Getting a subset**

	query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
	affyMis <- fetch(query); quantile(affyMis$misMatches)

**Not accidentally getting a ton of data**

	affyMisSmall <- fetch(query,n=10); dbClearResult(query);

	dbDisconnect(hg19)


**SQL commands**

[List of mysql commands](http://www.pantz.org/software/mysql/mysqlcommands.html), [blog of other commands](http://www.r-bloggers.com/mysql-and-r/). 

#### SQL withing R without MySQL

`sqldf` library is used for the purpose of using sql on R data frames
directly.

According to this stack question, `sqldf` has to use a driver given by
the argument `drv`. If nothing is specified it looks for some other
libraries loaded and tries to use their driver, which is when for a
command like `sqldf("select * from df limit 6", drv="SQLite")` you get
errors reagarding driver.


So do one of the following:

	detach("package:RMySQL", unload=TRUE)
	options(sqldf.driver = "SQLite")
	sqldf("select * from df limit 6", drv="SQLite")

[Source](https://stackoverflow.com/a/49431382/5986651)

#### SQL queries

	sqldf("select distinct AGEP from acs")
	sqldf("select pwgtp1 from acs where AGEP < 50")

### HDF5

Hierarchical data format.

This lecture is modeled very closely on the rhdf5 tutorial that can be
found here:
[http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf](http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf)

**Start**

	library(rhdf5)
	created = h5createFile("example.h5")
	
**Create groups**

```R
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5") # list groups in the table
```

**Write groups**

Write matrix directly

```r
A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")
```

```
        group   name       otype  dclass       dim
0           /    baa   H5I_GROUP                  
1           /    foo   H5I_GROUP                  
2        /foo      A H5I_DATASET INTEGER     5 x 2
3        /foo foobaa   H5I_GROUP                  
4 /foo/foobaa      B H5I_DATASET   FLOAT 5 x 2 x 2
```


**Write data sets**


```r
df = data.frame(1L:5L,seq(0,1,length.out=5),
  c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")
```

```
        group   name       otype   dclass       dim
0           /    baa   H5I_GROUP                   
1           /     df H5I_DATASET COMPOUND         5
2           /    foo   H5I_GROUP                   
3        /foo      A H5I_DATASET  INTEGER     5 x 2
4        /foo foobaa   H5I_GROUP                   
5 /foo/foobaa      B H5I_DATASET    FLOAT 5 x 2 x 2
```

**Reading data**

```r
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")
readA
```

**Writing and reading chunks**

```r
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")
```

**Notes and further resources**

* hdf5 can be used to optimize reading/writing from disc in R
* The rhdf5 tutorial: 
  * [http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf](http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf)
* The HDF group has informaton on HDF5 in general [http://www.hdfgroup.org/HDF5/](http://www.hdfgroup.org/HDF5/)
### Webscraping html reading

[Source-jtleek](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/02_03_readingFromTheWeb/index.md)

__Webscraping__: Programatically extracting data from the HTML code of websites. 

* It can be a great way to get data [How Netflix reverse engineered Hollywood](http://www.theatlantic.com/technology/archive/2014/01/how-netflix-reverse-engineered-hollywood/282679/)
* Many websites have information you may want to programaticaly read
* In some cases this is against the terms of service for the website
* Attempting to read too many pages too quickly can get your IP address blocked

[http://en.wikipedia.org/wiki/Web_scraping](http://en.wikipedia.org/wiki/Web_scraping)


**Getting data off webpages - readLines()**

```r
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
```

```
[1] "<!DOCTYPE html><html><head><title>Jeff Leek - Google Scholar
Citations</title><meta name=\"robots\" content=\"noarchive\"><meta
http-equiv=\"Content-Type\"
content=\"text/html;charset=ISO-8859-1\"><meta
http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\"><meta
name=\"format-detection\" content=\"telephone=no\"><link
rel=\"canonical\"
href=\"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&amp;hl=en\"><style
type=\"text/css\" media=\"screen, 
```

**Parsing with XML**

The actual lecture notes is sooooooooooo wrong.

```r
	library(XML)
	library(httr)
	url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
	html <- htmlTreeParse(rawToChar(GET(url)$content), useInternalNodes = TRUE)
	xpathSApply(html, "//title", xmlValue)
```

```
[1] "Jeff Leek - Google Scholar Citations"
```

```r
xpathSApply(html, "//td[@class='gsc_a_c']", xmlValue)
```

```
 [1] "Cited by" "397"      "259"      "237"      "172"      "138"      "125"      "122"     
 [9] "109"      "101"      "34"       "26"       "26"       "24"       "19"       "13"      
[17] "12"       "10"       "10"       "7"        "6"       
```

**GET from the httr package**

Somehow this works in the first try.

```r
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
xpathSApply(parsedHtml, "//td[@class='gsc_a_c']", xmlValue)
```

```
[1] "Jeff Leek - Google Scholar Citations"
```

**Accessing websites with passwords**


```r
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
```

```
Response [http://httpbin.org/basic-auth/user/passwd]
  Status: 401
  Content-type: application/json
{
  "authenticated": true,
  "user": "user"
} 
```

```r
names(pg2)
```

```
[1] "url"         "handle"      "status_code" "headers"     "cookies"     "content"    
[7] "times"       "config"     
```


[http://cran.r-project.org/web/packages/httr/httr.pdf](http://cran.r-project.org/web/packages/httr/httr.pdf)

---

**Using handles**

handles are used when you want to authenticate once and leave every
other time to use the same authentication.
```r
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")
```

[http://cran.r-project.org/web/packages/httr/httr.pdf](http://cran.r-project.org/web/packages/httr/httr.pdf)

**Notes and further resources**

* R Bloggers has a number of examples of web scraping [http://www.r-bloggers.com/?s=Web+Scraping](http://www.r-bloggers.com/?s=Web+Scraping)
* The httr help file has useful examples [http://cran.r-project.org/web/packages/httr/httr.pdf](http://cran.r-project.org/web/packages/httr/httr.pdf)
* See later lectures on APIs
 
### API's

[Source for API usage when the time is right, not now!](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/02_04_readingFromAPIs/index.md)

Example of making and getting info from github API.

``` R
library(httr)
library(httpuv)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
  key = "56b637a5baffac62cad9",
  secret = "8e107541ae1791259e9987d544ca568633da2ebf")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
lst <- content(req)

library(jsonlite)

# Convert to a data.frame
gitDF = fromJSON(toJSON(lst))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]

```

**Source**

1. [Exact question answered for the Coursera question](https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08)
2. [Source given by course era course
question](https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r)
3. [Source given by jtleek](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/02_04_readingFromAPIs/index.md)



### other sources





**There is a package for that**

* Roger has a nice video on how there are R packages for
most things that you will want to access.
* Here I'm going to briefly review a few useful packages
* In general the best way to find out if the R package
exists is to Google "data storage mechanism R package"
  * For example: "MySQL R package"

---

**Interacting more directly with files**

* file - open a connection to a text file
* url - open a connection to a url
* gzfile - open a connection to a .gz file
* bzfile - open a connection to a .bz2 file
* _?connections_ for more information
* <redtext>Remember to close connections </redtext>

---

**foreign package**

* Loads data from Minitab, S, SAS, SPSS, Stata,Systat
* Basic functions _read.foo_
  * read.arff (Weka)
  * read.dta (Stata)
  * read.mtp (Minitab)
  * read.octave (Octave)
  * read.spss (SPSS)
  * read.xport (SAS)
* See the help page for more details [http://cran.r-project.org/web/packages/foreign/foreign.pdf](http://cran.r-project.org/web/packages/foreign/foreign.pdf)


---

**Examples of other database packages**

* RPostresSQL provides a DBI-compliant database connection from R. Tutorial-[https://code.google.com/p/rpostgresql/](https://code.google.com/p/rpostgresql/), help file-[http://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf](http://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf)
* RODBC provides interfaces to multiple databases including PostgreQL, MySQL, Microsoft Access and SQLite. Tutorial - [http://cran.r-project.org/web/packages/RODBC/vignettes/RODBC.pdf](http://cran.r-project.org/web/packages/RODBC/vignettes/RODBC.pdf), help file - [http://cran.r-project.org/web/packages/RODBC/RODBC.pdf](http://cran.r-project.org/web/packages/RODBC/RODBC.pdf)
* RMongo [http://cran.r-project.org/web/packages/RMongo/RMongo.pdf](http://cran.r-project.org/web/packages/RMongo/RMongo.pdf) (example of Rmongo [http://www.r-bloggers.com/r-and-mongodb/](http://www.r-bloggers.com/r-and-mongodb/)) and [rmongodb](http://cran.r-project.org/web/packages/rmongodb/rmongodb.pdf) provide interfaces to MongoDb. 


---

**Reading images**

* jpeg - [http://cran.r-project.org/web/packages/jpeg/index.html](http://cran.r-project.org/web/packages/jpeg/index.html)
* readbitmap - [http://cran.r-project.org/web/packages/readbitmap/index.html](http://cran.r-project.org/web/packages/readbitmap/index.html)
* png - [http://cran.r-project.org/web/packages/png/index.html](http://cran.r-project.org/web/packages/png/index.html)
* EBImage (Bioconductor) - [http://www.bioconductor.org/packages/2.13/bioc/html/EBImage.html](http://www.bioconductor.org/packages/2.13/bioc/html/EBImage.html)

---

**Reading GIS data**

* rgdal - [http://cran.r-project.org/web/packages/rgdal/index.html](http://cran.r-project.org/web/packages/rgdal/index.html)
* rgeos - [http://cran.r-project.org/web/packages/rgeos/index.html](http://cran.r-project.org/web/packages/rgeos/index.html)
* raster - [http://cran.r-project.org/web/packages/raster/index.html](http://cran.r-project.org/web/packages/raster/index.html)

---

**Reading music data**

* tuneR - [http://cran.r-project.org/web/packages/tuneR/](http://cran.r-project.org/web/packages/tuneR/)
* seewave - [http://rug.mnhn.fr/seewave/](http://rug.mnhn.fr/seewave/)

### jpeg

> readJPEG                Read a bitmap image stored in the JPEG format
> writeJPEG               Write a bitmap image in JPEG format
> --- library(help=jpeg)

## Manipulating DATA (c3-w3)
### dealing with NA
	
	final[complete.cases(final), ]
	na.omit(your.data.frame)
	final <- final[!(is.na(final$rnor)) | !(is.na(rawdata$cfam)),]
	
Also look at imputing where NA is replaced with other things
	
### NA's are ignored using `which`

```r
X[which(X$var2 > 8),]
```

```
  var1 var2 var3
4    1   10   11
5    4    9   13
```

### dealing with blanks
https://stackoverflow.com/questions/12763890/exclude-blank-and-na-in-r
Question

https://stackoverflow.com/a/12764040/5986651 Answer

	foo[foo==""] <- NA
	foo <- na.omit(foo$column.name)
### Selecting random rows and setting value (Sampling)

```r
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
```

```
  var1 var2 var3
1    2   NA   15
4    1   10   11
2    3   NA   12
3    5    6   14
5    4    9   13
```
### Subsetting - quick review (2)

```r
X[,1]
```

```r
X[,"var1"]
```

```r
X[1:2,"var2"]
```

**Subsetting with %in%**
```r
restData[restData$zipCode %in% c("21212","21213"),]
```

### Logicals and's and or's


```r
X[(X$var1 <= 3 & X$var3 > 11),]
```

```
  var1 var2 var3
1    2   NA   15
2    3   NA   12
```

```r
X[(X$var1 <= 3 | X$var3 > 15),]
```

```
  var1 var2 var3
1    2   NA   15
4    1   10   11
2    3   NA   12
```

### Sorting

**Excludes NA's unless an argument is used** If needed then use
`na.last`=True

```r
sort(X$var1)
```

```
[1] 1 2 3 4 5
```

```r
sort(X$var1,decreasing=TRUE)
```

```
[1] 5 4 3 2 1
```

```r
sort(X$var2,na.last=TRUE)
```

```
[1]  6  9 10 NA NA
```
### Ordering

Different than Sorting in that **in orders the whole DF**

```r
X[order(X$var1),]
```

```
  var1 var2 var3
4    1   10   11
1    2   NA   15
2    3   NA   12
5    4    9   13
3    5    6   14
```

```r
X[order(X$var1,X$var3),]
```

```
  var1 var2 var3
4    1   10   11
1    2   NA   15
2    3   NA   12
5    4    9   13
3    5    6   14
```

### Order(arrange) with some more capabilities (plyr)

```r
library(plyr)
arrange(X,var1)
```

```
  var1 var2 var3
1    1   10   11
2    2   NA   15
3    3   NA   12
4    4    9   13
5    5    6   14
```

```r
arrange(X,desc(var1))
```

```
  var1 var2 var3
1    5    6   14
2    4    9   13
3    3   NA   12
4    2   NA   15
5    1   10   11
```



---

### Adding rows and columns

Directly add columns
```r
X$var4 <- rnorm(5)
X
```

```
  var1 var2 var3     var4
1    2   NA   15  0.18760
4    1   10   11  1.78698
2    3   NA   12  0.49669
3    5    6   14  0.06318
5    4    9   13 -0.53613
```
**or Use cind or rbind**
```r
Y <- cbind(X,rnorm(5))
Y
```

```
  var1 var2 var3     var4 rnorm(5)
1    2   NA   15  0.18760  0.62578
4    1   10   11  1.78698 -2.45084
2    3   NA   12  0.49669  0.08909
3    5    6   14  0.06318  0.47839
5    4    9   13 -0.53613  1.00053
```

### Col and row names

	names(test) <- c("A","B","C","D","E","F","G","H","I","J","K")

- faster 

		colnames(test) <- c("A","B","C","D","E","F","G","H","I","J","K")

### Using dictionary types in python similar(plyr)
- You have a table (activty.names) of 2 columns `$V1` and `$V2`. V1 with number, V2
  with char to be replaced.

```R
library(plyr)
traintest$Activity <-
    mapvalues(traintest$Activity,activity.names$V1,activity.names$V2)# requires `plyr`
```
  
  
### Notes and further resources

* R programming in the Data Science Track
* Andrew Jaffe's lecture notes [http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf)


[Source](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/03_01_subsettingAndSorting/index.md)
## Summarizing data (c3-w3)

### Using STR, Summary, HEAD

```r
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
```

**Read first few lines of the DF**

```r
head(restData,n=3)
tail(restData,n=3)
```
**Summary of data**

Info about every column based on its class.


``` R
summary(restData$name,5)
```
```
MCDONALD'S POPEYES FAMOUS FRIED CHICKEN 
                           8                            7 
                      SUBWAY       KENTUCKY FRIED CHICKEN 
                           6                            5 
                     (Other) 
                        1301 
```
**In-depth info (STR)**

`str` is more about *meta info* about the data, like what class is each
column, starting numbers, how many levels if factor etc..


```r
str(restData)
```

```
'data.frame':	1327 obs. of  6 variables:
 $ name           : Factor w/ 1277 levels "#1 CHINESE KITCHEN",..: 9 3 992 1 2 4 5 6 7 8 ...
 $ zipCode        : int  21206 21231 21224 21211 21223 21218 21205 21211 21205 21231 ...
 $ neighborhood   : Factor w/ 173 levels "Abell","Arlington",..: 53 52 18 66 104 33 98 133 98 157 ...
 $ councilDistrict: int  2 1 1 14 9 14 13 7 13 1 ...
 $ policeDistrict : Factor w/ 9 levels "CENTRAL","EASTERN",..: 3 6 6 4 8 3 6 4 6 6 ...
 $ Location.1     : Factor w/ 1210 levels "1 BIDDLE ST\nBaltimore, MD\n",..: 835 334 554 755 492 537 505 530 507 569 ...
```


### Quantile info


```r
quantile(restData$councilDistrict,na.rm=TRUE)
```

```
  0%  25%  50%  75% 100% 
   1    2    9   11   14 
```

```r
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))
```


### table

Counts the number of times of occurance of one column or even a
combination of columns in X and Y axis.

NA is removed by default.

```r
table(restData$councilDistrict,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)
```

### Check for missing values

```r
sum(is.na(restData$councilDistrict))
```

```
[1] 0
```

```r
any(is.na(restData$councilDistrict))
```

```
[1] FALSE
```

```r
all(restData$zipCode > 0)
```

```
[1] FALSE
```
**Getting info about all columns**
```r
colSums(is.na(restData))
```

```
           name         zipCode    neighborhood councilDistrict  policeDistrict      Location.1 
              0               0               0               0               0               0 
```


```r
all(colSums(is.na(restData))==0)
```

```
[1] TRUE
```

### Values with specific characteristics

```r
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212"))
```

```
FALSE  TRUE 
 1299    28 
```
**Subsetting with %in%**
```r
restData[restData$zipCode %in% c("21212","21213"),]
```

```
                                     name zipCode                neighborhood councilDistrict
29                      BAY ATLANTIC CLUB   21212                    Downtown              11
39                            BERMUDA BAR   21213               Broadway East              12
92                              ATWATER'S   21212   Chinquapin Park-Belvedere               4
111            BALTIMORE ESTONIAN SOCIET

```

### Cross tabs

**Shows values of Freq in a table of Gender and Admit**

```r
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt
```

```
        Admit
Gender   Admitted Rejected
  Male       1198     1493
  Female      557     1278
```

**Even for third dimension**

```r
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt
```

```
, , replicate = 1

    tension
wool  L  M  H
   A 26 18 36
   B 27 42 20

, , replicate = 2

    tension
wool  L  M  H
   A 30 21 21
   B 14 26 21
```

**With possibility to flatten it out!**

```r
ftable(xt)
```
### Size of data set

```r
fakeData = rnorm(1e5)
object.size(fakeData)
```

```
800040 bytes
```

```r
print(object.size(fakeData),units="Mb")
```

```
0.8 Mb
```

## Create new variables (c3-w3)

[Source](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/03_03_creatingNewVariables/index.md)




### Why create new variables?

* Often the raw data won't have a value you are looking for
* You will need to transform the data to get the values you would like
* Usually you will add those values to the data frames you are working with
* Common variables to create
  * Missingness indicators
  * "Cutting up" quantitative variables
  * Applying transforms


---


### Creating sequences

**Sample Data**
```r
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
```

_Sometimes you need an index for your data set_


```r
s1 <- seq(1,10,by=2) ; s1
```

```
[1] 1 3 5 7 9
```

```r
s2 <- seq(1,10,length=3); s2
```

```
[1]  1.0  5.5 10.0
```

```r
x <- c(1,3,8,25,100); seq(along = x)
```

```
[1] 1 2 3 4 5
```



---

### Creating new variable by subsetting


```r
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
```

```

FALSE  TRUE 
 1314    13 
```

### Creating binary variables


```r
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)
```

```
       
        FALSE TRUE
  FALSE  1326    0
  TRUE      0    1
```


### Creating categorical variables (CUT)


```r
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
```

```

(-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] (2.123e+04,2.129e+04] 
                  337                   375                   282                   332 
```

```r
table(restData$zipGroups,restData$zipCode)
```

```
                       
                        -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213
  (-2.123e+04,2.12e+04]      0   136   201     0     0     0     0     0     0     0     0     0
  (2.12e+04,2.122e+04]       0     0     0    27    30     4     1     8    23    41    28    31
  (2.122e+04,2.123e+04]      0     0     0     0     0     0     0     0     0     0     0     0
  (2.123e+04,2.129e+04]      0     0     0     0     0     0     0     0     0     0     0     0
     
```

#### Quiz question

> Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
>
> are Lower middle income but among the 38 nations with highest GDP?

> Answer:5

pandian2$RankingGroups <- cut(pandian2$Ranking,breaks=quantile(pandian2$Ranking,probs=seq(0,1,0.2)))
table(pandian2$RankingGroups,pandian2$Income.Group)
### Easier cutting library(hmisc) cut2


```r
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
```

```

[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
           338            375            300            314 
```


---

### Creating factor variables


```r
restData$zcf <- factor(restData$zipCode)
restData$zcf <- as.factor(restData$zipCode)
restData$zcf[1:10]
```

```
 [1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
32 Levels: -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214 ... 21287
```

```r
class(restData$zcf)
```

```
[1] "factor"
```

### Levels of factor variables


```r
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
levels(as.factor(yesno))
relevel(yesnofac,ref="no")
```

```
 [1] "no"  "yes"
 [2] yes yes yes yes no  yes yes yes no  no 
Levels: no yes
```

```r
as.numeric(yesnofac)
```

```
 [1] 1 1 1 1 2 1 1 1 2 2
```



### Using the mutate function or do it directly 

Need both HMISC and plyr.

```r
library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
restData$zipGroups  <-  cut2(restData$zipCode,g=4) # same result
table(restData2$zipGroups)
```

```

[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
           338            375            300            314 
```

This [stack source on different ways of adding columns](https://stackoverflow.com/questions/7976001/adding-a-column-of-means-by-group-to-original-data) to the main
data frame but factored:

``` R
df1$Y.New <- ave(df1$Y, df1$X)

## or

library(dplyr)
df1 <- df1 %>% 
  group_by(X) %>% 
  mutate(Y.new = mean(Y))
  
```

### Common transforms

* `abs(x)` absolute value
* `sqrt(x)` square root
* `ceiling(x)` ceiling(3.475) is 4
* `floor(x)` floor(3.475) is 3
* `round(x,digits=n)` round(3.475,digits=2) is 3.48
* `signif(x,digits=n)` signif(3.475,digits=2) is 3.5
* `cos(x), sin(x)` etc.
* `log(x)` natural logarithm
* `log2(x)`, `log10(x)` other common logs
* `exp(x)` exponentiating x

[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf)
[http://statmethods.net/management/functions.html](http://statmethods.net/management/functions.html)


---

### Notes and further reading

* A tutorial from the developer of plyr - [http://plyr.had.co.nz/09-user/](http://plyr.had.co.nz/09-user/)
* Andrew Jaffe's R notes [http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf)
* A nice lecture on categorical and factor variables [http://www.stat.berkeley.edu/classes/s133/factors.html](http://www.stat.berkeley.edu/classes/s133/factors.html)





## Reshaping data (c3-w3)
### The goal is tidy data

1. Each variable forms a column
2. Each observation forms a row
3. Each table/file stores data about one kind of observation (e.g. people/hospitals).


[http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf)

[Leek, Taub, and Pineda 2011 PLoS One](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0026895)

---

### Melting dataframes


```r
library(reshape2)
head(mtcars)
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
```

```
        carname gear cyl variable value
1     Mazda RX4    4   6      mpg  21.0
2 Mazda RX4 Wag    4   6      mpg  21.0
3    Datsun 710    4   4      mpg  22.8
```

```r
tail(carMelt,n=3)
```

```
         carname gear cyl variable value
62  Ferrari Dino    5   6       hp   175
63 Maserati Bora    5   8       hp   335
64    Volvo 142E    4   4       hp   109
```
[http://www.statmethods.net/management/reshape.html](http://www.statmethods.net/management/reshape.html)

### dCasting data frames


```r
cylData <- dcast(carMelt, cyl ~ variable)
cylData
```

```
  cyl mpg hp
1   4  11 11
2   6   7  7
3   8  14 14
```

```r
cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData
```

```
  cyl   mpg     hp
1   4 26.66  82.64
2   6 19.74 122.29
3   8 15.10 209.21
```


[http://www.statmethods.net/management/reshape.html](http://www.statmethods.net/management/reshape.html)

### Averaging values


```r
head(InsectSprays)
```

	```
  count spray
1    10     A
2     7     A
3    20     A
4    14     A
5    14     A
6    12     A
```

```r
tapply(InsectSprays$count,InsectSprays$spray,sum)

#or
spIns =  split(InsectSprays$count,InsectSprays$spray)
sprCount = lapply(spIns,sum)
unlist(sprCount) # to make it a table

#or
sapply(spIns,sum) # directly a table

```

```
  A   B   C   D   E   F 
174 184  25  59  42 200 
```


[http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/](http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/)

### Averaging across multiple variables

``` R
balt.NEI <- subset(NEI,fips==24510)

mn2 <- with(balt.NEI, tapply(Emissions, list(year,type), mean, na.rm=T))

library(dplyr)
mn20 <- balt.NEI %>% group_by(year,type) %>%
    summarise(Pandian=mean(Emissions)) # result in clean format
	
library(plyr)

mn21 -> ddply(balt.NEI, .(type,year), summarize,Pandian=mean(Emissions))
```
**Note:** Summarize and Summarise perform the same function.

**Warning:** loading plyr masks the Summarise of dplyr! You need to
detach plyr before using functions like Summarize again.

https://stackoverflow.com/a/27407856/5986651

### Another way - plyr package 


```r
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
```

```
  spray sum
1     A 174
2     B 184
3     C  25
4     D  59
5     E  42
6     F 200
```

#### Summary: Average of col1 for factor(col2) (quiz) 

- Pre-info

``` R
url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,"./c3-w3.csv",method="curl")
gdp.data <- read.csv("./c3-w3.csv", header=TRUE,skip=3)
gdp.data[gdp.data==""] <- NA # Make "" --> NA and then...
gdp.data <- gdp.data[!is.na(gdp.data$X),] # Remove na from one row
                                        # alone
gdp.data <- gdp.data[!is.na(gdp.data$Ranking),] # Remove na from one row
                                        # alone
gdp.data$X <- factor(gdp.data$X)# remove unused levels
gdp.data$Ranking<-factor(gdp.data$Ranking) # remove unused levels
is.na(gdp.data$Ranking)
gdp.data$Ranking <- as.numeric(as.character(gdp.data$Ranking))

url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url,"./c3-w3-other.csv",method="curl")
edu.data <- read.csv("./c3-w3-other.csv", header=TRUE)


pandian <- merge(gdp.data,edu.data,by.x="X",by.y="CountryCode")
```
- Finding average of Ranking for different Income groups

``` R
ave.rank1 <- tapply(pandian$Ranking,pandian$Income.Group,mean)
ave.rank2 <- sapply(split(pandian$Ranking,pandian$Income.Group),mean)#simplify=T
ave.rank3 <- lapply(split(pandian$Ranking,pandian$Income.Group),mean)
ave.rank3 <- unlist(ave.rank3)
ave.rank4 <- ddply(pandian,.(Income.Group),summarize,average=mean(Ranking))

```


### Creating a new column variable 

- adding the column to the existing dataframe using `transform`
[Transform](https://stackoverflow.com/a/7578905/5986651)

```R
pandian2 <- ddply(pandian,.(Income.Group),transform,average=mean(Ranking))
head(data.frame(pandian2$average,pandian2$Income.Group),n=50)
```
`ave` is not fully understood. but we see the difference. Go deeper if necessary.

```r
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
```

```
[1] 72  2
```

```r
head(spraySums)
```

```
  spray sum
1     A 174
2     A 174
3     A 174
4     A 174
5     A 174
6     A 174
```


---

### More information 

* A tutorial from the developer of plyr - [http://plyr.had.co.nz/09-user/](http://plyr.had.co.nz/09-user/)
* A nice reshape tutorial [http://www.slideshare.net/jeffreybreen/reshaping-data-in-r](http://www.slideshare.net/jeffreybreen/reshaping-data-in-r)
* A good plyr primer - [http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/](http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/)
* See also the functions
  * acast - for casting as multi-dimensional arrays
  * arrange - for faster reordering without using order() commands
  * mutate - adding new variables
  
## Merging data (c3-w3)

### Peer review experiment data

[http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895](http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895)

### Peer review data



```r
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
```

```
  id solution_id reviewer_id      start       stop time_left accept
1  1           3          27 1304095698 1304095758      1754      1
2  2           4          22 1304095188 1304095206      2306      1
```

```r
head(solutions,2)
```

```
  id problem_id subject_id      start       stop time_left answer
1  1        156         29 1304095119 1304095169      2343      B
2  2        269         25 1304095119 1304095183      2329      C
```


### Merging data - merge()

* Merges data frames
* Important parameters: _x_,_y_,_by_,_by.x_,_by.y_,_all_

```r
names(reviews)
```

```
[1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"  
[7] "accept"     
```

```r
names(solutions)
```

```
[1] "id"         "problem_id" "subject_id" "start"      "stop"       "time_left"  "answer"    
```

**Example**


```r
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)
```
If `all=TRUE` then for every row that has no match, you will see a row
with corresponding `NA`s.
  
```
  solution_id id reviewer_id    start.x     stop.x time_left.x accept problem_id subject_id
1           1  4          26 1304095267 1304095423        2089      1        156         29
2           2  6          29 1304095471 1304095513        1999      1        269         25
3           3  1          27 1304095698 1304095758        1754      1         34         22
4           4  2          22 1304095188 1304095206        2306      1         19         23
5           5  3          28 1304095276 1304095320        2192      1        605         26
6           6 16          22 1304095303 1304095471        2041      1        384         27
     start.y     stop.y time_left.y answer
1 1304095119 1304095169        2343      B
2 1304095119 1304095183        2329      C
3 1304095127 1304095146        2366      C
4 1304095127 1304095150        2362      D
5 1304095127 1304095167        2345      A
6 1304095131 1304095270        2242      C
```
### Default - merge all common column names


```r
intersect(names(solutions),names(reviews))
```

```
[1] "id"        "start"     "stop"      "time_left"
```

```r
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)
```

```
  id      start       stop time_left solution_id reviewer_id accept problem_id subject_id answer
1  1 1304095119 1304095169      2343          NA          NA     NA        156         29      B
2  1 1304095698 1304095758      1754           3          27      1         NA         NA   <NA>
3  2 1304095119 1304095183      2329          NA          NA     NA        269         25      C
4  2 1304095188 1304095206      2306           4          22      1         NA         NA   <NA>
5  3 1304095127 1304095146      2366          NA          NA     NA         34         22      C
6  3 1304095276 1304095320      2192           5          28      1         NA         NA   <NA>
```


---

### Using join in the plyr package 

_Faster, but less full featured - defaults to left join, see help file for more_

```r
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)
```

```
   id       x       y
1   1  0.2514  0.2286
2   2  0.1048  0.8395
3   3 -0.1230 -1.1165
4   4  1.5057 -0.1121
5   5 -0.2505  1.2124
6   6  0.4699 -1.6038
7   7  0.4627 -0.8060
8   8 -1.2629 -1.2848
9   9 -0.9258 -0.8276
10 10  2.8065  0.5794
```



---

### If you have multiple data frames


```r
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
```

```
   id        x        y        z
1   6  0.39093 -0.16670  0.56523
2   1 -1.90467  0.43811 -0.37449
3   7 -1.48798 -0.85497 -0.69209
4  10 -2.59440  0.39591 -0.36134
5   3 -0.08539  0.08053  1.01247
6   4 -1.63165 -0.13158  0.21927
7   5 -0.50594  0.24256 -0.44003
8   9 -0.85062 -2.08066 -0.96950
9   2 -0.63767 -0.10069  0.09002
10  8  1.20439  1.29138 -0.88586
```


---

### More on merging data

* The quick R data merging page - [http://www.statmethods.net/management/merging.html](http://www.statmethods.net/management/merging.html)
* plyr information - [http://plyr.had.co.nz/](http://plyr.had.co.nz/)
* Types of joins - [http://en.wikipedia.org/wiki/Join_(SQL)](http://en.wikipedia.org/wiki/Join_(SQL))
## Cleaning data NA and "" & (c3-w4)


### Cleaning data
So usually we have `NA` or empty spaces `""` which really fuck with
us. Based on which column we are using we skip them either by using
functions or literally just cleaning up things.

This example shows a case of how to deal with `NA` or empty spaces
`""`, including comments.

- data 

``` R
url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,"./c3-w3.csv",method="curl")
gdp.data <- read.csv("./c3-w3.csv", header=TRUE,skip=3)
```
- making "" --> NA
```R
gdp.data[gdp.data==""] <- NA # Make "" --> NA and then...
```

- removing NA rows from necessary cols ```(numeric and char)```

```R
gdp.data <- gdp.data[!is.na(gdp.data$X),] # Remove na from one row
                                        # alone
gdp.data <- gdp.data[!is.na(gdp.data$Ranking),] # Remove na from one row
                                        # alone
```
### Manipulating factors (**Important**)
- Manipulating factors is slightly different and [can lead to
  errors.](https://stackoverflow.com/a/6980780/5986651)
  

- removing unused levels is forcefully done

```R
gdp.data$X <- factor(gdp.data$X)# remove unused levels
gdp.data$Ranking<-factor(gdp.data$Ranking) # remove unused levels
is.na(gdp.data$Ranking)
```

- converting factor to numeric for doing some arithmetic or
arranging. **BE CAREFUL**

```R
gdp.data$Ranking <- as.numeric(as.character(gdp.data$Ranking))
```

- factors and headers (append data)

		header.data <- factor(append(c(subject.header,y.header),as.character(X.header)))

#### q3 question on which reflection is done 


Based on q3 coursera question:

>  Load the Gross Domestic Product data for the 190 ranked countries in this data set:
>
> https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
>
> Load the educational data from this data set:
>
> https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
>
> Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?
>
> Original data sources:
>
> http://data.worldbank.org/data-catalog/GDP-ranking-table
>
> http://data.worldbank.org/data-catalog/ed-stats

- Answer

    > 189 matches, 13th country is St. Kitts and Nevis


### Cleaning up colnames

**Example - Baltimore camera data**

[https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru](https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru)

**Data**

```r
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")

```

**Removing Capitals tolower(), toupper()**

```R
names(cameraData)
```

```
[1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location.1"  
```

```r
names(cameraData) <- tolower(names(cameraData))
```

```
[1] "address"      "direction"    "street"       "crossstreet"  "intersection" "location.1"  
```

**Removing `.` and `_` strsplit()**

* Good for automatically splitting variable names
* Important parameters: _x_, _split_

For `.` you need to use `\\.` as it is the escape character.

```r
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
```

```
[1] "intersection"
```

```r
splitNames[[6]]
```

```
[1] "Location" "1"       
```

```r
firstElement <- function(x){x[1]}
names(cameraData) <- sapply(splitNames,firstElement)
```

```
[1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location"    
```
**Peer review experiment data**

[http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895](http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895)

```r
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
```

```
  id solution_id reviewer_id      start       stop time_left accept
1  1           3          27 1304095698 1304095758      1754      1
2  2           4          22 1304095188 1304095206      2306      1
```

```r
head(solutions,2)
```

```
  id problem_id subject_id      start       stop time_left answer
1  1        156         29 1304095119 1304095169      2343      B
2  2        269         25 1304095119 1304095183      2329      C
```
**replacing char with other chars sub()**

* Important parameters: _pattern_, _replacement_, _x_


```r
names(reviews)
```

```
[1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"  
[7] "accept"     
```

```r
sub("_","",names(reviews),)
```

```
[1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"   "accept"    
```
**Fixing character vectors - gsub()**

Removes only one
```r
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)
```

```
[1] "thisis_a_test"
[2] "thisisatest"
```
`gsub` removes recursively.


**Finding values - grep(),grepl()**

`grep` for location of value. `grepl` for true or false which can be
passed as argument.
```r
grep("Alameda",cameraData$intersection)
grep("Alameda",cameraData$intersection,value=TRUE)

table(grepl("Alameda",cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

```

```
[1]  4  5 36
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"
[2]FALSE  TRUE 
   77     3 
```

**`length` to determine if `grep()` found something**

```r
grep("JeffStreet",cameraData$intersection)
```

```
integer(0)
```

```r
length(grep("JeffStreet",cameraData$intersection))
```

```
[1] 0
```


[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

**More useful string functions**


```r
library(stringr)
nchar("Jeffrey Leek")
```

```
[1] 12
```

```r
substr("Jeffrey Leek",1,7)
```

```
[1] "Jeffrey"
```

```r
paste("Jeffrey","Leek")
paste0("Jeffrey","Leek")
```

```
[1] "Jeffrey Leek"
[2] "JeffreyLeek"
```
**To trim the empty spaces**
```r
str_trim("Jeff      ")
```

```
[1] "Jeff"
```
**Important points about text in data sets**

* Names of variables should be 
  * All lower case when possible
  * Descriptive (Diagnosis versus Dx)
  * Not duplicated
  * Not have underscores or dots or white spaces
* Variables with character values
  * Should usually be made into factor variables (depends on application)
  * Should be descriptive (use TRUE/FALSE instead of 0/1 and
    Male/Female versus 0/1 or M/F)
	
### Identifying expressions with meta and literals

**Regular expressions**

- Regular expressions can be thought of as a combination of literals and _metacharacters_
- To draw an analogy with natural language, think of literal text forming the words of this language, and the metacharacters defining its grammar
- Regular expressions have a rich set of metacharacters

**Literals**

Simplest pattern consists only of literals. The literal “nuclear” would match to the following lines:

```markdown
Ooh. I just learned that to keep myself alive after a
nuclear blast! All I have to do is milk some rats
then drink the milk. Aweosme. :}
```
- `^I think` Beginning of line

``` markdown
i think we all rule for participating
i think i have been outed
```
- `morning$` end of line

```markdown
well they had something this morning
then had to catch a tram home in the morning
```
- `[Bb][Uu][Ss][Hh]` will find any case combi of `BuSH` 

```markdown
Bush 
BUSH
busHwalking
```
- `^[Ii]` am

```markdown
i am great!
I am mass
```
-`^[0-9][a-zA-Z]` starting with number follwed by any character

``` markdown
7th inning
2nd half s
```
- [^?.]$ Matching characters not `?` or `.` at the end of the line.

``` markdown
i like basketballs
6 and 9
```
- `9.11` any 1 character

``` markdown
its stupid the post 9-11 rules
9/11
```

- `flood|fire|earth|wind|water`; flood or fire or ...

``` markdown
is firewire like usb on none macs?
the global flood makes sense within the context of the bible
```

-`^[Gg]ood|[Bb]ad` Beginning of line with G or g or Bad/bad anywhere
in the sentence

``` markdown
good to hear some good knews from someone here
Good afternoon fellow american infidels!
```

- `^([Gg]ood|[Bb]ad)`; for both it is the beginning of the line!

- `[Gg]eorge( [Ww]\.)? [Bb]ush`; ? indicated optional characters

	Also here we need to escape `.` so we use `\.`

``` markdown
George W. Bush
George Bushless
```

- `(.*)`; brackets with any number of chars

``` markdown
anyone wanna chat? (24, m, germany)
hello, 20.m here... ( east area + drives + webcam )
(he means older men)
```

- `[0-9]+ (.*)[0-9]+` ;`*` mean none or many of the item and `+` means
  atleast 1 of the item.

``` markdown
working as MP here 720 MP battallion, 42nd birgade
so say 2 or 3 years at colleage and 4 at uni makes us 23 when and if we fin
```
- `[Bb]ush( +[^ ]+ +){1,5} debate`; { and } are referred to as interval quantifiers; the let us specify the minimum and maximum number of matches of an expression

``` markdown
Bush has historically won all major debates he’s done.
in my view, Bush doesn’t need these debates..
```

- parentheses not only limit the scope of alternatives divided by a
  “|”, but also can be used to “remember” text matched by the
  subexpression enclosed
  
  
  `+([a-zA-Z]+) +\1 +` ; some starting + one character atleast +
  somethingelse+ a repitition of the ones in `()` + something else
  
``` markdown
time for bed, night night twitter!
```


- `^s(.*)s` matches the longest string starting with s and ending with
  s
  
``` markdown
sitting at starbucks
setting up mysql and rails
```

- The greediness of * can be turned off with the ?, as in

	`^s(.*?)s$`
#### Quiz q4 grep question

    > Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    >
    > https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
    >
    > Load the educational data from this data set:
    >
    > https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
    >
    > Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
    >
    > Original data sources:
    >
    > http://data.worldbank.org/data-catalog/GDP-ranking-table
    >
    > http://data.worldbank.org/data-catalog/ed-stats
	
	> Answer: 13
	
```R
url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,"./c3-w3.csv",method="curl")
gdp.data <- read.csv("./c3-w3.csv", header=TRUE,skip=3)
gdp.data[gdp.data==""] <- NA # Make "" --> NA and then...
gdp.data <- gdp.data[!is.na(gdp.data$X),] # Remove na from one row
                                        # alone
gdp.data <- gdp.data[!is.na(gdp.data$Ranking),] # Remove na from one row
                                        # alone
gdp.data$X <- factor(gdp.data$X)# remove unused levels
gdp.data$Ranking<-factor(gdp.data$Ranking) # remove unused levels
is.na(gdp.data$Ranking)
gdp.data$Ranking <- as.numeric(as.character(gdp.data$Ranking))

url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url,"./c3-w3-other.csv",method="curl")
edu.data <- read.csv("./c3-w3-other.csv", header=TRUE)


pandian <- merge(gdp.data,edu.data,by.x="X",by.y="CountryCode")

length(grep("[Ff]iscal(.*)[Jj]une [0-9]",pandian$Special.Notes))
```
	

### Summary 

- Regular expressions are used in many different languages; not unique to R.
- Regular expressions are composed of literals and metacharacters that represent sets or classes of characters/words
- Text processing via regular expressions is a very powerful way to extract data from “unfriendly” sources (not all data comes as a CSV file)
- Used with the functions `grep`,`grepl`,`sub`,`gsub` and others that involve searching for text strings
(Thanks to Mark Hansen for some material in this lecture.)


## Dates & Times

```R
d1 = date() # class is "char"
d2 = Sys.Date() # class is "Date"
```

```
[1] "Sun Jan 12 17:48:33 2014"
[2] "2014-01-12"
```
**Formatting dates**

`%d` = day as number (0-31), `%a` = abbreviated weekday,`%A` = unabbreviated weekday, `%m` = month (00-12), `%b` = abbreviated month,
`%B` = unabbrevidated month, `%y` = 2 digit year, `%Y` = four digit year


```r
format(d2,"%a %b %d")
```

```
[1] "Sun Jan 12"
```


**Creating dates**


```r
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z
```

```
[1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"
```

```r
z[1] - z[2]
```

```
Time difference of -1 days
```

```r
as.numeric(z[1]-z[2])
```

```
[1] -1
```


**Converting to Julian**


```r
weekdays(d2)
```

```
[1] "Sunday"
```

```r
months(d2)
```

```
[1] "January"
```

```r
julian(d2)
```

```
[1] 16082
attr(,"origin")
[1] "1970-01-01"
```


**Lubridate**


```r
library(lubridate); ymd("20140108")
```

```
[1] "2014-01-08 UTC"
```

```r
mdy("08/04/2013")
```

```
[1] "2013-08-04 UTC"
```

```r
dmy("03-04-2013")
```

```
[1] "2013-04-03 UTC"
```


[http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)

**Dealing with times**


```r
ymd_hms("2011-08-03 10:15:03")
```

```
[1] "2011-08-03 10:15:03 UTC"
```

```r
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
```

```
[1] "2011-08-03 10:15:03 NZST"
```

```r
?Sys.timezone
```


[http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)

**Some functions have slightly different syntax**


```r
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
```

```
[1] 3
```

```r
wday(x[1],label=TRUE)
```

```
[1] Tues
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
```

### DATES and TIMEs from Exploratory graphs assignment learnings C4

Mixing Date and Time for graphs. [Source: Stack](https://stackoverflow.com/questions/11609252/r-tick-data-merging-date-and-time-into-a-single-object).

``` R
df$Date <- as.character(df$Date)
df$Time <- as.character(df$Time)

df$DateTime <- as.POSIXct(paste(df$Date, df$Time),
                          format="%d/%m/%Y %H:%M:%S")
library(lubridate)
df$Date.Time <- dmy_hms(paste(df$Date, df$Time))
```

**Notes and further resources**

* More information in this nice lubridate tutorial [http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)
* The lubridate vignette is the same content [http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html](http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html)
* Ultimately you want your dates and times as class "Date" or the classes "POSIXct", "POSIXlt". For more information type `?POSIXlt`
  
#### Quiz q c3-w4

You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.



How many values were collected in 2012? How many values were collected on Mondays in 2012?

``` R
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
sampleYears <- year(sampleTimes)
length(sampleYears[sampleYears==2012])

length(sampleTimes[year(sampleTimes)==2012 & weekdays(sampleTimes)=="maandag"])
```

### Working with TIME, difference, str_pad,strptime

``` R
mn1 <- df %>% group_by(interval) %>% summarize(num.of.steps.per.day=mean(steps))

                                        # convert mn1 interval to DT
                                        # subtract!

mn1$interval <- as.character(mn1.interval)
mn1$interval <- str_pad(mn1$interval, width=4, side="left", pad="0")
mn1$interval <- strptime(mn1$interval,"%H%M")
mn1
mn1$actualInterval <- mn1$interval-mn1$interval[1]
mna$actualInterval <- as.numeric(mn1$actualInterval)
```

## Data resources

[Source](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_05_dataResources/index.md)

### Open Government Sites

* United Nations [http://data.un.org/](http://data.un.org/)
* U.S. [http://www.data.gov/](http://www.data.gov/)
  * [List of cities/states with open data](http://simplystatistics.org/2012/01/02/list-of-cities-states-with-open-data-help-me-find/)
* United Kingdom [http://data.gov.uk/](http://data.gov.uk/)
* France [http://www.data.gouv.fr/](http://www.data.gouv.fr/)
* Ghana [http://data.gov.gh/](http://data.gov.gh/)
* Australia [http://data.gov.au/](http://data.gov.au/)
* Germany [https://www.govdata.de/](https://www.govdata.de/) 
* Hong Kong [http://www.gov.hk/en/theme/psi/datasets/](http://www.gov.hk/en/theme/psi/datasets/)
* Japan [http://www.data.go.jp/](http://www.data.go.jp/)
* Many more [http://www.data.gov/opendatasites](http://www.data.gov/opendatasites)

---

### Gapminder

<img class=center src=../../assets/img/03_ObtainingData/gapminder.png height=400/>

[http://www.gapminder.org/](http://www.gapminder.org/)


---

### Survey data from the United States

<img class=center src=../../assets/img/03_ObtainingData/asdfree.png height=400/>

[http://www.asdfree.com/](http://www.asdfree.com/)

---

### Infochimps Marketplace

<img class=center src=../../assets/img/03_ObtainingData/infochimps.png height=400/>

[http://www.infochimps.com/marketplace](http://www.infochimps.com/marketplace)

---

### Kaggle

<img class=center src=../../assets/img/03_ObtainingData/kaggle.png  height=400 />

[http://www.kaggle.com/](http://www.kaggle.com/)


---

### Collections by data scientists

* Hilary Mason http://bitly.com/bundles/hmason/1
* Peter Skomoroch https://delicious.com/pskomoroch/dataset
* Jeff Hammerbacher http://www.quora.com/Jeff-Hammerbacher/Introduction-to-Data-Science-Data-Sets
* Gregory Piatetsky-Shapiro http://www.kdnuggets.com/gps.html
* [http://blog.mortardata.com/post/67652898761/6-dataset-lists-curated-by-data-scientists](http://blog.mortardata.com/post/67652898761/6-dataset-lists-curated-by-data-scientists)


---

### More specialized collections

* [Stanford Large Network Data](http://snap.stanford.edu/data/)
* [UCI Machine Learning](http://archive.ics.uci.edu/ml/)
* [KDD Nugets Datasets](http://www.kdnuggets.com/datasets/index.html)
* [CMU Statlib](http://lib.stat.cmu.edu/datasets/)
* [Gene expression omnibus](http://www.ncbi.nlm.nih.gov/geo/)
* [ArXiv Data](http://arxiv.org/help/bulk_data)
* [Public Data Sets on Amazon Web Services](http://aws.amazon.com/publicdatasets/)

---

### Some API's with R interfaces

* [twitter](https://dev.twitter.com/) and [twitteR](http://cran.r-project.org/web/packages/twitteR/index.html) package
* [figshare](http://api.figshare.com/docs/intro.html) and [rfigshare](http://cran.r-project.org/web/packages/rfigshare/index.html)
* [PLoS](http://api.plos.org/) and [rplos](http://cran.r-project.org/web/packages/rplos/rplos.pdf)
* [rOpenSci](http://ropensci.org/packages/index.html)
* [Facebook](https://developers.facebook.com/) and [RFacebook](http://cran.r-project.org/web/packages/Rfacebook/)
* [Google maps](https://developers.google.com/maps/) and [RGoogleMaps](http://cran.r-project.org/web/packages/RgoogleMaps/index.html)
# Course4: Exploratory data Analysis


## Principles

* Principle 1: Show comparisons
* Principle 2: Show causality, mechanism, explanation
* Principle 3: Show multivariate data
* Principle 4: Integrate multiple modes of evidence
* Principle 5: Describe and document the evidence
* Principle 6: Content is king

* Principle 1: Show comparisons

  - Evidence for a hypothesis is always *relative* to another competing
    hypothesis.

  - Always ask "Compared to What?"

* Principle 2: Show causality, mechanism, explanation, systematic structure 
  - What is your causal framework for thinking about a question?

* Principle 3: Show multivariate data
  - Multivariate = more than 2 variables 
  - The real world is multivariate
  - Need to "escape flatland"
  
* Principle 4: Integration of evidence
  - Completely integrate words, numbers, images, diagrams

  - Data graphics should make use of many modes of data presentation 

  - Don't let the tool drive the analysis
  
* Principle 5: Describe and document the evidence with appropriate
  labels, scales, sources, etc.

  - A data graphic should tell a complete story that is credible 
  
* Principle 6: Content is king

  - Analytical presentations ultimately stand or fall depending on the
    quality, relevance, and integrity of their content
	


## Exploratory graphics

### Air Pollution in the United States

* The U.S. Environmental Protection Agency (EPA) sets national ambient
  air quality standards for outdoor air pollution

  * [U.S. National Ambient Air Quality Standards](http://www.epa.gov/air/criteria.html)

* For fine particle pollution (PM2.5), the "annual mean, averaged over
  3 years" cannot exceed $12~\mu g/m^3$.

* Data on daily PM2.5 are available from the U.S. EPA web site

  - [EPA Air Quality System](http://www.epa.gov/ttn/airs/airsaqs/detaildata/downloadaqsdata.htm)

* **Question**: Are there any counties in the U.S. that exceed that
  national standard for fine particle pollution?

---

### Data

Annual average PM2.5 averaged over the period 2008 through 2010 is
available on jtleeks repository [here](https://github.com/jtleek/modules/blob/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv). The actual csv file can be
accessed from [here](https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv).


```r
fileUrl <-
"https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv" 

download.file(fileUrl, destfile="./data/avgpm25.csv", method="curl")

pollution <- read.csv("./data/avgpm25.csv", colClasses = c("numeric", "character", 
    "factor", "numeric", "numeric"))
head(pollution)
```

```
##     pm25  fips region longitude latitude
## 1  9.771 01003   east    -87.75    30.59
## 2  9.994 01027   east    -85.84    33.27
## 3 10.689 01033   east    -87.73    34.73
## 4 11.337 01049   east    -85.80    34.46
## 5 12.120 01055   east    -86.03    34.02
## 6 10.828 01069   east    -85.35    31.19
```


Do any counties exceed the standard of $12~\mu g/m^3$?

---

### Summary of data, View data


One dimension

* Five-number summary
* Boxplots
* Histograms
* Density plot
* Barplot

---

### Five Number Summary


```r
summary(pollution$pm25)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    3.38    8.55   10.00    9.84   11.40   18.40
```


---
	
### Boxplot


```r
boxplot(pollution$pm25, col = "blue")
```

[Nice explanation of box plots](https://towardsdatascience.com/understanding-boxplots-5e2df7bcbd51)

* median (Q2/50th Percentile): the middle value of the dataset.

* first quartile (Q1/25th Percentile): the middle number between the smallest number (not the “minimum”) and the median of the dataset.

* third quartile (Q3/75th Percentile): the middle value between the median and the highest value (not the “maximum”) of the dataset.

* interquartile range (IQR): 25th to the 75th percentile.

* whiskers (shown in blue)

* outliers (shown as green circles)

* “maximum”: Q3 + 1.5*IQR

* “minimum”: Q1 -1.5*IQR

---

### Histogram
Bar plot basically!

```r
hist(pollution$pm25, col = "green")
```

Rug representation roughly informs about density by plotting below
histogram.

```r
hist(pollution$pm25, col = "green")
rug(pollution$pm25)
```
`breaks` parameter is used for determining the number of segments on
the Histogram.

```r
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)
```

---

### Overlaying Features


```r
boxplot(pollution$pm25, col = "blue")
abline(h = 12)
```

```r
hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)
```


---

### Barplot

Barplot is the histogram of text based info but without quantile and
all that shit!

```r
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")
```


---

### What plots to see >2 dimensions

**Two dimensions**

* Multiple/overlayed 1-D plots (Lattice/ggplot2)
* Scatterplots
* Smooth scatterplots

**greater than 2 dimensions**

* Overlayed/multiple 2-D plots; coplots
* Use color, size, shape to add dimensions
* Spinning plots
* Actual 3-D plots (not that useful)


---

### Multiple Boxplots

```r
boxplot(pm25 ~ region, data = pollution, col = "red")
```

---
	
### Multiple Histograms


```r
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")
```


---

### Scatterplot

```r
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)
```


---

### Scatterplot - Using Color


```r
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
```


---

### Multiple Scatterplots


```r
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
```



---

### Summary

* Exploratory plots are "quick and dirty"

* Let you summarize the data (usually graphically) and highlight any broad features

* Explore basic questions and hypotheses (and perhaps rule them out)

* Suggest modeling strategies for the "next step"

---


### Further resources

* [R Graph Gallery](http://gallery.r-enthusiasts.com/)
* [R Bloggers](http://www.r-bloggers.com/)


## Plotting systems
Functions like `plot` in base, `xyplot` in lattice, or `qplot` in
ggplot2 will default to sending a plot to the screen device
	
### The Base Plotting System

* "Artist's palette" model
* Start with blank canvas and build up from there
* Start with plot function (or similar)

* Use annotation functions to add/modify (`text`, `lines`, `points`,
  `axis`)
  
* Convenient, mirrors how we think of building plots and analyzing data

* ** Can’t go back once** plot has started (i.e. to adjust margins); need
  to plan in advance

* Difficult to "translate" to others once a new plot has been created
  (no graphical "language")

* Plot is just a series of R commands

---

### Base Plot


```r
library(datasets)
data(cars)
with(cars, plot(speed, dist))
```

---

### The Lattice System

* Plots are created with a single function call (`xyplot`, `bwplot`,
etc.)

* Most useful for conditioning types of plots: Looking at how y changes with x across levels of z

* Things like margins/spacing set automatically because entire plot is
  specified at once

* Good for puttng many many plots on a screen

* Sometimes awkward to specify an entire plot in a single function call

* Annotation in plot is not especially intuitive

* Use of panel functions and subscripts difficult to wield and
  requires intense preparation

* Cannot "add" to the plot once it is created

---

### Lattice Plot


```r
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


---

### The ggplot2 System

* Splits the difference between base and lattice in a number of ways

* Automatically deals with spacings, text, titles but also allows you
  to annotate by "adding" to a plot

* Superficial similarity to lattice but generally easier/more
  intuitive to use

* Default mode makes many choices for you (but you can still customize
  to your heart's desire)


---

### ggplot2 Plot


```r
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)
```


---

### Summary

* Base: "artist's palette" model

* Lattice: Entire plot specified by one function; conditioning

* ggplot2: Mixes elements of Base and Lattice

---

### References

Paul Murrell (2011). *R Graphics*, CRC Press.

Hadley Wickham (2009). *ggplot2*, Springer.
## What is a Graphics Device?

* A graphics device is something where you can make a plot appear

  * A window on your computer (screen device); Linux `x11()`
  
  * A PDF file (file device)

  * A PNG or JPEG file (file device)

  * A scalable vector graphics (SVG) file (file device)

* The most common place for a plot to be "sent" is the *screen device*

  * On Unix/Linux the screen device is launched with `x11()`

* When making a plot, you need to consider how the plot will be used
  to determine what device the plot should be sent to.

  - The list of devices is found in `?Devices`; there are also devices
    created by users on CRAN


* For quick visualizations and exploratory analysis, usually you want
  to use the screen device

  - Functions like `plot` in base, `xyplot` in lattice, or `qplot` in
    ggplot2 will default to sending a plot to the screen device

* otherwise use the file device




---

### Screen Device

1. Call a plotting function like `plot`, `xyplot`, or `qplot`



```r
library(datasets)
with(faithful, plot(eruptions, waiting))  ## Make plot appear on screen device
title(main = "Old Faithful Geyser data")  ## Annotate with a title
```

### File Device

The second approach to plotting is most commonly used for file devices:

1. Explicitly launch a graphics device

2. Call a plotting function to make a plot (Note: if you are using a file
device, no plot will appear on the screen)

3. Annotate plot if necessary

3. Explicitly close graphics device with `dev.off()` (**this is very important!)**


```r
pdf(file = "myplot.pdf")  ## Open PDF device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")  ## Annotate plot; still nothing on screen
dev.off()  ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer
```
Another example

``` R
png(filename="plot1.png", width=480, height=480)
hist(df$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
```


---

### Vector: File Devices types


There are two basic types of file devices: *vector* and *bitmap*
devices

Vector formats:

- `pdf`: useful for line-type graphics, resizes well, usually
  portable, not efficient if a plot has many objects/points

- `svg`: XML-based scalable vector graphics; supports animation and
  interactivity, potentially useful for web-based plots

- `win.metafile`: Windows metafile format (only on Windows)

- `postscript`: older format, also resizes well, usually portable, can
  be used to create encapsulated postscript files; Windows systems
  often don’t have a postscript viewer


---

### Bitmap: File Devices

Bitmap formats

- `png`: bitmapped format, good for line drawings or images with solid
  colors, uses lossless compression (like the old GIF format), most
  web browsers can read this format natively, good for plotting many
  many many points, does not resize well

- `jpeg`: good for photographs or natural scenes, uses lossy
  compression, good for plotting many many many points, does not
  resize well, can be read by almost any computer and any web browser,
  not great for line drawings

- `tiff`: Creates bitmap files in the TIFF format; supports lossless
  compression

- `bmp`: a native Windows bitmapped format

---

### Multiple Open Graphics Devices

```R
x11() # 1st screen
x11() # 2nd screen

dev.cur()
[1] X11cairo
     3
	
dev.set(2)
[1] X11cairo
     2
```

### Copying Plots; display and save plots

Copying a plot to another device can be useful because some plots
require a lot of code and it can be a pain to type all that in again
for a different device.

- `dev.copy`: copy a plot from one device to another

- `dev.copy2pdf`: specifically copy a plot to a PDF file 

NOTE: Copying a plot is not an exact operation, so the result may not
be identical to the original.


```r
library(datasets)
with(faithful, plot(eruptions, waiting))  ## Create plot on screen device
title(main = "Old Faithful Geyser data")  ## Add a main title
dev.copy(png, file = "geyserplot.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
```

```r
with(faithful, plot(eruptions,waiting))
dev.copy2pdf(file="pandian")
dev.off()
```

---

### Example Multiplot base plotting system using legend
As part of assignment,

``` R
plot(df$DateTime, df$Sub_metering_1, type="l", col="black", ylab="Energy sub metering",xlab="")
	lines(df$DateTime, df$Sub_metering_2, type="l", col="red")
lines(df$DateTime, df$Sub_metering_3, type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1:3, cex=0.8)

```

The below **Doesn't work**. Spent way too much time on it.

``` R
## legend(1, 95,
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
col=c("black","red","blue"),lty=1:3, cex=0.8) 
```



### Language settings on plots

[Stack Source](https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r)

Do this and all languages will be in english on the plots

	Sys.setlocale("LC_TIME", "en_US")
	
### Summary

* Plots must be created on a graphics device

* The default graphics device is almost always the screen device,
  which is most useful for exploratory analysis

* File devices are useful for creating plots that can be included in
  other documents or sent to other people

* For file devices, there are vector and bitmap formats

  - Vector formats are good for line drawings and plots with solid
    colors using a modest number of points

  - Bitmap formats are good for plots with a large number of points,
    natural scenes or web-based plots
## The Lattice Plotting System

The lattice plotting system is implemented using the following packages:

- *lattice*: contains code for producing Trellis graphics, which are
   independent of the “base” graphics system; includes functions like
   `xyplot`, `bwplot`, `levelplot`

- *grid*: implements a different graphing system independent of the
   “base” system; the *lattice* package builds on top of *grid*
   - We seldom call functions from the *grid* package directly

- The lattice plotting system does not have a "two-phase" aspect with
  separate plotting and annotation like in base plotting

- All plotting/annotation is done at once with a single function call


---

### Lattice Functions

- `xyplot`: this is the main function for creating scatterplots 
- `bwplot`: box-and-whiskers plots (“boxplots”)
- `histogram`: histograms
- `stripplot`: like a boxplot but with actual points 
- `dotplot`: plot dots on "violin strings"
- `splom`: scatterplot matrix; like `pairs` in base plotting system 
- `levelplot`, `contourplot`: for plotting "image" data

Lattice functions generally take a formula for their first argument, usually of the form

```r
xyplot(y ~ x | f * g, data)
```

- We use the *formula notation* here, hence the `~`.

- On the left of the ~ is the y-axis variable, on the right is the
  x-axis variable

- f and g are _conditioning variables_ — they are optional
  - the * indicates an interaction between two variables

- The second argument is the data frame or list from which the
  variables in the formula should be looked up

  - If no data frame or list is passed, then the parent frame is used.

- If no other arguments are passed, there are defaults that can be used.

---
### Simple Lattice Plot


```r
library(lattice)
library(datasets)
## Simple scatterplot.
xyplot(Ozone ~ Wind, data = airquality)
```

**Looking at 3 variables at a time**

```r
library(datasets)
library(lattice)
## Convert 'Month' to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
```

**transform** can be used or:

```R
airquality$Month <- as.factor(airquality$Month)
```

---

### Lattice Behavior

Lattice functions behave differently from base graphics functions in
one critical way.

- Base graphics functions plot data directly to the graphics device
  (screen, PDF file, etc.)

- Lattice graphics functions return an object of class **trellis**

- Lattice functions return "plot objects" that can, in principle, be
  stored (but it’s usually better to just save the code + data).

**You can save the plot to an object and it wont display just like
regular functions.**

```r
p <- xyplot(Ozone ~ Wind, data = airquality)  ## Nothing happens!
print(p)  ## Plot appears
```

```r
xyplot(Ozone ~ Wind, data = airquality)  ## Auto-printing
```

---

### Lattice Panel Functions

* Lattice functions have a **panel function** which controls what
  happens inside each panel of the plot.

* The *lattice* package comes with default panel functions, but you
  can supply your own if you want to customize what happens in each
  panel

* Panel functions receive the x/y coordinates of the data points
  in their panel (along with any optional arguments)


**Simple XY plots for case with xy related and not related**

```r
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))  ## Plot with 2 panels
```

**Custom panel function: Each window can have similar features**

```r
## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
    panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})
```

Can view large amount of data as shown [here](https://github.com/jtleek/modules/blob/master/04_ExploratoryAnalysis/PlottingLattice/figure/unnamed-chunk-8.png)

---

### Lattice Panel Functions: Regression line


```r
## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...)  ## First call default panel function
    panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})
```

### Many Panel Lattice Plot: Example from MAACS

* Study: Mouse Allergen and Asthma Cohort Study (MAACS)

* Study subjects: Children with asthma living in Baltimore City, many
  allergic to mouse allergen

* Design: Observational study, baseline home visit + every 3 months for a year.

* Question: How does indoor airborne mouse allergen vary over time and
  across subjects?


[Ahluwalia et al., *Journal of Allergy and Clinical Immunology*, 2013](http://www.ncbi.nlm.nih.gov/pubmed/23810154)

### Summary

* Lattice plots are constructed with a single function call to a core
  lattice function (e.g. `xyplot`)

* Aspects like margins and spacing are automatically handled and
  defaults are usually sufficient

* The lattice system is ideal for creating conditioning plots where
  you examine the same kind of plot under many different conditions

* Panel functions can be specified/customized to modify what is
  plotted in each of the plot panels
## GGPlot2 - mainly qplot()

### What is ggplot2?

- An implementation of _The Grammar of Graphics_ by Leland Wilkinson
- Written by Hadley Wickham (while he was a graduate student at Iowa State)
- A “third” graphics system for R (along with __base__ and __lattice__)
- Available from CRAN via `install.packages()`
- Web site: http://ggplot2.org (better documentation)

---

### What is ggplot2?

- Grammar of graphics represents an abstraction of graphics ideas/objects
- Think “verb”, “noun”, “adjective” for graphics
- Allows for a “theory” of graphics on which to build new graphics and graphics objects
- “Shorten the distance from mind to page”

---

### Grammer of Graphics

“In brief, the grammar tells us that a statistical graphic is a
__mapping__ from data to __aesthetic__ attributes (colour, shape,
size) of __geometric__ objects (points, lines, bars). The plot may
also contain statistical transformations of the data and is drawn on a
specific coordinate system”


### Plotting Systems in R: Base

- “Artist’s palette” model
- Start with blank canvas and build up from there
- Start with `plot` function (or similar)
- Use annotation functions to add/modify (`text`, `lines`, `points`, `axis`)

---

### Plotting Systems in R: Base

- Convenient, mirrors how we think of building plots and analyzing data
- Can’t go back once plot has started (i.e. to adjust margins); need to plan in advance
- Difficult to “translate” to others once a new plot has been created (no graphical “language”)
  - Plot is just a series of R commands

---

### Plotting Systems in R: Lattice

- Plots are created with a single function call (`xyplot`, `bwplot`, etc.)
- Most useful for conditioning types of plots: Looking at how $y$ changes with $x$ across levels of $z$
- Things like margins/spacing set automatically because entire plot is specified at once
- Good for putting many many plots on a screen

---

### Plotting Systems in R: Lattice

- Sometimes awkward to specify an entire plot in a single function call
- Annotation in plot is not intuitive
- Use of panel functions and subscripts difficult to wield and requires intense preparation
- Cannot “add” to the plot once it’s created

---

### Plotting Systems in R: ggplot2

- Split the difference between base and lattice
- Automatically deals with spacings, text, titles but also allows you to annotate by “adding”
- Superficial similarity to lattice but generally easier/more intuitive to use
- Default mode makes many choices for you (but you _can_ customize!)

---

### The Basics: `qplot()`

- Works much like the `plot` function in base graphics system
- Looks for data in a data frame, similar to lattice, or in the parent environment
- Plots are made up of _aesthetics_ (size, shape, color) and _geoms_ (points, lines)

---

### The Basics: `qplot()`

- Factors are important for indicating subsets of the data (if they are to have different properties); they should be __labeled__
- The `qplot()` hides what goes on underneath, which is okay for most operations
- `ggplot()` is the core function and very flexible for doing things `qplot()` cannot do

---

### Example Dataset


```r
library(ggplot2)
str(mpg)
```

```
'data.frame':	234 obs. of  11 variables:
 $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
 $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
 $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
 $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
 $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
 $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
 $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
 $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
 $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...
```



---

### ggplot2 “Hello, world!”


```r
qplot(displ, hwy, data = mpg)
```

<div class="rimage center"><img src="fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" class="plot" /></div>


---

### Modifying aesthetics


```r
qplot(displ, hwy, data = mpg, color = drv)
```

---

### Adding a geom


```r
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
```


---

### Histograms


```r
qplot(hwy, data = mpg, fill = drv)
```

<div class="rimage center"><img src="fig/unnamed-chunk-5.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" class="plot" /></div>




---

### Facets

Splits figure into as many based on the variable, for example months!

```r
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)
```

---

### MAACS Cohort

- Mouse Allergen and Asthma Cohort Study
- Baltimore children (aged 5—17)
- Persistent asthma, exacerbation in past year
- Study indoor environment and its relationship with asthma morbidity
- Recent publication: http://goo.gl/WqE9j8




---

### Example: MAACS


```r
str(maacs)
```

```
'data.frame':	750 obs. of  5 variables:
 $ id       : int  1 2 3 4 5 6 7 8 9 10 ...
 $ eno      : num  141 124 126 164 99 68 41 50 12 30 ...
 $ duBedMusM: num  2423 2793 3055 775 1634 ...
 $ pm25     : num  15.6 34.4 39 33.2 27.1 ...
 $ mopos    : Factor w/ 2 levels "no","yes": 2 2 2 2 2 2 2 2 2 2 ...
```



---

### Histogram of eNO


```r
qplot(log(eno), data = maacs)
```

<div class="rimage center"><img src="fig/unnamed-chunk-9.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" class="plot" /></div>


---

### Histogram by Group


```r
qplot(log(eno), data = maacs, fill = mopos)
```

<div class="rimage center"><img src="fig/unnamed-chunk-10.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" class="plot" /></div>


---

### Density Smooth


```r
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color = mopos)
```

<div class="rimage center"><img src="fig/unnamed-chunk-111.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" class="plot" />
<img src="fig/unnamed-chunk-112.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" class="plot" /></div>


---

### Scatterplots: eNO vs. PM$_{2.5}$


```r
qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)
```

<div class="rimage center"><img src="fig/unnamed-chunk-121.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" class="plot" />
<img src="fig/unnamed-chunk-122.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" class="plot" />
<img src="fig/unnamed-chunk-123.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" class="plot" /></div>



---

### Scatterplots: eNO vs. PM$_{2.5}$


```r
qplot(log(pm25), log(eno), data = maacs, color = mopos, 
      geom = c("point", "smooth"), method = "lm")
```

<div class="rimage center"><img src="fig/unnamed-chunk-13.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" class="plot" /></div>



---

### Scatterplots: eNO vs. PM$_{2.5}$


```r
qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"), 
      method = "lm", facets = . ~ mopos)
```

<div class="rimage center"><img src="fig/unnamed-chunk-14.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" class="plot" /></div>



---

### Summary of qplot()

- The `qplot()` function is the analog to `plot()` but with many built-in features
- Syntax somewhere in between base/lattice
- Produces very nice graphics, essentially publication ready (if you like the design)
- Difficult to go against the grain/customize (don’t bother; use full ggplot2 power in that case)

---

### Resources

- The _ggplot2_ book by Hadley Wickham
- The _R Graphics Cookbook_ by Winston Chang (examples in base plots and in ggplot2)
- ggplot2 web site (http://ggplot2.org)
- ggplot2 mailing list (http://goo.gl/OdW3uB), primarily for
  developers
## ggplot2 part 2





### Basic Components of a ggplot2 Plot
- A _data frame_
- _aesthetic mappings_: how data are mapped to color, size 
- _geoms_: geometric objects like points, lines, shapes. 
- _facets_: for conditional plots. 
- _stats_: statistical transformations like binning, quantiles, smoothing. 
- _scales_: what scale an aesthetic map uses (example: male = red, female = blue). 
- _coordinate system_ 

---

### Building Plots with ggplot2
- When building plots in ggplot2 (rather than using qplot) the “artist’s palette” model may be the closest analogy
- Plots are built up in layers
  - Plot the data
  - Overlay a summary
  - Metadata and annotation

---

### Example: BMI, PM$_{2.5}$, Asthma
- Mouse Allergen and Asthma Cohort Study
- Baltimore children (age 5-17)
- Persistent asthma, exacerbation in past year
- Does BMI (normal vs. overweight) modify the relationship between PM$_{2.5}$ and asthma symptoms?




---

### Basic Plot


```r
library(ggplot2)
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat, 
      geom = c("point", "smooth"), method = "lm")
```

---

### Building Up in Layers


```r
head(maacs)
```

```
  logpm25        bmicat NocturnalSympt logno2_new
1  1.5362 normal weight              1      1.299
2  1.5905 normal weight              0      1.295
3  1.5218 normal weight              0      1.304
4  1.4323 normal weight              0         NA
5  1.2762    overweight              8      1.108
6  0.7139    overweight              0      0.837
```

```r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
```

```
data: logpm25, bmicat, NocturnalSympt, logno2_new [554x4]
mapping:  x = logpm25, y = NocturnalSympt
faceting: facet_null() 
```

### No Plot Yet!


```r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
print(g)
```

```
Error: No layers in plot
```


---

### First Plot with Point Layer


```r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()
```

---

### Adding More Layers: Smooth geom


```r
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
```


### Adding More Layers: Facets


```r
g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")
```

---

### Annotation
- Labels: `xlab()`, `ylab()`, `labs()`, `ggtitle()`
- Each of the “geom” functions has options to modify 
- For things that only make sense globally, use `theme()` 
  - Example: `theme(legend.position = "none")` 
- Two standard appearance themes are included
  - `theme_gray()`: The default theme (gray background)
  - `theme_bw()`: More stark/plain 

---

### Modifying Aesthetics


```r
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)
```


---

### Modifying Labels


```r
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + 
  labs(x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")
```

---

### Customizing the Smooth


```r
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
```

<div class="rimage center"><img src="fig/unnamed-chunk-10.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" class="plot" /></div>


---

### Changing the Theme


```r
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")
```

<div class="rimage center"><img src="fig/unnamed-chunk-11.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" class="plot" /></div>


---

### A Note about Axis Limits


```r
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100  ## Outlier!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
```




---

### Axis Limits


```r
g + geom_line() + ylim(-3, 3)
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
```



---

### More Complex Example
- How does the relationship between PM$_{2.5}$ and nocturnal symptoms vary by BMI and NO$_2$?
- Unlike our previous BMI variable, NO$_2$ is continuous
- We need to make NO$_2$ categorical so we can condition on it in the plotting
- Use the `cut()` function for this

---

### Making NO$_2$ Tertiles


```r
## Calculate the tertiles of the data
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = TRUE)

## Cut the data at the tertiles and create a new factor variable
maacs$no2tert <- cut(maacs$logno2_new, cutpoints)

## See the levels of the newly created factor variable
levels(maacs$no2tert)
```

```
[1] "(0.378,1.2]" "(1.2,1.42]"  "(1.42,2.55]"
```


---

### Code for Final Plot


```r
## Setup ggplot with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))

## Add layers
g + geom_point(alpha = 1/3) + 
  facet_wrap(bmicat ~ no2tert, nrow = 2, ncol = 4) + 
  geom_smooth(method="lm", se=FALSE, col="steelblue") + 
  theme_bw(base_family = "Avenir", base_size = 10) + 
  labs(x = expression("log " * PM[2.5])) + 
  labs(y = "Nocturnal Symptoms") + 
  labs(title = "MAACS Cohort")
```


---

### Summary
- ggplot2 is very powerful and flexible if you learn the “grammar” and the various elements that can be tuned/modified
- Many more types of plots can be made; explore and mess around with
		the package (references mentioned in Part 1 are useful)
		
### Important resource on legend, legend order and coloring
Was trying to change labels of legend. nothing works just like in this
stack question;

https://stackoverflow.com/questions/23635662/editing-legend-text-labels-in-ggplot


http://www.cookbook-r.com/Graphs/

[We need to change the order of the factor](https://stackoverflow.com/a/54079708/5986651) so that `breaks`
corresponds with `values` (see below)

``` R

mn5$fips <- factor(mn5$fips, levels=c("24510","06037")) # to change
                                        # legend order later!
										
g <- ggplot(data=mn5, aes(x=year,y=Mean.Emissions,color=fips))+
    geom_line()

g + scale_colour_manual(breaks=c("24510","06037"),values=c("red","green"))

```


## Hierarchical Clustering
### Can we find things that are close together? 

Clustering organizes things that are __close__ into groups


* How do we define close?
* How do we group things?
* How do we visualize the grouping? 
* How do we interpret the grouping? 

* An agglomerative approach
  * Find closest two things
  * Put them together
  * Find next closest
* Requires
  * A defined distance
  * A merging approach
* Produces
  * A tree showing how close things are to each other


---


### How do we define close?

* Most important step
  * Garbage in -> garbage out
* Distance or similarity
  * Continuous - euclidean distance
  * Continuous - correlation similarity
  * Binary - manhattan distance
* Pick a distance/similarity that makes sense for your problem
  
  

---

### Example distances - Euclidean

Point to point

In general:

$$\sqrt{(A_1-A_2)^2 + (B_1-B_2)^2 + \ldots + (Z_1-Z_2)^2}$$
[http://rafalab.jhsph.edu/688/lec/lecture5-clustering.pdf](http://rafalab.jhsph.edu/688/lec/lecture5-clustering.pdf)

---

### Example distances - Manhattan

Like moving in a grid

In general:

$$|A_1-A_2| + |B_1-B_2| + \ldots + |Z_1-Z_2|$$

[http://en.wikipedia.org/wiki/Taxicab_geometry](http://en.wikipedia.org/wiki/Taxicab_geometry)

---

### Hierarchical clustering - example

```r
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
```

### Hierarchical clustering - `dist`

* Important parameters: _x_,_method_

```r
dataFrame <- data.frame(x = x, y = y)
dist(dataFrame)
```

```
##          1       2       3       4       5       6       7       8       9
## 2  0.34121                                                                
## 3  0.57494 0.24103                                                        
## 4  0.26382 0.52579 0.71862                                                
## 5  1.69425 1.35818 1.11953 1.80667                                        
## 6  1.65813 1.31960 1.08339 1.78081 0.08150                                
## 7  1.49823 1.16621 0.92569 1.60132 0.21110 0.21667                        
## 8  1.99149 1.69093 1.45649 2.02849 0.61704 0.69792 0.65063                
## 9  2.13630 1.83168 1.67836 2.35676 1.18350 1.11500 1.28583 1.76461        
## 10 2.06420 1.76999 1.63110 2.29239 1.23848 1.16550 1.32063 1.83518 0.14090
## 11 2.14702 1.85183 1.71074 2.37462 1.28154 1.21077 1.37370 1.86999 0.11624
## 12 2.05664 1.74663 1.58659 2.27232 1.07701 1.00777 1.17740 1.66224 0.10849
##         10      11
## 2                 
## 3                 
## 4                 
## 5                 
## 6                 
## 7                 
## 8                 
## 9                 
## 10                
## 11 0.08318        
## 12 0.19129 0.20803
```

---

### Hierarchical clustering - hclust


```r
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)
```

Plots a dendogram



---

### Prettier dendrograms

Use this function for prettier dendograms

```r
myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), 
    hang = 0.1, ...) {
    ## modifiction of plclust for plotting hclust objects *in colour*!  Copyright
    ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
    ## of labels of the leaves of the tree lab.col: colour for the labels;
    ## NA=default device foreground colour hang: as in hclust & plclust Side
    ## effect: A display of hierarchical cluster with coloured leaf labels.
    y <- rep(hclust$height, 2)
    x <- as.numeric(hclust$merge)
    y <- y[which(x < 0)]
    x <- x[which(x < 0)]
    x <- abs(x)
    y <- y[order(x)]
    x <- x[order(x)]
    plot(hclust, labels = FALSE, hang = hang, ...)
    text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order], 
        col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}
```

---

	
### Pretty dendrograms


```r
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))
```



---

### Even Prettier dendrograms


Site doesn't work! Site broken!

[http://gallery.r-enthusiasts.com/RGraphGallery.php?graph=79](http://gallery.r-enthusiasts.com/RGraphGallery.php?graph=79)


---

### Merging points - complete or average

> method: the agglomeration method to be used.  This should be (an
>           unambiguous abbreviation of) one of ‘"ward.D"’, ‘"ward.D2"’,
>           ‘"single"’, ‘"complete"’, ‘"average"’ (= UPGMA), ‘"mcquitty"’
>           (= WPGMA), ‘"median"’ (= WPGMC) or ‘"centroid"’ (= UPGMC).

method for hclust so that the clustering is done based on the farthest
points within the existing cluster if "complete".

### `heatmap()`
Clusters rows based on XY distance just like hclust. 

For columns it looks at individual columns and color codes them to
points that are close to each other.

```r
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)
```

In this example Y (9,12,6,7,1,5,11) are all "close" by where (3,2,4)
ain't!

---

### Notes and further resources

* Gives an idea of the relationships between variables/observations
* The picture may be unstable
  * Change a few points
  * Have different missing values
  * Pick a different distance
  * Change the merging strategy
  * Change the scale of points for one variable
* But it is deterministic
* Choosing where to cut isn't always obvious
* Should be primarily used for exploration 
* [Rafa's Distances and Clustering Video](http://www.youtube.com/watch?v=wQhVWUcXM0A)
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)

  
### My notes on hierarchical clustering and heatmaps

Hierarchical clustering is when you compare rows or columns of a DF by
first scaling them and the point is to see how everything is related
to each other. For example:

```R
s<-matrix(1:25,5)
s[lower.tri(s)] = t(s)[lower.tri(s)]
heatmap(s)
```

`Heatmap()` takes a DF and then does hierarchical clustering on the
rows and columns. It uses the `dist()` to make distance based on
different `method` arguments. For example, for the `eucledian method`,
it basically takes 2 entire row vectors on n dimension and measures
the eucledian distance and uses that for clustering. Same with the Column.


## Kmeans! Can we find things that are close together? 

* How do we define close?
* How do we group things?
* How do we visualize the grouping? 
* How do we interpret the grouping? 


---

### How do we define close?

* Most important step
  * Garbage in $\longrightarrow$ garbage out
* Distance or similarity
  * Continuous - euclidean distance
  * Continous - correlation similarity
  * Binary - manhattan distance
* Pick a distance/similarity that makes sense for your problem
  

---

### K-means clustering

* A partioning approach
  * Fix a number of clusters
  * Get "centroids" of each cluster
  * Assign things to closest centroid
  * Reclaculate centroids
* Requires
  * A defined distance metric
  * A number of clusters
  * An initial guess as to cluster centroids
* Produces
  * Final estimate of cluster centroids
  * An assignment of each point to clusters
  

---

### K-means clustering -  example

```r
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
```
### What Kmeans does?

-  starting centroids are guessed

-  assign points to closest centroid

- recalculates centroids

- reassigns points to closest centroid

- update centroids

---

### `kmeans()`

* Important parameters: _x_, _centers_, _iter.max_, _nstart_


```r
dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
```

```
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"         "iter"        
## [9] "ifault"
```

```r
kmeansObj$cluster
```

```
##  [1] 3 3 3 3 1 1 1 1 2 2 2 2
```


---


### `kmeans()`


```r
par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)
```

---

### Heatmaps


```r
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj2$cluster)], yaxt = "n")
```

slides have an error: `kmeansObj$cluster` is used and gives shitty
results!

---

### Notes and further resources

* K-means requires a number of clusters
  * Pick by eye/intuition
  * Pick by cross validation/information theory, etc.
  * [Determining the number of clusters](http://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set)
* K-means is not deterministic
  * Different # of clusters 
  * Different number of iterations
* [Rafael Irizarry's Distances and Clustering Video](http://www.youtube.com/watch?v=wQhVWUcXM0A)
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)

## Dimension reduction

### Matrix data 


```r
set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
```

---

### Cluster the data 


```r
par(mar = rep(0.2, 4))
heatmap(dataMatrix)
```

---

### What if we add a pattern?


```r
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
    }
}
```

	rep(c(0,3),each=5) 
	
produces 0,0,0,0,0,3,3,3,3,3;

Adds mean to last 5 columns only

---

### What if we add a pattern? - the data

You see split between first and last 5 columns!

```r
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
```

---

### What if we add a pattern? - the clustered data; heatmap

Appears random in the rows...

```r
par(mar = rep(0.2, 4))
heatmap(dataMatrix)
```

---

### Patterns in rows and columns; heatmap


order it and plot the heatmap

```r
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)
```

### Related problems

You have multivariate variables $X_1,\ldots,X_n$ so $X_1 = (X_{11},\ldots,X_{1m})$

* Find a new set of multivariate variables that are uncorrelated and explain as much variance as possible.
* If you put all the variables together in one matrix, find the best matrix created with fewer variables (lower rank) that explains the original data.


The first goal is <font color="#330066">statistical</font> and the second goal is <font color="#993300">data compression</font>.

---

### Related solutions - PCA/SVD

__SVD__

If $X$ is a matrix with each variable in a column and each observation in a row then the SVD is a "matrix decomposition"

$$ X = UDV^T$$

where the columns of $U$ are orthogonal (left singular vectors), the columns of $V$ are orthogonal (right singular vectors) and $D$ is a diagonal matrix (singular values). 

__PCA__

The principal components are equal to the right singular values if you
first scale (subtract the mean, divide by the standard deviation) the
variables.

This is pretty much it, it is a different way of doing the SVD I guess!

---

### What is SVD? 

X = U D V', U spans the column space and V spans the row space and are
orthonormal vectors (UU^T=I). 

X --> mxn; U --> mxm; D --> mxn; V --> nxn

Rank of X, r <= min(m,n)

If r < min(m,n), then

U and V have r vectors in the column (n) and row space (m). and n-r
vectors in the column space and m-r vectors in the row space.

[Gilbert Strang lecture is the source of this content.](https://www.youtube.com/watch?v=Nx0lRBaXoz4)

### Components of the SVD - $u$ and $v$
     
```r
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1, , xlab = "Row", ylab = "First left singular vector", 
    pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)
```

### When to scale and center

`scale()` does both centering and scaling if true, i.e., (x\_i -
mean(x\_i)/sd(x\_i) 


> it depends on the type of data you have. For some types of well
> defined data, there may be no need to scale and center. A good
> example is geolocation data (longitudes and latitudes). If you were
> seeking to cluster towns, you wouldn't need to scale and center
> their locations.
>
> For data that is of different physical measurements or units, its
> probably a good idea to scale and center. For example, when
> clustering vehicles, the data may contain attributes such as number
> of wheels, number of doors, miles per gallon, horsepower etc. In
> this case it may be a better idea to scale and center since you are
> unsure of the relationship between each attribute.
>
> The intuition behind that is that since many clustering algorithms
> require some definition of distance, if you do not scale and center
> your data, you may give attributes which have larger magnitudes more
> importance.
>
> In the context of your problem, I would scale and center the data if
> it contains attributes like patient height, weight, age etc.

[Source Stack](https://datascience.stackexchange.com/a/22369/67821)



---

### Components of the SVD - Variance calculation

`svd1$d^2/sum(svd1$d^2)`

```r
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", 
    pch = 19)
```



---

### SVD vs PCA; principle component analysis

Same as Right singular vectors. Nothing more. Look [here](https://www.youtube.com/) for more info.
```r
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "Principal Component 1", 
    ylab = "Right Singular Vector 1")
abline(c(0, 1))
```


---

### Components of the SVD - variance explained


```r
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)
```

---

## Dimension reduction: identifying patterns
### What if we add a second pattern?


```r
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
    coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip1) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5)
    }
    if (coinFlip2) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), 5)
    }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
```


---

### Singular value decomposition - true patterns 


```r
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0, 1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0, 1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")
```



---

###  $v$ and patterns of variance in rows


```r
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[, 1], pch = 19, xlab = "Column", ylab = "First right singular vector")
plot(svd2$v[, 2], pch = 19, xlab = "Column", ylab = "Second right singular vector")
```




---

###  $d$ and variance explained


```r
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percent of variance explained", 
    pch = 19)
```



---

### Missing values NA 


```r
dataMatrix2 <- dataMatrixOrdered
## Randomly insert some missing data
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2))  ## Doesn't work!
```

```
## Error: infinite or missing values in 'x'
```



---

### Own imputing the missing values NA

``` R
mn2 <- df %>% group_by(interval) %>% mutate(mean.across.days=mean(steps,na.rm=TRUE))
## Are there differences in activity patterns between weekdays and
## weekends?

na.row <- which(is.na(mn2$steps),arr.ind=TRUE)
mn2$steps.imputed.without.NA <- mn2$steps
mn2$steps.imputed.without.NA[na.row] <- mn2$mean.across.days[na.row]
```

### Imputing {impute}


```r
library(impute)  ## Available from http://bioconductor.org
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2)); plot(svd1$v[,1],pch=19); plot(svd2$v[,1],pch=19)
```





---

### Face example

<!-- ## source("http://dl.dropbox.com/u/7710864/courseraPublic/myplclust.R") -->


```r
load("data/face.rda")
image(t(faceData)[, nrow(faceData):1])
```




---

### Face example - variance explained


```r
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2), pch = 19, xlab = "Singular vector", ylab = "Variance explained")
```


---

### Face example - create approximations


```r

svd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication

# Here svd1$d[1] is a constant
approx1 <- svd1$u[, 1] %*% t(svd1$v[, 1]) * svd1$d[1]

# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[, 1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[, 1:5])
approx10 <- svd1$u[, 1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[, 1:10])
```


---

### Face example - plot approximations

```r
par(mfrow = c(1, 4))
image(t(approx1)[, nrow(approx1):1], main = "(a)")
image(t(approx5)[, nrow(approx5):1], main = "(b)")
image(t(approx10)[, nrow(approx10):1], main = "(c)")
image(t(faceData)[, nrow(faceData):1], main = "(d)")  ## Original data
```




---

### Notes and further resources

* Scale matters
* PC's/SV's may mix real patterns
* Can be computationally intensive
* [Advanced data analysis from an elementary point of view](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/ADAfaEPoV.pdf)
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* Alternatives
  * [Factor analysis](http://en.wikipedia.org/wiki/Factor_analysis)
  * [Independent components analysis](http://en.wikipedia.org/wiki/Independent_component_analysis)
  * [Latent semantic analysis](http://en.wikipedia.org/wiki/Latent_semantic_analysis)
## Colors
### Plotting and Color
- The default color schemes for most plots in R are horrendous
  - I don’t have good taste and even I know that
- Recently there have been developments to improve the handling/specifica1on of colors in plots/graphs/etc.
- There are functions in R and in external packages that are very handy

---


### Color U1li1es in R

- The `grDevices` package has two functions 
  - `colorRamp`
  - `colorRampPalette`
- These functions take palettes of colors and help to interpolate between the colors
- The function colors() lists the names of colors you can use in any plotting function

---

### Color Palette Utilities in R

- `colorRamp`: Take a palette of colors and return a function that takes valeus between 0 and 1, indicating the extremes of the color palette (e.g. see the 'gray' function)
- `colorRampPalette`: Take a palette of colors and return a function that takes integer arguments and returns a vector of colors interpolating the palette (like `heat.colors` or `topo.colors`)

---

### colorRamp

`[,1] [,2] [,3]` corresponds to `[Red] [Blue] [Green]`

```r
> pal <- colorRamp(c("red", "blue"))

> pal(0)
     [,1] [,2] [,3]
[1,]  255    0    0

> pal(1)
     [,1] [,2] [,3]
[1,]    0    0  255

> pal(0.5)
      [,1] [,2]  [,3]
[1,] 127.5    0 127.5
```

---

### colorRamp

```r
> pal(seq(0, 1, len = 10))
                  [,1] [,2]       [,3]
        [1,] 255.00000    0          0
        [2,] 226.66667    0   28.33333
        [3,] 198.33333    0   56.66667
        [4,] 170.00000    0   85.00000
        [5,] 141.66667    0  113.33333
        [6,] 113.33333    0  141.66667
        [7,]  85.00000    0  170.00000
        [8,]  56.66667    0  198.33333
        [9,]  28.33333    0  226.66667
        [10,]  0.00000    0  255.00000
```

---

### colorRampPalette

```r
> pal <- colorRampPalette(c("red", "yellow"))

> pal(2)
[1] "#FF0000" "#FFFF00"

> pal(10)
 [1] "#FF0000" "#FF1C00" "#FF3800" "#FF5500" "#FF7100"
 [6] "#FF8D00" "#FFAA00" "#FFC600" "#FFE200" "#FFFF00”
```

---

### RColorBrewer Package

-  One package on CRAN that contains **interesing/useful color palettes**

- There are 3 types of palettes
  - **Sequential**
  - **Diverging**
  - **Qualitative**
- Palette informa1on can be used in conjunction with the `colorRamp()` and `colorRampPalette()`


https://www.google.com/search?q=rcolorbrewer+package&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjUgtT7wsLgAhXIaFAKHVk6CdsQ_AUIDigB&biw=792&bih=756#imgrc=FVFdJalwdTOVNM:

---

### RColorBrewer and colorRampPalette

```r
library(RColorBrewer)

cols <- brewer.pal(3, "BuGn")

cols
[1] "#E5F5F9" "#99D8C9" "#2CA25F"

pal <- colorRampPalette(cols)

image(volcano, col = pal(20))
```

---

### The smoothScatter function

``` R
x-> rnorm(1000)
y-> rnorm(1000)
smoothScatter(x,y)


```

---

### Some other plotting notes

- The `rgb` function can be used to produce any color via red, green, blue proportions
- Color transparency can be added via the `alpha` parameter to `rgb`
- The `colorspace` package can be used for a different control over colors

---

### Scatterplot with no transparency

plot(x,y,pch=19)

---

### Scatterplot with transparency

plot(x,y,col=rgb(0,0,0,0.2),pch=19)

---

### Summary

- Careful use of colors in plots/maps/etc. can make it easier for the reader to get what you're trying to say (why make it harder?)
- The `RColorBrewer` package is an R package that provides color palettes for sequential, categorical, and diverging data
- The `colorRamp` and `colorRampPalette` functions can be used in conjunction with color palettes to connect data to colors
- Transparency can sometimes be used to clarify plots with many points
## c4-w4
### Slightly processed data

[Samsung data file](https://github.com/jtleek/modules/blob/master/04_ExploratoryAnalysis/clusteringExample/data/samsungData.rda)


```r
load("data/samsungData.rda")
names(samsungData)[1:12]
```

```
##  [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"
##  [4] "tBodyAcc-std()-X"  "tBodyAcc-std()-Y"  "tBodyAcc-std()-Z" 
##  [7] "tBodyAcc-mad()-X"  "tBodyAcc-mad()-Y"  "tBodyAcc-mad()-Z" 
## [10] "tBodyAcc-max()-X"  "tBodyAcc-max()-Y"  "tBodyAcc-max()-Z"
```

```r
table(samsungData$activity)
```

```
## 
##   laying  sitting standing     walk walkdown   walkup 
##     1407     1286     1374     1226      986     1073
```


---

### Plotting average acceleration for first subject


```r
par(mfrow = c(1, 2), mar = c(5, 4, 1, 1))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub1)[2])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity), 
    pch = 1)
```

Need to use `unique` for legend, don't need to use us unique in plot.


---

### Clustering based just on average acceleration

<!-- ## -->
<!-- source("http://dl.dropbox.com/u/7710864/courseraPublic/myplclust.R")  -->
<!-- above line of course doens't work! -->

This is a bad idea in this case as the avg acc is not able to
distinguish between the different activities.

```r
library(rafalib)
source("myplclust.R")
distanceMatrix <- dist(sub1[, 1:3])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))
```
https://rdrr.io/cran/rafalib/src/R/myplclust.R 


---

### Plotting max acceleration for the first subject


```r
par(mfrow = c(1, 2))
plot(sub1[, 10], pch = 19, col = sub1$activity, ylab = names(sub1)[10])
plot(sub1[, 11], pch = 19, col = sub1$activity, ylab =
names(sub1)[11])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity), pch = 1)
``` 
Much better way to identify parameters for clustering and setting
cutoffs for identifying or distinguishing things.

---

### Clustering based on maximum acceleration
Now we see some useful clustering based on distance, taking in XYZ acc!

```r
distanceMatrix <- dist(sub1[, 10:12])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))
legend("topright", legend = unique(sub1$activity), col = unique(sub1$activity), 
    pch = 1)
```




---

### Singular Value Decomposition


```r
svd1 = svd(scale(sub1[, -c(562, 563)]))
par(mfrow = c(1, 2))
plot(svd1$u[, 1], col = sub1$activity, pch = 19)
plot(svd1$u[, 2], col = sub1$activity, pch = 19)
```


---

### Find maximum contributor


```r
plot(svd1$v[, 2], pch = 19)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 



---

###  New clustering with maximum contributer


```r
maxContrib <- which.max(svd1$v[, 2])
distanceMatrix <- dist(sub1[, c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 



---

###  New clustering with maximum contributer


```r
names(samsungData)[maxContrib]
```

```
## [1] "fBodyAcc.meanFreq...Z"
```


---

###  K-means clustering (nstart=1, first try)


```r
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6)
table(kClust$cluster, sub1$activity)
```

```
##    
##     laying sitting standing walk walkdown walkup
##   1      0       0        0   50        1      0
##   2      0       0        0    0       48      0
##   3     27      37       51    0        0      0
##   4      3       0        0    0        0     53
##   5      0       0        0   45        0      0
##   6     20      10        2    0        0      0
```




---

###  K-means clustering (nstart=1, second try)


```r
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)
```

```
##    
##     laying sitting standing walk walkdown walkup
##   1      0       0        0    0       49      0
##   2     18      10        2    0        0      0
##   3      0       0        0   95        0      0
##   4     29       0        0    0        0      0
##   5      0      37       51    0        0      0
##   6      3       0        0    0        0     53
```



---

###  K-means clustering (nstart=100, first try)


```r
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)
```

```
##    
##     laying sitting standing walk walkdown walkup
##   1     18      10        2    0        0      0
##   2     29       0        0    0        0      0
##   3      0       0        0   95        0      0
##   4      0       0        0    0       49      0
##   5      3       0        0    0        0     53
##   6      0      37       51    0        0      0
```




---

###  K-means clustering (nstart=100, second try)


```r
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)
```

```
##    
##     laying sitting standing walk walkdown walkup
##   1     29       0        0    0        0      0
##   2      3       0        0    0        0     53
##   3      0       0        0    0       49      0
##   4      0       0        0   95        0      0
##   5      0      37       51    0        0      0
##   6     18      10        2    0        0      0
```


---

###  Cluster 1 Variable Centers (Laying)


```r
plot(kClust$center[1, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 



---

###  Cluster 2 Variable Centers (Walking)


```r
plot(kClust$center[4, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 



## Airpollution example

### setwd

``` R
setwd("./blablabla/")
```

### Entry questions Has fine particle pollution in the U.S. decreased from 1999 to 2012?

### Read in data from 1999

``` R
pm0 <- read.table("RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
dim(pm0)
head(pm0)
cnames <- readLines("RD_501_88101_1999-0.txt", 1)
print(cnames)
cnames <- strsplit(cnames, "|", fixed = TRUE)
print(cnames)
names(pm0) <- make.names(cnames[[1]])
head(pm0)
x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)
mean(is.na(x0))  ## Are missing values important here?
```

### Read in data from 2012

``` R
pm1 <- read.table("RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "", nrow = 1304290)
names(pm1) <- make.names(cnames[[1]]) # remove spaces in names
head(pm1)
dim(pm1)
x1 <- pm1$Sample.Value
class(x1)
```

### Five number summaries for both periods
summary(x1)
summary(x0)
mean(is.na(x1))  ## Are missing values important here?

### Make a boxplot of both 1999 and 2012
boxplot(x0, x1)
boxplot(log10(x0), log10(x1))

### Check negative values in 'x1'
summary(x1)
negative <- x1 < 0
sum(negative, na.rm = T)
mean(negative, na.rm = T)
dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)
hist(dates, "month")  ## Check what's going on in months 1--6


### Plot a subset for one monitor at both times

### Find a monitor for New York State that exists in both datasets
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)
both <- intersect(site0, site1)
print(both)

### Find how many observations available at each monitor
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)

### Choose county 63 and side ID 2008
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
dim(pm1sub)
dim(pm0sub)

### Plot data for 2012
dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
str(dates1)
plot(dates1, x1sub)

### Plot data for 1999
dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)

### Plot data for both years in same panel
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20)  ## Whoa! Different ranges
abline(h = median(x1sub, na.rm = T))

### Find global range
rng <- range(x0sub, x1sub, na.rm = T)
rng
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = T))

### Show state-wide means and make a plot showing trend
head(pm0)
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn0)
summary(mn0)
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn1)

### Make separate data frames for states / years
d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)
mrg <- merge(d0, d1, by = "state")
dim(mrg)
head(mrg)

### Connect lines
par(mfrow = c(1, 1))
with(mrg, plot(rep(1, 52), mrg[, 2], xlim = c(.5, 2.5)))
with(mrg, points(rep(2, 52), mrg[, 3]))
segments(rep(1, 52), mrg[, 2], rep(2, 52), mrg[, 3])
## Reproducible research (c5)- Structure of Data analysis
### Steps in a data analysis

* <redtext>Define the question</redtext>
* <redtext>Define the ideal data set</redtext>
* <redtext>Determine what data you can access</redtext>
* <redtext>Obtain the data</redtext>
* <redtext>Clean the data </redtext> 
* Exploratory data analysis
* Statistical prediction/modeling
* Interpret results
* Challenge results
* Synthesize/write up results
* Create reproducible code


--- 

### The key challenge in data analysis

"Ask yourselves, what problem have you solved, ever, that was worth solving, where you knew all of the given information in advance? Where you didn’t have a surplus of information and have to filter it out, or you had insufficient information and have to go find some?"

---

### An example

__Start with a general question__

Can I automatically detect emails that are SPAM that are not?

__Make it concrete__

Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?

---

### Define the ideal data set

* The data set may depend on your goal
  * Descriptive - a whole population
  * Exploratory - a random sample with many variables measured
  * Inferential - the right population, randomly sampled
  * Predictive - a training and test data set from the same population
  * Causal - data from a randomized study
  * Mechanistic - data about all components of the system
  
Say for example, [http://www.google.com/about/datacenters/inside/](http://www.google.com/about/datacenters/inside/)


---

### Determine what data you can access

* Sometimes you can find data free on the web
* Other times you may need to buy the data
* Be sure to respect the terms of use
* If the data don't exist, you may need to generate it yourself

### A possible solution

Open source data available on UCI! 

[http://archive.ics.uci.edu/ml/datasets/Spambase](http://archive.ics.uci.edu/ml/datasets/Spambase)

---

### Obtain the data

* Try to obtain the raw data
* Be sure to reference the source
* Polite emails go a long way
* If you will load the data from an internet source, record the url and time accessed

---

### Our data set for spam emails!

`kernlab` seems to have data on spam email!

[http://search.r-project.org/library/kernlab/html/spam.html](http://search.r-project.org/library/kernlab/html/spam.html)



---

### Clean the data

* Raw data often needs to be processed
* If it is pre-processed, make sure you understand how
* Understand the source of the data (census, sample, convenience sample, etc.)
* May need reformating, subsampling - record these steps
* __Determine if the data are good enough__ - if not, quit or change data

---

### Our cleaned data set


```r
# If it isn't installed, install the kernlab package with install.packages()
library(kernlab)
data(spam)
str(spam[, 1:5])
```

```
'data.frame':	4601 obs. of  5 variables:
 $ make   : num  0 0.21 0.06 0 0 0 0 0 0.15 0.06 ...
 $ address: num  0.64 0.28 0 0 0 0 0 0 0 0.12 ...
 $ all    : num  0.64 0.5 0.71 0 0 0 0 0 0.46 0.77 ...
 $ num3d  : num  0 0 0 0 0 0 0 0 0 0 ...
 $ our    : num  0.32 0.14 1.23 0.63 0.63 1.85 1.92 1.88 0.61 0.19 ...
```


[http://search.r-project.org/library/kernlab/html/spam.html](http://search.r-project.org/library/kernlab/html/spam.html)


## Structure of Data analysis 2 (c5)
### Steps in a data analysis

* Define the question
* Define the ideal data set
* Determine what data you can access
* Obtain the data
* Clean the data
* <redtext>Exploratory data analysis</redtext>
* <redtext>Statistical prediction/modeling</redtext>
* <redtext>Interpret results</redtext>
* <redtext>Challenge results</redtext>
* <redtext>Synthesize/write up results</redtext>
* <redtext>Create reproducible code</redtext>



---

### An example

__Start with a general question__

Can I automatically detect emails that are SPAM or not?

__Make it concrete__

Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?


--- 

### Our data set

[http://search.r-project.org/library/kernlab/html/spam.html](http://search.r-project.org/library/kernlab/html/spam.html)

--- 

### Subsampling our data set
We need to generate a test and training set (prediction)

```r
# If it isn't installed, install the kernlab package
library(kernlab)
data(spam)
# Perform the subsampling
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)
```

```
## trainIndicator
##    0    1 
## 2314 2287
```

```r
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]
```

---
	
### Exploratory data analysis

* Look at summaries of the data
* Check for missing data
* Create exploratory plots
* Perform exploratory analyses (e.g. clustering)

---

### Names

```r
names(trainSpam)
```

```
##  [1] "make"              "address"           "all"              
##  [4] "num3d"             "our"               "over"             
##  [7] "remove"            "internet"          "order"            
## [10] "mail"              "receive"           "will"             
## [13] "people"            "report"            "addresses"        
## [16] "free"              "business"          "email"            

```



---

### Head

```r
head(trainSpam)
```

```
##    make address  all num3d  our over remove internet order mail receive
## 1  0.00    0.64 0.64     0 0.32 0.00   0.00        0  0.00 0.00    0.00
## 7  0.00    0.00 0.00     0 1.92 0.00   0.00        0  0.00 0.64    0.96
## 9  0.15    0.00 0.46     0 0.61 0.00   0.30        0  0.92 0.76    0.76
## 12 0.00    0.00 0.25     0 0.38 0.25   0.25        0  0.00 0.00    0.12
## 14 0.00    0.00 0.00     0 0.90 0.00   0.90        0  0.00 0.90    0.90
## 16 0.00    0.42 0.42     0 1.27 0.00   0.42        0  0.00 1.27    0.00
##    will people report addresses free business email  you credit your font
## 1  0.64   0.00      0         0 0.32        0  1.29 1.93   0.00 0.96    0
## 7  1.28   0.00      0         0 0.96        0  0.32 3.85   0.00 0.64    0
## 9  0.92   0.00      0         0 0.00        0  0.15 1.23   3.53 2.00    0
## 12 0.12   0.12      0         0 0.00        0  0.00 1.16   0.00 0.77    0
## 14 0.00   0.90      0         0 0.00        0  0.00 2.72   0.00 0.90    0
## 16 0.00   0.00      0         0 1.27        0  0.00 1.70   0.42 1.27    0
##    num000 money hp hpl george num650 lab labs telnet num857 data num415
## 1       0  0.00  0   0      0      0   0    0      0      0 0.00      0
## 7       0  0.00  0   0      0      0   0    0      0      0 0.00      0
## 9       0  0.15  0   0      0      0   0    0      0      0 0.15      0
## 12      0  0.00  0   0      0      0   0    0      0      0 0.00      0
## 14      0  0.00  0   0      0      0   0    0      0      0 0.00      0
## 16      0  0.42  0   0      0      0   0    0      0      0 0.00      0
##    num85 technology num1999 parts pm direct cs meeting original project re
## 1      0          0    0.00     0  0   0.00  0       0      0.0       0  0
## 7      0          0    0.00     0  0   0.00  0       0      0.0       0  0
## 9      0          0    0.00     0  0   0.00  0       0      0.3       0  0
## 12     0          0    0.00     0  0   0.00  0       0      0.0       0  0
## 14     0          0    0.00     0  0   0.00  0       0      0.0       0  0
## 16     0          0    1.27     0  0   0.42  0       0      0.0       0  0
##    edu table conference charSemicolon charRoundbracket charSquarebracket
## 1    0     0          0         0.000            0.000                 0
## 7    0     0          0         0.000            0.054                 0
## 9    0     0          0         0.000            0.271                 0
## 12   0     0          0         0.022            0.044                 0
## 14   0     0          0         0.000            0.000                 0
## 16   0     0          0         0.000            0.063                 0
##    charExclamation charDollar charHash capitalAve capitalLong capitalTotal
## 1            0.778      0.000    0.000      3.756          61          278
## 7            0.164      0.054    0.000      1.671           4          112
## 9            0.181      0.203    0.022      9.744         445         1257
## 12           0.663      0.000    0.000      1.243          11          184
## 14           0.000      0.000    0.000      2.083           7           25
## 16           0.572      0.063    0.000      5.659          55          249
##    type
## 1  spam
## 7  spam
## 9  spam
## 12 spam
## 14 spam
## 16 spam
```


---

### Summaries

```r
table(trainSpam$type)
```

```
## 
## nonspam    spam 
##    1381     906
```


---

### Plots

```r
plot(trainSpam$capitalAve ~ trainSpam$type)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


---

### Plots 

```r
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


---

### Relationships between predictors

```r
plot(log10(trainSpam[, 1:4] + 1))
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


---

### Clustering




```r
hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


---
### New clustering

```r
hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


---
### Statistical prediction/modeling

* Should be informed by the results of your exploratory analysis
* Exact methods depend on the question of interest
* Transformations/processing should be accounted for when necessary
* Measures of uncertainty should be reported

---
### Statistical prediction/modeling
Logistic regression; prediction modelling, binomial etc...

```r
trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
    lmFormula = reformulate(names(trainSpam)[i], response = "numType")
    glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
    cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

## Which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]
```

```
## [1] "charDollar"
```

The explanation goes as follows. It took me about 2-3 hrs to wrap the
whole thing around my head but here goes my explanation.

**Goal**: Find a "simple model" ~~(binomial regression)~~ that has least
"error" ~~(cross validated error)~~, when we use the "simple model" to predict.


**Dataset** We only use the `trainSpam` data set to make the
predictive model. Each cell has the numerical value representing the
occurrence of a word (given by column) for a given e-mail (row). For
example, row 2 of the `charDollar` column has a of 0.054. This means
that 2nd mail has 0.054 `$` symbols in the mail.

The data is binomial in nature, i.e., 0 for non-Spam and 1 for
Spam. This is made numerical with:

	trainSpam$numType = as.numeric(trainSpam$type)-1
	
**Binomial regression** As the data is binomial, we fit a curve,
~~Binomial Regression~~ that predicts probability for a mail being
spam depending on the Value .  For example, look at column `charDollar`,

	png(filename="glm.png")
	lmFormula=numType~charDollar
	plot(lmFormula,data=trainSpam, ylab="probability")
	g=glm(lmFormula,family=binomial, data=trainSpam)
	curve(predict(g,data.frame(charDollar=x),type="resp"),add=TRUE)
	dev.off()

[![GLM][1]][1]

[1]: https://i.stack.imgur.com/Y8qyz.png
  
Here you see that for charDollar values > 0.5 there is almost a 100%
probability that it is SPAM. This is how binomial regression is used.

The author looks at every column, makes a binomial regression
fit. This is done with the `for loop`. So the author now has 55 models.

**Error Estimation**
The author wants to see which of these 55 models is predicting the
"BEST". For this we use Cross validation...

**cv.glm or CrossValidation**

The crossvalidation works as follows: It divides the trainData further
into TRAIN and TEST. The TRAIN data is used to compute the glm, and
this glm is used to predict the outcome of the TEST data. This is done
"[in a particular way](https://www.youtube.com/watch?v=fSytzGwwBVw)" many times and the results are averaged. 

The CV uses a cost-function to calculate the error.

The `cost function` (in this case) counts number of failed
predictions. The TEST data is used for this.  It takes two parameters
which is X (observed TEST data) and Y (Predicted data based on glm)
and checks how many times it failed in this case:

	costFunction = function(x,y) sum(x!=(y > 0.5))
	
`Y>0.5` provides a cutoff to decide if a value is spam or not. So if
the predicted value is `0.6` then the prediction is SPAM (or 1). If
the predicted value is `<=0.5` then it is NOT SPAM (or 0).

With the for loop we cycle over every single column and in the end pic
the column which has the least error of predictions:

	which.min(cvError)

**P.S** It is very beneficial to look at how the [glm binomial fitting
(including timestamp)](https://www.youtube.com/watch?v=yIYKR4sgzI8&t=458s) is done, and the explanation of the
[coefficients that come from `glm`](https://www.youtube.com/watch?v=vN5cNN2-HWE&t=304s) and what it means to obtain
[cross-validated error](https://www.youtube.com/watch?v=fSytzGwwBVw). The course, I agree however made a steep
jump in this aspect, without bothering to explain anything related to
this, what so ever. Hope this is helpful.

[Question and my answer on stack as well](https://stackoverflow.com/questions/48602066/log-regression-code-explanation-from-courseras-reproducible-research-class/54884544#54884544)

---

### Get a measure of uncertainty

```r
## Use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

## Get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])

## Classify as `spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"
```


---

### Get a measure of uncertainty


```r
## Classification table
table(predictedSpam, testSpam$type)
```

```
##              
## predictedSpam nonspam spam
##       nonspam    1346  458
##       spam         61  449
```

```r

## Error rate
(61 + 458)/(1346 + 458 + 61 + 449)
```

```
## [1] 0.2243
```


---

### Interpret results

* Use the appropriate language
  * describes 
  * correlates with/associated with
  * leads to/causes
  * predicts
* Give an explanation
* Interpret coefficients
* Interpret measures of uncertainty

---

### Our example

* The fraction of charcters that are dollar signs can be used to predict if an email is Spam
* Anything with more than 6.6% dollar signs is classified as Spam
* More dollar signs always means more Spam under our prediction
* Our test set error rate was 22.4% 

---

### Challenge results

* Challenge all steps:
  * Question
  * Data source
  * Processing 
  * Analysis 
  * Conclusions
* Challenge measures of uncertainty
* Challenge choices of terms to include in models
* Think of potential alternative analyses 

---

### Synthesize/write-up results

* Lead with the question
* Summarize the analyses into the story 
* Don't include every analysis, include it
  * If it is needed for the story
  * If it is needed to address a challenge
* Order analyses according to the story, rather than chronologically
* Include "pretty" figures that contribute to the story 

---

### In our example

* Lead with the question
  * Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?
* Describe the approach
  * Collected data from UCI -> created training/test sets
  * Explored relationships
  * Choose logistic model on training set by cross validation
  * Applied to test, 78% test set accuracy
* Interpret results
  * Number of dollar signs seems reasonable, e.g. "Make money with Viagra \\$ \\$ \\$ \\$!"
* Challenge results
  * 78% isn't that great
  * I could use more variables
  * Why logistic regression?


---


## Organizing Data Analysis (c5)
### Data analysis files

* Data
  * Raw data
  * Processed data
* Figures
  * Exploratory figures
  * Final figures
* R code
  * Raw / unused scripts
  * Final scripts
  * R Markdown files
* Text
  * README files
  * Text of analysis / report


---

### Raw Data

<img class=center src=../../assets/img/medicalrecord.png height='400'/>

* Should be stored in your analysis folder
* If accessed from the web, include url, description, and date accessed in README

---

### Processed data

<img class=center src=../../assets/img/excel.png height='400'/>
* Processed data should be named so it is easy to see which script generated the data. 
* The processing script - processed data mapping should occur in the README
* Processed data should be [tidy](http://vita.had.co.nz/papers/tidy-data.pdf)

---

### Exploratory figures

<img class=center src=../../assets/img/example10.png height='400'/>

* Figures made during the course of your analysis, not necessarily part of your final report.
* They do not need to be "pretty"

---

### Final Figures

<img class=center src=../../assets/img/figure1final.png height='400'/>

* Usually a small subset of the original figures
* Axes/colors set to make the figure clear
* Possibly multiple panels

---

### Raw scripts

<img class=center src=../../assets/img/rawcode.png height='350'/>

* May be less commented (but comments help you!)
* May be multiple versions
* May include analyses that are later discarded

---

### Final scripts

<img class=center src=../../assets/img/finalscript2.png height='300'/>

* Clearly commented
  * Small comments liberally - what, when, why, how
  * Bigger commented blocks for whole sections
* Include processing details
* Only analyses that appear in the final write-up

---

### R markdown files

<img class=center src=../../assets/img/rmd.png height='400'/>

* [R markdown](http://www.rstudio.com/ide/docs/authoring/using_markdown) files can be used to generate reproducible reports
* Text and R code are integrated
* Very easy to create in [Rstudio](http://www.rstudio.com/)

---

### Readme files

<img class=center src=../../assets/img/readme.png height='400'/>

* Not necessary if you use R markdown
* Should contain step-by-step instructions for analysis
* Here is an example [https://github.com/jtleek/swfdr/blob/master/README](https://github.com/jtleek/swfdr/blob/master/README)

---

### Text of the document

<img class=center src=../../assets/img/swfdr.png height='350'/>

* It should include a title, introduction (motivation), methods (statistics you used), results (including measures of uncertainty), and conclusions (including potential problems)
* It should tell a story
* _It should not include every analysis you performed_
* References should be included for statistical methods

---

### Further resources

* Information about a non-reproducible study that led to cancer patients being mistreated: [The Duke Saga Starter Set](http://simplystatistics.org/2012/02/27/the-duke-saga-starter-set/)
* [Reproducible research and Biostatistics](http://biostatistics.oxfordjournals.org/content/10/3/405.full)
* [Managing a statistical analysis project guidelines and best practices](http://www.r-statistics.com/2010/09/managing-a-statistical-analysis-project-guidelines-and-best-practices/)
* [Project template](http://projecttemplate.net/) - a pre-organized set of files for data analysis


## Markdown R knitr (c5)

### What is Markdown?

* Created by [John Gruber](http://daringfireball.net) and Aaron Swartz

* A simplified version of "markup" languages

* Allows one to focus on writing as opposed to formatting

* Simple/minimal intuitive formatting elements

* Easily converted to valid HTML (and other formats) using existing tools

* Complete information is available at [http://daringfireball.net/projects/markdown/](http://daringfireball.net/projects/markdown/)

* Some background information at [http://daringfireball.net/2004/03/dive_into_markdown](http://daringfireball.net/2004/03/dive_into_markdown)

---

### What is R Markdown?

* R markdown is the integration of R code with markdown 

* Allows one to create documents containing "live" R code

* R code is evaluated as part of the processing of the markdown

* Results from R code are inserted into markdown document 

* A core tool in <b>literate statistical programming</b>

---

### What is R Markdown?

* R markdown can be converted to standard markdown using the
  [knitr](http://yihui.name/knitr/) package in R

* Markdown can be converted to HTML using the [markdown](https://github.com/rstudio/markdown) package in R

* Any basic text editor can be used to create a markdown document; no
  special editing tools needed

* The R markdown --> markdown --> HTML work flow can be easily managed
  using [R Studio](http://rstudio.org) (but not required)

* These slides were written in R markdown and converted to slides
  using the [slidify](http://slidify.org) package
### Literate programming pros and cons

- Text and code all in one place, logical order
-  Data, results automatically updated to reflect external changes
- Code is live--automatic “regression test” when building a document

- Text and code all in one place; can make documents difficult to read,
especially if there is a lot of code 
- Can substantially slow down
processing of documents (although there are tools to help)

### Knitr USAGE and syntax

An R package written by Yihui Xie (while he was a grad student at Iowa State)
Available on CRAN
Supports RMarkdown, LaTeX, and HTML as documentation languages
Can export to PDF, HTML
Built right into RStudio for your convenience

**Usage**

```R
library(knitr)
setwd(<working directory>)
knit2html(“document.Rmd”)
browseURL(“document.html”)

```

Knitr adds both code and the output, is useful for documentation.

```Rmd
\```{r firstchunk}
## R code goes here
\```
```

.Rmd --> .md --> .html

Hiding results!

```Rmd
\```{r firstchunk, echo=FALSE,results="hide"}
## R code goes here
time-> bla bla
rand-> rnorm(1)
\```
The current time is `r time`. My favourite random number is `r rand`.
```

Plotting and controlling figure height

```Rmd
\```{r ploting, fig.height=4}
plot(x,y) bla bla bla
\```

```

Making tables with xtable

```Rmd
\```{r tablespandian, results="asis"}
library(xtable)
xt<- xtable(summary(fit))
print(xt,type="html")

\```
```

Setting options to on a global level

```RMD
\```{r settingblablaoptions, echo=FALSE}
knitr::opts_chunk$set(echo=FALSE, results="hide")
\```
```
https://yihui.name/knitr/options/


**Options common**

**Output**

results: “asis”, “hide”
echo: TRUE, FALSE
message: FALSE
warning=FALSE

https://yihui.name/knitr/demo/output/ More info by author.

"Error" reported here: https://github.com/yihui/knitr/issues/220
**Figures**

fig.height: numeric
fig.width: numeric

**Caching**

What if one chunk takes a long time to run?  All chunks have to be
re-computed every time you re-knit the file The `cache=TRUE` option can
be set on a chunk-by-chunk basis to store results of computation After
the first run, results are loaded from cache

Useful help document from stack:
https://stackoverflow.com/a/51409622/5986651

**YAML Front Matter example**


---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: yes
---


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, message=F, warning=F, cache=T)
```

More info in [Yihui's book](https://bookdown.org/yihui/rmarkdown/pdf-document.html) and his blog.

### Knitr for pdf; plots not working!

https://stackoverflow.com/questions/55032228/package-pdftex-def-error-file-not-found

Made a stack question that says it doesn't work.

however I stumbled upon something by accident: 

`rmarkdown::render("./code.rmd")` in the console seems to work on
plots. I just used this for now and finished the assignement. A lot of
issues here, appears to be not within EMACS!

### Making an Rmd document work with ESS init.el

https://stackoverflow.com/a/23326318/5986651 shows how to add the
basics and setup rmd mode

polymode keybindings are given here https://polymode.github.io/usage/

Also the library `rmarkdown` seems to be needed along with pandoc!

So install pandoc with 

	sudo apt-get install pandoc 
	
Got lot of sql errors but ignored it for now! and the system generates
an html nicely with `M-n e`.

Done! Peace!

Also for adding the code chunk you need to follow instructions given
here: https://emacs.stackexchange.com/a/27419/17941

	(defun tws-insert-r-chunk (header) 
	"Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
	(interactive "sHeader: ") 
	(insert (concat "```{r " header "}\n\n```")) 
	(forward-line -1))

	M-x tws-insert-r-chunk

Emacs init file attempts and failures for keybinding!

	;; (eval-after-load 'rmd-mode
	;;   '(define-key rmd-mode-map (kbd "C-c r")
	;;      'tws-insert-r-chunk)) 

	(global-set-key (kbd "C-c r") 'tws-insert-r-chunk) 
## Levels of detail (c5-w3)
### tl;dr

* People are busy, especially managers and leaders

* Results of data analyses are sometimes presented in oral form, but
  often the first cut is presented via email

* It is often useful to breakdown the results of an analysis into
  different levels of granularity / detail

* Getting responses from busy people: [http://goo.gl/sJDb9V](http://goo.gl/sJDb9V)

---

### Hierarchy of Information: Research Paper

* Title / Author list

* Abstract

* Body / Results

* Supplementary Materials / the gory details

* Code / Data / really gory details

---

### Hierarchy of Information: Email Presentation

* Subject line / Sender info

  - At a minimum; include one
  - Can you summarize findings in one sentence?

* Email body 

  - A brief description of the problem / context; recall what was
    proposed and executed; summarize findings / results; 1&ndash;2
    paragraphs

  - If action needs to be taken as a result of this presentation,
    suggest some options and make them as concrete as possible.

  - If questions need to be addressed, try ot make them yes / no

---

### Hierarchy of Information: Email Presentation

* Attachment(s)

  - R Markdown file 
  - knitr report 

  - Stay concise; don't spit out pages of code (because you
    used knitr we know it's available)

* Links to Supplementary Materials

  - Code / Software / Data
  - GitHub repository / Project web site
  
## Caching computations

Not sure where to use it. the library is called `cacher`

