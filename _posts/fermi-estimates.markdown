## Why fermi

Open phil says here that they need fermi estimates in their [2018
recruiting reflections](https://web.archive.org/web/20210124004953/https://www.openphilanthropy.org/blog/reflections-our-2018-generalist-research-analyst-recruiting).

FP asked in their [form](https://web.archive.org/web/20210709213819/https://docs.google.com/forms/d/e/1FAIpQLSeMWpZhhRhHqim-e75ywhsF0q8Tap3BagjbQgSQF3fHtg7U5A/viewform) for fermi estimates.

> Fermi (back of the envelope) estimate: Founders Pledge has about
> 1,600 members. What is the probability that Jeff Bezos will sign the
> Founders Pledge in the next five years? How did you arrive at this
> estimate, and what are your main uncertainties? [200 words max] *

## Enrico Fermi

https://en.wikipedia.org/wiki/Fermi_problem

> An example is Enrico Fermi's estimate of the strength of the atomic
> bomb that detonated at the Trinity test, based on the distance
> traveled by pieces of paper he dropped from his hand during the
> blast. Fermi's estimate of 10 kilotons of TNT was well within an
> order of magnitude of the now-accepted value of 21 kilotons.

https://physics.stackexchange.com/a/190920/214354

Fermi, wanted to calculate the energy content of a blast. He stood
apparently 16km away. Threw some paper from a height of 6m and they
moved 2.5m due to the blast.

E = PxdV

dV = Volume of shell x travel distance = 2 Pi R^2 x 2.5m = 4 10^9 m^3

Pressure felt by Fermi, P = inbetween 100N to 10^4N x 1m^2. Geometric
mean is 10^3N/m^2.

Thus, E = 1KT Multiplied by a factor as the 2.5m is missing several
other contribytions. 

E.final = 10KT, E.actual = 22KT

## Goal

Be in the right order of magnitude roughly factor 10 within. 

- How much is a ford Compact? 20k`$`.

## Tips

[Less wrong Luke answer](https://www.lesswrong.com/posts/PsEppdvgRisz5xAHG/fermi-estimates)

Book: Guesstimation 2.0

1. dare to be imprecise

	> By the spherical cow principle, there are 300 days in a year,
    > people are six feet (or 2 meters) tall, the circumference of the
    > Earth is 20,000 mi (or 40,000 km), and cows are spheres of meat
    > and bone 4 feet (or 1 meter) in diameter.

2. Decompose the problem into smaller parts that can be multiplied

3. Estimate by bounding and by geometric mean

	> How much time per day does the average 15-year-old watch TV? I
	> don't spend any time with 15-year-olds, so I haven't a clue. It
	> could be 30 minutes, or 3 hours, or 5 hours, but I'm pretty
	> confident it's more than 2 minutes and less than 7 hours (400
	> minutes, by the spherical cow principle).

	Taking geometric mean and not average and that too AGM not GM...
	
    > So what is the AGM of 2 and 400? Well, 2 is 2×100, and 400 is
    > 4×102. The average of the coefficients (2 and 4) is 3; the
    > average of the exponents (0 and 2) is 1. So, the AGM of 2 and
    > 400 is 3×101, or 30. The precise geometric mean of 2 and 400
    > turns out to be 28.28. **Not bad.**


    > What if the sum of the exponents is an odd number? Then we round
    > the resulting exponent down, and multiply the final answer by
    > three. So suppose my lower and upper bounds for how much TV the
    > average 15-year-old watches had been 20 mins and 400 mins. Now
    > we calculate the AGM like this: 20 is 2×101, and 400 is still
    > 4×102. The average of the coefficients (2 and 4) is 3; the
    > average of the exponents (1 and 2) is 1.5. So we round the
    > exponent down to 1, and we multiple the final result by three:
    > 3(3×101) = 90 mins. The precise geometric mean of 20 and 400 is
    > 89.44. Again, not bad.
	
	
4. Sanity check your answer

5. Use Google as needed. 


## Deliberate practice #1

1. How many new passenger cars are sold each year in the USA?

- 10% to 50% of people with cars trade in their cars

	- Max. Number of cars in the US currently = 300mil (adults) -
      74mil (kids) = 200mill
	- Min. Number of cars in the US currently = 100mil (usually every adult
      seems to have a car, so I would say half of that should be the
      lower bound)
	- AGM = 300mil (doesn't sound right) So we take normal Mean =
      150mill
	
	
	So, 10% to 50% i.e., 30% (AGM) of people with cars trade in their
    cars = 30% x 150mill = 45mill cars.
	
	
- Fresh driver license per year--> [300000](https://www.statista.com/statistics/191653/number-of-licensed-drivers-in-the-us-since-1988/)

- total 46mill new cars?

	Answer: 

	> Now, I Google new cars sold per year in the USA. Wikipedia is the
	> first result, and it says "In the year 2009, about 5.5 million new
	> passenger cars were sold in the United States according to the
	> U.S. Department of Transportation."

	Factor 10 off, but any answer would be factor 10 off?. That is
	ok. This was your first attempt. 

	**Note**: I missed the key factor that people mostly go for used cars.

## DP #2

Example 2: How many fatalities from passenger-jet crashes have there
been in the past 20 years?


Number of people killed due to flight crashes.

1. How many flight crashes in 20 years 

	From sensationalization, I think 1-3 crash. but lets go for a
    larger upper bound 1-5 crashes per year. AGM = 3

2. How many people die in such a flight crash

	100 people (google)

So my estimate is 3x100x20 = 6000 fatalities.

Actual estimate is 14k (Pretty good boy) --> Luke's estimate of the
true answer. factor 2 off.


## DP #3

Example 3: How much does the New York state government spends on K-12
education every year?

K12 means 5-18 year kids

**Population of new york State**

50 states in US 

500 cities, So avg population of new york state --> 300mil/50 = 6mil

New york is known to be densely populated, So let's take AGM of 1 and
10 times average pop = 3x6mil = 18mil.

**ratio of number of k-12 kids to pop**

300mill vs 74 mil is the ratio of pop vs kids, We'll assume same ratio
and get kids.

74/300 = 0.24

**% of kids that study at govt. schools.**

Say 50%

**Avg. cost of per student per year**

Salary of teacher =40k`$`- 100k`$` = 75k

40 kids require say 1 teacher's cost let's say

So, 75k/40 = 1.5k per student per year.

**Note**: Difference between me and Luke was in accounting for costs of
other things needed more than just a teacher, such as infrastructure etc.

**summary**

18mil new yorkers x 0.24 kids x 50% from govt x 1.5k`$` per student
per year = 5000k people --> 2500k people --> 3750mil

Actual answer 50b, factor 10 off. ;) But Luke seems to have done quite well.


## DP #4

**Example 4:** How many plays of My Bloody Valentine's "Only Shallow" have
been reported to last.fm? Number of times "My Bloody Valentine's" "shallow" has
been played? 

This is so hard...

How popular is bloody valentine?

When was it released?

Ho popular is last.fm

What are the approaches?

1. Find a similar song and get a baseline?

2. Start with population

Hmm, 2 seems more feasible.

**What is Last.fm**

> Last.fm builds a detailed profile of each user's musical taste by
> recording details of the tracks the user listens to, either from
> Internet radio stations, or the user's computer or many portable
> music devices. This information is transferred ("scrobbled") to
> Last.fm's database either via the music player (including, among
> others, Spotify, Deezer, Tidal, MusicBee, and Anghami) or via a
> plug-in installed into the user's music player.

Once a user gives access, Last.fm can scrobble and track songs. Until
then it cant. --- https://www.youtube.com/watch?v=ijq1M1QWz6E

**% of people who have heard this song**

Ok so on youtube I have rarely seen songs with 1b views (It's one of
the best songs or viral songs that get the maximum listens). But that
is just on Youtube. Youtube has 2b unique listeners now.

2Bil is our ultimate max for sure. 1bil already seems ultimate. Half
of that lets say is unique users, 500mil is new max. But this song is
not that popular like Gagnam style or BTS, I haven't heard it. For
example I see an upcoming artist make 10-20m listens on youtube even
for his top songs. So I would say 1 to 15 million unique users.

AGM = 1.25 x 10^6 x 3 = 5m unique people.

Song was listed at number 27 in the united states.

**% of people who have tracked this song on Last.fm compared to all
other platforms**

So Last.fm seems to be everywhere and can track spotify youtube and
everywhere you listen to music, provided you give access to it.

Let's use spotify users giving access to last.fm as a proxy for this.

Number of Spotify users is: 150m - 200m including the people listening
to ads

Say 10% seems too many people. 1-5% lets say. And that means... 2.5%


**Number of listens per person per year**

In a year sometimes I listen to a song say 100 times max. That is
roughly the order I remember listening to some songs when I got my
year end. songs that I really like go on loop.

A lower order of it would be 2 times.

AGM --> 1.5 x 10^1 = 15 (actual value 14.14) listens per year per person?

**Number of years of listening**

Last.fm started in 2002 

That means 19 years so far. 

**Additional discounts**

Discount the fact that the song was created in 1992 and usually those
are not as popular --> 1/10

All numbers are calculated as of 2021 and need a discount for avg over
18 years forming a right tailedbell curve somewhere. --> 1/5


**So**

5m unique user listens x 2.5% allowed tracking on last.fm x 15 listens
per person per year x 19 years x 1/10 discount old song x 1/5 discount right
tailed bell curve = 700k reports on last.fm

Actual answer 2m.. Wow factor 3 off. Wow. Especially for a Fermi estimate.

Where was the difference between you and luke?

**for later**

How to calculate with a distribution peaking in the middle?

Perform sanity checks everywhere? and see if it helps your growth

**Lukeprog way off albeit, has some interesting techniques**


Power law method. Apparently a lot of relationships in the world are
governed by the power law. It is "scale invariant".

It is given by y = f(x) = C x^n.

In this case Luke says Plays(rank) = C/rank

Integrate the equation on both sides and you get,

	Total plays = C ln(total tracks) #i.e., tot. ranks = tot. tracks

He knows from wiki that there are 50billion total plays on last.fm and
guesses a 100m songs. Then you get `C = 50bil/ln(100mil) = 2.5bil`.

From here you go back to main eqn. 

Plays(10k rank) = 250k. Off by roughly factor 10.

## DP #5

How safe are planes?

We need a prol

## Actual form question

Fermi (back of the envelope) estimate: Founders Pledge has about 1,600
members. What is the probability that Jeff Bezos will sign the
Founders Pledge in the next five years? How did you arrive at this
estimate, and what are your main uncertainties? 


What is probability that a billionare will sign up to FP in the next 5
years?

- what is the probability of billionares in the past signing up to FP?
   
   
### What we know about FP

4bil in pledged donations, Our 1600+ members include the people behind
industry-leading companies such as Dropbox, Skype, Spotify, Uber, and
Airbnb.

Launched in 2015.

### Modelling an earthquake

### modelling the question

There are 1600 members who have pledged 4 bil since 2015.

So there have been 1600 events of people pledging to FP.

**Way 1**

1. Probability of start up founders joining FP

x companies x founders -> n joined FP --> 

- 

**Way 2**

Probability that JB will sign FP in the next 5 years.

Probability that jb will pledge >8.25 bill in the next 5 years.

Probability that his net worth grows by 38% in the next 5
years. (based on what he did in 2020).

Probability that he figures out more money is neeeded.. currently he
has only manged to give out 700m in 3 years.

Probability that jb will make an open pledge atleast on twitter

Probability that jb take the the giving pledge i.e., public display
saying I will donate atleast 50% of my ownings.

Probability that jb will take the fp pledge? which is >5% but legally
binding?

Probability that people will make him ridicule him more to donate. He
seems to be receiving of that.

Probability that jb will be interested in giving away all of his
money, probability that twitter ridicule, 



Sign FP would mean atleast ready to pitch in 2.55 million shares or
8.25 billion dollars in the next 5 years via FP in a legally binding
pledge. Not to EA orgs or anything. He hasn't even taken the giving
pledge (which is not binding)

Probability that JB will donate min.5% in the next 5 years... But his
track record is pretty good. 2017 asks, 2018 2bil albeit in
homelessness and 2020 10 bil in earth fund commited, also got
divorced, given out 700mill of it in 3 years.

JB will realize about effecitve donating?

There are 200 bilre with 600billion pledged via the giving pledge.

THere are 2755 bilre and only 200 have taken the pledge. 

38% annual growth rate


Probability that JB will make this pledge (look at other billionares
who have made the founders pledge, JB has refused to take the full
pledge like Warren Buffet), So this gives me like bounds


---


**Probability that JB will sign FP in the next 5 years.**

Translated to: Probability that JB will pledge >5% of his Amazon
shares in the next 5 years at FP

= 0.05% (see below)

1. Probability that JB will pledge >5% of his Amazon shares (>8.5bil)
   in the coming 5 years:

	5% lower bound considering, 
	
	He has not done anything since he became a billionaire in 1998
    until 2017 and suddenly all his philanthropic activity
    starts. This could just be a PR stunt or to create a halo effect
    on Amazon or to get people off his back about his lack of
    philanthropic activity in the order of billions of dollars. I
    think he will be struggling to give away the whole 10 billion he
    has pledged so far. He has given away only 700million of the 10
    billion in 1.5 years.
	
	50% upper bound considering,
	
	He has averaged 38% growth per year, in the last 5 years and it
    doesn't look like it is slowing down. He would want to pledge
    something to atleast get people off his back.
	
	GM{5%,50%} = 15%	
	  
  
2. Probability that JB will pledge that at FP (which is a binding
   contract):
   
   GM{0.1% to 1%} = 0.3%
   
   None of the billionaires (except Dustin) seem to have taken the
   Founders pledge. The 100 billionaires seem to want to start their
   own Fund and work with it under their rules (Mark Zuckerberg,
   Warren Buffet, Bill and Melinda Gates etc.). I can't imagine why
   Jeff Bezos would be any different and come to FP. He has in the
   past committed openly and I think that is the likely scenario.

Total Probability = 0.05%
	
[1]: https://www.marketwatch.com/story/is-this-amazons-attempt-at-reputation-laundering-5-unanswered-questions-about-jeff-bezos-philanthropy-11612798076
[2]: https://www.celebritynetworth.com/richest-businessmen/ceos/jeff-bezos-net-worth/
[3]:https://www.aboutamazon.com/news/company-news/email-from-jeff-bezos-to-employees
[4]: https://en.wikipedia.org/wiki/The_Giving_Pledge
[5]: https://en.wikipedia.org/wiki/The_Giving_Pledge
[6]: https://math.stackexchange.com/questions/184115/in-need-of-tips-suggestions-when-to-add-or-multiply-probabilities

	
	
3. Probability that his net worth increases by 5% atleast.

	GM{70-90%} = 79%
	
	I think if his Net Worth decreases he might not want to give more
    and protect his assets first. And he could thus be petty about
    these things being conditional on whether he gives more money or
    not. If this was not the case, he should have atleast in some form
    taken the Giving Pledge.

	

	
   
   
   
   

**What we know:** In 2017 he asked for ideas after 20 years of
becoming a billionare. In 2018 he pledged 2bil for homelessness and
education. In Jan 2019 he got divorced. He went down to 114b as of
July 2019 (I think due to the divorce as the price of Amazon shares
remain particularly stable from Jan 2019 to March 2019). In 2020
february he pledged another 10bil for earth fund of which 700mil has
been disposed. Only later that year His earnins soured.

**Note:** he also has other investments other than just the shares which
roughly amount to 75% of his earnings).


**JB and the Giving pledge:** The giving pledge started already in
2010 Jeff Bezos notably didn't do anything about it until now. He
became a billionare in 1998 and a 10 billionaire in 2010 and a 100bill
in 2018. He grew from Dec 2017 to July 2018 from 73bil to 150bil.

**What we know about his peers:** Elon musk, Bill and M gates, Warren
buffet and 200 other billionares out of 2000 billionares have all
taken the giving pledge (where you are expected to make an open and
non-binding commitment to donate atleast half of your earnings).

Aug 2010 had 40 pledgers, April 2011 69 pledgers, May 2017 158
pledgers, 2020 with 210 or so pledgers.

Bill and melinda gates foundation seem to have 50billion in net assets
and spend about 5-6 billion a year. This also includes Warren Buffets
contribution to the foundation. It's hard to get rid of money it looks like.




What we don't know: Why he did this pledging, was it because of
pressure, Was it because he was gaining on tax deductions? Was it a
strategic decision to create a halo effect and get people off his back
or was it because he is genuinely concerned and has the understanding
of that of the great WB?

   


## Score

| No. | Type              | factor off | factor off luke or other | Pot. Issue    |
|-----|-------------------|------------|--------------------------|---------------|
| 1   | new cars          | 8-o        | 0.1-u                    | missed factor |
| 2   | flight fatalities | 2-u        | 2-u                      | -             |
| 3   | k-12 education    | 12.5-u     | 0.06-o                   | missed factor |
| 4   | last.fm listens   | 3-u        | 10-u                     | -             |
| 5   |                   |            |                          |               |


## things to consider

1. Other ways of calculating the same thing as an exercise in getting
   besser. Do make thinking more stronger.

## Less wrong explanation

1. [Less wrong Luke answer](https://www.lesswrong.com/posts/PsEppdvgRisz5xAHG/fermi-estimates)
