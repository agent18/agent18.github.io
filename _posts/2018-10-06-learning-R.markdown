---
layout: post
comments: true
title:  "Learning R"
date:    06-10-2018 
categories: notes
ntags: R, learn
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

## Course4: Exploratory data Analysis


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
**When you have a histogram and 2 vlines, how to add legend**

https://stackoverflow.com/questions/37660694/add-legend-to-geom-vline

``` R
quantile_1 <- quantile(sf$Unit.Sales, prob = 0.25)
quantile_2 <- quantile(sf$Unit.Sales, prob = 0.75)

ggplot(aes(x = Unit.Sales), data = sf) + 
  geom_histogram(color = 'black', fill = NA) + 
  geom_vline(aes(xintercept=median(Unit.Sales)),
            color="blue", linetype="dashed", size=1) + 
  geom_vline(aes(xintercept=mean(Unit.Sales)),
            color="red", linetype="dashed", size=1) +
  geom_vline(aes(xintercept=quantile_1), color="yellow", linetype="dashed", size=1)
```


### ggplot histogram

http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)

	g <- ggplot(data.frame(mn.mat),aes(x=mn.mat))
	
```r
g <- ggplot(data.frame(mn.mat),aes(x=mn.mat))

## hist and plots

g+geom_histogram(aes(y=..density..,fill="Distribution"),binwidth=0.5,color="black") +
    scale_fill_manual("Histogram Legend", values=c("white")) +
    geom_vline(aes(xintercept=mn.sample,color="Sample.mean"),linetype="dashed",size=0.5)+
    geom_vline(aes(xintercept=mean(mn.mat),color="Mean.of.distribution"),linetype="dashed",size=1)+
    scale_color_manual(name = "vLine legend", values = c( Sample.mean= "blue", Mean.of.distribution = "red"))+
    ggtitle("Sampling distribution of Sample Mean") +xlab("Sample Mean, n=40") + ylab("density")
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

### Caching and the way to go

> It seems the default is set to FALSE and local chunk options
> override the global options but one thing **you could do is set the
> global options to cache by default by adding this to the top of your
> document**

    `r opts_chunk$set(cache=TRUE)`

> Then for the sections you don't want cached ever you would
> explicitly set those sections to cache=FALSE.
>
> Then if you want to set the whole document to not cache anything you
> could change the global option to FALSE and rerun it.
>
> The problem is that if any of the chunk options are set to
> cache=TRUE then those will override the global setting and won't be
> rerun if you set the global option to FALSE.  So I think the only
> way to achieve what you want is to change the default to cache=TRUE,
> explicitly set chunks that you don't want cached to have
> cache=FALSE, and then you can switch the global option to FALSE to
> do what you want when the time occurs.

Source: https://stackoverflow.com/a/10628731/5986651

### template Knitr doc and my workflow

-----------
 
	---
	title: "Effects of Storm Events on People and Economy"
    output: html
    ---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, message=F, warning=F, cache=T)
```
Keep the cache at true in the main settings so that you can toggle
when needed to do a full evaluation. 

You use include=FALSE to have the chunk evaluated, but neither the
code nor its output displayed.

And, echo=FALSE indicates that the code will not be shown in the final
document (though any results/output would still be displayed).

[Source](https://kbroman.org/knitr_knutshell/pages/Rmarkdown.html).


`C-c r`  gives the r code section based on my init file!

```{r }
a <- 2
```

```{r libraries, include=F}
library(dplyr) #library that aids in grouping (mainly %>%)
```

```{r scatterplot, fig.width=8, fig.height=6}
plot(x,y)
```


--------------

Use `M-n e` for executing. PDF images don't work with this command but
html works well! Use `rmarkdown::render("./code.rmd")` in the console
and it works well. Recently that has been failing as well. So do the
html rendering and then in the end wrap it up with rstudio's console!


	
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

## SI: probability (c6-w1)

Statistical inference

**Course Content** The course is taught via 13 lectures

Introduction
Probability
Conditional Probability
Expectations
Variance
Common Distributions
Asymptotics
T confidence intervals
Hypothesis testing
P-values
Power
Multiple Testing
Resampling

https://www.youtube.com/playlist?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ

- In these slides we will cover the basics of probability at low enough level
to have a basic understanding for the rest of the series
- For a more complete treatment see the class Mathematical Biostatistics Boot Camp 1
    - Youtube: www.youtube.com/playlist?list=PLpl-gQkQivXhk6qSyiNj51qamjAtZISJ-
    - Coursera: www.coursera.org/course/biostats
    - Git: http://github.com/bcaffo/Caffo-Coursera

## Probability c6-w1
### Rules probability must follow

An event A occurs; A die is rolled and we get the outcome from the set
{1,2,3,4,5,6}.
- P(nothing occurs) = 0; When a die rolls the probability that we
  don't see 1,2,3,4,5,6 is 0.
- P(something occurs) = 1; 
- P(A) + P(1-A) = 1
- P(AUB)= P(A) + P(B) ; if they are mutually exclusive

You roll a die. A={1,2}, B= {3,4}. P(A)=2/6; P(B)=2/6; P(1 or 2 or 3
or 4)=P(A∪B)=P4/6.

- P(AUB) = P(A) + P(B) - P(A∩B)

Example: A={1,2,3}; B={1,5,6} 

- if {A} => {B}; P(A) < P(B)

A={1,2}; B={1,2,3,4}

---

### Example

The National Sleep Foundation ([www.sleepfoundation.org](http://www.sleepfoundation.org/)) reports
that around 3% of the American population has sleep apnea. They also
report that around 10% of the North American and European population
has restless leg syndrome. Does this imply that 13% of people will
have at least one sleep problems of these sorts?

Assuming all of this are probabilities from the same population, i.e.,
P(sleep apnea in America) represents the population, as much as
P(RLS in North America).

A person can have SA and/or RLS. Both are not mutually exclusive. So 

P(SA)= 0.03; P(RLS)= 0.1; P(atleast SA or RLS)=P(SA)+P(RLS)-P(SA∩RLS)
Answer: No, the events can simultaneously occur and so 
are not mutually exclusive. To elaborate let:

### Random variables

- A **random variable** is a numerical outcome of an experiment.

Roll a die and the outcome is say X (random variable), and this is either 1 or,2,3,4,5,6.

- The random variables that we study will come in two varieties,
  **discrete** or **continuous**.
- Discrete random variable are random variables that take on only a
countable number of possibilities and we talk about the probability that they
take specific values
- Continuous random variable can conceptually take any value on the real line or some subset of the real line and we talk about the probability that they line within
some range

---

### Examples of variables that can be thought of as random variables

Experiments that we use for intuition and building context
- The $(0-1)$ outcome of the flip of a coin
- The outcome from the roll of a die

Specific instances of treating variables as if random
- The web site traffic on a given day
- The BMI of a subject four years after a baseline measurement
- The hypertension status of a subject randomly drawn from a population
- The number of people who click on an ad 
- Intelligence quotients for a sample of children

---

### PMF and PDF


PMF is for discrete random variables and PDF (probability density function) is for continuous random
variables.

Probability Mass Function example:

$$

PMF(x)=(1/2)ˣ (1/2)^(1-x); for x = {0,1}
PMF2(x)=(θ)ˣ (1-θ)^(1-x);
$$

PMF(x) is a probability of a coin flip. This function gives value of
0.5 when x the random variable takes 0 or
1 . With PMF2 we see a die which is biased.

∑PMF(xᵢ)=1;

PDF is for continuous variable. Example: Suppose that the proportion
of help calls that get addressed in a random day by a help line is
given by $$ f(x) = \left{\begin{array}{ll} 2 x & \mbox{ for }& 0< x <
1 \ 0 & \mbox{ otherwise} \end{array} \right. $$

Is this a mathematically valid density?

$$
PDF(x)=2x for 0<x<1
$$

```r
x <- c(-0.5, 0, 1, 1, 1.5)
y <- c(0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
```

### Example continued

What is the probability that 75% or fewer of calls get addressed?

<img src="assets/fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />


---

```r
1.5 * 0.75/2
```

```
## [1] 0.5625
```

```r
pbeta(0.75, 2, 1)
```

```
## [1] 0.5625
```

### CDF and survival function
#### Certain areas are so useful, we give them names

- The **cumulative distribution function** (CDF) of a random variable, $X$, returns the probability that the random variable is less than or equal to the value $x$
$$
F(x) = P(X \leq x)
$$
(This definition applies regardless of whether $X$ is discrete or continuous.)
- The **survival function** of a random variable $X$ is defined as the probability
that the random variable is greater than the value $x$
$$
S(x) = P(X > x)
$$
- Notice that $S(x) = 1 - F(x)$

---

### Example

What are the survival function and CDF from the density considered before?

For $1 \geq x \geq 0$
$$
F(x) = P(X \leq x) = \frac{1}{2} Base \times Height = \frac{1}{2} (x) \times (2 x) = x^2
$$

$$
S(x) = 1 - x^2
$$


```r
pbeta(c(0.4, 0.5, 0.6), 2, 1)
```

```
## [1] 0.16 0.25 0.36
```

---

### Percentiles

You've heard of sample quantiles. If you were the 95th percentile on an exam, you know
that 95% of people scored worse than you and 5% scored better. 
These are sample quantities. Here we define their population analogs.

Arrange grades in increasing order. If there were 100 people you are 95th.

---
### Definition

The  $\alpha^{th}$ **quantile** of a distribution with distribution function $F$ is the point $x_\alpha$ so that
$$
F(x_\alpha) = \alpha
$$
- A **percentile** is simply a quantile with $\alpha$ expressed as a percent
- The **median** is the $50^{th}$ percentile

---
### For example

The $95^{th}$ percentile of a distribution is the point so that:
- the probability that a random variable drawn from the population is less is 95%
- the probability that a random variable drawn from the population is more is 5%

---
### Example

Consider a PDF for scores for 10000 people. The 0.5th quantile is
F(score<=some_score)=0.5. F
(score<=some_score) is the area under the
curve or the CDF(distribution function.x
What is the median of the distribution that we were working with before?
- We want to solve $0.5 = F(x) = x^2$
- Resulting in the solution 

```r
sqrt(0.5)
```

```
## [1] 0.7071
```

- Therefore, about 0.7071 of calls being answered on a random day is the median.

---
### Example continued
R can approximate quantiles for you for common distributions


```r
qbeta(0.5, 2, 1)
```

```
## [1] 0.7071
```


---

### Summary

- You might be wondering at this point "I've heard of a median before, it didn't require integration. Where's the data?"
- We're referring to are **population quantities**. Therefore, the median being
  discussed is the **population median**.
- A probability model connects the data to the population using assumptions.
- Therefore the median we're discussing is the **estimand**, the sample median will be the **estimator**


	
## SI: Conditional probability c6-w1

### Conditional probability, motivation

- The probability of getting a one when rolling a (standard) die
  is usually assumed to be one sixth
- Suppose you were given the extra information that the die roll
  was an odd number (hence 1, 3 or 5)
- *conditional on this new information*, the probability of a
  one is now one third

---

### Conditional probability, definition

| implies given condition! Roll a die. 

- Consider our die roll example
- $B = \{1, 3, 5\}$
- $A = \{1\}$

- P(A|B)=P(A∩B)/P(B). Draw venn diagram you will understand.

= 1/3= 1/6 ÷ 3/6 = 1/3.

---

### Bayes' rule
Baye's rule allows us to reverse the conditioning set provided
that we know some marginal probabilities
$$
P(B ~|~ A) = \frac{P(A ~|~ B) P(B)}{P(A ~|~ B) P(B) + P(A ~|~ B^c)P(B^c)}.
$$
  

---

### Diagnostic tests

- Let $+$ and $-$ be the events that the result of a diagnostic test is positive or negative respectively
- Let $D$ and $D^c$ be the event that the subject of the test has or does not have the disease respectively 
- The **sensitivity** is the probability that the test is positive given that the subject actually has the disease, $P(+ ~|~ D)$
- The **specificity** is the probability that the test is negative given that the subject does not have the disease, $P(- ~|~ D^c)$

- The **positive predictive value** is the probability that the subject has the  disease given that the test is positive, $P(D ~|~ +)$
- The **negative predictive value** is the probability that the subject does not have the disease given that the test is negative, $P(D^c ~|~ -)$
- The **prevalence of the disease** is the marginal probability of disease, $P(D)$

- The **diagnostic likelihood ratio of a positive test**, labeled $DLR_+$, is $P(+ ~|~ D) / P(+ ~|~ D^c)$, which is the $$sensitivity / (1 - specificity)$$
- The **diagnostic likelihood ratio of a negative test**, labeled $DLR_-$, is $P(- ~|~ D) / P(- ~|~ D^c)$, which is the $$(1 - sensitivity) / specificity$$

---

### Example

- A study comparing the efficacy of HIV tests, reports on an
  experiment which concluded that HIV antibody tests have a
  sensitivity of 99.7% and a specificity of 98.5%
- Suppose that a subject, from a population with a .1% prevalence of
  HIV, receives a positive test result. What is the positive
  predictive value?
- Mathematically, we want $P(D ~|~ +)$ given the sensitivity, $P(+ ~|~
  D) = .997$, the specificity, $P(- ~|~ D^c) =.985$, and the
  prevalence $P(D) = .001$

---

### Using Bayes' formula

- In this population a positive test result only suggests a 6%
  probability that the subject has the disease
- (The positive predictive value is 6% for this test) This is super
  low owing to the prevalence!

- The low positive predictive value is due to low prevalence of
  disease and the somewhat modest specificity
- Suppose it was known that the subject was an intravenous drug user
  and routinely had intercourse with an HIV infected partner
- Notice that the evidence implied by a positive test result does not
  change because of the prevalence of disease in the subject's
  population, only our interpretation of that evidence changes


### Likelihood ratios

- Therefore
$$\
frac{P(D ~|~ +)}{P(D^c ~|~ +)} = \frac{P(+~|~D)}{P(+~|~D^c)}\times \frac{P(D)}{P(D^c)}
$$

i.e.,

$$
\mbox{post-test odds of }D = DLR_+\times\mbox{pre-test odds of }D
$$

- odds is when you do P(X)÷P(1-X)

- Post odds = likelihood * prior odds.

- Similarly, $DLR_-$ relates the decrease in the odds of the
  disease after a negative test result to the odds of disease prior to
  the test.

---

### HIV example revisited

- Suppose a subject has a positive HIV test
- $DLR_+ = .997 / (1 - .985) \approx 66$
- The result of the positive test is that the odds of disease is now 66 times the pretest odds
- Or, equivalently, the hypothesis of disease is 66 times more supported by the data than the hypothesis of no disease

---

### HIV example revisited

- Suppose that a subject has a negative test result 
- $DLR_- = (1 - .997) / .985  \approx .003$
- Therefore, the post-test odds of disease is now $.3\%$ of the pretest odds given the negative test.
- Or, the hypothesis of disease is supported $.003$ times that of the hypothesis of absence of disease given the negative test result

---

### Independence

- Two events $A$ and $B$ are **independent** if $$P(A \cap B) =
  P(A)P(B)$$;
  
  Two successive coin flips. 
  
- Equivalently if $P(A ~|~ B) = P(A)$ 
- Two random variables, $X$ and $Y$ are independent if for any two
  sets $A$ and $B$ P(A∩B)=P(A)*P(B)
- Two coin flips both having heads is 0.5*0.5
- If $A$ is independent of $B$ then 
  - $A^c$ is independent of $B$ 
  - $A$ is independent of $B^c$
  - $A^c$ is independent of $B^c$

### Example (star mark example)

- Volume 309 of Science reports on a physician who was on trial for expert testimony in a criminal trial
- Based on an estimated prevalence of sudden infant death syndrome of
  1÷8543, the physician testified that that the probability of a
  mother having two children with SIDS was
  $\left(\frac{1}{8,543}\right)^2
- The mother was convicted for murder.

WOW! Apparently A and B are not independent. The chance of A&B
happening given (|) the same mother is different. There are dependent
as fuck!

- That is, $P(A_1 \cap A_2)$ is not necessarily equal to $P(A_1)P(A_2)$
- Biological processes that have a believed genetic or familiar
  environmental component, of course, tend to be dependent within
  families
  
  
- **Relevant to this discussion, the principal mistake was to *assume*
  that the events of having SIDs within a family are independent**

- (There are many other statistical points of discussion for this case.)

---
### IID random variables (independent identically distributed)

- Random variables are said to be iid if they are independent and identically distributed
  - Independent: statistically unrelated from one and another
  - Identically distributed: all having been drawn from the same
    population distribution
	
	
Unlike the mother murder example and like a coin toss, every coin toss
is independent of the other and the probabilities are obtained from
the same distribution data (0.5).
- iid random variables are the default model for random samples
- Many of the important theories of statistics are founded on assuming that variables are iid
- Assuming a random sample and iid will be the default starting point
  of inference for this class



## SI: Expected values c6-w1

### Expected values or Mean
- Expected values are useful for characterizing a distribution
- The mean is a characterization of its center
- The variance and standard deviation are characterizations of
how spread out it is
- Our sample expected values (the sample mean and variance) will
estimate the population versions

### The population mean
- The **expected value** or **mean** of a random variable is the center of its distribution
- For discrete random variable $X$ with PMF $p(x)$, it is defined as
  follows:
  
		X*100% = ∑xᵢ*p(xᵢ); It is the center of Mass of the system 
		
- X represents the center of mass of a collection of locations and
  weights, x and p(x).


### The sample mean

- The sample mean estimates this population mean
- The center of mass of the data is the empirical mean

Why? we assume it? why? no idea! 

---

### Example

### Using manipulate
```
library(manipulate)
myHist <- function(mu){
    g <- ggplot(galton, aes(x = child))
    g <- g + geom_histogram(fill = "salmon", 
      binwidth=1, aes(y = ..density..), colour = "black")
    g <- g + geom_density(size = 2)
    g <- g + geom_vline(xintercept = mu, size = 2)
    mse <- round(mean((galton$child - mu)^2), 3)  
    g <- g + labs(title = paste('mu = ', mu, ' MSE = ', mse))
    g
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))
```

Getting an error that it needs to be run from R-studio.


---
### Example of a population mean

- Suppose a coin is flipped and $X$ is declared $0$ or $1$
  corresponding to a head or a tail, respectively, the expected value
  is at 0.5 (i.e., mean);
  
- Note, if thought about geometrically, this answer is obvious; if two
  equal weights are spaced at 0 and 1, the center of mass will be $.5$
  
### Example

- Suppose that a die is rolled and $X$ is the number face up
- What is the expected value of $X$?
    $$
    E[X] = 1 \times \frac{1}{6} + 2 \times \frac{1}{6} +
    3 \times \frac{1}{6} + 4 \times \frac{1}{6} +
    5 \times \frac{1}{6} + 6 \times \frac{1}{6} = 3.5
    $$
- Again, the geometric argument makes this answer obvious without calculation.

### What about a biased coin?

- Suppose that a random variable, $X$, is so that
$P(X=1) = p$ and $P(X=0) = (1 - p)$
- (This is a biased coin when $p\neq 0.5$)
- What is its expected value?
$$
E[X] = 0 * (1 - p) + 1 * p = p
$$

---

### Continuous random variables

- For a continuous random variable, $X$, with density, $f$, the
  expected value is again exactly the center of mass of the density

---

### Example

- Consider a density where $f(x) = 1$ for $x$ between zero and one
- (Is this a valid density?)
- Suppose that $X$ follows this density; what is its expected value?  

---

### Facts about expected values

- Recall that expected values are properties of distributions
- Note the average of random variables is itself a random variable
and its associated distribution has an expected value
- The center of this distribution is the same as that of the original distribution

- Take several values from a std. normal distribution. Plot it and you
  can draw the original PDF.
  
- Now take 10 observations and average it (likely to be closer to the
  center than one observation); Do this several times and you have
  another PDF which has the same Expected value aka mean as that of
  the PDF we began with.
  
- Average of 10 die flips taken N times and ploted gives a shape like
  a normal distribution with mean in the centre as you would have for
  N*10 die flips
  
- Average of 20 die flips will be more concentrated towards the centre
  and so on with 30 die flips. The variance will be low and the mean
  is at the same place as that of individual die flips.
---
### Summarizing what we know
- Expected values are properties of distributions
- The population mean is the center of mass of population
- The sample mean is the center of mass of the observed data
- The sample mean is an estimate of the population mean
- The sample mean is unbiased if the population mean of its
  distribution is the mean that it's trying to estimate
- The more data that goes into the sample mean, the more 
concentrated its density / mass function is around the population mean

## SI c6-w2 Variance

### The variance

- The variance of a random variable is a measure of *spread*
- If $X$ is a random variable with mean $\mu$, the variance of $X$ is defined as

$$
Var(X) = E[(X - \mu)^2] = E[X^2] - E[X]^2
$$ 

derivation for above is [here](https://www.khanacademy.org/math/statistics-probability/summarizing-quantitative-data/variance-standard-deviation-population/v/statistics-alternate-variance-formulas)

- The expected (squared) distance from the mean
- Densities with a higher variance are more spread out than densities with a lower variance
- The square root of the variance is called the **standard deviation**
- The standard deviation has the same units as $X$

---

### Example

- What's the variance from the result of a toss of a die? 

  - $E[X] = 3.5$ 
  - $E[X^2] = 1 ^ 2 \times \frac{1}{6} + 2 ^ 2 \times \frac{1}{6} + 3 ^ 2 \times \frac{1}{6} + 4 ^ 2 \times \frac{1}{6} + 5 ^ 2 \times \frac{1}{6} + 6 ^ 2 \times \frac{1}{6} = 15.17$ 

- $Var(X) = E[X^2] - E[X]^2 \approx 2.92$

---

### Example: coin toss

- What's the variance from the result of the toss of a coin with probability of heads (1) of $p$? 

  - $E[X] = 0 \times (1 - p) + 1 \times p = p$
  - $E[X^2] = E[X] = p$ 

$$Var(X) = E[X^2] - E[X]^2 = p - p^2 = p(1 - p)$$

---
### The sample variance 
- The sample variance is 
$$
S^2 = \frac{\sum_{i=1} (X_i - \bar X)^2}{n-1}
$$
(almost, but not quite, the average squared deviation from
the sample mean)
- It is also a random variable
  - It has an associate population distribution
  - Its expected value is the population variance
  - Its distribution gets more concentrated around the population variance with mroe data
- Its square root is the sample standard deviation

---
### Variances of x die rolls

Variance of sample is $S^2$

Variance of sample mean (n average) is $S^2/n$

---

### Recall the mean
- Recall that the average of random sample from a population 
is itself a random variable
- We know that this distribution is centered around the population
mean, $E[\bar X] = \mu$
- We also know what its variance is $Var(\bar X) = \sigma^2 / n$
- This is very useful, since we don't have repeat sample means 
to get its variance; now we know how it relates to
the population variance
- We call the standard deviation of a statistic a standard error

---
### To summarize
- The sample variance, $S^2$, estimates the population variance, $\sigma^2$
- The distribution of the sample variance is centered around $\sigma^2$
- The variance of the sample mean is $\sigma^2 / n$
  - Its logical estimate is $s^2 / n$
  - The logical estimate of the standard error is $S / \sqrt{n}$
- $S$, the standard deviation, talks about how variable the population is
- $S/\sqrt{n}$, the standard error, talks about how variable averages of random samples of size $n$ from the population are

---

### Simulation example: standard normal

Standard normals have variance 1; means of $n$ standard normals
have standard deviation $1/\sqrt{n}$

>A normal distribution with a mean of 0 and a standard deviation of 1
>is called a standard normal distribution. -wiki


```r
nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim * n), nosim), 1, mean))
```

```
## [1] 0.3156
```

```r
1 / sqrt(n)
```

```
## [1] 0.3162
```


---

### Simulation example: uniform distribution

https://en.wikipedia.org/wiki/Uniform_distribution_%28continuous%29

$$
f(x) = 1/(b-a) for a<=x<=b

f(x) =         for other cases
$$

https://math.stackexchange.com/a/728072/332456 for explanation of
variance = (b-a)/12.

Standard uniforms have variance $1/12$; means of 
random samples of $n$ uniforms have sd = $1/\sqrt{12 \times n}$



```r
nosim <- 1000
n <- 10
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))
```

```
## [1] 0.09017
```

```r
1 / sqrt(12 * n)
```

```
## [1] 0.09129
```


---
### Binomial distribution

- Based on [khan lecture](https://www.khanacademy.org/math/in-in-grade-12-ncert/in-in-probability-of-events/copy-of-binomial-random-variables/v/visualizing-a-binomial-distribution).

Let's say we have 5 coin tosses and we are interested in the #heads
that come about! 

X is the random variable which has the outcome of #heads

P(X=0) = 5C1 x (1/2)^0 x (1/2)^5

P(X=2) = 5C2 x (1/2)^1 x (1/2)^4


And so on. It will look like a normal distribution but it is discrete.

- Based on "[Binomial probability example"](https://www.khanacademy.org/math/in-in-grade-12-ncert/in-in-probability-of-events/copy-of-binomial-random-variables/v/probability-of-making-2-shots-in-6-attempts)


P(making basket) = 70%

P(failing) = 30% 

P(X=2 in 6 attempts) = 6C2 x (0.7)^2 x (0.3)^4 = 15 x 0.49 x 0.0081 = 6%

- Mean of binomial probability.

E(X)= n x p(success)

For example, if we shoot with 60% success (per shot), then for 10 shots
we would have made on an average = 10 x 60% = 6 baskets.

- Generalization of p of binomial distributions!

P(exactly k scores in n attempts) = nCk f^k (1-f)^(n-k)


### Simulation example: Poissons

Based on this [khan video](https://www.khanacademy.org/math/statistics-probability/random-variables-stats-library/poisson-distribution/v/poisson-process-1), we understand that Poisson is nothing
but binomial but when n -> infinity.

Also according to [stack](https://math.stackexchange.com/questions/1050184/difference-between-poisson-and-binomial-distributions),

> The difference between the two is that while both measure the number
> of certain random events (or "successes") within a certain frame,
> the Binomial is based on discrete events, while the Poisson is based
> on continuous events. That is, with a binomial distribution you have
> a certain number, $n$, of "attempts," each of which has probability
> of success $p$. With a Poisson distribution, you essentially have
> infinite attempts, with infinitesimal chance of success. That is,
> given a Binomial distribution with some $n,p$, if you let
> $n\rightarrow\infty$ and $p\rightarrow0$ in such a way that
> $np\rightarrow\lambda$, then that distribution approaches a Poisson
> distribution with parameter $\lambda$.

**Mean=Variance**= $\lambda$

**Probability is given by**

$$\Pr[X = k] = e^{-\lambda} \frac{\lambda^k}{k!}, \quad k = 0, 1, 2, \ldots.$$ 

If Var=Mean=4, & number we average upon is n = 10; then SD = sqrt(variance/n) 

```r
nosim <- 1000
n <- 10
sd(apply(matrix(rpois(nosim * n, 4), nosim), 1, mean))
```

```
## [1] 0.6219
```

```r
sqrt(4/n)
```

```
## [1] 0.6325
```

---
### Simulation example: binomial distribution

Fair coin flips have variance $0.25$; means of 
random samples of $n$ coin flips have SD = sqrt(variance/n); same as poissons!

```r
nosim <- 1000
n <- 10
sd(apply(matrix(sample(0 : 1, nosim * n, replace = TRUE),
                nosim), 1, mean))
```

```
## [1] 0.1587
```

```r
1 / (2 * sqrt(n))
```

```
## [1] 0.1581
```

---
### Data example

```r
library(UsingR); data(father.son); 
x <- father.son$sheight
n<-length(x)
```

---
### Plot of the son's heights
<img src="assets/fig/unnamed-chunk-9.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

---
### Let's interpret these numbers

```r
round(c(var(x), var(x) / n, sd(x), sd(x) / sqrt(n)),2)
```

```
## [1] 7.92 0.01 2.81 0.09
```

<img src="assets/fig/unnamed-chunk-11.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />


---

### Summarizing what we know about variances
- The sample variance estimates the population variance
- The distribution of the sample variance is centered at
what its estimating
- It gets more concentrated around the population variance with larger sample sizes
- The variance of the sample mean is the population variance
divided by $n$
  - The square root is the standard error
- It turns out that we can say a lot about the distribution of
averages from random samples, 
even though we only get one to look at in a given data set

## Common distributions c6-w2
### The Bernoulli distribution

- The **Bernoulli distribution** arises as the result of a binary outcome
- Bernoulli random variables take (only) the values 1 and 0 with probabilities of (say) $p$ and $1-p$ respectively
- The PMF for a Bernoulli random variable $X$ is $$P(X = x) =  p^x (1 - p)^{1 - x}$$
- The mean of a Bernoulli random variable is $p$ and the variance is $p(1 - p)$
- If we let $X$ be a Bernoulli random variable, it is typical to call $X=1$ as a "success" and $X=0$ as a "failure"


---

### Binomial trials

- The *binomial random variables* are obtained as the sum of iid Bernoulli trials
- In specific, let $X_1,\ldots,X_n$ be iid Bernoulli$(p)$; then $X = \sum_{i=1}^n X_i$ is a binomial random variable
- The binomial mass function is
$$
P(X = x) = 
\left(
\begin{array}{c}
  n \\ x
\end{array}
\right)
p^x(1 - p)^{n-x}
$$
for $x=0,\ldots,n$

---

### Choose

- Recall that the notation 
  $$\left(
    \begin{array}{c}
      n \\ x
    \end{array}
  \right) = \frac{n!}{x!(n-x)!}
  $$ (read "$n$ choose $x$") counts the number of ways of selecting $x$ items out of $n$
  without replacement disregarding the order of the items

$$\left(
    \begin{array}{c}
      n \\ 0
    \end{array}
  \right) =
\left(
    \begin{array}{c}
      n \\ n
    \end{array}
  \right) =  1
  $$ 

---

### Example

- Suppose a friend has $8$ children (oh my!), $7$ of which are girls and none are twins
- If each gender has an independent $50$% probability for each birth, what's the probability of getting $7$ or more girls out of $8$ births?
$$\left(
\begin{array}{c}
  8 \\ 7
\end{array}
\right) .5^{7}(1-.5)^{1}
+
\left(
\begin{array}{c}
  8 \\ 8
\end{array}
\right) .5^{8}(1-.5)^{0} \approx 0.04
$$

```r
choose(8, 7) * 0.5^8 + choose(8, 8) * 0.5^8
```

```
## [1] 0.03516
```

```r
pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)
```

```
## [1] 0.03516
```



---

### The normal distribution

- A random variable is said to follow a **normal** or **Gaussian** distribution with mean $\mu$ and variance $\sigma^2$ if the associated density is
  $$
  (2\pi \sigma^2)^{-1/2}e^{-(x - \mu)^2/2\sigma^2}
  $$
  If $X$ a RV with this density then $E[X] = \mu$ and $Var(X) = \sigma^2$
- We write $X\sim \mbox{N}(\mu, \sigma^2)$
- When $\mu = 0$ and $\sigma = 1$ the resulting distribution is called **the standard normal distribution**
- Standard normal RVs are often labeled $Z$

---
### The standard normal distribution with reference lines 
<img src="assets/fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />


---

### Facts about the normal density

If $X \sim \mbox{N}(\mu,\sigma^2)$ then 
$$Z = \frac{X -\mu}{\sigma} \sim N(0, 1)$$ 


If $Z$ is standard normal $$X = \mu + \sigma Z \sim \mbox{N}(\mu, \sigma^2)$$

---

### More facts about the normal density by ThRa



Take a normal distribution with mean 0 and standard deviation 1.

0th quantile is the middle. 1st quantile is 1 sd to the right. 2nd
quantile is 2 sd to the right.


0th quantile is 50 percentile. 2nd quantil is 97.7%. 3rd quantile is
99.8%. 

	pnorm(q) # gives distribution function value for given quantile
	qnorm(p) # gives the other way around


CDF: F(X_alpha)= area under the curve until X_alpha


1. Approximately $68\%$, $95\%$ and $99\%$  of the normal density lies
   within $1$, $2$ and $3$ standard deviations from the mean,
   respectively
	   
		>pnorm(1)-pnorm(-1)
		[1] 0.6826895
	    > pnorm(2)-pnorm(-2)
		[1] 0.9544997
		> (pnorm(3)-pnorm(-3))
		[1] 0.9973002
   
2. $-1.28$, $-1.645$, $-1.96$ and $-2.33$ are the $10^{th}$, $5^{th}$,
   $2.5^{th}$ and $1^{st}$ percentiles of the standard normal
   distribution respectively
   
		> qnorm(0.1)
		[1] -1.281552
		
3. By symmetry, $1.28$, $1.645$, $1.96$ and $2.33$ are the $90^{th}$, $95^{th}$, $97.5^{th}$ and $99^{th}$ percentiles of the standard normal distribution respectively


---

### Question

- What is the $95^{th}$ percentile of a $N(\mu, \sigma^2)$ distribution? 
  - Quick answer in R `qnorm(.95, mean = mu, sd = sd)`
- Or, because you have the standard normal quantiles memorized
and you know that 1.645 is the 95th percentile you know that the answer has to be
$$\mu + \sigma 1.645$$
- (In general $\mu + \sigma z_0$ where $z_0$ is the appropriate standard normal quantile)

---

### Question

- What is the probability that a $\mbox{N}(\mu,\sigma^2)$ RV is larger than $x$?

---
### Example

Assume that the number of daily ad clicks for a company 
is (approximately) normally distributed with a mean of 1020 and a standard
deviation of 50. What's the probability of getting
more than  1,160 clicks in a day?

---

### Example

Assume that the number of daily ad clicks for a company 
is (approximately) normally distributed with a mean of 1020 and a standard
deviation of 50. What's the probability of getting
more than  1,160 clicks in a day?

It's not very likely, 1,160 is 2.8 standard
deviations from the mean 

```r
pnorm(1160, mean = 1020, sd = 50, lower.tail = FALSE)
```

```
## [1] 0.002555
```

```r
pnorm(2.8, lower.tail = FALSE)
```

```
## [1] 0.002555
```


---

### Example

Assume that the number of daily ad clicks for a company 
is (approximately) normally distributed with a mean of 1020 and a standard
deviation of 50. What number of daily ad clicks would represent
the one where 75% of days have fewer clicks (assuming
days are independent and identically distributed)?

---

### Example

Assume that the number of daily ad clicks for a company 
is (approximately) normally distributed with a mean of 1020 and a standard
deviation of 50. What number of daily ad clicks would represent
the one where 75% of days have fewer clicks (assuming
days are independent and identically distributed)?


```r
qnorm(0.75, mean = 1020, sd = 50)
```

```
## [1] 1054
```


---
### The Poisson distribution

* Used to model counts
* The Poisson mass function is
$$
P(X = x; \lambda) = \frac{\lambda^x e^{-\lambda}}{x!}
$$
for $x=0,1,\ldots$

* **The mean of this distribution is $\lambda$**
* **The variance of this distribution is $\lambda$**
* **Notice that $x$ ranges from $0$ to $\infty$**

---
### Some uses for the Poisson distribution
* Modeling count data  
* Modeling event-time or survival data
* Modeling contingency tables
* Approximating binomials when $n$ is large and $p$ is small

---
### Rates and Poisson random variables
* Poisson random variables are used to model rates
* $X \sim Poisson(\lambda t)$ where 
  * $\lambda = E[X / t]$ is the expected count per unit of time
  * $t$ is the total monitoring time

---
### Example
The number of people that show up at a bus stop is Poisson with
a mean of $2.5$ per hour.

If watching the bus stop for 4 hours, what is the probability that $3$
or fewer people show up for the whole time?


```r
ppois(3, lambda = 2.5 * 4)
```

```
## [1] 0.01034
```


---
### Poisson approximation to the binomial
* When $n$ is large and $p$ is small the Poisson distribution
  is an accurate approximation to the binomial distribution
* Notation
  * $X \sim \mbox{Binomial}(n, p)$
  * $\lambda = n p$
  * $n$ gets large 
  * $p$ gets small


---
### Example, Poisson approximation to the binomial

We flip a coin with success probablity $0.01$ five hundred times. 

What's the probability of 2 or fewer successes?


```r
pbinom(2, size = 500, prob = 0.01)
```

```
## [1] 0.1234
```

```r
ppois(2, lambda = 500 * 0.01)
```

```
## [1] 0.1247
```

## Asymtotics
	
### Asymptotics
* Asymptotics is the term for the behavior of statistics as the sample size (or some other relevant quantity) limits to infinity (or some other relevant number)
* (Asymptopia is my name for the land of asymptotics, where everything works out well and there's no messes. The land of infinite data is nice that way.)
* Asymptotics are incredibly useful for simple statistical inference and approximations 
* (Not covered in this class) Asymptotics often lead to nice understanding of procedures
* Asymptotics generally give no assurances about finite sample performance
* Asymptotics form the basis for frequency interpretation of probabilities 
  (the long run proportion of times an event occurs)


---


### Law of large numbers in action

```r
n <- 10000
means <- cumsum(rnorm(n))/(1:n)
library(ggplot2)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g
```

---
### Law of large numbers in action, coin flip

```r
means <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0.5) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 


If we make infinite coin tosses then we get the right answer, law of
large numbers!

---

### The Central Limit Theorem

- The **Central Limit Theorem** (CLT) is one of the most important theorems in statistics
- For our purposes, the CLT states that the distribution of averages of iid variables (properly normalized) becomes that of a standard normal as the sample size increases
- The CLT applies in an endless variety of settings
- The result is that 
$$\frac{\bar X_n - \mu}{\sigma / \sqrt{n}}=
\frac{\sqrt n (\bar X_n - \mu)}{\sigma}
= \frac{\mbox{Estimate} - \mbox{Mean of estimate}}{\mbox{Std. Err. of estimate}}$$ has a distribution like that of a standard normal for large $n$.
- (Replacing the standard error by its estimated value doesn't change the CLT)
- **The useful way to think about the CLT is that $\bar X_n$ is
approximately $N(\mu, \sigma^2 / n)$**


**Basically, that when you take an iid like a coin flip, and you start
making distribution of averages out of them, it tends to normal
distribution.**



---

### Example

- Simulate a standard normal random variable by rolling $n$ (six sided)
- Let $X_i$ be the outcome for die $i$
- Then note that $\mu = E[X_i] = 3.5$
- $Var(X_i) = 2.92$ 
- SE $\sqrt{2.92 / n} = 1.71 / \sqrt{n}$
- Lets roll $n$ dice, take their mean, subtract off 3.5,
and divide by $1.71 / \sqrt{n}$ and repeat this over and over


---
### Result of our die rolling experiment

You see that for 10 rolls of a die it is still discrete, but for 30
rolls it almost makes the bell curve given by $\mu$ and the Variance!


---
### Coin CLT

 - Let $X_i$ be the $0$ or $1$ result of the $i^{th}$ flip of a possibly unfair coin


- The sample proportion, say $\hat p$, is the average of the coin flips
- $E[X_i] = p$ and $Var(X_i) = p(1-p)$
- Standard error of the mean is $\sqrt{p(1-p)/n}$
- Then
$$
    \frac{\hat p - p}{\sqrt{p(1-p)/n}}
$$
will be approximately normally distributed


- Let's flip a coin $n$ times, take the sample proportion
of heads, subtract off .5 and multiply the result by
$2 \sqrt{n}$ (divide by $1/(2 \sqrt{n})$)

---
### Simulation results
<img src="assets/fig/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


---
### Simulation results, $p = 0.9$
<img src="assets/fig/unnamed-chunk-5.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


---
### Galton's quincunx 

http://en.wikipedia.org/wiki/Bean_machine#mediaviewer/File:Quincunx_(Galton_Box)_-_Galton_1889_diagram.png

<img src="fig/quincunx.png" height="450"></img>

---

### Confidence intervals thej

This is a hard topic almost impossible to follow from the coursera
course.

**Population**  
Let's say there are 100k people and you want to find out who voted for
k. Let's assume the **True mean** (aka sample proportion) to be **p**.

**Sampling**  
But unfortunately we cannot estimate the true mean, so we take
**n=100** sample. We determine the what is the sample proportion i.e.,
54 people vote for A (success). $\cap{p}=0.54$. 

**Normal distribution**

Imagine a bell curve over different population sets of 100. So we make
**$\cap{p}_1$** and then another 100 leads to **$\cap{p}_2$** etc... We make a
plot out of it. 

Obviously **E[$\cap{p}$]** is the same as the population mean **p**
and a bell curve is formed eventually where std deviation as we have
seen earlier is $\sigma_\cap{p} = \sqrt{p(1-p)/n}$. Note it is **p**
that determines the SD of the bell!

**2 things we are interested in**

- What is the probability that any **$\cap{p}$** lies within 2sigma of the
  **True Mean p**

or conversely,

- What is the probability that the **True Mean p** lies within 2sigma
  of the **$\cap{p}$**

**Note**: Sigma can only be calculated from the true mean.

**The problem and solution**

But there is no way of knowing the true mean in advance and possibly
ever, (for example think of determining who people are going to vote
for in the country.)

So we do what is the **next "best" possible stuff!**

We try to take the **SE (standard Error)** which is obtained by using
$\cap{p}$ instead of P in the SD calculations. I.e., We draw **a** **sample**
of **n=100**, find the $\cap{p}=0.54$. Then we use this to determine
the **SE and not the SD**. 

**What does this mean? and why?**

There is a **95% probability** that **p is within 2sigma $\cap{p}$ of
$\cap{p}$**.

In the above example SE=0.05, so there is 95% probability that the
drawn sample mean is within 0.44 and 0.64.

It turns out that [SE is a decent estimation of SD](https://www.khanacademy.org/math/statistics-probability/confidence-intervals-one-sample/introduction-to-confidence-intervals/v/confidence-interval-simulation).

**There are 3 types of interval findings in this notes**

- Finding SE with **$\cap{p}$ instead of p (true mean)**, and
  computing Confidence interval

- SE for biased coin type problems with ** 2xSE=1/sqrt(n)**

	- Using Agresti interval by taking X+2 and n+4 (i.e., adding 2 more
  successes and failures!

#### Give a confidence interval for the average height of sons

in Galton's data

Here we take the same of data we have for the son's height and find
the 95% confidence intervals.

```r
library(UsingR)
data(father.son)
x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12
```

```
## [1] 5.710 5.738
```

---

### Confidence interval Walds interval

We imagine a biased coin, i.e., SD= sqrt(p(1-p));

- The interval takes the form:

$$
    \hat p \pm z_{1 - \alpha/2}  \sqrt{\frac{p(1 - p)}{n}}
$$

The maximum value p(1-p) can take is 1/2 at p=0.5.

-**For 95% intervals $$\hat p \pm \frac{1}{\sqrt{n}}$$**

This is used for quick "conservative"(maybe) estimates.

---
### Example of voters for Wald's interval

* Your campaign advisor told you that in a random sample of 100 likely voters,
  56 intent to vote for you. 
  * Can you relax? Do you have this race in the bag?
  * Without access to a computer or calculator, how precise is this estimate?
* `1/sqrt(100)=0.1` so a back of the envelope calculation gives an
  **approximate 95% interval** of `(0.46, 0.66)`
  * Not enough for you to relax, better go do more campaigning as it
    is not >50%
* Rough guidelines is that when n=100 you have one decimal place of in
  the SE and n=10000 you have 2 deimal places in the SE.

```r
round(1/sqrt(10^(1:6)), 3)
```
```
## [1] 0.316 0.100 0.032 0.010 0.003 0.001
```

---

### 2 ways of determining the confidence interval!


```r
0.56 + c(-1, 1) * qnorm(0.975) * sqrt(0.56 * 0.44/100)
```

```
## [1] 0.4627 0.6573
```

```r
binom.test(56, 100)$conf.int
```

```
## [1] 0.4572 0.6592
## attr(,"conf.level")
## [1] 0.95
```


---

### Simulation fOR n=20


```r
n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p) {
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
```

**When true mean is 0.5, then confidence interval covers the true
mean**, i.e., follows central limit theorem!! but otherwise for
**n=20** it doesn't seem to work correctly. For some cases of
**p=0.1**, the confidence interval obtained from the SE does not seem
to contain the **p**.

### Simulation for n=100

For n=100 the graph is rather spot on: For all **p**'s there is a
90-95% chance that it covers the true mean when using SE.


```r
n <- 100
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage2 <- sapply(pvals, function(p) {
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
```


---
### What's happening? Fix: Agresti/Coull interval

- **$n$ isn't "large enough" for the CLT to be applicable
for many of the values of $p$**

- Quick fix, form the interval with 
$$
\frac{X + 2}{n + 4}
$$
- (Add two successes and failures, **Agresti/Coull interval)**

**Use Agresti/Coull interval generally- Bcaffo**

### Simulation with Agresti interval for n=20
Now let's look at $n=20$ but adding 2 successes and failures

```r
n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p) {
    phats <- (rbinom(nosim, prob = p, size = n) + 2)/(n + 4)
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
```
It's a little conservative, i.e. the mean lies within >2 sigma for
sure. i.e., >95% confidence

---

### Poisson interval
* A nuclear pump failed 5 times out of 94.32 days, give a 95% confidence interval for the failure rate per day?
* $X \sim Poisson(\lambda t)$.
* Estimate $\hat \lambda = X/t$
* $Var(\hat \lambda) = \lambda / t$ 
* $\hat \lambda / t$ is our variance estimate

---
### R code

```r
x <- 5
t <- 94.32
lambda <- x/t
round(lambda + c(-1, 1) * qnorm(0.975) * sqrt(lambda/t), 3)
```

```
## [1] 0.007 0.099
```

```r
poisson.test(x, T = 94.32)$conf
```

```
## [1] 0.01721 0.12371
## attr(,"conf.level")
## [1] 0.95
```



---
### Simulating the Poisson coverage rate
Let's see how this interval performs for lambda
values near what we're estimating

```r
lambdavals <- seq(0.005, 0.1, by = 0.01)
nosim <- 1000
t <- 100
coverage <- sapply(lambdavals, function(lambda) {
    lhats <- rpois(nosim, lambda = lambda * t)/t
    ll <- lhats - qnorm(0.975) * sqrt(lhats/t)
    ul <- lhats + qnorm(0.975) * sqrt(lhats/t)
    mean(ll < lambda & ul > lambda)
})
```




---
### Covarage
(Gets really bad for small values of lambda)
<img src="assets/fig/unnamed-chunk-17.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" style="display: block; margin: auto;" />




---
### What if we increase t to 1000?
<img src="assets/fig/unnamed-chunk-18.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" style="display: block; margin: auto;" />



---
### Summary
- The LLN states that averages of iid samples 
converge to the population means that they are estimating
- The CLT states that averages are approximately normal, with
distributions
  - centered at the population mean 
  - with standard deviation equal to the standard error of the mean
  - CLT gives no guarantee that $n$ is large enough
- Taking the mean and adding and subtracting the relevant
normal quantile times the SE yields a confidence interval for the mean
  - Adding and subtracting 2 SEs works for 95% intervals
- Confidence intervals get wider as the coverage increases
(why?)
- Confidence intervals get narrower with less variability or
larger sample sizes
- The Poisson and binomial case have exact intervals that
don't require the CLT
  - But a quick fix for small sample size binomial calculations is to add 2 successes and failures
## Questions c6-w2

1. What is the variance of the distribution of the average an IID draw
   of nn observations from a population with mean μ and variance σ^2
   
   $sigma^2/n$
   
2. Suppose that diastolic blood pressures (DBPs) for men aged 35-44
   are normally distributed with a mean of 80 (mm Hg) and a standard
   deviation of 10. About what is the probability that a random 35-44
   year old has a DBP less than 70?
   
		pnorm(70, mean = 80, sd = 10)

3. Brain volume for adult women is normally distributed with a mean of
   about 1,100 cc for women with a standard deviation of 75 cc. What
   brain volume represents the 95th percentile?
   
		qnorm(0.95, mean = 1100, sd = 75)
		
4. Refer to the previous question. Brain volume for adult women is
   about 1,100 cc for women with a standard deviation of 75
   cc. Consider the sample mean of 100 random adult women from this
   population. What is the 95th percentile of the distribution of that
   sample mean?
   
		qnorm(0.95, mean = 1100, sd = 75/sqrt(100))
		
5. You flip a fair coin 5 times, about what's the probability of
   getting 4 or 5 heads?
   
		pbinom(3, size = 5, prob = 0.5, lower.tail = FALSE)
		
6. The respiratory disturbance index (RDI), a measure of sleep
   disturbance, for a specific population has a mean of 15 (sleep
   events per hour) and a standard deviation of 10. They are not
   normally distributed. Give your best estimate of the probability
   that a sample mean RDI of 100 people is between 14 and 16 events
   per hour?
   
		pnorm(16, mean = 15, sd = 1) - pnorm(14, mean = 15, sd = 1)
		
	The population needn't be normal but **distribution of sample mean** seems to be
    normally distributed.


7. Consider a standard uniform density. The mean for this density is
   .5 and the variance is 1 / 12. You sample 1,000 observations from
   this distribution and take the sample mean, what value would you
   expect it to be near?
   
   Via the LLN it should be near .5 *it seems!!!!*
   
8. The number of people showing up at a bus stop is assumed to be
   Poisson with a mean of 5 5 people per hour. You watch the bus stop
   for 3 hours. About what's the probability of viewing 10 or fewer
   people?

		ppois(10, lambda = 15)
		
	Need to give this a bit more thought! But I nailed the answer! of
    course!
	
	
	
## T confidence interval (c6-w3)
### T Confidence intervals

- In the previous, we discussed creating a confidence interval using the CLT
  - They took the form $Est \pm ZQ \times SE_{Est}$ 
  
  But according to [jbstatistics](https://youtu.be/Uv6nGIgZMVw?t=68), he says that only Z quantile
  implies using population sd. But what ever! we move on.
  
- In this lecture, we discuss some methods for **small samples**,
  notably **Gosset's $t$ distribution and $t$ confidence intervals**
  
  - They are of the form **$Est \pm TQ \times SE_{Est}$**
  
- **If you want a rule between whether to use a $t$ interval or normal
interval, just always use the $t$ interval**

---

### Gosset's $t$ distribution

If you look in this [jbstatistics video](https://youtu.be/Uv6nGIgZMVw?t=190), you see how the curve
looks for a given "degrees of Freedom". No one dares to explain what
it is though.

- Has thicker tails than the normal
- **Is indexed by a degrees of freedom; gets more like a standard
  normal as df gets larger**

- It assumes that the underlying data are iid Gaussian with the result
that $$ \frac{\bar X - \mu}{SE/\sqrt{n}} $$ follows Gosset's $t$
distribution with $n-1$ degrees of freedom

- (If we replaced $s$ by $\sigma$ the statistic would be exactly standard normal)
- Interval is $\bar X \pm t_{n-1} S/\sqrt{n}$ where $t_{n-1}$
is the relevant quantile

So what changes in essence is the lack of $\sigma$ resulting in a t
distribution whose quantile terms are not Z anymore, they are t. And
the approximation of this distribution closes to the normal when dof = infinity!

---
### Code for manipulate

Shows the normal and T plots with varying dofs!

```r
library(ggplot2)
library(manipulate)
k <- 1000
xvals <- seq(-5, 5, length = k)
myplot <- function(df) {
    d <- data.frame(y = c(dnorm(xvals), dt(xvals, df)), x = xvals, dist = factor(rep(c("Normal", 
        "T"), c(k, k))))
    g <- ggplot(d, aes(x = x, y = y))
    g <- g + geom_line(size = 2, aes(colour = dist))
    g
}
manipulate(myplot(mu), mu = slider(1, 20, step = 1))
```

---
### Easier to see

Compares the z and t quantiles
```r
pvals <- seq(0.5, 0.99, by = 0.01)
myplot2 <- function(df) {
    d <- data.frame(n = qnorm(pvals), t = qt(pvals, df), p = pvals)
    g <- ggplot(d, aes(x = n, y = t))
    g <- g + geom_abline(size = 2, col = "lightblue")
    g <- g + geom_line(size = 2, col = "black")
    g <- g + geom_vline(xintercept = qnorm(0.975))
    g <- g + geom_hline(yintercept = qt(0.975, df))
    g
}
manipulate(myplot2(df), df = slider(1, 20, step = 1))
```


---

### Note's about the $t$ interval

- The $t$ interval technically assumes that the data are iid normal,
  though it is robust to this assumption
- It works well whenever the distribution of the data is roughly
  symmetric and mound shaped
- Paired observations are often analyzed using the $t$ interval by
  taking differences
- For large degrees of freedom, $t$ quantiles become the same as
  standard normal quantiles; therefore this interval converges to the
  same interval as the CLT yielded
- For skewed distributions, the spirit of the $t$ interval assumptions
  are violated
  
  -**Also, for skewed distributions, it doesn't make a lot of sense to
  center the interval at the mean**????
  
  - In this case, consider taking logs or using a different summary
    like the median
- For highly discrete data, like binary, other intervals are available

---

### Paired data --- Sleep data

In R typing `data(sleep)` brings up the sleep data originally
analyzed in Gosset's Biometrika paper, which shows the increase in
hours for 10 patients on two soporific drugs. R treats the data as two
groups rather than paired despite the same patients using both the
drugs in succession.

---
### The data

```r
data(sleep)
head(sleep)
```

```
##   extra group ID
## 1   0.7     1  1
## 2  -1.6     1  2
## 3  -0.2     1  3
## 4  -1.2     1  4
## 5  -0.1     1  5
## 6   3.4     1  6
```

---

### Different ways of running the T.test t distribution

**97.5 is used and not 95%**

```r
g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
difference <- g2 - g1
mn <- mean(difference)
s <- sd(difference)
n <- 10
```


```r
mn + c(-1, 1) * qt(0.975, n - 1) * s/sqrt(n)
t.test(difference)
t.test(g2, g1, paired = TRUE)
t.test(extra ~ I(relevel(group, 2)), paired = TRUE, data = sleep)
```

---


### The results
(After a little formatting)

```
##        [,1] [,2]
## [1,] 0.7001 2.46
## [2,] 0.7001 2.46
## [3,] 0.7001 2.46
## [4,] 0.7001 2.46
```

---

### Unpaired data --- Independent group $t$ confidence intervals

- Suppose that we want to compare the mean blood pressure between two
  groups in a randomized trial; **those who received the treatment to those who received a placebo**
- **We cannot use the paired t test because the groups are independent and may have different sample sizes**
- We now present methods for comparing independent groups

---
### Confidence interval

- Therefore a $(1 - \alpha)\times 100\%$ confidence interval for $\mu_y - \mu_x$ is 
$$
    \bar Y - \bar X \pm t_{n_x + n_y - 2, 1 - \alpha/2}S_p\left(\frac{1}{n_x} + \frac{1}{n_y}\right)^{1/2}
$$
- The pooled variance estimator is $$S_p^2 = \{(n_x - 1) S_x^2 + (n_y - 1) S_y^2\}/(n_x + n_y - 2)$$ 
- **Remember this interval is assuming a constant variance across the
  two groups**
  
- According to the lecture, it is a reasonable assumption if we
  perform randomization, that variance is the same.
- **If there is some doubt, assume a different variance per group**,
  which we will discuss later

---

### Example : unpaired data; var is equal
#### Based on Rosner, Fundamentals of Biostatistics
(Really a very good reference book)

- Comparing SBP for 8 oral contraceptive users versus 21 controls
- $\bar X_{OC} = 132.86$ mmHg with $s_{OC} = 15.34$ mmHg
- $\bar X_{C} = 127.44$ mmHg with $s_{C} = 18.23$ mmHg
- Pooled variance estimate

```r
sp <- sqrt((7 * 15.34^2 + 20 * 18.23^2)/(8 + 21 - 2))
132.86 - 127.44 + c(-1, 1) * qt(0.975, 27) * sp * (1/8 + 1/21)^0.5
```

```
## [1] -9.521 20.361
```



---
### Mistakenly treating the sleep data as paired

```r
n1 <- length(g1)
n2 <- length(g2)
sp <- sqrt(((n1 - 1) * sd(x1)^2 + (n2 - 1) * sd(x2)^2)/(n1 + n2 - 2))
```

```
## Error: object 'x1' not found
```

```r
md <- mean(g2) - mean(g1)
semd <- sp * sqrt(1/n1 + 1/n2)
rbind(md + c(-1, 1) * qt(0.975, n1 + n2 - 2) * semd, t.test(g2, g1, paired = FALSE, 
    var.equal = TRUE)$conf, t.test(g2, g1, paired = TRUE)$conf)
```

```
##          [,1]   [,2]
## [1,] -14.8873 18.047
## [2,]  -0.2039  3.364
## [3,]   0.7001  2.460
```

---


### Var equal and Var non equal!
#### `ChickWeight` data in R


```r
library(datasets)
data(ChickWeight)
library(reshape2)
## define weight gain or loss
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")
names(wideCW)[-(1:2)] <- paste("time", names(wideCW)[-(1:2)], sep = "")
library(dplyr)
```


```r
wideCW <- mutate(wideCW, gain = time21 - time0)
```


---
### Plotting the raw data

<img src="assets/fig/unnamed-chunk-12.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

noodle plot of the data per diet

---
### Weight gain by diet
<img src="assets/fig/unnamed-chunk-13.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />

violin plot of the data per diet!

---
### Let's do a t interval

```r
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
rbind(t.test(gain ~ Diet, paired = FALSE, var.equal = TRUE, data = wideCW14)$conf, 
    t.test(gain ~ Diet, paired = FALSE, var.equal = FALSE, data = wideCW14)$conf)
```

```
##        [,1]   [,2]
## [1,] -108.1 -14.81
## [2,] -104.7 -18.30
```



---

### Finding the Unequal variances

- Under unequal variances
$$
\bar Y - \bar X \pm t_{df} \times \left(\frac{s_x^2}{n_x} + \frac{s_y^2}{n_y}\right)^{1/2}
$$
where $t_{df}$ is calculated with degrees of freedom
$$
df=    \frac{\left(S_x^2 / n_x + S_y^2/n_y\right)^2}
    {\left(\frac{S_x^2}{n_x}\right)^2 / (n_x - 1) +
      \left(\frac{S_y^2}{n_y}\right)^2 / (n_y - 1)}
$$
will be approximately a 95% interval
- This works really well
  - So when in doubt, just assume unequal variances

---

### Example

- Comparing SBP for 8 oral contraceptive users versus 21 controls
- $\bar X_{OC} = 132.86$ mmHg with $s_{OC} = 15.34$ mmHg
- $\bar X_{C} = 127.44$ mmHg with $s_{C} = 18.23$ mmHg
- $df=15.04$, $t_{15.04, .975} = 2.13$
- Interval
$$
132.86 - 127.44 \pm 2.13 \left(\frac{15.34^2}{8} + \frac{18.23^2}{21} \right)^{1/2}
= [-8.91, 19.75]
$$
- In R, `t.test(..., var.equal = FALSE)`

---
### Comparing other kinds of data
* For binomial data, there's lots of ways to compare two groups
  * Relative risk, risk difference, odds ratio.
  * Chi-squared tests, normal approximations, exact tests.
* For count data, there's also Chi-squared tests and exact tests.
* We'll leave the discussions for comparing groups of data for binary
  and count data until covering glms in the regression class.
* In addition, Mathematical Biostatistics Boot Camp 2 covers many special
  cases relevant to biostatistics.

### Summary Agents

- t intervals arise due to lack of population $\sigma$

- T intervals can be obtained from `t.test()`, no need to memorize any
  insane formulas!
  
- T intervals can be grouped (takes difference) or ungrouped
  
- T intervals also are split based on the assumption that the
  variances of the two ungrouped groups are equal or not!
  
  - Variance is assumed to be equal when the sample is randomized!!!
	What ever that is supposed to mean!
  
## Hypothesis testing c6-w3

* Hypothesis testing is concerned with making decisions using data
* A null hypothesis is specified that represents the status quo,
  usually labeled $H_0$
* The null hypothesis is assumed true and statistical evidence is required
  to reject it in favor of a research or alternative hypothesis 

---
### Example
* A respiratory disturbance index of more than $30$ events / hour, say, is 
  considered evidence of severe sleep disordered breathing (SDB).
* Suppose that in a sample of $100$ overweight subjects with other
  risk factors for sleep disordered breathing at a sleep clinic, the
  mean RDI was $32$ events / hour with a standard deviation of $10$ events / hour.
* We might want to test the hypothesis that 
  * $H_0 : \mu = 30$
  * $H_a : \mu > 30$
  * **where $\mu$ is the population mean RDI.**

- Disease : > 30 events/hr

- Overweight sample n=100

- Mu_sample = 32 events/hr

- Sigma_sample = 10 events/hr

---
### Hypothesis testing
* The alternative hypotheses are typically of the form $<$, $>$ or $\neq$
* Note that there are four possible outcomes of our statistical decision process

Truth | Decide | Result |
---|---|---|
$H_0$ | $H_0$ | Correctly accept null |
$H_0$ | $H_a$ | Type I error |
$H_a$ | $H_a$ | Correctly reject null |
$H_a$ | $H_0$ | Type II error |

---
### Discussion
* Consider a court of law; the null hypothesis is that the
  defendant is innocent
* We require a standard on the available evidence to reject the null hypothesis (convict)
* If we set a low standard, then we would increase the
  percentage of innocent people convicted (type I errors); however we
  would also increase the percentage of guilty people convicted
  (correctly rejecting the null)
* If we set a high standard, then we increase the the
  percentage of innocent people let free (correctly accepting the
  null) while we would also increase the percentage of guilty people
  let free (type II errors)

- **H0:** Defendant is innocent; Person does not have Disease

- **Ha:** Defendant is guilty; Person has Disease

- if we make **type 1 error** by having a convicting everyone 90%
  close to the murder scene, then we reject H0, i.e.,we would increase
  the percentage of innocent people convicted and we would also
  increase the percentage of guilty people convicted
  
- if we make **type 2 error**, vice versa!

**In the case of diseases**

- If we make a type 1 error, then we wrongly accuse people of having
  disease and we rightly accuse people of having disease
  
- and Vice Versa!

So we need to set some limit to minimize the type 1 error i.e.,
wrong accusation of people as having disease when they actually don't.

---

### The Rejection constant C
* Consider our sleep example again
* A reasonable strategy would reject the null hypothesis if
  $\bar X$ was larger than some constant, say $C$
* Typically, $C$ is chosen so that the probability of a Type I
  error, $\alpha$, is $.05$ (or some other relevant constant)
* $\alpha$ = Type I error rate = Probability of rejecting the null
  hypothesis when, in fact, the null hypothesis is correct
  
- So if in a random sample we have $\bar X$ to be >95th percentile

---
### Rejection based on C Example!

- Standard error of the mean $10 / \sqrt{100} = 1$

- **Under $H_0$** $\bar X \sim N(30, 1)$ 

*How we are justified in using the std deviation of 1, I am not clear!
Take this into class and identify exactly what you do not understand!*

- We want to chose $C$ so that the $P(\bar X > C; H_0)$ is 
5%
- The 95th percentile of a normal distribution is 1.645
standard deviations from the mean

- If $C = 30 + 1 \times 1.645 = 31.645$
  - Then the probability that a $N(30, 1)$ is larger
    than it is 5%
  - So the rule "Reject $H_0$ when $\bar X \geq 31.645$"
    has the property that the probability of rejection
    is 5% when $H_0$ is true (for the $\mu_0$, $\sigma$
    and $n$ given)

**- So we want to identify if H0 shall be rejected.**

**- We take a normal distribution of sample means, based on H0 and see
where the sample mean lies (within C or outside C!**

---
### Discussion
* In general we don't convert $C$ back to the original scale
* We would just reject because the Z-score; which is how many
  standard errors the sample mean is above the hypothesized mean
  $$
  \frac{32 - 30}{10 / \sqrt{100}} = 2
  $$
  is greater than $1.645$
* Or, whenever $ (\bar X - \mu_0) / (s/\sqrt{n}) > Z_{1-\alpha}$

---
### Summary 1: General rules

* The $Z$ test for $H_0:\mu = \mu_0$ versus 
  * $H_1: \mu < \mu_0$
  * $H_2: \mu \neq \mu_0$
  * $H_3: \mu > \mu_0$ 
* Test statistic $ TS = \frac{\bar{X} - \mu_0}{S / \sqrt{n}} $
* Reject the null hypothesis when 
  * $TS \leq Z_{\alpha} = -Z_{1 - \alpha}$
  * $|TS| \geq Z_{1 - \alpha / 2}$
  * $TS \geq Z_{1 - \alpha}$

---
### Failing to reject H0 and not, accepting H0!

* **We have fixed $\alpha$ to be low, so if we reject $H_0$ (either
  our model is wrong) or there is a low probability that we have made
  an error**
* **We have not fixed the probability of a type II error, $\beta$;
  therefore we tend to say ``Fail to reject $H_0$'' rather than
  accepting $H_0$**
* Statistical significance is not the same as scientific
  significance
* The region of TS values for which you reject $H_0$ is called the
  rejection region

---
### When to apply Z and when to apply T test! Agents!

From [jbStatisctics's explanation](https://youtu.be/Uv6nGIgZMVw?t=108):

- Z statistic is used when $\sigma$ is known. As a result we have a
normal distribution,

$$ Z = (\bar{X} - \mu) / (**\sigma** / sqrt(n))$$

- t statistic is used when $\sigma$ is not known. We use SE and so
  have t statistic with n-1 dofs!
  
$$ t = (\bar{X} - \mu) / (**SE**     / sqrt(n))$$  has a t
distribution with n-1 dofs!

- 95% confidence intervals are obtained by:

Z --> $$ \bar{X} +-       1.96  \sigma / sqrt(n)$$

T --> $$ \bar{X} +- qt(0.95,n-1) SE    / sqrt(n)$$



* **The $Z$ test requires the assumptions of the CLT and for $n$ to be large enough
  for it to apply**
* **If $n$ is small, then a Gossett's $T$ test is performed exactly in the same way,
  with the normal quantiles replaced by the appropriate Student's $T$ quantiles and
  $n-1$ df**
* The probability of rejecting the null hypothesis when it is false is called *power*
* Power is a used a lot to calculate sample sizes for experiments

---
### Example with n=16 and using T-statistic

- Consider our example again. Suppose that $n= 16$ (rather than
$100$)

- The statistic
$$
\frac{\bar X - 30}{s / \sqrt{16}}
$$
follows a $T$ distribution with 15 df under $H_0$

-**Under $H_0$, the probability that it is larger
that the 95th percentile of the $T$ distribution is 5%**

- **The 95th percentile of the T distribution with 15
df is 1.7531 (obtained via `qt(.95, 15)`)**

- So that our test statistic is now **$\sqrt{16}(32 - 30) / 10 = 0.8
  $** << 1.7531 (95% with 15 dofs)
  
- We now **fail to reject.**


---
### Two sided tests

**Not 95% anymore. It will become 97.5%; Just pay attention when you
encounter such a problem.**

* Suppose that we would reject the null hypothesis if in fact the  mean was too large or too small
* That is, we want to test the alternative $H_a : \mu \neq 30$
* We will reject if the test statistic, $0.8$, is either too large or too small
* Then we want the probability of rejecting under the
null to be 5%, split equally as 2.5% in the upper
tail and 2.5% in the lower tail
* Thus we reject if our test statistic is larger
than `qt(.975, 15)` or smaller than `qt(.025, 15)`
  * This is the same as saying: reject if the
  absolute value of our statistic is larger than
  `qt(0.975, 15)` = 2.1314
  * So we fail to reject the two sided test as well
  * (If you fail to reject the one sided test, you
  know that you will fail to reject the two sided)


---
### T test in R

```r
library(UsingR); data(father.son)
t.test(father.son$sheight - father.son$fheight)
```

```
> 
> 	One Sample t-test
> 
> data:  father.son$sheight - father.son$fheight
> t = 11.79, df = 1077, p-value < 2.2e-16
> alternative hypothesis: true mean is not equal to 0
> 95 percent confidence interval:
>  0.831 1.163
> sample estimates:
> mean of x 
>     0.997
```

---
### Connections with confidence intervals (Important)

* Consider testing $H_0: \mu = \mu_0$ versus $H_a: \mu \neq \mu_0$
* Take the set of all possible values for which you fail to reject $H_0$, this set is a $(1-\alpha)100\%$ confidence interval for $\mu$
* The same works in reverse; if a $(1-\alpha)100\%$ interval
  contains $\mu_0$, then we *fail  to* reject $H_0$



```r
library(UsingR); data(father.son)
t.test(father.son$sheight - father.son$fheight)
qt(0.975,length(father.son$sheight - father.son$fheight)-1)
```

```
> 
> 	One Sample t-test
> 
> data:  father.son$sheight - father.son$fheight
> t = 11.79, df = 1077, p-value < 2.2e-16
> alternative hypothesis: true mean is not equal to 0
> 95 percent confidence interval:
>  0.831 1.163
> sample estimates:
> mean of x 
>     0.997

> 1.962
```
**H0**: Mu = 0 (no difference in heights)

**H_$\alpha$** : Mu != 0 (two sided alternate hypothesis)

t statistic for 95% confidence = 1.962 for 97.5 percentile;

t statistic for mu.sample=0.99 is, 11.78 => ~100 percentile; This
implies there is a 0% chance that 11.78 will occur, which leads us to
think that the null hypothesis is BS! 

So we reject the null hypothesis that it is a normal distribution
about 0. BS!

**If the t statistic lied below the 95th t percentile, then H0 is failed
to be rejected,** [as shown here in jbstatistics video](https://youtu.be/pGv13jvnjKc?t=548).

The beauti is that we can also see if we reject the null hypothesis
with the confidence interval (0.83 and 1.16). 0 is not in the 95%
confidence interval, so, REJECT H0.


---
### Two group intervals
- First, now you know how to do two group T tests
since we already covered indepedent group T intervals
- Rejection rules are the same 
- Test $H_0 : \mu_1 = \mu_2$
- Let's just go through an example

---
### `chickWeight` data
Recall that we reformatted this data

```r
library(datasets); data(ChickWeight); library(reshape2)
##define weight gain or loss
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")
names(wideCW)[-(1 : 2)] <- paste("time", names(wideCW)[-(1 : 2)], sep = "")
library(dplyr)
wideCW <- mutate(wideCW,
  gain = time21 - time0
)
```

---
#### Unequal variance T test comparing diets 1 and 4

```r
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
t.test(gain ~ Diet, paired = FALSE, 
       var.equal = TRUE, data = wideCW14)
```

```
>  
>  	Two Sample t-test
>  
>  data:  gain by Diet
>  t = -2.725, df = 23, p-value = 0.01207
>  alternative hypothesis: true difference in means is not equal to 0
>  95 percent confidence interval:
>   -108.15  -14.81
>  sample estimates:
>  mean in group 1 mean in group 4 
>            136.2           197.7
```

We reject the null hypothesis as it falls the t statistic falls
outside the 95% confidence interval!

---
### Exact binomial test
- Recall this problem, *Suppose a friend has $8$ children, $7$ of which are girls and none are twins*
- Perform the relevant hypothesis test. $H_0 : p = 0.5$ $H_a : p > 0.5$
  - What is the relevant rejection region so that the probability of rejecting is (less than) 5%?
  
Rejection region | Type I error rate |
---|---|
[0 : 8] | 1
[1 : 8] | 0.9961
[2 : 8] | 0.9648
[3 : 8] | 0.8555
[4 : 8] | 0.6367
[5 : 8] | 0.3633
[6 : 8] | 0.1445
[7 : 8] | 0.0352
[8 : 8] | 0.0039

---
### Notes
* It's impossible to get an exact 5% level test for this case due to the discreteness of the binomial. 
  * The closest is the rejection region [7 : 8]
   * Any alpha level lower than 0.0039 is not attainable.
* For larger sample sizes, we could do a normal approximation, but you already knew this.
* Two sided test isn't obvious. 
  * Given a way to do two sided tests, we could take the set of values of $p_0$ for which we fail to reject to get an exact binomial confidence interval (called the Clopper/Pearson interval, BTW)
* For these problems, people always create a P-value (next lecture) rather than computing the rejection region.

## P-values (c6-w3) 

* Most common measure of statistical significance
* Their ubiquity, along with concern over their interpretation and use
  makes them controversial among statisticians
  * [http://warnercnr.colostate.edu/~anderson/thompson1.html](http://warnercnr.colostate.edu/~anderson/thompson1.html)
  * Also see *Statistical Evidence: A Likelihood Paradigm* by Richard Royall 
  * *Toward Evidence-Based Medical Statistics. 1: The P Value Fallacy* by Steve Goodman
  * The hilariously titled: *The Earth is Round (p < .05)* by Cohen.
* Some positive comments
  * [simply statistics](http://simplystatistics.org/2012/01/06/p-values-and-hypothesis-testing-get-a-bad-rap-but-we/)
  * [normal deviate](http://normaldeviate.wordpress.com/2013/03/14/double-misunderstandings-about-p-values/)
  * [Error statistics](http://errorstatistics.com/2013/06/14/p-values-cant-be-trusted-except-when-used-to-argue-that-p-values-cant-be-trusted/)

---


### What is a P-value? 

Not using alpha, but allowing others to choose their own alpha. 

It is the 1-CDF(test statistic value). That's all!

---
### P-values
* The P-value is the probability under the null hypothesis of
  obtaining evidence as extreme or more extreme than that obtained
* If the P-value is small, then either $H_0$ is true and we have
  observed a rare event or $H_0$ is false
*  Suppos that you get a $T$ statistic of $2.5$ for 15 df testing
$H_0:\mu = \mu_0$ versus $H_a : \mu > \mu_0$.
  * What's the probability of getting a $T$ statistic as large as
    $2.5$?

```r
pt(2.5, 15, lower.tail = FALSE)
```

```
## [1] 0.01225
```

* Therefore, the probability of seeing evidence as extreme or more extreme than that actually obtained under $H_0$ is 0.0123

---
### The attained significance level
* Our test statistic was $2$ for $H_0 : \mu_0  = 30$ versus $H_a:\mu > 30$.
* Notice that we rejected the one sided test when $\alpha = 0.05$, would we reject if $\alpha = 0.01$, how about $0.001$?
* The smallest value for alpha that you still reject the null hypothesis is called the *attained significance level*
* This is equivalent, but philosophically a little different from, the *P-value*

---
### Notes
* By reporting a P-value the reader can perform the hypothesis
  test at whatever $\alpha$ level he or she choses
* If the P-value is less than $\alpha$ you reject the null hypothesis 
* For two sided hypothesis test, double the smaller of the two one
  sided hypothesis test Pvalues

---
### Revisiting an earlier example (star mark) ;)

- Suppose a friend has $8$ children, $7$ of which are girls and none are twins
- If each gender has an independent $50$% probability for each birth, what's the probability of getting $7$ or more girls out of $8$ births?

```r
choose(8, 7) * 0.5^8 + choose(8, 8) * 0.5^8
```

```
## [1] 0.03516
```

```r
pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)
```

```
## [1] 0.03516
```


---
### Poisson example

- Suppose that a hospital has an infection rate of 10 infections per
  100 person/days at risk (rate of 0.1) during the last monitoring
  period.
- Assume that an infection rate of 0.05 is an important benchmark. 
- Given the model, could the observed rate being larger than 0.05 be attributed to chance?
- Under $H_0: \lambda = 0.05$ so that $\lambda_0 100 = 5$
- Consider $H_a: \lambda > 0.05$.


JFC the writing is crazy! 


**Sample:** 10 infections for 100 sick people/day => rate of 0.1

**Expected, prefered rate**: 5 infections for .... => rate of 0.05

**H0** rate = 0.05

**H_a** rate > 0.05



```r
ppois(9, 5, lower.tail = FALSE)
```

```
## [1] 0.03183
```



## quiz c6-w3

1. In a population of interest, a sample of 9 men yielded a sample
   average brain volume of 1,100cc and a standard deviation of
   30cc. What is a 95% Student's T confidence interval for the mean
   brain volume in this new population?
		
		mn=1100
		sp=30/3
		mn + c(1,-1) * qt(0.975,8) * sp
   
2. In a population of interest, a sample of 9 men yielded a sample
   average brain volume of 1,100cc and a standard deviation of
   30cc. What is a 95% Student's T confidence interval for the mean
   brain volume in this new population?
		
		2*3/qt(0.975,8)
		2.60
   
3. In an effort to improve running performance, 5 runners were either
   given a protein supplement or placebo. Then, after a suitable
   washout period, they were given the opposite treatment. Their mile
   times were recorded under both the treatment and placebo, yielding
   10 measurements with 2 per subject. The researchers intend to use a
   T test and interval to investigate the treatment. Should they use a
   paired or independent group T test and interval?
   
4. In a study of emergency room waiting times, investigators consider
   a new and the standard triage systems. To test the systems,
   administrators selected 20 nights and randomly assigned the new
   triage system to be used on 10 nights and the standard system on
   the remaining 10 nights. They calculated the nightly median waiting
   time (MWT) to see a physician. The average MWT for the new system
   was 3 hours with a variance of 0.60 while the average MWT for the
   old system was 5 hours with a variance of 0.68. Consider the 95%
   confidence interval estimate for the differences of the mean MWT
   associated with the new system. Assume a constant variance. What is
   the interval? Subtract in this order (New System - Old System).
   

	-2.75 to -1.25
	
5. Suppose that you create a 95% T confidence interval. You then
   create a 90% interval using the same data. What can be said about
   the 90% interval with respect to the 95% interval?
   
   Smaller obviously
   
6. To further test the hospital triage system, administrators selected
   200 nights and randomly assigned a new triage system to be used on
   100 nights and a standard system on the remaining 100 nights. They
   calculated the nightly median waiting time (MWT) to see a
   physician. The average MWT for the new system was 4 hours with a
   standard deviation of 0.5 hours while the average MWT for the old
   system was 6 hours with a standard deviation of 2 hours. Consider
   the hypothesis of a decrease in the mean MWT associated with the
   new treatment.

	What does the 95% independent group confidence interval with
	unequal variances suggest vis a vis this hypothesis? (Because there's
	so many observations per group, just use the Z quantile instead of the
	T.)
	
		n1 <- n2 <- 100
		xbar1 <- 4
		xbar2 <- 6
		s1 <- 0.5
		s2 <- 2
		xbar2 - xbar1 + c(-1, 1) * qnorm(0.975) * sqrt(s1^2/n1 +
		s2^2/n2)
		
7. Suppose that 18 obese subjects were randomized, 9 each, to a new
   diet pill and a placebo. Subjects’ body mass indices (BMIs) were
   measured at a baseline and again after having received the
   treatment or placebo for four weeks. The average difference from
   follow-up to the baseline (followup - baseline) was −3 kg/m2 for
   the treated group and 1 kg/m2 for the placebo group. The
   corresponding standard deviations of the differences was 1.5 kg/m2
   for the treatment group and 1.8 kg/m2 for the placebo group. Does
   the change in BMI over the four week period appear to differ
   between the treated and placebo groups? Assuming normality of the
   underlying data and a common population variance, calculate the
   relevant *90%* t confidence interval. Subtract in the order of
   (Treated - Placebo) with the smaller (more negative) number first.
   
		n1 <- n2 <- 9
		x1 <- -3 ##treated
		x2 <- 1 ##placebo
		s1 <- 1.5 ##treated
		s2 <- 1.8 ##placebo
		s <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2)/(n1 + n2 - 2))
		(x1 - x2) + c(-1, 1) * qt(0.95, n1 + n2 - 2) * s * sqrt(1/n1 + 1/n2)
## Power (c6-w4)

-**Power is the probability of rejecting the null hypothesis when it is false**
- Ergo, power (as its name would suggest) is a good thing; you want more power
- A type II error (a bad thing, as its name would suggest) is failing to reject the null hypothesis when it's false; the probability of a type II error is usually called $\beta$
- Note Power  $= 1 - \beta$

**H_a** is true but you decide **H0**; for example, mu>30 but you
decide mu=30.

---


### Khan academy notes

https://www.khanacademy.org/math/ap-statistics/tests-significance-ap/error-probabilities-power/v/introduction-to-power-in-significance-tests


|                      | H0 true      | H0 False        |
|----------------------|--------------|-----------------|
| Reject H0            | Type I error | Correct (POWER) |
| Failing to reject H0 | Correct      | Type II error   |

H0: mu=30

Ha: mu>30


**Type I error:** when mu=30 but you reject H0. 

**Type II error:** When mu!=30 but you fail to reject the H0.

Imagine you take a random sample of n=100 from the population with
sigma = 4

**Under H0**, N(30,4) you check where mu=mu.sample is?

If mu=mu.sample lies outside of 95% values, then you reject H0; This
**5% is alpha**.

If mu=mu.sample lies within 95% values, then you fail to reject H0.

i.e., there is a 95% chance that you will be right (fail to reject
H0|under H0)

or there is a 5% chance that you are wrong (reject H0 | under H0)
**Type I error**

**Under !H0**,   N(say 35,4),  you check for where mu=mu.sample is?

if mu.sample lies to the left of Z_alpha quantile, then you fail to
reject H0 **(Type II error)**

if mu.sample lies to the right of Z_alpha quantile, then you reject H0
happily **(POWER)**


### Power increase when?

**alpha** ^ Power ^ And also Type I error ^

**n** ^ Power ^

**Less variability** ^ Power ^

**Mu** far from null hypotheses the Power ^


---
### Example continued
- $\mu_a = 32$, $\mu_0 = 30$, $n =16$, $\sigma = 4$

```r
mu0 = 30; mua = 32; sigma = 4; n = 16
z = qnorm(1 - alpha)
```

You get alpha from the below:

```r
pnorm(mu0 + z * sigma / sqrt(n), mean = mu0, sd = sigma / sqrt(n), 
      lower.tail = FALSE)
```

You get Power from the below:

```r
pnorm(mu0 + z * sigma / sqrt(n), mean = mua, sd = sigma / sqrt(n), 
      lower.tail = FALSE)
```

---

### Graphical Depiction of Power

```r
library(manipulate)
mu0 = 30
myplot <- function(sigma, mua, n, alpha){
    g = ggplot(data.frame(mu = c(27, 36)), aes(x = mu))
    g = g + stat_function(fun=dnorm, geom = "line", 
                          args = list(mean = mu0, sd = sigma / sqrt(n)), 
                          size = 2, col = "red")
    g = g + stat_function(fun=dnorm, geom = "line", 
                          args = list(mean = mua, sd = sigma / sqrt(n)), 
                          size = 2, col = "blue")
    xitc = mu0 + qnorm(1 - alpha) * sigma / sqrt(n)
    g = g + geom_vline(xintercept=xitc, size = 3)
    g
}
manipulate(
    myplot(sigma, mua, n, alpha),
    sigma = slider(1, 10, step = 1, initial = 4),
    mua = slider(30, 35, step = 1, initial = 32),
    n = slider(1, 50, step = 1, initial = 16),
    alpha = slider(0.01, 0.1, step = 0.01, initial = 0.05)
    )
```


---
### Question
- When testing $H_a : \mu > \mu_0$, notice if power is $1 - \beta$, then 
$$1 - \beta = P\left(\bar X > \mu_0 + z_{1-\alpha} \frac{\sigma}{\sqrt{n}} ; \mu = \mu_a \right)$$
- where $\bar X \sim N(\mu_a, \sigma^2 / n)$
- **Unknowns: $\mu_a$, $\sigma$, $n$, $\beta$**
- **Knowns: $\mu_0$, $\alpha$**
- **Specify any 3 of the unknowns and you can solve for the remainder**

---
### Notes

- Power doesn't need **$\mu_a$, $\sigma$ and $n$**, instead only
 **$\frac{\sqrt{n}(\mu_a - \mu_0)}{\sigma}$**
 
  - The quantity **$\frac{\mu_a - \mu_0}{\sigma}$** is called the **effect
    size**

- **Unknowns: $\mu_a$, $\sigma$, $n$, $\beta$**
- **Knowns: $\mu_0$, $\alpha$**
- **Specify any 3 of the unknowns and you can solve for the
  remainder**
  
  
---
### T-test power
-  Consider calculating power for a Gossett's $T$ test for our example
-  The power is
  $$
  P\left(\frac{\bar X - \mu_0}{S /\sqrt{n}} > t_{1-\alpha, n-1} ~;~ \mu = \mu_a \right)
  $$
- **Calcuting this requires the non-central t distribution.**
- **`power.t.test` does this very well**
  - Omit one of the arguments and it solves for it

---
### Example

```r
power.t.test(n = 16, delta = 2 / 4, sd=1, type = "one.sample",  alt = "one.sided")$power
```

```
## [1] 0.604
```

```r
power.t.test(n = 16, delta = 2, sd=4, type = "one.sample",  alt = "one.sided")$power
```

```
## [1] 0.604
```

```r
power.t.test(n = 16, delta = 100, sd=200, type = "one.sample", alt = "one.sided")$power
```

```
## [1] 0.604
```

---
### Example

```r
power.t.test(power = .8, delta = 2 / 4, sd=1, type = "one.sample",  alt = "one.sided")$n
```

```
## [1] 26.14
```

```r
power.t.test(power = .8, delta = 2, sd=4, type = "one.sample",  alt = "one.sided")$n
```

```
## [1] 26.14
```

```r
power.t.test(power = .8, delta = 100, sd=200, type = "one.sample", alt = "one.sided")$n
```

```
## [1] 26.14
```
## Key ideas Multiple testing C6-w4

* Hypothesis testing/significance analysis is commonly overused
* Correcting for multiple testing avoids false positives or discoveries
* Two key components
  * Error measure
  * Correction

---

### Three eras of statistics

__The age of Quetelet and his successors, in which huge census-level
data sets were brought to bear on simple but important questions__:
Are there more male than female births? Is the rate of insanity
rising?

The classical period of Pearson, Fisher, Neyman, Hotelling, and their
successors, intellectual giants who __developed a theory of optimal
inference capable of wringing every drop of information out of a
scientific experiment__. The questions dealt with still tended to be
simple Is treatment A better than treatment B?

__The era of scientific mass production__, in which new technologies
typified by the microarray allow a single team of scientists to
produce data sets of a size Quetelet would envy. But now the flood of
data is accompanied by a deluge of questions, perhaps thousands of
estimates or hypothesis tests that the statistician is charged with
answering together; not at all what the classical masters had in
mind. Which variables matter among the thousands measured? How do you
relate unrelated information?

[http://www-stat.stanford.edu/~ckirby/brad/papers/2010LSIexcerpt.pdf](http://www-stat.stanford.edu/~ckirby/brad/papers/2010LSIexcerpt.pdf)


[http://xkcd.com/882/](http://xkcd.com/882/) I don't get this!

---

### Types of errors

Suppose you are testing a hypothesis that a parameter $\beta$ equals zero versus the alternative that it does not equal zero. These are the possible outcomes. 
</br></br>

                    | $\beta=0$   | $\beta\neq0$   |  Hypotheses
--------------------|-------------|----------------|---------
Claim $\beta=0$     |      $U$    |      $T$       |  $m-R$
Claim $\beta\neq 0$ |      $V$    |      $S$       |  $R$
    Claims          |     $m_0$   |      $m-m_0$   |  $m$

</br></br>

__Type I error or false positive ($V$)__ Say that the parameter does not equal zero when it does

__Type II error or false negative ($T$)__ Say that the parameter equals zero when it doesn't 


---

### Error rates

__False positive rate__ - The rate at which false results ($\beta = 0$) are called significant: $E\left[\frac{V}{m_0}\right]$*

__Family wise error rate (FWER)__ - The probability of at least one false positive ${\rm Pr}(V \geq 1)$

__False discovery rate (FDR)__ - The rate at which claims of significance are false $E\left[\frac{V}{R}\right]$

* The false positive rate is closely related to the type I error rate [http://en.wikipedia.org/wiki/False_positive_rate](http://en.wikipedia.org/wiki/False_positive_rate)

---

### Controlling the false positive rate **FPR**

If P-values are correctly calculated calling all $P < \alpha$ significant will control the false positive rate at level $\alpha$ on average. 

<redtext>Problem</redtext>: Suppose that you perform 10,000 tests and $\beta = 0$ for all of them. 

Suppose that you call all $P < 0.05$ significant. 

The expected number of false positives is: $10,000 \times 0.05 = 500$  false positives. 

__How do we avoid so many false positives?__ reduce alpha!


---

### Controlling family-wise error rate (FWER)


The [Bonferroni correction](http://en.wikipedia.org/wiki/Bonferroni_correction) is the oldest multiple testing correction. 

__Basic idea__: 
* Suppose you do $m$ tests
* You want to control FWER at level $\alpha$ so $Pr(V \geq 1) < \alpha$
* Calculate P-values normally
* Set $\alpha_{fwer} = \alpha/m$
* Call all $P$-values less than $\alpha_{fwer}$ significant

__Pros__: Easy to calculate, conservative
__Cons__: May be very conservative


---

### Controlling false discovery rate (FDR)

This is the most popular correction when performing _lots_ of tests say in genomics, imaging, astronomy, or other signal-processing disciplines. 

__Basic idea__: 
* Suppose you do $m$ tests
* You want to control FDR at level $\alpha$ so $E\left[\frac{V}{R}\right]$
* Calculate P-values normally
* Order the P-values from smallest to largest $P_{(1)},...,P_{(m)}$
* Call any $P_{(i)} \leq \alpha \times \frac{i}{m}$ significant

__Pros__: Still pretty easy to calculate, less conservative (maybe much less)

__Cons__: Allows for more false positives, may behave strangely under dependence

---

### Example with 10 P-values

<img class=center src=fig/example10pvals.png height=450>

Controlling all error rates at $\alpha = 0.20$

Controlling FDR results in a line.

Controlling FWER resutls in a very conservative cutoff

![p-values cut off](./images/p-values.png)

---

### Adjusted P-values

* One approach is to adjust the threshold $\alpha$
* A different approach is to calculate "adjusted p-values"
* They _are not p-values_ anymore
* But they can be used directly without adjusting $\alpha$

__Example__: 
* Suppose P-values are $P_1,\ldots,P_m$
* You could adjust them by taking $P_i^{fwer} = \max{m \times P_i,1}$ for each P-value.
* Then if you call all $P_i^{fwer} < \alpha$ significant you will control the FWER. 

---

### Case study I: no true positives


```r
set.seed(1010093)
pValues <- rep(NA, 1000)
for (i in 1:1000) {
    y <- rnorm(20)
    x <- rnorm(20)
    pValues[i] <- summary(lm(y ~ x))$coeff[2, 4]
}

# Controls false positive rate
sum(pValues < 0.05)
```

```
## [1] 51
```


---

### Case study I: no true positives


```r
# Controls FWER
sum(p.adjust(pValues, method = "bonferroni") < 0.05)
```

```
## [1] 0
```

```r
# Controls FDR
sum(p.adjust(pValues, method = "BH") < 0.05)
```

```
## [1] 0
```



---

### Case study II: 50% true positives


```r
set.seed(1010093)
pValues <- rep(NA, 1000)
for (i in 1:1000) {
    x <- rnorm(20)
    # First 500 beta=0, last 500 beta=2
    if (i <= 500) {
        y <- rnorm(20)
    } else {
        y <- rnorm(20, mean = 2 * x)
    }
    pValues[i] <- summary(lm(y ~ x))$coeff[2, 4]
}
trueStatus <- rep(c("zero", "not zero"), each = 500)
table(pValues < 0.05, trueStatus)
```

```
##        trueStatus
##         not zero zero
##   FALSE        0  476
##   TRUE       500   24
```


---


### Case study II: 50% true positives


```r
# Controls FWER
table(p.adjust(pValues, method = "bonferroni") < 0.05, trueStatus)
```

```
##        trueStatus
##         not zero zero
##   FALSE       23  500
##   TRUE       477    0
```

```r
# Controls FDR
table(p.adjust(pValues, method = "BH") < 0.05, trueStatus)
```

```
##        trueStatus
##         not zero zero
##   FALSE        0  487
##   TRUE       500   13
```



---


### Case study II: 50% true positives

__P-values versus adjusted P-values__

```r
par(mfrow = c(1, 2))
plot(pValues, p.adjust(pValues, method = "bonferroni"), pch = 19)
plot(pValues, p.adjust(pValues, method = "BH"), pch = 19)
```

For Bonferroni it is mostly 1 and for BH it increases with p-values!


---

### Notes and resources

__Notes__:
* Multiple testing is an entire subfield
* A basic Bonferroni/BH correction is usually enough
* If there is strong dependence between tests there may be problems
  * Consider method="BY"

__Further resources__:
* [Multiple testing procedures with applications to genomics](http://www.amazon.com/Multiple-Procedures-Applications-Genomics-Statistics/dp/0387493166/ref=sr_1_2/102-3292576-129059?ie=UTF8&s=books&qid=1187394873&sr=1-2)
* [Statistical significance for genome-wide studies](http://www.pnas.org/content/100/16/9440.full)
* [Introduction to multiple testing](http://ies.ed.gov/ncee/pubs/20084018/app_b.asp)
## resampling: bootstrap and permutations c6-w4


> Both are popular and useful, but primarily for different uses. The
> permutation test is best for testing hypotheses and bootstrapping is
> best for estimating confidence intervals.


Also look at this

> If you are using R, then they are all easy to implement. See, for
> instance,
> http://www.burns-stat.com/pages/Tutor/bootstrap_resampling.html



- The bootstrap is a tremendously useful tool for constructing
  confidence intervals and calculating standard errors for difficult
  statistics
- For example, how would one derive a confidence interval for the median?
- The bootstrap procedure follows from the so called bootstrap
  principle
  
---
### Obtain 10k datasets from the same dataset!

```r
library(UsingR)
```

```r
data(father.son)
x <- father.son$sheight
n <- length(x)
B <- 10000
resamples <- matrix(sample(x,
                           n * B,
                           replace = TRUE),
                    B, n)
resampledMedians <- apply(resamples, 1, median)
```

Plot of sample distribution of the medians

---


### The bootstrap principle

- Suppose that I have a statistic that estimates some population
  parameter, but I don't know its sampling distribution
- **The bootstrap principle suggests using the distribution defined by
  the data to approximate its sampling distribution**

---

### Nonparametric bootstrap algorithm example

- **Bootstrap procedure for calculating confidence interval for the
  median from a data set of $n$ observations**

  i. Sample $n$ observations **with replacement** from the observed
  data resulting in one simulated complete data set
  
  ii. Take the median of the simulated data set
  
  iii. Repeat these two steps $B$ times, resulting in $B$ simulated
  medians
  
  iv. These medians are approximately drawn from the sampling
  distribution of the median of $n$ observations; therefore we can
  
    - Draw a histogram of them
    - Calculate their standard deviation to estimate the standard
      error of the median
    - Take the $2.5^{th}$ and $97.5^{th}$ percentiles as a confidence
      interval for the median

---

### Example code


```r
B <- 10000
resamples <- matrix(sample(x,
                           n * B,
                           replace = TRUE),
                    B, n)
medians <- apply(resamples, 1, median)
sd(medians)
```

```
## [1] 0.08424
```

```r
quantile(medians, c(.025, .975))
```

```
##  2.5% 97.5% 
## 68.43 68.81
```

---
### Histogram of bootstrap resamples


```r
g = ggplot(data.frame(medians = medians), aes(x = medians))
g = g + geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05)
g
```

---

	
### Notes on the bootstrap

- The bootstrap is non-parametric
- **Better percentile bootstrap confidence intervals correct for bias**
- There are lots of variations on bootstrap procedures; the book "An
  Introduction to the Bootstrap"" by Efron and Tibshirani is a great
  place to start for both bootstrap and jackknife information


---
### Group comparisons
- Consider comparing two independent groups.
- Example, comparing sprays B and C

---
### Permutation tests
-  Consider the null hypothesis that the distribution of the observations from each group is the same
-  Then, the group labels are irrelevant
- Consider a data frome with count and spray
- Permute the spray (group) labels 
- Recalculate the statistic
  - Mean difference in counts
  - Geometric means
  - T statistic
- Calculate the percentage of simulations where
the simulated statistic was more extreme (toward
the alternative) than the observed

---
### Variations on permutation testing (apparently too much info)


| Data type | Statistic           | Test name                 |
|-----------|---------------------|---------------------------|
| Ranks     | rank sum            | rank sum test             |
| Binary    | hypergeometric prob | Fisher's exact test       |
| Raw data  |                     | ordinary permutation test |

- Also, so-called *randomization tests* are exactly permutation tests, with a different motivation.
- For matched data, one can randomize the signs
  - For ranks, this results in the signed rank test
- Permutation strategies work for regression as well
  - Permuting a regressor of interest
- Permutation tests work very well in multivariate settings

---
### Permutation test B v C

```r
subdata <- InsectSprays[InsectSprays$spray %in% c("B", "C"),]
y <- subdata$count
group <- as.character(subdata$spray)
testStat <- function(w, g) mean(w[g == "B"]) - mean(w[g == "C"])
observedStat <- testStat(y, group)
permutations <- sapply(1 : 10000, function(i) testStat(y, sample(group)))
observedStat
```

```
## [1] 13.25
```

```r
mean(permutations > observedStat)
```

```
## [1] 0
```

---
### Histogram of permutations B v C
<img src="assets/fig/unnamed-chunk-9.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

## Quiz 4 (c6-w4) (lot of deaths)


1. A pharmaceutical company is interested in testing a potential blood
   pressure lowering medication. Their first examination considers
   only subjects that received the medication at baseline then two
   weeks later. The data are as follows (SBP in mmHg)
   
   Consider testing the hypothesis that there was a mean reduction in
   blood pressure? Give the P-value for the associated two sided T
   test.
   
   (Hint, consider that the observations are paired.)



	0.087
	
	```R
	bl <- c(140, 138, 150, 148, 135)
	fu <- c(132, 135, 151, 146, 130)
	t.test(fu, bl, alternative = "two.sided", paired = TRUE)
	t.test(fu - bl, alternative = "two.sided")
	```
	
2. A sample of 9 men yielded a sample average brain volume of 1,100cc
   and a standard deviation of 30cc. What is the complete set of values
   of \mu_0 μ 0 ​ that a test of H_0: \mu = \mu_0 H 0 ​ :μ=μ 0 ​ would fail
   to reject the null hypothesis in a two sided 5% Students t-test?

		1100 + c(-1, 1) * qt(0.975, 8) * 30/sqrt(9)
		
	1077 to 1123
	
3. Researchers conducted a blind taste test of Coke versus Pepsi. Each
   of four people was asked which of two blinded drinks given in
   random order that they preferred. The data was such that 3 of the 4
   people chose Coke. Assuming that this sample is representative,
   report a P-value for a test of the hypothesis that Coke is
   preferred to Pepsi using a one sided exact test.
   
		pbinom(2, size = 4, prob = 0.5, lower.tail = FALSE)
		
	What the hell was the point of the 3/4???? Nothing! PNN!
	
4. Infection rates at a hospital above 1 infection per 100 person days
   at risk are believed to be too high and are used as a benchmark. A
   hospital that had previously been above the benchmark recently had
   10 infections over the last 1,787 person days at risk. About what
   is the one sided P-value for the relevant test of whether the
   hospital is *below* the standard?
   
		ppois(10, lambda = 0.01 * 1787)
		
    10 is on the left!
	
	
5. Suppose that 18 obese subjects were randomized, 9 each, to a new
   diet pill and a placebo. Subjects’ body mass indices (BMIs) were
   measured at a baseline and again after having received the
   treatment or placebo for four weeks. The average difference from
   follow-up to the baseline (followup - baseline) was −3 kg/m2 for
   the treated group and 1 kg/m2 for the placebo group. The
   corresponding standard deviations of the differences was 1.5 kg/m2
   for the treatment group and 1.8 kg/m2 for the placebo group. Does
   the change in BMI appear to differ between the treated and placebo
   groups? Assuming normality of the underlying data and a common
   population variance, give a pvalue for a two sided t test.
   
   
		n1 <- n2 <- 9
		x1 <- -3 ##treated
		x2 <- 1 ##placebo
		s1 <- 1.5 ##treated
		s2 <- 1.8 ##placebo
		s <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2)/(n1 + n2 - 2))
		ts <- (x1 - x2)/(s * sqrt(1/n1 + 1/n2))
		2 * pt(ts, n1 + n2 - 2)
	
	**Double p so that you get it on both sides!**


6. Brain volumes for 9 men yielded a 90% confidence interval of 1,077
   cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test
   of

	H_0 : \mu = 1,078 H 0 ​ :μ=1,078?
	
	Ans: No, you would fail to reject. The 95% interval would be wider
	than the 90% interval. Since 1,078 is in the narrower 90% interval, it
	would also be in the wider 95% interval. Thus, in either case it's in
	the interval and so you would fail to reject.
	
7. Researchers would like to conduct a study of 100 100 healthy adults
   to detect a four year mean brain volume loss of .01~mm^3 .01 mm 3
   . Assume that the standard deviation of four year volume loss in
   this population is .04~mm^3 . About what would be the
   power of the study for a 5\% 5% one sided test versus a null
   hypothesis of no volume loss?
   
		pnorm(1.645 * 0.004, mean = 0.01, sd = 0.004, lower.tail = FALSE)

8. Researchers would like to conduct a study of n n healthy adults to
   detect a four year mean brain volume loss of .01~mm^3 .01 mm 3
   . Assume that the standard deviation of four year volume loss in this
   population is .04~mm^3 .04 mm 3 . About what would be the value of n n
   needed for 90\% 90% power of type one error rate of 5\% 5% one sided
   test versus a null hypothesis of no volume loss?

		power.t.test(delta=0.01,sd=0.04,sig.level=0.05,power=0.9,type="one.sample",alt="one.sided")
		
		ceiling((4 * (qnorm(0.95) - qnorm(0.1)))^2)
		
9. As you increase the type one error rate, \alpha α, what happens to
   power?
   
   As you require less evidence to reject, i.e. your \alpha α rate
   goes up, you will have larger power.
## Regression Models c7-w1

### (Perhaps surprisingly, this example is still relevant)


[http://www.nature.com/ejhg/journal/v17/n8/full/ejhg20095a.html](http://www.nature.com/ejhg/journal/v17/n8/full/ejhg20095a.html)

[Predicting height: the Victorian approach beats modern genomics](http://www.wired.com/wiredscience/2009/03/predicting-height-the-victorian-approach-beats-modern-genomics/)
	
---
### Recent simply statistics post
(Simply Statistics is a blog by Jeff Leek, Roger Peng and 
Rafael Irizarry, who wrote this post, link on the image)



- **"Data supports claim that if Kobe stops ball hogging the Lakers
  will win more"**
- "Linear regression suggests that an increase of 1% in % of shots taken by Kobe results in a drop of 1.16 points (+/- 0.22)  in score differential."
- How was it done? Do you agree with the analysis? 



---
### Questions for this class (too many labels!!!)
* Consider trying to answer the following kinds of questions:
  * To use the parents' heights to predict childrens' heights.
  * To try to find a parsimonious, easily described mean 
    relationship between parent and children's heights.
  * To investigate the variation in childrens' heights that appears 
  unrelated to parents' heights (residual variation).
  * To quantify what impact genotype information has beyond parental height in explaining child height.
  * To figure out how/whether and what assumptions are needed to
    generalize findings beyond the data in question.  
  * Why do children of very tall parents tend to be 
    tall, but a little shorter than their parents and why children of very short parents tend to be short, but a little taller than their parents? (This is a famous question called 'Regression to the mean'.)

---
### Galton's Data

* Let's look at the data first, used by Francis Galton in 1885. 
* Galton was a statistician who invented the term and concepts
  of regression and correlation, founded the journal Biometrika,
  and was the cousin of Charles Darwin.
* You may need to run `install.packages("UsingR")` if the `UsingR` library is not installed.
* Let's look at the marginal (parents disregarding children and children disregarding parents) distributions first. 
  * Parent distribution is all heterosexual couples.
  * **Correction for gender via multiplying female heights by 1.08.**
  * Overplotting is an issue from discretization. (do not [overplot](https://www.displayr.com/what-is-overplotting/))

---

```r
library(UsingR); data(galton); library(reshape); long <- melt(galton)
g <- ggplot(long, aes(x = value, fill = variable)) 
g <- g + geom_histogram(colour = "black", binwidth=1) 
g <- g + facet_grid(. ~ variable)
g
```
**plot of histograms of children heights and parents heights!**

---
### Finding the middle via least squares
* Consider only the children's heights. 
  * How could one describe the "middle"?
  * One definition, let $Y_i$ be the height of child $i$ for $i = 1,
  \ldots, n = 928$, then define the middle as the value of $\mu$ that
  minimizes $$\sum_{i=1}^n (Y_i - \mu)^2$$
* This is physical center of mass of the histrogram.
* You might have guessed that the answer $\mu = \bar Y$.

**Least squares finds a line with minimum "error"**

---
### Experiment
#### Use R studio's manipulate to see what value of $\mu$ minimizes the sum of the squared deviations.

```
library(manipulate)
myHist <- function(mu){
    mse <- mean((galton$child - mu)^2)
    g <- ggplot(galton, aes(x = child)) + geom_histogram(fill = "salmon", colour = "black", binwidth=1)
    g <- g + geom_vline(xintercept = mu, size = 3)
    g <- g + ggtitle(paste("mu = ", mu, ", MSE = ", round(mse, 2), sep = ""))
    g
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))
```

---
### **The least squares est. is the empirical mean for least error**

```r
g <- ggplot(galton, aes(x = child)) + geom_histogram(fill = "salmon", colour = "black", binwidth=1)
g <- g + geom_vline(xintercept = mean(galton$child), size = 3)
g
```


---
#### Proof: that least squares est. for low error is the emperical mean!

$$ 
\begin{align} 
\sum_{i=1}^n (Y_i - \mu)^2 & = \
\sum_{i=1}^n (Y_i - \bar Y + \bar Y - \mu)^2 \\ 
& = \sum_{i=1}^n (Y_i - \bar Y)^2 + \
2 \sum_{i=1}^n (Y_i - \bar Y)  (\bar Y - \mu) +\
\sum_{i=1}^n (\bar Y - \mu)^2 \\
& = \sum_{i=1}^n (Y_i - \bar Y)^2 + \
2 (\bar Y - \mu) \sum_{i=1}^n (Y_i - \bar Y)  +\
\sum_{i=1}^n (\bar Y - \mu)^2 \\
& = \sum_{i=1}^n (Y_i - \bar Y)^2 + \
2 (\bar Y - \mu)  (\sum_{i=1}^n Y_i - n \bar Y) +\
\sum_{i=1}^n (\bar Y - \mu)^2 \\
& = \sum_{i=1}^n (Y_i - \bar Y)^2 + \sum_{i=1}^n (\bar Y - \mu)^2\\ 
& \geq \sum_{i=1}^n (Y_i - \bar Y)^2 \
\end{align} 
$$

---
### Comparing childrens' heights and their parents' heights

[OVERPLOTTING!](https://www.displayr.com/what-is-overplotting/)

```r
ggplot(galton, aes(x = parent, y = child)) + geom_point()
```


---
Size of point represents number of points at that (X, Y) combination (See the Rmd file for the code).

**Plot code not given here about how not to Overplot!**


---
### Regression through the origin
* Suppose that $X_i$ are the parents' heights.
* Consider picking the slope $\beta$ that minimizes $$\sum_{i=1}^n (Y_i - X_i \beta)^2$$
* This is exactly using the origin as a pivot point picking the
line that minimizes the sum of the squared vertical distances
of the points to the line
* Use R studio's  manipulate function to experiment
* Subtract the means so that the origin is the mean of the parent
and children's heights

---

```r
y <- galton$child - mean(galton$child)
x <- galton$parent - mean(galton$parent)
freqData <- as.data.frame(table(x, y))
names(freqData) <- c("child", "parent", "freq")
freqData$child <- as.numeric(as.character(freqData$child))
freqData$parent <- as.numeric(as.character(freqData$parent))
myPlot <- function(beta){
    g <- ggplot(filter(freqData, freq > 0), aes(x = parent, y = child))
    g <- g  + scale_size(range = c(2, 20), guide = "none" )
    g <- g + geom_point(colour="grey50", aes(size = freq+20, show_guide = FALSE))
    g <- g + geom_point(aes(colour=freq, size = freq))
    g <- g + scale_colour_gradient(low = "lightblue", high="white")                     
    g <- g + geom_abline(intercept = 0, slope = beta, size = 3)
    mse <- mean( (y - beta * x) ^2 )
    g <- g + ggtitle(paste("beta = ", beta, "mse = ", round(mse, 3)))
    g
}
manipulate(myPlot(beta), beta = slider(0.6, 1.2, step = 0.02))
```


---
### The solution 
#### In the next few lectures we'll talk about why this is the solution

```r
lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data = galton)
```

```

Call:
lm(formula = I(child - mean(child)) ~ I(parent - mean(parent)) - 
    1, data = galton)

Coefficients:
I(parent - mean(parent))  
                   0.646  
```

**The -1 somehow gets rid of the intercepts!!!!???**

### Summary AGENT

- Linear regression is line which minimizes error in "Y".

- $$\sum_{i=1}^n (Y_i - \mu)^2$$

	- mu is nothing but the mean (proof is available above!) so that
      error is minimized
- For some reason we centre the line around the mean so to get better
  estimates!
  
- This is done by using:

		lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data = galton)
	
	- the **-1** somehow gets rid of the intercepts!
	
## Notation c7-w1
### Some basic definitions

* In this module, we'll cover some basic definitions and notation used throughout the class.
* We will try to minimize the amount of mathematics required for this class.
* No calculus is required. 

---

### Notation for data

* We write $X_1, X_2, \ldots, X_n$ to describe $n$ data points.
* As an example, consider the data set $\{1, 2, 5\}$ then 
  * $X_1 = 1$, $X_2 = 2$, $X_3 = 5$ and $n = 3$.
* We often use a different letter than $X$, such as $Y_1, \ldots , Y_n$.
* We will typically use Greek letters for things we don't know. 
  Such as, $\mu$ is a mean that we'd like to estimate.

---
### The empirical mean 

* Define the empirical mean as
$$
\bar X = \frac{1}{n}\sum_{i=1}^n X_i. 
$$
* Notice if we subtract the mean from data points, we get data that has mean 0. That is, if we define
$$
**\tilde X_i = X_i - \bar X.**
$$
The mean of the $\tilde X_i$ is 0.
* This process is called **"centering" the random variables**.
* Recall from the previous lecture that the mean is 
  the least squares solution for minimizing
  $$
  \sum_{i=1}^n (X_i - \mu)^2
  $$

---

### The empirical standard deviation and variance

* Define the empirical variance as 
$$
S^2 = \frac{1}{n-1} \sum_{i=1}^n (X_i - \bar X)^2 
= \frac{1}{n-1} \left( \sum_{i=1}^n X_i^2 - n \bar X ^ 2 \right)
$$
* The empirical standard deviation is defined as
$S = \sqrt{S^2}$. Notice that the standard deviation has the same units as the data.
* The data defined by $X_i / s$ have empirical standard
  deviation 1. This is called "scaling" the data. i.e., **SCALING**

**Empirical seems to be associated with the sample!**

---
### Normalization

* The data defined by
$$
**Z_i = \frac{X_i - \bar X}{s}**
$$
**have empirical mean zero and empirical standard deviation 1**. 
* The process of centering then scaling the data is called **"normalizing"** the data. 
* Normalized data are centered at 0 and have units equal to standard deviations of the original data. 
* Example, a value of 2 from normalized data means that data point
was two standard deviations larger than the mean.

**SCALING AND CENTERING**

---
### The empirical covariance
* Consider now when we have pairs of data, $(X_i, Y_i)$.
* Their empirical covariance is 
$$
Cov(X, Y) = 
\frac{1}{n-1}\sum_{i=1}^n (X_i - \bar X) (Y_i - \bar Y)
= \frac{1}{n-1}\left( \sum_{i=1}^n X_i Y_i - n \bar X \bar Y\right)
$$
* The correlation is defined is
$$
Cor(X, Y) = \frac{Cov(X, Y)}{S_x S_y}
$$
where $S_x$ and $S_y$ are the estimates of standard deviations 
for the $X$ observations and $Y$ observations, respectively.

**Covariance**

It is the measure of deviation of X and Y from linear relationship
relationship. i.e., if X and Y are plotted on to a line with slope
"doesn't matter" degrees!

**Correlation**

$$
Cor(X, Y) = \frac{Cov(X, Y)}{S_x S_y}
$$

Just divide Covariance by emperical SD's.

---
### Some facts about correlation
* $**Cor(X, Y) = Cor(Y, X)**$
* **$-1 \leq Cor(X, Y) \leq 1$**
* $Cor(X,Y) = 1$ and $Cor(X, Y) = -1$ only when the $X$ or $Y$ observations fall perfectly on a positive or negative sloped line, respectively.
* $Cor(X, Y)$ **measures the strength of the linear relationship between the $X$ and $Y$** data, with stronger relationships as $Cor(X,Y)$ heads towards -1 or 1.
* $Cor(X, Y) = 0$ implies no linear relationship. 

		cor(x,2*x)=1
		cor(x,-x)=-1

**Cor measures ability to fall on straight line. Cov is not that
useful other than in getting Cov I think**


## OLS c7-w1

### Fitting the best line 
* Let $Y_i$ be the $i^{th}$ child's height and $X_i$ be the 
$i^{th}$ (average over the pair of) parents' heights. 
* Consider finding the best line 
  * Child's Height = $\beta_0$ + Parent's Height $\beta_1$
* Use least squares
  $$
  \sum_{i=1}^n \{Y_i - (\beta_0 + \beta_1 X_i)\}^2
  $$

---
### Results (beta0, beta1)
* The least squares model fit to the line $Y = \beta_0 + \beta_1 X$
  through the data pairs $(X_i, Y_i)$ with $Y_i$ as the outcome
  obtains the line $Y = \hat \beta_0 + \hat \beta_1 X$ where $$\hat
  **\beta_1 = Cor(Y, X) \frac{Sd(Y)}{Sd(X)} ~~~ \hat \beta_0 = \bar Y -
  \hat \beta_1 \bar X**$$
* **The line passes through the point $(\bar X, \bar Y$)**
* The slope of the regression line with $X$ as the outcome and $Y$ as
  the predictor is $Cor(Y, X) Sd(X)/ Sd(Y)$.
* The slope is the same one you would get if you centered the data,
$(X_i - \bar X, Y_i - \bar Y)$, and did regression through the origin.
* If you normalized the data, $\{ \frac{X_i - \bar X}{Sd(X)},
  \frac{Y_i - \bar Y}{Sd(Y)}\}$, the slope is $Cor(Y, X)$.

* **Regression line passes through the centre**
* **centered data also has the same slope as the actual data**
		coef(lm(yc~xc))[2]==coef(lm(y~x))[2]

**Normalizing the values results in slope beta1=cor(y,x)**

		yn <- (y - mean(y))/sd(y)
		xn <- (x - mean(x))/sd(x)
		c(cor(y, x), cor(yn, xn), coef(lm(yn ~ xn))[2])

[This lecture](https://www.youtube.com/watch?v=COVQX8WZVA8&list=PLpl-gQkQivXjqHAJd2t-J_One_fYE55tC&index=8) gives more info on the derivations.

---
### Revisiting Galton's data
#### Double check our calculations using R

```r
y <- galton$child
x <- galton$parent
beta1 <- cor(y, x) *  sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
rbind(c(beta0, beta1), coef(lm(y ~ x)))
```

```
     (Intercept)      x
[1,]       23.94 0.6463
[2,]       23.94 0.6463
```


---
### Revisiting Galton's data
#### Reversing the outcome/predictor relationship

```r
beta1 <- cor(y, x) *  sd(x) / sd(y)
beta0 <- mean(x) - beta1 * mean(y)
rbind(c(beta0, beta1), coef(lm(x ~ y)))
```

```
     (Intercept)      y
[1,]       46.14 0.3256
[2,]       46.14 0.3256
```


---
### Revisiting Galton's data
#### Regression through the origin yields an equivalent slope if you center the data first

```r
yc <- y - mean(y)
xc <- x - mean(x)
beta1 <- sum(yc * xc) / sum(xc ^ 2)
c(beta1, coef(lm(y ~ x))[2])
```

```
            x 
0.6463 0.6463 
```

### Forcing the regression through origin

	x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
	y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

	sum(y*x)/sum(x^2)
	
	or 
	
	lm(y~0 + .,cbind(y,x))
	
	lm(y~0 _ .,cbind(x,y)) also gives the same result PNN!
	
---
### Revisiting Galton's data
#### Normalizing variables results in the slope being the correlation

```r
yn <- (y - mean(y))/sd(y)
xn <- (x - mean(x))/sd(x)
c(cor(y, x), cor(yn, xn), coef(lm(yn ~ xn))[2])
```

```
                  xn 
0.4588 0.4588 0.4588 
```


---
<div class="rimage center"><img src="fig/unnamed-chunk-6.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" class="plot" /></div>


## Quiz c7-w1

1. x <- c(0.18, -1.54, 0.42, 0.95)
   w <- c(2, 1, 3, 1)
   
   w is weights, what is the value that minimizes?
   
		sum(x * w)/sum(w)
   
   
2. x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
   y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
   
   it the regression through the origin and get the slope treating y
   as the outcome and x as the regressor. (Hint, do not center the data
   since we want regression through the origin, not through the means of
   the data.)
   
   
		coef(lm(y ~ x - 1))
		
		sum(y * x)/sum(x^2)
		
		coef(lm(y~0 + . , cbind(x,y)))
		
3. Do \verb|data(mtcars)|data(mtcars) from the datasets package and
   fit the regression model with mpg as the outcome and weight as the
   predictor. Give the slope coefficient.

		cor(mpg, wt) * sd(mpg)/sd(wt)
		
4. Consider data with an outcome (Y) and a predictor (X). The standard
   deviation of the predictor is one half that of the outcome. The
   correlation between the two variables is .5. What value would the
   slope coefficient for the regression model with YY as the outcome
   and XX as the predictor?
   
   1
   
5. Students were given two hard tests and scores were normalized to
   have empirical mean 0 and variance 1. The correlation between the
   scores on the two tests was 0.4. What would be the expected score
   on Quiz 2 for a student who had a normalized score of 1.5 on Quiz
   1?
   
   
		1.5 * 0.4
		
6. x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

		((x - mean(x))/sd(x))[1]
		
7. x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
   y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49,
   0.05)
   
		coef(lm(y ~ x))[1]
		
8. You know that both the predictor and response have mean 0. What can
   be said about the intercept when you fit a linear regression?
   
   The intercept estimate is $\bar Y - \beta_1 \bar X$ and so will be
   zero.
   
9. x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)

		mean(x)
10. beta1/ gamma1 ?

	when beta1 is y~x slope and gamma1 is x~y slope!
	
	Ans: var(y)/var(x)
	
	
   
## rttm c7-w2
###  Regression to the Mean **examples Agent**
* Why is it that the children of tall parents tend to be tall, but not as tall as their parents? 
* Why do children of short parents tend to be short, but not as short as their parents?
* Why do parents of very short children, tend to be short, but not a short as their child? And the same with parents of very tall children?
* Why do the best performing athletes this year tend to do a little worse the following?

**RTTM is about ramdomness**

Consider the above examples... where even though the athlete might
have worked the same, some randomness makes him better or worse is the
claim.

**100% rttm**

Think of a normal distribution, if in the first 100 numbers you get
maximum of 2. In the second 100 numbers (paired) the chance of getting
such a high number(in its pair)) is super low (mean=0, sd=1), (i.e., 2
sd's apart aka <5% chance in a bell curve).

	x <- rnorm(100)
	y <- rnorm(100)
	
	odr <- order(x)
	
	x[odr[100]] is 2
	
	y[odr[100]] is 0.5 or sumpin
	
**Exam tests rttm**

Test 1 has some mistakes but is still hard, Test 2 is also hard.

Good students score well in Test 1 compared to the second
test. Quizzes are imperfect to judge the potential of the kid. 

Many people get by, by just doing the previous-exam questions for
example. Think of the poor students, they would have done better in
the tests with errors than their test 2 grades.

vaguely rttm!

Basically rttm is some randomness in your life that peaks and lowers
your true performance, it is the noise, that doesn't allow to measure
your true potential.	

---
### Regression to the mean
* These phenomena are all examples of so-called regression to the mean
* Invented by Francis Galton in the paper "Regression towards
  mediocrity in hereditary stature" The Journal of the Anthropological
  Institute of Great Britain and Ireland , Vol. 15, (1886).
* Think of it this way, imagine if you simulated pairs of random normals
  * The largest first ones would be the largest by chance, and the
    probability that there are smaller for the second simulation is
    high.
  * In other words $P(Y < x | X = x)$ gets bigger as $x$ heads into
    the very large values.
  * Similarly $P(Y > x | X = x)$ gets bigger as $x$ heads to very
    small values.
* Think of the regression line as the intrisic part.
  * Unless $Cor(Y, X) = 1$ the intrinsic part isn't perfect

---
### Regression to the mean
* Suppose that we normalize $X$ (child's height) and $Y$ (parent's
  height) so that they both have mean 0 and variance 1.
* Then, recall, our regression line passes through $(0, 0)$ (the mean of the X and Y).
* If the slope of the regression line is $Cor(Y,X)$, regardless of
  which variable is the outcome (recall, both standard deviations are
  1).
* Notice if $X$ is the outcome and you create a plot where $X$ is the
  horizontal axis, the slope of the least squares line that you plot
  is $1/Cor(Y, X)$.


```r
library(UsingR)
data(father.son)
y <- (father.son$sheight - mean(father.son$sheight)) / sd(father.son$sheight)
x <- (father.son$fheight - mean(father.son$fheight)) / sd(father.son$fheight)
rho <- cor(x, y)

g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_point(size = 6, colour = "black", alpha = 0.2)
g = g + geom_point(size = 4, colour = "salmon", alpha = 0.2)
g = g + xlim(-4, 4) + ylim(-4, 4)
g = g + geom_abline(intercept = 0, slope = 1)
g = g + geom_vline(xintercept = 0)
g = g + geom_hline(yintercept = 0)
g = g + geom_abline(intercept = 0, slope = rho, size = 2)
g = g + geom_abline(intercept = 0, slope = 1 / rho, size = 2)
g
```

---

### Discussion
* If you had to predict a son's normalized height, it would be
  $Cor(Y, X) * X_i$ 
* If you had to predict a father's normalized height, it would be
  $Cor(Y, X) * Y_i$
* Multiplication by this correlation shrinks toward 0 (regression toward the mean)
* If the correlation is 1 there is no regression to the mean (if father's height perfectly determine's child's height and vice versa)
* Note, regression to the mean has been thought about quite a bit and
  generalized 
  
## Linear regression c7-w2
### Basic regression model with additive Gaussian errors.
* Least squares is an estimation tool, how do we do inference?
* Consider developing a probabilistic model for linear regression
$$
Y_i = \beta_0 + \beta_1 X_i + **\epsilon_{i}**
$$
* Here the $\epsilon_{i}$ are assumed iid $N(0, \sigma^2)$. 
* Note, $E[Y_i ~|~ X_i = x_i] = \mu_i = \beta_0 + \beta_1 x_i$
* Note, $Var(Y_i ~|~ X_i = x_i) = \sigma^2$. **variance for a given X**


---
### Recap
* Model $Y_i =  \mu_i + \epsilon_i = \beta_0 + \beta_1 X_i + \epsilon_i$ where $\epsilon_i$ are iid $N(0, \sigma^2)$
* ML estimates of $\beta_0$ and $\beta_1$ are the least squares estimates
  $$\hat \beta_1 = Cor(Y, X) \frac{Sd(Y)}{Sd(X)} ~~~ \hat \beta_0 = \bar Y - \hat \beta_1 \bar X$$
* $E[Y ~|~ X = x] = \beta_0 + \beta_1 x$
* $Var(Y ~|~ X = x) = \sigma^2$

---
### Changing regression coefficients beta1 beta0

**if you multiply the X axis by 10, then you divide the units
by 10. It changes the slope by 10**

$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i
= \beta_0 + \frac{\beta_1}{a} (X_i a) + \epsilon_i
= \beta_0 + \tilde \beta_1 (X_i a) + \epsilon_i
$$

* Example: $X$ is height in $m$ and $Y$ is weight in $kg$. Then $\beta_1$ is $kg/m$. Converting $X$ to $cm$ implies multiplying $X$ by $100 cm/m$. To get $\beta_1$ in the right units, we have to divide by $100 cm /m$ to get it to have the right units. 

**Subtracting the X axis by 'a' changes the intercept but not the
slope.**

---
### Example
#### `diamond` data set from `UsingR` 
Data is diamond prices (Singapore dollars) and diamond weight in
carats (standard measure of diamond mass, 0.2 $g$). To get the data
use 

```r
library(UsingR); 
data(diamond)
plot(diamond$carat, diamond$price,
xlab = "Mass (carats)",
ylab = "Price (SIN $)",
bg = "lightblue",
col = "black", cex = 1.1, pch = 21,frame = FALSE)
abline(lm(price ~ carat, data = diamond), lwd = 2)

```

---
### Fitting the linear regression model

```r
fit <- lm(price ~ carat, data = diamond)
coef(fit)
```

```
(Intercept)       carat 
     -259.6      3721.0 
```


* We estimate an expected 3721.02 (SIN) dollar increase in price for every carat increase in mass of diamond.
* The intercept -259.63 is the expected price
  of a 0 carat diamond.

---
### 0 carats value is worthless to you so you **Center** the Carats!

**Subtracting the X axis by 'a' changes the intercept but not the
slope.**

```r
fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond)
coef(fit2)
```

```
           (Intercept) I(carat - mean(carat)) 
                 500.1                 3721.0 
```

Thus $500.1 is the expected price for 
the average sized diamond of the data (0.2042 carats).

---
### Changing scale
* A one carat increase in a diamond is pretty big, what about
  changing units to 1/10th of a carat? 
* We can just do this by just dividing the coeficient by 10.
  * We expect  a 372.102 (SIN) dollar   change in price for every 1/10th of a carat increase in mass of diamond.
* Showing that it's the same if we rescale the Xs and refit

```r
fit3 <- lm(price ~ I(carat * 10), data = diamond)
coef(fit3)
```

```
  (Intercept) I(carat * 10) 
       -259.6         372.1 
```


---
### Predicting the price of a diamond

```r
newx <- c(0.16, 0.27, 0.34)
coef(fit)[1] + coef(fit)[2] * newx
```

```
[1]  335.7  745.1 1005.5
```
**Use Predict next time!**


```r
predict(fit, newdata = data.frame(carat = newx))
```

```
     1      2      3 
 335.7  745.1 1005.5 
```

### Plot with lm

```r
library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (SIN $)")
g = g + geom_point(size = 7, colour = "black", alpha=0.5)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g = g + geom_smooth(method = "lm", colour = "black")
g
```

## residual variation c7-w2

### Motivating example
#### `diamond` data set from `UsingR` 
Data is diamond prices (Singapore dollars) and diamond weight
in carats (standard measure of diamond mass, 0.2 $g$). To get the data use `library(UsingR); data(diamond)`

``` r
library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (SIN $)")
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha=0.5)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g
```


### Residuals
* Model **$Y_i = \beta_0 + \beta_1 X_i + \epsilon_i$** where
  $\epsilon_i \sim N(0, \sigma^2)$.
  
* Observed outcome $i$ is $Y_i$ at predictor value $X_i$
* Predicted outcome $i$ is $\hat Y_i$ at predictor valuve $X_i$ is
  $$
  \hat Y_i = \hat \beta_0 + \hat \beta_1 X_i
  $$
* Residual, the between the observed and predicted outcome
  $$
  e_i = Y_i - \hat Y_i
  $$
  
  **Residual is nothing but the difference between data and linear
  regressor line**
  
  * The vertical distance between the observed data point and the
    regression line
	
* Least squares minimizes $\sum_{i=1}^n e_i^2$
* The $e_i$ can be thought of as estimates of the $\epsilon_i$.

---
### Properties of the residuals
* $E[e_i] = 0$. **Intuitively if everything stands on either sides of
  the mean, then the sum shall be equal to 0**

* If an intercept is included, $\sum_{i=1}^n e_i = 0$ !!! Convinced by
  intuitive explanation [here](https://stats.stackexchange.com/a/189613/217983). **Regression line is in some sense a
  mean around which to the left are certain values which are exactly
  equal to the right. PNN!**
  
  I think when they say *including the intercept* I think we should
  not force the center through other points like the origin, in which
  case residual might be different?
  
		sum(resid(lm(price~diamond$carat-1))) != 0 (tested)
		sum(resid(lm(price~diamond$carat))) = 0 
		sum(resid(lm(xc~yc))) == 0 True!
		
* If a regressor variable, $X_i$, is included in the model
  $\sum_{i=1}^n e_i X_i = 0$. ???
  
* Residuals are useful for investigating poor model fit by zooming in
  on the locations.
  
* Positive residuals are above the line, negative residuals are below.

* Residuals can be thought of as the outcome ($Y$) with the
  linear association of the predictor ($X$) removed.
  
* One differentiates residual variation (variation after removing
the predictor) from systematic variation (variation explained by the regression model).
* Residual plots highlight poor model fit.

Residual variation is a random error like the one that occurs when you
take the same measurement over and over again but your reading varies "randomly"

---
### Calculate Residuals in 3 ways!


```r
data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit)
yhat <- predict(fit)
max(abs(e -(y - yhat)))
```

```
## [1] 9.486e-13
```

```r
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))
```

```
## [1] 9.486e-13
```

**Important properties**

```r
sum(e)=0
sum(e*X)=0
```

### Residuals are the assigned length of the red lines
```{r, echo = FALSE, fig.height=5, fig.width=5}
plot(diamond$carat, diamond$price,  
     xlab = "Mass (carats)", 
     ylab = "Price (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 2, pch = 21,frame = FALSE)
abline(fit, lwd = 2)
for (i in 1 : n) 
  lines(c(x[i], x[i]), c(y[i], yhat[i]), col = "red" , lwd = 2)
```

---
### Residuals versus X
```{r, echo = FALSE, fig.height=5, fig.width=5}
plot(x, e,  
     xlab = "Mass (carats)", 
     ylab = "Residuals (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 2, pch = 21,frame = FALSE)
abline(h = 0, lwd = 2)
for (i in 1 : n) 
  lines(c(x[i], x[i]), c(e[i], 0), col = "red" , lwd = 2)
```

---
### Non-linear data
```{r, echo = FALSE, fig.height=5, fig.width=5}
x = runif(100, -3, 3); y = x + sin(x) + rnorm(100, sd = .2); 
library(ggplot2)
g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g
```

---
### Residual plot
```{r, echo = FALSE, fig.height=5, fig.width=5}
g = ggplot(data.frame(x = x, y = resid(lm(y ~ x))), 
           aes(x = x, y = y))
g = g + geom_hline(yintercept = 0, size = 2); 
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g = g + xlab("X") + ylab("Residual")
g
```

---
### Heteroskedasticity
```{r, echo = FALSE, fig.height=4.5, fig.width=4.5}
x <- runif(100, 0, 6); y <- x + rnorm(100,  mean = 0, sd = .001 * x); 
g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g
```
**When residual increases with X**

---
### Getting rid of the blank space can be helpful
```{r, echo = FALSE, fig.height=4.5, fig.width=4.5}
g = ggplot(data.frame(x = x, y = resid(lm(y ~ x))), 
           aes(x = x, y = y))
g = g + geom_hline(yintercept = 0, size = 2); 
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g = g + xlab("X") + ylab("Residual")
g
```

---
### Diamond data residual plot

```{r, echo = FALSE, fig.height=4.5, fig.width=4.5}
diamond$e <- resid(lm(price ~ carat, data = diamond))
g = ggplot(diamond, aes(x = carat, y = e))
g = g + xlab("Mass (carats)")
g = g + ylab("Residual price (SIN $)")
g = g + geom_hline(yintercept = 0, size = 2)
g = g + geom_point(size = 7, colour = "black", alpha=0.5)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g
```

---
### Diamond data residual plot

```{r, echo = FALSE, fig.height=4.5, fig.width=4.5}
## price~1 gives variation about average
e = c(resid(lm(price ~ 1, data = diamond)), 
      resid(lm(price ~ carat, data = diamond)))
fit = factor(c(rep("Itc", nrow(diamond)),
               rep("Itc, slope", nrow(diamond))))
g = ggplot(data.frame(e = e, fit = fit), aes(y = e, x = fit, fill = fit))
g = g + geom_dotplot(binaxis = "y", size = 2, stackdir = "center", binwidth = 20)
g = g + xlab("Fitting approach")
g = g + ylab("Residual price")
g
```

---


---
### Estimating residual variation (n-2 dof)
* Model $Y_i = \beta_0 + \beta_1 X_i + \epsilon_i$ where $\epsilon_i \sim N(0, \sigma^2)$.
* The ML estimate of $\sigma^2$ is **$\frac{1}{n}\sum_{i=1}^n
e_i^2$**, the average squared residual.
* Most people use
  $$
  \hat \sigma^2 = \frac{1}{n-2}\sum_{i=1}^n e_i^2.
  $$
* The **$n-2$** instead of $n$ is so that $E[\hat \sigma^2] =
  \sigma^2$

---
### Diamond example

```r
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
summary(fit)$sigma
```

```
## [1] 31.84
```

```r
sqrt(sum(resid(fit)^2) / (n - 2))
```

```
## [1] 31.84
```

---
### Total variation = regression variation + residual variation

- The **total variability** in our response is the variability around an intercept
(think mean only regression) $\sum_{i=1}^n (Y_i - \bar Y)^2$
- The **regression variability** is the variability that is explained
by adding the predictor $\sum_{i=1}^n (\hat Y_i - \bar Y)^2$
- The **error variability(residual))** is what's leftover around the
regression line $\sum_{i=1}^n (Y_i - \hat Y_i)^2$
- Neat fact
$$
\sum_{i=1}^n (Y_i - \bar Y)^2 
= \sum_{i=1}^n (Y_i - \hat Y_i)^2 + \sum_{i=1}^n  (\hat Y_i - \bar Y)^2 
$$

---
### R squared

https://www.youtube.com/watch?v=w2FKXOa0HGA

- R squared is the percentage of the **total variability that is
explained by the linear relationship with the predictor**

$$ R^2 =
\frac{\sum_{i=1}^n (\hat Y_i - \bar Y)^2}{\sum_{i=1}^n (Y_i - \bar
Y)^2} $$


**1-R^2 = residual variation(intercept and slope) / total variation
(only intercept (lm(y~1))))** 

R^2 = sum_squared(actual-estimate with
regression)/sum_squared(actual-mean without any regressors) =
1-residvariation/total variation

---

### Some facts about $R^2$
* $R^2$ is the percentage of variation explained by the regression model.
* $0 \leq R^2 \leq 1$
* **$R^2$ is the sample correlation squared. ???**
* $R^2$ can be a **misleading summary of model fit.** Look in the
  **anscombe** library for data and the below subsection!
  * Deleting data can inflate $R^2$.
  * (For later.) Adding terms to a regression model always increases $R^2$.
* Do `example(anscombe)` to see the following data.
  * Basically same mean and variance of X and Y.
  * Identical correlations (hence same $R^2$ ).
  * Same linear regression relationship.

---
### `data(anscombe);example(anscombe)`

```{r, echo = FALSE, fig.height=5, fig.width=5, results='hide'}
require(stats); require(graphics); data(anscombe)
ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  ## or   ff[[2]] <- as.name(paste0("y", i))
  ##      ff[[3]] <- as.name(paste0("x", i))
  mods[[i]] <- lmi <- lm(ff, data = anscombe)
  #print(anova(lmi))
}
```

---

### How to derive R squared (Not required!)
#### For those that are interested
$$
\begin{align}
\sum_{i=1}^n (Y_i - \bar Y)^2 
& = \sum_{i=1}^n (Y_i - \hat Y_i + \hat Y_i - \bar Y)^2 \\
& = \sum_{i=1}^n (Y_i - \hat Y_i)^2 + 
2 \sum_{i=1}^n  (Y_i - \hat Y_i)(\hat Y_i - \bar Y) + 
\sum_{i=1}^n  (\hat Y_i - \bar Y)^2 \\
\end{align}
$$

****
#### Scratch work
$(Y_i - \hat Y_i) = \{Y_i - (\bar Y - \hat \beta_1 \bar X) - \hat \beta_1 X_i\} = (Y_i - \bar Y) - \hat \beta_1 (X_i - \bar X)$

$(\hat Y_i - \bar Y) = (\bar Y - \hat \beta_1 \bar X - \hat \beta_1 X_i - \bar Y )
= \hat \beta_1  (X_i - \bar X)$

$\sum_{i=1}^n  (Y_i - \hat Y_i)(\hat Y_i - \bar Y) 
= \sum_{i=1}^n  \{(Y_i - \bar Y) - \hat \beta_1 (X_i - \bar X))\}\{\hat \beta_1  (X_i - \bar X)\}$

$=\hat \beta_1 \sum_{i=1}^n (Y_i - \bar Y)(X_i - \bar X) -\hat\beta_1^2\sum_{i=1}^n (X_i - \bar X)^2$

$= \hat \beta_1^2 \sum_{i=1}^n (X_i - \bar X)^2-\hat\beta_1^2\sum_{i=1}^n (X_i - \bar X)^2 = 0$


---
### The relation between R squared and r(not required?)
#### (Again not required)
Recall that $(\hat Y_i - \bar Y) = \hat \beta_1  (X_i - \bar X)$
so that
$$
R^2 = \frac{\sum_{i=1}^n  (\hat Y_i - \bar Y)^2}{\sum_{i=1}^n (Y_i - \bar Y)^2}
= \hat \beta_1^2  \frac{\sum_{i=1}^n(X_i - \bar X)^2}{\sum_{i=1}^n (Y_i - \bar Y)^2}
= Cor(Y, X)^2
$$
Since, recall, 
$$
\hat \beta_1 = Cor(Y, X)\frac{Sd(Y)}{Sd(X)}
$$
So, $R^2$ is literally $r$ squared.

## Inference c7-w1
### Recall our model and fitted values
* Consider the model
$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i
$$
* $\epsilon \sim N(0, \sigma^2)$. 

* We assume that the true model is known.
* We assume that you've seen confidence intervals and hypothesis tests before.
* $\hat \beta_0 = \bar Y - \hat \beta_1 \bar X$
* $\hat \beta_1 = Cor(Y, X) \frac{Sd(Y)}{Sd(X)}$.

---
### Review (not required! hypothesis testing and condifence intervals)
* Statistics like $\frac{\hat \theta - \theta}{\hat \sigma_{\hat \theta}}$ often have the following properties.
    1. Is normally distributed and has a finite sample Student's T distribution if the  variance is replaced with a sample estimate (under normality assumptions).
    3. Can be used to test $H_0 : \theta = \theta_0$ versus $H_a : \theta >, <, \neq \theta_0$.
    4. Can be used to create a confidence interval for $\theta$ via $\hat \theta \pm Q_{1-\alpha/2} \hat \sigma_{\hat \theta}$
    where $Q_{1-\alpha/2}$ is the relevant quantile from either a normal or T distribution.
* In the case of regression with iid sampling assumptions and normal errors, our inferences will follow
very similarily to what you saw in your inference class.
* We won't cover asymptotics for regression analysis, but suffice it to say that under assumptions 
on the ways in which the $X$ values are collected, the iid sampling model, and mean model, 
the normal results hold to create intervals and confidence intervals

---
### Results
**Variation of the slope is dependent of \sigma and inversely on
variation of the X**

* $\sigma_{\hat \beta_1}^2 = Var(\hat \beta_1) = \sigma^2 /
  \sum_{i=1}^n (X_i - \bar X)^2$
  
**variation of intercepts**
  
* $\sigma_{\hat \beta_0}^2 = Var(\hat \beta_0)  = \left(\frac{1}{n} +
  \frac{\bar X^2}{\sum_{i=1}^n (X_i - \bar X)^2 }\right)\sigma^2$
  
  
* **In practice, $\sigma$ is replaced by its estimate.**

	
* It's probably not surprising that under iid Gaussian errors
$$
\frac{\hat \beta_j - \beta_j}{\hat \sigma_{\hat \beta_j}}
$$
follows a $t$ distribution with $n-2$ degrees of freedom and a normal distribution for large $n$.
* This can be used to create confidence intervals and perform
hypothesis tests.

---
### Understand output of lm(y~x) table

```r
library(UsingR); data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / (n-2)) 
ssx <- sum((x - mean(x))^2)
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma 
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0; tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)
coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0), c(beta1, seBeta1, tBeta1, pBeta1))
colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("(Intercept)", "x")
```
**t-statistic is computed based on 0 intercept and 0 slope being the
null hypothesis value**

**Residual variation**

	a <- resid(lm(y~x))
	sqrt(sum(a^2)/46)

---
### Manually calculated coefTable compared with lm(y~x)


```r
coefTable
```

```
            Estimate Std. Error t value   P(>|t|)
(Intercept)   -259.6      17.32  -14.99 2.523e-19
x             3721.0      81.79   45.50 6.751e-40
```

```r
fit <- lm(y ~ x); 
summary(fit)$coefficients
```

```
            Estimate Std. Error t value  Pr(>|t|)
(Intercept)   -259.6      17.32  -14.99 2.523e-19
x             3721.0      81.79   45.50 6.751e-40
```

---
### Getting a confidence interval
	
```r
sumCoef <- summary(fit)$coefficients
sumCoef[1,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[1, 2]
```

```
[1] -294.5 -224.8
```

```r
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2]) / 10
```

```
[1] 355.6 388.6
```
With 95% confidence, we estimate that a 0.1 carat increase in
diamond size results in a 355.6 to 388.6 increase in price in (Singapore) dollars.

---
### Prediction of outcomes
* Consider predicting $Y$ at a value of $X$
  * Predicting the price of a diamond given the carat
  * Predicting the height of a child given the height of the parents
* The obvious estimate for prediction at point $x_0$ is 
$$
\hat \beta_0 + \hat \beta_1 x_0
$$
* A standard error is needed to create a prediction interval.
* There's a distinction between intervals for the regression
  line at point $x_0$ and the prediction of what a $y$ would be
  at point $x_0$. 
* Line at $x_0$ se, $\hat \sigma\sqrt{\frac{1}{n} +  \frac{(x_0 - \bar X)^2}{\sum_{i=1}^n (X_i - \bar X)^2}}$
* Prediction interval se at $x_0$, $\hat \sigma\sqrt{1 + \frac{1}{n} + \frac{(x_0 - \bar X)^2}{\sum_{i=1}^n (X_i - \bar X)^2}}$

- There are two things we are interested as part of the prediction
  interval we see in the lm plots with ggplot,

	- The confidence interval for the line itself at x0 keeping in
      mind a population
	  
	- the prediction interval at x0 keeping in mind the population. 

**Prediction variance varies with the following:**

- $\hat \sigma\$; Increases with less R^2 error.

- $\frac{1}{n}$ goes down with more samples! sqrt(1/n) is always part
  of it.

- $\frac{(x_0 - \bar X)^2$; Best prediction when x0 is closest to average

- $\sum_{i=1}^n (X_i - \bar X)^2}$ More variability in the X term
  leads to less variability in the in the interval.

---
### Plotting the prediction intervals and confidence intervals

```{r, fig.height=5, fig.width==5, echo = FALSE, results='hide'}
library(ggplot2)
newx = data.frame(x = seq(min(x), max(x), length = 100))
p1 = data.frame(predict(fit, newdata= newx,interval = ("confidence")))
p2 = data.frame(predict(fit, newdata = newx,interval = ("prediction")))
p1$interval = "confidence"
p2$interval = "prediction"
p1$x = newx$x
p2$x = newx$x
dat = rbind(p1, p2)
names(dat)[1] = "y"
g = ggplot(dat, aes(x = x, y = y))
g = g + geom_ribbon(aes(ymin = lwr, ymax = upr, fill = interval), alpha = 0.2) 
g = g + geom_line()
g = g + geom_point(data = data.frame(x = x, y=y), aes(x = x, y = y), size = 4)
g
```

http://www2.stat.duke.edu/~tjl13/s101/slides/unit6lec3H.pdf

Is very important especially this following line:

> Two type of intervals available:
> - Confidence interval for the average foster twin’s IQ
> - Prediction interval for a single foster twin’s IQ

Average or slope is associated with confidence interval, and
prediction is associated with single or expected value


> A confidence interval gives a range for $\text{E}[y \mid x]$, as you
> say. A prediction interval gives a range for $y$ itself. Naturally,
> our best guess for $y$ is $\text{E}[y \mid x]$, so the intervals
> will both be centered around the same value, $x\hat{\beta}$.


### Predicting with new data

Absolute nonsense with respect to R's way of work!
https://stackoverflow.com/questions/15115909/feeding-newdata-to-r-predict-function

	
	 Note:

     Variables are first looked for in ‘newdata’ and then searched for
     in the usual way (which will include the environment of the
     formula used in the fit).  A warning will be given if the
     variables found are not of the same length as those in ‘newdata’
     if it was supplied.
  
So if you do 
	
	newx <- 3
	predict(fit, newdata=newx, interval=("prediction")) 

This wont work. R is looking for the x variable name in newX

	newx<-data.frame(x=x0)
	predict(fit, newdata=newx, interval=("prediction")) 
	
works! my god!

---
### Discussion an agent and Bcaffo's understanding!

* Both intervals have varying widths.
  * Least width at the mean of the Xs.
* We are quite confident in the regression line, so that 
  interval is very narrow.
  * If we knew $\beta_0$ and $\beta_1$ this interval would have zero width.
* The prediction interval must incorporate the variabilibity
  in the data around the line.
  * Even if we knew $\beta_0$ and $\beta_1$ this interval would still have width.


**Plotting this shows a couple of things:**

- salmon bands are thin and represent the prediction of the line
  itself (confidence)
  
  - the confidence bands are thinner than the prediction bands.
  
- confidence bands (salmon)

	- The confidence bands  show the uncertainty in predicting the
      line itself. If there are more and more points this uncertainty
      would reduce. It is about beta1 the slope. 

	
	- the prediction bands show the uncertainty in predicting Y0. They
      will always exist even when there are a million points as the
      linear regression cannot account for everything.
	  
- they grow smaller at the mean and then become big away from the
  center.
  
---

### In R
```{r, fig.height=5, fig.width=5, echo=FALSE,results='hide'}
newdata <- data.frame(x = xVals)
p1 <- predict(fit, newdata, interval = ("confidence"))
p2 <- predict(fit, newdata, interval = ("prediction"))
plot(x, y, frame=FALSE,xlab="Carat",ylab="Dollars",pch=21,col="black", bg="lightblue", cex=2)
abline(fit, lwd = 2)
lines(xVals, p1[,2]); lines(xVals, p1[,3])
lines(xVals, p2[,2]); lines(xVals, p2[,3])
```
  
### Based on khan academy



## Quiz c7-w2

1. Consider the following data with x as the predictor and y as as the
   outcome. Give a P-value for the two sided hypothesis test of
   whether β1 ​from a linear regression model is 0 or not.
   
		x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
		y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
		
	
		summary(lm(y ~ x))$coef
		
2. Consider the previous problem, give the estimate of the residual
   standard deviation.
   
		summary(lm(y ~ x))$sigma
		
3. In the \verb|mtcars|mtcars data set, fit a linear regression model
   of weight (predictor) on mpg (outcome). Get a 95% confidence
   interval for the **expected mpg** at the average weight. What is the
   lower endpoint?
   
		data(mtcars)
		fit <- lm(mpg ~ I(wt - mean(wt)), data = mtcars)
		confint(fit)
		
		or
		fit <- lm(mpg~wt,data=mtcars)
		predict(fit,newdata=data.frame(wt=mean(df$wt)),
		interval="confidence")
		
4. Refer to the previous question. Read the help file for
   \verb|mtcars|mtcars. What is the weight coefficient interpreted as?
   
   The estimated expected change in mpg per 1,000 lb increase in
   weight.

5. Consider again the \verb|mtcars|mtcars data set and a linear
   regression model with mpg as predicted by weight (1,000 lbs). A new
   car is coming weighing 3000 pounds. Construct a 95% prediction
   interval for its mpg. What is the upper endpoint?
   
		fit <- lm(mpg ~ wt, data = mtcars)
		predict(fit, newdata = data.frame(wt = 3), interval = "prediction")

6. Consider again the \verb|mtcars|mtcars data set and a linear
   regression model with mpg as predicted by weight (in 1,000 lbs). A
   “short” ton is defined as 2,000 lbs. Construct a 95% confidence
   interval for the expected change in mpg per 1 short ton increase in
   weight. Give the lower endpoint.
   
		fit <- lm(mpg ~ wt, data = mtcars)
		confint(fit)[2, ] * 2
		
		fit <- lm(mpg ~ I(wt * 0.5), data = mtcars)
		confint(fit)[2, ]
		
	confint gives info about confidence of the slope and intercept as
    is asked in the question...
	
		            Estimate Std. Error t value Pr(>|t|)    
		(Intercept)   37.285      1.878  19.858  < 2e-16 ***
		x            -10.689      1.118  -9.559 1.29e-10 ***
		
		
		-10.689+ c(1,-1)*1.118* qt(0.975,30) gives the same values!
		
		
7. If my X from a linear regression is measured in centimeters and I
   convert it to meters what would happen to the slope coefficient?
   
		It would get multiplied by 100

8. I have an outcome, YY, and a predictor, XX and fit a linear
   regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would
   be the consequence to the subsequent slope and intercept if I were
   to refit the model with a new regressor, X + cX+c for some
   constant, cc?
   
   The new intercept would be β^0−cβ^1
   
9. Refer back to the mtcars data set with mpg as an outcome and weight
   (wt) as the predictor. About what is the ratio of the the sum of
   the squared errors, ∑ni=1(Yi−Y^i)2 when comparing a model with just
   an intercept (denominator) to the model with the intercept and
   slope (numerator)?
   
   
		fit1 <- lm(mpg ~ wt, data = mtcars)
		fit2 <- lm(mpg ~ 1, data = mtcars)
		1 - summary(fit1)$r.squared
		
		
		sse1 <- sum((predict(fit1) - mtcars$mpg)^2)
		sse2 <- sum((predict(fit2) - mtcars$mpg)^2)
		sse1/sse2

10. Do the residuals always have to sum to 0 in linear regression?

	If an intercept is included, then they will sum to 0


3, ~~6~~ except for Xa and beta/a, 7, and 5 with the confidence intervals are quite a mistery!

### Summary of inference

There seem to be 3 confidence intervals:

1. Confint of slope

	Can be found from `confint(fit)` or from summary of fit

		fit <- lm(mpg ~ I(wt * 0.5), data = mtcars)
		confint(fit)[2, ]
			
		OR
		
		            Estimate Std. Error t value Pr(>|t|)    
		(Intercept)   37.285      1.878  19.858  < 2e-16 ***
		x            -10.689      1.118  -9.559 1.29e-10 ***
		
		
		-10.689+ c(1,-1)*1.118* qt(0.975,30) gives the same values!

2. Conf interval of expected value (aka, average)

	This is when you want to find the variation of the avg of Y at an
    x\_i
	
	This can be found with predict variable, but sometimes also with
    confint which is confusing to me. The relation between expected
    value and slope is not clear!
	
	
		data(mtcars)
		fit <- lm(mpg ~ I(wt - mean(wt)), data = mtcars)
		confint(fit)
		
		or
		fit <- lm(mpg~wt,data=mtcars)
		predict(fit,newdata=data.frame(wt=mean(df$wt)),
		interval="confidence")
		
	*I don't get the difference but whatever*

3. Prediction interval for the actual value of Y and not the expected
   value
   
		fit <- lm(mpg ~ wt, data = mtcars)
		predict(fit, newdata = data.frame(wt = 3), interval = "prediction")


This is it! for now. As needed we can go into depths!

**Note**

Ths summary of fit gives a lot of info. The t.value is the value under
the null hypothesis and not the 95% confidence interval thingy!

		            Estimate Std. Error t value Pr(>|t|)    
		(Intercept)   37.285      1.878  19.858  < 2e-16 ***
		x            -10.689      1.118  -9.559 1.29e-10 ***


That about sums it up! Cheers!


## c7-w3 multivariate regression

### Multivariable regression analyses Why?
* If I were to present evidence of a relationship between breath mint
useage (mints per day, X) and pulmonary function (measured in FEV),
you would be skeptical.
  * Likely, you would say, 'smokers tend to use more breath mints than
    non smokers, smoking is related to a loss in pulmonary
    function. That's probably the culprit.'
  * If asked what would convince you, you would likely say, 'If
    non-smoking breath mint users had lower lung function than
    non-smoking non-breath mint users and, similarly, if smoking
    breath mint users had lower lung function than smoking non-breath
    mint users, I'd be more inclined to believe you'.
* In other words, to even consider my results, I would have to
  demonstrate that they hold while holding smoking status fixed.

---
### Multivariable regression analyses Why people are interested?
* An insurance company is interested in how last year's claims can
  predict a person's time in the hospital this year.
  * They want to use an enormous amount of data contained in claims to
    predict a single number. Simple linear regression is not equipped
    to handle more than one predictor.
* How can one generalize SLR to incoporate lots of regressors for the
purpose of prediction?
* What are the consequences of adding lots of regressors? 

  * Surely there must be consequences to throwing variables in that
    aren't related to Y?
  * Surely there must be consequences to omitting variables that are?


**With sufficient random vectors you can come up with 0 residuals**

---
### The linear model Equations

* The general linear model extends simple linear regression (SLR) by
adding terms linearly into the model.  $$ Y_i = \beta_1 X_{1i} +
\beta_2 X_{2i} + \ldots + \beta_{p} X_{pi} + \epsilon_{i} =
\sum_{k=1}^p X_{ik} \beta_j + \epsilon_{i} $$

	**Outcome = Predictor * coefficients**

* Here $X_{1i}=1$ typically, so that an intercept is included.



* **Least squares** (and hence ML estimates under iid Gaussianity of
the errors) minimizes

	**$$ \sum_{i=1}^n \left(Y_i - \sum_{k=1}^p X_{ki} \beta_j\right)^2
$$**

	**Minimizing overall error by looking at error at each point 'i',
    and over** 


* Note, the important linearity is linearity in the coefficients.
Thus $$ Y_i = \beta_1 X_{1i}^2 + \beta_2 X_{2i}^2 + \ldots + \beta_{p}
X_{pi}^2 + \epsilon_{i} $$ is still a linear model. (We've just
squared the elements of the predictor variables.)

	**Whether the same beta holds when you square the variable, am not
sure! but moving on!** 

---

### How to get estimates Expected values Least squares!

* Recall that the LS estimate for regression through the origin,
  $E[Y_i]=X_{1i}\beta_1$, was $\sum X_i Y_i / \sum X_i^2$.
* Let's consider two regressors, $E[Y_i] = X_{1i}\beta_1 +
  X_{2i}\beta_2 = \mu_i$.


*** Least squares tries to minimize**

	$$ \sum_{i=1}^n (Y_i - X_{1i} \beta_1 - X_{2i} \beta_2)^2 $$

---
### Result

$$\hat \beta_1 = \frac{\sum_{i=1}^n e_{i, Y | X_2} e_{i, X_1 |
X_2}}{\sum_{i=1}^n e_{i, X_1 | X_2}^2}$$


* **That is, the regression estimate for $\beta_1$ is the regression
through the origin estimate having regressed $X_2$ out of both the
response and the predictor.**

	**What does this even mean?**
	
* (Similarly, the regression estimate for $\beta_2$ is the regression
  through the origin estimate having regressed $X_1$ out of both the
  response and the predictor.)
* More generally, multivariate regression estimates are exactly those
having removed the linear relationship of the other variables from
both the regressor and response.

---
### Example with two variables, simple linear regression (**important**)


* $Y_{i} = \beta_1 X_{1i} + \beta_2 X_{2i}$ where **$X_{2i} = 1$ is an
  intercept term.**
  
  Think of X2 as the number of people who smoke, you fix it at 1
  person smoking (aka the intercept term!)
  
* Notice the fitted coefficient of $X_{2i}$ on $Y_{i}$ is $\bar Y$
    * The residuals $e_{i, Y | X_2} = Y_i - \bar Y$
	
* Notice the fitted coefficient of $X_{2i}$ on $X_{1i}$ is $\bar X_1$
    * The residuals $e_{i, X_1 | X_2}= X_{1i} - \bar X_1$
	
* Thus $$ \hat \beta_1 = \frac{\sum_{i=1}^n e_{i, Y | X_2} e_{i, X_1 |
X_2}}{\sum_{i=1}^n e_{i, X_1 | X_2}^2} = \frac{\sum_{i=1}^n (X_i -
\bar X)(Y_i - \bar Y)}{\sum_{i=1}^n (X_i - \bar X)^2} = Cor(X, Y)
\frac{Sd(Y)}{Sd(X)} $$

- choose an intercept value for X2?

- get rid of X2 by centering Y and X

- compute the "origin intercept lm" for yc~xc, 

I don't get it though!

- and same beta formula with correlation

---
### The general case
* Least squares solutions have to minimize $$ \sum_{i=1}^n (Y_i -
X_{1i}\beta_1 - \ldots - X_{pi}\beta_p)^2 $$
* The least squares estimate for the coefficient of a multivariate
  regression model is exactly regression through the origin with the
  linear relationships with the other regressors removed from both the
  regressor and outcome by taking residuals.?????????????
* In this sense, multivariate regression "adjusts" a coefficient for
  the linear impact of the other variables.

beta 1 -> All the variable from X2 to Xp have been "linearly" removed
from Y and X1

---

### Demonstration that it works using an example
#### Linear model with two variables
```{r}
n = 100; x = rnorm(n); x2 = rnorm(n); x3 = rnorm(n)
y = 1 + x + x2 + x3 + rnorm(n, sd = .1)
ey = resid(lm(y ~ x2 + x3))
ex = resid(lm(x ~ x2 + x3))
sum(ey * ex) / sum(ex ^ 2)
coef(lm(ey ~ ex - 1))
coef(lm(y ~ x + x2 + x3)) 
```

So what you do is remove x2 and x3 aka, take residuals from a fit on
them. This way the residuals ey and ex are without x2 and x3
contribution. and why we then do **-1** is beyond me!


---
### Interpretation of the coeficients
$$E[Y | X_1 = **x_1**, \ldots, X_p = x_p] = \sum_{k=1}^p x_{k}
\beta_k$$

$$ E[Y | X_1 = **x_1 + 1**, \ldots, X_p = x_p] = (x_1 + 1) \beta_1 +
\sum_{k=2}^p x_{k} \beta_k $$

$$ **E[Y**| X_1 = **x_1 + 1**, \ldots, X_p = x_p] **-** **E[Y |** X_1
= **x_1**, \ldots, X_p = x_p]$$ $$= (x_1 + 1) \beta_1 + \sum_{k=2}^p
x_{k} \beta_k + \sum_{k=1}^p x_{k} \beta_k **= \beta_1** $$

**So that the interpretation of a multivariate regression coefficient is
the expected change in the response per unit change in the regressor,
holding all of the other regressors fixed.**

In the next lecture, we'll do examples and go over context-specific
interpretations.

---
### Fitted values, residuals and residual variation
All of our SLR quantities can be extended to linear models
* Model $Y_i = \sum_{k=1}^p X_{ik} \beta_{k} + \epsilon_{i}$ where
  $\epsilon_i \sim N(0, \sigma^2)$
* Fitted responses $\hat Y_i = \sum_{k=1}^p X_{ik} \hat \beta_{k}$
* Residuals $e_i = Y_i - \hat Y_i$
* Variance estimate $\hat \sigma^2 = \frac{1}{n-p} \sum_{i=1}^n e_i
  ^2$
* To get predicted responses at new values, $x_1, \ldots, x_p$, simply
  plug them into the linear model $\sum_{k=1}^p x_{k} \hat \beta_{k}$
* Coefficients have standard errors, $\hat \sigma_{\hat \beta_k}$, and
$\frac{\hat \beta_k - \beta_k}{\hat \sigma_{\hat \beta_k}}$ follows a
$T$ distribution with $n-p$ degrees of freedom.
* Predicted responses have standard errors and we can calculate
  predicted and expected response intervals.

---
### Linear models
* Linear models are the single most important applied statistical and
  machine learning techniqe, *by far*.
* Some amazing things that you can accomplish with linear models
  * Decompose a signal into its harmonics.
  * Flexibly fit complicated functions.
  * Fit factor variables as predictors.
  * Uncover complex multivariate relationships with the response.
  * Build accurate prediction models.
## Multivariate examples (c7-w3)
### Data set for discussion 
#### `require(datasets); data(swiss); ?swiss`
Standardized fertility measure and socio-economic indicators for each of 47 French-speaking provinces of Switzerland at about 1888.

A data frame with 47 observations on 6 variables, each of which is in percent, i.e., in [0, 100].

* [,1]   Fertility          a common standardized fertility measure
* [,2]   Agriculture        % of males involved in agriculture as occupation
* [,3]	 Examination        % draftees receiving highest mark on army examination
* [,4]	 Education          % education beyond primary school for draftees
* [,5]	 Catholic           % catholic (as opposed to protestant)
* [,6]	 Infant.Mortality   live births who live less than 1 year

All variables but Fertility give proportions of the population.

---

**Nice plot that shows all variations**

```{r, fig.height=6, fig.width=10, echo = FALSE}
require(datasets); data(swiss); require(GGally); require(ggplot2)
g = ggpairs(swiss, lower = list(continuous = "smooth"),params = c(method = "loess"))
g
```

---

### Calling `lm` for all variables "lm(y~.)"

`summary(lm(Fertility ~ . , data = swiss))`

```{r, echo = FALSE}
summary(lm(Fertility ~ . , data = swiss))$coefficients
```
Agriculture -0.17 slope without the contributions of other variables!

---
### Example interpretation (importance of removing variables)

* Agriculture is expressed in percentages (0 - 100)
* **Estimate is -0.1721.**
* Our models estimates an expected 0.17 decrease in standardized
  fertility for every 1% increase in percentage of males involved in
  agriculture in holding the remaining variables constant.
* The t-test for $H_0: \beta_{Agri} = 0$ versus $H_a: \beta_{Agri} \neq 0$ is  significant.
* Interestingly, the unadjusted estimate is 

```{r}
summary(lm(Fertility ~ Agriculture, data = swiss))$coefficients
```

**0.19**

"If there hasn't been randomization to protect you from the founding
you are going to have to come up with a dynamic process of choosing
which variables etc..."

---
**How can adjustment reverse the sign of an effect? Let's try a
simulation.**

```{r, echo = TRUE}
n <- 100; x2 <- 1 : n; x1 <- .01 * x2 + runif(n, -.1, .1); y = -x1 + x2 + rnorm(n, sd = .01)
summary(lm(y ~ x1))$coef
summary(lm(y ~ x1 + x2))$coef
```

**First output coeff is 95 instead of "-1". Quite a blunder! The linear
model is picking up on the large contribution of x2 on Y and making
its own fit which is absolutely not correct. x2 is uniform noise which
spikes up the value of x1**

---

**Plot of y vs x1 and x2 to see all trends in one image!**

Does show the "fake relationship" between y and x1, we also see how y
is dependent on x2 and x1 is dependent on x2.

```{r, echo = FALSE, fig.height=5, fig.width=10, results = 'show'}
dat = data.frame(y = y, x1 = x1, x2 = x2, ey = resid(lm(y ~ x2)), ex1
= resid(lm(x1 ~ x2)))

library(ggplot2)
g = ggplot(dat, aes(y = y, x = x1, colour = x2))
g = g + geom_point(colour="grey50", size = 5) + geom_smooth(method = lm, se = FALSE, colour = "black") 
g = g + geom_point(size = 4) 
g
```

So we need to remove the effect of x2 from both y and x1 i.e., by
taking the residual, which is the left over data.
```{r, echo = FALSE, fig.height=5, fig.width=10, results = 'show'}
g2 = ggplot(dat, aes(y = ey, x = ex1, colour = x2))  
g2 = g2 + geom_point(colour="grey50", size = 5) + geom_smooth(method = lm, se = FALSE, colour = "black") + geom_point(size = 4) 
g2
```

It is very clear with this plot that, x2 is now properly randomized
and the true relationship pops out.

---
	
### Back to this data set
* The sign reverses itself with the inclusion of Examination and
  Education.
* The percent of males in the province working in agriculture is
  negatively related to educational attainment (correlation of `r
  cor(swiss$Agriculture, swiss$Education)`) and Education and
  Examination (correlation of `r cor(swiss$Education,
  swiss$Examination)`) are obviously measuring similar things.
  * Is the positive marginal an artifact for not having accounted for,
    say, Education level? (Education does have a stronger effect, by
    the way.)
* At the minimum, anyone claiming that provinces that are more
  agricultural have higher fertility rates would immediately be open
  to criticism.

---
### What if we include an unnecessary variable?
z adds no new linear information, since it's a linear
combination of variables already included. R just drops 
terms that are linear combinations of other terms.
```{r, echo = TRUE}
z <- swiss$Agriculture + swiss$Education
lm(Fertility ~ . + z, data = swiss)
```

When Z is a linear combination of other variables then you get NA when
you remove the components of z to do lm(y~z).

---
### Dummy variables are smart


* Consider the linear model $$ Y_i = \beta_0 + X_{i1} \beta_1 +
\epsilon_{i} $$ where each **$X_{i1}$ is binary** so that it is a 1 if
measurement $i$ is in a group and 0 otherwise. (Treated versus not in
a clinical trial, for example.)
* Then for people in the group $E[Y_i] = \beta_0 + \beta_1$
* And for people not in the group $E[Y_i] = \beta_0$
* The LS fits work out to be $\hat \beta_0 + \hat \beta_1$ is the mean
  for those in the group and $\hat \beta_0$ is the mean for those not
  in the group.
* $\beta_1$ is interpretted as the increase or decrease in the mean
  comparing those in the group to those not.
* Note including a binary variable that is 1 for those not in the
  group would be redundant. It would create three parameters to
  describe two means. ???
  
- basically we can lm binary factor variables too!  They give means
and change compared to the lower group!

---
### More than 2 levels

* Consider a multilevel factor level. For didactic reasons, let's say
  a three level factor (example, US political party affiliation:
  Republican, Democrat, Independent)
* $Y_i = \beta_0 + X_{i1} \beta_1 + X_{i2} \beta_2 + \epsilon_i$.
* $X_{i1}$ is 1 for Republicans and 0 otherwise.
* $X_{i2}$ is 1 for Democrats and 0 otherwise.
* If $i$ is Republican $E[Y_i] = \beta_0 +\beta_1$
* If $i$ is Democrat $E[Y_i] = \beta_0 + \beta_2$.
* If $i$ is Independent $E[Y_i] = \beta_0$.
* $\beta_1$ compares Republicans to Independents.
* $\beta_2$ compares Democrats to Independents.
* $\beta_1 - \beta_2$ compares Republicans to Democrats.
* (Choice of reference category changes the interpretation.)

**Warning:**What you choose as your reference somehow has big effect on how you
interpret! What does it mean? maybe the examples show more info!


---
### Insect Sprays (Understanding factors and dummy variables!)
```{r, echo = FALSE, fig.height=5, fig.width=5}
require(datasets);data(InsectSprays); require(stats); require(ggplot2)
g = ggplot(data = InsectSprays, aes(y = count, x = spray, fill  = spray))
g = g + geom_violin(colour = "black", size = 2)
g = g + xlab("Type of spray") + ylab("Insect count")
g
```

```
            Estimate Std. Error t value  Pr(>|t|)
(Intercept)  14.5000      1.132 12.8074 1.471e-19
sprayB        0.8333      1.601  0.5205 6.045e-01
sprayC      -12.4167      1.601 -7.7550 7.267e-11
sprayD       -9.5833      1.601 -5.9854 9.817e-08
sprayE      -11.0000      1.601 -6.8702 2.754e-09
sprayF        2.1667      1.601  1.3532 1.806e-01
```

Spray is missing as it is the reference B0 with mean of 14.5 and
everything else is compared to it, i.e., mean of spray b is 14.5+0.833
etc...

Spray A is the dummy variable!

---
#### Linear model fit, group A is the reference
```{r, echo= TRUE}
summary(lm(count ~ spray, data = InsectSprays))$coef
```

---
#### Hard coding the dummy variables
```{r, echo= TRUE}
summary(lm(count ~ 
             I(1 * (spray == 'B')) + I(1 * (spray == 'C')) + 
             I(1 * (spray == 'D')) + I(1 * (spray == 'E')) +
             I(1 * (spray == 'F'))
           , data = InsectSprays))$coef
```

---
#### What if we include all 6?
```{r, echo= TRUE}
summary(lm(count ~ 
   I(1 * (spray == 'B')) + I(1 * (spray == 'C')) +  
   I(1 * (spray == 'D')) + I(1 * (spray == 'E')) +
   I(1 * (spray == 'F')) + I(1 * (spray == 'A')), data = InsectSprays))$coef
```

---
#### What if we omit the intercept?
```{r, echo= TRUE}
summary(lm(count ~ spray - 1, data = InsectSprays))$coef
library(dplyr)
summarise(group_by(InsectSprays, spray), mn = mean(count))
```
When you omit the intercept its all about 0. All the P values and t
statistics are about a null hypothesis 0 instead of spray A.

---
### Reordering the levels
```{r}
spray2 <- relevel(InsectSprays$spray, "C")
summary(lm(count ~ spray2, data = InsectSprays))$coef
```

---

#### Summary
* If we treat Spray as a factor, R includes an intercept and omits the alphabetically first level of the factor.
  * All t-tests are for comparisons of Sprays versus Spray A.
  * Emprirical mean for A is the intercept.
  * Other group means are the itc plus their coefficient. 
* If we omit an intercept, then it includes terms for all levels of the factor. 
  * Group means are the coefficients. 
  * Tests are tests of whether the groups are different than zero. (Are the expected counts zero for that spray.)
* If we want comparisons between, Spray B and C, say we could refit the model with C (or B) as the reference level. 


---
### Other thoughts on this data
* Counts are bounded from below by 0, violates the assumption of normality of the errors. 
  * Also there are counts near zero, so both the actual assumption and the intent of the assumption are violated.
* Variance does not appear to be constant.
* Perhaps taking logs of the counts would help. 
  * There are 0 counts, so maybe log(Count + 1)
* Also, we'll cover Poisson GLMs for fitting count data.

---

### Modelling the data as b0+b1X1+b2X2 and b0+...+b3X1X2

Two types of modelling is possible leading to either 

one intercept and one slope

or

2 intercepts and 2 different slopes

#### Recall the `swiss` data set

```{r}
library(datasets); data(swiss)
head(swiss)
```

---
#### Create a binary variable
```{r}
library(dplyr); 
swiss = mutate(swiss, CatholicBin = 1 * (Catholic > 50))
```

---
#### Plot the data 

```{r, fig.height=5, fig.width=8, echo = FALSE}
g = ggplot(swiss, aes(x = Agriculture, y = Fertility, colour = factor(CatholicBin)))
g = g + geom_point(size = 6, colour = "black") + geom_point(size = 4)
g = g + xlab("% in Agriculture") + ylab("Fertility")
g
```

---
#### No effect of religion
```{r, echo = TRUE}
summary(lm(Fertility ~ Agriculture, data = swiss))$coef
```

---
#### The associated fitted line
```{r, echo = FALSE, fig.width=8, fig.height=5}
fit = lm(Fertility ~ Agriculture, data = swiss)
g1 = g
g1 = g1 + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2], size = 2)
g1
```


---
#### Parallel lines, i.e., same slope different intercepts (using +)
```{r, echo = TRUE}
summary(lm(Fertility ~ Agriculture + factor(CatholicBin), data = swiss))$coef
```

```{r, echo = FALSE, fig.width=5, fig.height=4}
fit = lm(Fertility ~ Agriculture + factor(CatholicBin), data = swiss)
g1 = g
g1 = g1 + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2], size = 2)
g1 = g1 + geom_abline(intercept = coef(fit)[1] + coef(fit)[3], slope = coef(fit)[2], size = 2)
g1
```

1. b0 + b1 X + b2 *0
2. b0 + b1 X + b2 *1

---
#### Lines with different slopes and intercepts (using * instead of +)

```{r, echo = TRUE}
summary(lm(Fertility ~ Agriculture * factor(CatholicBin), data = swiss))$coef
```

```{r, echo = FALSE, fig.width=5, fig.height=4}
fit = lm(Fertility ~ Agriculture * factor(CatholicBin), data = swiss)
g1 = g
g1 = g1 + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2], size = 2)
g1 = g1 + geom_abline(intercept = coef(fit)[1] + coef(fit)[3], 
                          slope = coef(fit)[2] + coef(fit)[4], size = 2)
g1
```

---
#### Just to show you it can be done
```{r, echo = TRUE}
summary(lm(Fertility ~ Agriculture + Agriculture : factor(CatholicBin), data = swiss))$coef
```
## adjustment (playing with different variables in lm) c7-w3

### Consider the following simulated data
Code for the first plot, rest omitted
(See the git repo for the rest of the code.)
```
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), runif(n/2));
beta0 <- 0; beta1 <- 2; tau <- 1; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```


---
### Simulation 1
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), runif(n/2));
beta0 <- 0; beta1 <- 2; tau <- 1; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```

---
### Discussion
#### Some things to note in this simulation
* The X variable is unrelated to group status
* The X variable is related to Y, but the intercept depends
  on group status.
* The group variable is related to Y.
  * The relationship between group status and Y is constant depending on X.
  * The relationship between group and Y disregarding X is about the same as holding X constant

---
### Simulation 2
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), 1.5 + runif(n/2));
beta0 <- 0; beta1 <- 2; tau <- 0; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```


---
### Discussion
#### Some things to note in this simulation
* The X variable is highly related to group status
* The X variable is related to Y, the intercept
  doesn't depend on the group variable.
  * The X variable remains related to Y holding group status constant
* The group variable is marginally related to Y disregarding X.
* The model would estimate no adjusted effect due to group.
  * There isn't any data to inform the relationship between
    group and Y.
  * This conclusion is entirely based on the model.

---
### Simulation 3
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), .9 + runif(n/2));
beta0 <- 0; beta1 <- 2; tau <- -1; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```

---
### Discussion
#### Some things to note in this simulation
* Marginal association has red group higher than blue.
* Adjusted relationship has blue group higher than red.
* Group status related to X.
* There is some direct evidence for comparing red and blue
holding X fixed.



---
### Simulation 4
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(.5 + runif(n/2), runif(n/2));
beta0 <- 0; beta1 <- 2; tau <- 1; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```

---
### Discussion
#### Some things to note in this simulation
* No marginal association between group status and Y.
* Strong adjusted relationship.
* Group status not related to X.
* There is lots of direct evidence for comparing red and blue
holding X fixed.

---
### Simulation 5
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2, -1, 1), runif(n/2, -1, 1));
beta0 <- 0; beta1 <- 2; tau <- 0; tau1 <- -4; sigma <- .2
y <- beta0 + x * beta1 + t * tau + t * x * tau1 + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t + I(x * t))
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2] + coef(fit)[4], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)
```

---
### Discussion
#### Some things to note from this simulation
* There is no such thing as a group effect here.
  * The impact of group reverses itself depending on X.
  * Both intercept and slope depends on group.
* Group status and X unrelated.
  * There's lots of information about group effects holding X fixed.

---
#### Simulation 6
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
p <- 1
n <- 100; x2 <- runif(n); x1 <- p * runif(n) - (1 - p) * x2
beta0 <- 0; beta1 <- 1; tau <- 4 ; sigma <- .01
y <- beta0 + x1 * beta1 + tau * x2 + rnorm(n, sd = sigma)
plot(x1, y, type = "n", frame = FALSE)
abline(lm(y ~ x1), lwd = 2)
co.pal <- heat.colors(n)
points(x1, y, pch = 21, col = "black", bg = co.pal[round((n - 1) * x2 + 1)], cex = 2)
```

---
#### Do this to investigate the bivariate relationship
```
library(rgl)
plot3d(x1, x2, y)
```

---
#### Residual relationship
```{r, fig.height=5, fig.width=5, echo = FALSE, results='hide'}
plot(resid(lm(x1 ~ x2)), resid(lm(y ~ x2)), frame = FALSE, col = "black", bg = "lightblue", pch = 21, cex = 2)
abline(lm(I(resid(lm(x1 ~ x2))) ~ I(resid(lm(y ~ x2)))), lwd = 2)
```


---
### Discussion
#### Some things to note from this simulation

* X1 unrelated to X2
* X2 strongly related to Y
* Adjusted relationship between X1 and Y largely unchanged
  by considering X2.
  * Almost no residual variability after accounting for X2.

---
### Some final thoughts
* Modeling multivariate relationships is difficult.
* Play around with simulations to see how the
  inclusion or exclusion of another variable can
  change analyses.
* The results of these analyses deal with the
impact of variables on associations.
  * Ascertaining mechanisms or cause are difficult subjects
    to be added on top of difficulty in understanding multivariate associations.
© 
## Diagnostics c7-w3

### The linear model
* Specified as $Y_i =  \sum_{k=1}^p X_{ik} \beta_j + \epsilon_{i}$
* We'll also assume here that $\epsilon_i \stackrel{iid}{\sim} N(0, \sigma^2)$
* Define the residuals as
$e_i = Y_i -  \hat Y_i =  Y_i - \sum_{k=1}^p X_{ik} \hat \beta_j$
* Our estimate of residual variation is $\hat \sigma^2 = \frac{\sum_{i=1}^n e_i^2}{n-p}$, the $n-p$ so that $E[\hat \sigma^2] = \sigma^2$

---
```{r, fig.height = 5, fig.width = 5}
data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ . , data = swiss); plot(fit)
```

---
### Influential, high leverage and outlying points
```{r, fig.height = 5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; x <- rnorm(n); y <- x + rnorm(n, sd = .3)
plot(c(-3, 6), c(-3, 6), type = "n", frame = FALSE, xlab = "X", ylab = "Y")
abline(lm(y ~ x), lwd = 2)
points(x, y, cex = 2, bg = "lightblue", col = "black", pch = 21)
points(0, 0, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(0, 5, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(5, 5, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(5, 0, cex = 2, bg = "darkorange", col = "black", pch = 21)
```

---
### Summary of the plot
Calling a point an outlier is vague. 
  * Outliers can be the result of spurious or real processes.
  * Outliers can have varying degrees of influence.
  * Outliers can conform to the regression relationship (i.e being marginally outlying in X or Y, but not outlying given the regression relationship).
* Upper left hand point has low leverage, low influence, outlies in a way not conforming to the regression relationship.
* Lower left hand point has low leverage, low influence and is not to be an outlier in any sense.
* Upper right hand point has high leverage, but chooses not to extert it and thus would have low actual influence by conforming to the regresison relationship of the other points.
* Lower right hand point has high leverage and would exert it if it were included in the fit.

---
### Influence measures of points! of data not variables
* Do `?influence.measures` to see the full suite of influence measures
  in stats. The measures include
  * `rstandard` - standardized residuals, residuals divided by their
    standard deviations)
  * `rstudent` - standardized residuals, residuals divided by their
    standard deviations, where the ith data point was deleted in the
    calculation of the standard deviation for the residual to follow a
    t distribution
  * `hatvalues` - measures of leverage
  * `dffits` - change in the predicted response when the $i^{th}$
    point is deleted in fitting the model. **one data for one point**.
  * `dfbetas` - change in **individual coefficients** when the $i^{th}$
    point is deleted in fitting the model.
  * `cooks.distance` - overall change in teh coefficients when the
    $i^{th}$ point is deleted.
  * `resid` - returns the ordinary residuals
  * `resid(fit) / (1 - hatvalues(fit))` where `fit` is the linear
    model fit returns the PRESS residuals, i.e. the leave one out
    cross validation residuals - the difference in the response and
    the predicted response at data point $i$, where it was not
    included in the model fitting.

---
### How do I use all of these things?
* Be wary of simplistic rules for diagnostic plots and measures. The
  use of these tools is context specific. It's better to understand
  what they are trying to accomplish and use them judiciously.
* Not all of the measures have meaningful absolute scales. You can
  look at them relative to the values across the data.
* They probe your data in different ways to diagnose different
  problems.
* Patterns in your residual plots generally indicate some poor aspect
  of model fit. These can include:
  * Heteroskedasticity (non constant variance).
  * Missing model terms.
  * Temporal patterns (plot residuals versus collection order).
* Residual QQ plots investigate normality of the errors.
* Leverage measures (hat values) can be useful for diagnosing data
  entry errors.
* Influence measures get to the bottom line, 'how does deleting or
  including this point impact a particular aspect of the model'.


**Plot residual vs fitted values** to check for systematic patterns
that you are missing

---


### Case 1
```{r, fig.height=5, fig.width=5, echo=FALSE}
x <- c(10, rnorm(n)); y <- c(10, c(rnorm(n)))
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
abline(lm(y ~ x))            
```

---
### The code
```
n <- 100; x <- c(10, rnorm(n)); y <- c(10, c(rnorm(n)))
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
abline(lm(y ~ x))            
```
* The point `c(10, 10)` has created a strong regression relationship where there shouldn't be one.

---
### Showing a couple of the diagnostic values
```{r}
fit <- lm(y ~ x)
round(dfbetas(fit)[1 : 10, 2], 3)
round(hatvalues(fit)[1 : 10], 3)
```

---
### Case 2
```{r, fig.height=5, fig.width=5, echo=FALSE}
x <- rnorm(n); y <- x + rnorm(n, sd = .3)
x <- c(5, x); y <- c(5, y)
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
fit2 <- lm(y ~ x)
abline(fit2)            
```

---
### Looking at some of the diagnostics
```{r, echo = TRUE}
round(dfbetas(fit2)[1 : 10, 2], 3)
round(hatvalues(fit2)[1 : 10], 3)
```

---
### Example described by Stefanski TAS 2007 Vol 61.
```{r, fig.height=4, fig.width=4}
## Don't everyone hit this server at once.  Read the paper first.
dat <- read.table('http://www4.stat.ncsu.edu/~stefanski/NSF_Supported/Hidden_Images/orly_owl_files/orly_owl_Lin_4p_5_flat.txt', header = FALSE)
pairs(dat)
```

---
### Got our P-values, should we bother to do a residual plot?
```{r}
summary(lm(V1 ~ . -1, data = dat))$coef
```
Residual plots zoom in on poor model fits, they show ys how much we
have covered the systematic part. Run the above to see more!

---
### Residual plot
#### P-values significant, O RLY?
```{r, fig.height=4, fig.width=4, echo = TRUE}
fit <- lm(V1 ~ . - 1, data = dat); plot(predict(fit), resid(fit), pch = '.')
```

Shows how bad the fit is as we completely missed the systematic
patterns!

---
### Back to the Swiss data
```{r, fig.height = 5, fig.width = 5, echo=FALSE}
data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ . , data = swiss); plot(fit)
```
## Multiple variables regression (c7-w3)

### Multivariable regression
* We have an entire class on prediction and machine learning, so we'll
  focus on modeling.
  * Prediction has a different set of criteria, needs for
    interpretability and standards for generalizability.
  * In modeling, our interest lies in parsimonious, interpretable
    representations of the data that enhance our understanding of the
    phenomena under study.
  * A model is a lense through which to look at your data. (I
    attribute this quote to Scott Zeger)
  * Under this philosophy, what's the right model? Whatever model
    connects the data to a true, parsimonious statement about what
    you're studying.
* There are nearly uncountable ways that a model can be wrong, in this
  lecture, we'll **focus on variable inclusion and exclusion**.
* Like nearly all aspects of statistics, good modeling decisions are
  context dependent.
  * **A good model for prediction versus one for studying mechanisms
    versus one for trying to establish causal effects may not be the
    same.** if only I could gve an example!

---
### The Rumsfeldian triplet

*There are known knowns. These are things we know that we know. There
are known unknowns. That is to say, there are things that we know we
don't know. But there are also unknown unknowns. There are things we
don't know we don't know.* Donald Rumsfeld

In our context
* (Known knowns) Regressors that we know we should check to include in
  the model and have.
* (Known Unknowns) Regressors that we would like to include in the
  model, but don't have.
* (Unknown Unknowns) Regressors that we don't even know about that we
  should have included in the model.

---
### General rules (very important!)
* **Omitting variables results in bias** in the coeficients of
  interest - unless their regressors are uncorrelated with the omitted
  ones.
  * **This is why we randomize treatments, it attempts to uncorrelate
    our treatment indicator with variables that we don't have to put
    in the model.** **WE need to make out own example for this one!
    during writing** Thats why AB testing and clinical trials are so
    powerful. but if there are too many confounding things then even
    randomization is not going to help you!
	
  * (If there's too many unobserved confounding variables, even
    randomization won't help you.)
* **Including variables that we shouldn't have increases standard errors
  of the regression variables.** No BIAS!!!!!!
  * Actually, including any **new variables increasese** (actual, not
    estimated) **standard errors** of other regressors. So we don't
    want to idly throw variables into the model.
* The model must tend toward perfect fit as the number of
  non-redundant regressors approaches $n$.
* **$R^2$ increases monotonically as more regressors are included.**
* The SSE decreases monotonically as more regressors are included.

Need to check these out!

---
### Plot of $R^2$ versus $n$
For simulations as the number of variables included equals increases to $n=100$. 
No actual regression relationship exist in any simulation
```{r, fig.height=5, fig.width=5, echo=FALSE}
 n <- 100
plot(c(1, n), 0 : 1, type = "n", frame = FALSE, xlab = "p", ylab = "R^2")
r <- sapply(1 : n, function(p)
      {
        y <- rnorm(n); x <- matrix(rnorm(n * p), n, p)
        summary(lm(y ~ x))$r.squared 
      }
    )
lines(1 : n, r, lwd = 2)
abline(h = 1)
```
Awesome! shows exactly what the problem is during my DP sessions!

---
### Variance inflation; all three are rnormed; including variables!
```{r, echo = TRUE}
n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- rnorm(n); x3 <- rnorm(n); 
betas <- sapply(1 : nosim, function(i){
  y <- x1 + rnorm(n, sd = .3)
  c(coef(lm(y ~ x1))[2], 
    coef(lm(y ~ x1 + x2))[2], 
    coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
```
**Apparently, the actual variance is inflated and maybe not the estimated variance. I am not sure what this means and what is the consequence for us!**

Monte carlo error?

As long as variables are independent, we seem to be cool!

```
x1      x1      x1 
0.02839 0.02872 0.02884 
```

---
### Variance inflation (when there is a relation between x1 and x3)
```{r, echo = TRUE}
n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- x1/sqrt(2) + rnorm(n) /sqrt(2)
x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2); 
betas <- sapply(1 : nosim, function(i){
  y <- x1 + rnorm(n, sd = .3)
  c(coef(lm(y ~ x1))[2], 
    coef(lm(y ~ x1 + x2))[2], 
    coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
```

```
     x1      x1      x1 
0.03131 0.04270 0.09653 
```

If the variable you include (x3) is highly correlated with variable
you are interested in (x1), then you are going to inflat the fuck out
of it (aka 3 times as shown above!)

Think about what you wanna include and why!

If you included height and weight in the same model! both of them are
highly corelated. Maybe we check the correlation before adding
variables!

As long as they are randomized it is still ok? or it somehow reduces
the correlation (investigate!)

---
### Variance inflation factors (dp!)
* Notice variance inflation was much worse when we included a variable
that was highly related to `x1`.
* We don't know $\sigma$, so we can only estimate the increase in the
  actual standard error of the coefficients for including a regressor.
* However, $\sigma$ drops out of the relative standard errors. If one
  sequentially adds variables, one can check the variance (or sd)
  inflation for including each one.
* When the other regressors are actually orthogonal to the regressor
  of interest, then there is no variance inflation.
* The **variance inflation factor (VIF)** is the increase in the
  variance for the ith regressor compared to the ideal setting where
  it is orthogonal to the other regressors.
  
	  Ratio of current case with all regressors and the case with
      non-correlated regressors! Look into how this works out!
	  
	  Shown below!
  * (The square root of the VIF is the increase in the sd ...)
* Remember, variance inflation is only part of the picture. We want to
  include certain variables, even if they dramatically inflate our
  variance.

---
### Revisting our previous simulation
```{r, echo = TRUE}
##doesn't depend on which y you use,
y <- x1 + rnorm(n, sd = .3)
a <- summary(lm(y ~ x1))$cov.unscaled[2,2]
c(summary(lm(y ~ x1 + x2))$cov.unscaled[2,2],
  summary(lm(y~ x1 + x2 + x3))$cov.unscaled[2,2]) / a
temp <- apply(betas, 1, var); temp[2 : 3] / temp[1]
```

---

### Swiss data
```{r}
data(swiss); 
fit1 <- lm(Fertility ~ Agriculture, data = swiss)
a <- summary(fit1)$cov.unscaled[2,2]
fit2 <- update(fit, Fertility ~ Agriculture + Examination)
fit3 <- update(fit, Fertility ~ Agriculture + Examination + Education)
  c(summary(fit2)$cov.unscaled[2,2],
    summary(fit3)$cov.unscaled[2,2]) / a 
```

---
### Swiss data VIFs, 
```{r}
library(car)
fit <- lm(Fertility ~ . , data = swiss)
vif(fit)
sqrt(vif(fit)) #I prefer sd 
```
```
     Agriculture      Examination        Education         Catholic Infant.Mortality 
           1.511            1.917            1.666            1.392            1.052 
```

WE see infant mortality and expect it to be not too bothered by other
variables! but examination and edumacation, PNN.

---
### What about residual variance estimation?
* Assuming that the model is linear with additive iid errors (with
  finite variance), we can mathematically describe the impact of
  omitting necessary variables or including unnecessary ones.
  * If we underfit the model, the variance estimate is biased.
  * If we correctly or overfit the model, including all necessary
    covariates and/or unnecessary covariates, the variance estimate is
    unbiased.
    * However, the variance of the variance is larger if we include
      unnecessary variables.

---
### Covariate model selection
* Automated covariate selection is a difficult topic. It depends
  heavily on how rich of a covariate space one wants to explore.
  * The space of models explodes quickly as you add interactions and
    polynomial terms.
* In the prediction class, we'll cover many modern methods for
  traversing large model spaces for the purposes of prediction.
* Principal components or factor analytic models on covariates are
  often useful for reducing complex covariate spaces.
* Good design can often eliminate the need for complex model searches
  at analyses; though often control over the design is limited;
  Randomization for example...
  
  For example in bio statistics, when you want to measure
  effectiveness of the aspirin, they try to give the drug to one
  person and use a washout period to test the drug the next time!
  
* If the models of interest are nested and without lots of parameters
  differentiating them, it's fairly uncontroversial to use nested
  likelihood ratio tests. (Example to follow.)
* My favoriate approach is as follows. Given a coefficient that I'm
  interested in, I like to use covariate adjustment and multiple
  models to probe that effect to evaluate it for robustness and to see
  what other covariates knock it out.  This isn't a terribly
  systematic approach, but it tends to teach you a lot about the the
  data as you get your hands dirty.

---
### How to do nested model testing in R
```{r}
fit1 <- lm(Fertility ~ Agriculture, data = swiss)
fit3 <- update(fit, Fertility ~ Agriculture + Examination + Education)
fit5 <- update(fit, Fertility ~ Agriculture + Examination + Education + Catholic + Infant.Mortality)
anova(fit1, fit3, fit5)
```

```
Analysis of Variance Table

Model 1: Fertility ~ Agriculture
Model 2: Fertility ~ Agriculture + Examination + Education
Model 3: Fertility ~ Agriculture + Examination + Education + Catholic + 
    Infant.Mortality
  Res.Df  RSS Df Sum of Sq    F  Pr(>F)    
1     45 6283                              
2     43 3181  2      3102 30.2 8.6e-09 ***
3     41 2105  2      1076 10.5 0.00021 ***

Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

This looks like a good way to understand again, what is a good
parameter to include! Use above only when there is possibility of
nesting. 
### Summary

- use anova of 2 fits to determine in a nested fashion if a variable
  adds value or not!
  
- otherwise just look at the slopes to determine if they have impact
  of not
  
- use influence measures to determine if certain points influence the
  data!
  
- vis is to measure variance extra!


- more variables => more variance if not truly randomized
  - example, examination and education!

- less variables => more error in result due to spurious additions

	- always try to removed contributions of other variables by
      looking at residuals!

### Quiz 
1. Consider the \verb| mtcars|mtcars data set. Fit a model with mpg as
   the outcome that includes number of cylinders as a factor variable
   and weight as confounder. Give the adjusted estimate for the
   expected change in mpg comparing 8 cylinders to 4.
   
		fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
		summary(fit)$coef
		
2. Consider the \verb| mtcars|mtcars data set. Fit a model with mpg as
   the outcome that includes number of cylinders as a factor variable
   and weight as a possible confounding variable. Compare the effect
   of 8 versus 4 cylinders on mpg for the adjusted and unadjusted by
   weight models. Here, adjusted means including the weight variable
   as a term in the regression model and unadjusted means the model
   without weight included. What can be said about the effect
   comparing 8 and 4 cylinders after looking at models with and
   without weight included?.

	Holding weight constant, cylinder appears to have less of an
    impact on mpg than if weight is disregarded.
	
	It is both true and sensible that including weight would attenuate
    the effect of number of cylinders on mpg.
	
	Not sure what they mean by more impact (p-value or anova tests or
    slopes etc...)
	
3. Consider the \verb|mtcars|mtcars data set. Fit a model with mpg as
   the outcome that considers number of cylinders as a factor variable
   and weight as confounder. Now fit a second model with mpg as the
   outcome model that considers the interaction between number of
   cylinders (as a factor variable) and weight. Give the P-value for
   the likelihood ratio test comparing the two models and suggest a
   model using 0.05 as a type I error rate significance benchmark.
   
   The P-value is larger than 0.05. So, according to our criterion, we
   would fail to reject, which suggests that the interaction terms may
   not be necessary.
   
   fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
   fit2 <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
   summary(fit1)$coef
   
   summary(fit2)$coef
   
   anova(fit1, fit2)
   
4. Consider the \verb|mtcars|mtcars data set. Fit a model with mpg as
   the outcome that includes number of cylinders as a factor variable
   and weight inlcuded in the model as
   
		lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
		
	The estimated expected change in MPG per one ton increase in
    weight for a specific number of cylinders (4, 6, 8).
	
5. Consider the following data set

		x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
		y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
		
	Give the hat diagonal for the most influential point
	
		influence(lm(y ~ x))$hat
		## showing how it's actually calculated
		xm <- cbind(1, x)
		diag(xm %*% solve(t(xm) %*% xm) %*% t(xm))
		
		
6. Consider the following data set

		x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
		y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

	Give the slope dfbeta for the point with the highest hat value.

		influence.measures(lm(y ~ x))
		
7. Consider a regression relationship between Y and X with and without
   adjustment for a third variable Z. Which of the following is true
   about comparing the regression coefficient between Y and X with and
   without adjustment for Z.
   
   It is possible for the coefficient to reverse sign after
   adjustment. For example, it can be strongly significant and
   positive before adjustment and strongly significant and negative
   after adjustment.
   
   See lecture 02_03 for various examples.



### optional quiz 

Your assignment is to study how income varies across college major
categories. Specifically answer: “Is there an association between
college major category and income?”

To get started, start a new R/RStudio session with a clean
workspace. To do this in R, you can use the q() function to quit, then
reopen R. The easiest way to do this in RStudio is to quit RStudio
entirely and reopen it. After you have started a new session, run the
following commands. This will load a data.frame called college for you
to work with.

	install.packages("devtools")
	devtools::install_github("jhudsl/collegeIncome")
	library(collegeIncome)
	data(college)
	
	devtools::install_github("jhudsl/matahari")
	library(matahari)
	
    ##	To start and end
	dance_start(value = FALSE, contents = FALSE)
	dance_save("~/Desktop/college_major_analysis.rds")
	
Based on your analysis, would you conclude that there is a significant
association between college major category and income?

Ans: NO as for one, p-values are way higher indicating similarity!

Mean and boxplots don't seem to show variability

#### My answer

df$ranks doesn't seem to be coming from df$medianl in that case I
don't understand the rank variable! So I almost don't look at it!

with this, I look at only the variables in isolation , i.e., removing
all residuals needed: fit <- lm(median ~ . -major - major_code,
data=df) ; summary(fit)

Result:
```
major_categoryAgriculture & Natural Resources       0.8917    
major_categoryBiology & Life Science                0.4126    
major_categoryBusiness                              0.2229    
major_categoryCommunications & Journalism           0.1541    
major_categoryComputers & Mathematics               0.0680  

```
Most of the categories are above a 20 % significance level and all
above 5%. This goes to show that when I look at median income, and the
categories, there is not a "significant" level of association!

Also the same output shows the corelation between p25th and p75th. I
guess this is enough! Using a lot of variables (as I have done above)
might increase the variance, but I am not sure what is the
significance of it for this case!


my work: published: in rds matahari stuff:
https://github.com/agent18/linear-regression/blob/master/college_major_analysis.rds

#### better solution by prof for later consumption!

https://d3c33hcgiwev3.cloudfront.net/_fd9c88bac4ae1ea84e1994f141541ef2_solution.pdf?Expires=1556064000&Signature=X-bGR26cRgoTYnJe209LjxxU4U1T~edPw7Ri0akbYlaX70aQodTO10w6YTlSRv~38qwJXFgL6AIcQpBLdKwg-r~r8KkJhi6iXBME4iLJGcvNmnfcpaED6RFYH4Y1jy36CcKWJx9l6uHDSt5yzyRfH6qCUgStRsrHexcTw7Nh~BM_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A

I have also saved this here: https://github.com/agent18/linear-regression/commit/a91f8a84668e3201146281ebbd65e8b35792509b
	
### p hacking

Your assignment is to study how income varies across different
categories of college majors. You will be using data from a study of
recent college graduates. Make sure to use good practices that you
have learned so far in this course and previous courses in the
specialization.In particular, it is good practice to specify an
analysis plan early in the process to avoid the “p-hacking” behavior
of trying many analyses to find one that has desired results. If you
want to learn more about “p-hacking”, you can visit
https://projects.fivethirtyeight.com/p-hacking/



## GLM -- Don't read Horrible lecture and notes 0 EX (C7-w4)

### Linear models
* Linear models are the most useful applied statistical
  technique. However, they are not without their limitations.
  * Additive response models don't make much sense if the response is
    discrete, or stricly positive.
  * Additive error models often don't make sense, for example if the
    outcome has to be positive.
  * Transformations are often hard to interpret.
    * There's value in modeling the data on the scale that it was
      collected.
    * Particularly interpetable transformations, natural logarithms in
      specific, aren't applicable for negative or zero values.



---
### Generalized linear models
* Introduced in a 1972 RSSB paper by Nelder and Wedderburn.
* Involves three components
  * An *exponential family* model for the response.
	* includes normal, binom and poisson
  * A systematic component via a linear predictor.
  * A link function that connects the means of the response to the
    linear predictor.
  

---
### Example, linear models
* Assume that $Y_i \sim N(\mu_i, \sigma^2)$ (the Gaussian distribution is an exponential family distribution.)
* Define the linear predictor to be $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$.
* The link function as $g$ so that $g(\mu) = \eta$.
  * For linear models $g(\mu) = \mu$ so that $\mu_i = \eta_i$
* This yields the same likelihood model as our additive error Gaussian linear model
$$
Y_i = \sum_{k=1}^p X_{ik} \beta_k + \epsilon_{i}
$$
where $\epsilon_i \stackrel{iid}{\sim} N(0, \sigma^2)$

---
### Example, logistic regression
* Assume that $Y_i \sim Bernoulli(\mu_i)$ so that $E[Y_i] = \mu_i$ where $0\leq \mu_i \leq 1$.
* Linear predictor $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$
* Link function 
$g(\mu) = \eta = \log\left( \frac{\mu}{1 - \mu}\right)$
$g$ is the (natural) log odds, referred to as the **logit**.
* Note then we can invert the logit function as
$$
\mu_i = \frac{\exp(\eta_i)}{1 + \exp(\eta_i)} ~~~\mbox{and}~~~
1 - \mu_i = \frac{1}{1 + \exp(\eta_i)}
$$
Thus the likelihood is
$$
\prod_{i=1}^n \mu_i^{y_i} (1 - \mu_i)^{1-y_i}
= \exp\left(\sum_{i=1}^n y_i \eta_i \right)
\prod_{i=1}^n (1 + \eta_i)^{-1}
$$

---
### Example, Poisson regression
* Assume that $Y_i \sim Poisson(\mu_i)$ so that $E[Y_i] = \mu_i$ where $0\leq \mu_i$
* Linear predictor $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$
* Link function 
$g(\mu) = \eta = \log(\mu)$
* Recall that $e^x$ is the inverse of $\log(x)$ so that 
$$
\mu_i = e^{\eta_i}
$$
Thus, the likelihood is
$$
\prod_{i=1}^n (y_i !)^{-1} \mu_i^{y_i}e^{-\mu_i}
\propto \exp\left(\sum_{i=1}^n y_i \eta_i - \sum_{i=1}^n \mu_i\right)
$$

---
### Some things to note
* In each case, the only way in which the likelihood depends on the data is through 
$$\sum_{i=1}^n y_i \eta_i =
\sum_{i=1}^n y_i\sum_{k=1}^p X_{ik} \beta_k = 
\sum_{k=1}^p \beta_k\sum_{i=1}^n X_{ik} y_i
$$
Thus if we don't need the full data, only $\sum_{i=1}^n X_{ik} y_i$. This simplification is a consequence of chosing so-called 'canonical' link functions.
* (This has to be derived). All models achieve their maximum at the root of the so called normal equations
$$
0=\sum_{i=1}^n \frac{(Y_i - \mu_i)}{Var(Y_i)}W_i
$$
where $W_i$ are the derivative of the inverse of the link function.

---
### About variances
$$
0=\sum_{i=1}^n \frac{(Y_i - \mu_i)}{Var(Y_i)}W_i
$$
* For the linear model $Var(Y_i) = \sigma^2$ is constant.
* For Bernoulli case $Var(Y_i) = \mu_i (1 - \mu_i)$
* For the Poisson case $Var(Y_i) = \mu_i$. 
* In the latter cases, it is often relevant to have a more flexible variance model, even if it doesn't correspond to an actual likelihood
$$
0=\sum_{i=1}^n \frac{(Y_i - \mu_i)}{\phi \mu_i (1 - \mu_i ) } W_i ~~~\mbox{and}~~~
0=\sum_{i=1}^n \frac{(Y_i - \mu_i)}{\phi \mu_i} W_i
$$
* These are called 'quasi-likelihood' normal equations 

---
### Odds and ends
* The normal equations have to be solved iteratively. Resulting in 
$\hat \beta_k$ and, if included, $\hat \phi$.
* Predicted linear predictor responses can be obtained as $\hat \eta = \sum_{k=1}^p X_k \hat \beta_k$
* Predicted mean responses as $\hat \mu = g^{-1}(\hat \eta)$
* Coefficients are interpretted as 
$$
g(E[Y | X_k = x_k + 1, X_{\sim k} = x_{\sim k}]) - g(E[Y | X_k = x_k, X_{\sim k}=x_{\sim k}]) = \beta_k
$$
or the change in the link function of the expected response per unit
change in $X_k$ holding other regressors constant.
* Variations on Newon/Raphson's algorithm are used to do it.
* Asymptotics are used for inference usually.
* Many of the ideas from linear models can be brought over to GLMs.

## Logistic regression(c7-w4)
### Key ideas

* Frequently we care about outcomes that have two values
  * Alive/dead
  * Win/loss
  * Success/Failure
  * etc
* Called binary, Bernoulli or 0/1 outcomes 
* Collection of exchangeable binary outcomes for the same covariate data are called binomial outcomes.

---

### Example Baltimore Ravens win/loss
#### Ravens Data

```{r loadRavens,cache=TRUE}
download.file("https://dl.dropboxusercontent.com/u/7710864/data/ravensData.rda"
              , destfile="./data/ravensData.rda",method="curl") #
			  doesn't work
load("./data/ravensData.rda")
head(ravensData)
```
Download from here! 

https://github.com/jtleek/dataanalysis/blob/master/week5/002binaryOutcomes/data/ravensData.rda?raw=true

---

### Linear regression 

$$ RW_i = b_0 + b_1 RS_i + e_i $$

$RW_i$ - 1 if a Ravens win, 0 if not

$RS_i$ - Number of points Ravens scored

$b_0$ - probability of a Ravens win if they score 0 points ( because
winning is a binary variable, values between o and 1 imply a
probability I think!)

$b_1$ - increase in probability of a Ravens win for each additional point

$e_i$ - residual variation due 

---

### Linear regression in R

```{r linearReg, dependson = "loadRavens", cache=TRUE}
lmRavens <- lm(ravensData$ravenWinNum ~ ravensData$ravenScore)
summary(lmRavens)$coef
```

``` r

summary(lm(ravensData$ravenWinNum~ravensData$ravenScore))


plot(ravensData$ravenScore,ravensData$ravenWinNum)
abline(lm(ravensData$ravenWinNum~ravensData$ravenScore))

```

---

### Odds

__Binary Outcome 0/1__

$$RW_i$$  

__Probability (0,1)__

$$\rm{Pr}(RW_i | RS_i, b_0, b_1 )$$


__Odds $(0,\infty)$__
$$\frac{\rm{Pr}(RW_i | RS_i, b_0, b_1 )}{1-\rm{Pr}(RW_i | RS_i, b_0, b_1)}$$ 

__Log odds $(-\infty,\infty)$__

$$\log\left(\frac{\rm{Pr}(RW_i | RS_i, b_0, b_1 )}{1-\rm{Pr}(RW_i | RS_i, b_0, b_1)}\right)$$ 

^^ is the **LOGIT**

---

### Linear vs. logistic regression

__Linear__

*Modeling it as linear*

$$ RW_i = b_0 + b_1 RS_i + e_i $$

or

$$ E[RW_i | RS_i, b_0, b_1] = b_0 + b_1 RS_i$$

Expected value of a fair coin is a probability, i.e., 0.5 fair coin

__Logistic__

*Modelling it as odds!* 

x = b0+b1*RSi

p  = e^x/(1+e^x) --- exfit  


or

log(p/(1-p)) = x --- logit--- log odds


**LOG ODDS OF PROBABILITY = f(regressors) = b0+b1*RSi**


$$ \rm{Pr}(RW_i | RS_i, b_0, b_1) = \frac{\exp(b_0 + b_1 RS_i)}{1 + \exp(b_0 + b_1 RS_i)}$$


$$ \log\left(\frac{\rm{Pr}(RW_i | RS_i, b_0, b_1 )}{1-\rm{Pr}(RW_i | RS_i, b_0, b_1)}\right) = b_0 + b_1 RS_i $$


---

### Interpreting Logistic Regression

$$ \log\left(\frac{\rm{Pr}(RW_i | RS_i, b_0, b_1 )}{1-\rm{Pr}(RW_i | RS_i, b_0, b_1)}\right) = b_0 + b_1 RS_i $$

log(p/(1-p)) = x --- logit--- log odds ; x = b0+b1*RSi

p  = e^x/(1+e^x)

$b_0$ - Log odds of a Ravens win if they score zero points

$b_1$ - Log odds ratio of win probability for each point scored (compared to zero points)

$\exp(b_1)$ - Odds ratio of win probability for each point scored (compared to zero points)

A better explanation on the actual logic of exp(beta1) is given
[here](https://stats.stackexchange.com/questions/35013/exponentiated-logistic-regression-coefficient-different-than-odds-ratio).

In the end exp(beta1) gives Odds ratio!

---

### Odds
- Imagine that you are playing a game where you flip a coin with
  success probability $p$.
- If it comes up heads, you win $X$. If it comes up tails, you lose
  $Y$.
- What should we set $X$ and $Y$ for the game to be fair?

    **$$E[earnings]= X p - Y (1 - p) = 0$$**
	
- Implies
    
	**$$\frac{Y}{X} = \frac{p}{1 - p}$$**   
	
- The odds can be said as "How much should you be willing to pay for a
  $p$ probability of winning a dollar?"
    - (If $p > 0.5$ you have to pay more if you lose than you get if you win.)
    - (If $p < 0.5$ you have to pay less if you lose than you get if you win.)

---
### Visualizing fitting logistic regression curves
```
x <- seq(-10, 10, length = 1000)
manipulate(
    plot(x, exp(beta0 + beta1 * x) / (1 + exp(beta0 + beta1 * x)), 
         type = "l", lwd = 3, frame = FALSE),
    beta1 = slider(-2, 2, step = .1, initial = 2),
    beta0 = slider(-2, 2, step = .1, initial = 0)
    )
```

Its an S curve when you plot, **e^x/(1-e^x)** 

---

### Ravens logistic regression

```{r logReg, dependson = "loadRavens"}
logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore,family="binomial")
summary(logRegRavens)
```

**It automatically assumes that the link function is the logit function!**

---

### Ravens fitted values

```{r dependson = "logReg",fig.height=4,fig.width=4}
plot(ravensData$ravenScore,logRegRavens$fitted,pch=19,col="blue",xlab="Score",ylab="Prob Ravens Win")
```

**It's actually a complete S curve but it is not shown here.**

---

### Odds ratios and confidence intervals

```{r dependson = "logReg",fig.height=4,fig.width=4}
exp(logRegRavens$coeff)
exp(confint(logRegRavens))
```

**The above gives the coefficients for the probabilities**

---

### ANOVA for logistic regression

```{r dependson = "logReg",fig.height=4,fig.width=4}
anova(logRegRavens,test="Chisq")
```

---

### Interpreting Odds Ratios

* Not probabilities 
* Odds ratio of 1 = no difference in odds
* Log odds ratio of 0 = no difference in odds
* Odds ratio < 0.5 or > 2 commonly a "moderate effect"
* Relative risk $\frac{\rm{Pr}(RW_i | RS_i = 10)}{\rm{Pr}(RW_i | RS_i = 0)}$ often easier to interpret, harder to estimate
* For small probabilities RR $\approx$ OR but __they are not the same__!

[Wikipedia on Odds Ratio](http://en.wikipedia.org/wiki/Odds_ratio)


---

### Further resources

* [Wikipedia on Logistic Regression](http://en.wikipedia.org/wiki/Logistic_regression)
* [Logistic regression and glms in R](http://data.princeton.edu/R/glms.html)
* Brian Caffo's lecture notes on: [Simpson's paradox](http://ocw.jhsph.edu/courses/MethodsInBiostatisticsII/PDFs/lecture23.pdf), [Case-control studies](http://ocw.jhsph.edu/courses/MethodsInBiostatisticsII/PDFs/lecture24.pdf)
* [Open Intro Chapter on Logistic Regression](http://www.openintro.org/stat/down/oiStat2_08.pdf)

### Logistic regression and linear Regression for factors --- Agent

#### Linear regression with X as factor

```r
y <- mtcars$mpg
x <- mtcars$vs

boxplot(y[x==0],y[x!=0]) shows mean for the two values of X
a <- lm(y~x)


```

All LM can do is predict mpg if the vs is 0 or 1. That's it and it
does so based on means!

The equation is `Y = mean_0 + (mean_1 - mean_0)*x$`.

``` r
predict(a,newdata=data.frame(x=as.factor(1)))
```

Ans: 24

```r
predict(a,newdata=data.frame(x=as.factor(0)))
```

Ans: 16. 


Ans are nothing but the means!

In LM the Y is a continuous variable! In logistic regression Y is 0 or
1 as well.

[Source](https://youtu.be/vN5cNN2-HWE?t=842) with timestamp!

#### Linear regression with X continuous and Y factor

``` r
y <- mtcars$vs ## v-model
y <- as.numeric(as.character(y))

x <- mtcars$mpg ## v-model
plot(x,y)
fit <- lm(as.numeric(y)~x)
abline(fit)

predict(fit, newdata=data.frame(x=mean(x)))
predict(fit, newdata=data.frame(x=max(x)))
```
**Y is a probability of getting a 1. Higher the X higher the
probability. But probability cannot be greater than 1**

#### Logistic regression y factor and X continuous

`log(p/(1-p)) = beta0 + beta1*x = out`

beta0 is the intercept of the log odds plot vs X.

**beta1 is the slope of the line, i.e., change in log odds per change in
X.** 

**Change is log odds is nothing but the log odds ratio. logA - logB =
Log A/B** 

`p = e^(out)/(1+e^(out))`

The probability is given as above! 

``` r
fit->glm(y~x, family="binomial") ## gives beta0 and beta1
plot(x,y)
points(x,fit$fitted.values,pch="-", col="red")

```
We see an S curve!

#### Logistic regression y factor and X also Factor! 

The greatest and most useful source was: 
``` r
x <- mtcars$am
y <- mtcars$vs

y <-as.numeric(as.character(y))
x <-as.numeric(as.character(x))
glm(y~x,family="binomial")

table(x,y)
c(log(7/12),-log(7/12)+log(7/6)) ## glm manual
```

Quiz 4: q1 

> Consider the space shuttle data \verb|?shuttle|?shuttle in the
> \verb|MASS|MASS library. Consider modeling the use of the autolander
> as the outcome (variable name \verb|use|use). Fit a logistic
> regression model with autolander (variable auto) use (labeled as
> "auto" 1) versus not (0) as predicted by wind sign (variable
> wind). Give the estimated odds ratio for autolander use comparing
> head winds, labeled as "head" in the variable headwind (numerator)
> to tail winds (denominator).

``` r
shuttle$use2<-as.integer(shuttle$use=="auto")
shuttle$wind2<-as.integer(shuttle$wind=="head")
logRegShuttle<-glm(use2~wind2, family=binomial, shuttle)

## or
table(y,x)
log(55/73)-log(56/72) ## slope
log(56/72) ## intercept
```



## Poisson's logistic regression c7-w4
### Key ideas

* Many data take the form of counts
  * Calls to a call center
  * Number of flu cases in an area
  * Number of cars that cross a bridge
* Data may also be in the form of rates
  * Percent of children passing a test
  * Percent of hits to a website from a country
* Linear regression with transformation is an option

---

### Poisson distribution
- The Poisson distribution is a useful model for counts and rates
- Here a rate is count per some monitoring time
- Some examples uses of the Poisson distribution
    - Modeling web traffic hits
    - Incidence rates
    - Approximating binomial probabilities with small $p$ and large $n$
    - Analyzing contigency table data

---
### The Poisson mass function
- $X \sim Poisson(t\lambda)$ if
$$
P(X = x) = \frac{(t\lambda)^x e^{-t\lambda}}{x!}
$$
For $x = 0, 1, \ldots$.
- The mean of the Poisson is $E[X] = t\lambda$, thus $E[X / t] = \lambda$
- The variance of the Poisson is $Var(X) = t\lambda$.
- The Poisson tends to a normal as $t\lambda$ gets large.

---

```{r simPois,fig.height=4,fig.width=8, cache=TRUE}
par(mfrow = c(1, 3))
plot(0 : 10, dpois(0 : 10, lambda = 2), type = "h", frame = FALSE)
plot(0 : 20, dpois(0 : 20, lambda = 10), type = "h", frame = FALSE)
plot(0 : 200, dpois(0 : 200, lambda = 100), type = "h", frame = FALSE) 
```

---

### Poisson distribution
#### Sort of, showing that the mean and variance are equal
```{r}
x <- 0 : 10000; lambda = 3
mu <- sum(x * dpois(x, lambda = lambda))
sigmasq <- sum((x - mu)^2 * dpois(x, lambda = lambda))
c(mu, sigmasq)
```

---

### Example: Leek Group Website Traffic
* Consider the daily counts to Jeff Leek's web site

[http://biostat.jhsph.edu/~jleek/](http://biostat.jhsph.edu/~jleek/)

* **Since the unit of time is always one day, set $t = 1$ and then
the Poisson mean is interpretted as web hits per day. (If we set $t = 24$, it would
be web hits per hour).**

---

### Website data

```{r leekLoad,cache=TRUE}
download.file("https://dl.dropboxusercontent.com/u/7710864/data/gaData.rda",destfile="./data/gaData.rda",method="curl")
load("./data/gaData.rda")
gaData$julian <- julian(gaData$date)
head(gaData)
```

[http://skardhamar.github.com/rga/](http://skardhamar.github.com/rga/)


---

### Plot data

```{r, dependson="leekLoad",fig.height=4.5,fig.width=4.5}
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
```


---

### Linear regression

$$ NH_i = b_0 + b_1 JD_i + e_i $$

$NH_i$ - number of hits to the website

$JD_i$ - day of the year (Julian day)

$b_0$ - number of hits on Julian day 0 (1970-01-01)

$b_1$ - increase in number of hits per unit day

$e_i$ - variation due to everything we didn't measure


---

### Linear regression line

```{r linReg, dependson="leekLoad",fig.height=4,fig.width=4, cache=TRUE}
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
lm1 <- lm(gaData$visits ~ gaData$julian)
abline(lm1,col="red",lwd=3)
```

---

### Aside, taking the log of the outcome
- Taking the natural log of the outcome has a specific interpretation.
- Consider the model

$$ \log(NH_i) = b_0 + b_1 JD_i + e_i $$ 

**We take log because exp(E(log(Y))) = is [geometric mean](https://www.mathsisfun.com/numbers/geometric-mean.html)**

$NH_i$ - number of hits to the website

$JD_i$ - day of the year (Julian day)

$b_0$ - log number of hits on Julian day 0 (1970-01-01)

$b_1$ - increase in log number of hits per unit day

$e_i$ - variation due to everything we didn't measure

---
### Exponentiating coefficients
- **$e^{E[\log(Y)]}$ geometric mean of $Y$**.
    - With no covariates, this is estimated by
      $e^{\frac{1}{n}\sum_{i=1}^n \log(y_i)} = (\prod_{i=1}^n
      y_i)^{1/n}$
- **When you take the natural log of outcomes and fit a regression
model, your exponentiated coefficients estimate things about geometric
means.**
- $e^{\beta_0}$ estimated geometric mean hits on day 0
- $e^{\beta_1}$ estimated relative increase or decrease in geometric
  mean hits per day
- **There's a problem with logs with you have zero counts**, adding a constant works
```{r}
round(exp(coef(lm(I(log(gaData$visits + 1)) ~ gaData$julian))), 5)
```

---

### Linear vs. Poisson regression

__Linear__

$$ NH_i = b_0 + b_1 JD_i + e_i $$

or

$$ E[NH_i | JD_i, b_0, b_1] = b_0 + b_1 JD_i$$

__Poisson/log-linear__

$$ \log\left(E[NH_i | JD_i, b_0, b_1]\right) = b_0 + b_1 JD_i $$

**Log of expected value NOT LOG OF VALUE!**

or

$$ E[NH_i | JD_i, b_0, b_1] = \exp\left(b_0 + b_1 JD_i\right) $$


---

### Multiplicative differences

<br><br>
$$ E[NH_i | JD_i, b_0, b_1] = \exp\left(b_0 + b_1 JD_i\right) $$

<br><br>

$$ E[NH_i | JD_i, b_0, b_1] = \exp\left(b_0 \right)\exp\left(b_1 JD_i\right) $$

<br><br>

**If $JD_i$ is increased by one unit, $E[NH_i | JD_i, b_0, b_1]$ is
multiplied by $\exp\left(b_1\right)$** https://youtu.be/hg51LjG1xIc?t=205

---

### Poisson regression in R

```{r poisReg, dependson="linReg",fig.height=4.5,fig.width=4.5, cache=TRUE}
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
glm1 <- glm(gaData$visits ~ gaData$julian,family="poisson")
abline(lm1,col="red",lwd=3); lines(gaData$julian,glm1$fitted,col="blue",lwd=3)
```
**We see the difference between lm and glm**

---

### Mean-variance relationship?

```{r, dependson="poisReg",fig.height=4.5,fig.width=4.5}
plot(glm1$fitted,glm1$residuals,pch=19,col="grey",ylab="Residuals",xlab="Fitted")
```

If we look at the residuals for a given fitted value, the mean seems
to increase and the variance seems to increase. But we would like the
mean == Variance.

---

### Model agnostic standard errors 

```{r agnostic}
library(sandwich)
confint.agnostic <- function (object, parm, level = 0.95, ...)
{
    cf <- coef(object); pnames <- names(cf)
    if (missing(parm))
        parm <- pnames
    else if (is.numeric(parm))
        parm <- pnames[parm]
    a <- (1 - level)/2; a <- c(a, 1 - a)
    pct <- stats:::format.perc(a, 3)
    fac <- qnorm(a)
    ci <- array(NA, dim = c(length(parm), 2L), dimnames = list(parm,
                                                               pct))
    ses <- sqrt(diag(sandwich::vcovHC(object)))[parm]
    ci[] <- cf[parm] + ses %o% fac
    ci
}
```
[http://stackoverflow.com/questions/3817182/vcovhc-and-confidence-interval](http://stackoverflow.com/questions/3817182/vcovhc-and-confidence-interval)

---

### Estimating confidence intervals

```{r}
confint(glm1)
confint.agnostic(glm1)
```


---

### Add log offset in glm to account for ratios


<br><br>


$$ E[NHSS_i | JD_i, b_0, b_1]/NH_i = \exp\left(b_0 + b_1 JD_i\right) $$

<br><br>

$$ \log\left(E[NHSS_i | JD_i, b_0, b_1]\right) - \log(NH_i)  =  b_0 + b_1 JD_i $$

<br><br>

$$ \log\left(E[NHSS_i | JD_i, b_0, b_1]\right) = \log(NH_i) + b_0 + b_1 JD_i $$

---

### Fitting rates in R 

```{r ratesFit,dependson="agnostic", cache=TRUE,fig.height=4,fig.width=4}
glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),glm2$fitted,col="blue",pch=19,xlab="Date",ylab="Fitted Counts")
points(julian(gaData$date),glm1$fitted,col="red",pch=19)
```

---

### Fitting rates in R 

```{r,dependson="ratesFit",fig.height=4,fig.width=4}
glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),gaData$simplystats/(gaData$visits+1),col="grey",xlab="Date",
     ylab="Fitted Rates",pch=19)
lines(julian(gaData$date),glm2$fitted/(gaData$visits+1),col="blue",lwd=3)
```

---

### More information

* [Log-linear models and multiway tables](http://ww2.coastal.edu/kingw/statistics/R-tutorials/loglin.html)
* [Wikipedia on Poisson regression](http://en.wikipedia.org/wiki/Poisson_regression), [Wikipedia on overdispersion](http://en.wikipedia.org/wiki/Overdispersion)
* [Regression models for count data in R](http://cran.r-project.org/web/packages/pscl/vignettes/countreg.pdf)
* [pscl package](http://cran.r-project.org/web/packages/pscl/index.html) - the function _zeroinfl_ fits zero inflated models. 

## Hodgepodge (c7-w4)

### How to fit functions using linear models
* Consider a model $Y_i = f(X_i) + \epsilon$. 
* How can we fit such a model using linear models (called scatterplot smoothing)
* Consider the model 
  $$
  Y_i = \beta_0 + \beta_1 X_i + \sum_{k=1}^d (x_i - \xi_k)_+ \gamma_k + \epsilon_{i}
  $$
where $(a)_+ = a$ if $a > 0$ and $0$ otherwise and $\xi_1 \leq ... \leq \xi_d$ are known knot points.
* Prove to yourelf that the mean function
$$
\beta_0 + \beta_1 X_i + \sum_{k=1}^d (x_i - \xi_k)_+ \gamma_k
$$
is continuous at the knot points.

---
### Simulated example
```{r, fig.height=4, fig.width=4}
n <- 500; x <- seq(0, 4 * pi, length = n); y <- sin(x) + rnorm(n, sd = .3)
knots <- seq(0, 8 * pi, length = 20); 
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
```

---
### Adding squared terms
* Adding squared terms makes it continuously differentiable at the knot points.
* Adding cubic terms makes it twice continuously differentiable at the knot points; etcetera.
$$
  Y_i = \beta_0 + \beta_1 X_i + \beta_2 X_i^2 + \sum_{k=1}^d (x_i - \xi_k)_+^2 \gamma_k + \epsilon_{i}
$$

---
```{r, fig.height=4, fig.width=4}  
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot)^2)
xMat <- cbind(1, x, x^2, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
```

---
### Notes
* The collection of regressors is called a basis.
  * People have spent **a lot** of time thinking about bases for this kind of problem. So, consider this as just a teaser.
* Single knot point terms can fit hockey stick like processes.
* These bases can be used in GLMs as well.
* An issue with these approaches is the large number of parameters introduced. 
  * Requires some method of so called regularization.

---
### Harmonics using linear models
```{r}
##Chord finder, playing the white keys on a piano from octave c4 - c5
notes4 <- c(261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25)
t <- seq(0, 2, by = .001); n <- length(t)
c4 <- sin(2 * pi * notes4[1] * t); e4 <- sin(2 * pi * notes4[3] * t); 
g4 <- sin(2 * pi * notes4[5] * t)
chord <- c4 + e4 + g4 + rnorm(n, 0, 0.3)
x <- sapply(notes4, function(freq) sin(2 * pi * freq * t))
fit <- lm(chord ~ x - 1)
```

---
```{r, fig.height=5,fig.width=5, echo=FALSE}
plot(c(0, 9), c(0, 1.5), xlab = "Note", ylab = "Coef^2", axes = FALSE, frame = TRUE, type = "n")
axis(2)
axis(1, at = 1 : 8, labels = c("c4", "d4", "e4", "f4", "g4", "a4", "b4", "c5"))
for (i in 1 : 8) abline(v = i, lwd = 3, col = grey(.8))
lines(c(0, 1 : 8, 9), c(0, coef(fit)^2, 0), type = "l", lwd = 3, col = "red")
```

---
```{r, fig.height=5, fig.wdith=5}
##(How you would really do it)
a <- fft(chord); plot(Re(a)^2, type = "l")
```
### Quiz c7-w4
http://rstudio-pubs-static.s3.amazonaws.com/147494_3a252a05553c4bac9770f4582e9f770a.html


## C7-w4 assignment
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, message=F, warning=F, cache=T)
```
### Executive Summary

We start with the exploratory analysis (boxplots), to see how the Mean
of MPG varies with transmissions. Next, we attempt to fit models with
one variable and many variables to get more realistic results. Finally
we look at some diagnostic plots to comment on our data and
findings. **Throughout the analysis we expect Manual transmissions to be
better than Automatic.**

### Exploratory Analysis

`?mtcars` gives the variable names. `mpg` stands for miles per
gallon. `am` is 1 for automatic and 0 for manual. `summary` shows us
that `mpg` varies from 10 to 34 Miles per gallon! We make a boxplot
which helps us frame out hypothesis to answer which is better for MPG,
automatic or manual. Due to space constraints further exploration is
not shown

```{r plot, fig.width=4, fig.height=3 }
#par(mfrow=c(1,2))
x <- mtcars$am 
y <- mtcars$mpg
boxplot(y[x==0],y[x==1], names=c("Automatic","Manual"))
```

---

### Is an automatic or manual transmission better for MPG ?

We do a one sided T test with the following hypothesis:

**H0:** $\mu_{automatic} \leq \mu_{manual}$  
**H1:** $\mu_{automatic} \geq \mu_{manual}$

```{r }
y <- mtcars$mpg
x <- mtcars$am
ya <- y[x==0]
ym <- y[x==1]
t.test(ym,ya,paired=F, var.equal=F, alternative="greater")$p.value
t.test(ym,ya,paired=F, var.equal=F, alternative="greater")$conf.int
```
We reject H0 based on the p-value (<<< 5%) and the confidence intervals not
containing values $\leq 0$. We are inclined to think that **Manual is
better than Automatic**

---

### Fitting models
**Strategy for model selection**: It appears that lm a decent tool for
this. Poisson seems to not make sense here as the data is not discrete
and is not a rate (per time). We start with 1 variable lm and then
follow it up with some anova tests to identify the variables that make
an impact and then make the final model with those variables.

**Lm with one variable**
```{r linreg}
fit <- lm(y~x)
summary(fit)$coefficients
```
**The intercept is the mean of automatic and the coefficient of X is the
difference between the means.** With this we are able to predict that
MPG is `17.14` for automatic and `24.39` for manual. The intercept and
the coefficient of X are both significant based on the p-values. 

**Lm Anova multiple variables**:  
We check the influence of other parameters by sequentially adding more
variables to determine which model adds Sum Square value as shown below.

Checking influence of other parameters. Anova is not done to save
time! 

```{r anova, echo=T}
fit3 <- lm(mpg~ factor(am),data=mtcars)
fit4 <- lm(mpg~ factor(am)+cyl,data=mtcars)
fit5 <- lm(mpg~ factor(am)+cyl+disp,data=mtcars)
fit6 <- lm(mpg~ factor(am)+cyl+disp+hp,data=mtcars)
fit7 <- lm(mpg~ factor(am)+cyl+disp+hp+drat,data=mtcars)
fit8 <- lm(mpg~ factor(am)+cyl+disp+hp+drat+wt,data=mtcars)
fit9 <- lm(mpg~ factor(am)+cyl+disp+hp+drat+wt+qsec,data=mtcars)
fit10 <- lm(mpg~
               factor(am)+cyl+disp+hp+drat+wt+qsec+factor(vs),data=mtcars)
fit11 <- lm(mpg~
               factor(am)+cyl+disp+hp+drat+wt+qsec+factor(vs)+gear,data=mtcars)
fit12 <- lm(mpg~
                factor(am)+cyl+disp+hp+drat+wt+qsec+factor(vs)+gear+carb,data=mtcars)
anova(fit3, fit4, fit5, fit6, fit7, fit8, fit9, fit10,fit11,fit12)
```
From looking at the `Sum of Squares` the `Pr` column **we select `cyl`, `hp` and
`wt`** which seem to be the contributing factors based on the
p-value. **Based on sum of squares the other variables seem to account for `93%`
of residual variation.**

So final model is:
```{r }
fit.final <- lm(mpg~ factor(am)+cyl+hp+wt,data=mtcars)
summary(fit.final)$coefficients

```

---

### Conclusions: **Quantifying the MPG difference**  

It appears that the **manual transmission on average has 1.47 MPG more
than automatic and NOT 7 MPG more as estimated by
1-variable-linear-regression**, when accounting for other variables
using Anova. This current value is much higher than the value we got
initially without considering other variables. The anova test and
subsequent variables account for 93% of the residual variation. 

The residual plots and diagnostics info are shown in Appendix.

---


### Appendix: Diagnostics and residual plots

```{r, include=F }
plot(fit.final$fitted.values,resid(fit.final))
abline(h=0)
```


```{r, echo=F }
par(mfrow=c(2,3))
plot(fit.final, which=1)
plot(fit.final, which=2)
plot(fit.final, which=3)
plot(fit.final, which=4)
plot(fit.final, which=5)
plot(fit.final, which=6)
```
The residual plot shows a small pattern (variation of +-2) probably
due to variables that are not measured or the small sample size, as I
tested adding a few more of the anova variables and the pattern didn't go. The Q-Q plot is
expected to be on the dotted line, it shows deviation towards the
end. Probably due to the small size of the sample that we see the
deviation. The Scale location shows that the residuals are equally
spread along the ranges of the predictor. 

Looking at the Leverage we agree that there is not much possibility of
data entry issues as the points are away from the dotted lines on the
right (above and below).

### Appendix: Poisson's

Poisson's model is expected to be used for counts or rates (with
time). But I check the results of this as well, to see if we get a
different picture. It looks like the results are very different than
the lm with several variables.

```{r }
gfit <- glm(y~as.factor(x), family="poisson")
exp(gfit$coefficients)
summary(gfit)
##boxplot(y[x==0],y[x==1])
```


## C8-w1 Machine Learning
## Prediction Motivation

https://github.com/DataScienceSpecialization/courses/blob/master/08_PracticalMachineLearning/001predictionMotivation/index.md
### About this course

* This course covers the basic ideas behind machine learning/prediction
  * Study design - training vs. test sets
  * Conceptual issues - out of sample error, ROC curves
  * Practical implementation - the caret package
* What this course depends on
  * The Data Scientist's Toolbox
  * R Programming
* What would be useful
  * Exploratory analysis
  * Reporting Data and Reproducible Research
  * Regression models

---

### Who predicts?

* Local governments -> pension payments
* Google -> whether you will click on an ad
* Amazon -> what movies you will watch
* Insurance companies -> what your risk of death is
* Johns Hopkins -> who will succeed in their programs

---


### Why predict? Glory!

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/volinsky.png height=450>


[http://www.zimbio.com/photos/Chris+Volinsky](http://www.zimbio.com/photos/Chris+Volinsky)



---

### Why predict? Riches!

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/heritage.png height=450>


[http://www.heritagehealthprize.com/c/hhp](http://www.heritagehealthprize.com/c/hhp)



---

### Why predict? For sport!

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/kaggle.png height=350>


[http://www.kaggle.com/](http://www.kaggle.com/)

---

### Why predict? To save lives!

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/oncotype.png height=350>

[http://www.oncotypedx.com/en-US/Home](http://www.oncotypedx.com/en-US/Home)

---

### A useful (if a bit advanced) book

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/elemlearn.png height=350>


[The elements of statistical learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)

---

### A useful package

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/caret.png height=350>


[http://caret.r-forge.r-project.org/](http://caret.r-forge.r-project.org/)


---

### Machine learning (more advanced material)

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/machinelearning.png height=350>


[https://www.coursera.org/course/ml](https://www.coursera.org/course/ml)


---

### Even more resources

* [List of machine learning resources on Quora](http://www.quora.com/Machine-Learning/What-are-some-good-resources-for-learning-about-machine-learning-Why)
* [List of machine learning resources from Science](http://www.sciencemag.org/site/feature/data/compsci/machine_learning.xhtml)
* [Advanced notes from MIT open courseware](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-867-machine-learning-fall-2006/lecture-notes/)
* [Advanced notes from CMU](http://www.stat.cmu.edu/~cshalizi/350/)
* [Kaggle - machine learning competitions](http://www.kaggle.com/)
## What is prediction
### The central dogma of prediction

<img class="center" src=../../assets/img/08_PredictionAndMachineLearning/centraldogma.png height=450>

---

### What can go wrong

<img class="center" src=../../assets/img/08_PredictionAndMachineLearning/googleflu.png height=450>


http://www.sciencemag.org/content/343/6176/1203.full.pdf

---

### Components of a predictor

</br>

<center> question -> input data -> features -> algorithm -> parameters -> evaluation  </center>


---

### SPAM Example

</br>

<center> <redtext>question</redtext> -> input data -> features -> algorithm -> parameters -> evaluation  </center>

</br>

__Start with a general question__

Can I automatically detect emails that are SPAM that are not?

__Make it concrete__

Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?


---

### SPAM Example

</br>

<center> question -> <redtext>input data </redtext> -> features -> algorithm -> parameters -> evaluation  </center>

<img class=center src=../../assets/img/spamR.png height='400' />

[http://rss.acs.unt.edu/Rdoc/library/kernlab/html/spam.html](http://rss.acs.unt.edu/Rdoc/library/kernlab/html/spam.html)



---

### SPAM Example

</br>

<center> question -> input data  -> <redtext>features</redtext> -> algorithm -> parameters -> evaluation  </center>

</br>



<b>
Dear Jeff, 

Can you send me your address so I can send you the invitation? 

Thanks,

Ben
</b>




---

### SPAM Example

</br>

<center> question -> input data  -> <redtext>features</redtext> -> algorithm -> parameters -> evaluation  </center>

</br>

<b> 

Dear Jeff, 

Can <rt>you</rt> send me your address so I can send <rt>you</rt> the invitation? 

Thanks,

Ben
</b>

</br>

Frequency of you $= 2/17 = 0.118$

---

### SPAM Example

</br>

<center> question -> input data  -> <redtext>features</redtext> -> algorithm -> parameters -> evaluation  </center>


```{r loadData}
library(kernlab)
data(spam)
head(spam)
```


---

### SPAM Example


<center> question -> input data  -> features -> <redtext>algorithm</redtext> -> parameters -> evaluation  </center>

```{r,dependson="loadData",fig.height=3.5,fig.width=3.5}
plot(density(spam$your[spam$type=="nonspam"]),
     col="blue",main="",xlab="Frequency of 'your'")
lines(density(spam$your[spam$type=="spam"]),col="red")
```

---

### SPAM Example


<center> question -> input data  -> features -> <redtext>algorithm</redtext> -> parameters -> evaluation  </center>

</br></br>

__Our algorithm__

* Find a value $C$. 
* __frequency of 'your' $>$ C__ predict "spam"

---

### SPAM Example


<center> question -> input data  -> features -> algorithm -> <redtext>parameters</redtext> -> evaluation  </center>

```{r,dependson="loadData",fig.height=3.5,fig.width=3.5}
plot(density(spam$your[spam$type=="nonspam"]),
     col="blue",main="",xlab="Frequency of 'your'")
lines(density(spam$your[spam$type=="spam"]),col="red")
abline(v=0.5,col="black")
```

---

### SPAM Example


<center> question -> input data  -> features -> algorithm -> parameters -> <redtext>evaluation</redtext></center>

```{r,dependson="loadData",fig.height=3.5,fig.width=3.5}
prediction <- ifelse(spam$your > 0.5,"spam","nonspam")
table(prediction,spam$type)/length(spam$type)
```

Accuracy$ \approx 0.459 + 0.292 = 0.751$
## Importantce of steps
### Relative order of importance

</br>
</br>
</br>

<center> question > data > features > algorithms </center>


---

### An important point

<q>The combination of some data and an aching desire for an answer does not ensure that a reasonable answer can be extracted from a given body of data.</q>

<center> John Tukey </center>




---

### Garbage in = Garbage out

<center> question -> <rt>input data</rt> -> features -> algorithm -> parameters -> evaluation  </center>

1. May be easy (movie ratings -> new movie ratings)
2. May be harder (gene expression data -> disease)
3. Depends on what is a "good prediction".
4. Often [more data > better models](http://www.youtube.com/watch?v=yvDCzhbjYWs)
5. The most important step!


---

### Features matter!

<center> question -> input data -> <rt>features</rt> -> algorithm -> parameters -> evaluation  </center>

__Properties of good features__

* Lead to data compression
* Retain relevant information
* Are created based on expert application knowledge

__Common mistakes__

* Trying to automate feature selection
* Not paying attention to data-specific quirks
* Throwing away information unnecessarily

---

### May be automated with care

<center> question -> input data -> <rt>features</rt> -> algorithm -> parameters -> evaluation  </center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/autofeatures.jpeg height=300>

[http://arxiv.org/pdf/1112.6209v5.pdf](http://arxiv.org/pdf/1112.6209v5.pdf)

---

### Algorithms matter less than you'd think

<center> question -> input data -> features -> <rt>algorithm</rt> -> parameters -> evaluation  </center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/illusiontable.png height=400>

[http://arxiv.org/pdf/math/0606441.pdf](http://arxiv.org/pdf/math/0606441.pdf)

---

### Issues to consider

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/mlconsiderations.jpg height=400>

[http://strata.oreilly.com/2013/09/gaining-access-to-the-best-machine-learning-methods.html](http://strata.oreilly.com/2013/09/gaining-access-to-the-best-machine-learning-methods.html)

---

### Prediction is about accuracy tradeoffs


* Interpretability versus accuracy
* Speed versus accuracy
* Simplicity versus accuracy
* Scalability versus accuracy

---

### Interpretability matters

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/interpretable.png height=150>

</br></br></br>

[http://www.cs.cornell.edu/~chenhao/pub/mldg-0815.pdf](http://www.cs.cornell.edu/~chenhao/pub/mldg-0815.pdf)

---

### Scalability matters

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/netflixno.png height=250>
</br></br></br>

[http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/](http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/)

[http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html](http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html)

## In and out of sample errors (c8-w1)

### In sample versus out of sample

__In Sample Error__: The error rate you get on the same
data set you used to build your predictor. Sometimes
called resubstitution error.

__Out of Sample Error__: The error rate you get on a new
data set. Sometimes called generalization error. 

__Key ideas__

1. Out of sample error is what you care about
2. In sample error $<$ out of sample error
3. The reason is overfitting
  * Matching your algorithm to the data you have

---

### In sample versus out of sample errors

```{r loadData, fig.height=3.5,fig.width=3.5}
library(kernlab); data(spam); set.seed(333)
smallSpam <- spam[sample(dim(spam)[1],size=10),]
spamLabel <- (smallSpam$type=="spam")*1 + 1
plot(smallSpam$capitalAve,col=spamLabel)
```


---

### Prediction rule 1

* capitalAve $>$ 2.7 = "spam"
* capitalAve $<$ 2.40 = "nonspam"
* capitalAve between 2.40 and 2.45 = "spam"
* capitalAve between 2.45 and 2.7 = "nonspam"

---

### Apply Rule 1 to smallSpam

```{r, dependson="loadData"}
rule1 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.7] <- "spam"
  prediction[x < 2.40] <- "nonspam"
  prediction[(x >= 2.40 & x <= 2.45)] <- "spam"
  prediction[(x > 2.45 & x <= 2.70)] <- "nonspam"
  return(prediction)
}
table(rule1(smallSpam$capitalAve),smallSpam$type)
```

---

### Prediction rule 2

* capitalAve $>$ 2.40 = "spam"
* capitalAve $\leq$ 2.40 = "nonspam"


---

### Apply Rule 2 to smallSpam


```{r, dependson="loadData"}
rule2 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.8] <- "spam"
  prediction[x <= 2.8] <- "nonspam"
  return(prediction)
}
table(rule2(smallSpam$capitalAve),smallSpam$type)
```

---

### Apply to complete spam data

```{r, dependson="loadData"}
table(rule1(spam$capitalAve),spam$type)
table(rule2(spam$capitalAve),spam$type)
mean(rule1(spam$capitalAve)==spam$type)
mean(rule2(spam$capitalAve)==spam$type)
```

---

### Look at accuracy

```{r, dependson="loadData"}
sum(rule1(spam$capitalAve)==spam$type)
sum(rule2(spam$capitalAve)==spam$type)
```


---

### What's going on? 

<center><rt> Overfitting </rt></center>

* Data have two parts
  * Signal
  * Noise
* The goal of a predictor is to find signal
* You can always design a perfect in-sample predictor
* You capture both signal + noise when you do that
* Predictor won't perform as well on new samples

[http://en.wikipedia.org/wiki/Overfitting](http://en.wikipedia.org/wiki/Overfitting)

## Prediction study design (c8-w1)
### Prediction study design

1. Define your error rate
2. Split data into:
  * Training, Testing, Validation (optional)
3. On the training set pick features
  * Use cross-validation
4. On the training set pick prediction function
  * Use cross-validation
6. If no validation 
  * Apply 1x to test set
7. If validation
  * Apply to test set and refine
  * Apply 1x to validation 


---

### Know the benchmarks

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/benchmark.png height=400>

[http://www.heritagehealthprize.com/c/hhp/leaderboard](http://www.heritagehealthprize.com/c/hhp/leaderboard)


---

### Study design

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/studyDesign.png height=400>


[http://www2.research.att.com/~volinsky/papers/ASAStatComp.pdf](http://www2.research.att.com/~volinsky/papers/ASAStatComp.pdf)

---

### Used by the professionals

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/kagglefront.png height=400>

[http://www.kaggle.com/](http://www.kaggle.com/)

---

### Avoid small sample sizes

* Suppose you are predicting a binary outcome 
  * Diseased/healthy
  * Click on ad/not click on ad 
* One classifier is flipping a coin
* Probability of perfect classification is approximately:
  * $\left(\frac{1}{2}\right)^{sample \; size}$
  * $n = 1$ flipping coin 50% chance of 100% accuracy
  * $n = 2$ flipping coin 25% chance of 100% accuracy
  * $n = 10$ flipping coin 0.10% chance of 100% accuracy

---

### Rules of thumb for prediction study design

* If you have a large sample size
  * 60% training
  * 20% test
  * 20% validation
* If you have a medium sample size
  * 60% training
  * 40% testing
* If you have a small sample size
  * Do cross validation
  * Report caveat of small sample size

---

### Some principles to remember

* Set the test/validation set aside and _don't look at it_
* In general _randomly_ sample training and test
* Your data sets must reflect structure of the problem
  * If predictions evolve with time split train/test in time chunks (called[backtesting](http://en.wikipedia.org/wiki/Backtesting) in finance)
* All subsets should reflect as much diversity as possible
  * Random assignment does this
  * You can also try to balance by features - but this is tricky
## Types of errors (c8-w1)
### Basic terms

In general, __Positive__ = identified and __negative__ = rejected. Therefore:

__True positive__ = correctly identified

__False positive__ = incorrectly identified

__True negative__ = correctly rejected

__False negative__ = incorrectly rejected

_Medical testing example_:

__True positive__ = Sick people correctly diagnosed as sick

__False positive__= Healthy people incorrectly identified as sick

__True negative__ = Healthy people correctly identified as healthy

__False negative__ = Sick people incorrectly identified as healthy.

[http://en.wikipedia.org/wiki/Sensitivity_and_specificity](http://en.wikipedia.org/wiki/Sensitivity_and_specificity)


---

### Key quantities


<img class=center src=../../assets/img/keyquantities.png height=500>


[http://en.wikipedia.org/wiki/Sensitivity_and_specificity](http://en.wikipedia.org/wiki/Sensitivity_and_specificity)

http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### Key quantities as fractions


<img class=center src=../../assets/img/keyquantfrac.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/


---

### Screening tests


<img class=center src=../../assets/img/predpos1.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### General population


<img class=center src=../../assets/img/predpos2.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### General population as fractions


<img class=center src=../../assets/img/predpos3.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### At risk subpopulation

<img class=center src=../../assets/img/predpos4.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### At risk subpopulation as fraction

<img class=center src=../../assets/img/predpos5.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/


---

### Key public health issue 

<img class=center src=../../assets/img/mammograms.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

### Key public health issue 

<img class=center src=../../assets/img/prostatescreen.png height=500>



---

### For continuous data

__Mean squared error (MSE)__:

$$\frac{1}{n} \sum_{i=1}^n (Prediction_i - Truth_i)^2$$

__Root mean squared error (RMSE)__:

$$\sqrt{\frac{1}{n} \sum_{i=1}^n(Prediction_i - Truth_i)^2}$$

---

### Common error measures

1. Mean squared error (or root mean squared error)
  * Continuous data, sensitive to outliers
2. Median absolute deviation 
  * Continuous data, often more robust
3. Sensitivity (recall)
  * If you want few missed positives
4. Specificity
  * If you want few negatives called positives
5. Accuracy
  * Weights false positives/negatives equally
6. Concordance
  * One example is [kappa](http://en.wikipedia.org/wiki/Cohen%27s_kappa)
5. Predictive value of a positive (precision)
  * When you are screeing and prevelance is low
  
## Receiver operating characteristic (c8-w1)
### Why a curve?

* In binary classification you are predicting one of two categories
  * Alive/dead
  * Click on ad/don't click
* But your predictions are often quantitative
  * Probability of being alive
  * Prediction on a scale from 1 to 10
* The _cutoff_  you choose gives different results

---

### ROC curves Agent and Statquest

Very well explained by [StatQuest](https://www.youtube.com/watch?v=xugjARegisk)!

The below is the confusion table:

|     | D  | Dc |
|-----|----|----|
| +ve | TP | FP |
| -ve | FN | TN |
	
Sensitivity = TP/(TP/FN); It is the P(+ve|D)
Specificity = FP/(FP+TN); It is the P(-ve|Dc)

TP Rate = Sensitivity

FP Rate = 1-Sensitivity

Basically it is about choosing cutoff. Imagine an S curve for a
logistic regression with Determining obesity and weight. 

Obesity vs Weight.

When the cut off is really low to determine if something is obese
then, 

|     | D | Dc |
|-----|---|----|
| +ve | 4 | 4  |
| -ve | 0 | 0  |

i.e., TP rate of 1 and FP rate of 1. 

For ROC we plot Sensitivity vs 1-Specificity i.e., TP rate vs FP rate.

What we want is TP rate to be high and FP rate to be low. This is what
we will choose as the CutOff.


[http://en.wikipedia.org/wiki/Receiver_operating_characteristic](http://en.wikipedia.org/wiki/Receiver_operating_characteristic)

---

### Bayes

https://stats.stackexchange.com/a/185260/217983

Shows the formula for bayes: Post odds = Likelihood ratio * prior
odds.

i.e., P(D|+)/P(Dc|+) = P(+|D)/P(-|Dc) * P(D)/P(Dc)

P(+|D)/P(-|Dc) = likelihood ratio = sensitivity / 1- specificity

### An example

[http://en.wikipedia.org/wiki/Receiver_operating_characteristic](http://en.wikipedia.org/wiki/Receiver_operating_characteristic)

---

### Area under the curve

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/roc1.png height=200>

* AUC = 0.5: random guessing
* AUC = 1: perfect classifer
* In general AUC of above 0.8 considered "good"

[http://en.wikipedia.org/wiki/Receiver_operating_characteristic](http://en.wikipedia.org/wiki/Receiver_operating_characteristic)

---

### What is good?

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/roc3.png height=400>

[http://en.wikipedia.org/wiki/Receiver_operating_characteristic](http://en.wikipedia.org/wiki/Receiver_operating_characteristic)

## cross validation (c8-w1)
### Study design

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/studyDesign.png height=400>


[http://www2.research.att.com/~volinsky/papers/ASAStatComp.pdf](http://www2.research.att.com/~volinsky/papers/ASAStatComp.pdf)

---

### Key idea

1. Accuracy on the training set (resubstitution accuracy) is optimistic
2. A better estimate comes from an independent set (test set accuracy)
3. But we can't use the test set when building the model or it becomes part of the training set
4. So we estimate the test set accuracy with the training set. 


---

### Cross-validation

_Approach_:

1. Use the training set

2. Split it into training/test sets 

3. Build a model on the training set

4. Evaluate on the test set

5. Repeat and average the estimated errors

_Used for_:

1. Picking variables to include in a model

2. Picking the type of prediction function to use

3. Picking the parameters in the prediction function

4. Comparing different predictors

---

### Random subsampling


<img class=center src=../../assets/img/08_PredictionAndMachineLearning/random.png height=400>


---

### K-fold


<img class=center src=../../assets/img/08_PredictionAndMachineLearning/kfold.png height=400>

---

### Leave one out

Leaving 1 data point out and using everything else, i.e., its like
k-fold but when k=N

### Considerations

* For time series data data must be used in "chunks"
* For k-fold cross validation
  * Larger k = less bias, more variance
  * Smaller k = more bias, less variance
* Random sampling must be done _without replacement_
* Random sampling with replacement is the _bootstrap_
  * Underestimates of the error
  * Can be corrected, but it is complicated ([0.632 Bootstrap](http://www.jstor.org/discover/10.2307/2965703?uid=2&uid=4&sid=21103054448997))
* If you cross-validate to pick predictors estimate you must estimate
  errors on independent data. 
### Why should we Cross Validate: Agent's

**Why do we need CV? CV is only for model checking, not building! PNN!**
https://stats.stackexchange.com/questions/52274/how-to-choose-a-predictive-model-after-k-fold-cross-validation


**Hold-out-validation vs cross-validation**
https://stats.stackexchange.com/questions/104713/hold-out-validation-vs-cross-validation

**Need to look into this**
http://stats.stackexchange.com/questions/18856/is-cross-validation-a-proper-substitute-for-validation-set

**For now:**

> There are pros and cons to estimating error with both CV and
> hold-out validation (the test set you mention). Both are different
> ways of estimating error on unseen data. In some cases, such as
> limited training data, CV might be the only realistic option. Though
> out-of-sample error estimates for CV will be biased toward the
> training set (these are averaged over each fold) and can lead to
> lower estimated error. If you are using random forest there is
> something called 'out of bag error' which is intended to compensate
> for this and can be more accurate.

https://www.coursera.org/learn/practical-machine-learning/discussions/weeks/4/threads/sJN_F-wlEeaYmQ7DfRQSPg

## What data should you use? (c8-w1)
### A succcessful predictor

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/fivethirtyeight.png height=400>

[fivethirtyeight.com](fivethirtyeight.com)

---

### Polling data

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/gallup.png height=400>

[http://www.gallup.com/](http://www.gallup.com/)

---

### Weighting the data

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/538.png height=400>

[http://www.fivethirtyeight.com/2010/06/pollster-ratings-v40-methodology.html](http://www.fivethirtyeight.com/2010/06/pollster-ratings-v40-methodology.html)

---

### Key idea

<center>To predict X use data related to X</center>


---

### Key idea

<center>To predict player performance use data about player performance</center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/moneyball.jpg height=400>

---

### Key idea

<center>To predict movie preferences use data about movie preferences</center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/netflix.png height=400>

---

### Key idea

<center>To predict hospitalizations use data about hospitalizations</center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/heritage.png height=400>

---

### Not a hard rule

<center>To predict flu outbreaks use Google searches</center>

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/flutrends.png height=400>

[http://www.google.org/flutrends/](http://www.google.org/flutrends/)

---

### Looser connection = harder prediction

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/oncotype.png height=300>

---

### Data properties matter

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/fluproblems.jpg height=400>

---

### Unrelated data is the most common mistake

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/choc.png height=400>

[http://www.nejm.org/doi/full/10.1056/NEJMon1211064](http://www.nejm.org/doi/full/10.1056/NEJMon1211064)
## Quiz
https://rpubs.com/delermando/PracticalMachineLearning-Quiz1

## Caret package (c8-w2)
### The caret R package

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/caret.png height=400>

[http://caret.r-forge.r-project.org/](http://caret.r-forge.r-project.org/)

---

### Caret functionality

* Some preprocessing (cleaning)
  * preProcess
* Data splitting
  * createDataPartition
  * createResample
  * createTimeSlices
* Training/testing functions
  * train
  * predict
* Model comparison
  * confusionMatrix

---

### Machine learning algorithms in R

* Linear discriminant analysis
* Regression
* Naive Bayes
* Support vector machines
* Classification and regression trees
* Random forests
* Boosting
* etc. 

---

### Why caret? 

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/predicttable.png height=250>

http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf


--- 

### SPAM Example: Data splitting

```{r loadPackage}
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
```


--- 

### SPAM Example: Fit a model

```{r training, dependson="loadPackage",cache=TRUE}
set.seed(32343)
modelFit <- train(type ~.,data=training, method="glm")
modelFit
```


--- 

### SPAM Example: Final model

```{r finalModel, dependson="training",cache=TRUE}
modelFit <- train(type ~.,data=training, method="glm")
modelFit$finalModel
```


--- 

### SPAM Example: Prediction

```{r predictions, dependson="training",cache=TRUE}
predictions <- predict(modelFit,newdata=testing)
predictions
```

--- 

### SPAM Example: Confusion Matrix

```{r confusion, dependson="predictions",cache=TRUE}
confusionMatrix(predictions,testing$type)
```

---

### Further information

* Caret tutorials:
  * [http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf](http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf)
  * [http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf](http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf)
* A paper introducing the caret package
  * [http://www.jstatsoft.org/v28/i05/paper](http://www.jstatsoft.org/v28/i05/paper)
  
## Data Slicing (c8-w2)


### SPAM Example: Data splitting

DATA Splitting: just split data to have equal 75% training and 25%
sample and trying to keep the ratio of spam and non spam in the same
order.

```{r loadPackage}
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
```

---

### SPAM Example: K-fold

K partitions are made on radmomized order of sample. Then we choose
first k partition as test and the rest of the data as training and so
on.


```{r kfold,dependson="loadPackage"}
set.seed(32323)
folds <- createFolds(y=spam$type,k=10,
                             list=TRUE,returnTrain=TRUE)
sapply(folds,length)
folds[[1]][1:10]
```

---

### SPAM Example: Return test

```{r kfoldtest,dependson="loadPackage"}
set.seed(32323)
folds <- createFolds(y=spam$type,k=10,
                             list=TRUE,returnTrain=FALSE)
sapply(folds,length)
folds[[1]][1:10]
```

---

### SPAM Example: Resampling

Here we are talking about pure resampling of the entire data with repitition
```{r resample,dependson="loadPackage"}
set.seed(32323)
folds <- createResample(y=spam$type,times=10,
                             list=TRUE)
sapply(folds,length)
folds[[1]][1:10]
```

``` r
Resample01 Resample02 Resample03 Resample04 Resample05 Resample06 Resample07 Resample08 Resample09 
      4601       4601       4601       4601       4601       4601       4601       4601       4601 
Resample10 
      4601 
```

``` r
 [1]  1  2  3  3  3  5  5  7  8 12
```

---

### SPAM Example: Time Slices

```{r time,dependson="loadPackage"}
set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y=tme,initialWindow=20,
                          horizon=10)
names(folds)
folds$train[[1]]
folds$test[[1]]
```

``` r
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

``` r
[1] 21 22 23 24 25 26 27 28 29 30
```

---

### Further information

* Caret tutorials:
  * [http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf](http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf)
  * [http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf](http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf)
* A paper introducing the caret package
  * [http://www.jstatsoft.org/v28/i05/paper](http://www.jstatsoft.org/v28/i05/paper)
  
## Training options (c8-w2) Train command
### SPAM Example

```{r loadPackage,cache=TRUE}
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
modelFit <- train(type ~.,data=training, method="glm")
```

---

### Train options

```{r ,dependson="loadPackage"}
args(train.default) ## does not work
args(caret:::train.default) ##works
```

the above command is not found
``` r
function (x, y, method = "rf", preProcess = NULL, ..., weights = NULL, 
    metric = ifelse(is.factor(y), "Accuracy", "RMSE"), maximize = ifelse(metric == 
        "RMSE", FALSE, TRUE), trControl = trainControl(), tuneGrid = NULL, 
    tuneLength = 3) 
NULL
```


---

### Metric options

__Continous outcomes__:
  * _RMSE_ = Root mean squared error
  * _RSquared_ = $R^2$ from regression models

__Categorical outcomes__:
  * _Accuracy_ = Fraction correct
  * _Kappa_ = A measure of [concordance](http://en.wikipedia.org/wiki/Cohen%27s_kappa)
  
  

--- 

### trainControl

```{r , dependson="loadPackage",cache=TRUE}
args(trainControl)
```

``` r
function (method = "boot", number = ifelse(method %in% c("cv", 
    "repeatedcv"), 10, 25), repeats = ifelse(method %in% c("cv", 
    "repeatedcv"), 1, number), p = 0.75, initialWindow = NULL, 
    horizon = 1, fixedWindow = TRUE, verboseIter = FALSE, returnData = TRUE, 
    returnResamp = "final", savePredictions = FALSE, classProbs = FALSE, 
    summaryFunction = defaultSummary, selectionFunction = "best", 
    custom = NULL, preProcOptions = list(thresh = 0.95, ICAcomp = 3, 
        k = 5), index = NULL, indexOut = NULL, timingSamps = 0, 
    predictionBounds = rep(FALSE, 2), seeds = NA, allowParallel = TRUE) 
NULL
```

--- 

### trainControl resampling

* _method_
  * _boot_ = bootstrapping
  * _boot632_ = bootstrapping with adjustment
  * _cv_ = cross validation
  * _repeatedcv_ = repeated cross validation
  * _LOOCV_ = leave one out cross validation
* _number_
  * For boot/cross validation
  * Number of subsamples to take
* _repeats_
  * Number of times to repeate subsampling
  * If big this can _slow things down_


---

### Setting the seed

* It is often useful to set an overall seed
* You can also set a seed for each resample
* Seeding each resample is useful for parallel fits



--- 


### seed example

```{r , dependson="seedExample",cache=TRUE}
set.seed(1235)
modelFit2 <- train(type ~.,data=training, method="glm")
modelFit2
```


--- 

### seed example

```{r , dependson="seedExample",cache=TRUE}
set.seed(1235)
modelFit3 <- train(type ~.,data=training, method="glm")
modelFit3
```


--- 

### Further resources

* [Caret tutorial](http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf)
* [Model training and tuning](http://caret.r-forge.r-project.org/training.html)

## Plotting predictors (c8-w2) exploratory analysis points
### Example: predicting wages

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/wages.jpg height=350>

Image Credit [http://www.cahs-media.org/the-high-cost-of-low-wages](http://www.cahs-media.org/the-high-cost-of-low-wages)

Data from: [ISLR package](http://cran.r-project.org/web/packages/ISLR) from the book: [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)  



---

### Example: Wage data

```{r loadData,cache=TRUE}
library(ISLR); library(ggplot2); library(caret);
data(Wage)
summary(Wage)
```



---

### Get training/test sets

```{r trainingTest,dependson="loadData",cache=TRUE}
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training); dim(testing)
```


---

### Feature plot (*caret* package)

```{r ,dependson="trainingTest",fig.height=4,fig.width=4}
featurePlot(x=training[,c("age","education","jobclass")],
            y = training$wage,
            plot="pairs")
```

Plot every variable against each other!

---

### Qplot (*ggplot2* package)


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qplot(age,wage,data=training)
```


---

### Qplot with color (*ggplot2* package)


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qplot(age,wage,colour=jobclass,data=training)
```


---

### Add regression smoothers (*ggplot2* package)


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qq <- qplot(age,wage,colour=education,data=training)
qq +  geom_smooth(method='lm',formula=y~x)
```


---

### cut2, making factors (*Hmisc* package)


```{r cut2,dependson="trainingTest",fig.height=4,fig.width=6,cache=TRUE}
cutWage <- cut2(training$wage,g=3)
table(cutWage)
```

---

### Boxplots with cut2


```{r ,dependson="cut2plot",fig.height=4,fig.width=6,cache=TRUE}
p1 <- qplot(cutWage,age, data=training,fill=cutWage,
      geom=c("boxplot"))
p1
```

---

### Boxplots with points overlayed
## Basic preprocessing (c8-w2)
### Why preprocess?

```{r loadPackage,cache=TRUE,fig.height=3.5,fig.width=3.5}
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
hist(training$capitalAve,main="",xlab="ave. capital run length")
```

Histogram shows large variance which might affect the algorithms! how
exactly?

---

### Why preprocess?

```{r ,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
mean(training$capitalAve)
sd(training$capitalAve)
```

---

### **Standardizing**

```{r ,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve  - mean(trainCapAve))/sd(trainCapAve) 
mean(trainCapAveS)
sd(trainCapAveS)
```

---

### Standardizing - test set

```{r ,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve  - mean(trainCapAve))/sd(trainCapAve) 
mean(testCapAveS)
sd(testCapAveS)
```

https://stats.stackexchange.com/questions/29781/when-conducting-multiple-regression-when-should-you-center-your-predictor-varia

---

### Standardizing - _preProcess_ function

```{r preprocess,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
preObj <- preProcess(training[,-58],method=c("center","scale")) 
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)
```

**`preProcess` takes the values from training set and makes the model,
which is then predicted for either training or test data set!**

---

### Standardizing - _preProcess_ function

```{r ,dependson="preprocess",cache=TRUE,fig.height=3.5,fig.width=3.5}
testCapAveS <- predict(preObj,testing[,-58])$capitalAve
mean(testCapAveS)
sd(testCapAveS)
```

---

### Standardizing - _preProcess_ argument

```{r training, dependson="loadPackage",cache=TRUE}
set.seed(32343)
modelFit <- train(type ~.,data=training,
                  preProcess=c("center","scale"),method="glm")
modelFit
```


---

### Standardizing - Box-Cox transforms

```{r ,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=7}
preObj <- preProcess(training[,-58],method=c("BoxCox"))
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
par(mfrow=c(1,2)); hist(trainCapAveS); qqnorm(trainCapAveS)
```

Centering and scaling reduces variability. Another think we can do is
remove high variability values and another thing following that we can
do is to use another transformation like BOXCOX. What is it? NO
IDEA. When to use it? NO IDEA!

---

### Standardizing - Imputing data - handling NA

```{r knn,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=7}
set.seed(13343)
# Make some values NA
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1],size=1,prob=0.05)==1
training$capAve[selectNA] <- NA

# Impute and standardize
preObj <- preProcess(training[,-58],method="knnImpute")
capAve <- predict(preObj,training[,-58])$capAve

# Standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)
```

**knnimpute also seems to change the columns that don't have NA**

---

### Standardizing - Imputing data

```{r ,dependson="knn",cache=TRUE,fig.height=3.5,fig.width=7}
quantile(capAve - capAveTruth)
quantile((capAve - capAveTruth)[selectNA])
quantile((capAve - capAveTruth)[!selectNA])
```
	
**Why is !selectNA not completely equal to 0** because of KNNIMPUTE?


### Notes and further reading

* **Training and test must be processed in the same way**
* Test transformations will likely be imperfect
  * Especially if the test/training sets collected at different times
* Careful when transforming factor variables!
* [preprocessing with caret](http://caret.r-forge.r-project.org/preprocess.html)

### Agent's notes on cleaning data

Based on [here](https://machinelearningmastery.com/pre-process-your-dataset-in-r/). All in caret!

“BoxCox“: apply a Box–Cox transform, values must be non-zero and positive.
“YeoJohnson“: apply a Yeo-Johnson transform, like a BoxCox, but values can be negative.
“expoTrans“: apply a power transform like BoxCox and YeoJohnson.
“zv“: remove attributes with a zero variance (all the same value).
“nzv“: remove attributes with a near zero variance (close to the same value).
“center“: subtract mean from values.
“scale“: divide values by standard deviation.
“range“: normalize values.
“pca“: transform data to the principal components.
“ica“: transform data to the independent components.
“spatialSign“: project data onto a unit circle.


## Covariate creation (c8-w2)
### Two levels of covariate creation

**Level 1: From raw data to covariate**

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/covCreation1.png height=200>

**Level 2: Transforming tidy covariates** 

```{r spamData,fig.height=4,fig.width=4}
library(kernlab);data(spam)
spam$capitalAveSq <- spam$capitalAve^2
```


---

### Level 1, Raw data -> covariates

* Depends heavily on application
* The balancing act is summarization vs. information loss
* Examples:
  * Text files: frequency of words, frequency of phrases ([Google ngrams](https://books.google.com/ngrams)), frequency of capital letters.
  * Images: Edges, corners, blobs, ridges ([computer vision feature detection](http://en.wikipedia.org/wiki/Feature_detection_(computer_vision)))
  * Webpages: Number and type of images, position of elements, colors, videos ([A/B Testing](http://en.wikipedia.org/wiki/A/B_testing))
  * People: Height, weight, hair color, sex, country of origin. 
* **The more knowledge of the system you have the better the job you will do.** 
* **When in doubt, err on the side of more features**
* Can be automated, but use caution!


---

### Level 2, Tidy covariates -> new covariates

* More necessary for some methods (regression, svms) than for others (classification trees).
* **Should be done _only on the training set_**
* The **best approach is through exploratory analysis** (plotting/tables)
* New covariates should be added to data frames

**Only on the training set? but then how do you use it on the test
variables?** Later discussed?

---

### Load example data


```{r loadData,cache=TRUE}
library(ISLR); library(caret); data(Wage);
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
```


---

### Common covariates to add, dummy variables

__Basic idea - convert factor variables to [indicator variables](http://bit.ly/19ZhWB6)__

```{r dummyVar,dependson="loadData"}
table(training$jobclass)
dummies <- dummyVars(wage ~ jobclass,data=training)
head(predict(dummies,newdata=training))
```

---

### Removing zero covariates

```{r ,dependson="dummyVar"}
nsv <- nearZeroVar(training,saveMetrics=TRUE)
nsv
```

``` r
           freqRatio percentUnique zeroVar   nzv
year           1.029       0.33302   FALSE FALSE
age            1.122       2.80685   FALSE FALSE
sex            0.000       0.04757    TRUE  TRUE
maritl         3.159       0.23787   FALSE FALSE
race           8.529       0.19029   FALSE FALSE
education      1.492       0.23787   FALSE FALSE
region         0.000       0.04757    TRUE  TRUE
jobclass       1.077       0.09515   FALSE FALSE
health         2.452       0.09515   FALSE FALSE
health_ins     2.269       0.09515   FALSE FALSE
logwage        1.198      17.26927   FALSE FALSE
wage           1.185      18.07802   FALSE FALSE
```

Removing low variability covariates!

---

### Spline basis

```{r splines,dependson="dummyVar",cache=TRUE}
library(splines)
bsBasis <- bs(training$age,df=3) 
bsBasis
```

_See also_: ns(),poly()

---

### Fitting curves with splines

```{r ,dependson="splines",fig.height=4,fig.width=4}
lm1 <- lm(wage ~ bsBasis,data=training)
plot(training$age,training$wage,pch=19,cex=0.5)
points(training$age,predict(lm1,newdata=training),col="red",pch=19,cex=0.5)
```


---

### Splines on the test set

```{r ,dependson="splines",fig.height=4,fig.width=4}
predict(bsBasis,age=testing$age)
```


---

### Notes and further reading

* Level 1 feature creation (raw data to covariates)
  * Science is key. Google "**feature extraction for [data type]"**
  * Err on overcreation of features
  * In some applications (images, voices) automated feature creation is possible/necessary
    * http://www.cs.nyu.edu/~yann/talks/lecun-ranzato-icml2013.pdf
* Level 2 feature creation (covariates to new covariates)
  * The function _preProcess_ in _caret_ will handle some preprocessing.
  * Create new covariates if you think they will improve fit
  * Use exploratory analysis on the training set for creating them
  * Be careful about overfitting!
* [preprocessing with caret](http://caret.r-forge.r-project.org/preprocess.html)
* If you want to fit spline models, use the _gam_ method in the _caret_ package which allows smoothing of multiple variables.
* More on feature creation/data tidying in the Obtaining Data course
  from the Data Science course track. 
  
## Preprocessing with principal components (c8-w2)
### Correlated predictors

```{r loadPackage,cache=TRUE,fig.height=3.5,fig.width=3.5}
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
M <- abs(cor(training[,-58]))
diag(M) <- 0
which(M > 0.8,arr.ind=T)
```

Check which variables have high correalation

---

### Correlated predictors

```{r,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])
```

---

### Basic PCA idea

* We might not need every predictor ??? 
* A weighted combination of predictors might be better Why? how?
* We should pick this combination to capture the "most information" possible
* Benefits
  * Reduced number of predictors; computation wise?
  * Reduced noise (due to averaging);


---

### We could rotate the plot ??? rotate?

$$ X = 0.71 \times {\rm num 415} + 0.71 \times {\rm num857}$$

$$ Y = 0.71 \times {\rm num 415} - 0.71 \times {\rm num857}$$

```{r,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 0.71*training$num415 - 0.71*training$num857
plot(X,Y)
```

---

### Related problems

You have multivariate variables $X_1,\ldots,X_n$ so $X_1 =
(X_{11},\ldots,X_{1m})$

* Find a new set of multivariate variables that are uncorrelated and
  explain as much variance as possible.
* If you put all the variables together in one matrix, find the best
  matrix created with fewer variables (lower rank) that explains the
  original data. (as you do not want to overfit? or ?)


The first goal is <font color="#330066">statistical</font> and the
second goal is <font color="#993300">data compression</font>.

---

### Related solutions - PCA/SVD

__SVD__

If $X$ is a matrix with each variable in a column and each observation in a row then the SVD is a "matrix decomposition"

$$ X = UDV^T$$

where the columns of $U$ are orthogonal (left singular vectors), the columns of $V$ are orthogonal (right singluar vectors) and $D$ is a diagonal matrix (singular values). 

__PCA__

The principal components are equal to the right singular values if you first scale (subtract the mean, divide by the standard deviation) the variables.

---

### Principal components in R - prcomp

```{r prcomp,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])
```

---

### Principal components in R - prcomp

```{r ,dependson="prcomp",cache=TRUE,fig.height=3.5,fig.width=3.5}
prComp$rotation
```

``` r
          PC1     PC2
num415 0.7081  0.7061
num857 0.7061 -0.7081
```

---

### PCA on SPAM data

```{r spamPC,dependson="loadPackage",cache=TRUE,fig.height=3.5,fig.width=3.5}
typeColor <- ((spam$type=="spam")*1 + 1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor,xlab="PC1",ylab="PC2")
```

**Why Log10? Because this will make the data look more gaussion! So
what? No idea, why would rd peng explain these things?** Some of the
variables are skewed and not normal looking? so ? What is the issue?

---

### PCA with caret

```{r ,dependson="spamPC",cache=TRUE,fig.height=3.5,fig.width=3.5}
preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)
```


---

### Preprocessing with PCA

```{r pcaCaret,dependson="spamPC",cache=TRUE,fig.height=3.5,fig.width=3.5}
preProc <- preProcess(log10(training[,-58]+1),method="pca",pcaComp=2)
trainPC <- predict(preProc,log10(training[,-58]+1))
modelFit <- train(training$type ~ .,method="glm",data=trainPC)
```

Also can be done with `prcomp(log10(training[,-58]),scale=TRUE)`,
preProcess seems to already use `Scale` in it! Needs to be
investigated as needed!

---

### Preprocessing with PCA

```{r ,dependson="pcaCaret",cache=TRUE,fig.height=3.5,fig.width=3.5}
testPC <- predict(preProc,log10(testing[,-58]+1))
confusionMatrix(testing$type,predict(modelFit,testPC))
```

---

### Alternative (sets # of PCs)

```{r ,dependson="pcaCaret",cache=TRUE,fig.height=3.5,fig.width=3.5}
modelFit <- train(training$type ~ .,method="glm",preProcess="pca",data=training)
confusionMatrix(testing$type,predict(modelFit,testing))
```

---

### Final thoughts on PCs

* Most useful for linear-type models
* **Can make it harder to interpret predictors**
* Watch out for outliers! 
  * Transform first (with logs/Box Cox)
  * Plot predictors to identify problems
* For more info see 
  * Exploratory Data Analysis
  * [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
  

## predicting with regression (c8-w2)

### Key ideas

* Fit a simple regression model
* Plug in new covariates and multiply by the coefficients
* Useful when the linear model is (nearly) correct

__Pros__:
* Easy to implement
* Easy to interpret

__Cons__:
* Often poor performance in nonlinear settings


---

### Example: Old faithful eruptions

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/yellowstone.png height=400>

Image Credit/Copyright Wally Pacholka [http://www.astropics.com/](http://www.astropics.com/)

---

### Example: Old faithful eruptions

```{r faith}
library(caret);data(faithful); set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting,
                              p=0.5, list=FALSE)
trainFaith <- faithful[inTrain,]; testFaith <- faithful[-inTrain,]
head(trainFaith)
```

---

### Eruption duration versus waiting time

```{r dependson="faith",fig.height=4,fig.width=4}
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="Waiting",ylab="Duration")
```

---

### Fit a linear model 

$$ ED_i = b_0 + b_1 WT_i + e_i $$

```{r faithlm,dependson="faith",fig.height=4,fig.width=4}
lm1 <- lm(eruptions ~ waiting,data=trainFaith)
summary(lm1)
```


---
### Model fit

```{r dependson="faithlm",fig.height=4,fig.width=4}
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="Waiting",ylab="Duration")
lines(trainFaith$waiting,lm1$fitted,lwd=3)
```

---

### Predict a new value

$$\hat{ED} = \hat{b}_0 + \hat{b}_1 WT$$

```{r ,dependson="faithlm",fig.height=4,fig.width=4}
coef(lm1)[1] + coef(lm1)[2]*80
newdata <- data.frame(waiting=80)
predict(lm1,newdata)
```

---

### Plot predictions - training and test

```{r ,dependson="faithlm",fig.height=4,fig.width=8}
par(mfrow=c(1,2))
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="Waiting",ylab="Duration")
lines(trainFaith$waiting,predict(lm1),lwd=3)
plot(testFaith$waiting,testFaith$eruptions,pch=19,col="blue",xlab="Waiting",ylab="Duration")
lines(testFaith$waiting,predict(lm1,newdata=testFaith),lwd=3)
```

---

### Get training set/test set errors

```{r ,dependson="faithlm",fig.height=4,fig.width=4}
# Calculate RMSE on training
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))
# Calculate RMSE on test
sqrt(sum((predict(lm1,newdata=testFaith)-testFaith$eruptions)^2))
```

---

### Prediction intervals

```{r ,dependson="faithlm",fig.height=4,fig.width=4}
pred1 <- predict(lm1,newdata=testFaith,interval="prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting,testFaith$eruptions,pch=19,col="blue")
matlines(testFaith$waiting[ord],pred1[ord,],type="l",,col=c(1,2,2),lty = c(1,1,1), lwd=3)
```

**matlines somehow gives prediction interval. Need to see how it comes
about**

---

### Same process with caret

```{r caretfaith,dependson="faith",fig.height=4,fig.width=4}
modFit <- train(eruptions ~ waiting,data=trainFaith,method="lm")
summary(modFit$finalModel)
```


---

### Notes and further reading

* Regression models with multiple covariates can be included
* Often useful in combination with other models 
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Modern applied statistics with S](http://www.amazon.com/Modern-Applied-Statistics-W-N-Venables/dp/0387954570)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)


## Predicting with regression multiple covariates (c8-w2)

### Example: predicting wages

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/wages.jpg height=350>

Image Credit [http://www.cahs-media.org/the-high-cost-of-low-wages](http://www.cahs-media.org/the-high-cost-of-low-wages)

Data from: [ISLR package](http://cran.r-project.org/web/packages/ISLR) from the book: [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)



---

### Example: Wage data

```{r loadData,cache=TRUE}
library(ISLR); library(ggplot2); library(caret);
data(Wage); Wage <- subset(Wage,select=-c(logwage))
summary(Wage)
```



---

### Get training/test sets

```{r trainingTest,dependson="loadData",cache=TRUE}
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
dim(training); dim(testing)
```



---

### Feature plot

```{r ,dependson="trainingTest",fig.height=4,fig.width=4}
featurePlot(x=training[,c("age","education","jobclass")],
            y = training$wage,
            plot="pairs")
```


---

### Plot age versus wage


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qplot(age,wage,data=training)
```


---

### Plot age versus wage colour by jobclass


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qplot(age,wage,colour=jobclass,data=training)
```


---

### Plot age versus wage colour by education


```{r ,dependson="trainingTest",fig.height=4,fig.width=6}
qplot(age,wage,colour=education,data=training)
```

---

### Fit a linear model 

$$ ED_i = b_0 + b_1 age + b_2 I(Jobclass_i="Information") + \sum_{k=1}^4 \gamma_k I(education_i= level k) $$

```{r modelFit,dependson="trainingTest", cache=TRUE,fig.height=4,fig.width=4}
modFit<- train(wage ~ age + jobclass + education,
               method = "lm",data=training)
finMod <- modFit$finalModel
print(modFit)
```

Education levels: 1 = HS Grad, 2 = Some College, 3 = College Grad, 4 = Advanced Degree

---

### Diagnostics

```{r,dependson="modelFit",fig.height=5,fig.width=5}
plot(finMod,1,pch=19,cex=0.5,col="#00000010")
```


---

### Color by variables not used in the model 

```{r,dependson="modelFit",fig.height=4,fig.width=6}
qplot(finMod$fitted,finMod$residuals,colour=race,data=training)
```

---

### Plot by index

```{r,dependson="modelFit",fig.height=5,fig.width=5}
plot(finMod$residuals,pch=19)
```


---

### Predicted versus truth in test set

```{r predictions, dependson="modelFit",fig.height=4,fig.width=6}
pred <- predict(modFit, testing)
qplot(wage,pred,colour=year,data=testing)
```

---

### If you want to use all covariates

```{r allCov,dependson="trainingTest",fig.height=4,fig.width=4,warning=FALSE}
modFitAll<- train(wage ~ .,data=training,method="lm")
pred <- predict(modFitAll, testing)
qplot(wage,pred,data=testing)
```


---

### Notes and further reading

* Often useful in combination with other models 
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Modern applied statistics with S](http://www.amazon.com/Modern-Applied-Statistics-W-N-Venables/dp/0387954570)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
## Quiz c8-w2
1. Load the Alzheimer's disease data using the commands:

	``` r
	library(AppliedPredictiveModeling)
	data(AlzheimerDisease)
	```
	Which of the following commands will create non-overlapping
    training and test sets with about 50% of the observations assigned
    to each?
	
	```R
	adData = data.frame(diagnosis,predictors)
	trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
	training = adData[trainIndex,]
	testing = adData[-trainIndex,]
	```

	
2. 

	``` r
	library(AppliedPredictiveModeling)
	data(concrete)
	library(caret)
	set.seed(1000)
	inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
	training = mixtures[ inTrain,]
	testing = mixtures[-inTrain,]
	```
	
	Make a plot of the outcome (CompressiveStrength) versus the index
    of the samples. Color by each of the variables in the data set
    (you may find the cut2() function in the Hmisc package useful for
    turning continuous covariates into factors). What do you notice in
    these plots?
	
	Ans: There is a non-random pattern in the plot of the outcome
    versus index that does not appear to be perfectly explained by any
    predictor suggesting a variable may be missing.
	
	``` r
	qplot(1:dim(training)[[1]],CompressiveStrength,color=Water, data=training)
	```

3. 

	``` r
	library(AppliedPredictiveModeling)
	data(concrete)
	library(caret)
	set.seed(1000)
	inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
	training = mixtures[ inTrain,]
	testing = mixtures[-inTrain,]
	```
	
	Make a histogram and confirm the SuperPlasticizer variable is
    skewed. Normally you might use the log transform to try to make
    the data more symmetric. Why would that be a poor choice for this
    variable?

	There are a large number of values that are the same and even if
    you took the log(SuperPlasticizer + 1) they would still all be
    identical so the distribution would not be symmetric.

4. Load the Alzheimer's disease data using the commands:



	``` r
	library(caret)
	library(AppliedPredictiveModeling)
	set.seed(3433)
	data(AlzheimerDisease)
	adData = data.frame(diagnosis,predictors)
	inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
	training = adData[ inTrain,]
	testing = adData[-inTrain,]
	```
	
	Find all the predictor variables in the training set that begin
    with IL. Perform principal components on these variables with the
    preProcess() function from the caret package. Calculate the number
    of principal components needed to capture 90% of the variance. How
    many are there?
	
	Ans: 9

	``` r
	pca <- prcomp(training[,cnam],scale=T)
	eigs <- pca$sdev^2
	sum(eigs[1:7])/sum(eigs)
	
	## or 
	
	summary(pca)
	```
	
	Note: Scale=TRUE has to be given if you want it to match with the
    pre-Processing PCA!

	``` r
	preProc <- preProcess(training[,cnam],method="pca",thresh=0.9)
	preProc
	```

5. 

	``` r
	library(caret)
	library(AppliedPredictiveModeling)
	set.seed(3433)data(AlzheimerDisease)
	adData = data.frame(diagnosis,predictors)
	inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]training = adData[ inTrain,]
	testing = adData[-inTrain,]
	```
	
	Create a training data set consisting of only the predictors with
    variable names beginning with IL and the diagnosis. Build two
    predictive models, one using the predictors as they are and one
    using PCA with principal components explaining 80% of the variance
    in the predictors. Use method="glm" in the train function.

	What is the accuracy of each method in the test set? Which is more
	accurate?
	
	**Ans:**
	
	``` r
	library(caret)
	library(AppliedPredictiveModeling)
	set.seed(3433);data(AlzheimerDisease)
	adData = data.frame(diagnosis,predictors)
	inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]];training = adData[ inTrain,]
	testing = adData[-inTrain,]
	
	
	cnam <- colnames(training[grep("^IL",colnames(training))])
	
	modelFit <- train(y=training$diagnosis,x=training[,cnam],method=c("glm")
	predictions <- predict(modelFit,newdata=testing[,cnam])
	confusionMatrix(predictions,testing$diagnosis)
	
	preProc <- preProcess(training[,cnam],method="pca",thresh=0.8)
	trainPC <- predict(preProc,training[,cnam])
	modelFitPC <- train(y=training$diagnosis,x=trainPC,method="glm")
	
	predictionsPC <- predict(modelFitPC,newdata=predict(preProc,testing[,cnam]))
	confusionMatrix(predictionsPC,testing$diagnosis)

	``` 
	
	This works as the same as this solution
	(http://www.rpubs.com/ryantillis/Machine_Learning_2) and this
	solution (https://rpubs.com/Chuk_Yong/248560) but I do not
	get the 65% but I get 72% for PCA, but the rpubs guys seems to get it!
	WTF?????
	
	
	https://rpubs.com/Chuk_Yong/248560 ; reported answer 65% and 72%,
    actual answer when I run it: 75% and 72%
	
	``` r
	library(caret)
	library(AppliedPredictiveModeling)
	set.seed(3433)
	data(AlzheimerDisease)
	adData = data.frame(diagnosis,predictors)
	inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
	training = adData[ inTrain,]
	testing = adData[-inTrain,]

	# grep all columns with IL and diagnosis in the traning and testing set
	trainingIL <- training[,grep("^IL|diagnosis", names(training))]
	testingIL <- testing[,grep("^IL|diagnosis", names(testing))]

	# non-PCA
	model <- train(diagnosis ~ ., data = trainingIL, method = "glm")
	predict_model <- predict(model, newdata= testingIL)
	matrix_model <- confusionMatrix(predict_model, testingIL$diagnosis)
	matrix_model$overall[1]
	
	
	modelPCA <- train(diagnosis ~., data = trainingIL, method = "glm", preProcess = "pca",trControl=trainControl(preProcOptions=list(thresh=0.8)))
	matrix_modelPCA <- confusionMatrix(testingIL$diagnosis, predict(modelPCA, testingIL))
	matrix_modelPCA$overall[1]
	```

## c8-w3

**Predicting with Trees**

https://www.youtube.com/watch?v=eKD5gxPPeY0&list=PLBv09BD7ez_4temBw7vLA19p3tdQH6FYO

So basically you look at different variables and try to classify them
as groups. i.e., If it is sunny, heavy winds and rainy, will tom go to
work?

**With Bagging**

We do bootstrapping (mulitple resampling with replacement), then
average the results of multiple fits to reduce variability but keeps
the bias the same!

**Random forests**

Bootstrapping and then taking each set to make own decision tree and
prediction. Now we average the prediction.

## Predicting with trees (c8-w3)
### Key ideas

* Iteratively split variables into groups
* Evaluate "homogeneity" within each group
* Split again if necessary

__Pros__:

* Easy to interpret
* Better performance in nonlinear settings

__Cons__:

* Without pruning/cross-validation can lead to overfitting
* Harder to estimate uncertainty
* Results may be variable


---

### Example Tree

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/obamaTree.png height=450>

[http://graphics8.nytimes.com/images/2008/04/16/us/0416-nat-subOBAMA.jpg](http://graphics8.nytimes.com/images/2008/04/16/us/0416-nat-subOBAMA.jpg)

---

### Basic algorithm

1. Start with all variables in one group
2. Find the variable/split that best separates the outcomes
3. Divide the data into two groups ("leaves") on that split ("node")
4. Within each split, find the best variable/split that separates the outcomes
5. Continue until the groups are too small or sufficiently "pure"


---

### Measures of impurity

$$\hat{p}_{mk} = \frac{1}{N_m}\sum_{x_i\; in \; Leaf \; m}\mathbb{1}(y_i = k)$$

__Misclassification Error__: 
$$ 1 - \hat{p}_{m k(m)}; k(m) = {\rm most; common; k}$$ 
* 0 = perfect purity
* 0.5 = no purity

__Gini index__:
$$ \sum_{k \neq k'} \hat{p}_{mk} \times \hat{p}_{mk'} = \sum_{k=1}^K \hat{p}_{mk}(1-\hat{p}_{mk}) = 1 - \sum_{k=1}^K p_{mk}^2$$

* 0 = perfect purity
* 0.5 = no purity

http://en.wikipedia.org/wiki/Decision_tree_learning

---

### Measures of impurity

__Deviance/information gain__:

$$ -\sum_{k=1}^K \hat{p}_{mk} \log_2\hat{p}_{mk} $$
* 0 = perfect purity
* 1 = no purity

http://en.wikipedia.org/wiki/Decision_tree_learning


--- &twocol w1:50% w2:50%
### Measures of impurity

*** =left

```{r leftplot,fig.height=3,fig.width=4,echo=FALSE,fig.align="center"}
par(mar=c(0,0,0,0)); set.seed(1234); x = rep(1:4,each=4); y = rep(1:4,4)
plot(x,y,xaxt="n",yaxt="n",cex=3,col=c(rep("blue",15),rep("red",1)),pch=19)
```

* __Misclassification:__ $1/16 = 0.06$
* __Gini:__ $1 - [(1/16)^2 + (15/16)^2] = 0.12$
* __Information:__$-[1/16 \times log2(1/16) + 15/16 \times log2(15/16)] = 0.34$

*** =right

```{r,dependson="leftplot",fig.height=3,fig.width=4,echo=FALSE,fig.align="center"}
par(mar=c(0,0,0,0)); 
plot(x,y,xaxt="n",yaxt="n",cex=3,col=c(rep("blue",8),rep("red",8)),pch=19)
```

* __Misclassification:__ $8/16 = 0.5$
* __Gini:__ $1 - [(8/16)^2 + (8/16)^2] = 0.5$
* __Information:__$-[1/16 \times log2(1/16) + 15/16 \times log2(15/16)] = 1$




---

### Example: Iris Data

```{r iris, cache=TRUE}
data(iris); library(ggplot2)
names(iris)
table(iris$Species)
```


---

### Create training and test sets

```{r trainingTest, dependson="iris",cache=TRUE}
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
```


---

### Iris petal widths/sepal width

```{r, dependson="trainingTest",fig.height=4,fig.width=6}
qplot(Petal.Width,Sepal.Width,colour=Species,data=training)
```


---

### Iris petal widths/sepal width

```{r createTree, dependson="trainingTest", cache=TRUE}
library(caret)
modFit <- train(Species ~ .,method="rpart",data=training)
print(modFit$finalModel)
```

---

### Plot tree

```{r, dependson="createTree", fig.height=4.5, fig.width=4.5}
plot(modFit$finalModel, uniform=TRUE, 
      main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)
```


---

### Prettier plots

```{r, dependson="createTree", fig.height=4.5, fig.width=4.5}
library(rattle)
fancyRpartPlot(modFit$finalModel)
```

---

### Predicting new values

```{r newdata, dependson="createTree", fig.height=4.5, fig.width=4.5, cache=TRUE}
predict(modFit,newdata=testing)
```

---

### Notes and further resources

* Classification trees are non-linear models
  * They use interactions between variables
  * Data transformations may be less important (monotone transformations)
  * Trees can also be used for regression problems (continuous outcome)
* Note that there are multiple tree building options
in R both in the caret package - [party](http://cran.r-project.org/web/packages/party/index.html), [rpart](http://cran.r-project.org/web/packages/rpart/index.html) and out of the caret package - [tree](http://cran.r-project.org/web/packages/tree/index.html)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Classification and regression trees](http://www.amazon.com/Classification-Regression-Trees-Leo-Breiman/dp/0412048418)
## Bagging (c8-w3)
### Bootstrap aggregating (bagging)

__Basic idea__: 

1. Resample cases and recalculate predictions
2. Average or majority vote

__Notes__:

* Similar bias 
* Reduced variance
* More useful for non-linear functions


---

### Ozone data

```{r ozoneData, cache=TRUE}
library(ElemStatLearn); data(ozone,package="ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
head(ozone)
```
[http://en.wikipedia.org/wiki/Bootstrap_aggregating](http://en.wikipedia.org/wiki/Bootstrap_aggregating)


---

### Bagged loess

```{r baggedOzone, dependson="ozoneData",cache=TRUE}
ll <- matrix(NA,nrow=10,ncol=155)
for(i in 1:10){
  ss <- sample(1:dim(ozone)[1],replace=T)
  ozone0 <- ozone[ss,]; ozone0 <- ozone0[order(ozone0$ozone),]
  loess0 <- loess(temperature ~ ozone,data=ozone0,span=0.2)
  ll[i,] <- predict(loess0,newdata=data.frame(ozone=1:155))
}
```

---

### Bagged loess

```{r, dependson="baggedOzone",fig.height=4.5,fig.width=4.5}
plot(ozone$ozone,ozone$temperature,pch=19,cex=0.5)
for(i in 1:10){lines(1:155,ll[i,],col="grey",lwd=2)}
lines(1:155,apply(ll,2,mean),col="red",lwd=2)
```


---

### Bagging in caret

* Some models perform bagging for you, in `train` function consider `method` options 
  * `bagEarth` 
  * `treebag`
  * `bagFDA`
* Alternatively you can bag any model you choose using the `bag` function

---

### More bagging in caret

```{r bag1}
predictors = data.frame(ozone=ozone$ozone)
temperature = ozone$temperature
treebag <- bag(predictors, temperature, B = 10,
                bagControl = bagControl(fit = ctreeBag$fit,
                                        predict = ctreeBag$pred,
                                        aggregate = ctreeBag$aggregate))
```

http://www.inside-r.org/packages/cran/caret/docs/nbBag


---

### Example of custom bagging (continued)

```{r,dependson="bag1",fig.height=4,fig.width=4}
plot(ozone$ozone,temperature,col='lightgrey',pch=19)
points(ozone$ozone,predict(treebag$fits[[1]]$fit,predictors),pch=19,col="red")
points(ozone$ozone,predict(treebag,predictors),pch=19,col="blue")
```


---

### Parts of bagging

```{r}
ctreeBag$fit
```

---

### Parts of bagging

```{r}
ctreeBag$pred
```


---

### Parts of bagging

```{r}
ctreeBag$aggregate
```


---

### Notes and further resources

__Notes__:

* Bagging is most useful for nonlinear models
* Often used with trees - an extension is random forests
* Several models use bagging in caret's _train_ function

__Further resources__:

* [Bagging](http://en.wikipedia.org/wiki/Bootstrap_aggregating)
* [Bagging and boosting](http://stat.ethz.ch/education/semesters/FS_2008/CompStat/sk-ch8.pdf)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)

## Random Forests (c8-w3)
### Random forests

1. Bootstrap samples
2. At each split, bootstrap variables
3. Grow multiple trees and vote

__Pros__:

1. Accuracy

__Cons__:

1. Speed
2. Interpretability
3. Overfitting


---

### Random forests

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/forests.png height=400>

[http://www.robots.ox.ac.uk/~az/lectures/ml/lect5.pdf](http://www.robots.ox.ac.uk/~az/lectures/ml/lect5.pdf)


---

### Iris data

```{r iris, cache=TRUE}
data(iris); library(ggplot2)
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
```


---

### Random forests

```{r forestIris, dependson="irisData",fig.height=4,fig.width=4,cache=TRUE}
library(caret)
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE)
modFit
```

---

### Getting a single tree

```{r , dependson="forestIris",fig.height=4,fig.width=4}
getTree(modFit$finalModel,k=2)
```

---

### Class "centers"

```{r centers, dependson="forestIris",fig.height=4,fig.width=4}
irisP <- classCenter(training[,c(3,4)], training$Species, modFit$finalModel$prox)
irisP <- as.data.frame(irisP); irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width, Petal.Length, col=Species,data=training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),size=5,shape=4,data=irisP)
```

---

### Predicting new values

```{r predForest, dependson="centers",fig.height=4,fig.width=4,cache=TRUE}
pred <- predict(modFit,testing); testing$predRight <- pred==testing$Species
table(pred,testing$Species)
```

---

### Predicting new values

```{r, dependson="predForest",fig.height=4,fig.width=4}
qplot(Petal.Width,Petal.Length,colour=predRight,data=testing,main="newdata Predictions")
```

---

### Notes and further resources

__Notes__:

* Random forests are usually one of the two top
performing algorithms along with boosting in prediction contests.
* Random forests are difficult to interpret but often very accurate. 
* Care should be taken to avoid overfitting (see [rfcv](http://cran.r-project.org/web/packages/randomForest/randomForest.pdf) funtion)


__Further resources__:

* [Random forests](http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm)
* [Random forest Wikipedia](http://en.wikipedia.org/wiki/Random_forest)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
## Boosting (c8-w3)
### Basic idea

1. Take lots of (possibly) weak predictors
2. Weight them and add them up
3. Get a stronger predictor


---

### Basic idea behind boosting

1. Start with a set of classifiers $h_1,\ldots,h_k$
  * Examples: All possible trees, all possible regression models, all possible cutoffs.
2. Create a classifier that combines classification functions:
$f(x) = \rm{sgn}\left(\sum_{t=1}^T \alpha_t h_t(x)\right)$.
  * Goal is to minimize error (on training set)
  * Iterative, select one $h$ at each step
  * Calculate weights based on errors
  * Upweight missed classifications and select next $h$
  
[Adaboost on Wikipedia](http://en.wikipedia.org/wiki/AdaBoost)

[http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)

---

### Simple example

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/ada1.png height=450>

[http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)

---

### Round 1: adaboost

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/adar1.png height=450>

[http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)

---

### Round 2 & 3

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/ada2.png height=450>

[http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)


---

### Completed classifier

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/ada3.png height=450>

[http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)

---

### Boosting in R 

* Boosting can be used with any subset of classifiers
* One large subclass is [gradient boosting](http://en.wikipedia.org/wiki/Gradient_boosting)
* R has multiple boosting libraries. Differences include the choice of basic classification functions and combination rules.
  * [gbm](http://cran.r-project.org/web/packages/gbm/index.html) - boosting with trees.
  * [mboost](http://cran.r-project.org/web/packages/mboost/index.html) - model based boosting
  * [ada](http://cran.r-project.org/web/packages/ada/index.html) - statistical boosting based on [additive logistic regression](http://projecteuclid.org/DPubS?service=UI&version=1.0&verb=Display&handle=euclid.aos/1016218223)
  * [gamBoost](http://cran.r-project.org/web/packages/GAMBoost/index.html) for boosting generalized additive models
* Most of these are available in the caret package 



---

### Wage example

```{r wage, cache=TRUE}
library(ISLR); data(Wage); library(ggplot2); library(caret);
Wage <- subset(Wage,select=-c(logwage))
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
```


---

### Fit the model

```{r, dependson="wage", cache=TRUE}
modFit <- train(wage ~ ., method="gbm",data=training,verbose=FALSE)
print(modFit)
```

---

### Plot the results

```{r, dependson="wage", fig.height=4,fig.width=4}
qplot(predict(modFit,testing),wage,data=testing)
```



---

### Notes and further reading

* A couple of nice tutorials for boosting
  * Freund and Shapire - [http://www.cc.gatech.edu/~thad/6601-gradAI-fall2013/boosting.pdf](http://www.cc.gatech.edu/~thad/6601-gradAI-fall2013/boosting.pdf)
  * Ron Meir- [http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf)
* Boosting, random forests, and model ensembling are the most common tools that win Kaggle and other prediction contests. 
  * [http://www.netflixprize.com/assets/GrandPrize2009_BPC_BigChaos.pdf](http://www.netflixprize.com/assets/GrandPrize2009_BPC_BigChaos.pdf)
  * [https://kaggle2.blob.core.windows.net/wiki-files/327/09ccf652-8c1c-4a3d-b979-ce2369c985e4/Willem%20Mestrom%20-%20Milestone%201%20Description%20V2%202.pdf](https://kaggle2.blob.core.windows.net/wiki-files/327/09ccf652-8c1c-4a3d-b979-ce2369c985e4/Willem%20Mestrom%20-%20Milestone%201%20Description%20V2%202.pdf)
  

## Model Based Prediction (c8-w3)
### Basic idea

1. Assume the data follow a probabilistic model
2. Use Bayes' theorem to identify optimal classifiers

__Pros:__

* Can take advantage of structure of the data
* May be computationally convenient
* Are reasonably accurate on real problems

__Cons:__

* Make additional assumptions about the data
* When the model is incorrect you may get reduced accuracy

---

### Model based approach


1. Our goal is to build parametric model for conditional distribution $P(Y = k | X = x)$

2. A typical approach is to apply [Bayes theorem](http://en.wikipedia.org/wiki/Bayes'_theorem):
$$ Pr(Y = k | X=x) = \frac{Pr(X=x|Y=k)Pr(Y=k)}{\sum_{\ell=1}^K Pr(X=x |Y = \ell) Pr(Y=\ell)}$$
$$Pr(Y = k | X=x) = \frac{f_k(x) \pi_k}{\sum_{\ell = 1}^K f_{\ell}(x) \pi_{\ell}}$$

3. Typically prior probabilities $\pi_k$ are set in advance.

4. A common choice for $f_k(x) = \frac{1}{\sigma_k \sqrt{2 \pi}}e^{-\frac{(x-\mu_k)^2}{\sigma_k^2}}$, a Gaussian distribution

5. Estimate the parameters ($\mu_k$,$\sigma_k^2$) from the data.

6. Classify to the class with the highest value of $P(Y = k | X = x)$

---

### Classifying using the model

A range of models use this approach

* Linear discriminant analysis assumes $f_k(x)$ is multivariate Gaussian with same covariances
* Quadratic discrimant analysis assumes $f_k(x)$ is multivariate Gaussian with different covariances
* [Model based prediction](http://www.stat.washington.edu/mclust/) assumes more complicated versions for the covariance matrix 
* Naive Bayes assumes independence between features for model building

http://statweb.stanford.edu/~tibs/ElemStatLearn/


---

### Why linear discriminant analysis?

$$log \frac{Pr(Y = k | X=x)}{Pr(Y = j | X=x)}$$
$$ = log \frac{f_k(x)}{f_j(x)} + log \frac{\pi_k}{\pi_j}$$
$$ = log \frac{\pi_k}{\pi_j} - \frac{1}{2}(\mu_k + \mu_j)^T \Sigma^{-1}(\mu_k + \mu_j)$$
$$ + x^T \Sigma^{-1} (\mu_k - \mu_j)$$

http://statweb.stanford.edu/~tibs/ElemStatLearn/


---

### Decision boundaries

<img class="center" src="../../assets/img/ldaboundary.png" height=500>

---

### Discriminant function

$$\delta_k(x) = x^T \Sigma^{-1} \mu_k - \frac{1}{2}\mu_k \Sigma^{-1}\mu_k + log(\mu_k)$$


* Decide on class based on $\hat{Y}(x) = argmax_k \delta_k(x)$
* We usually estimate parameters with maximum likelihood


---

### Naive Bayes

Suppose we have many predictors, we would want to model: $P(Y = k | X_1,\ldots,X_m)$

We could use Bayes Theorem to get:

$$P(Y = k | X_1,\ldots,X_m) = \frac{\pi_k P(X_1,\ldots,X_m| Y=k)}{\sum_{\ell = 1}^K P(X_1,\ldots,X_m | Y=k) \pi_{\ell}}$$
$$ \propto \pi_k P(X_1,\ldots,X_m| Y=k)$$

This can be written:

$$P(X_1,\ldots,X_m, Y=k) = \pi_k P(X_1 | Y = k)P(X_2,\ldots,X_m | X_1,Y=k)$$
$$ = \pi_k P(X_1 | Y = k) P(X_2 | X_1, Y=k) P(X_3,\ldots,X_m | X_1,X_2, Y=k)$$
$$ = \pi_k P(X_1 | Y = k) P(X_2 | X_1, Y=k)\ldots P(X_m|X_1\ldots,X_{m-1},Y=k)$$

We could make an assumption to write this:

$$ \approx \pi_k P(X_1 | Y = k) P(X_2 | Y = k)\ldots P(X_m |,Y=k)$$

---

### Example: Iris Data

```{r iris, cache=TRUE}
data(iris); library(ggplot2)
names(iris)
table(iris$Species)
```


---

### Create training and test sets

```{r trainingTest, dependson="iris",cache=TRUE}
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
```

---

### Build predictions

```{r fit,dependson="trainingTest"}
modlda = train(Species ~ .,data=training,method="lda")
modnb = train(Species ~ ., data=training,method="nb")
plda = predict(modlda,testing); pnb = predict(modnb,testing)
table(plda,pnb)
```


---

### Comparison of results

```{r,dependson="fit",fig.height=4,fig.width=4}
equalPredictions = (plda==pnb)
qplot(Petal.Width,Sepal.Width,colour=equalPredictions,data=testing)
```

---

### Notes and further reading

* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Model based clustering](http://www.stat.washington.edu/raftery/Research/PDF/fraley2002.pdf)
* [Linear Discriminant Analysis](http://en.wikipedia.org/wiki/Linear_discriminant_analysis)
* [Quadratic Discriminant Analysis](http://en.wikipedia.org/wiki/Quadratic_classifier)

## Agent's notes c8-w3

Very depressing lecture set!

Check this out for Cross validation and how to perform it using [trainControl](http://www.sthda.com/english/articles/38-regression-model-validation/157-cross-validation-essentials-in-r/).

## Quiz 3

### question 1
For this quiz we will be using several R packages. R package versions change over time, the right answers have been checked using the following versions of the packages.
AppliedPredictiveModeling: v1.1.6

caret: v6.0.47

ElemStatLearn: v2012.04-0

pgmm: v1.1

rpart: v4.1.8

If you aren’t using these versions of the packages, your answers may not exactly match the right answer, but hopefully should be close.

Load the cell segmentation data from the AppliedPredictiveModeling package using the commands:

	library(AppliedPredictiveModeling)
	data("segmentationOriginal")
	library(caret)

1. Subset the data to a training set and testing set based on the Case variable in the data set.

2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings.

3. In the final model what would be the final model prediction for cases with the following variable values:

a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2

b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100

c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100

d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2




Ans: I did not get answer: PS, **WS**,PS, Not possible to predict!

With a tree you cannot predict whats not in the tree and you always
have to start from the top. If you don't have the top variable then
there is no point!


``` r
 
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)


df <-  segmentationOriginal

trainSet <- segmentationOriginal[segmentationOriginal$Case =="Train",]
testSet <- segmentationOriginal[segmentationOriginal$Case =="Test",]

set.seed(125)
model_rpart <- train(Class~.,data=trainSet,method="rpart")

library(rattle)
fancyRpartPlot(modFit$finalModel)

predict(modFit, newata=te)
## it doesn't show more than 2 trees, don't know why! And the second
tree is slightly wrong giving different results!
```

### Question 2

If K is small in a K-fold cross validation is the bias in the estimate
of out-of-sample (test set) accuracy smaller or bigger? If K is small
is the variance in the estimate of out-of-sample (test set) accuracy
smaller or bigger. Is K large or small in leave one out cross
validation?

Ans: 

The bias is larger and the variance is smaller. Under leave one out
cross validation K is equal to the sample size.

Why?



Based on [this](https://stats.stackexchange.com/questions/61783/bias-and-variance-in-leave-one-out-vs-k-fold-cross-validation), it appears that as k increases bias decreases and
variance increases!






### Question 3

Load the olive oil data using the commands:

``` r
library(pgmm)
data(olive)
olive = olive[,-1]
```

These data contain information on 572 different Italian olive oils
from multiple regions in Italy. Fit a classification tree where Area
is the outcome variable. Then predict the value of area for the
following data frame using the tree command with all defaults

``` r
newdata = as.data.frame(t(colMeans(olive)))
```

What is the resulting prediction? Is the resulting prediction strange?
Why or why not?

Ans:

2.783. It is strange because Area should be a qualitative variable -
but tree is reporting the average value of Area as a numeric variable
in the leaf predicted for newdata

``` r
library(pgmm)
data(olive)
olive = olive[,-1]

olive_rpart <- train(Area~.,data=olive,method="rpart")
newdata = as.data.frame(t(colMeans(olive)))
predict(olive_rpart,newdata=newdata)

```

### Question 4

Load the South Africa Heart Disease Data and create training and test
sets with the following code:

``` r
library(ElemStatLearn)
## Warning: package 'ElemStatLearn' was built under R version 3.3.2
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
```

Then set the seed to 13234 and fit a logistic regression model
(method=“glm”, be sure to specify family=“binomial”) with Coronary
Heart Disease (chd) as the outcome and age at onset, current alcohol
consumption, obesity levels, cumulative tabacco, type-A behavior, and
low density lipoprotein cholesterol as predictors. Calculate the
misclassification rate for your model using this function and a
prediction on the “response” scale:

``` r
missClass = function(values,prediction){sum(((prediction > 0.5)*1) !=
values)/length(values)}
```

What is the misclassification rate on the training set? What is the misclassification rate on the test set?

Test Set Misclassification: 0.27
Training Set: 0.31
Test Set Misclassification: 0.43
Training Set: 0.31
Test Set Misclassification: 0.31
Training Set: 0.27
Test Set Misclassification: 0.35
Training Set: 0.31

ANS:

``` r
set.seed(13234)

# definition of the training model
regModel <-
train(chd~age+alcohol+obesity+tobacco+typea+ldl,data=trainSA,method="glm",family="binomial")

## Warning in train.default(x, y, weights = w, ...): You are trying to do
## regression and your outcome only has two possible values Are you trying to
## do classification? If so, use a 2 level factor as your outcome column.
# computation of the misclasssification on the training set and test
set

missClassTrain <- missClass(trainSA$chd,predict(regModel,newdata=trainSA))
missClassTest <- missClass(testSA$chd,predict(regModel,newdata=testSA))
missClassTrain
missClassTest

```
You will get warnings but we don't care for now!

### Question 5

Load the vowel.train and vowel.test data sets:

``` r
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
```


Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. Fit a random forest predictor relating the factor variable y to the remaining variables. Read about variable importance in random forests here: http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr.

The caret package uses by default the Gini importance.

Calculate the variable importance using the varImp function in the caret package. What is the order of variable importance?

[NOTE: Use randomForest() specifically, not caret, as there’s been some issues reported with that approach. 11/6/2016]

The order of the variables is:
x.1, x.2, x.3, x.8, x.6, x.4, x.5, x.9, x.7,x.10
The order of the variables is:
x.10, x.7, x.9, x.5, x.8, x.4, x.6, x.3, x.1,x.2
The order of the variables is:
x.2, x.1, x.5, x.6, x.8, x.4, x.9, x.3, x.7,x.10
The order of the variables is:
x.10, x.7, x.5, x.6, x.8, x.4, x.9, x.3, x.1,x.2

ANS:

``` r
rm(.Random.seed, envir=globalenv())
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)

modvowel <- randomForest(y ~ ., data = vowel.train)
order(varImp(modvowel), decreasing = T)
```

Produces results differently based on the setting of the seed at
different points. What ever I did I was never able to match the quiz
answer!



## Regularized Regression (c8-w4)
### Basic idea

1. Fit a regression model
2. Penalize (or shrink) large coefficients

__Pros:__

* Can help with the bias/variance tradeoff
* Can help with model selection

__Cons:__

* May be computationally demanding on large data sets
* Does not perform as well as random forests and boosting



---

### A motivating example

$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \epsilon$$

where $X_1$ and $X_2$ are nearly perfectly correlated (co-linear). You can approximate this model by:

$$Y = \beta_0 + (\beta_1 + \beta_2)X_1 + \epsilon$$

The result is:

* You will get a good estimate of $Y$
* The estimate (of $Y$) will be biased 
* We may reduce variance in the estimate


**For some reason it appears that lesser variables lesser variance? So
what if there is more variance? What is the impact action! And lesser
variables more BIAS!
**

---
	
### Prostate cancer 

```{r prostate}
library(ElemStatLearn); data(prostate)
str(prostate)
```



---

### Subset selection

<img class="center" src="../../assets/img/prostate.png" height="450">

[Code here](http://www.cbcb.umd.edu/~hcorrada/PracticalML/src/selection.R)


---

### Most common pattern

<img class="center" src="../../assets/img/trainingandtest.png" height="450">

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/

---

### Model selection approach: split samples

* No method better when data/computation time permits it

* Approach
  1. Divide data into training/test/validation
  2. Treat validation as test data, train all competing models on the train data and pick the best one on validation. 
  3. To appropriately assess performance on new data apply to test set
  4. You may re-split and reperform steps 1-3

* Two common problems
  * Limited data
  * Computational complexity
  
http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/


---

### Decomposing expected prediction error

Assume $Y_i = f(X_i) + \epsilon_i$

$EPE(\lambda) = E\left[\{Y - \hat{f}_{\lambda}(X)\}^2\right]$

Suppose $\hat{f}_{\lambda}$ is the estimate from the training data and look at a new data point $X = x^*$
$$E\left[\{Y - \hat{f}_{\lambda}(x^*)\}^2\right] = \sigma^2 + \{E[\hat{f}_{\lambda}(x^*)] - f(x^*)\}^2 + var[\hat{f}_\lambda(x_0)]$$

**<center> = Irreducible error + Bias$^2$ + Variance </center>**

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

---

### Another issue for high-dimensional data

```{r ,dependson="prostate"}
small = prostate[1:5,]
lm(lpsa ~ .,data =small)
```

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

---

### Hard thresholding

* Model $Y = f(X) + \epsilon$

* Set $\hat{f}_{\lambda}(x) = x'\beta$

* Constrain only $\lambda$ coefficients to be nonzero. 

* Selection problem is after chosing $\lambda$ figure out which $p - \lambda$ coefficients to make nonzero

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

---

### Regularization for regression

If the $\beta_j$'s are unconstrained:
* They can explode
* And hence are susceptible to very high variance

To control variance, we might regularize/shrink the coefficients. 

$$ PRSS(\beta) = \sum_{j=1}^n (Y_j - \sum_{i=1}^m \beta_{1i} X_{ij})^2 + P(\lambda; \beta)$$

where $PRSS$ is a penalized form of the sum of squares. Things that are commonly looked for

* Penalty reduces complexity
* Penalty reduces variance
* Penalty respects structure of the problem

---

### Ridge regression

Solve:

$$ \sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2 + \lambda \sum_{j=1}^p \beta_j^2$$

equivalent to solving

$\sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2$ subject to $\sum_{j=1}^p \beta_j^2 \leq s$ where $s$ is inversely proportional to $\lambda$ 


Inclusion of $\lambda$ makes the problem non-singular even if $X^TX$ is not invertible.

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/


---

### Ridge coefficient paths

<img class="center" src="../../assets/img/ridgepath.png" height="450">

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

---

### Tuning parameter $\lambda$

* $\lambda$ controls the size of the coefficients
* $\lambda$ controls the amount of {\bf regularization}
* As $\lambda \rightarrow 0$ we obtain the least square solution
* As $\lambda \rightarrow \infty$ we have $\hat{\beta}_{\lambda=\infty}^{ridge} = 0$


---

### Lasso 

$\sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2$ subject to $\sum_{j=1}^p |\beta_j| \leq s$ 

also has a lagrangian form 

$$ \sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2 + \lambda \sum_{j=1}^p |\beta_j|$$

For orthonormal design matrices (not the norm!) this has a closed form solution

$$\hat{\beta}_j = sign(\hat{\beta}_j^0)(|\hat{\beta}_j^0 - \gamma)^{+}$$
 
but not in general. 

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/


---

### Notes and further reading


* [Hector Corrada Bravo's Practical Machine Learning lecture notes](http://www.cbcb.umd.edu/~hcorrada/PracticalML/)
* [Hector's penalized regression reading list](http://www.cbcb.umd.edu/~hcorrada/AMSC689.html#readings)
* [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* In `caret` methods are:
  * `ridge`
  * `lasso`
  * `relaxo`
## Combining Predictors (c8-w4)
### Key ideas

* You can combine classifiers by averaging/voting
* Combining classifiers improves accuracy
* Combining classifiers reduces interpretability
* Boosting, bagging, and random forests are variants on this theme

---

### Netflix prize

BellKor = Combination of 107 predictors 

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/netflix.png height=450>

[http://www.netflixprize.com//leaderboard](http://www.netflixprize.com//leaderboard)

---

### Heritage health prize - Progress Prize 1

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/makers.png height=200>
[Market Makers](https://kaggle2.blob.core.windows.net/wiki-files/327/e4cd1d25-eca9-49ca-9593-b254a773fe03/Market%20Makers%20-%20Milestone%201%20Description%20V2%201.pdf)

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/mestrom.png height=200>

[Mestrom](https://kaggle2.blob.core.windows.net/wiki-files/327/09ccf652-8c1c-4a3d-b979-ce2369c985e4/Willem%20Mestrom%20-%20Milestone%201%20Description%20V2%202.pdf)


---

### Basic intuition - majority vote

Suppose we have 5 completely independent classifiers

If accuracy is 70% for each:
  * $10\times(0.7)^3(0.3)^2 + 5\times(0.7)^4(0.3)^2 + (0.7)^5$
  * 83.7% majority vote accuracy

With 101 independent classifiers
  * 99.9% majority vote accuracy
  

---

### Approaches for combining classifiers

1. Bagging, boosting, random forests
  * Usually combine similar classifiers
2. Combining different classifiers
  * Model stacking
  * Model ensembling

---

### Example with Wage data

__Create training, test and validation sets__

```{r wage}
library(ISLR); data(Wage); library(ggplot2); library(caret);
Wage <- subset(Wage,select=-c(logwage))
# Create a building data set and validation set
inBuild <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
validation <- Wage[-inBuild,]; buildData <- Wage[inBuild,]
inTrain <- createDataPartition(y=buildData$wage,
                              p=0.7, list=FALSE)
training <- buildData[inTrain,]; testing <- buildData[-inTrain,]
```


---

### Wage data sets

__Create training, test and validation sets__

```{r, dependson="wage"}
dim(training)
dim(testing)
dim(validation)
```


---

### Build two different models

```{r modFit,dependson="wage"}
mod1 <- train(wage ~.,method="glm",data=training)
mod2 <- train(wage ~.,method="rf",
              data=training, 
              trControl = trainControl(method="cv"),number=3)
```


---

### Predict on the testing set 

```{r predict,dependson="modFit",fig.height=4,fig.width=6}
pred1 <- predict(mod1,testing); pred2 <- predict(mod2,testing)
qplot(pred1,pred2,colour=wage,data=testing)
```


---

### Fit a model that combines predictors

```{r combine,dependson="predict"}
predDF <- data.frame(pred1,pred2,wage=testing$wage)
combModFit <- train(wage ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)
```


---

### Testing errors

```{r ,dependson="combine"}
sqrt(sum((pred1-testing$wage)^2))
sqrt(sum((pred2-testing$wage)^2))
sqrt(sum((combPred-testing$wage)^2))
```


---

### Predict on validation data set

```{r validation,dependson="combine"}
pred1V <- predict(mod1,validation); pred2V <- predict(mod2,validation)
predVDF <- data.frame(pred1=pred1V,pred2=pred2V)
combPredV <- predict(combModFit,predVDF)
```


---

### Evaluate on validation

```{r ,dependson="validation"}
sqrt(sum((pred1V-validation$wage)^2))
sqrt(sum((pred2V-validation$wage)^2))
sqrt(sum((combPredV-validation$wage)^2))
```



---

### Notes and further resources

* Even simple blending can be useful
* Typical model for binary/multiclass data
  * Build an odd number of models
  * Predict with each model
  * Predict the class by majority vote
* This can get dramatically more complicated
  * Simple blending in caret: [caretEnsemble](https://github.com/zachmayer/caretEnsemble) (use at your own risk!)
  * Wikipedia [ensemble learning](http://en.wikipedia.org/wiki/Ensemble_learning)

---

### Recall - scalability matters

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/netflixno.png height=250>
</br></br></br>

[http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/](http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/)

[http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html](http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html)

## Unsupervised Prediction (c8-w4)
### Key ideas

* Sometimes you don't know the labels for prediction
* To build a predictor
  * Create clusters
  * Name clusters
  * Build predictor for clusters
* In a new data set
  * Predict clusters


---

### Iris example ignoring species labels

```{r iris}
data(iris); library(ggplot2)
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
```


---

### Cluster with k-means

```{r kmeans,dependson="iris",fig.height=4,fig.width=6}
kMeans1 <- kmeans(subset(training,select=-c(Species)),centers=3)
training$clusters <- as.factor(kMeans1$cluster)
qplot(Petal.Width,Petal.Length,colour=clusters,data=training)
```


---

### Compare to real labels

```{r ,dependson="kmeans"}
table(kMeans1$cluster,training$Species)
```



---

### Build predictor

```{r modelFit,dependson="kmeans"}
modFit <- train(clusters ~.,data=subset(training,select=-c(Species)),method="rpart")
table(predict(modFit,training),training$Species)
```

---

### Apply on test

```{r ,dependson="modFit"}
testClusterPred <- predict(modFit,testing) 
table(testClusterPred ,testing$Species)
```


---

### Notes and further reading

* The cl_predict function in the clue package provides similar functionality
* Beware over-interpretation of clusters!
* This is one basic approach to [recommendation engines](http://en.wikipedia.org/wiki/Recommender_system)
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
## Forecasting (c8-w4)

### Time series data

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/GOOG.png height=450>

[https://www.google.com/finance](https://www.google.com/finance)

---

### What is different?

* Data are dependent over time
* Specific pattern types
  * Trends - long term increase or decrease
  * Seasonal patterns - patterns related to time of week, month, year, etc.
  * Cycles - patterns that rise and fall periodically
* Subsampling into training/test is more complicated
* Similar issues arise in spatial data 
  * Dependency between nearby observations
  * Location specific effects
* Typically goal is to predict one or more observations into the future. 
* All standard predictions can be used (with caution!)

---

### Beware spurious correlations!


<img class=center src=../../assets/img/08_PredictionAndMachineLearning/spurious.jpg height=450>

[http://www.google.com/trends/correlate](http://www.google.com/trends/correlate)

[http://www.newscientist.com/blogs/onepercent/2011/05/google-correlate-passes-our-we.html](http://www.newscientist.com/blogs/onepercent/2011/05/google-correlate-passes-our-we.html)

---

### Also common in geographic analyses

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/heatmap.png height=450>

[http://xkcd.com/1138/](http://xkcd.com/1138/)


---

### Beware extrapolation!

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/extrapolation.jpg height=450>

[http://www.nature.com/nature/journal/v431/n7008/full/431525a.html](http://www.nature.com/nature/journal/v431/n7008/full/431525a.html)

---

### Google data


```{r loadGOOG}
library(quantmod)
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
getSymbols("GOOG", src="google", from = from.dat, to = to.dat)
head(GOOG)
```

---

### Summarize monthly and store as time series

```{r tseries,dependson="loadGOOG",fig.height=4,fig.width=4}
mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1 <- ts(googOpen,frequency=12)
plot(ts1,xlab="Years+1", ylab="GOOG")
```


---

### Example time series decomposition

* __Trend__  - Consistently increasing pattern over time 
* __Seasonal__ -  When there is a pattern over a fixed period of time that recurs.
* __Cyclic__ -  When data rises and falls over non fixed periods

[https://www.otexts.org/fpp/6/1](https://www.otexts.org/fpp/6/1)


---

### Decompose a time series into parts

```{r ,dependson="tseries",fig.height=4.5,fig.width=4.5}
plot(decompose(ts1),xlab="Years+1")
```

---

### Training and test sets

```{r trainingTest,dependson="tseries",fig.height=4.5,fig.width=4.5}
ts1Train <- window(ts1,start=1,end=5)
ts1Test <- window(ts1,start=5,end=(7-0.01))
ts1Train
```

---

### Simple moving average

$$ Y_{t}=\frac{1}{2*k+1}\sum_{j=-k}^k {y_{t+j}}$$

```{r ,dependson="trainingTest",fig.height=4.5,fig.width=4.5}
plot(ts1Train)
lines(ma(ts1Train,order=3),col="red")
```



---

### Exponential smoothing

__Example - simple exponential smoothing__
$$\hat{y}_{t+1} = \alpha y_t + (1-\alpha)\hat{y}_{t-1}$$

<img class=center src=../../assets/img/08_PredictionAndMachineLearning/expsmooth.png height=300>

[https://www.otexts.org/fpp/7/6](https://www.otexts.org/fpp/7/6)

---

### Exponential smoothing

```{r ets,dependson="trainingTest",fig.height=4.5,fig.width=4.5}
ets1 <- ets(ts1Train,model="MMM")
fcast <- forecast(ets1)
plot(fcast); lines(ts1Test,col="red")
```


---

### Get the accuracy

```{r ,dependson="ets",fig.height=4.5,fig.width=4.5}
accuracy(fcast,ts1Test)
```

---

### Notes and further resources

* [Forecasting and timeseries prediction](http://en.wikipedia.org/wiki/Forecasting) is an entire field
* Rob Hyndman's [Forecasting: principles and practice](https://www.otexts.org/fpp/) is a good place to start
* Cautions
  * Be wary of spurious correlations
  * Be careful how far you predict (extrapolation)
  * Be wary of dependencies over time
* See [quantmod](http://cran.r-project.org/web/packages/quantmod/quantmod.pdf) or [quandl](http://www.quandl.com/help/packages/r) packages for finance-related problems.



## Quiz c8-w4

### Question 1

``` r
rm(.Random.seed, envir=globalenv())
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)
library(caret)

rfFit <- train(y~.,method="rf", data=vowel.train)

rfPred <- predict(rfFit,vowel.test)
confusionMatrix(rfPred,vowel.test[,1])

gbmFit <- train(y~., method="gbm", data=vowel.train);

gbmPred <- predict(gbmFit,vowel.test)
confusionMatrix(predict(gbmFit,vowel.test),vowel.test[,1])

## combined model

predDF <- data.frame(as.factor(rfPred),as.factor(gbmPred),y=vowel.test$y)
combModFit <- train(y~.,method="gam",data=predDF)

combPred <- predict(combModFit,predDF)
confusionMatrix(combPred,vowel.test$y)

## Agreement accuracy
confusionMatrix(gbmPred, rfPred)$overall['Accuracy']

a <- rfPred==gbmPrewd
sum(a==T)/length(a)
```

### Question 2

Completely wrong answer but the way I have written the code is exactly
the same as rpubs versions here and also in the code below!

``` r
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

##caleculation

set.seed(62433)

rfFit <- train(diagnosis~.,method="rf",data=training)
gbmFit <- train(diagnosis~.,method="gbm",data=training)
ldaFit <- train(diagnosis~.,method="lda",data=training)


rfPred <- predict(rfFit,testing)
confusionMatrix(rfPred,testing$diagnosis)


gbmPred <- predict(gbmFit,testing)
confusionMatrix(gbmPred,testing$diagnosis)$overall["Accuracy"]


ldaPred <- predict(ldaFit,testing)
confusionMatrix(ldaPred,testing$diagnosis)$overall["Accuracy"]

predDF <-
    data.frame(rfPred,gbmPred,ldaPred,diagnosis=testing$diagnosis)
combModFit <- train(diagnosis~.,method="rf",data=predDF)

combPred <- predict(combModFit,predDF)
confusionMatrix(combPred,testing$diagnosis)$overall["Accuracy"]

### Comparing to others in rpubs!

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
modelFit_rf<-train(diagnosis~., method="rf", data=training)
modelFit_gbm<-train(diagnosis~., method="gbm", data=training,verbose=FALSE)
modelFit_lda<-train(diagnosis~., method="lda", data=training)

predict_rf<-predict(modelFit_rf,newdata=testing)
predict_gbm<-predict(modelFit_gbm,newdata=testing)
predict_lda<-predict(modelFit_lda,newdata=testing)
confusionMatrix(predict_rf, testing$diagnosis)$overall['Accuracy']

confusionMatrix(predict_gbm, testing$diagnosis)$overall['Accuracy']
confusionMatrix(predict_lda, testing$diagnosis)$overall['Accuracy']


#create a new dataframe with the predictions
predDF <- data.frame(predict_rf, predict_gbm, predict_lda, diagnosis = testing$diagnosis)
#create a new model using the new data frame and rf method
combModFit <- train(diagnosis ~.,method="rf",data=predDF)

#predict values and calculate the confusion matrix to check the accuracy
combPred <- predict(combModFit, predDF)
confusionMatrix(combPred, testing$diagnosis)$overall['Accuracy']
```

### Question 3

``` r
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

## Caleculation

library(glmnet)
library(glmnetUtils)
set.seed(233)

cv.lasso <-
    cv.glmnet(CompressiveStrength~.,data=training,alpha=1)

plot(cv.lasso$glmnet.fit, "lambda", label=TRUE)

## Above seems to give the right answer as well!

## modFit <- glmnet(CompressiveStrength~.,data=training, alpha = 1,
##                 lambda = cv.lasso$lambda.min) ## Not needed
##                 apparently for the question!


## Answer from Rpubs!

set.seed(233)
trcontrol <- train
modLasso <- train(CompressiveStrength ~ ., data=training, method="lasso")
plot.enet(modLasso$finalModel,  xvar="penalty", use.color=TRUE)


## The below from
## https://stackoverflow.com/questions/43852738/how-to-apply-lasso-logistic-regression-with-caret-and-glmnet
## also gives similar result!

trainControl <- trainControl(method = "cv",
                             number = 10)

modelFit <- train(CompressiveStrength ~ ., data = training, 
            method = "lasso", 
            trControl = trainControl)
```

### Question 4

``` r
library(lubridate) # For year() function below
dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

fit <- bats(tstrain)
prediction <- forecast(fit,level=95,h=nrow(testing))

pos <- sum(testing$visitsTumblr>prediction$lower
           &testing$visitsTumblr<prediction$upper)
pos/nrow(testing)

set.seed(3523)
```
### Question 5

``` r

library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
library(e1071)

fit <- svm(CompressiveStrength~.,data=training)
prediction <- predict(fit,newdata=testing)
accuracy(prediction,testing$CompressiveStrength)

```

## Statquest Bias and Variance!

Based on [this statquest](https://www.youtube.com/watch?v=EuBBz3bI-aA).

Think of straight line and a squiggly line fitting the test data. 

**Bias**

So the squiggly line fits every single point and thus has "very little
bias"

The straight line aka least squares line has bias as it can never take
the shape of the points as done by the squiggly line!

**Variance**

If you use another dataset, you will have huge errors aka VARIANCE
WITH EVERY DATASET with the squiggly line fit. The squiggly line is
**OverFit**.

Where as the straight line will have not "that much" variance as
compared to squiggs!

**What do we want in ML**

*Low Bias, and accurately modelling the true relationship with low
variance between different data sets!*

find sweet spot between simple and complext model aka straight line
and squiggly line! aka, using regularization boosting and bagging!

## Ridge regression from Stat quest

Based on [this statquest on ridge regression](https://www.youtube.com/watch?v=Q81RR3yKn30).

So we start with say 2 points and fit a linear line. We can fit it
exactly. AKA, low BIAS. But resulting test on the test data will haev
high ass variance!

So we are fitting: sum of square residuals

Instead let's fit: **sum of square residuals + $\lambda$ x slope**

This way we look for a lambda by cross validation (10-fold) such that
the above value is the smallest.

**This introduces some bias in the training set for a reduced Variance
across test sets!**

So basically as lambda goes from 0 to 1, the slope will have to reduce
i.e., the y axis becomes less sensitive to changes in the x axis!

Same applies to logistic regression i.e., fit: **max likelihood
+lambda x slope**


**Note**: the y-intercept is not included!

### Lasso


Ridge Regression: **sum of square residuals + $\lambda$ x slope^2**

Lasso Regression: **sum of square residuals + $\lambda$ x abs(slope)**

In Lasso the slopes can go all the way to 0. Let's say the size of
mice is dependent on 

- astrology sign
- weight
- diet
- airspeed of a swallow.

With Lasso the airspeed and astrology variables will go to absolute 0,
where as with ridge they will tend to 0, i.e., the variables will
still be in the equation. This way we get rid of parameters that are
useless in the training!

Roughly, when most variables are useful use ridge which will still
keep all variables and Lasso when most variables are not that useful!

### Dealing with 1000 variables with lesser data points!

### Elastic net regression

We have elastic-net regression
 
**sum of square residuals + $\lambda1$ x abs(slope)** +  $\lambda2$ x slope^2**

CLAIM: This is good to deal with correlated terms as Lasso tends to pick just
one of the correlated terms and eliminates the others and Whereas
Ridge shrinks all parameters of the correlated variables together!

### links

R code on ridge lasso and other :
https://www4.stat.ncsu.edu/~post/josh/LASSO_Ridge_Elastic_Net_-_Examples.html
## Final Assignment: C8-w4

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, message=F, warning=F, cache=T)
```  

### Model explanation

With this assignment the goal is to predict classification of barbell
lifts into A,B,C,D,E. We start with exploring the data. We realize
that there are many NA's so we start cleaning the data by removing
high NA columns. We perform both Hold-out test as well as cross
validation based on this [stack answer](https://stats.stackexchange.com/questions/104713/hold-out-validation-vs-cross-validation) as we have 19 thousand Data
points! CV is used typically if the dataset is small. Both are used to
understand the Model Accuracy.

The initial plan is to start with decision trees and go from there on
if the accuracy is not good enough. As explained below we need a model
accuracy of 99% as I would like atleast a 90% accuracy on the
QUIZ/TEST!


#### Expected out of sample error calculation!

Based on [this](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/pml-requiredModelAccuracy.md), we are able to calculate the following:

The following table illustrates the probability of predicting all 20
test cases right, given a particular model accuracy.


<table>
<tr><th><br><br>Model<br>Accuracy</th><th>Probability<br>of Predicting <br>20 out of 20<br>Correctly</th>
</tr>
<tr><td align=right>0.800</td><td align=right>0.0115</td></tr>
<tr><td align=right>0.850</td><td align=right>0.0388</td></tr>
<tr><td align=right>0.900</td><td align=right>0.1216</td></tr>
<tr><td align=right>0.950</td><td align=right>0.3585</td></tr>
<tr><td align=right>0.990</td><td align=right>0.8179</td></tr>
<tr><td align=right>0.995</td><td align=right>0.9046</td></tr>
</table>

We thus aim for a model accuracy of 99.5% atleast so that the expected
out of sample accuracy will be in the order of 90%.

---
### Start of R programming!

```{r }
library(caret,corrplot)
```

The training data for this project are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

```{r }
f.training <- read.csv("./pml-training.csv")
f.testing <- read.csv("./pml-testing.csv")
```

### Explore Data

```{r }
dim(f.training)
sum(is.na(f.training))
```
Other explorations were done with `head`, `names` etc... but is not
showed here due to the large output. With the `sum` function we see
that there are a lot of NA's, so we get into cleaning the data.

### Cleaning DATA

```{r }

## Cleaning Removing high NA cols

ncol(f.training)
nas <- lapply(f.training,function(X) sum(is.na(X)))> 0.90*nrow(f.training)
f.training <- f.training[,!nas]
f.testing <- f.testing[,!nas]
ncol(f.training)

## Cleaning Removing Zero Var Cols

NZV <- nearZeroVar(f.training)
f.training <- f.training[,-NZV]
f.testing <- f.testing[,-NZV]
ncol(f.training)

## cleaning removing meaningless variables such as name

MLV <- 1:5
f.training <- f.training[,-MLV]
f.testing <- f.testing[,-MLV]
ncol(f.training)

```

### Partition the data

```{r partition }
inTrain <- createDataPartition(y=f.training$classe,p=0.7,list=F)
training <- f.training[inTrain,]
testing <- f.training[-inTrain,]
```


### Model fit Decision tree!

We start with the Decision Tree as here we are primary interested in a
classification type of problem. Based on [this](https://stats.stackexchange.com/questions/61783/bias-and-variance-in-leave-one-out-vs-k-fold-cross-validation) we choose a CV
K-fold of 10.

```{r LGOCV}
trControl <- trainControl(method="cv",number=10)
modFitDT <- train(classe~.,method="rpart",data=training,trControl=trControl)

predictionDT <- predict(modFitDT,testing)
confusionMatrix(predictionDT,testing$classe)$overall['Accuracy']
```
The accuracy of the decision tree seems to be really bad. Increasing
the CV number doesn't seem to help! The decision tree is shown below:

```{r DTplot}
library(rattle)
fancyRpartPlot(modFitDT$finalModel)
plot(confusionMatrix(predictionDT,testing$classe)$table)
```


### Model Fit Random Forests

Next we try Random Forests. This following code uses 3 cores, and
allows running in parallel for a time of 5 mins instead of 20 mins, on
an 8gb ram system. The code is based off of : [Github link of Len](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/pml-randomForestPerformance.md).

```{r RF}
library(parallel)
library(doParallel)
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)

trControl <- trainControl(method = "cv",
                           number = 5,
                          allowParallel = TRUE)

modFitRF <- train(classe~.,data=training,method="rf", trControl=trControl)

stopCluster(cluster)
registerDoSEQ()

predictionRF <- predict(modFitRF,testing)
confusionMatrix(predictionRF,testing$classe)$overall['Accuracy']
```

```{r }
plot(confusionMatrix(predictionRF,testing$classe)$table)
```

### Final Prediction
```{r }
prediction.finale <- predict(modFitRF,f.testing)
prediction.finale
```
This led to a 100% prediction on the Quiz! :)

### Appendix: Question copied from Coursera!

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now
possible to collect a large amount of data about personal activity
relatively inexpensively. These type of devices are part of the
quantified self movement – a group of enthusiasts who take
measurements about themselves regularly to improve their health, to
find patterns in their behavior, or because they are tech geeks. One
thing that people regularly do is quantify how much of a particular
activity they do, but they rarely quantify how well they do it. In
this project, your goal will be to use data from accelerometers on the
belt, forearm, arm, and dumbell of 6 participants. They were asked to
perform barbell lifts correctly and incorrectly in 5 different
ways. More information is available from the website here:
http://web.archive.org/w
eb/20161224072740/http:/groupware.les.inf.puc-rio.br/har
(see the section on the Weight Lifting Exercise Dataset).

The training data for this project are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

The data for this project come from this source:
http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har. If
you use the document you create for this class for any purpose please
cite them as they have been very generous in allowing their data to be
used for this kind of assignment.


The training data for this project are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

> The data for this project come from this source:
> http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har. If
> you use the document you create for this class for any purpose
> please cite them as they have been very generous in allowing their
> data to be used for this kind of assignment. - from [website](http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har#weight_lifting_exercises)

> Six young health participants were asked to perform one set of 10
> repetitions of the Unilateral Dumbbell Biceps Curl in five different
> fashions: exactly according to the specification (Class A), throwing
> the elbows to the front (Class B), lifting the dumbbell only halfway
> (Class C), lowering the dumbbell only halfway (Class D) and throwing
> the hips to the front (Class E). - from [website](http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har#weight_lifting_exercises)


## C9 Developing DATA products!
https://github.com/DataScienceSpecialization/Developing_Data_Products
### Warning about shiny

> Shinyapps.io Project - Read on GitHub Some people in this session
> let us know that they are concerned about running up against the
> 25-hour per month limit on the free tier of shinyapps.io.
>
> Should you hit the limit on the free plan, RStudio will send you a
> message. If you receive the message and are more than a few days
> from getting a fresh 25 hours on your monthly renewal, please send
> an email to shinyapps-support@rstudio.com with the email address you
> use on the service and the account name you are using (the first
> part of the URL). RStudio will then increase your limit so you can
> continue working on your project.
>
> Since there are a lot of folks in the class we’d appreciate if you
> only emailed RStudio after you get the message and only if you feel
> you’ll need more time.


## Shiny Part 1 (c9-w1)
### What is Shiny?

- Shiny is a web application framework for R.
- Shiny allows you to create a graphical interface so that
users can interact with your visualizations, models, and 
algorithms without needed to know R themselves.
- Using Shiny, the time to create simple, yet powerful, 
web-based interactive data products in R is minimized.
- Shiny is made by the fine folks at R Studio.

### Some Mild Prerequisites 

Shiny doesn't really require it, but as with all web 
programming, a little knowledge of HTML, CSS and Javascript
is very helpful.

- HTML gives a web page structure and sectioning as well as markup instructions
- CSS gives the style
- Javscript for interactivity
  
Shiny uses [Bootstrap](http://getbootstrap.com/) (no 
relation to the statistics bootstrap) style, which (to me) 
seems to look nice and renders well on mobile platforms.

### Available Tutorials

If you're interested in learning more about HTML, CSS, and
Javascript we recommend any one of the following resources:

- [Mozilla Developer Network Tutorials](https://developer.mozilla.org/en-US/docs/Web/Tutorials)
- [HTML & CSS from Khan Academy](https://www.khanacademy.org/computing/computer-programming/html-css)
- [Tutorials from Free Code Camp](https://www.freecodecamp.com/)

### Getting Started

- Make sure you have the latest release of R installed
- If on Windows, make sure that you have Rtools installed
- `install.packages("shiny")`
- `library(shiny)`
- Great tutorial at http://shiny.rstudio.com/tutorial/
- Basically, this lecture is walking through that tutorial 
offering some of our insights

### A Shiny project

A shiny project is a directory containing at least two files:

- `ui.R` (for user interface) controls how your app looks.
- `server.R` that controls what your app does.

### ui.R

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Data science FTW!"),
  sidebarLayout(
    sidebarPanel(
      h3("Sidebar Text")
    ),
    mainPanel(
      h3("Main Panel Text")
    )
  )
))
```

### server.R

```r
library(shiny)
shinyServer(function(input, output) {
})
```

### To run it
- In R, change to the directories with these files and type `runApp()`
- or put the path to the directory as an argument
- It should open a browser window with the app running

### Your First Shiny App

![](app1.png)

### HTML Tags in Shiny

Shiny provides several wrapper functions for using
standard HTML tags in your `ui.R`, including `h1()` through
`h6()`, `p()`, `a()`, `div()`, and `span()`.

- See `?builder` for more details.

### R Wrappers for HTML Tags

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("HTML Tags"),
  sidebarLayout(
    sidebarPanel(
      h1("H1 Text"),
      h3("H3 Text"),
      em("Emphasized Text")
    ),
    mainPanel(
      h3("Main Panel Text"),
      code("Some Code!")
    )
  )
))
```

### App with Many Tags

![](app2.png)

### App with Inputs and Outputs

Now that you've played around with customizing the look of
your app, let's give it some functionality! Shiny provides
several types of inputs including buttons, checkboxes, text
boxes, and calendars. First let's experiment with the slider
input. This simple app will display the number that is
selected with a slider.

### Slider App: ui.R

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Slider App"),
  sidebarLayout(
    sidebarPanel(
      h1("Move the Slider!"),
      sliderInput("slider1", "Slide Me!", 0, 100, 0)
    ),
    mainPanel(
      h3("Slider Value:"),
      textOutput("text")
    )
  )
))
```

### Slider App: server.R

```r
library(shiny)
shinyServer(function(input, output) {
  output$text <- renderText(input$slider1)
})
```

### Slider App

![](app3.png)

### New Components in the Slider App

#### ui.R

- `sliderInput()` specifies a slider that a user can manipulate
- `testOutput()` displays text that is rendered in `server.R`

#### server.R

- `renderText()` transforms UI input into text that can be displayed.

### Inputs and Outputs

Notice that in `ui.R` input and output names are assigned
with strings (`sliderInput("slider1",...`, `textOutput("text")`)
and in `server.R` those components can be accessed with the
`$` operator: `output$text <- renderText(input$slider1)`.

### Apps with Plots

Allowing users to manipulate data and to see the results of
their manipulations as a plot can be very useful. Shiny
provides the `plotOutput()` function for `ui.R` and the 
`renderPlot()` function for `sever.R` for taking user input 
and creating plots.

### Plot App: ui.R Part 1

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric", "How Many Random Numbers Should be Plotted?", 
                   value = 1000, min = 1, max = 1000, step = 1),
      sliderInput("sliderX", "Pick Minimum and Maximum X Values",
                  -100, 100, value = c(-50, 50)),

      sliderInput("sliderY", "Pick Minimum and Maximum Y Values",
                  -100, 100, value = c(-50, 50)),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
    mainPanel(
      h3("Graph of Random Points"),
      plotOutput("plot1")
    )
  )
))
```

### Plot App: server.R Part 1

```r
library(shiny)
shinyServer(function(input, output) {
  output$plot1 <- renderPlot({
    set.seed(2016-05-25)
    number_of_points <- input$numeric
    minX <- input$sliderX[1]
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]

    dataX <- runif(number_of_points, minX, maxX)
    dataY <- runif(number_of_points, minY, maxY)
    xlab <- ifelse(input$show_xlab, "X Axis", "")
    ylab <- ifelse(input$show_ylab, "Y Axis", "")
    main <- ifelse(input$show_title, "Title", "")
    plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main,
         xlim = c(-100, 100), ylim = c(-100, 100))
  })
})
```


### Apps with Plots

#### ui.R

- `numericInput()` allows the user to enter any number
- `checkboxInput()` creates boxes that can be checked
- `plotOutput()` displays a plot

#### server.R

- `renderPlot()` wraps the creation of a plot so it can be displayed

### Next Lecture

- Reactivity
- Advanced UI
- Interactive Graphics

### More about R and the Web
- [OpenCPU](https://public.opencpu.org/) by Jerome Ooms, is a really neat project providing an API for calling R from web documents

## Shiny revisited (shinier!)
* In the last lecture, we covered basic creation of 
Shiny applications
* If you tried it and are like most, you had an easy time with `ui.R`
but a harder time with `server.R`
* In this lecture, we cover some more of the details of shiny
* Since writing the last lecture, a more detailed tutorial has
been created that is worth checking out
(http://shiny.rstudio.com/tutorial/)


---

### Details
* Code that you put before `shinyServer` in the `server.R` function gets
called once when you do `runApp()`
* Code inside the unnamed function of `shinyServer(function(input, output){` but
not in a reactive statement will run once for every new user (or page refresh) 
* Code in reactive functions of `shinyServer` get run repeatedly as needed
when new values are entered (reactive functions are those like `render*`)

---
#### Experiment (code in the slidify document)
`ui.R`

```
shinyUI(pageWithSidebar(
  headerPanel("Hello Shiny!"),
  sidebarPanel(
      textInput(inputId="text1", label = "Input Text1"),
      textInput(inputId="text2", label = "Input Text2")
  ),
  mainPanel(
      p('Output text1'),
      textOutput('text1'),
      p('Output text2'),
      textOutput('text2'),
      p('Output text3'),
      textOutput('text3'),
      p('Outside text'),
      textOutput('text4'),
      p('Inside text, but non-reactive'),
      textOutput('text5')
  )
))

```

---
`server.R`
Set `x <- 0` before running
```
library(shiny)
x <<- x + 1
y <<- 0

shinyServer(
  function(input, output) {
    y <<- y + 1
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({as.numeric(input$text1)+1})
    output$text4 <- renderText(y)
    output$text5 <- renderText(x)
  }
)
```

---
### Try it
* type `runApp()` 
* Notice hitting refresh incriments `y` but enterting values in the textbox does not
* Notice `x` is always 1
* Watch how it updated `text1` and `text2` as needed.
* Doesn't add 1 to text1 every time a new `text2` is input.
* *Important* try `runApp(display.mode='showcase')` 

---
### Reactive expressions
* Sometimes to speed up your app, you want reactive operations (those operations that depend on widget input values) to be performed outside of a `render*`1 statement
* For example, you want to do some code that gets reused in several 
`render*` statements and don't want to recalculate it for each
* The `reactive` function is made for this purpose


---
### Example
`server.R`
```
shinyServer(
  function(input, output) {
    x <- reactive({as.numeric(input$text1)+100})      
    output$text1 <- renderText({x()                          })
    output$text2 <- renderText({x() + as.numeric(input$text2)})
  }
)
```

---
### As opposed to
```
shinyServer(
  function(input, output) {
    output$text1 <- renderText({as.numeric(input$text1)+100  })
    output$text2 <- renderText({as.numeric(input$text1)+100 + 
        as.numeric(input$text2)})
  }
)
```

---
### Discussion
* Do `runApp(display.mode='showcase')` 
* (While inconsequential) the second example has to add 100 twice every time
text1 is updated for the second set of code
* Also note the somewhat odd syntax for reactive variables


---
### Non-reactive reactivity (what?)
* Sometimes you don't want shiny to immediately perform reactive
calculations from widget inputs
* In other words, you want something like a submit button

---
### ui.R
```
shinyUI(pageWithSidebar(
  headerPanel("Hello Shiny!"),
  sidebarPanel(
      textInput(inputId="text1", label = "Input Text1"),
      textInput(inputId="text2", label = "Input Text2"),
      actionButton("goButton", "Go!")
  ),
  mainPanel(
      p('Output text1'),
      textOutput('text1'),
      p('Output text2'),
      textOutput('text2'),
      p('Output text3'),
      textOutput('text3')
  )
))
```

---
### Server.R
```
shinyServer(
  function(input, output) {
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({
        input$goButton
        isolate(paste(input$text1, input$text2))
    })
  }
)
```

---
### Try it out
* Notice it doesn't display output `text3` until the go button is pressed
* `input$goButton` (or whatever you named it) gets increased by one for every
time pushed
* So, when in reactive code (such as `render` or `reactive`) you can use conditional statements like below to only execute code on the first button press or to not execute code until the first or subsequent button press

```if (input$goButton == 1){  Conditional statements }``` 


---
## Example
Here's some replaced code from our previous `server.R` 

```r
output$text3 <- renderText({
    if (input$goButton == 0) "You have not pressed the button"
    else if (input$goButton == 1) "you pressed it once"
    else "OK quit pressing it"
})
```

---

### More on layouts
* The sidebar layout with a main panel is the easiest.
* Using `shinyUI(fluidpage(` is much more flexible and allows 
tighter access to the bootstrap styles
* Examples here (http://shiny.rstudio.com/articles/layout-guide.html)
* `fluidRow` statements create rows and then the `column` function
from within it can create columns
* Tabsets, navlists and navbars can be created for more complex apps

---
#### Directly using html
* For more complex layouts, direct use of html is preferred
    (http://shiny.rstudio.com/articles/html-ui.html)
* Also, if you know web development well, you might find using
R to create web layouts kind of annoying
* Create a directory called `www` in the same directory with `server.R`
* Have an `index.html` page in that directory
* Your named input variables will be passed to `server.R`
`<input type="number" name="n" value="500" min="1" max="1000" />`
* Your `server.R` output will have class definitions of the form `shiny-`
`<pre id="summary" class="shiny-text-output"></pre>`

---
### Debugging techniques for Shiny
* Debugging shiny apps can be tricky
* We saw that `runApp(displayMode = 'showcase')` highlights execution while a 
shiny app runs
* Using `cat` in your code displays output to stdout (so R console)
* The `browser()` function can interupt execution and can be called conditionally
(http://shiny.rstudio.com/articles/debugging.html)


## Shiny Part [2] (c9-w1)
### Reactivity

A reactive expression is like a recipe that manipulates
inputs from Shiny and then returns a value. Reactivity
provides a way for your app to respond since inputs will 
change depending on how users interact with your user 
interface. Expressions wrapped by `reactive()` should be
expressions that are subject to change.

### Reactivity

Creating a reactive expression is just like creating a
function:

```r
calc_sum <- reactive({
  input$box1 + input$box2
})
# ...
calc_sum()
```

### Your First Reactive App

```{r, echo=FALSE}
library(webshot)
appshot("app1", "app1.png")
```

This application predicts the horsepower of a car given
the fuel efficiency in miles per gallon for the car.

### Horsepower Prediction: ui.R Part 1

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
# ...
```

### Horsepower Prediction: ui.R Part 2

```r
# ...
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Horsepower from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2:"),
      textOutput("pred2")
    )
  )
))
```

### Horsepower Prediction: server.R Part 1

```r
library(shiny)
shinyServer(function(input, output) {
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
  model1 <- lm(hp ~ mpg, data = mtcars)
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg = mpgInput))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata = 
              data.frame(mpg = mpgInput,
                         mpgsp = ifelse(mpgInput - 20 > 0,
                                        mpgInput - 20, 0)))
  })
```
### Horsepower Prediction: server.R Part 2
```r
  output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG
    
    plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
         ylab = "Horsepower", bty = "n", pch = 16,
         xlim = c(10, 35), ylim = c(50, 350))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
      ))
      lines(10:35, model2lines, col = "blue", lwd = 2)
    }
```
### Horsepower Prediction: server.R Part 3
```r
  legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})
```

### Horsepower Prediction

![](app1.png)

### Delayed Reactivity

You might not want your app to immediately react to changes
in user input because of something like a long-running
calculation. In order to prevent reactive expressions from
reacting you can use a submit button in your app. Let's take
a look at last app we created, but with a submit button
added to the app.

```{r, echo=FALSE}
library(webshot)
appshot("app2", "app2.png")
```

### Reactive Horsepower: ui.R

There's one new line added to the code from the last app:

```r
shinyUI(fluidPage(
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit") # New!
    ),
```

### Reactive Horsepower

![](app2.png)

### Advanced UI

There are several other kinds of UI components that you can
mix into your app including tabs, navbars, and sidebars.
We'll show you an example of how to use tabs to give your app
multiple views. The `tabsetPanel()` function specifies a
group of tabs, and then the `tabPanel()` function specifies
the contents of an individual tab.

```{r, echo=FALSE}
library(webshot)
appshot("app3", "app3.png")
```

### Tabs: ui.R

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Tabs!"),
  sidebarLayout(
    sidebarPanel(
      textInput("box1", "Enter Tab 1 Text:", value = "Tab 1!"),
      textInput("box2", "Enter Tab 2 Text:", value = "Tab 2!"),
      textInput("box3", "Enter Tab 3 Text:", value = "Tab 3!")
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Tab 1", br(), textOutput("out1")), 
                  tabPanel("Tab 2", br(), textOutput("out2")), 
                  tabPanel("Tab 2", br(), textOutput("out3"))
      )
    )
  )
))
```

### Tabs: server.R

```r
library(shiny)
shinyServer(function(input, output) {
  output$out1 <- renderText(input$box1)
  output$out2 <- renderText(input$box2)
  output$out3 <- renderText(input$box3)
})
```

### Tabs

![](app3.png)

### Interactive Graphics

One of my favorite features of Shiny is the ability to create
graphics that a user can interact with. One method you can
use to select multiple data points on a graph is
by specifying the `brush` argument in `plotOutput()` on the
`ui.R` side, and then using the `brushedPoints()` function on
the `server.R` side. The following example app fits a
linear model for the selected points and then draws a line 
of best fit for the resulting model.

```{r, echo=FALSE}
library(webshot)
appshot("app4", "app4.png")
```

### Interactive Graphics: ui.R

```r
library(shiny)
shinyUI(fluidPage(
  titlePanel("Visualize Many Models"),
  sidebarLayout(
    sidebarPanel(
      h3("Slope"),
      textOutput("slopeOut"),
      h3("Intercept"),
      textOutput("intOut")
    ),
    mainPanel(
      plotOutput("plot1", brush = brushOpts(
        id = "brush1"
      ))
    )
  )
))
```

### Interactive Graphics: server.R Part 1

```r
library(shiny)
shinyServer(function(input, output) {
  model <- reactive({
    brushed_data <- brushedPoints(trees, input$brush1,
                            xvar = "Girth", yvar = "Volume")
    if(nrow(brushed_data) < 2){
      return(NULL)
    }
    lm(Volume ~ Girth, data = brushed_data)
  })
  output$slopeOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      model()[[1]][2]
    }
  })
# ...
```
### Interactive Graphics: server.R Part 2
```r
# ...
output$intOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      model()[[1]][1]
    }
  })
  output$plot1 <- renderPlot({
    plot(trees$Girth, trees$Volume, xlab = "Girth",
         ylab = "Volume", main = "Tree Measurements",
         cex = 1.5, pch = 16, bty = "n")
    if(!is.null(model())){
      abline(model(), col = "blue", lwd = 2)
    }
  })
})
```

### Interactive Graphics

![](app4.png)

### Sharing Shiny Apps

Once you've created a Shiny app, there are several ways to
share your app. Using [shinyapps.io](http://www.shinyapps.io/)
allows users to interact with your app through a web browser
without needing to have R or Shiny installed. Shinyapps.io
has a free tier, but if you want to use a Shiny app in your
business you may be interested in paying for the service. If
you're sharing your app with an R user you can post your app
to GitHub and instruct the user to use the `runGist()` or 
`runGitHub()` function to launch your app.

### More Shiny Resources

- [The Official Shiny Tutorial](http://shiny.rstudio.com/tutorial/)
- [Gallery of Shiny Apps](http://shiny.rstudio.com/gallery/)
- [Show Me Shiny: Gallery of R Web Apps](http://www.showmeshiny.com/)
- [Integrating Shiny and Plotly](https://plot.ly/r/shiny-tutorial/)
- [Shiny on Stack Overflow](http://stackoverflow.com/questions/tagged/shiny)
## Shiny_Gadgets (c9-w1)
### Introduction

Shiny Gadgets provide a way to use Shiny's interactivity and
user interface tools as a part of a data analysis. With
Shiny Gadgets you can create a function that opens a small 
Shiny app. Since these apps are smaller we'll be using the
miniUI package for creating user interfaces.

### A Simple Gadget

At its core a Shiny Gadget is a function that launches a
small (single-page) Shiny application. Since Shiny Gadgets
are meant to be displayed in the RStudio viewer pane, the
miniUI package comes in handy for its smaller graphical
elements. Let's construct a very simple Shiny Gadget.

### A Simple Gadget: Code

```r
library(shiny)
library(miniUI)
myFirstGadget <- function() {
  ui <- miniPage(
    gadgetTitleBar("My First Gadget")
  )
  server <- function(input, output, session) {
    # The Done button closes the app
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui, server)
}
```

### A Simple Gadget: Image

![myFirstGadget](myFirstGadget.png)

### A Simple Gadget: Code Review

Source the preceding code and run `myFirstGadget()` to see
a very basic Shiny Gadget. Just to review some of the new
functions in this Gadget:

- `miniPage()` creates a small layout.
- `gadgetTitleBar()` provides a title bar with Done and 
Cancel buttons.
- `runGadget()` runs the Shiny Gadget, taking `ui` and
`server` as arguments.

### Gadgets with Arguments

One of the advantages of Shiny Gadgets is that since Shiny
Gadgets are functions they can take values as arguments and
they can return values. Let's take a look at a simple
example of a Shiny Gadget that takes arguments and returns
a value. The following Shiny Gadget takes two different
vectors of numbers as arguments and uses those vectors to
populate two `selectInput`s. The user can then choose two
numbers within the Gadget, and the product of those two
numbers will be returned.

### Gadgets with Arguments: Code Part 1

```r
library(shiny)
library(miniUI)
multiplyNumbers <- function(numbers1, numbers2) {
  ui <- miniPage(
    gadgetTitleBar("Multiply Two Numbers"),
    miniContentPanel(
      selectInput("num1", "First Number", choices=numbers1),
      selectInput("num2", "Second Number", choices=numbers2)
    )
  )
  server <- function(input, output, session) {
    observeEvent(input$done, {
      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)
      stopApp(num1 * num2)
    })
  }
  runGadget(ui, server)
}
```

### Gadgets with Arguments: Image

![multiplyNumbers](multiplyNumbers.png)

### Gadgets with Arguments: Code Review

Source the preceding code and run 
`multiplyNumbers(1:5, 6:10)` so you
can get a sense of how this Gadget works. As you can see
this Gadget uses `selectInput()` so that the user can
select two different numbers. Clicking the Done button
multiplies the tow numbers together, which is returned as
the result of the `multiplyNumbers()` function.

### Gadgets with Interactive Graphics

Shiny Gadgets are particularly useful when a data analysis
needs a touch of human intervention. You can imagine
presenting an interactive data visualization through a
Gadget, where an analyst could manipulate data in the
Gadget, and then the Gadget would return the manipulated
data. Let's walk though an example of how this could be done.

### Gadgets with Interactive Graphics: Code Part 1

```r
library(shiny)
library(miniUI)
pickTrees <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )
```
### Gadgets with Interactive Graphics: Code Part 2
```r
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(trees$Girth, trees$Volume, main = "Trees!",
        xlab = "Girth", ylab = "Volume")
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(trees, input$brush,
        xvar = "Girth", yvar = "Volume"))
    })
  }
  runGadget(ui, server)
}
```

### Gadgets with Interactive Graphics: Image

![pickTrees](pickTrees.png)

### Gadgets with Interactive Graphics: Code Review

Source the preceding code and run `pickTrees()`. Click and
drag a box over the graph. Once you've drawn a box that
you're satisfied with click the Done button and the points
that you selected will be returned to you as a data frame.
This functionality is made possible by the `brushedPoints()`
function, which is part of the `shiny` package. (See 
`?shiny::brushedPoints` for more information.)

### Conclusion

For more details about Shiny Gadgets visit the Shiny Gadgets
website:

- http://shiny.rstudio.com/articles/gadgets.html
- http://shiny.rstudio.com/articles/gadget-ui.html
## GoogleVis (c9-w1)
### Google Vis API

<img class="center" src="googlecharts.png" height=250>

https://developers.google.com/chart/interactive/docs/gallery

### Basic idea

* The R function creates an HTML page
* The HTML page calls Google Charts
* The result is an interactive HTML graphic

### Example 

```{r gv, results="asis", cache=TRUE}
suppressPackageStartupMessages(library(googleVis))
M <- gvisMotionChart(Fruits, "Fruit", "Year",
                     options=list(width=600, height=400))
print(M,"chart")
```

### Charts in googleVis

<center> "gvis + ChartType" </center>

* Motion charts:  `gvisMotionChart`
* Interactive maps: `gvisGeoChart`
* Interactive tables: `gvisTable`
* Line charts: `gvisLineChart`
* Bar charts: `gvisColumnChart`
* Tree maps: `gvisTreeMap`

http://cran.r-project.org/web/packages/googleVis/googleVis.pdf

### Plots on maps

```{r,dependson="gv",results="asis", cache=TRUE}
G <- gvisGeoChart(Exports, locationvar="Country",
                  colorvar="Profit",options=list(width=600, height=400))
print(G,"chart")
```

### Specifying a region

```{r,dependson="gv",results="asis", cache=TRUE}
G2 <- gvisGeoChart(Exports, locationvar="Country",
                  colorvar="Profit",options=list(width=600, height=400,region="150"))
print(G2,"chart")
```

### Finding parameters to set under `options`


<img class="center" src="configoptions.png" height=250>

https://developers.google.com/chart/interactive/docs/gallery/geochart

### Setting more options

```{r linechart,dependson="gv",results="asis", cache=TRUE}
df <- data.frame(label=c("US", "GB", "BR"), val1=c(1,3,4), val2=c(23,12,32))
Line <- gvisLineChart(df, xvar="label", yvar=c("val1","val2"),
        options=list(title="Hello World", legend="bottom",
                titleTextStyle="{color:'red', fontSize:18}",                         
                vAxis="{gridlines:{color:'red', count:3}}",
                hAxis="{title:'My Label', titleTextStyle:{color:'blue'}}",
                series="[{color:'green', targetAxisIndex: 0}, 
                         {color: 'blue',targetAxisIndex:1}]",
                vAxes="[{title:'Value 1 (%)', format:'##,######%'}, 
                                  {title:'Value 2 (\U00A3)'}]",                          
                curveType="function", width=500, height=300                         
                ))
```

https://github.com/mages/Introduction_to_googleVis/blob/gh-pages/index.Rmd

### Setting more options

```{r ,dependson="linechart",results="asis", cache=TRUE}
print(Line,"chart")
```

### Combining multiple plots together

```{r multiplot,dependson="gv",results="asis", cache=TRUE}
G <- gvisGeoChart(Exports, "Country", "Profit",options=list(width=200, height=100))
T1 <- gvisTable(Exports,options=list(width=200, height=270))
M <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(width=400, height=370))
GT <- gvisMerge(G,T1, horizontal=FALSE)
GTM <- gvisMerge(GT, M, horizontal=TRUE,tableOptions="bgcolor=\"#CCCCCC\" cellspacing=10")
```

### Combining multiple plots together

```{r,dependson="multiplot",results="asis", cache=TRUE}
print(GTM,"chart")
```

### Seeing the HTML code

```{r ,dependson="gv", cache=TRUE}
M <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(width=600, height=400))
print(M)
print(M, 'chart', file='myfilename.html')
```

### Things you can do with Google Vis

* The visualizations can be embedded in websites with HTML code
* Dynamic visualizations can be built with Shiny, Rook, and R.rsp
* Embed them in [R markdown](http://www.rstudio.com/ide/docs/authoring/using_markdown) based documents
  * Set `results="asis"` in the chunk options
  * Can be used with [knitr](http://cran.r-project.org/web/packages/knitr/index.html) and [slidify](http://slidify.org/)

### For more info

```{r,eval=FALSE}
demo(googleVis)
```

* http://cran.r-project.org/web/packages/googleVis/vignettes/googleVis.pdf
* http://cran.r-project.org/web/packages/googleVis/googleVis.pdf
* https://developers.google.com/chart/interactive/docs/gallery
* https://developers.google.com/chart/interactive/faq
## plotly (c9-w1)
### What is Plotly?

Plotly is a web application for creating and sharing data visualizations. Plotly
can work with several programming languages and applications including R,
Python, and Microsoft Excel. We're going to concentrate on creating different
graphs with Plotly and sharing those graphs.

### Installing Plotly

Installing Plotly is easy:

```r
install.packages("plotly")
library(plotly)
```

If you want to share your visualizations on https://plot.ly/ you should make an
account on their site.

### Basic Scatterplot

A basic scatterplot is easy to make, with the added benefit of tooltips that
appear when your mouse hovers over each point. Specify a scatterplot by
indicating `type = "scatter"`. Notice that the arguments for the `x` and `y` 
variables as specified as formulas, with the tilde operator (`~`) preceding the
variable that you're plotting.


```{r, eval=FALSE}
library(plotly)
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter")
```

### Basic Scatterplot

```{r, echo=FALSE, message=FALSE}
library(plotly)
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter")
```

### Scatterplot Color

You can add color to your scatterplot points according to a categorical variable
in the data frame you use with `plot_ly()`.

```{r, eval=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", color = ~factor(cyl))
```

### Scatterplot Color

```{r, echo=FALSE, message=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", color = ~factor(cyl))
```

### Continuous Color

You can also show continuous variables with color in scatterplots.

```{r, eval=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", color = ~disp)
```

### Continuous Color

```{r, echo=FALSE, message=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", color = ~disp)
```

### Scatterplot Sizing

By specifying the `size` argument you can make each point in your scatterplot a
different size.

```{r, eval=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", 
        color = ~factor(cyl), size = ~hp)
```

### Scatterplot Sizing

```{r, echo=FALSE, message=FALSE}
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", 
        color = ~factor(cyl), size = ~hp)
```

### 3D Scatterplot

You can create a three-dimensional scatterplot with the `type = "scatter3d"`
argument. If you click and drag these scatterplots you can view them from
different angles.

```{r, eval=FALSE}
set.seed(2016-07-21)
temp <- rnorm(100, mean = 30, sd = 5)
pressue <- rnorm(100)
dtime <- 1:100
plot_ly(x = ~temp, y = ~pressue, z = ~dtime,
        type = "scatter3d", color = ~temp)
```

### 3D Scatterplot

```{r, echo=FALSE, message=FALSE}
set.seed(2016-07-21)
temp <- rnorm(100, mean = 30, sd = 5)
pressue <- rnorm(100)
dtime <- 1:100
plot_ly(x = ~temp, y = ~pressue, z = ~dtime,
        type = "scatter3d", color = ~temp)
```

### Line Graph

Line graphs are the default graph for `plot_ly()`. They're of course useful for
showing change over time:

```{r, eval=FALSE}
data("airmiles")
plot_ly(x = ~time(airmiles), y = ~airmiles, type = "scatter", mode = "lines")
```

### Line Graph

```{r, echo=FALSE, message=FALSE}
data("airmiles")
plot_ly(x = ~time(airmiles), y = ~airmiles, type = "scatter", mode = "lines")
```

### Multi Line Graph

You can show multiple lines by specifying the column in the data frame that
separates the lines:

```{r, eval=FALSE}
library(plotly)
library(tidyr)
library(dplyr)
data("EuStockMarkets")
stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets), 4))
plot_ly(stocks, x = ~time, y = ~price, color = ~index, type = "scatter", mode = "lines")
```

### Multi Line Graph

```{r, echo=FALSE, message=FALSE}
library(plotly)
library(tidyr)
library(dplyr)
data("EuStockMarkets")
stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets), 4))
plot_ly(stocks, x = ~time, y = ~price, color = ~index, type = "scatter", mode = "lines")
```

### Histogram

A histogram is great for showing how counts of data are distributed. Use the
`type = "histogram"` argument.

```{r, eval=FALSE}
plot_ly(x = ~precip, type = "histogram")
```

### Histogram

```{r, echo=FALSE, message=FALSE}
plot_ly(x = ~precip, type = "histogram")
```

### Boxplot

Boxplots are wonderful for comparing how different datasets are distributed.
Specify `type = "box"` to create a boxplot.

```{r, eval=FALSE}
plot_ly(iris, y = ~Petal.Length, color = ~Species, type = "box")
```

### Boxplot

```{r, echo=FALSE, message=FALSE}
plot_ly(iris, y = ~Petal.Length, color = ~Species, type = "box")
```

### Heatmap

Heatmaps are useful for displaying three dimensional data in two dimensions,
using color for the third dimension. Create a heatmap by using the
`type = "heatmap"` argument.

```{r, eval=FALSE}
terrain1 <- matrix(rnorm(100*100), nrow = 100, ncol = 100)
plot_ly(z = ~terrain1, type = "heatmap")
```

### Heatmap

```{r, echo=FALSE, message=FALSE}
terrain1 <- matrix(rnorm(100*100), nrow = 100, ncol = 100)
plot_ly(z = ~terrain1, type = "heatmap")
```

### 3D Surface

Why limit yourself to two dimensions when you can render three dimensions on a
computer!? Create moveable 3D surfaces with `type = "surface"`.

```{r, eval=FALSE}
terrain2 <- matrix(sort(rnorm(100*100)), nrow = 100, ncol = 100)
plot_ly(z = ~terrain2, type = "surface")
```

### 3D Surface

```{r, echo=FALSE, message=FALSE}
terrain2 <- matrix(sort(rnorm(100*100)), nrow = 100, ncol = 100)
plot_ly(z = ~terrain2, type = "surface")
```

### Choropleth Maps: Setup

Choropleth maps illustrate data across geographic areas by shading regions with
different colors. Choropleth maps are easy to make with Plotly though they
require more setup compared to other Plotly graphics.

```{r, eval=FALSE}
# Create data frame
state_pop <- data.frame(State = state.abb, Pop = as.vector(state.x77[,1]))
# Create hover text
state_pop$hover <- with(state_pop, paste(State, '<br>', "Population:", Pop))
# Make state borders white
borders <- list(color = toRGB("red"))
# Set up some mapping options
map_options <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
```

### Choropleth Maps: Mapping

```{r, eval=FALSE}
plot_ly(z = ~state_pop$Pop, text = ~state_pop$hover, locations = ~state_pop$State, 
        type = 'choropleth', locationmode = 'USA-states', 
        color = state_pop$Pop, colors = 'Blues', marker = list(line = borders)) %>%
  layout(title = 'US Population in 1975', geo = map_options)
```

### Choropleth Maps

```{r, echo=FALSE, message=FALSE}
# Create data frame
state_pop <- data.frame(State = state.abb, Pop = as.vector(state.x77[,1]))
# Create hover text
state_pop$hover <- with(state_pop, paste(State, '<br>', "Population:", Pop))
# Make state borders white
borders <- list(color = toRGB("red"))
# Set up some mapping options
map_options <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
plot_ly(z = ~state_pop$Pop, text = ~state_pop$hover, locations = ~state_pop$State, 
        type = 'choropleth', locationmode = 'USA-states', 
        color = state_pop$Pop, colors = 'Blues', marker = list(line = borders)) %>%
  layout(title = 'US Population in 1975', geo = map_options)
```

### More Resources

- [The Plolty Website](https://plot.ly/)
- [The Plotly R API](https://plot.ly/r/)
- [The Plotly R Package on GitHub](https://github.com/ropensci/plotly)
- [The Plotly R Cheatsheet](https://images.plot.ly/plotly-documentation/images/r_cheat_sheet.pdf)
- ["Plotly for R" book by Carson Sievert](https://cpsievert.github.io/plotly_book/)


## R_markdown (c9-w2)
### Introduction

R Markdown is built into RStudio and allows you to create documents like HTML, PDF, and Word documents from R. With R Markdown, you can embed R code into your documents. 

#### Why use R Markdown?
- Turn work in R into more accessible formats
- Incorporate R code and R plots into documents
- R Markdown documents are reproducible -- the source code gets rerun every time a document is generated, so if data change or source code changes, the output in the document will change with it. 

### Getting Started

- Create a new R Markdown file in RStudio by going to  
File > New File > R Markdown...
- Click the "presentation" tab
- Enter a title, author, and select what kind of slideshow you ultimately want (this can all be changed later)

### Getting Started
The beginning of an R Markdown file looks like this:<br><br>
`---`  
`title: "Air Quality"`  
`author: "JHU"`  
`date: "May 17, 2016"`  
`output: html_document`  
`---`<br><br>
The new document you've created will contain example text and code below this -- delete it for a fresh start.

### Making Your First Slide
- Title your first slide using two # signs: <br> `## Insert Title Here`
- To make a slide without a title, use three asterisks:<br> `***`
- You can add subheadings with more # signs: <br>
`### Subheading` or `#### Smaller Subheading`
- To add a new slide, just add another Title: <br> `## New Slide Title`

### Adding Text
- Add bullet points to a slide using a hyphen followed by a space: <br>
`- bullet point`
- Add sub-points using four spaces and a plus sign:<br>
&nbsp;&nbsp;&nbsp;&nbsp;`+ sub-point`
- Add an ordered list by typing the number/letter: <br>
`1. first point`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`a) sub-sub-point`
- Add bullet points that appear one by one (on click) with:<br>
`>- iterated bullet point`

### Formatting Text
              Text                               Code in R Markdown
----------------------------------    ----------------------------------------
           plain text                              `plain text`  
           *italics*                               `*italics*`  
           **bold**                                `**bold**` 
  [link](http://www.jhsph.edu)          `[link](http://www.jhsph.edu)`  
          `verbatim code`                          ` `code here` `
 
### Embedding R Code
This is a chunk of R code in R Markdown:<br><br>
\`\`\`{r} <br>
`head(airquality)`<br>
\`\`\`  
The code gets run, and both the input and output are displayed.
```{r}
head(airquality)
```

### Embedding R Code
To hide the input code, use `echo=FALSE`.<br><br>
\`\`\`{r, echo=FALSE} <br>
`head(airquality)`<br>
\`\`\` 
```{r, echo=FALSE}
head(airquality)
```
This can be useful for showing plots.

### Embedding R Code
To show the input code only, use `eval=FALSE`.<br><br>
\`\`\`{r, eval=FALSE} <br>
`head(airquality)`<br>
\`\`\` 
```{r, eval=FALSE}
head(airquality)
```

### Embedding R Code
To run the code without showing input or output, use `include=FALSE`. <br><br>
\`\`\`{r, include=FALSE} <br>
`library(ggplot2)`<br>
\`\`\` 

### Generating Slideshows
- Click the **Knit** button at the top of the R Markdown document to generate your new document.
    + You may be asked to install required packages if you don't already have them installed -- hit "Yes" and RStudio will install them for you
- You can change the type of document generated by changing the `output` line in the header, or by selecting an output from the **Knit** button's pull-down menu.

### Generating Slideshows
- HTML: two options with different looks
    + `output: ioslides_presentation` This is available in my emacs
      knitr framework
    + `output: slidy_presentation`
- PDF: `output: beamer_presentation`  
- Note: You can specify multiple outputs at the beginning of the R Markdown file if you will need to generate multiple filetypes. 

### PDFs and LaTeX
- To **knit** a PDF slideshow, you will need to install **LaTeX** on your computer
- LaTeX is a typesetting system that is needed to convert R Markdown into formatted text for PDFs

#### Downloading and Installing LaTeX
- *LaTeX* is free
- LaTeX takes up a lot of space (almost ~2.6 GB download and takes up ~5 GB when installed)
- Visit [https://www.tug.org/begin.html](https://www.tug.org/begin.html) to download LaTeX for your operating system
- Depending on your internet connection, it may take a while to download due to its size 

### Conclusion

For more information about R Markdown visit http://rmarkdown.rstudio.com/
## leaflet (c9-w2)
### Introduction

Leaflet is one of the most popular Javascript libraries for
creating interactive maps. The leaflet R package allows you
to create your own leaflet maps without needing to know any
Javascript!

#### Installation

```r
install.packages("leaflet")
```

### Your First Map

Getting started with leaflet is easy. The `leaflet()`
function creates a map widget that you can store in a
variable so that you can modify the map later on. You can
add features to the map using the pipe operator (`%>%`) just
like in dplyr. The `addTiles()` function adds mapping data
from [Open Street Map](http://www.openstreetmap.org/).

```{r, eval=FALSE}
library(leaflet)
my_map <- leaflet() %>% 
  addTiles()
my_map
```

### Your First Map

```{r, echo=FALSE}
library(leaflet)
my_map <- leaflet() %>% 
  addTiles()
my_map
```

### Adding Markers

You can add markers to your map one at a time using the
`addMarkers()` function by specifying the longitude and
latitude. ([Here's](https://twitter.com/drob/status/719927537330040832)
a tip if you tend to mix them up.) You can specify popup
text for when you click on the marker with the `popup` 
argument.

```{r, eval=FALSE}
library(leaflet)
my_map <- my_map %>%
  addMarkers(lat=39.2980803, lng=-76.5898801, 
             popup="Jeff Leek's Office")
my_map
```

### Adding Markers

```{r, echo=FALSE}
library(leaflet)
my_map <- my_map %>%
  addMarkers(lat=39.2980803, lng=-76.5898801, 
             popup="Jeff Leek's Office")
my_map
```

### Adding Many Markers

Adding one marker at a time is often not practical if you
want to display many markers. If you have a data frame with
columns `lat` and `lng` you can pipe that data frame into
`leaflet()` to add all the points at once.

```{r, eval=FALSE}
set.seed(2016-04-25)
df <- data.frame(lat = runif(20, min = 39.2, max = 39.3),
                 lng = runif(20, min = -76.6, max = -76.5))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers()
```

### Adding Many Markers

```{r, echo=FALSE}
set.seed(2016-04-25)
df <- data.frame(lat = runif(20, min = 39.2, max = 39.3),
                 lng = runif(20, min = -76.6, max = -76.5))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers()
```

### Making Custom Markers

The blue markers that leaflet comes packaged with may not be
enough depending on what you're mapping. Thankfully you can
make your own markers from `.png` files.

```{r, eval=FALSE}
hopkinsIcon <- makeIcon(
  iconUrl = "http://brand.jhu.edu/content/uploads/2014/06/university.shield.small_.blue_.png",
  iconWidth = 31*215/230, iconHeight = 31,
  iconAnchorX = 31*215/230/2, iconAnchorY = 16
)
hopkinsLatLong <- data.frame(
  lat = c(39.2973166, 39.3288851, 39.2906617),
  lng = c(-76.5929798, -76.6206598, -76.5469683))
hopkinsLatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = hopkinsIcon)
```

### Making Custom Markers

```{r, echo=FALSE}
hopkinsIcon <- makeIcon(
  iconUrl = "http://brand.jhu.edu/content/uploads/2014/06/university.shield.small_.blue_.png",
  iconWidth = 31*215/230, iconHeight = 31,
  iconAnchorX = 31*215/230/2, iconAnchorY = 16
)
hopkinsLatLong <- data.frame(
  lat = c(39.2973166, 39.3288851, 39.2906617, 39.2970681, 39.2824806),
  lng = c(-76.5929798, -76.6206598, -76.5469683, -76.6150537, -76.6016766))
hopkinsLatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = hopkinsIcon)
```

### Adding Multiple Popups

When adding multiple markers to a map, you may want to add
popups for each marker. You can specify a string of plain
text for each popup, or you can provide HTML which will be
rendered inside of each popup.

```{r, eval=FALSE}
hopkinsSites <- c(
  "<a href='http://www.jhsph.edu/'>East Baltimore Campus</a>",
  "<a href='https://apply.jhu.edu/visit/homewood/'>Homewood Campus</a>",
  "<a href='http://www.hopkinsmedicine.org/johns_hopkins_bayview/'>Bayview Medical Center</a>",
  "<a href='http://www.peabody.jhu.edu/'>Peabody Institute</a>",
  "<a href='http://carey.jhu.edu/'>Carey Business School</a>"
)
hopkinsLatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = hopkinsIcon, popup = hopkinsSites)
```

### Adding Multiple Popups

```{r, echo=FALSE}
hopkinsSites <- c(
  "<a href='http://www.jhsph.edu/'>East Baltimore Campus</a>",
  "<a href='https://apply.jhu.edu/visit/homewood/'>Homewood Campus</a>",
  "<a href='http://www.hopkinsmedicine.org/johns_hopkins_bayview/'>Bayview Medical Center</a>",
  "<a href='http://www.peabody.jhu.edu/'>Peabody Institute</a>",
  "<a href='http://carey.jhu.edu/'>Carey Business School</a>"
)
hopkinsLatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = hopkinsIcon, popup = hopkinsSites)
```

### Mapping Clusters

Sometimes you might have so many points on a map that it
doesn't make sense to plot every marker. In these situations
leaflet allows you to plot clusters of markers using
`addMarkers(clusterOptions = markerClusterOptions())`. When
you zoom in to each cluster, the clusters will separate until
you can see the individual markers.

```{r, eval=FALSE}
df <- data.frame(lat = runif(500, min = 39.25, max = 39.35),
                 lng = runif(500, min = -76.65, max = -76.55))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())
```

### Mapping Clusters

```{r, echo=FALSE}
df <- data.frame(lat = runif(500, min = 39.25, max = 39.35),
                 lng = runif(500, min = -76.65, max = -76.55))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())
```

### Mapping Circle Markers

Instead of adding markers or clusters you can easily add
circle markers using `addCircleMarkers()`.

```{r, eval=FALSE}
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers()
```

### Mapping Circle Markers

```{r, echo=FALSE}
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers()
```

### Drawing Circles

You can draw arbitrary shapes on the maps you create,
including circles and squares. The code below draws a map
where the circle on each city is proportional to the
population of that city.

```{r, eval=FALSE}
md_cities <- data.frame(name = c("Baltimore", "Frederick", "Rockville", "Gaithersburg", 
                                 "Bowie", "Hagerstown", "Annapolis", "College Park", "Salisbury", "Laurel"),
                        pop = c(619493, 66169, 62334, 61045, 55232,
                                39890, 38880, 30587, 30484, 25346),
                        lat = c(39.2920592, 39.4143921, 39.0840, 39.1434, 39.0068, 39.6418, 38.9784, 38.9897, 38.3607, 39.0993),
                        lng = c(-76.6077852, -77.4204875, -77.1528, -77.2014, -76.7791, -77.7200, -76.4922, -76.9378, -75.5994, -76.8483))
md_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight = 1, radius = sqrt(md_cities$pop) * 30)
```

### Drawing Circles

```{r, echo=FALSE}
md_cities <- data.frame(name = c("Baltimore", "Frederick", "Rockville", "Gaithersburg", 
                                 "Bowie", "Hagerstown", "Annapolis", "College Park", "Salisbury", "Laurel"),
                        pop = c(619493, 66169, 62334, 61045, 55232,
                                39890, 38880, 30587, 30484, 25346),
                        lat = c(39.2920592, 39.4143921, 39.0840, 39.1434, 39.0068, 39.6418, 38.9784, 38.9897, 38.3607, 39.0993),
                        lng = c(-76.6077852, -77.4204875, -77.1528, -77.2014, -76.7791, -77.7200, -76.4922, -76.9378, -75.5994, -76.8483))
md_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight = 1, radius = sqrt(md_cities$pop) * 30)
```

### Drawing Rectangles

You can add rectangles on leaflet maps as well:

```{r, eval=FALSE}
leaflet() %>%
  addTiles() %>%
  addRectangles(lat1 = 37.3858, lng1 = -122.0595, 
                lat2 = 37.3890, lng2 = -122.0625)
```

### Drawing Rectangles

```{r, echo=FALSE}
leaflet() %>%
  addTiles() %>%
  addRectangles(lat1 = 37.3858, lng1 = -122.0595, 
                lat2 = 37.3890, lng2 = -122.0625)
```

### Adding Legends

Adding a legend can be useful if you have markers on your
map with different colors:

```{r, eval=FALSE}
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55),
                 col = sample(c("red", "blue", "green"), 20, replace = TRUE),
                 stringsAsFactors = FALSE)
df %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(color = df$col) %>%
  addLegend(labels = LETTERS[1:3], colors = c("blue", "red", "green"))
```

### Adding Legends

```{r, echo=FALSE, message=FALSE}
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55),
                 col = sample(c("red", "blue", "green"), 20, replace = TRUE),
                 stringsAsFactors = FALSE)
df %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(color = df$col) %>%
  addLegend(labels = LETTERS[1:3], colors = c("blue", "red", "green"))
```

### Conclusion

For more details about the leaflet package for R 
visit http://rstudio.github.io/leaflet/.
## Assignment 2, c9-w2

```r 
knitr yaml!

---

title: "Rmarkdown with Maps"
date: "June 6, 2019"
output: html

---


```

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, message=F, warning=F, cache=T)
```


### Maps: Library and Station and TU Delft building of my City

```{r, echo=F }
library(leaflet)

df <- data.frame(lat = c(52.002901,52.007517,51.990961), lng = 
c( 4.375342, 4.357094,4.375575),
popup=c("library","station","aerospace building"),col=c("red","green","black"),stringsAsFactors = FALSE)
df %>% leaflet() %>% addTiles() %>% addCircleMarkers(color=df$col) %>%
    addLegend(labels=c("library","station","Aerospace building"),colors=c("red","green","black"))

```

## Rpackages (c9-)
### What is an R Package?

- A mechanism for extending the basic functionality of R
- A collection of R functions, or other (data) objects
- Organized in a systematic fashion to provide a minimal amount of consistency
- Written by users/developers everywhere



### Where are These R Packages?

- Primarily available from CRAN and Bioconductor

- Also available from GitHub, Bitbucket, Gitorious, etc. (and elsewhere)

- Packages from CRAN/Bioconductor can be installed with `install.packages()`

- Packages from GitHub can be installed using `install_github()` from
  the <b>devtools</b> package

You do not have to put a package on a central repository, but doing so
makes it easier for others to install your package.



### What's the Point?

- "Why not just make some code available?"
- Documentation / vignettes
- Centralized resources like CRAN
- Minimal standards for reliability and robustness
- Maintainability / extension
- Interface definition / clear API
- Users know that it will at least load properly



### Package Development Process

- Write some code in an R script file (.R)
- Want to make code available to others
- Incorporate R script file into R package structure
- Write documentation for user functions
- Include some other material (examples, demos, datasets, tutorials)
- Package it up!



### Package Development Process

- Submit package to CRAN or Bioconductor
- Push source code repository to GitHub or other source code sharing web site
- People find all kinds of problems with your code
  - Scenario #1: They tell you about those problems and expect you to fix it
  - Scenario #2: They fix the problem for you and show you the changes
- You incorporate the changes and release a new version



### R Package Essentials

- An R package is started by creating a directory with the name of the R package
- A DESCRIPTION file which has info about the package
- R code! (in the R/ sub-directory)
- Documentation (in the man/ sub-directory)
- NAMESPACE
- Full requirements in Writing R Extensions



### The DESCRIPTION File

- <b>Package</b>: Name of package (e.g. library(name))
- <b>Title</b>: Full name of package
- <b>Description</b>: Longer description of package in one sentence (usually)
- <b>Version</b>: Version number (usually M.m-p format)
- <b>Author</b>, <b>Authors@R</b>: Name of the original author(s)
- <b>Maintainer</b>: Name + email of person who fixes problems
- <b>License</b>: License for the source code



### The DESCRIPTION File

These fields are optional but commonly used

- <b>Depends</b>: R packages that your package depends on
- <b>Suggests</b>: Optional R packages that users may want to have installed
- <b>Date</b>: Release date in YYYY-MM-DD format
- <b>URL</b>: Package home page
- <b>Other</b> fields can be added



### DESCRIPTION File: `gpclib`

<b>Package</b>:  gpclib<br />
<b>Title</b>:  General Polygon Clipping Library for R<br />
<b>Description</b>:  General polygon clipping routines for R based on Alan Murta's C library.<br />
<b>Version</b>:  1.5-5<br />
<b>Author</b>:  Roger D. Peng <rpeng@jhsph.edu> with contributions from Duncan Murdoch and Barry Rowlingson; GPC library by Alan Murta<br />
<b>Maintainer</b>:  Roger D. Peng <rpeng@jhsph.edu><br />
<b>License</b>:  file LICENSE<br />
<b>Depends</b>:  R (>= 2.14.0), methods<br />
<b>Imports</b>:  graphics<br />
<b>Date</b>:  2013-04-01<br />
<b>URL</b>:  http://www.cs.man.ac.uk/~toby/gpc/, http://github.com/rdpeng/gpclib



### R Code

- Copy R code into the R/ sub-directory
- There can be any number of files in this directory
- Usually separate out files into logical groups
- Code for all functions should be included here and not anywhere else in the package



### The NAMESPACE File

- Used to indicate which functions are <b>exported</b>
- Exported functions can be called by the user and are considered the public API
- Non-exported functions cannot be called directly by the user (but the code can be viewed)
- Hides implementation details from users and makes a cleaner package interface



### The NAMESPACE File

- You can also indicate what functions you <b>import</b> from other packages
- This allows for your package to use other packages without making other packages visible to the user
- Importing a function loads the package but does not attach it to the search list



### The NAMESPACE File

Key directives

- export("\<function>") 
- import("\<package>")
- importFrom("\<package>", "\<function>")

Also important

- exportClasses("\<class>")
- exportMethods("\<generic>")



### NAMESPACE File: `mvtsplot` package

```r
export("mvtsplot")
import(splines)
import(RColorBrewer)
importFrom("grDevices", "colorRampPalette", "gray")
importFrom("graphics", "abline", "axis", "box", "image", 
           "layout", "lines", "par", "plot", "points", 
           "segments", "strwidth", "text", "Axis")
importFrom("stats", "complete.cases", "lm", "na.exclude", 
           "predict", "quantile")
```



### NAMESPACE File: `gpclib` package

```r
export("read.polyfile", "write.polyfile")
importFrom(graphics, plot)
exportClasses("gpc.poly", "gpc.poly.nohole")
exportMethods("show", "get.bbox", "plot", "intersect", "union", 
              "setdiff", "[", "append.poly", "scale.poly", 
              "area.poly", "get.pts", "coerce", "tristrip", 
              "triangulate")
```



### Documentation

- Documentation files (.Rd) placed in man/ sub-directory
- Written in a specific markup language
- Required for every exported function
  - Another reason to limit exported functions
- You can document other things like concepts, package overview



### Help File Example: `line` Function

```
\name{line}
\alias{line}
\alias{residuals.tukeyline}
\title{Robust Line Fitting}
\description{
  Fit a line robustly as recommended in \emph{Exploratory Data Analysis}.
}
```



### Help File Example: `line` Function

```
\usage{
line(x, y)
}
\arguments{
  \item{x, y}{the arguments can be any way of specifying x-y pairs.  See
    \code{\link{xy.coords}}.}
}
```



### Help File Example: `line` Function

```
\details{
  Cases with missing values are omitted.
  Long vectors are not supported.
}
\value{
  An object of class \code{"tukeyline"}.
  Methods are available for the generic functions \code{coef},
  \code{residuals}, \code{fitted}, and \code{print}.
}
```



### Help File Example: `line` Function

```
\references{
  Tukey, J. W. (1977).
  \emph{Exploratory Data Analysis},
  Reading Massachusetts: Addison-Wesley.
}
```



### Building and Checking

- R CMD build is a command-line program that creates a package archive
  file (`.tar.gz`)

- R CMD check runs a battery of tests on the package

- You can run R CMD build or R CMD check from the command-line using a
  terminal or command-shell application

- You can also run them from R using the system() function

```r
system("R CMD build newpackage")
system("R CMD check newpackage")
```



### Checking

- R CMD check runs a battery tests
- Documentation exists
- Code can be loaded, no major coding problems or errors
- Run examples in documentation
- Check docs match code
- All tests must pass to put package on CRAN




### Getting Started

- The `package.skeleton()` function in the utils package creates a "skeleton" R package
- Directory structure (R/, man/), DESCRIPTION file, NAMESPACE file, documentation files
- If there are functions visible in your workspace, it writes R code files to the R/ directory
- Documentation stubs are created in man/
- You need to fill in the rest!



### Summary

- R packages provide a systematic way to make R code available to others
- Standards ensure that packages have a minimal amount of documentation and robustness
- Obtained from CRAN, Bioconductor, Github, etc.



### Summary

- Create a new directory with R/ and man/ sub-directories (or just use package.skeleton())
- Write a DESCRIPTION file
- Copy R code into the R/ sub-directory
- Write documentation files in man/ sub-directory
- Write a NAMESPACE file with exports/imports
- Build and check

### Agent

There is a lecture demo on making R package! in week 3 of course 9
:https://www.coursera.org/learn/data-products/lecture/t8FX1/building-r-packages-demo

2 things that they do with rstudio and needs an alternative in emacs
is : building documentation and checking code worthiness for cran and
loading a package! We can figure it out later as needed!


## Classes and Methods (c9-w1)
### Classes and Methods

- A system for doing object oriented programming
- R was originally quite interesting because it is both interactive _and_ has a system for object orientation.
    - Other languages which support OOP (C++, Java, Lisp, Python, Perl) generally speaking are not interactive languages
    
### Classes and Methods

- In R much of the code for supporting classes/methods is written by John Chambers himself (the creator of the original S language) and documented in the book _Programming with Data: A Guide to the S Language_
- A natural extension of Chambers' idea of allowing someone to cross the user -> programmer spectrum
- Object oriented programming is a bit different in R than it is in most languages - even if you are familiar with the idea, you may want to pay attention to the details

### Two styles of classes and methods

S3 classes/methods
- Included with version 3 of the S language. 
- Informal, a little kludgey
- Sometimes called _old-style_ classes/methods

S4 classes/methods
- more formal and rigorous
- Included with S-PLUS 6 and R 1.4.0 (December 2001) 
- Also called _new-style_ classes/methods

### Two worlds living side by side

- For now (and the forseeable future), S3 classes/methods and S4 classes/methods are separate systems (but they can be mixed to some degree).
- Each system can be used fairly independently of the other.
- Developers of new projects (you!) are encouraged to use the S4 style classes/methods.
    - Used extensively in the Bioconductor project
- But many developers still use S3 classes/methods because they are "quick and dirty" (and easier).
- In this lecture we will focus primarily on S4 classes/methods
- The code for implementing S4 classes/methods in R is in the *methods* package, which is usually loaded by default (but you can load it with `library(methods)` if for some reason it is not loaded)

### Object Oriented Programming in R

- A class is a description of a thing. A class can be defined using `setClass()` in the *methods* package.
- An _object_ is an instance of a class. Objects can be created using `new()`. 
- A _method_ is a function that only operates on a certain class of objects.
- A generic function is an R function which dispatches methods. A generic function typically encapsulates a "generic" concept (e.g. `plot`, `mean`, `predict`, ...)
    - The generic function does not actually do any computation.
- A _method_ is the implementation of a generic function for an object of a particular class.

### Things to look up

- The help files for the 'methods' package are extensive - do read them as they are the primary documentation
- You may want to start with `?Classes` and `?Methods` 
- Check out `?setClass`, `?setMethod`, and `?setGeneric`
- Some of it gets technical, but try your best for now-it will make sense in the future as you keep using it.
- Most of the documentation in the *methods* package is oriented towards developers/programmers as these are the primary people using classes/methods

### Classes

All objects in R have a class which can be determined by the class function

```{r}
class(1)
class(TRUE)
```

### Classes

```{r}
class(rnorm(100))
class(NA)
class("foo")
```

### Classes (cont'd)

Data classes go beyond the atomic classes

```{r}
x <- rnorm(100)
y <- x + rnorm(100)
fit <- lm(y ~ x)  ## linear regression model
class(fit)
```

### Generics/Methods in R

- S4 and S3 style generic functions look different but conceptually, they are the same (they play the same role).
- When you program you can write new methods for an existing generic OR create your own generics and associated methods.
- Of course, if a data type does not exist in R that matches your needs, you can always define a new class along with generics/methods that go with it.

### An S3 generic function (in the 'base' package)

The `mean` and `print` functions are generic 
```{r}
mean
```

### An S3 generic function (in the 'base' package)

```{r}
print
```

### S3 methods

The `mean` generic function has a number of methods associated with it.

```{r}
methods("mean")
```

### An S4 generic function

The `show` function is from the <b>methods</b> package and is the S4
equivalent of `print`
```{r}
library(methods)
show
```
The `show` function is usually not called directly (much like `print`)
because objects are auto-printed.

### S4 methods

```{r}
showMethods("show")
```

### Generic/method mechanism

The first argument of a generic function is an object of a particular class (there may be other arguments)

1. The generic function checks the class of the object.
2. A search is done to see if there is an appropriate method for that class.
3. If there exists a method for that class, then that method is called on the object and we're done.
4. If a method for that class does not exist, a search is done to see if there is a default method for the generic. If a default exists, then the default method is called.
5. If a default method doesn't exist, then an error is thrown.

### Examining Code for Methods

- You cannot just print the code for a method like other functions because the code for the method is usually hidden.
- If you want to see the code for an S3 method, you can use the function `getS3method`.
- The call is `getS3method(<generic>, <class>)`
- For S4 methods you can use the function `getMethod`
- The call is `getMethod(<generic>, <signature>)` (more details later)

### S3 Class/Method: Example 1

What's happening here?

```{r}
set.seed(2)
x <- rnorm(100)
mean(x)
```

1. The class of x is "numeric"
2. But there is no mean method for "numeric" objects!
3. So we call the default function for `mean`.

### S3 Class/Method: Example 1

```{r}
head(getS3method("mean", "default"), 10)
```

### S3 Class/Method: Example 1

```{r}
tail(getS3method("mean", "default"), 10)
```

### S3 Class/Method: Example 2

What happens here?

```{r}
set.seed(3)
df <- data.frame(x = rnorm(100), y = 1:100)
sapply(df, mean)
```

### S3 Class/Method: Example 2

1. The class of `df` is "data.frame"; each column can be an object of
a different class

2. We `sapply` over the columns and call the `mean` function

3. In each column, `mean` checks the class of the object and dispatches the
appropriate method.

4. We have a `numeric` column and an `integer` column; `mean` calls the default method for both

### Calling Methods Directly

* Some S3 methods are visible to the user (i.e. `mean.default`),

* <b>Never</b> call methods directly

* Use the generic function and let the method be dispatched
automatically.

* With S4 methods you cannot call them directly at all

### S3 Class/Method: Example 3

The `plot` function is generic and its behavior depends on the object being plotted. 

```{r ex3_1,eval=FALSE}
set.seed(10)
x <- rnorm(100)
plot(x)
```

### S3 Class/Method: Example 3

```{r tenPlot, echo=FALSE}
set.seed(10)
x <- rnorm(100)
plot(x)
```

### S3 Class/Method: Example 3

For time series objects, `plot` connects the dots

```{r ex3_3,eval=FALSE}
set.seed(10)
x <- rnorm(100)
x <- as.ts(x) ## Convert to a time series object 
plot(x)
```

### S3 Class/Method: Example 3

```{r ex3_4,echo=FALSE}
set.seed(10)
x <- rnorm(100)
x <- as.ts(x) ## Convert to a time series object 
plot(x)
```

### Write your own methods!

If you write new methods for new classes, you'll probably end up writing methods for the following generics:
- print/show 
- summary 
- plot

There are two ways that you can extend the R system via classes/methods
- Write a method for a new class but for an existing generic function (i.e. like
`print`)
- Write new generic functions and new methods for those generics

### S4 Classes

Why would you want to create a new class?
- To represent new types of data (e.g. gene expression, space-time, hierarchical, sparse matrices)
- New concepts/ideas that haven't been thought of yet (e.g. a fitted point process model, mixed-effects model, a sparse matrix)
- To abstract/hide implementation details from the user
I say things are "new" meaning that R does not know about them (not that they are new to the statistical community).

### S4 Class/Method: Creating a New Class

A new class can be defined using the `setClass` function
- At a minimum you need to specify the name of the class
- You can also specify data elements that are called _slots_
- You can then define methods for the class with the `setMethod` function 
- Information about a class definition can be obtained with the `showClass` function

### S4 Class/Method: Polygon Class

Creating new classes/methods is usually not something done at the console; you likely want to save the code in a separate file

```{r polygon_1, tidy = FALSE}
library(methods)
setClass("polygon",
         representation(x = "numeric",
                        y = "numeric"))
```

- The slots for this class are `x` and `y`

- The slots for an S4 object can be accessed with the `@` operator.

### S4 Class/Method: Polygon Class

A plot method can be created with the `setMethod` function.

- For `setMethod` you need to specify a generic function (`plot`), and
  a _signature_.

- A signature is a character vector indicating the classes of objects
  that are accepted by the method.

- In this case, the `plot` method will take one type of object, a
  `polygon` object.

### S4 Class/Method: Polygon Class

Creating a `plot` method with `setMethod`.

```{r polygon_2, tidy = FALSE}
setMethod("plot", "polygon",
          function(x, y, ...) {
                  plot(x@x, x@y, type = "n", ...)
                  xp <- c(x@x, x@x[1])
                  yp <- c(x@y, x@y[1])
                  lines(xp, yp)
	  })
```

- Notice that the slots of the polygon (the x- and y-coordinates) are
  accessed with the `@` operator.

### S4 Class/Method: Polygon Class

After calling `setMethod` the new `plot` method will be added to the list of methods for `plot`.

```{r polygon_3}
library(methods)
showMethods("plot")
```

Notice that the signature for class `polygon` is listed. The method for `ANY` is the default method and it is what is called when now other signature matches

### S4 Class/Method: Polygon class

```{r polygon_4}
p <- new("polygon", x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)
```

### Summary

- Developing classes and associated methods is a powerful way to
  extend the functionality of R

- <b>Classes</b> define new data types

- <b>Methods</b> extend <b>generic functions</b> to specify the behavior
    of generic functions on new classes

- As new data types and concepts are created, classes/methods provide
  a way for you to develop an intuitive interface to those
  data/concepts for users

### Where to Look, Places to Start

- The best way to learn this stuff is to look at examples

- There are quite a few examples on CRAN which use S4
  classes/methods. You can usually tell if they use S4 classes/methods
  if the <b>methods</b> package is listed in the `Depends:` field

- Bioconductor (http://www.bioconductor.org) - a rich resource, even
  if you know nothing about bioinformatics

- Some packages on CRAN (as far as I know) - SparseM, gpclib, flexmix,
  its, lme4, orientlib, filehash

- The `stats4` package (comes with R) has a bunch of classes/methods
for doing maximum likelihood analysis.


## swirl (c9-)
### What is swirl? Part 1

- Swirl is an R package that turns the R console into an interactive learning
evironment.
- Students are guided through R programming exercises where they
can answer questions in the R console.
- There is no separation between where a student learns to use R, and where 
they go on to use R for thier own creative purposes. 

If you've never used swirl before you shoud try swirl out for yourself:

```r
install.packages("swirl")
library(swirl)
swirl()
```

### What is swirl? Part 2

- Anyone can create and distribute their own swirl course!
- Creating a swirl course can allow you scale R and data science education
within your company or school.
- If you're interested in getting involved in the open source education
community you can release your swirl course online and Team swirl will promote
it for you!
- There's a package called swirlify which is designed to help you write a swirl
course. We'll look into swirlify later.

### What is a swirl course?

- A swirl course is a directory that contains all of the files, folders, and 
lessons associated with the course you are developing. 
- Lessons contain most of the content that students interact with, and the 
course sequentially organizes these lessons.
- A course should conceptually encapsulate a broad concept that you want to 
teach. For example: “Plotting in R” or “Statistics for Engineers” are broad 
enough topics that they could be broken down further (into lessons which we’ll 
talk about next). 
- When a student start swirl, they will prompted to choose from a list of 
courses, and then they can choose a lesson within the course they selected. 
- Once the student selects a lesson, swirl will start asking the student 
questions in the R console.

### What is a lesson?

- A lesson is a directory that contains all of the files required to execute one
unit of instruction inside of swirl. 
- For example a "Plotting in R" course might contain the lessons: "Plotting 
with Base Graphics", "Plotting with Lattice", and "Plotting with ggplot2." 
- Every lesson must contain one `lesson.yaml`
file which structures the text that the student will see inside the R console
while they are using swirl. 
- The `lesson.yaml` file contains a sequence of questions that students will 
be prompted with.

### Writing swirl Courses: Setting up the App

First install swirlify:

```r
install.packages("swirlify")
library(swirlify)
```

Then set your working directory to wherever you want to create your course and
start the Shiny lesson authoring app:

```r
setwd(file.path("~", "Desktop"))
swirlify("Lesson 1", "My First Course")
```

### Writing swirl Courses: Using the App

For a demo about how to use the Shiny authoring app see the following video:
https://youtu.be/UPL_W-Umgjs

### Writing swirl Courses: Using the R Console

- Alternatively you can use the R console and a text editor to write swirl
lessons. 
- We highly recommend using
[RStudio](https://www.rstudio.com/products/rstudio/download/) 
for writing swirl lessons since RStudio provides this editor and console setup 
by default.

To start a new lesson from the R console set your working directory to where
you want to create the course, and then use the `new_lesson()` function to
create the course:

```r
setwd("/Users/sean/")
new_lesson("My First Lesson", "My First Course")
```

### Writing Lessons: Part 1

The `new_lesson()` function will create a file and folder structure like this
in your working directory:

```r
My_New_Course
- My_First_Lesson
    - lesson.yaml
    - initLesson.R
    - dependson.txt
    - customTests.R
```

### Writing Lessons: Part 2

To review, the `new_lesson()` function did the following:

1. A new directory was created in `/Users/sean/` called `My_New_Course`.
2. A new directory was created in `/Users/sean/My_New_Course` called `My_First_Lesson`.

### Writing Lessons: Part 2.5

- Several files were created inside of `/Users/sean/My_New_Course/My_First_Lesson`:
    - `lesson.yaml` is where you will write all of the questions for this lesson. ([Example](https://github.com/seankross/Test_Course/blob/master/Test_Lesson/lesson.yaml))
    - `initLesson.R` is an R script that is run before the lesson starts which is
    usually used to load data or set up environmental variables. ([Example](https://github.com/seankross/Test_Course/blob/master/Test_Lesson/initLesson.R))
    - `dependson.txt` is the list of R packages your lesson will require. swirl
    will install these packages if the user doesn't already have them installed. ([Example](https://github.com/seankross/Test_Course/blob/master/Test_Lesson/dependson.txt))
    - `customTests.R` is where you can write your own tests for student's answers.
([Example](https://github.com/seankross/Test_Course/blob/master/Test_Lesson/customTests.R))

### Writing Lessons: Part 3

If everything is set up correctly then `new_lesson()` should have opened up the
new `lesson.yaml` file in a text editor. You can now start adding questions to
the `lesson.yaml` by using functions that start with `wq_` (write question).

### Writing Lessons: Types of Questions

Lessons are sequences of questions that have the following general structure:

```
- Class: [type of question]
  Key1: [value1]
  Key2: [value2]
- Class: [type of question]
  Key1: [value1]
  Key2: [value2]
...
```

The example above shows the high-level structure for two questions.

### Writing Lessons: Types of Questions

- Each question is demarcated with a hyphen. 
- Every question starts with a `Class` that specifies that question's behavior
inside of swirl.
- What follows the class is a set of key-value pairs that will be used to render
the question when a student is using swirl.

### Writing Lessons: The Meta Question

The first question in every `lesson.yaml` is always the meta question which
contains general information about the course. Below is an example of the meta
question:

```
- Class: meta
  Course: My Course
  Lesson: My Lesson
  Author: Dr. Jennifer Bryan
  Type: Standard
  Organization: The University of British Columbia
  Version: 2.5
```
The meta question will not be displayed to a student. The only fields you should
modify are `Author` and `Organization` fields.

### Writing Lessons: Message Questions

Message questions display a string of text in the R console for the student to 
read. Once the student presses enter, swirl will move on to the next question.

Add a message question using `wq_message()`. 

Here's an example message question:

```
- Class: text
  Output: Welcome to my first swirl course!
```

The student will see the following in the R console:

```
| Welcome to my first swirl course!
...
```

### Writing Lessons: Command Questions

Command questions prompt the student to type an expression into the R console.

- The `CorrectAnswer` is entered into the console if the student uses the `skip()`
function. 
- The `Hint` is displayed to the student if they don't get the question right.
- The `AnswerTests` determine whether or not the student answered the question
correctly. See the answer testing section for more information.

Add a message question using `wq_command()`. 

### Writing Lessons: Command Questions

Here's an example command question:

```
- Class: cmd_question
  Output: Add 2 and 2 together using the addition operator.
  CorrectAnswer: 2 + 2
  AnswerTests: omnitest(correctExpr='2 + 2')
  Hint: Just type 2 + 2.
```

The student will see the following in the R console:

```
| Add 2 and 2 together using the addition operator.
>
```

### Multiple Choice Questions

Multiple choice questions present a selection of options to the student. These
options are presented in a different order every time the question is seen.

- The `AnswerChoices` should be a semicolon separated string of choices that
the student will have to choose from.

Add a message question using `wq_multiple()`. 

Here's an example multiple choice question:

```
- Class: mult_question
  Output: What is the capital of Canada?
  AnswerChoices: Toronto;Montreal;Ottawa;Vancouver
  CorrectAnswer: Ottawa
  AnswerTests: omnitest(correctVal='Ottawa')
  Hint: This city contains the Rideau Canal.
```

### Multiple Choice Questions

The student will see the following in the R console:

```
| What is the capital of Canada?
1: Toronto
2: Montreal
3: Ottawa
4: Vancouver
```

### Other Question Types

For complete documentation about writing swirl courses and lessons see the
swirlify website: http://swirlstats.com/swirlify/

### Organizing Lessons: Part 1

Let's revisit the general structure of a swirl course. This is the structure of
a course with two lessons:

```
My_New_Course
- My_First_Lesson
  - lesson.yaml
  - initLesson.R
  - dependson.txt
  - customTests.R
- My_Second_Lesson
  - lesson.yaml
  - initLesson.R
  - dependson.txt
  - customTests.R
```

### Organizing Lessons: Part 2

- By default each folder in `My_New_Course` will be displayed to the student 
as a lesson they can select. 
- If you want to explicitly specify the order in which lessons are displayed 
you will need to add a `MANIFEST` file to your course.
- You can do this with the `add_to_manifest()` function, which will add 
the lesson you are currently working on to the `MANIFEST`. You can also edit
the `MANIFEST` yourself in a text editor.

### Organizing Lessons: Part 3

The (abridged) `MANIFEST` file below belongs to Team swirl's
R Programming course:

```
Basic_Building_Blocks
Workspace_and_Files
Sequences_of_Numbers
Vectors
Missing_Values
Subsetting_Vectors
Matrices_and_Data_Frames
```

### Sharing Your Course

Swirlify makes sharing a swirl course easy. We recommend three different methods
for sharing a swirl course.

### Sharing Your Course as a File

We've developed the `.swc` file type so that you can share your course as a
single file. Creating an `.swc` file for your course is easy:

1. Set any lesson in the course you want to share as the current lesson using
`set_lesson()`.
2. Create an `.swc` file using the `pack_course()` function. Your `.swc` file
will appear in the same directory as the directory that contains the course
folder. You also have the option to export the `.swc` file to another directory
by specifying the `export_path` argument.

### Sharing Your Course as a File

- You can now share your `.swc` file like you would any other file (through email, file sharing services, etc). 
- Students can install your course from the `.swc` file by downloading the 
file and then using the `install_course()` function in swirl, which will 
prompt them to interactively select the file they downloaded.

### Sharing Your Course on GitHub

- We highly encourage you to develop your course on 
[GitHub](https://github.com/) so that we can better support you if you 
have questions or need assistance while developing your course.
- Developing your course on GitHub provides the added
benefit that your course will be instantly ready to distribute.
- Students can install your course from swirl using the `install_course_github()` function.
- Make sure that your course directory is the root folder of your 
git repository. For examples of courses that have been shared on GitHub 
you can browse some of the courses on 
the [Swirl Course Network](http://swirlstats.com/scn/).

### Sharing Your Course on The Swirl Course Network

The goal of the Swirl Course Network is to list and organize all publicly
available swirl courses. Visit the [homepage](http://swirlstats.com/scn/) of the
SCN for more information.

After adding your course to the SCN students will be able to install your course
using `install_course("[Name of Your Course]")` in swirl.

### Sharing Your Course on The Swirl Course Network

In order to add your course to the SCN:

1. Create an `.swc` file for your course.
2. Fork https://github.com/swirldev/scn on GitHub.
3. Add the `.swc` file to your fork.
4. Add an Rmd file to your fork like 
[this one](https://raw.githubusercontent.com/swirldev/scn/gh-pages/rprog.Rmd).
You can include a description of your course, authors, a course website, and
how to install your course.
5. Run `rmarkdown::render_site()` when your current directory is set to your
fork.
6. Add, commit, and push your changes to GitHub, then send us a Pull Request.

### More Help & Resources

- [The swirl Website](http://swirlstats.com/)
- [The swirlify Documentation](http://swirlstats.com/swirlify/)
- [The swirl Course Network](http://swirlstats.com/scn/)

Feel free to get in touch with Team swirl:

- Via email: info@swirlstats.com
- On Twitter: @[swirlstats](https://twitter.com/swirlstats)

