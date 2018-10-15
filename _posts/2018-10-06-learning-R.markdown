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
		

