---
layout: post
comments: true
title:  "DP Questions with Claims #8"
date:    22-04-2019 
categories: posts
tags: DP, feedback, examples, claims
permalink: /:title.html
published: true
---

## Important feedback of the previous post

- Notice what is wrong! Don't blindly try to give examples

    > To drive home the point, *what do I mean by an independent test*
    > 	of a claim? It's like removing their proposed answer from the
    > 	claim and filling the blank yourself. "Most people reach their
    > 	peak in their middle age" becomes "most people reach their
    > 	peak in ____". Now, you go look at most people and check when
    > 	they reach their peak and you fill in the blank
    > 	yourself. Then, you compare the two answers. If they don't
    > 	match, either the claim is wrong or your example or reasoning
    > 	is faulty. Either way you get the valuable information that
    > 	something is amiss. Otherwise, if you just read it as "most
    > 	people reach their peak in middle age", you won't *notice if
    > 	something is wrong*.
	
	
- one vs many valid examples

    > What examples could you have come up with for improving over
    > 	decades?  Sachin. Rahman. Dhoni. Mani Ratnam? Superstar?
    > 	Harris Jayaraj?! Note that a counter-example doesn't falsify
    > 	the claim because it says you can improve, not you will
    > 	improve over decades. So, you just need one valid example.

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

## Multiple variable regression (8)

**Source:** Part of the Regression covered [here](https://github.com/bcaffo/courses/tree/master/07_RegressionModels)

---
**C&Q**:  

> (Omitting variables)[A] results in (bias in the coefficients of
> interest)[B] - unless (their regressors are uncorrelated with the omitted
> ones)[C].

**Claim**: [A] results in [B] if [C] is false.

**Question**: [A] results in ____ if [C] is false

**Example**: 

Let's take the following data as an example:

	n = 10000
	x1 = rnorm(n); x2 = 1 * x1 + rnorm(n); 

Let `y=x1+x2`. The goal with linear regression (`lm`) is to find the
coefficient of x1; given y, x2 and x2 data.

For A, we think of omitting x2. Instead of `lm(y~x1+x2)`, we
do `lm(y~x1)`, to determine the coefficient of x1.

For B: The actual slope of x1 is 1 (`y=x1+x2`), but when you omit x2,
you get a higher value for the slope of x2 (2.019), i.e., BIAS.

```
lm(y~x1)    # not including x2 in the model
          x1 
  2.01945683 
lm(y~x1+x2) # including x1 and x2 in the model      
	      x1          x2 
   1.0074283   1.0104000
```

> [C]-->  unless their (regressors)[4] are (uncorrelated)[5] with the (omitted
> ones)[6]

In the above case the regressors (x1) show a correlation of 0.7 with
the omitted regressor (x2).

If the regressors are uncorrelated (`x1=rnorm(n), x2=rnorm(n)`)
i.e., x1 and x2 show a correlation of 0.02, then case [A] results in
NO [B] as [C] is True. As observed below there is no bias as the
coefficients when including and excluding x2 is the same.


```
lm(y~x1)    # not including x2 in the model
	      x1 
  0.97783187 
  
lm(y~x1+x2) # including x1 and x2 in the model 
          x1          x2 
  1.00455357  0.99684880
```

---
**C&Q**:  

> (This)[A] is why we (randomize treatments)[B], (it)[B] attempts to
> (uncorrelate)[C] our (treatment indicator with variables that we don't
> have to put in the model)[D].

**Claims**: (Avoiding Biases in the coefficients of the regressor)[A] is
  why we do [B]

**Question**: When we do [B], we end up with ____

**Example**: * I tried creating a population with 2 correlated
variables (introducing bias). I then randomly selected 100 of
them. There still was bias (there was still correlation).* 

*I guess I don't understand what it means to randomize treatments or
of course the claim is wrong.*

## Career Research - Analysis (23)

**Source:** From the [Summary I wrote for my career analysis](/Summary-before-applying-to-80k.html).

---
**C&Q**:    

> (An excel sheet)[1] has been created pooling in all the (data
> computed above)[2] of (more than a dozen career options to choose
> from)[3].

**Claim**: [1] has been created with [2] consisting of [3]

**Question**: [1] has been created with ____ consisting of [3].

**Example**: 

In the [excel sheet](https://docs.google.com/spreadsheets/d/1uclRbujg4o9DTXxjVmwKU7-_lhe8AwQ7rQdIl3LhLzQ/edit#gid=1691161657), we look in the 'personal fit' tab. 'Entering
DS from DE' is chanced at 95%. This is the exact number found [in the
essay](/Summary-before-applying-to-80k.html) under 'Data Science' section, within the 'personal fit'
subsection. This excel sheet contains data for Management Consulting,
Software Engineering, Economics PhD and many more.

*I am sticking to one running example per claim or per chosen
sentence. It is hard to focus on the whole paragraph at once and find
one example that will fit all. Only when I go to the next sentence I
know what I am missing, so I need a new example.*

---
**C&Q**:    

> (Similar data)[1] is also available within the
> (80k-hours-career-guide)[2], but that does not allow (as much
> detail)[3] in comparison.

**Claim** [1] is also available at [2] but not with [3]

**Question**: [1] is also available at ____ but not with [3]


If you look at the [excel sheet](https://docs.google.com/spreadsheets/d/1uclRbujg4o9DTXxjVmwKU7-_lhe8AwQ7rQdIl3LhLzQ/edit#gid=1691161657), you will see that there are
options for number of lives saved if I move to the US, or if I stay in
Netherlands. Such detail is not available in the
80k-hours-career-guide.

<!-- > For example, (I don’t care if I ETG or do DW)[]. (I care about total -->
<!-- > impact (IT))[], i.e., (number of lives saved)[]. So (I want to be -->
<!-- > able to get data)[] on (total impact)[] and not (individual impact -->
<!-- > of DW or ETG or advocacy)[], as is (available on -->
<!-- > 80k-hours-guide)[]. In addition to the above, (I have made -->
<!-- > subdivisions within careers)[] for which (80k hours does not have -->
<!-- > the data I need)[]. For example, (MC)[] is split into (MC for ETG)[] -->
<!-- > and (MC for DW)[]. (This allows me to see)[] which (career -->
<!-- > direction)[] has what type of (total impact)[]. -->


<!-- I think just the above are examples. So I remove them and focus on -->
<!-- more of the real stuff! -->

---
**C&Q**:    

> (Support conditions)[1] wise (IB and the like)[2], (seems like a
> reject)[3]. 

**Claims**: Considering [1], [2] is to be rejected.

**Question**: Considering [1], [2] is to be ____

**Example**: 

For 1, we think of abnormal working hours (80 hrs/week) and working 28
days a month, continuously.

For 2, we think of Investment Banking, Trading.

For 3, I think of not taking up jobs in IB due to the fear of burning out?

*How do you test "seems like"? how do you test "opinions?" At this
point it's more like personal choice, I am not even sure an example
can be given*
 
---
**C&Q**:     
> I am (quite afraid)[4] of the (extremely long hours)[5],
> (the need to facetime)[6], the (lack of attention to health)[7] etc…

**Claims:** IB has [5]

**Question:** IB has ____ hours for work/week?

**Example:** IBer's work from [70 to 100 hrs per week](http://www.askivy.net/articles/investment-banking/investment-banking-lifestyle/working-hours-in-investment-banking), this means
10 to 14 hrs for 7 days a week.

**Claims:** IB forces you into [6]

**Question:** IB ____ facetime

**Example**: "My group is ~15 people. I have to be at my desk all the
time. If my associates / VPs call me the first thing they ask is "are
you in the office" even if it is a weekend. They call me in on
weekends when they are there just in case work comes up they want me
to be accessible. I can never leave before anyone more senior that me
or I get a staffing email the next day because they assume I am not
working on anything / I am not busy." --- [wallstreet oasis forum](https://www.wallstreetoasis.com/forums/facetime).

**Claims:** IB results in [7]

**Question:** IB results in ____ to health

**Example** "Constant heart palpitations due to caffeine/energy
drinks/stress Carpal tunnel / tendinitis. Lost a lot of hair. Put on 25
lbs or more (fat, not muscle). Stress lowered my immune response to the
point that I got a serious infection that landed me in the hospital
(it started out small but spread to my veins). Became borderline
alcoholic (was having 4-5 drinks every day after work, sometimes
before work although not that often)", within 3 years of working in
IB. --- testimony of an IBer on [wallstreet oasis forum](https://www.wallstreetoasis.com/forums/how-much-damage-has-banking-done-to-your-life)

For [7], we think of stress eating junk food or avoiding food
altogether to meet deadlines, and the inability to do cardio 5 times a
week.

**Claim**: I am (quite afraid)[8] to work in IB due to the "lack of
supporting conditions"

**Question**: I am ___ to work in IB...

*Not sure how to test when someone is afraid or does not want to do
something because of X! Oh wait, there is a 'because'!*

---
**C&Q**:    
> (I might be able to do it)[1] for (a few years)[2], but not for
> (long)[3]. 

**Claim**: Might be able to work in IB for \< 2-5 years

**Question**:  Have you worked in "similar conditions to IB" for 2-5
years, in the past?

**Example:** During my IIT days, I regularly worked 6-7 days for \>10
hrs easily. I had "quite some stress", due to making mistakes in work,
or not being good enough and trying to show that I am much better than
I actually am. I slept at weird times and was always at work until 8 pm
or even more. This happened for about 1-1.5 years.

<!-- During my Master's, I worked every single day for more than 10hrs for -->
<!-- 12 months straight, including most weekends. -->

<!-- Nowadays, I do a 40 hr workweek and for the past couple of weeks have -->
<!-- been averaging 65 to 75 hrs work weeks although I don't hate working -->
<!-- like previous examples, and don't have a crazy boss. -->

For "similar conditions to IB", I think of 70-100 hrs a week, not
being able to do cardio every day, the need to facetime.

**Claim**: I might not be able to work for long at IB

**Question**: Have there been others who have not been able to work
for 15 years?

**Example:** This guy moved to Private Equity within 3 years of
working in IB because of poor "support conditions" mentioned
above. --- [wallstreet oasis forum](https://www.wallstreetoasis.com/forums/how-much-damage-has-banking-done-to-your-life)

**Corollary Question:** Have there been others who have been able to work for
more than 15 years?

*I guess I don't have to answer the above question as main claim
doesn't say "I **will never** be able to work for \<15 years in IB."*

---
**C&Q**:  

> (IB)[A] doesn’t make sense unless it is going to be done for the
> next (10-15 years)[B], as it takes (so much time)[C] to reach
> (millions)[D].

**Claims**: [A] for \< [B], is not the best option, ~~because it takes
[C] to reach [D]~~

**Question**: [A] for ___, is not the best option 

*We skip the because part!*

**Example**: Within 15 years you are able to save only \~[900
lives](https://docs.google.com/spreadsheets/d/1uclRbujg4o9DTXxjVmwKU7-_lhe8AwQ7rQdIl3LhLzQ/edit#gid=307272509) (based on [this](http://www.careers-in-finance.com/ibsal.htm)); not including the "personal fit"",
which will probably bring the value down "further". With joining an
EAO like GiveWell it seems like you can make a contribution of [97k$
per year](https://80000hours.org/2016/08/reflections-from-a-givewell-employee/) by working there. This seems to allow for \>1000 lives
over a 40 year career.

**Claim**: [A] for \> [B] seems like one of the best options
considering impact alone (not including personal fit).

**Question**: [A] for \> ____ seems like one of the best options for
impact(not including personal fit).

**Example**: Over a 30 year career if a person earns on average 800k$
(roughly based on [here](http://www.careers-in-finance.com/ibsal.htm)) you could save ~3100 lives (\>\> 1000 lives
at an EAO).

---
**C&Q**:    
> I’d rather try to get into (MC)[1], which doesn’t seem like an
> option where I would (necessarily burn out)[2]. I conclude that MC
> \> (IB)[3].

**Claim**: MC doesn't seem to result in burn out. There fore MC > IB.

**Question**: MC doesn't seem to result in [2]. Therefore [1] ____ [3]

**Example:** According to [this quora answer](https://www.quora.com/What-are-the-hours-like-at-management-consulting-firms) of someone from
McKinsey, average work hours is 60. With IB it is 70 to 100 hrs of
work.

For burnout, we think of not being able to do cardio for 20 mins 5
times a week, \>70 hrs work weeks, "monotonous work".

*I am not sure identifying this question is helping in anyway. I
look at the claim and remove some word and there I have the
question. Identifying the claim seems to be most important as I try to
find example looking at it.*

## Mechanics (40)

**Source:** Mechanical Vibrations by Daniel Rixen

---
**C&Q**:    
> On the other hand, solving the (equilibrium equations)[1] in the
> (direction constrained by the kinematical conditions)[2] is not
> useful since, (in that direction, the trajectory is prescribed by
> the constraint and thus known)[3].

**Claims**: Solving [1] along [2], is not useful because [3]

**Question**: Solving [1] along ____ is not useful ...

For [1] along [2], we think of  the following equation along the
pendulum bar.

`$T = mg \sin{\theta}$`

For [3], we think of the constant distance of R in the direction of
the bar of the pendulum which NEVER changes.

**Example**: In Pg 22 of the book, there is no discussion or usage of
the `$T = mg \sin{\theta}$` for the determination of the equation of
motion equation `$ml^2 \ddot{\theta} + mgl \sin{\theta}=0$`. Hence not
useful.

---
**C&Q**:  

> In the (system described in Figure 1.2)[1] (below) only the (motion along
> the direction tangent to the curve)[2] needs to be determined. 

**Claims**: In [1], only [2] needs to be determined.

**Questions**: In [1] only ____ needs to be determined

**Example**: In [1], the pendulum can only move along the spherical
surface. That is the only motion to be determined. There is no motion
along the direction of the radius of the pendulum and hence it doesn't
need to be determined.

For 1, we think of this image from the text book

![sph-pendulum](./images/images-DP-3/sph-pendulum.png)

For 2, we think of the motion along the spherical surface

---
**C&Q**:    

> (In doing so)[1], (the reaction forces, which act in the direction
> normal to the curve)[2], do not participate to the (motion)[3] and
> thus need not be determined: 

**Claims**: [2] is not needed for [3] because of [1]

**Question**: [2] is ____ for [3]...

**Example**: On pg 22 of the book, we see the derivation for the
equations of motion of a simple pendulum. We notice the complete
absence of this reaction force (tension force), in the final equation
(as well as the entire derivation).

![derivation pendulom](./images/images-DP-3/derivation-pendulum.png)

For [1], we think of the system described above, where the motion is
only along the spherical surface is determined

For [2], The tension forces along the bar of the pendulum.

For [3], we think of the equations of motion (1-dimension)

`$ml^2 \ddot{\theta} + mgl \sin{\theta}=0$`

---
**C&Q**:    
> the (position of the particle in the direction normal to the
> curve)[4] is obviously imposed by the (constraint)[5] and does not
> require solving the (equilibrium equation in that direction)[6].

**Claims:** [4] is known because of [5]
 
*Because statement*

**Claims**: [4] does not require solving [6]

**Questions**: [4] does ____ solving [6]

**Examples**: The position of the particle normal to the parabola
(along the bar of the pendulum), is always going to be the length of
the pendulum. At 30 degrees the position is the length of the
pendulum, at 90 degrees the position along the normal to the parabola
of the pendulum path, is L. It does not require solving of ANYTHING as
a result!

---
**C&Q**:    
> Let us therefore decide that, in the presence of (kinematical
> constraints)[1], we consider only (virtual displacements)[2a] δui
> (VD) (compatible with the constraints)[2] or, in other words,
> (kinematically admissible)[3].

**Claims**: When [1] is present, we consider [2a] only along [2].

**Question**: When [1] is present, we consider [2a] only along ____.

**Example**: On Pg 22, we see that the simple pendulum, has a
constraint of staying on a circle (via the bar of length L). 

`$u_{1} = L \cos{\theta}$`
`$u_{1} = L \sin{\theta}$`

The coefficients extracted are:

`$\delta u_1 = -l \sin{\theta} \delta \theta$`
`$\delta u_2 =  l \cos{\theta} \delta \theta$` 

When you divide the coefficients Y by X, you get `$-\tan(\theta)$`,
which is nothing but the slope of the circle traced by the
pendulum for the current coordinate system, u1 facing down and u2
facing to the right. This shows that the virtual displacements are
along [2].

**Claims**: [2] is [3].

*To me this looks like just a definition, So I skip!*

---
**C&Q**:    

> (`$\sum^{3}_{i=1}(m\ddot{ui}-X_i)\delta u_i = 0$`)[4] then describes
> the projection of the (dynamic equilibrium)[4a] in the (space
> compatible with the constraints)[5], namely in directions
> (orthogonal to unknown reaction forces)[6]. The (form (1.5))[7] thus
> involves only (effectively applied forces)[8] and stipulates that.
	
**Claims**: [4] describes projection of [4a] on [5]

**Question**: [4]  describes ____ of [4a] on [5]

**Example**: As we see below, [4] is nothing but the dot product
(projection) of [4a] on [5].

For 4a, we think of equilibrium equations in X and Y

X: `$(T \cos{\theta} - mg + m \ddot{u_1})$`   
Y: `$(T \sin{\theta} - m \ddot{u_2})$`

For 5, we think of `$l \delta \theta$` which in X and Y direction is:

X:`$u1 = -l \sin{\theta} \delta\theta$`   
Y: `$u2 = -l \cos{\theta} \delta \theta$`

For [4], we think of multiplying the equilibrium equations with
virtual displacements as shown in the above picture.

`$(T \cos{\theta} - mg + m \ddot{u_1}) \times (-l \sin{\theta}) + (T
\sin{\theta} - m \ddot{u_2}) (l \cos{\theta}) $`

**Claims**: [5] is [6]

**Question**: [5] ____ [6]

**Example:** The slope of the virtual displacements is
`$-tan(\theta)$`, which is tangent to the circle. This is orthogonal
to the Tension forces in the simple pendulum.

**Claims**: [7] involves only [8]

**Question**: [7] involves only [8]

**Example**:

In the example given for [4] we have: 

`$(T \cos{\theta} - mg + m \ddot{u_1}) \times (-l \sin{\theta}) + (T
\sin{\theta} - m \ddot{u_2}) (l \cos{\theta}) $`

The tension force cancels out giving the virtual work equation in the
above image:

`$(- mg + m \ddot{u_1}) \times (-l \sin{\theta}) + ( - m \ddot{u_2})
(l \cos{\theta}) $`.

Thus [7] above, involves force due to gravity `mg` and inertial terms
`m \ddot{u_1}` but not the reaction force `T`, i.e., [7], involves
only [8].

---
**C&Q**:    
> The (virtual work)[9] produced by the (effective forces acting on
> the particle)[10] during a (virtual displacement δui compatible with
> the constraints)[11] is equal to zero.

**Claims**: [9] produced by [10] along [11] is 0

**Questions**: [9] produced by [10] along [11] is ____

**Example**: 

For [11], we think of,

X: `$u1 = -l \sin{\theta} \delta\theta$`   
Y: `$u2 = -l \cos{\theta} \delta \theta$`

For [10], we think of force due to gravity `mg` and inertial terms `m
\ddot{u_1} ` but not the reaction force `T`. 

For [9], we think of 

`$(T \cos{\theta} - mg + m \ddot{u_1}) \times (-l \sin{\theta}) + (T
\sin{\theta} - m \ddot{u_2}) (l \cos{\theta}) $=0`

simplified to **only contain the effective forces**

`$(- mg + m \ddot{u_1}) \times (-l \sin{\theta}) + ( - m \ddot{u_2})
(l \cos{\theta}) $ = 0`

[9], produced by only [10] along [11] is thus 0.

---
**C&Q**:  

> Conversely, `$\sum^{3}_{i=1}(m\ddot{ui}-X_i)\delta u_i = 0$`[1]
> indicates that If the (trajectory ui of the particle)[2] is such
> that the (effectively applied forces)[3] produce no (virtual
> work)[4] for any (virtual displacement compatible with the
> constraints)[5], the (equilibrium)[6] is then (satisfied)[7].

It appears that the above is nothing but what we did in the last
---
**C&Q**:  , but with the "(equilibrium)[6] is then (satisfied)[7]"
statement added.

*This is something I came across while DPing a few articles back. I
don't know what it means to "satisfy equilibrium". In my view, all
systems are in dynamic equilibrium, i.e., everything can be written in
the D'alhembert's form. I have no example, when system is not in
dynamic equilibrium. I don't understand those final words,
"equilibrium is satisfied".*

For the rest is very similar to the last *C&Q* so I don't go further
with it!

---
**C&Q**:  

> Again, the (principle of virtual work)[1] corresponds to the
> (projection of the equilibrium equations)[2] in the (directions
> compatible with the kinematical constraints)[3]. The (resulting
> equations)[4] are then (easier to solve)[5] since the (constraining
> forces are no longer unknowns)[6] for the problem.

*[1],[2],[3] have been already dealt with! Moving on!*

**Claim**: [4] is [5] because of [6]

**Example:** In the case of the simple pendulum the equation [4], has
no reaction forces in it and hence the reaction forces doesn't need to
be solved. Now we just have to solve 1 equation ([4]) for 1 unknown
($\theta$) instead of also solving also for the reaction Forces.

For 4, we think of the following equation where we have one unknown
`$\theta$`

`$ml^2 \ddot{\theta} + mgl \sin{\theta}=0$`

For 5, we think of solving the following two equations for two
unknowns `$\theta$` and `$T$`

X: `$(T \cos{\theta} - mg - m \ddot{u_1})=0$`   
Y: `$(T \sin{\theta} - m \ddot{u_2})=0$`

where u1, u2 are functions of `\theta`

---
**C&Q**:    

> Without (kinematic constraints)[1], the (state of the system)[2] would
> be completely defined by the 3N (displacement components `$u_{ik}$`)[3]
> since, starting from a (reference configuration `$x_ik$`)[4], they
> represent the (instantaneous configuration)[5]:

`$$
\xi_{ik}(t) = x_{ik} + u_{ik}(x_{jk},t)    
i,j=1,2,3; k = 1,...,N
$$`

> The (system)[6] is then said to possess 3N (degrees of freedom)[7].

**Claims**: Without [1], [2] is known with 3N [3] because ...

**Questions**: Without [1], [2] is known from  ____ [3]

**Examples**: With the pendulum free to move without any bar holding
it at a distance L, if the pendulum is at (2,L,3), we need 3
parameters to define its position in space. N=1 particle, implies 3N =
3 displacements:

`$ux = X = 2$`
`$uy = Y = L$`
`$uz = Z = 3$`

With the pendulum bar of length L, if the pendulum is at (0,L,0), then
`$\theta = 90^\circ $` defines its position in the 2d case. 

`$ux = L \cos{\theta} = 0 $`
`$uy = L \sin{\theta} = L $`
`$uz = 0$`

**Claims**: [4] + [3] = [5]

**Questions**: [4] + [3] = ____

**Examples**: The reference configuration is say (1,1,0) for the
ball. If it moves by (2,3,0), then the new current position of
the ball is (3,4,0). 

**Claims**: [6] has 3N [7]

**Question**: [6] has ____ [7]

**Examples**: With the pendulum free to move without any bar holding
it at distance L, it needs 3 variables to know its position (as seen
above).  N=1; 3N = [3].

---
**C&Q**:    
> In (most mechanical systems)[1], however, the (particles)[0] are
> submitted to (kinematic constraints)[2], which restrain their
> (motion)[3] and define (dependency relationships between particles)[4].

**Claims**: In [1], [0] is bound by [2] which restrains [3] 

**Question**: In [1], [0] is bound by ____ which restrains [3] 

**Example**: In the double pendulum, the two balls are forced to move
in a particular trajectory. Ball 1 can move in a circle given by
radius L1. Ball 2 can move in a circle given by radius L2, for a given
position of ball 1.

**Claims**: In [1], [0] is bound by [2], which defines [4]

**Question**: In [1], [0] is bound by ____ which defines [4]

**Example**: We think of a double pendulum. Ball 1 can move in a
circle given by radius L1 alone. Ball2, is dependent on the position
of ball 1 as shown below:

![double pendulum](./images/images-DP-3/double-pendulum.png)

*Because it says particles, I use the double pendulum example*

## Mechanics: non-holonomic constraints (40)

**Source:** Mechanical Vibrations by Daniel Rixen

---
**C&Q**:    
> **Holonomic constraints** 

> The (holonomic constraints)[1] are defined by (implicit
> relationships)[2] of type:

`$$
f(\xi_{ik},t)=0
$$`

> If there is no (explicit dependence with respect to time)[3], the (
>constraints)[4] are said to be (scleronomic)[4a]. They are
>(rheonomic)[4b] otherwise.

> A (holonomic constraint)[6] reduces by one the number of (degrees of
> freedom of the system)[7].

**Claims**: [1] is of type `$f(\xi_{ik},t)=0$`

**Examples**: `$\sqrt{x^2+y^2} - L = 0$`

This is a holonomic constraint for the simple pendulum, where the
distance between the ball and the origin is given by
`$\sqrt{x^2+y^2}$`.

![scleronomic](./images/images-DP-3/scleronomic.png)

**Claims**: [1] is defined by [2]

**Questions**: [1] is defined by ____ relationships

**Examples**: <!-- `$f(\xi_{ik},t)=\sum^3_{i=1} -->
<!-- (\xi_{i2}-\xi_{i1})^2-l^2=0$` --> `$\sqrt{x^2+y^2} - L = 0$`

Here we see that `x,y & t` are written on the same side of
the equation, equated to 0 (implicit).

**Claims**: if [3], then [4] is said to be [4a]

*This claim cannot really be verified as scleronomic is a label given
to something that looks a particular way*

An example of the [4a] is `$\sqrt{x^2+y^2} - L = 0$`

**Claims**: If not [3], then [4] is said to be [4b]

*This claim cannot be verified as well as rheonomic is just a label
given to something*

An example of [4b] is: 

![reonomic png](./images/images-DP-3/reonomic.png)

Here, the constraint is given by the following where there is also
time dependence.

`$\sqrt{(x-x_0 \cos{\omega t})^2 +y^2} - L =0 $`

**Claims**: [6] reduces [7] by 1

**Questions**: [6] reduces [7] by ____

**Examples**: In the 2d pendulum example, without the bar constraint
`$\sqrt{x^2+y^2} - L = 0$`, the pendulum ball is free to move in all
directions. This means it has 2 DOFs (x and y). With the constraint
the pendulum ball can only move in a circle and hence has only 1 DOF
(`$\theta$`). 

2-1 = 1 

---
**C&Q**:    
> A (constraint)[1] is said to be (nonholonomic)[2] if it cannot be put in
> the (form (1.12))[3]. In particular, (non-holonomic constraints)[4]
> often take the form of (differential relationships)[5]. (Such
> relationships)[5\*] are generally not (integrable)[6], and therefore
> they do not allow reduction of the (number of degrees of freedom of
> the system)[7].

`$f (\dot{\xi}, \xi, t) = 0$`

**Form 1.12:** [3]
`$$
f(\xi_{ik},t)=0
$$`

**Claims**: [1] is [2] if it cannot be like [3]

*This is a definition-claim. The best I think I can do here I think is to give
an example for [2]*

For 2, we think of:

![non-holo png](./images/images-DP-3/non-holo.png)

`$\dot{x_1} + r \dot{\phi} \cos{\theta}=0$`
`$\dot{y_1} - r \dot{\phi} \sin{\theta}=0$`

~~Here the plate is assumed to be parallel to the Z axis and that it
does not slip.~~

**Claims**: [4] "often" has [5] in it.

**Question**: [4] has ____ relationship in it. 

**Example1**: 

`$\dot{x_1} + r \dot{\phi} \cos{\theta}$`
`$\dot{y_1} - r \dot{\phi} \sin{\theta}$`

The equations have `$\dot{x_1}$` and `$\dot{\phi}$` in it.

*For "often" "generally", I would think I should give atleast one more
example either "for" or "against"! Your thoughts?*

**Claims**: [4] with [5] is not "generally" [6]

**Questions**: [4] with [5] is ____ [6]

**Examples**: The constraints shown below cannot be integrated as
there are two variables in one term, i.e., `$\theta$` `$\phi$`

`$\dot{x_1} + r \dot{\phi} \cos{\theta}=0$`

Contrast this to `$\theta$` being fixed. We are able to integrate it to:

`$x_1 + r \phi \cos{\theta_{fixed}} = 0$` i.e., a holonomic constraint.

**Example2**: The constraints shown below CAN be integrated although
they seem to be in the non-holonomic form.

`$\dot{x_0}+\dot{y_0} = 0$`

Upon closer examination, once integrated they turn out to be holonomic
constraints. I guess as a result this is not a non-holonomic
constraint and non-holonomic constraints must not be integrable.

**Claims**: [4] with [5] are generally [6] and therefore does not
reduce [7]

**Questions**: [4] with [5] are generally not [6] and therefore does
not ____ [7]

**Example1**: 

![non-holo png](./images/images-DP-3/non-holo.png)

We need 8 variables to know the position of the plate in the
co-ordinate system (DOFs):

`$x1, y1, z1, x2, y2, z2, \phi, \theta$`

The following are the non-holonomic constraints: 

`$\dot{x_1} + r \dot{\phi} \cos{\theta}$`
`$\dot{y_1} - r \dot{\phi} \sin{\theta}$`

The following are the holonomic constraints: 

`$x2-x1 = r \sin{\phi} \cos{\theta}$`
`$y2-y1 = r \sin{\phi} \sin{\theta}$`
`$z2-z1 = -r \cos{\phi}$`
`$z1 = r$`

With holonomic constraints just by simple substitution we reduce the
DOFs by 1 for each constraint. So we now have 4 dofs (8-4). The two
non-holonomic constraints seem to not reduce the DOF's!

Initial DOFs: 8
Holonomic constraints: 4
non-holonomic constraints: 2
Final Dofs: 4 (8-4)

**Example2**: With the moving origin of a pendulum example, 

`$\dot{x_0}+\dot{y_0} = 0$` can be reduced to `$x_0 + y0 = constant$`
by integration; With an initial condition this constant will be
known. This is nothing but is in the form of holonomic constraint.

Initial DOFS: 3 ($\theta$, x0,y0)
holonomic constraint disguised as a non-holonomic constraint: 1
Final DOFS after constraint: 2 ($\theta$ & x0)

*This took me 2 hrs for the last 8 phrases. Man puzzling out takes
time, but I seem to understand the word integrate and it's relation to
holonomic constraints. I remember seeing the word integrate and
thinking at the beginning, ah I am fucked! Indeed, I felt fucked but I
think I swam out. Please give feedback on how unclear the above is for
a reader like you and what I can do to make it easier for your eyes!*

---
**C&Q**:    
> If R (holonomic kinematic constraints)[1] exist between the 3N
> (displacement components of the system)[2], the (number of degrees of
> freedom)[3] is then reduced to (3N − R)[4]. It is then necessary to
> define n = 3N − R (configuration parameters)[5], or (generalized
> coordinates)[6], denoted (q1 , ... , qn ) in terms of which the
> (displacements of the system particles)[7] are expressed in the form:

`$u(x_{jk},t) = U_{ik}(q_1, q_2..., q_n,t))$`

**Claim**: If R of [1] exist between 3N of [2], then [3] is reduced to
[4].

**Question**: If R of [1] exist between 3N of [2], then [3] is reduced to
____.

**Example**: Take a double pendulum. 

No: of holonomic constraints: 2 [1] 
No: of displacement components: 2*2 (3N is 2N in 2D) [2] 
No: of DOFs: 4-2 = 2 [3,4]  

With `$\theta_1$` we know the position of the first ball. With
`$\theta_2$` we know the position of the second ball as well.

**Claim**: It is necessary to define [5] or [6] such that [7] are of
the form shown.

`$u(x_{jk},t) = U_{ik}(q_1, q_2..., q_n,t))$`

**Question**:  It is ____ to define [5] or [6] such that [7] are of
the form shown.

**Example**: Pg22, derivation, shows writing the displacements `$u_1,
u_2$` in `$\theta$` allows for the derivation of 1 motion equation. If
we keep it as `$u_1$` and `$u_2$`, then we have 2 motion
equations. Hence making it necessary to write it in `$\theta$` which
will reduce to [1] equation, [1] unknown.

For [5] or [6] we think about the pendulum example, where variable `$\theta$`
defines the position of the system.

For [7] we think of `$u_1=L\cos{\theta}$` and `$u_2=L\sin{\theta}$`

---
**C&Q**:    
> When only (holonomic constraints)[1] are applied to the (system)[2],
> the (generalized coordinates qs)[3] remain (independent)[4] and may be
> varied in (an arbitrary manner without violating the kinematic
> constraints)[5]. The (virtual displacements `$δu_{ik}$` compatible
> with the holonomic constraints)[6] may be expressed in the (form)[7]:

`$\delta u_{ik} = \sum_{s=1}^{n} \frac{\partial U_{ik}}{\partial q_s}
\delta q_s$`

**Claim**: When only [1] is applied to [2], [3] remains [4].

**Question**: When only [1] is applied to [2], [3] remains ____

**Example**: In the simple pendulum example, once the pendulum bar is
connected to the pendulum ball (constraint), then `$theta$` is the
variable that does not depend on anything.

The displacements in X and Y depend on `$\theta$`, but \theta does not
depend on anything.

`$u_1 = L \cos{\theta}$`
`$u_2 = L \sin{\theta}$`

For [1] we think of 

`$\sqrt{u_1^2+u_2^2} - L = 0$`

For [2], we think of the simple pendulum

For [3] we think of `$\theta$`

*I realize later that my interpretation of independent is wrong*

**Claim**: When [1] is applied to [2], [3] may be varied in [5].

**Question**: When [1] is applied to [2], [3] may be varied in ____

**Example**: 

*I still do not understand this "varying of displacement in an
arbitrary manner", How varying the displacement in an arbitrary manner
brings about virtual displacement is still not understood. This was
also something I didn't understand when I did the DP exercise a few
times back.*

*So we skip this for now!*

**Claim**: [6] is expressed as [7] 

**Question**:  [6] is expressed as ____

**Example**: As part of the derivation on pg 22 we see that,

`$u_{11} = L \cos{\theta}$`
`$u_{12} = L \sin{\theta}$`

From which we get in the form of [7]. Here s=1, n=1, k=1; Therefore:

`$\delta u_11 = -l \sin{\theta}\ \delta \theta $`
`$\delta u_12 = l \cos{\theta}\ \delta \theta $`

---
**C&Q**:    
> The (coefficients `$\frac{\partial U_{ik}}{\partial q_s}$`)[1]
> define the (displacement directions of mass k)[1a] when the
> (generalized coordinate $q_s$)[2] is varied. The (variations
> δqs)[3] are (totally independent by definition)[4], meaning that
> they can be chosen arbitrarily without violating any (kinematic
> constraint)[5]. The (identity (1.16))[6] being satisfied for any
> (virtual displacement)[7], it follows that (each associated term in
> the virtual work (1.16) principal)[8] must be zero. (These terms)[9]
> correspond to the (equilibrium projected onto the direction of the
> generalized coordinate qs)[10].

Identity 1.16:

> `$\sum_{s=1}^n (\sum_{k=1}^N \sum_{i=1}^3 (m_k \ddot{u_{ik}} -
> X_{ik}) \frac{\partial U_{ik}}{\partial q_s}       ) \delta q_s=0$`

**Claim**: [1] is [1a] when [2] is varied.

**Question**: [1] is ____ when [2] is varied.

**Example**: In the simple pendulum example, when `$\theta$` is "varied"
we get,

`$\delta u_{11} = -l \sin{\theta}\ \delta \theta $`
`$\delta u_{12} = l \cos{\theta}\ \delta \theta $`

from the displacements,

`$u_{11} = L \cos{\theta}$`
`$u_{12} = L \sin{\theta}$`

The coefficients extracted are:

in Y: `$-l \sin{\theta}$`
in X: `$ l \cos{\theta}$` 

When you divide the coefficients Y by X, you get `$-\tan(\theta)$`,
which is nothing but the slope of the circle traced by the
pendulum for the current coordinate system, u1 facing down and u2
facing to the right. 

*I thought I knew what the displacement direction of mass means! When
I tried to explain I stunk! My explanation didn't make any
sense. After a while I have an explanation.*

**Claim**: [3] can be chosen arbitrarily without violating [5] 

*Not sure what "arbitrarily chosen" means. This is something that I
have encountered in the beginning of the this section as well.*

**Claim**: [4] implies that [3] can be chosen arbitrarily without
violating [5] 

*This is a definition.*

**Claim**: [6] is 0 for any [7] 

**Question**: [6] is ____ for any [7]. 

*What does "any virtual displacement" even mean, can't think of an
example for this!?*

**Claim**: [8] is [10]

**Question**:  ____ term in identity 1.16 is [10]

**Example**: 

*[8] is without the reaction forces*

We know the equilibrium equations for the simple pendulum
from before,

X: `$(T \cos{\theta} - mg + m \ddot{u_1}) = 0$`   
Y: `$(T \sin{\theta} - m \ddot{u_2}) = 0$`

The above equilibrium is multiplied by the direction of generalized
coordinates 

`$(T \cos{\theta} - mg + m \ddot{u_1}) \times (-l \sin{\theta}) = 0$`

`$ (T \sin{\theta} - m \ddot{u_2}) (l \cos{\theta}) = 0$`

We continue to have the equation = 0; here n=1, N=1, i varies 1..2.

The above is the exact term referred by [8].

**Claim**: [8] is 0

**Question**: [8] is ____

**Example**: From the previous example, we see that [8] is indeed 0


## Career research - Analysis continued (42) 

**Source:** From the [Summary I wrote for my career analysis](/Summary-before-applying-to-80k.html).

---
**C&Q**:    

> (CC wise)[1], (DE)[2] appears to give little or no support to the
> (career ambitions I have)[3], such as, to go into (EAO’s in
> management or analyst roles)[4]. (It’s)[2] also not good for
> (ETG)[5]. (DS)[6] seems like a (clear winner)[7] when compared to
> (DE)[2] as it does (more than DE)[8] and (aides in
> going towards DW)[9]. So, (DS)[6] \> (DE)[2].  

CC - Career Capital, DE - Design Engineering, DS - Data Science

**Claim**: [2] does not support [3], considering [1].

**Question**: [2] does not support [3] considering ____.

**Example**: With working as a design engineer, skills like
statistics are very rarely used during my work and hence not
learnt. These are the [skills that seem to be required for
EAO's like GiveWell](https://www.givewell.org/about/jobs/research-positions).

For [1], we think of skills such as statistics, managing an
organization/team.

For [2], we think of working in the lithography industry as a design
engineer for the next 5-10 years.

For [3], we think of working in an EAO like GiveWell or 80000 hrs in
the roles of management or analyst.

**Claim**: [2] is not good for [5]. 

**Question**: Salary for [2] ____ Salary for [6]. 

**Example**: 

 Mechanical Design engineer jobs in the KLA San Francisco: [119k avg
 salary](https://www.glassdoor.co.uk/Salary/KLA-Mechanical-Design-Engineer-US-Salaries-EJI_IE1557.0,3_KO4,30_IL.31,33_IN1.htm?experienceLevel=ONE_TO_THREE) 
 
 Data Scientist in Facebook California: [150k avg salary](https://www.glassdoor.co.uk/Salary/Facebook-Data-Scientist-San-Francisco-Salaries-EJI_IE40772.0,8_KO9,23_IL.24,37_IM759.htm?experienceLevel=ONE_TO_THREE)

 Friend in KLA California earns 100k in a similar to Mechanical
 Designer role in KLA, whereas friend in Apple earns at \~150k as a
 Data Scientist.

**Claim**: [6] "seems like" [7] w.r.t  [2] considering [8]. i.e., [6]>[2].

**Question**: [6] ____ [2] considering [8] 

**Example**: 

DS at Facebook gives "more skills" in statistics and more salary, than
DE at ASML and hence is a better choice.

**Claim**: [6] "seems like" [7] w.r.t [2] considering [9]. 

**Question**: [6] ____ [2] considering [9]. 

**Example**:

DS at Facebook involves a "lot more statistics" than DE in ASML/KLA,
which is needed at EAO's like GiveWell.

*I suspect you are going to say this is not an example! If so, then
the example I would need to come up with is something like, A did DS
and went to GiveWell, and B did DE and didn't go to GiveWell. But such
examples are hard to find right?*

For [7], we think of performing linear regression analysis with
multiple variables everyday as a DS than once in a 3 months as a DE.

For [9], we think of working in GiveWell.

---
**C&Q**:    

> Although (Starting-up)[1] has (unbelievable potential for impact)[2],
> and (pretty good CC)[3], it still (sucks as an option)[4] because of
> the (very poor personal fit)[5]. In case (great potential)[6] is
> foreseen in (some startup idea)[7] or there is an option to (join a
> startup)[8], an (evaluation of current options)[9] must be done
> then. (Starting-up)[10] is (not for me now)[11].

**Claim**: [1] has [2].

**Question**: Does [1] have [2]?

**Example**: According to [80000 hrs](https://80000hours.org/2014/05/how-much-do-y-combinator-founders-earn/#fn:5), founders from the first 5
years of Y Combinator are now worth 18 million after 5-9 years. If 50%
is donated this would mean a savings of 1800 lives at 5k<span>$</span>
per life. Contrast this to DE Netherlands, where you could save about
200 lives over a 40 year career! JFC!


**Claim**: [1] is [3].

**Question**: Does [1] have [3]?

**Example**: I don't know.

For "pretty good" we think of ???

For "CC" we think of ???

*"pretty good" compared to what?*

*I think I maybe get your frustration on using "CC" now. The
definition of CC is so broad, everything could be good CC, unless, you
look at impact. For example, DS is "good CC", as it gives skills in
statistics. Starting up gives "good CC"* even if you fail as you have
"management skills". These are absolutely useless statements, as there
is no number associated with it. Ultimately the only thing we care
about is IMPACT. I would rather, 'DS allows you to save N1 lives',
'Starting up allows you to save N2 lives when you fail'. It was
painful to think of examples and struggle with WORDS, LABELS and
definitions! Am I wrong?*

*This would mean to not deal with these words at all anymore?*

*And please do call out such words, so I can rid them off my
dictionary as well!*

**Claim**: [1] is [4] because of [5].

**Question**: Is [1], [4] because of [5]?

**Example**: The effective impact is obtained by multiplying the
chance of success with potential impact.

With startups the chance of success for me currently as [calculated
here](http://agent18.github.io/Summary-before-applying-to-80k.html) (in the "founding startup" section), is 0.03%, i.e., the
effective impact is` 0.03%*1800` lives = 0.54 lives over a lifetime.

**Claim**: if [6] is seen in [7] then [9] must be done.

**Question**: if [6] is seen in [7] then [9] ____ be done.

**Example**: In case we come across a startup idea like AirBnb, i.e.,
one that has never been done before and if scaled all over the world
can make a lot of money, [evaluating your options as shown by 80k
hours](https://80000hours.org/career-planning-tool/).

*I don't have an example, but it "seems like a good thing to do". It's
still a claim. I agree. What should I do in these cases?*

**Claim**: if [6] is seen in [8] then [9] must be done.

**Question**: If [6] is seen in [8] the [9] must be done.

*Same as above!*

**Claim**: [10] is [11].

**Question**: Is [10], [11]?

**Example**: if you look at my current personal fit, it is at 0.03%
leading to an expected value of 0.54 lives saved per lifetime. If I
continue working where I do right now as a DE, I am guaranteed to save
\>100 lives.


<!-- [11] + [9]  -->

---
**C&Q**:    
> An (Economics PhD)[1] shall be done for either (getting into
> academia)[2] or getting into (places like government institutions
> where you might rarely get a chance to change many lives)[3]. The
> (effective impact)[4] of a (career in academia)[2] is estimated as
> (624 lives)[6], where as the (maximum impact of a tenure track
> position)[7] is (582 (which is \<624) lives)[8]. This implies that
> the (failure paths chosen in the decision tree)[9] have (probably
> much higher impact)[10] (which is also the case)[11].

**Claim**: [1] is done for [2].

**Question**: Is [1] needed for [2]?

**Example**: 

*Unfortunately, when I looked at MITs Poverty Action Lab, they seemed
to want in their requirements masters and bachelors in economics with
X years of experience. I didn't find PhD requirements except for 1
position of post-doctorate. Also Robin Hanson's interview [here](https://80000hours.org/2013/10/the-value-of-economics-phds-a-conversation-with-robin-hanson/)
seems like labels after labels. So I am really not sure, if Econ PhD
is the right one for getting into places like MITs Poverty Action Lab*
(or "similar").

*I am not sure what kind of impact these boys in "academia can have"
especially because of an Econ Phd.*

For [2], we think of getting into [academia like the "MITs Poverty
Action Lab](https://80000hours.org/career-reviews/economics-phd/), for ending extreme poverty" and gaining
<span>XXX $</span> of impact.

**Claim**: [1] is done for [3].

**Question**: Is [1] done for [3]?

**Example**: we think of [this blog post's owner](http://allegedwisdom.blogspot.com/2017/03/the-story-of-lucky-economist.html), who informs
about his job in the government and how he had an impact of saving 400
lives once in his career in addition to donations that he makes.

**Claim**: [4] in [2] is [6].

**Question**: [4] in [2] is ____.

**Example**: Effective impact calculation that I have done earlier was
based on some extrapolation, and I didn't spend too much  time into it
as I knew I was not going to take it up any way.

I would assume the impact is similar to an EAO like 80khours i.e., ~1k
lives saved over a 40 year career. With Econ PhD, I guess it is like a
30 year career only due to the long study time. 

The effective impact would reduce as a result of my "poor personal fit"
with being able to do an Econ PhD. When I input it [here](https://docs.google.com/spreadsheets/d/1uclRbujg4o9DTXxjVmwKU7-_lhe8AwQ7rQdIl3LhLzQ/edit?usp=sharing), I get a
value of 640 lives. Close to [6]. 

**Claim**: [7] is [8].

**Question**: Is [7], [8]?

**Example**: Pursuing a tenure track will cut another[ 7-11 years](https://80000hours.org/2013/10/the-value-of-economics-phds-a-conversation-with-robin-hanson/) from
your life where you can cause impact. Resulting in lower impact than
working in say MIT's Poverty Action Lab. Assuming of course, that the
tenure track in academia will have the same impact as working at EAOs
~1k lives per 40 years of work.

**Claim**: [9] has [10].


I skip this, as 9 doesn't make sense any more. 

*Really bad writing!*

*11 also skipped for similar reasons!*

---
**C&Q**:    
> Also, compared to (DS for DW)[1] this (career path is not good)[2],
> looking at (personal fit)[3] as well as (impact)[4]. If I take up
> this career, I see myself loosing up to (10 years from now)[5]
> before finishing my PhD. There is a (very good chance)[6] that I
> don’t make the (tenure track)[7] but still get into
> (academia)[8]. This could easily (set me back another decade)[9]
> before I (start my real contribution in academia)[10], (further
> reducing the impact)[11].

**Claim**: DS for DW \> Economics PhD considering [3].

**Question**: DS for DW ____ Economics PhD considering [3].

**Example**: Based on the fact that I didn't get top 20 for my masters
in the US, I think it is axiomatic that I don't have credentials for
top 20 in Economics PhD. I probably need to spend 3-5 years working my
way up from ground 0 in economics before I am top 20 worthy. 

Whereas with DS, I personally know several engineers who studied
similar to my degree, who went to DS after a masters.

In the meanwhile, since I have 5 years before I make the official
jump to EAO, I have plenty of time to do Deliberate Practice and beef
up my statistics game. Hence I claim that Personal fit is "much better"
for DS for DW than Economics PhD.

For [1], we think of working in DS in Google for 5 years, and then
moving to EAO's like GiveWell.

For Econ PhD, we think of getting into the top 20 colleges to do a PhD

**Claim**: DS for DW \> Economics PhD considering impact

**Question**: DS for DW ____ Economics PhD considering impact

**Example**: Based on [Alleged Wisdom](http://allegedwisdom.blogspot.com/2017/03/the-story-of-lucky-economist.html), it appears that there is a
chance of making an impact as large as 400 lives once in your life. In
addition to this with a salary starting at 108k, it would in total be
possible to save [750 lives](http://agent18.github.io/Summary-before-applying-to-80k.html). 

With working an an EAO like GiveWell, it should be possible to save 1k
lives.

**Claim**: It will take [5] before finishing PhD

**Question**: It will take ____ before finishing PhD

**Example**: Based on [this](https://80000hours.org/2015/06/advice-on-entering-a-us-economics-phd-from-the-uk-with-a-non-quantitative-background/) the initial prepping for Economics PhD
will take 3 years atleast! [An econ PhD takes 5-7 years](https://80000hours.org/career-reviews/economics-phd/#what-is-this-career-path). In total
10 years.

**Claim**: \<5% chance that I make [7] 

**Question**: ____ % chance that I make [7].

**Example**: *Unable to find any links that gives stats comparing
tenure and non-tenure.
*
**Claim**: >50% chance that I go into [8].

**Question**: ____ % chance that I go into [8].

**Example**: [This](http://ftp.iza.org/dp6990.pdf) link suggests that academic positions were
\>55% of all the employments of Econ PhDs for 2012

**Claim**: Lack of [7] leads to [9] before [10]

**Question**: Lack of [7], leads to ____ before [10].

**Example**: *I only have Robin Hanson's word for it! Also he does not
say that absence of tenure track is pointless to work, he only says
that if the research you need to do is not in the direction for
positive impact only then we may want to spend time to get tenure track*

**Claim**: Lack of [7] leads to [11] 

**Question**: Lack of [7] leads to ____

**Example**: If I spend 10 years for studying, and another 10
years to get tenure track, I will have another 20 years to work. Where
as if I start with tenure track after 10 years of studying, then I
have 30 years of contribution still left. 

*I know this whole series above of [10] phrases is with no
proper examples. Only while I write this I see how I am lacking. Only
when someone asked me for examples am I thinking that maybe what I am
guessing could be wrong. For example, I have no resources with me
how hard it is to get tenure track, other than "it is HARD".*

## 80k hours CC (15)

**Source:** https://80000hours.org/career-guide/career-capital/

---
**C&Q**:    
> So we’ve seen (what career capital is)[1] and (why it’s
> important)[2]. But (how do you get it)[3]? Here’s a (list of paths
> that we’ve found)[4] are often good for (gaining flexible career
> capital early on)[5]. Note down any that could be a good fit for
> you.


**Claim**: We've seen [1] in the article referred. 

**Question**: We ____ seen [1] in the article referred.

**Example**: In the article [referred above](https://80000hours.org/career-guide/career-capital/), "CC" is described and
there is atleast one example of what it is.

For [1], we think of Rob Mather working in Sales and Marketing
(building skills), before he started AMF (where he claims the skills
gained earlier were "useful")

**Claim**: We've seen [2].

**Question**: We ____ seen [2].

**Example**: In the article [referred above](https://80000hours.org/career-guide/career-capital/), we have seen that
Kate went to work at a non-profit directly after university. She
couldn't advance further and returned back to the corporate sector for
more training and building useful skills. Instead if she had gone to
the corporate sector directly, she would have ended up much ahead with
more skills.

*You are probably cringing at "more skills" "advance further",
etc... Forgive me I wanted to take an example from 80k and this is the
only one I found where focusing and not focusing on "CC"  were
contrasted-ish*

**Claim**: (Working at a growing organization that has a reputation for
high performance)[4] is good for [5].

**Question**: Working at a growing organization that has a reputation
for high performance is ____ for [5].

**Example**: Peter works for a startup that makes credit models to
make personal loans cheaper. Here Peter is learning to program, as
well as learning about business and finance as well.

For [4], we think of working at a growing organization that has a
reputation for high performance like any startup, where you take on
many tasks and gain generic skill in many fields. (Exhibit Peter:
skills in programming, business and finance).

For [5], we think of Peter gaining skills in programming, business and
finance.

*Good flexible CC! SST???*

*The last [5] phrases took 78 minutes. I suspect it is because of the
fuzzy words like Career Capital. Don't even get me started on Flexible
CC.*

---
**C&Q**:    
> Work at a growing organization that has a reputation for high
> performance

> (Rob Mather)[1] is the (founder)[2] of (Against Malaria Foundation)[3],
> which (GiveWell)[4] rates as the (most cost-effective)[5], (proven)[6]
> and (well-run)[7] (international development charity in the world (as
> of 2016))[8]. But he started his career in (sales and management
> consulting)[9]. He says (these positions)[9] gave him (the management and
> persuasion skills)[10] he used to make AMF (so lean and efficient)[11].

**Claim**: [1] is the founder of [3].

**Question**: [1] is the ____ of [3].

**Example**: https://www.againstmalaria.com/People.aspx

**Claim**: [4] rates [3] as [5] [8].

**Question**: [4] rates [3] as ____ [8].

**Example**: It looks like in 2016, AMF is only 0.4 as cost-effective
as 'Deworm the world' and a few other charities. So I am not sure it
is the most effective as mentioned by 80000 Hours!

For [5], we think of the cost effectiveness model made by GiveWell
[here](https://docs.google.com/spreadsheets/d/1KiWfiAGX_QZhRbC9xkzf3I8IqsXC5kkr-nwY_feVlcM/edit#gid=1034883018).

**Claim**: [4] rates [3]  as [6] and [7] [8].

**Question**: [4] rates ____ as [6],[7],[8].

**Example**: GiveWell does rate AMF as on of the top charities people
should donate to. 

**Claim**: [1] started in [9].

**Question**: [1] started in ___ after university.

**Example**: https://www.againstmalaria.com/People.aspx

**Claim**: [9] gave [10].

**Question:** [9] gives ____

**Example**: I don't know what they are talking about!

**Claim**: [3] is [11].

**Question**: ___ is [11].

**Example**: AMF has 198 million <span>$</span> in total donations in
15 years with the peaks of \~40 million in the last four years! This
is achieved with 8 people being paid @ AMF and several partners and
volunteers who assist for free.

**Claim**: [1] uses [10] he got from [9], to make [11].

**Question**: [1] uses [10] he got from ____, to make [11].

**Example**: *No idea of where to find evidence for an
independent test of the claim*

For [10], we think of funding?

For [11], we think of few people and massive savings in lives?

*Can you suggest a 'Spectator' for concrete thinking? #BF method *


## Eliezer Yudkowsky Entanglement (14)

---
**C&Q**:    
> Walking along the street, your shoelaces come untied. Shortly
> thereafter, for some odd reason, you start believing your shoelaces
> are untied. Light leaves the Sun and strikes your shoelaces and
> bounces off; some photons enter the pupils of your eyes and strike
> your retina; the energy of the photons triggers neural impulses; the
> neural impulses are transmitted to the visual-processing areas of
> the brain; and there the optical information is processed and
> reconstructed into a 3D model that is recognized as an untied
> shoelace. There is a (sequence of events)[1], (a chain of cause and
> effect, within the world and your brain)[2], by which you end up
> (believing what you believe)[3]. The (final outcome of the process)[4] is a
> (state of mind)[5] which mirrors the (state of your actual shoelaces)[6]


**Claim**: [1], and [2] results in [3].

**Question**: [1] and [2] result in ____

**Example**: 

Walking along the street, your shoelaces come untied. Shortly
thereafter, for some odd reason, you start believing your shoelaces
are untied. Light leaves the Sun and strikes your shoelaces and
bounces off; some photons enter the pupils of your eyes and strike
your retina; the energy of the photons triggers neural impulses; the
neural impulses are transmitted to the visual-processing areas of the
brain; and there the optical information is processed and
reconstructed into a 3D model that is recognized as an untied
shoelace.

For [1], we think of 'light leaving the sun and striking your
shoelace', 'photons enter the pupil of your eyes', etc... ending
with 'the brain '

For [2], we think of 'light striking the shoelace' and then reaching
your pupil, where the information is processed by the brain to make it
a 3D model that is recognized as an untied shoelace.

For [3], we think of believing that shoelaces are untied


**Claim**:  [4] is [5] 

**Question**: _____ is [5]==[6].

**Example**: Light leaves the sun and hits an untied shoelace and then
reaches the pupil of the eye. The brain then processes it and spits
out the 3d model in the end, which is recognized as an untied
shoelace.

For [5], we think of recognizing the 3d model generated in our brain
as an untied shoelace

---
**C&Q**:    
> What is (evidence)[1]? (It)[1] is an (event entangled)[3a], by (links of
> cause and effect)[2], with (whatever you want to know about)[3]. If
> the (target of your inquiry is your shoelaces)[4], for example, then
> the (light entering your pupils)[5a] is (evidence entangled with your
> shoelaces)[5]. This should not be confused with the (technical sense of
> “entanglement” used in physics)[6]—here I’m just talking about
> “entanglement” in the sense of (two things that end up in correlated
> states)[7] because of (the links of cause and effect between them)[8].

**Claim**: [1] is [3a] with [3], by [2].

**Question**: ____ is [3a] with [3], by [2].

**Example**: 

*definition*

> 3a with [3], by [2]

light entering the pupil is the event entangled with shoelaces, by
links of cause and effects such as ('light falling on the shoelaces'
leading to 'light reflecting off the shoelaces' etc...)

For [3a] with [3], we think of 'light entering your pupil' being the
event entangled with shoelaces.

For [3], we think of shoelaces.

**Claim**: if [4], then [5a] is [5].

*also an example for the previous claim. No need to explain this.*

**Claim**: [5] != [6].

**Question**: [5] ____ [6].

**Example**: 

For [5], we think of "light entering the pupil"

For [6], we think of "subatomic particle decays into an entangled pair
of other particles" --- Wikipedia. 

[5] != [6].

**Claim**:   [7] because of [8]. 

**Question**:  ____ because of [8].

**Example**: *because*

## Work: BM with springs(26)

*My GL did some cool work and sent it out to everybody. This being
related to control and dynamics, I had a hard time understanding
it. So I started to look at his claims one by one, started putting
numbers, cleared one by one and went all the way till the end to see
if they held water. In the end I had 2 questions and was able to
discuss with him on "his level" about what he had written and what my
questions were aka what I didn't understand. I felt happy. Atleast as
soon as I started pulling some numbers from the text 50 N/mm
etc... life started to become better. I need to do this on more and
more on more documents at work. The first time I read it, I knew I was
just reading labels. No understanding, because I didn't paint a
picture in my head with \#examples, I guess. Isolate and tackle and
identify what exactly you didn't understand or so I thought!*

![stage-damper png](./images/images-DP-3/stage-damper.png)

**Context for reader:**

The stage has coils and the balance mass has magnets in it. With
current in the coils it creates a force on the stage and the BM
(balance mass). The stage needs to move 150mm and the balance mass
which is 5 times as heavy will move only 30mm. Initially there were no
springs but motors to bring back the balance mass to the center, once
in 10 days (in case it drifted away). This was an investigation by
GL about this. And I had to understand what they were saying.

---
**C&Q**:  

> What if we replace the Drift motors by simple springs with damping?

>**Consequence 1**
> Obvious: (Force)[1] will be exerted on the (outer frame)[2]. But the
> (magnitude of this force)[3] is (small)[4]:(maximal the amount of
> force needed by the balance mass motors)[5] otherwise. The (force)[6]
> scales with the (displacement of the balance mass)[7], which is a
> (double integrator of the applied force to the stage)[8]. (This
> force)[9] thus only has (low frequent components)[10].

**Claim**: [1] is exerted on [2]. 

**Question**: ____ is exerted on [2] because of the presence of
springs.

**Example**: When the stage moves from 0 to 150mm to the right, the
balance mass moves 30mm to the left. This results in a spring
compression of 30mm. Assuming a stiffness of 50N per 30 mm (based on
another document), we see that there will be a force of 50N on the
frame.

**Claim**: [3] is [5]. 

**Question**: [3] ____ [5].

**Example**: The documentation suggests that with drift motors 50 N of
force will be on the frame and this is fine. With the spring of
stiffness 50N per 30mm, we should have the same force on the frame.

**Claim**: [3] is [4].

**Question**: [3] is ____.

**Example**: [3] will be 50N force on the frame which is allowed when
using the drift motors and hence it shall be allowed when we use
springs. Hence it is "small" aka acceptable.

**Claim**: [6] increases with [7]. 

**Question**: [6] increases, [7] _____

**Example**: It is a spring, so this is expected. If the spring
compresses 30mm, then we have a force of 50 N. If the spring
compresses 15mm, then only a force of 25N is experienced on the outer
frame.

**Claim**: [6] increasing with [7], is [8].

**Question**: [6] increasing with [7], ____ [8].

**Example**:  No idea what [8] means. *It is not my area*

**Claim**: Due to [8], [9] results in [10].

**Question**: Due to [8], [9], results in ____.

**Example**: I don't understand [8] yet, so not able to comment on
[10]. Also what is "low frequency", I don't know. I imagine it is
something that the controller can handle with ease based on its
"bandwidth"

---
**C&Q**:    

>**Consequence 2**
> Using (low spring constant)[1] keeps the BM in the (center of the
> range)[2a] with a large (time constant)[2]. So even with the stage
> at (one extreme position)[3], the balance mass will (move slowly
> back to the center)[4]. (Moving the stage from that extreme position
> to the opposite extreme position)[5] will result in( movement of the
> Balance Mass twice the amount as when the stage would move from the
> center to that same extreme position)[6]. So another consequence is:
> (twice the movement range of the balance mass)[7] is (needed)[8].

**Claim**: [1] keeps BM in [2a] with large [2].

**Question**: [1] keeps BM, in [2a] with ____ [2].

**Example**: 

For [1], we think about 50N per 30 mm. This brings the BM back to the
center in 1s (time constant). Is this large? I think it is. This
essentially will provide an oscillation of \<1Hz which can easily be
matched by a controller to keep the stage in the same position within
0.5um accuracy.

**Claim**: If stage at [3], BM will [4]. 

**Question**: If stage at [3], the BM will ____ move back to center.

**Example**: When the stage is moved by 150mm from the center, the
balance mass will move by by 30mm. It will come back to 0 mm within
1s and will oscillate with <1Hz. This is slow enough, for the
controller to keep the stage in the same position within 0.5um
accuracy. 

**Claim**: [5], will result in [6].

**Question**: [5] will result in ____

**Example**: Moving the stage by 150mm takes it to the extreme
position with the BM moved by 30mm. We hold the stage there but the BM
drifts towards the center. Now when we want to move the Stage to
-150mm, then the BM will need to move -60mm.

**Claim**: [7] is needed.

**Question**: [7] is ____

**Example**: With the drift motor there is space needed only to move
by 30 mm each side. Due to the springs added, we see in the above
example that we will "need" 2x BM movement. Well!

The 2x need not be necessary based on the actual scenarios. I do not
know the actual scenarios. If the stage stays at the extreme position
only for 0.1s, then the BM drifts 5mm in 0.1s. This means the BM will
need to move by 5 mm extra if the stage moves from one extreme to the
other, if the stage stays at the extreme position for \> 1s, then we
need 2x range for the BM for sure. For now we assume 2x is needed with
springs!

---
**C&Q**:    

> **Consequence 3**
> In case the (balance mass is combined with the motor Yoke (like it’s
> the case for the XBeam)[1], the (extra range of movement needed for
> the balance mass)[2] translates into the (requirement for a longer
> Yoke)[3]. The (extra length needed equals)[4] the (extra movement
> range of the balance mass)[5]. Taking (consequence 2 & 3)[6a]
> together, the (total extra space)[6] needed in order to( replace a
> BM motor by a spring)[7] is 2x the (original movement range of the
> BM)[8].

**Claim**:  if [1], [2] implies longer [3].

**Question**: if [1], [2] implies ____ [3].

**Example**: The current yoke is such that there is 5mm before the
coil runs out of the magnets when the stage is in the extreme
position. This is used for tolerances like machining etc... To
accommodate the spring-design we need +-60mm instead of +-30mm
(current). This means that the Yoke has to be increased by +- 30mm
(60mm total) atleast to ensure that the continuous force of the
actuator is constant (280N +- 1N) so that there are no "problems for
the controller".

**Claim**: [4] == [5].

**Question**: [4] ____ [5].

**Example**: To accommodate the spring we need +-60mm instead of
+-30mm (current). This means that the Yoke has to be increased by 60mm
atleast to ensure that the continuous force of the actuator is 280N +-
1N so that there are no "problems for the controller".

**Claim**: Considering [6a], [6] needed for [7], is 2x of [8].

**Question**: Considering [6a], [6] needed for [7] is ____ of [8].

**Example**: As seen above we need +-60mm of BM travel. Currently we
have 30mm of BM travel. 60\/30 = 2

## Statistics

**Total days:**10 (With three holidays)  
**Total time**: 43.5 hrs  
**Total DP time**: 36.4 hrs  
**Total time on editing:**4.8 hrs  
**Total time on other things:** 7.1 hrs  
**Total Phrases:**208  
**Total Words:**9350  

**Avg time per day**: 4.3 hrs per day!
**Avg DP time per day**: 3.6 hrs per day!
**Avg Phrases per hr**: 5.71
**Max time per day**: 6.9 hrs on Saturday!

**Day 1**: Monday -- 3.6 hrs (holiday)

**Day 2**: Tuesday -- 2.8 hrs (no gym)

**Day 3**: Wednesday -- 4.2 hrs (gym)

**Day 4**: Thursday -- 4.1 hrs (gym cardio)

**Day 5**: Friday -- 1.9 hrs (no gym but traveling long to work)

**Day 6**: Saturday -- 6.9 hrs (holiday)

Slept for 1hr

**Day 7**: Sunday -- 5.7 hrs (holiday)

Slept for 1 hr and played ball and watched 2 hrs of movies

**Day 8**: Monday -- 3.6 hrs (gym)

**Day 9**: Tuesday -- 3.5 hrs (no gym)

Slept 20 mins

**Day 10**: Wednesday -- 5.5 hrs (no gym)

Slept 20 mins; only editing and formatting.

**Other:**

**P.S**

All work was done at home and not at the library. Just feeling lazy
and it takes ~30 mins to travel walk, go to toilet and pack the
things.


<!--

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

-->

<!-- ## Todo -->

<!-- ~~- cut and past as fit.~~ -->
<!-- ~~- edit the text where not good!~~ -->

<!-- ~~headings~~ -->

<!-- ~~- spell check~~ -->

<!-- formatting $$ and ____ -->

<!-- cite where you got shit from -->
	
<!-- ## work -->

<!-- Day 1: Spent time at home went to sleep masturbated even. -->

<!-- I am afraid these are typical things I feel at home! the opportunity -->
<!-- and ease of giving up! Anyways having decided to start at the library -->
<!-- at 7:15, I seem to be much better grinding. 1.5 hrs flew by. Of course -->
<!-- I need to check how I am working at the hotel, cause not everything is -->
<!-- the same. I am on a **misson** now. want to compare mission periods. -->

<!-- But I am liking the library feel again! -->

<!-- Also my worry is about weekedns where I barely fucking perform work! -->
<!-- JFC! less than 4 hrs! omg! -->

<!-- Spent 90 mins and could not come up with exampels! JFC! so fucked up! -->

<!-- Day 2:  -->

<!-- Spent another 42 mins on the same thing! Somebody stop me! No results! -->
<!-- Maybe I should make a stack post on it! -->

<!-- Day 3:  -->

<!-- After a long hiatus of nonsense exhibition behaviour! I finally -->
<!-- at 8:30 pulled my shit together after eating a bucket load of -->
<!-- shit. Did about 4 hrs of work! in the evening. Switched off times and -->
<!-- phones! I don't know what time it is as I write this. I will finishe 7 -->
<!-- more before I go to sleep! Drinking caffine to stay awake and feel -->
<!-- less sleepy! really helping! coca Cola! I need to keep this around for -->
<!-- "those days". Luckily nothing serious tomorrow at work, Can allow for -->
<!-- the "poor sleep" or even late delays. -->

<!-- Slowly soodu pudikudhu! Fuck!  -->

<!-- Feeling like a happy pandian! bouncing back from a nigger 8:30 near -->
<!-- fail day! God! Just need to fucking get wired in! inshallah! Pandian -->
<!-- is back baby! -->

<!-- No seriously, Welcome back Pandian! -->

<!-- 20 phrases in 4.2 hrs! -->

<!-- Day 4: did ~25 phrases. Better than most days! maybe it was due to the -->
<!-- repetition and probably my hang of the process! -->

<!-- Day 5: took a trip back home! ate great food starting at -->
<!-- 21:18... Wanted to crash quite bad, ended up procrastinating! -->




<!-- day 9: 206. -->
