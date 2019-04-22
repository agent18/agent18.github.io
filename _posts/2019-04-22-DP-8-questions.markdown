---
layout: post
comments: true
title:  "DP questions #8"
date:    22-04-2019 
categories: posts
tags: DP, feedback, examples, claims
permalink: /:title.html
published: true
---

## Planning

It took 35 hrs of total work with 25.5 hrs of DP for 200 phrases in
the last essay "DP-claims"

Monday 6 hrs, Tues, 3.5 hrs, Wed: 3 hrs, Thu: 3.5 hrs, Fri: 3.5 Sat 8
hrs, Sun 8hrs.


If I want to do 1 hr of DS everyday at the end of the day, then I need
7 more hrs. 

Let's try it. If I do 7 hrs of DS then I am allowed a Tuesday
deadline! Otherwise Sunday deadline! Get it!


Fine! Let's roll with it!

## Sources

Statistics -p value, confidence intervals, linear regression,
residuals, distributions, bayes stuff!

Continue the dynamics one?

MSD- not sure... actuators, PID control?? there will be a lot that I
don't know.

less wrong stuff?

PG stuff?

Summary from my career guide?

What am I confused about?

What to do in life, 

What about work document PIR?
What about the intertia document!

How to get persuaded articel STM

80000 hours! AI, datascience

	
## Star mark feedback of the previous post


- Notice what is wrong! Don't blindly try to give examples

	Stick your head out and say, bla bla bla is wrong! either your
    example is wrong or there is something amiss! 
	
	
	To drive home the point, *what do I mean by an independent test*
	of a claim? It's like removing their proposed answer from the
	claim and filling the blank yourself. "Most people reach their
	peak in their middle age" becomes "most people reach their peak in
	____". Now, you go look at most people and check when they reach
	their peak and you fill in the blank yourself. Then, you compare
	the two answers. If they don't match, either the claim is wrong or
	your example or reasoning is faulty. Either way you get the
	valuable information that something is amiss. Otherwise, if you
	just read it as "most people reach their peak in middle age", you
	won't *notice if something is wrong*.
	
	
- one vs many valid examples

	What examples could you have come up with for improving over decades?
	Sachin. Rahman. Dhoni. Mani Ratnam? Superstar? Harris Jayaraj?! Note
	that a counter-example doesn't falsify the claim because it says you
	can improve, not you will improve over decades. So, you just need one
	valid example.

## consolidation of feedback

How do you know if you have given the right example? how do you know
if you are vague?


## Mission #8

Mission #8: Your mission, should you choose to accept it, is to
identify the question and answer in each claim, come up with an
example for the question, fill-in-the-blank for the answer yourself,
and compare to the claimed answer.

For example,

> On one hand, the presence of reaction forces acting in the direction
> of the constraint generally renders the equilibrium description more
> complex, since those unknown forces must be determined along the
> entire trajectory such that kinematical constraints are satisfied.

becomes

> On one hand, the presence of reaction forces acting in the direction
> of the constraint generally renders the equilibrium description
> ____, since those unknown forces must be determined along the entire
> trajectory such that kinematical constraints are satisfied.

**Until you can fill in the blank yourself, you don't really
"understand" the statement.**

**(You can ignore "because" statements for now.)**

Take on passages that you are confused about. That way, you will know
that the technique worked because things will be clear
afterwards. What do you want to "think critically" about?

> Please do let me know when you are back. Good luck to you. As always
> please don't give up on me.

I can't give up on people who put in the hard work. "Sometimes people
deserve to have their faith rewarded."
## My plan

- Identify claims and questions to be answered

- then pin point examples

- then confirm their status

##  multiple variables regression


> * **Omitting variables results in bias** in the coeficients of
>   interest - unless their regressors are uncorrelated with the omitted
>   ones.
>   * **This is why we randomize treatments, it attempts to uncorrelate
>     our treatment indicator with variables that we don't have to put
>     in the model.** **WE need to make out own example for this one!
>     during writing** Thats why AB testing and clinical trials are so
>     powerful. but if there are too many confounding things then even
>     randomization is not going to help you!
> 	
>   * (If there's too many unobserved confounding variables, even
>     randomization won't help you.)
> * **Including variables that we shouldn't have increases standard errors
>   of the regression variables.** No BIAS!!!!!!
>   * Actually, including any **new variables increasese** (actual, not
>     estimated) **standard errors** of other regressors. So we don't
>     want to idly throw variables into the model.
> * The model must tend toward perfect fit as the number of
>   non-redundant regressors approaches $n$.
> * **$R^2$ increases monotonically as more regressors are included.**
> * The SSE decreases monotonically as more regressors are included.

**C&Q**

> (Omitting variables)[a] results in (bias in the coefficients of
> interest)[B] - unless (their regressors are uncorrelated with the omitted
> ones)[C].

**Claim**: [A] results in [B] unless [C]

**Question**: [A] results in ____ unless [C]

> (Omitting variables)[1]

Let's take the following data as an example:

	n=10000
	x1=rnorm(n); x2=1*x1 + rnorm(n); 

We know ahead of time actually `y=x1+x2`. The goal with linear
regression is to find the coefficient of x1 when only the data is
available and the relationship is not known.

For 1, we think of omitting x2. Instead of `lm(y~x1+x2)`, we
do `lm(y~x1)`, to determine the coefficient of x1.

> results in (bias)[2] in the (coefficients of interest)[3]

For 3, we think of the ratio of coefficient of x1 with and without x2,
being `$>1$` i.e, `$2.01/1.00 = 2$`


```
lm(y~x1)    # not including x2 in the model
          x1 
  2.01945683 
lm(y~x1+x2) # includeing x1 and x2 in the model      
	      x1          x2 
   1.0074283   1.0104000
```

> unless their (regressors)[4] are (uncorrelated)[5] with the (omitted
> ones)[6]

In the above case the regressors (x1) show a correlation of 0.7 with
the omitted regressor (x2).

If the regressors are uncorrelated (x1=rnorm(n), x2=rnorm(n)) i.e., x1
and x2 show a correlation of 0.02. In this case [A] results in NO [B].

```
	      x1 
  0.97783187 
 
          x1          x2 
  1.00455357  0.99684880
```

	
*I am not sure if I should show correalated or uncorrealated variables
or both! Nam sayin!!! Because of [C] I think I need to give example of
uncorrealated, because of [B], I need give example of correlation*

*I also see that I put quite some effort into explaining the
individual words, I will reduce it, if I need to do like a 100 serious
phrases. I will try and skip as adviced if things are "pretty
obvious", if not I will write out in english as done above in the last
case to identify the labels for a reader.*

*Felt quite good having fucking explained this in over 90 mins! JFC!
But nevertheless! Solidified Pandian, Pan Indian!*

**C&Q**

> (This is why we randomize treatments)[A], it attempts to uncorrelate our
> treatment indicator with variables that we don't have to put in
> the model.












> **WE need to make out own example for this one!
>     during writing** Thats why AB testing and clinical trials are so
>     powerful. but if there are too many confounding things then even
>     randomization is not going to help you!
> 	
>   * (If there's too many unobserved confounding variables, even
>     randomization won't help you.)
> * **Including variables that we shouldn't have increases standard errors
>   of the regression variables.** No BIAS!!!!!!
>   * Actually, including any **new variables increasese** (actual, not
>     estimated) **standard errors** of other regressors. So we don't
>     want to idly throw variables into the model.
> * The model must tend toward perfect fit as the number of
>   non-redundant regressors approaches $n$.
> * **$R^2$ increases monotonically as more regressors are included.**
> * The SSE decreases monotonically as more regressors are included.


## work

Day 1: Spent time at home went to sleep masturbated even. 

I am afraid these are typical things I feel at home! the opportunity
and ease of giving up! Anyways having decided to start at the library
at 7:15, I seem to be much better grinding. 1.5 hrs flew by. Of course
I need to check how I am working at the hotel, cause not everything is
the same. I am on a **misson** now. want to compare mission periods.

But I am liking the library feel again!

Also my worry is about weekedns where I barely fucking perform work!
JFC! less than 4 hrs! omg!


Day 2: 

