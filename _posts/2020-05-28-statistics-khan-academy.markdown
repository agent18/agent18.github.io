## Statistics and probability

[link](https://www.khanacademy.org/math/statistics-probability)

**Goal**: get to annova chi, t statistic and hypothesis testing... Do
one question in each and understand how to do them...

Will be useful while doing linear regression...


linear regression classification and linear regression float.



## Central limit theoram

Any distribution ++ sample size tending to inf ++ function (mean sum
anything), then you get close normal dist...

## Sampling distribution of the sample mean

We care about this as it gives the mean of the actual
distribution. Example [here](https://www.khanacademy.org/math/statistics-probability/sampling-distributions-library/sample-means/v/sampling-distribution-of-the-sample-mean?modal=1).

1. n==5 vs n==10 (Lesser kurtosis closer to 0 and skew closer to 0)

Kurtosis--> how pointy or non pointy it is from the normal (it's
almost always a negative kurtosis)

skew --> whether the mean moves away from the actual mean in what
direction (right is negative)


2. Variance of sampling distribution of sampling mean `\sigma.\bar{x}
   == \sigma.mu /sqrt(n)`

**Standard deviation of sampling distribution (of the sample mean) is called Standard error
of the mean**


## SDSM

- Sampling distribution of sampling mean
- Sampling distribution of sampling proportion

SD of SDSP == sqrt(p(1-p)/n)

SE of SDSP == sqrt(phat(1-phat)/n)

Margin of error == 2 SDs of SDSP


## What does CI of 95% mean

You start with a sampling proportion of `phat` and an True proportion
of `p`. You determine the SE based on phat (SE of SDSP formula
above). SE is assumed to be an estimate of the SD of the SDSP.

So what we have then is a sample proportion and an SE. There is a 95%
chance that the sample proportion is within the tru proportion +- 2SE
(95% in normal dist). This is the same as the tru proportion being
within +-2SE of the sample proportion.

Also another way of seeing it is, out of 100 sample proportions 95 of
them will contain the true proportion.

## t statistic

Usually we have :

	\bar{x} +- Z * SE/sqrt(n)
	
Z is based on an actual normal distribution. 

	\bar{x} +- t * SE/sqrt(n)

The above gives 95% confidence when we say 95% confidence.


**Why we need Z statistic**

[Explanation here](https://youtu.be/gLE6y_NwmhQ)...

**But because we use SE we can't use Z anymore.** It's SE which is the
problem as shown below.

So basically 

1. Z + actual sigma --> 95% confidence band spots the mean 95% of the
   times
   
2. Z + SE --> 92%

3. T + SE --> 95% again.

### Code

``` python
import scipy.stats as st
import matplotlib.pyplot as plt

pop = np.random.normal(0,1,1000)
plt.hist(pop);
x = np.linspace(pop.max(),pop.min(),10000)
plt.plot(x,st.norm.pdf(x));
st.norm.cdf(1.96) ## out --> 97.5% of the cumilative dater
st.norm.ppf(st.norm.cdf(1.96)) ## out --> 1.96 is the Z score for
#cumilative percentage
```

ppf and cdf are based on cumilative values

### Conditions for using CI (check it out more thoroughly)

1. Random sample
2. Normal distribution of the sample 

This is that you have >=10 items in successes and failures.

In the [t-statistic conditions video](https://youtu.be/WPxnNjD_yoU) when someone did an SRS of 20
to determine a statistic (mean of age) then the teacher says it is not
enough as we need an n>=30. "If n>=30, then the sampling distribution
will approximately be normal".


- So basically n>=30 helps the sample be normal
- if distribution is already normal then ...
- if the sample is symmetric

3. Independence condition

It's preferred if you sample with replacement but that might not be
always possible (e.g., people going out of store). But n<10% of entire
sample  will help uphold the independence condition.

## Hypothesis testing


It's about inference to the population.

H0: average liquid dispensed = 530ml
Ha: average liquid dispensed >530ml

And find P(mean of sample| H0 is true). What are the chances of
getting H0 is true given the mean of the sample.

### Type 1 and type 2 era


|                   | H0 True | H0 False |
|-------------------|---------|----------|
| reject H0         | Type I  | Correct  |
| Fail to reject H0 | Correct | Type II  |


### probability of making a type II error (later)

[This lecture](https://youtu.be/6_Cuz0QqRWc)


### Definitive example

https://youtu.be/-FtlH4svqx4

Could write a blog post on it...


### Z vs T

`n>30` Z, otherwise T (6:20 [here](https://youtu.be/5ABpqVSx33I))

### difference of means example

https://youtu.be/hxZ6uooEJOk


## Chi square

Used for goodness of fit as shown [here](https://youtu.be/2QeDRsxSF9M), in this example.

Let X1 be a random pick from a normal std distribution.

`Q1 = X1^^2` **Chi squared variable**

`Q2 = X1^^2 + X2^^2` **Chi squared variable** ...

And then we have distributions of Q1 and Q2. 1, 2 standing for `dofs+1`.

Chi Squared plot is just another PDF. Which we can look up.

### Example:

A restaurant says this is their weekly distribution

|                 | M     | T    | W     | T   | F   |
|-----------------|-------|------|-------|-----|-----|
| Expected        | 30    | 14   | 50    | 20  | 40  |
| Actual          | 10    | 20   | 30    | 40  | 50  |
| Difference      | 20    | 6    | 20    | 20  | 10  |
| Normalized diff | 20/30 | 6/14 | 20/50 | ... | ... |

	


So the above has 4 Dofs. We take the difference and work look up the
Chi^^2 distribution for a given dof. 

To know if the Difference is "significant", we look at the Chi^^2
value of difference and see how likely is it to appear in the Chi^^2
PDF for dof=4. 

BTW we need to normalize the difference

DOF == 5-1 = 4

## Linear Regression and CI around the fitted line

### conditions 

LINER --> Linear, Independent, normal, equal variance, Random

**I really need to understand how the SE of slope and SE of constants
come about**

**What is correlation and covariance etc...**

## Anova (Analysis of Variance) with F-statistic

[Ling](https://youtu.be/Xg8_iSkJpAE) 

Similar to regular HT, we compute some parameter and then check
against a PDF. Here we use F-statistic. But to get there let's take an
example.

|         | food 1 | food 2 | food 3 |
|---------|--------|--------|--------|
| Person1 | 3      | 5      | 5      |
| Person2 | 2      | 3      | 6      |
| Person3 | 1      | 4      | 7      |
| Mean    | 2      | 4      | 6      |

\bar{X} = 4

SST--> Sum of Squares Total
SSB--> Sum of Squares Between different Foods
SSW--> Sum of Squares within each food

SST == (3-4)^^2 + (5-4)^^2 .... DOF=8
	== 30

SSB == 3\*(2-4)^^2 +3\*(4-4)^^2 .... DOF=2
	== 24

SSW == (3-2)^^2 + (2-2)^^2 .... DOF ==6
	== 6
	
	
SSB + SSW == SST

SSB DOF + SSW DOF == SST DOF


H0: Food doesn't make a difference

H1: It does

`F_stat = SSB/dof_ssb / (SSW/dof_ssw)`

In this case Fstat = 24/2 /(6/6)

There is more variation across foods than within persons.

If F_stat is really big then there seems to be a high chance that H0
is false.

And then we look it up on the F_stat chart for alpha=5% or something...

## Linear Regression (Statquest)

1. fit line based on sum of squared residuals minimization

2. Calculate R^^2 --> explains variation around the mean is
   explained by the line. SS--> Sum of squares.
	
    (SS(mean)- SS(fit))/ SS(mean) = R^^2 

3. Calculate P-value for R^^2 to determine if this value is randomly
   possible (for example with 2 points you get R^^2=100%)


LS fits a line for 1 dimension and a plane for 2 dimensions and so on
for n-dimensions.

weight of mouse = 0.1 + height of mouse + flip a coin

- Random events could reduce sum of squares fit, and increase R^^2 (what
we want but not through random events). ([Here](https://youtu.be/nk2CQITm_eo?t=956))

- But if it is a random parameter like size of hair or astrology sign,
  those that will create nno change to your sum of squares, will
  automatically be eliminated

### Multiple regression
## Permutation 



