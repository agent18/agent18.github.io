---
layout: post
comments: true
title:  "A naive analysis on if EA is Talent constrained" 
date:    12-02-2020 
categories: posts
tags: DP, feedback, examples
permalink: /:title.html
published: false
---

## Introduction (never done)

I am having a hard time evaluating what I am supposed to be doing in
my career. My biggest source *time*

With this essay I personally try to take as many digs at 80khours as
possible whilst accomplishing that they were so wrong about the TC
debate.

## Definitions(done)

We are going to be primarily dealing with the term "Talent
Constrained". To avoid confusion we try to understand what it is
first. 80khours defines TC in "[Why you should work on Talent
gaps](https://80000hours.org/2015/11/why-you-should-focus-more-on-talent-gaps-not-funding-gaps/#what-are-talent-gaps)" (Nov 2015) as,

> For some causes, additional money can buy substantial progress. In
> others, the key bottleneck is finding people with a specific skill
> set. This second set of causes are more “talent constrained” than
> “funding constrained”; we say they have a “talent gap”.

Ok! A cause is TC if finding people with specific skill set proves to
be difficult. The difficulty I assume is in the lack of of those
skilled people, and not some process/management constrain[^3]. [EA
Concepts](https://concepts.effectivealtruism.org/concepts/talent-constraints-vs-funding-constraints/), clears this confusion up with a better worded "example":

> Organization A: Has annual funding of $5m, so can fund more staff,
> and has been actively hiring for a year, but has been unable to find
> anyone suitable... Organization A is more talent constrained than
> funding constrained...

**Note**: In this post, discussions are focused on "Orgs that are TC"
and not "Causes that are TC". When I am told that AI strategy is TC
with the lack of "Disentanglement Research" (DR), I don't know what to
do about it. But if I know FHI and many other orgs are TC in DR, then
I can plausibly get skilled in DR and apply to close the talent
gap. So looking at causes for me is less helpful and less concrete and
is not what I have set out to uncover.

<!-- needs repair in english but content ok-->

## Why I think EA is TC (done)

EA has been and is talent constrained, according to surveys made by
80khours and CEA since 2017. Several organizations seem to think so in
these surveys: [2017 survey](https://80000hours.org/2017/11/talent-gaps-survey-2017/), [2018 survey](https://80000hours.org/2018/10/2018-talent-gaps-survey/#appendix-2-answers-to-open-comment-questions), [2019
survey](https://forum.effectivealtruism.org/posts/TpoeJ9A2G5Sipxfit/ea-leaders-forum-survey-on-ea-priorities-data-and-analysis). In all the surveys EAs on average claim to be more Talent
Constrained than Funding constrained. For example in 2019 EAOs
reported feeling more (3 out of 5 rating) Talent Constrained and less
(1 out of 5 rating) Funding Constrained[^11]. More details in the
footnote [^1].

80khours doesn't seem to have changed it's position on this matter
since 2015. 80khours suggests that we should focus on providing talent
to the community rather than ETG in ["Why you should focus on talent
gaps and not funding gaps](https://80000hours.org/2015/11/why-you-should-focus-more-on-talent-gaps-not-funding-gaps/). They explain that in AI Safety, the
funds seem enough as per the evaluation of Open Phil and there are
people who are ready to donate even more funds, but think there isn't
enough "talent pool" (back in 2015)[^12]. More posts such as ["Working
at EAO](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/) (June 2017), ["The world desperately needs AI
strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/)[^16] and "[Why operations
management is the biggest bottleneck in EA](https://80000hours.org/articles/operations-management/)" (March 2018), continue
to make the case for EAOs being TC.

In Nov 2018, they wrote a post to clarify any misconceptions regarding
the understanding of the term TC: ["Think twice before talking about
Talent gaps"](https://80000hours.org/2018/11/clarifying-talent-gaps/). 80khours informs us that EAOs are not TC in general
but are TC by specific skills. Some examples being, people capable of
Disentanglement Research in Strategy and Policy (FHI, OpenAI,
Deepmind), dedicated people in influential government positions
etc... Great! The claim becomes narrower: EA is TC in specifically
X. So what is this X?

## Where is the EA specifically TC (done)

There seem to be a list of posts from 80khours from which we can
gather where EA is specifically TC.

- Surveys ([2017](https://80000hours.org/2017/11/talent-gaps-survey-2017/), [2018](https://80000hours.org/2018/10/2018-talent-gaps-survey/), [2019](https://forum.effectivealtruism.org/posts/TpoeJ9A2G5Sipxfit/ea-leaders-forum-survey-on-ea-priorities-data-and-analysis))
- Bottlenecks in problem profiles ([Shaping AI](https://80000hours.org/problem-profiles/positively-shaping-artificial-intelligence/), [Working in an EAOs](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/))
- Priority career paths (in "[High Impact Careers](https://80000hours.org/articles/high-impact-careers/)") 
- Bottleneck hype posts ([AI strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/), [Operations](https://80000hours.org/articles/operations-management/))

**The surveys** from 2017 to 2019 that informed us that the EA Orgs are
TC, also provide information on "what sort of talent the EA orgs and
EA as a whole would need more of, in the next 5 years?". This question
sounds like a proxy to "Where is EA specifically TC?". 80khours seems
to agree with this proxy approximation of the question in the surveys,
as evidenced [here](https://80000hours.org/articles/high-impact-careers/#our-list-of-priority-paths) and [here](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#what-skills-are-the-organisations-most-short-of). The top 7 results (out of 20 or
so) are below:

|   | 2017        | 2017 (EA)   | 2018       | 2018 (EA)  | 2019      | 2019 (EA)   |
|---|-------------|-------------|------------|------------|-----------|-------------|
| 1 | GR          | G&P\***     | Oper.      | G&P\***    | GR        | G&P\***     |
| 2 | Good Calib. | Good Calib. | Mngment    | Oper.      | Oper.     | Mngment     |
| 3 | Mngment     | Mngment     | GR         | ML/AI      | Mngment   | H. GPR\*\*  |
| 4 | Off. mngers | ML/ AI tech | ML/AI      | Mngment    | ML        | Founding    |
| 5 | Oper.       | Movt. build | H. GPR\*\* | Hustle GPR | Econ/math | Soc. Skill  |
| 6 | Math        | GR          | Founder    | GR         | HighEA\*  | ML/AI       |
| 7 | ML/AI       | Oper.       | Soc. skill | Founding   | H. GPR    | Movt. Build |

\* High level overview of EA  
\*\* The hustle to really figure out what matters most and set the
right priorities  
\*\*\* Government and Policy 

Although some of the "talents" are down right vague, the rest of them
seem to ring a bell with me as to what they could mean. For example
when I think of GR, I think of a Generalist Researcher in Open Phil or
GiveWell, whereas when I think of "hustle to really figure out what
matters" or "one-on-one social skills", I have 0 examples in mind and
have no idea what in the hell they are talking about. As a result I
can't do much with these vague descriptions and am forced to skip it
as I am unsure how to interpret them.

Another way to arrive at or to supplement this list, is to look at the
**problem profiles** and check what the bottlenecks are. For example, in
the [profile on shaping AI](https://80000hours.org/problem-profiles/positively-shaping-artificial-intelligence/) (March 2017), we see that 80khours
calls for people to help in AI technical research, AI strategy and
policy, Complimentary roles and, Advocacy and capacity building. So
basically EVERYTHING IN AI, except ETG is TC (it appears). In the
problem profile on [GPR](https://80000hours.org/problem-profiles/global-priorities-research/#what-is-most-needed-to-solve-this-problem) (July 2018), 80khours suggests that they
mainly need researchers trained in math econ and phil etc... Also
needed are academic managers and operations staff. Is it just me or is
the EA TC in "general"? Like when researchers in econ etc...,
operations and managers are in shortage in a GPR org and an AI org,
then who else is left?

In the post on [High Impact Careers](https://80000hours.org/articles/high-impact-careers/#why-did-we-choose-these-categories) (August 2018), the **priority
career paths** aka TC paths according to 80khours, are research and
policy work in AI safety, biorisk, EA, GPR, grantmaking, nuclear
security and institutional decision making.

> In brief, we think our list of top problems (AI safety, biorisk, EA,
> GPR, nuclear security, institutional decision-making) are mainly
> constrained by research insights, either those that directly solve
> the issue or insights about policy solutions.

<!--- AI strategy and Policy research
- AI safety technical research
- Grant maker focused on top areas
- Work in effective Altruism orgs
- Global priorities researcher
- Bio-risk strategy and policy
- China Specialists
- Earning to give in quant trading
- Decision making psychology research and roles-->

Some **hyped posts** exist as well for operations and AI Strategy
atleast:

- [The world desparately needs AI strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/) (June 2017)

	Here, other than the title, I didn't really understand the
    "desperate need for AI strategists" as Miles nor Rob seem to help
    the listener understand the TC. We might have to rest on the
    shoulders of these giants as they are expected to have better
    insight into the problems.
	
- [Why operations management is one of the biggest bottlenecks in
  effective altruism](https://80000hours.org/articles/operations-management/#which-traits-do-you-need) (March 2018)
  
  80khours updated this post saying that the post is "somewhat out of
  date", and that the job market has changed over the last year. Ok
  these things happen.
  
In conclusion, the surveys say GRs, ML/AI people, GPR people and
movement building are TC (2019). The problem profiles say that GPR and
AI is completely TC (2017,2018). Whereas the High-impact-careers post
says that research insights are the most needed (2018). Is it research
alone? or is it much more? They do look like contradictions but we
move on with the key message that all these things listed could be
potentially TC.

## Let's help the world  out

I have been using 80khours since 2017 and have read almost all their
posts, spent weeks after weeks reading them to figure out what I
should be doing in life. They seem to have done a ton of research and
put out many many posts for us readers to benefit from. In the process
they have made a lot of claims, as shown in the previous section which
are hard to verify as we don't have the insight, contacts or the data
that 80khours is exposed to. Unfortunately, 80khours doesn't seem
approachable other than through coaching (which is only for the
ELITE), comments sections are pretty empty, and I don't know of any
other sources doing this sort of research and coaching people[^4]. So
being as low IQ as I am, I formed the impression as shared by
brother [EA applicant](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really):

> Hey you! You know, all these ideas that you had about making the
> world a better place, like working for Doctors without Borders?
> They probably aren’t that great. The long-term future is what
> matters. And that is not funding constrained, so earning to give is
> kind of off the table as well. But the good news is, we really,
> really need people working on these things. We are so talent
> constrained...--- [EA applicant in the EA Forum](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really)

And looking at the *276 upvotes* this post got (*the highest ever
votes in this forum*), it might appear that a "lot of people" share
the sentiment that EA could potentially be seriously TC (as per the
list in the previous section).

But are these claims true? Can you test them? What do they mean? Maybe
they meant something else? Are you able to verify them with atleast
one example? Did 80khours try to generalize too much?

Until I stumbled upon EA Forum just 2 weeks back (by accident), the
word of 80khours was the word of God for me. Finding this one
particular post seems to have grounded me and brought me to reality:
"[After one year of Applying for EA jobs](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really)". It opened a pandora box
of evidence (which I am really really grateful for). Without further
ado the ANTI-THESIS.

## EA doesn't look to be TC

<!--In the previous sections it is clear that GR is quite sought after
in all three surveys
([2017](https://80000hours.org/2017/11/talent-gaps-survey-2017/),
[2018](https://80000hours.org/2018/10/2018-talent-gaps-survey/),
[2019](https://forum.effectivealtruism.org/posts/TpoeJ9A2G5Sipxfit/ea-leaders-forum-survey-on-ea-priorities-data-and-analysis)). In
fact in 2019 it climbed all the way to the top implying that it is
"most" TC. Furthermore in their recent post on [High Impact
careers](https://80000hours.org/articles/high-impact-careers/) (Aug
2018), they suggest that research insights in EA, GPR etc... are some
of the most constrained. But when we look at the [recent hiring round
of Open
Phil](https://www.openphilanthropy.org/blog/reflections-our-2018-generalist-research-analyst-recruiting)
the claims don't seem to hold water. --> 

**GR in GPR**

Researchers in GPR are claimed to be constrained. GR's also stand on
top of the survey lists shown before for 2019. Yet, Open Phil seems to
paint a very different picture. For the hiring round by Open Phil
(started in Feb 2018 and ended in December 2018) they wanted to hire 5
GRs. They report that more than a 100 strong resumes with missions
aligned to that of OP were received. 59 of them were selected after
remote work tests and went into an interview. Of this, 17 of them were
offered a 3 month trial and 5 selected in the end. "Multiple people"
they met in this round are claimed have potential to excel in roles at
Open Phil in the future. Open Phil does not seem to feel that there is
a lack of skilled people. It appears that they had plenty to choose
from and that they have found suitable candidates.

A similar case is observed with EAF. In [EAFs recent hiring round](https://forum.effectivealtruism.org/posts/d3cupMrngEArCygNk/takeaways-from-eaf-s-hiring-round)
(Nov 2018) to hire 1 GR ([grant evaluator](https://ea-foundation.org/open-position-research-analyst/)) and 1 operations
personnel, *within just 2 weeks, 66 people applied to this EAO which
is in a [non-hub](/what-should-I-do-in-eao.html)*. These 66 trickled down to 10 interviews after
work tests, 4 were offered trials and 2 were selected in the end. No
TC in GR here either.

Would Open Phil like to hire more GRs? For sure, but they don't have
the capability to deploy such a pool of available talent, they
say. They seem to be constrained by something else, something not
"talent". Perhaps process or management or mentorship constrained
etc...

---

**AI Strategy and Policy**

Researchers in AI Strategy and Policy are also claimed to be
constrained. The surveys echo the same as well. But [Carrick from
FHI](https://forum.effectivealtruism.org/posts/RCvetzfDnBNFX7pLH/personal-thoughts-on-careers-in-ai-policy-and-strategy) (Sep 2017) suggests that AI Policy implementation and research
work is essentially on hold until Disentanglement Research
progresses. And that even *"extremely talented people" will not be
able to contribute directly* until then. Similar to Open Phil,
institutional capacity to absorb and utilize more research in Strategy
is constrained according to him.

This means that *except for the TC in Disentanglement research
(DR)*---where there seems to be large demand and if you meet the bar,
it appears you will get a job---there seems to be no sign of TC in
Strategy and Policy, at the moment. But in the future there would be a
need for "a lot of AI researchers" once DR progresses, Carrick
expects. 

It's been 2.5 years since the post by Carrick and as late as Nov 2018,
[80khours continues to cite this article](https://80000hours.org/2018/11/clarifying-talent-gaps/). This seems to suggest
that not much might have changed. I have requested Carrick to write a
reboot of this and hopefully he can further clarify the TC or lack
there of.

<!--**Note**: *This article by Carrick was written in September 2017
and I am not sure what is the update in Feb 2020. Most articles on [AI
strategy and Policy are written in
2017](https://80000hours.org/topic/priority-paths/ai-policy/). As late
as November 2018, this article by Carrick is still being [cited by
80k](https://80000hours.org/2018/11/clarifying-talent-gaps/). This
suggests that they might not have changed "much". But they claim in
the future they would need "a lot of AI researchers" working on
this.*-->

---

**Research and Management staff in EA orgs**

The co-founder and board member of Rethink Science seems to suggest
that both senior and junior staff for Rethink Charity and Charity
Science were not hard to find aka not TC.

> I’ve certainly had no problem finding junior staff for Rethink
> Priorities, Rethink Charity, or Charity Science (Note: Rethink
> Priorities is part of Rethink Charity but both are entirely separate
> from Charity Science)… and so far we’ve been lucky enough to have
> enough strong senior staff applications that we’re still finding
> ourselves turning down really strong applicants we would otherwise
> really love to hire.---[Peter Hurford says in the 2019 survey](https://forum.effectivealtruism.org/posts/7bp9Qjy7rCtuhGChs/survey-of-ea-org-leaders-about-what-skills-and-experience?commentId=ySRBeBocRz7oSahAC)

**Note**: When Peter says junior staff, I think of operations and
researchers. For senior staff I think of positions like Director,
Manager etc... based on the staff of Rethink Charity.

The Life You Can Save's Jon Behar also agrees with Peter. He adds that
it's not the lack of talent but the lack of money to add new staff
which is the bottleneck for TLYCS.

---

So far we have seen Open Phil, EAF, Rethink Charity, Rethink Science,
TLYCS, FHI all seem to be not TC, except for one concrete skill of
Disentanglement Research.

Maybe comment on Orgs are hiring slow they remain small...

Also maybe comment on 80ks extenstion of definition with: TC still
means that 5-10% are selected.

Competitive could still mean TC.

Also comment on TC and why did surveys fuck up?

**Conclusion**

Conclude with they are not TC. Now it still stands if we should work
in these situations, and for that competitiveness plays a role. 

80khours sprays bullshit suchas TC does not imply non competitiveness.
Try to give a rebutt to it..

## Discussing the anamolies

Why did the survey then say it is TC

No idea.. perhaps there was some misunderstanding or maybe the orgs
were also considering TC to be MC PC and everything else.

## Qualms with 80khours

I am really frustrated with 80khours. Atleast to my knowledge they
have made 4 claims:

- replaceability
- TC
- Pushing CC
- how easy getting a job in EA is 
- They write in english (not numbers)
- They don't think they need to apologise
- very bad explanation:
  Think twice Talent gaps
  Survey 2019 EA work about cash
  
- LAck of decisive advice (saying just about everything)

- bloating a definition to make it useless

- contradiction:
profile on AI says basically everything where as it is somehow TC in
specific areas in AI.

TC not in general but for AI it is in general, for Working in EAO it
is in general.

- lack of updation of posts. 

- Several definitions for TC (god help me)
- repeat posts (not sure what the difference is)

- Mistakes mistakes mistakes

recent hire cost, 

- useless advice

go to the companies and ask them how much donation I would be
irrelavent. BS

- Not one place do they seem to mention the EA forum (My savior)

- how useless ETG is

- untestable claims unless for EA forum:

> In brief, we think our list of top problems (AI safety, biorisk, EA,
> GPR, nuclear security, institutional decision-making) are mainly
> constrained by research insights, either those that directly solve
> the issue or insights about policy solutions.

Look at is-ea-bottlenecked.markdown 

- one of the hardest things to do is to estimate the impact and they
  conviniently leave that out. They get very createive with their
  example giving.

**Other**

- They expect english to convey shit... not numbers

When someone asked that 80khours hsould consider the cost of us
applying and figuring out how much life sucks they literally made a
shitty comment.

Peter Expresses his concern on the bemoaning of ETG. As evidence to
his claim I believe unless I can be a quants trader I am a loser and
that it is better to focus on working at an EAO as a result. And now
even this is turning out to be hard as fuck. And the one org we turn
to for career advice sucks. 

## what this means for me?
## Why is this debate so important

A junior GR at GiveWell was potentially [associated with moving
244k](https://80000hours.org/2016/08/reflections-from-a-givewell-employee/)<span>$</span>(2015) assuming a 10% replaceability. This means
that if he was not replaceable then the amount of money he moved would
be a staggering 2.4m<span>$</span>. This amount should be much more (I
think based on the hype) for longterism oriented folk such as Open
Phil, FHI [etc...](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#what-do-we-mean-by-working-at-effective-altruist-organisations).

TC at GiveWell in GR implies 0% replaceability whereas if it is not TC
then replaceability is a function of the value created by the person
hired and the person who just missed the job. 

Consider A and B applying for a job at an EAO. The top members at the
EAO are able to evaluate A can contribute 500k if he takes up the job
and B can contribute 400k if he takes up the job. For simplicity,
let's assume they produce little or no value if A or B does not take
take up that job.

Total value created for the world if A sits idle at home: 400k  
Total value created if A takes the job: 500k.

So if A works 500k otherwise the world already has 400k. So it appears
that if A put effort he made the world 100k better that is it NOT 500k
better. 

Now imagine the scenario that B didn't exist, i.e., the job is not
replaceable or that the last applicant for the job is miles below
A. Then:

Total value created if A sits idle at home: 0k
Total value created if A takes the job: 500k

With actual numbers of replaceability and value created I can trade
this off to amount of donations, and with that my plan to work on DS
or slog towards an EAO. 

Add how 80khours misleads on this as well. Surprise surprise.

Cite peter and then I think I am done with this...

## How replaceable is GR in actually?

I tried to get data but that didn't seem to work out in this case.
But is this what the world is undergoing? is it true that who ever
doens't get the job has to do something significantly bad ? according
to peter hurford yes, according to his friends yes.


So now that EA is not TC atleast for the type of jobs I was planning
to upskill myself in (GR, AI safety guy), I need another plan. 

I was thinking of working in GiveWell maybe and from there on going
further. Or doing a masters in AI and then finding my way into there. 


## You wont get into EA

Start with 80khours telling people they shouldn't ETG (as it is
pointless). They should focus on 

and maybe list all the people who didn't get in

Orgs are hiring slow they remain small... 

## How I think 80khours misleads everybody

- definitions 

- no examples

- working for the elite

or try to see if you can make that a post the things I have written
earlier.

or maybe it is just better to take mild digs at them... here and
there. 



## Todo

Clean EA doesn't look to be TC

Why is this debate so important?

Run through the whole thing twice... 

I think this is it! 

Qualms is another post

By sunday! common pandian pan indian

Rest goes into another post of what I should do in EAO.

For my life I need TC post, Qualms with 80khours but only what I need
to do in an EAO.. I think it is a separate issue. Wrap it up boye!

## Footnotes

[^1]: 

[^2]: 

[^3]: If 80khours on the other hand suggested that TC included
everything that made it hard to find a specific skillset then saying
it is TC is such a misnomer

[^4]: Somehow I have started stumbling on people who coach for
    money. I need to make a list. There was this guy from fuck who was
    the COO and now is in operations
	
	EAF seems to have
	[here](https://ea-foundation.org/career-coaching/)
	
	EAF has a coach who is in operations Analyst
	https://danielkestenholz.org/coaching/
