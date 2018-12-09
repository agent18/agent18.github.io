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

## Using R basics

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

	`plyr`, `Hmisc`, `reshape`,`jpeg`, `stringr`, `lubridate`, `quantmod`
	
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

### NA's are ignored using `which`

```r
X[which(X$var2 > 8),]
```

```
  var1 var2 var3
4    1   10   11
5    4    9   13
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


## Dates

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
