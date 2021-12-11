## Question

**Lely annual report**

The sales department of Lely has the job to give an overview of the
performance of the company based on the data available. The end of the
year is coming and **management is asking for some insights to their
products**. Based on the following tables information shall be retrieved
and combined in order to provide a nice annual report about the sold
robots.   

**Management expects at least an answer to the following questions:**

1. How much revenue did we make per country?  
2. How much revenue did we make per robot per country?  
3. How much damage (in €) was reported per robot per year?  
4. Management also feels there’s something missing in their
report. Which data or analysis is, in your opinion, missing and
how could we possibly improve the report for coming years?  
5. Please use the graph and other information below to answer
question 5.1 to 5.4.   

![pic5question](../images/indrews/lely-question-5-pic-1.png)



**Mean time between failure, total averages:**
Vector: 11,2  
Astronaut: 11,1  
Collector: 4,4  

robot is not able to function in an appropriate way. Since we are
A mean time between failures (MTBF) is a way to describe how often a
trying to reduce these failures, we are using this metric to report on
the performance of our systems.   

Please give you opinion as an analyst about the following statements
made by your stakeholder; please give at least one remark per
question:  
1. “It’s a bit close, but since Vector has the highest overall
   MTBF it is our best functioning system”  
   might be a reason for that?”  
2. “In some months the collector is performing really well, what
3.  “Can we improve the visual so we prevent misinterpretation”?  

**Our expectations:** We would like you to use Python for the first
three questions in this assignment, feel free to use any package you
like. All data as provided below may also be found in the provided CSV
files (incidents.csv, sales.csv, and robot_information.csv). Please do
not focus on visually appealing graphs. We are looking for a
combination of **technical skills, choice in graph type and ability to
reason around Analytics**. Please provide an explanation for the
steps you made to answer the questions.

## Solution and thinking

> The end of the year is coming and management is asking for some
> insights to their products. Based on the following tables
> information shall be retrieved and combined in order to provide a
> nice annual report about the sold robots.


> How much revenue did we make per country?

What would the management be interested in knowing? they want to know
if there is a problem and where to work on?

I think they will be interested in seeing the revenue total per robot,
total per country, and how it varies. Is there a poorly performing
country?

**Question 4**

> Management also feels there’s something missing in their
> report. Which data or analysis is, in your opinion, missing and
> how could we possibly improve the report for coming years?


I think the following would be nice to have and report on: 

**Profit revenue etc.**

1. Profit (in addition to Revenue) with

   - time (weeks years months) (last year vs this year)
   - country (with state or province information)
   - robot type
   
2. Average revenue generated per dairy farm due to selling robots
   
   - over time
   - per country
   - per robot type
   - per "new" and "old" dairy farm (filter)
   

3. What seems to be given is Price of the Robot, but I imagine there
   are some discounts, which are not perhaps captured with this data
   and the revenue could thus be misrepresented.
   
4. Missing data i.e., other robots (and countries) and their data are
   missing
   
**Damages**

1. MTBF data and also average downtime of robots when they end up with
   failure would be interesting to know about the performance of the
   sold robots.

2. Above metrics over time, per country, per robot type etc.

3. Average number of failures, and average downtime per robot
   per month, per week , per year (with filters across country).

4. Damages (It is not clear what this represents and who it's supposed
   to affect), such as does it take into account manpower, opportunity
   costs etc. 
   
**Statistics**

Mean value alone does not tell the whole story.

In some cases like avg. number of failures it might be good to know
the spread of this metric, i.e., Mean, Median, 25th 75th 99th
percentile etc. 

What else would we like to know about the robots sold?

Profit perhaps? filters on country, type of robot
perhaps there were dicounts given, more accurate estiamte on reventue?

How much money do robots alone make compared to other systems? such as
advice, management systems

As someone interested in sales, I would also like to see who are
biggest customers are? What are the cutomer segements with filters on
country and robots and other things.

Which months are the sales high? 

Year over year information

---

**Question 5**

**You want to reduce the failures** Also want to reduce number of
failures and perhaps even downtime

So you want to see first of all how many happen, how long of a
downtime happens. Now coming to per machine id, you want to know how
often this happens in a year (frequency aka MTBF) and understand the
spread, i.e., average breakdown frequency per machine id.

MTBF --> You take a particular type of robot, seems to be per machine ID

**It’s a bit close, but since Vector has the highest overall MTBF it
is our best functioning system**

"best functioning system"? hmmm. So It's literally 

Assuming MTBF is the right metric, I think this is where a 95% CI
would be useful to actually see if Vector MTBF can be said it is
better, taking into account all variations. MEAN DOESNT TELL THE WHOLE
STORY.

https://www.mathsisfun.com/data/standard-normal-distribution-table.html



| Astronaut | Vector   | Collector |                     |
| --------- | -------- | --------- | ------------------- |
| 10        | 10       | 2         |                     |
| 11        | 9        | 3         |                     |
| 11        | 11       | 2         |                     |
| 11        | 10       | 2         |                     |
| 12        | 9        | 9         |                     |
| 11        | 12       | 10        |                     |
| 11        | 10       | 2         |                     |
| 12        | 20       | 2         |                     |
| 11        | 10       | 10        |                     |
| 11        | 11       | 2         |                     |
| **11.1**  | **11.2** | **4.4**   | **mean**            |
| **0.57**  | **3.22** | **3.66**  | **3s**              |
| 0.38      | 2.14     | 2.43      | **Margin of error** |
| 11.48     | 13.34    | 6.83      | **Mean + MOE**      |
| 10.53     | 7.98     | 0.74      | **Mean – MOE**      |

Note: this is not the full story, there is still error unaccounted for
which is due to intra month variation is one of the things unaccounted
for to say the least.


I would also further do a bit more granular variations to understand
the repeatability and reproducibility of such devices? i.e.,
Measurement spread.

Repeatability (repeated conditions for same equipment).

Reproducibility (spread within differetn conditions, type)


To make this estiamte better, we need could try to increase the amount
of data we have (more months or start looking at it for the entire
year), that way you can improve your confidence (even if the error is
purely random)

**In some months the collector is performing really well, what might
be a reason for that?**

1. Data collection issue?

2. I have a suspicion that perhaps failure is associated with usage
   and this usage data is missing. It could be that you use less of
   collector during those months. 'Why the usage went down in those
   months' is a follow up question, 
   
   
   usage --> more cows producing milk, more machines are not working,
   demand or supply somehow affecting it (would need to talk to a
   domain expert), running more hours for somereaon (for example 24/7
   vs 12 hrs), 
   
   
3. Perhaps a lot of new collectors or recently repaired were installed
   at that time and new collectors usually have a large MTBF in the
   beginning?
   
   So look at ratio of new vs old during that time perhaps?
   
4. Operator issue? something fundamental happened?

5. New software patch? or a particular software upgrade?

6. hardware upgraded recently

Is any part of this seasonal, other than deamns and supply

1. hardware issues (lack of oil or regular maintenance)


**Can we improve the visual so we prevent misinterpretation**   

Which misinterpretation? It would be nice to have some usage
statistics along

Plot the spread along with the mean value to show the estimated
region of the mean.

Reduce granularity to year and look at things along with CI. Just
looking at Average Mean time between failure for the entire year is
not good enough.

Perhaps a scatter plot to show Usage vs MTBF? to get deeper into
understanding MTBF

Also additionally I would like to a bit more granular filters
	- customer segment (number of people or cows working in a farm to number of robots)
	- number of incidents per robot unique id per year, per month
	- country
	- robot type
	- new vs old
	- just new
	- just things which are x months old
	
can you use other metrics? avg downtime per robot? this might be
interesting to minimize as well

avg cost per downtime

For all this we want to look at 
