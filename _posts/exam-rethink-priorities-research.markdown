## Question 1

In the fictional country of Examplestan, there is a disease called
Exampletosis that is known to impair IQ. Based on a meta-analysis of
studies, we know that someone with an Exampletosis blood level of 10
suffers a 4 point IQ loss relative to someone with 0 blood level,
whereas going from a blood level of 10 to 20 results in an additional
2 point IQ loss, and each 10 point increase in blood level after 20
results in an additional 1 point of IQ loss.

Study 1 estimates the effect of treating Exampletosis in the northwest
region of Examplestan and finds they can reduce the average blood
level of Exampletosis from 20 to 5 for 150 people. They calculate a
cost-effectiveness of $500 to $1000 per IQ point improvement depending
on cost assumptions made.

Study 2 looks at a similar effort in the southeast region. They note
that they can reduce the level of Exampletosis from an average of 40
points to an average of 20 points among a total of 200 people for a
total cost of $400,000.

Study 3 looks at another effort in the far south region and finds an
average reduction of blood levels incidence from 20 to 15 for
$40,000. Study 3 starts by analyzing 70 children, but due to
significant attrition the endline results only analyze 25 children.

The Example Foundation is considering making a grant to fund
additional/marginal work in one of these three regions and wants to
maximise the number of IQ points saved per dollar spent. Based on
these three studies, what would you conclude about where the Example
Foundation should target their funding? What assumptions have you made
and what are your uncertainties?



## Answer


**Notes on question**

Exampletosis --> IQ

10 blood level IQ loss vs 0 blood level IQ loss --> 4 IQ point loss. 

BL --> IQ points

0 --> X IQ points

10 --> X-4 IQ points

20 --> X-4-2 IQ points

30 --> X-4-2-1 IQ points

40 --> X-4-2-1-1 IQ points

**Study 1:** NW of Examplestan 

*Estimate*: 20 to 5 BL for 150 people

Cost-effectiveness: 500$ to 1000$ per IQ point (based on *assumptions*)

**Study 2**: SW region

*Estimate*: avg of 40 BL to avg of 20 BL among 200 people 

cost - 400k$

**Study 3**: Far south region

*Estimate*: avg reduction 20 to 15 BL for 40k$

70 children to 25 children attrition rate.

**Dimension of interest**

*Maximize:* IQ points saved per dollar spent

**Calculation**

Cost-Effectiveness study 1:  500$ to 1000$ per IQ point improvement

IQ points saved per $ = 0.002 to 0.001

Cost-Effectiveness study 2: 

40 to 20 BL => 2 IQ points improvement p.p => 400 IQ points (200 people)
improvement

IQ points improved/saved per $ = 400/400k$ = 0.001 

Cost-Effectiveness study 3:

20 to 15 BL => 1 IQ points improvement p.p => 25 IQ points (25 is the
final results we have after attrition)

IQ points improved/saved per $ = 25/40k$ = 0.000625

(assuming linear relationship between 10 and 20 BL)

**Conclusion**:

I have some concerns about the studies (listed below) but I think
cost-Effectiveness-wise Study 1 (0.002 to 0.001) is my choice as it
could be 0.002 in the best case and in the worst case 0.001 (I assume
these are like 95% Confidence bands). Just looking at the
Cost-Effectiveness it appears that the grant shall be made to the NW
region of Examplestan.

But I would really like to hold my conclusions on which region to
provide the grant to, without further investigation on the below
concerns.

**Concerns with study 1**: 

Why is there such a huge variation in the Cost-Effectiveness, and
where is the uncertainty coming from?

**Concerns with study 3**:

I feel really wary about such a large attrition (>50%) for study 3,
assuming study 1 and study 2 have no attrition. As a result I am
unsure of what is the cause for reduction in the blood levels. I am
unsure how this is calculated as well.

**Concerns and questions with all studies**

1. I am not sure the above usage of "average" of Blood level is the
   best way. We get here the average Blood level, but depending on the
   distribution of the blood level we could have different total IQ point
   increase.

2. I am really unsure about the [internal validity](https://www.verywellmind.com/internal-and-external-validity-4584479) of each of the
   studies (as there is not much info provided). For all we know there
   could be confounding variables and it is really hard to say
   anything more without additional information.
   
3. I would look at the following aspects to judge the internal
   validity.
   
    1. Randomization (of treatment and control)

	2. Random sample (from a distinct population)

	3. systematic bias (sex, country, education level, recruitment
	strategy, reaches only people actively looking for help)
   
	4. Confounding variables(season, time, historical events or
       anything else)?

	5. Blinding, less imputation, experimenter bias, selection bias
	
	6. Attrition rate from selection until the end for study 1 and 2

	7. Long term effects (does blood levels stay at said value or do
       they change?)

	8. Comparing initial set of people and attrition people and how
       different they are.
   
	9. Replication7
	
	10. Sample size, p-value etc.


4. Does adding more money to a region mean directly result in
   additional IQ points saved?
   
5. Are there plans to conduct follow up studies in these regions?
   
## Question 2

If you were in charge of investigating whether mercury poisoning is a
problem area worth prioritizing, what steps would you take to
determine the cost-effectiveness of interventions to address mercury
poisoning and who the best organizations are working in the area? (Do
not actually calculate anything, just list the research process you
would do).


## Answers


1. Look up the available interventions and organizations that are
   working on it. I would start with google scholar and WHO reports to
   get see a summary of the different interventions in the area. I
   would then identify 3 "best" effective interventions and then
   proceed with the next step.
   
   **Meta**: Identifying "best" interventions means needing something
   like DALYs to compare across different studies. But different
   studies are conducted in different populations and have their own
   shortcomings. I guess the plan is to "best" estimate using these
   pitfalls and clearly mention the shortcomings as done by GiveWell.

2. Understand the scale of the intervention

	- How many people stand to benefit from it, How many people are
      currently being helped. 
	  
	**Meta**: For this I would look up statistics from WHO or papers
    on this if available. Otherwise, I think I need to look for if
    there something skewed in the amount of funding spent by the govt
    or other bodies to the disease burden estimated. For example, in
    mental health, the govt spending in some countries was for mental
    health was not corresponding to the disease burden.

3. Identify organizations working in this area
   
   - promising organizations are those that are transparent, willing
     to cooperate, and have studies that support their decision
     making, existing track record, and spending opportunities
     identified.
	 
4. Before making cost-effectiveness estimates

	- Look at the populations targeted by said organization and their
      characteristics.
	  
	- Look for evidence that orgs giving the intervention,
		- "work"
		- Reaches people intended
		- People use said intervention
		- It works in the "long run"
	
	**Meta**: Ideally we would like all this information from the
    org. But I am not really sure if every org is as approachable. I
    have read in GIVEWELL about big organizations refusing to give
    information or not seeing us research organizations as doing
    anything worthwhile. Not sure how to circumvent this, other than
    to skip the organization for lack of transparency.
	
5. Making cost-effectiveness estimates

	- Identify costs
	
		- costs to buy materials for intervention
		- costs of shipping and delivering
		- Resources contributed by volunteers, government such as time
          of staff, materials, space etc.
		- salaries of staff
		
	- look at prior estimates to determine DALY 
	
		- account for uncertainties as a result of difference from RCT/study
          to current target population
		  
	- there could be other benefits such as from preventing non-fatal
      cases and hence having short-term impact, but we shall exclude
      these as they are hard to calculate (even for AMF).

	- I would not stop at just the Cost-Effectiveness estimate. I
   would also look at Scalability, ability to absorb funding by each
   organization.

6. Scalability and neglectedness

	- current available funding
	- expected funding
	- Spending opportunities identified

7. Make a report and a Cost-Effectiveness google sheets for people to
   read and understand your research and uncertainties.
