---
layout: post
comments: true
title:  "A naive analysis on if EA is Talent constrained" 
date:    12-02-2020 
categories: posts
tags: DP, feedback, examples
permalink: /:title.html
published: true
---

## Introduction

I have been using 80khours since 2017 and have read almost all their
posts, spent weeks after weeks reading them to figure out what I
should be doing in life. They seem to have done a ton of research and
put out many many posts, for us readers to benefit from. In the process
they have made a lot of claims which are hard and time-consuming to
verify as we don't have the insights, contacts or the data that
80khours is exposed to. For example [they say](https://80000hours.org/key-ideas/#global-priorities) "an additional
person working on the most effective issues will (in expectation) have
over 100 times as much impact as an additional person working on a
typical issue". To verify this with one example, I would need
estimates from say Open Phil on the impact of an employee. I tried,
and they are unable to put effort into it at the moment.

Maybe 80k can be asked for clarification directly? Unfortunately,
80khours doesn't seem approachable other than through coaching (which
is only for the stellar). [Comments sections are pretty deserted](https://80000hours.org/articles/high-impact-careers/)
to ask for help, and I didn't know of any other sources doing this
sort of research and coaching for people[^4]. Based on reading
80khours for years I formed the impression as shared by fellow [EA
applicant](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really):

> Hey you! You know, all these ideas that you had about making the
> world a better place, like working for Doctors without Borders?
> They probably aren’t that great. The long-term future is what
> matters. And that is not funding constrained, so earning to give is
> kind of off the table as well. But the good news is, we really,
> really need people working on these things. We are so talent
> constrained...--- [EA applicant in the EA Forum](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really)

And looking at the *277 upvotes* this post got (*the highest ever
votes in this forum*), it might appear that a "lot of people" share(d)
this sentiment that EA orgs could potentially be seriously Talent
Constrained (TC).

A few weeks back I stumbled upon some articles in the [EA forum](https://forum.effectivealtruism.org/)
and to my surprise it appeared that some EA orgs were suggesting that
they were not TC. Until this point I don't think it occurred to me
that 80khours' claims ("EA is TC") could be wrong or lost in
translation or that I should test it. Nevertheless, having seen orgs
say otherwise, it felt like a good idea to dig into it atleast now.

The following article is my naive investigation on if EA is TC. Before
we start going deep into whether EA is TC or not, we must first state
the definition clearly.

## Definitions

We are going to primarily deal with the term "Talent
Constrained" (TC). 80khours defines TC in "[Why you should work on
Talent gaps](https://80000hours.org/2015/11/why-you-should-focus-more-on-talent-gaps-not-funding-gaps/#what-are-talent-gaps)" (Nov 2015) as,

> For some causes, additional money can buy substantial progress. In
> others, the key bottleneck is finding people with a specific skill
> set. This second set of causes are more “talent constrained” than
> “funding constrained”; we say they have a “talent gap”.

So, a cause is TC if finding people with a specific skill set, proves
to be difficult. The difficulty I assume is in the lack of of those
skilled people, and not some process/management constrain[^3]. "[EA
Concepts](https://concepts.effectivealtruism.org/concepts/talent-constraints-vs-funding-constraints/)", clears this confusion up with a better worded
"example":

> Organization A: Has annual funding of $5m, so can fund more staff,
> and has been actively hiring for a year, but has been unable to find
> anyone suitable... Organization A is more talent constrained than
> funding constrained...

In this post, discussions are focused on *Orgs that are TC* and not
*Causes that are TC*. When I am told that AI strategy is TC with the
lack of "Disentanglement Research" (DR), I don't know what to do about
it. But if I know FHI and many other orgs are TC in DR, then I could
potentially upskill in DR, and close the talent gap. So looking at
causes for me, is less helpful, less concrete and is not what I have
set out to understand.

## Why I think EA is TC

EA has been and is talent constrained, according to surveys based on
input from several EA orgs[^6]: [2017 survey](https://80000hours.org/2017/11/talent-gaps-survey-2017/), [2018 survey](https://80000hours.org/2018/10/2018-talent-gaps-survey/#appendix-2-answers-to-open-comment-questions),
[2019 survey](https://forum.effectivealtruism.org/posts/TpoeJ9A2G5Sipxfit/ea-leaders-forum-survey-on-ea-priorities-data-and-analysis). These surveys were conducted by 80khours and CEA.
In all the surveys EAs on average claim to be more Talent Constrained
than Funding Constrained. For example, in 2019 EA orgs reported feeling
more Talent Constrained (3 out of 5 rating) and less Funding
Constrained (1 out of 5 rating)[^11].

80khours doesn't seem to have changed it's position on this matter
since a while. In 2015, 80khours suggested that we should focus on
providing talent to the community rather than ETG, in ["Why you should
focus on talent gaps and not funding gaps"](https://80000hours.org/2015/11/why-you-should-focus-more-on-talent-gaps-not-funding-gaps/). One of the examples
they give is about AI Safety where there are people who are ready to
donate even more funds, but think there isn't enough "talent
pool". More posts such as ["Working at EA orgs](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/) (June 2017), ["The
world desperately needs AI strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/) (June 2017), "[Why
operations management is the biggest bottleneck in EA](https://80000hours.org/articles/operations-management/)" (March
2018), and [High-Impact-Careers](https://80000hours.org/articles/high-impact-careers/) (Aug 2018), continue to make the
case for EA orgs being TC. Even in their recent post, ["Key
Ideas"](https://80000hours.org/key-ideas/#priority-paths) (October 2019)--which is mostly recycled from the 2018 article
on [High-Impact-Careers](https://80000hours.org/articles/high-impact-careers/)--they continue to say that the bottleneck
to GPR for example, is researchers and operations people[^10].

In Nov 2018, they wrote a post to clarify any misconceptions regarding
the understanding of the term TC: ["Think twice before talking about
Talent gaps"](https://80000hours.org/2018/11/clarifying-talent-gaps/). 80khours informs us that EA orgs are not TC in general
but are TC by specific skills. Some examples (according to them)
being, people capable of Disentanglement Research in Strategy and
Policy (FHI, OpenAI, Deepmind), dedicated people in influential
government positions etc... This is great, the claim is becoming
narrower: *EA is TC in specifically X*. So what is this X?

## Where is the EA specifically TC

There seem to be a list of posts from 80khours from which we can
gather where EA is specifically TC. They are:

- Surveys ([2017](https://80000hours.org/2017/11/talent-gaps-survey-2017/), [2018](https://80000hours.org/2018/10/2018-talent-gaps-survey/), [2019](https://forum.effectivealtruism.org/posts/TpoeJ9A2G5Sipxfit/ea-leaders-forum-survey-on-ea-priorities-data-and-analysis))
- Bottlenecks in [top problem profiles](https://80000hours.org/key-ideas/#priority-paths) ([Shaping AI](https://80000hours.org/problem-profiles/positively-shaping-artificial-intelligence/), [Working
  in an EA orgs](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/), [GPR](https://80000hours.org/problem-profiles/global-priorities-research/#what-is-most-needed-to-solve-this-problem) etc...)
- Posts on priority career paths ([High Impact Careers](https://80000hours.org/articles/high-impact-careers/),
  [Key-ideas](https://80000hours.org/key-ideas/#priority-paths))
- Bottleneck hype-posts (for [AI strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/) and [Operations](https://80000hours.org/articles/operations-management/))

**The surveys** from 2017 to 2019 that informed us that the EA Orgs
are TC, provide information on "what sort of talent the EA orgs and EA
as a whole would need more of, in the next 5 years?". This question
sounds like a proxy to "Where is EA specifically TC?". 80khours seems
to agree with this proxy-approximation of the question as evidenced
[here](https://80000hours.org/articles/high-impact-careers/#our-list-of-priority-paths)[^7] and [here](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#what-skills-are-the-organisations-most-short-of)[^8]. The top 7 results (out of 20 or so) are
below:

|   | 2017        | 2017 (EA)   | 2018       | 2018 (EA)  | 2019      | 2019 (EA)   |
|---|-------------|-------------|------------|------------|-----------|-------------|
| 1 | GR          | G&P\***     | Oper.      | G&P\***    | GR        | G&P\***     |
| 2 | Good Calib. | Good Calib. | Mngment    | Oper.      | Oper.     | Mngment     |
| 3 | Mngment     | Mngment     | GR         | ML/AI      | Mngment   | H. GPR\*\*  |
| 4 | Off. mngers | ML/AI | ML/AI | Mngment | ML | Founding |
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
have no idea what they are talking about. As a result I am
unable to do much with these vague descriptions and am forced to skip
it as I am unsure how to interpret them.

Another way to arrive at or to supplement this list, is to look at the
**[top problem profiles](https://80000hours.org/articles/high-impact-careers/#our-list-of-priority-paths)** and check what the bottlenecks are. For
example, in the [profile on shaping AI](https://80000hours.org/problem-profiles/positively-shaping-artificial-intelligence/#what-can-you-do-to-help) (March 2017), we see that
80khours calls for people to help in AI Technical research, AI
Strategy and Policy, Complimentary roles and, Advocacy and Capacity
building. So basically EVERYTHING IN AI except ETG, is TC (it
appears). In the problem profile on [GPR](https://80000hours.org/problem-profiles/global-priorities-research/#what-is-most-needed-to-solve-this-problem) (July 2018), 80khours
suggests that they mainly need researchers trained in math, econ, phil
etc... Also needed are academic managers and operations staff. A very
similar story for [working at EA orgs](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#what-skills-are-the-organisations-most-short-of) as well.

Is it just me or is EA TC in "general"? Like when researchers,
operations people and managers are in shortage at GPR orgs, AI orgs
and other EA orgs, then who else is left?

In the post on [High Impact Careers](https://80000hours.org/articles/high-impact-careers/#why-did-we-choose-these-categories) (August 2018), 80khours
suggests the following **priority career paths** and what they are
constrained by:

> In brief, we think our list of top problems (AI safety, biorisk, EA,
> GPR, nuclear security, institutional decision-making) are mainly
> constrained by research insights, either those that directly solve
> the issue or insights about policy solutions. --- [High Impact
> Careers](https://80000hours.org/articles/high-impact-careers/)

<!--- AI strategy and Policy research
- AI safety technical research
- Grant maker focused on top areas
- Work in effective Altruism orgs
- Global priorities researcher
- Bio-risk strategy and policy
- China Specialists
- Earning to give in quant trading
- Decision making psychology research and roles-->

In **hype-posts** for Operations and AI Strategy just the title
already informs how TC the situation is:

- [The world desperately needs AI strategists](https://80000hours.org/podcast/episodes/the-world-desperately-needs-ai-strategists-heres-how-to-become-one/) (June 2017)

	Here, other than the title, I didn't really understand the
    "desperate need for AI strategists". Miles expects that "many"
    jobs would open up in the "future".
	
- [Why operations management is one of the biggest bottlenecks in
  effective altruism](https://80000hours.org/articles/operations-management/#which-traits-do-you-need) (March 2018)
  
  80khours updated this post one year later saying that the post is
  "somewhat out of date", and that the job market has changed over the
  last year. I guess these things happen.
  
In conclusion, the surveys say GRs, ML/AI people, GPR people and
movement building are TC (2019). The problem profiles seem to suggest
that GPR and AI are completely TC except for ETG (2017,2018). Whereas
the High-impact-careers post says that research insights and policy
solutions are the most constrained (2018). Different articles
suggesting different things. It appears that there is some discrepancy
between different articles but we move on with the key message that
all these things listed could be potentially TC. But are they really
TC though?

## The Evidence

**GR in GPR**

Researchers in GPR are claimed to be constrained. GR's also stand on
top of the survey lists shown before, for 2019. Yet, [Open Phil seems
to paint a very different picture](https://www.openphilanthropy.org/blog/reflections-our-2018-generalist-research-analyst-recruiting). For the recent hiring round by
Open Phil (started in Feb 2018 and ended in December 2018) they wanted
to hire 5 GRs. They report that more than a 100 strong resumes with
missions aligned to that of Open Phil were received. 59 of them were selected
after remote work tests and went into an interview. Of this, 17 of
them were offered a 3 month trial and 5 selected in the end. "Multiple
people" they met in this round are claimed to have potential to excel
in roles at Open Phil in the future. Open Phil does not seem to feel
that there is a lack of skilled people. It appears that they had
plenty to choose from and that they have found suitable candidates.

A similar case is observed with EAF. In [EAF's recent hiring round](https://forum.effectivealtruism.org/posts/d3cupMrngEArCygNk/takeaways-from-eaf-s-hiring-round)
(Nov 2018) to hire 1 GR ([for grant evaluation](https://ea-foundation.org/open-position-research-analyst/)) and 1 operations
personnel, *within just 2 weeks 66 people applied to this EA org
which was in a [non-hub](/what-should-I-do-in-eao.html)*. These 66 trickled down to 10 interviews
after work tests, 4 were offered trials and 2 were selected in the
end. No TC in GR here either.

Would Open Phil like to hire more GRs? For sure, but they don't have
the capability to deploy such a pool of available talent, they
say. They seem to be constrained by something else, something not
"talent". Perhaps, process or management or mentorship constrained?

---

<br>

**AI Strategy and Policy**

Researchers in AI Strategy and Policy are also claimed to be
constrained. The surveys echo the same as well. But [Carrick from
FHI](https://forum.effectivealtruism.org/posts/RCvetzfDnBNFX7pLH/personal-thoughts-on-careers-in-ai-policy-and-strategy) (Sep 2017) suggests that AI Policy implementation and research
work is essentially on hold until Disentanglement Research
progresses. And that even *"extremely talented people" will not be
able to contribute directly* until then. Similar to Open Phil,
institutional capacity to absorb and utilize more researchers in
Strategy is constrained according to Carrick.

This means that *except for the TC in Disentanglement research
(DR)*---where there seems to be large demand and if you meet the bar,
you will get a job---there seems to be no sign of TC in Strategy and
Policy, at the moment.

Once DR progresses, there would be a need for "a lot of AI
researchers", Carrick expects. It's been 2.5 years since the post by
Carrick, and as late as Nov 2018, [80khours continues to cite Carrick's
article](https://80000hours.org/2018/11/clarifying-talent-gaps/). This seems to suggest that not much might have changed. I
[have tried requesting Carrick](https://forum.effectivealtruism.org/posts/RCvetzfDnBNFX7pLH/personal-thoughts-on-careers-in-ai-policy-and-strategy?commentId=a2o5mTK2YuZswqic6) to write a reboot of his initial
post and hopefully he can further clarify the TC or lack there of.

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

<br>

**Researchers and Management staff in other EA orgs**

The co-founder and board member of Rethink Charity seems to suggest
that both senior and junior staff for Rethink Charity and Charity
Science were not hard to find, aka not TC.

> I’ve certainly had no problem finding junior staff for Rethink
> Priorities, Rethink Charity, or Charity Science (Note: Rethink
> Priorities is part of Rethink Charity but both are entirely separate
> from Charity Science)… and so far we’ve been lucky enough to have
> enough strong senior staff applications that we’re still finding
> ourselves turning down really strong applicants we would otherwise
> really love to hire.---[Peter Hurford says in the 2019 survey](https://forum.effectivealtruism.org/posts/7bp9Qjy7rCtuhGChs/survey-of-ea-org-leaders-about-what-skills-and-experience?commentId=ySRBeBocRz7oSahAC)


<!-- 
> Based at least on my recent hiring for Rethink Priorities, I can
> definitely confirm this is true, at least for us. We ended up
> completely overwhelmed with high-quality applicants beyond our
> wildest dreams. As a result we're dramatically scaling up as fast as
> we can to hire as many great applicants as we can responsibly,
> taking on a bunch of risk to do so. Even with all of that additional
> effort, we still had to reject numerous high-quality candidates that
> we would've otherwise loved to work with, if only we had more
> funding / management capacity / could grow the team even faster
> without overwhelming everyone.-->

The Life You Can Save's Jon Behar, [agrees with Peter](https://forum.effectivealtruism.org/posts/7bp9Qjy7rCtuhGChs/survey-of-ea-org-leaders-about-what-skills-and-experience?commentId=tojT8rKhwCz9rfJbB). He adds
that it's not the lack of talent but the lack of money to add new
staff which is the bottleneck for TLYCS.

---

<br>

## Conclusion

An org is TC in Talent X, if it is not able to find "skilled" people
despite "hiring actively". So far we have seen that Open Phil, EAF,
Rethink Charity, Charity Science, TLYCS and FHI, are able to find the
skilled people they need--except for one concrete example of
Disentanglement Research in FHI (and possibly similar institutes).
Contrary to the claims from 80khours, it appears that several orgs are
not TC.

I am really upset with 80khours. First it was focusing too much on
career capital (CC) and positions like management consulting, and now
TC. Getting into the TC debate only opened a Pandora's box of more
issues. Recently, I discovered that their discussion on
[replaceability](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#but-wont-i-be-replaceable) is probably [wrong](https://forum.effectivealtruism.org/posts/7bp9Qjy7rCtuhGChs/survey-of-ea-org-leaders-about-what-skills-and-experience?commentId=sCXPW4BWKWdkdyK2q). They have [gone back and
forth](https://80000hours.org/search/?cx=007036038893981741514%3Ad-war0ad7jy&cof=FORID%3A11&q=replaceability) on it in the past and currently have suggested that it
[depends](https://80000hours.org/2019/08/how-replaceable-are-top-candidates-in-large-hiring-rounds/). They ended up [inflating impact associated with people
working in EA orgs](https://80000hours.org/2018/10/2018-talent-gaps-survey/#ea-leaders-are-willing-to-sacrifice-a-lot-of-extra-donations-to-hold-on-to-their-most-recent-hires) and [have now taken it back](https://forum.effectivealtruism.org/posts/pzEJmc5gRskHjGTak/many-ea-orgs-say-they-place-a-lot-of-financial-value-on). They [severely
downplayed how competitive it is to get jobs in EA orgs](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#how-to-assess-your-personal-fit). And there
are [so many cases](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really)[^12] of people who feel the same way, not
without reason. I traveled with 80khours on the CC hype and spent
months on identifying positions of maximum CC. Then I did a 1 year
course of Data Science at Coursera. After that I jumped onto the
work-at-an-EA-org-because-TC hype and was just about to upskill in
statistics and apply for GR positions because they need me.

So many crucial mistakes that cost people like me and others[^12] a
lot of time, and the world a "lot of" dollars. And when someone
requests one of the members of 80khours to not just serve the elite
and that perhaps maybe invest in a small conversation with the
non-elite EAs to save them years of wasting time, [there is no
reply](https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really?commentId=no7FouoZDjPZuxCwr).

Thus, I find it very hard to trust the claims listed in 80khours. And
there are so [many of those](https://80000hours.org/key-ideas/) claims in every post and it's just
impractical to verify each one of them. Rather than relying on the
English and generalization of advice for everyone, I find EA forums a
much easier place to get information from, challenge claims and get
responses for (quickly). I found most of the evidence against TC
including the Pandora's box of issues, there. A lot of the successful
people from the EA world seem approachable there with chats, comments
and AMAs. Recently I was able to chat with Ben West, Aaron Gertler,
Peter Hurford, Jon Behar, Jeff Kaufman and Stefan Torges. A bigger
celebrity list of people can be seen commenting in posts, such as
Carrick Flynn and 80khours' very own Rob Wiblin.

<!-- Why "so many" organizations reported that they were TC in the surveys -->
<!-- is hard to determine. Maybe it was a generalization problem or the -->
<!-- times changed too quickly or things got lost in translation or the -->
<!-- definition changed over time or something else. I can only speculate. -->



## Final message

**Caution**: Just because an org is not TC, it doesn't mean that you
should reject that org.

**Why is this debate so important?**

 Whether an org is TC or not, has implications on the impact made. The
true impact you make when a job is TC at an EA org is (much) higher,
than when the job is not TC. A junior GR at GiveWell is expected to
move 2.4m<span>$</span> if the job was TC. The same GR is expected to
move only [244k](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#but-wont-i-be-replaceable) in the case that the hired GR is better than the
next-best-candidate by 10% (Not TC). Such is the distinction between
being TC and not. 

The above example assumes no [spillover effects](https://80000hours.org/career-reviews/working-at-effective-altruist-organisations/#but-wont-i-be-replaceable). But is that
correct? Why is there no spillover? Should I work in EA or not? How
much value do people really get out of working at an EA org? What is
best path for my aspiring EA career?

Stay tuned...

<!--Consider A and B applying for a job at an EA org that is not TC. This
means it is A can contribute 500k<span>$</span> value and B can
contribute 400k<span>$</span> value for the same job. For simplicity,
let's assume they produce little or no value if A or B does not take
take up that job.

Total value created for the world if A sits idle at home: 400k  
Total value created if A takes the job: 500k.  
Total value if A does ETG (for 100k) and B takes the job: 500k --> 

## Footnotes

[^3]: If 80khours on the other hand suggested that TC included
	everything that made it hard (such as hiring bottleneck) to find
	people with specific skillsets then TC is such a misnomer. Joel
	from EA forum puts it well:
	
	
	> I could be mistaken, but it would seem odd to say you’re “funding
	> constrained” but can’t use more funding at the moment. Whereas we
	> are saying orgs are “talent constrained” but can’t make use of
	> available talent... I feel a “talent bottleneck” implies an
	> insufficient supply of talent/applicants, which doesn’t seem to be
	> the case. I guess it’s more that there’s insufficient talent
	> actually working on the problems, but it’s not a matter of supply,
	> so it’s more of a “hiring bottleneck” or an “organizational capacity
	> bottleneck”.---[Joel EA Forum](https://forum.effectivealtruism.org/posts/pzEJmc5gRskHjGTak/many-ea-orgs-say-they-place-a-lot-of-financial-value-on?commentId=r3vv6HWvZ8riBfLEM#r3vv6HWvZ8riBfLEM)
	
	

[^4]: EAF seems to offer career coaching [here](https://ea-foundation.org/career-coaching/).
	
    EAF's operations analyst is also doing coaching [here](https://danielkestenholz.org/coaching/).


[^6]: 2018 survey includes: 

	> 80,000 Hours (3), AI Impacts (1), Animal Charity Evaluators (2),
	> Center for Applied Rationality (2), Centre for Effective Altruism
	> (2), Centre for the Study of Existential Risk (1), Berkeley Center
	> for Human-Compatible AI (1), Charity Science: Health (1), DeepMind
	> (1), Foundational Research Institute (2), Future of Humanity
	> Institute (2), GiveWell (1), Global Priorities Institute (2),
	> LessWrong (1), Machine Intelligence Research Institute (1), Open
	> Philanthropy Project (4), OpenAI (1), Rethink Charity (2), Sentience
	> Institute (1), SparkWave (1), and Other (5)

[^7]:

	> These positions are both our own assessment and backed up by
	> results of our surveys of community leaders about talent
	> constraints, skill needs and key bottlenecks."

[^8]: > What skills are the organizations most short of?

[^11]:

	**Funding Constrained**
	> 1 = how much things cost is never a practical limiting factor for
	> you; 5 = you are considering shrinking to avoid running out of money
	
	**Talent constrained**
	> 1 = you could hire many outstanding candidates who want to work at
	> your org if you chose that approach, or had the capacity to absorb
	> them, or had the money; 5 = you can't get any of the people you need
	> to grow, or you are losing the good people you have

[^10]: 80khours about GPR: 
	"To make this happen, perhaps the biggest need right now is to
    find more researchers able to make progress on the key questions
    of the field. There is already enough funding available to hire
    more people if they could demonstrate potential in the area
    (though there’s a greater need for funding than with AI safety)"
	
	"Another bottleneck to progress on global priorities research might be operations staff, as discussed earlier, so that’s another option to consider if you want to work on this issue."




[^12]: Links of posts where people were completely misinformed about
    how competitive the EA world is (look in the comments as well):

	1. https://forum.effectivealtruism.org/posts/jmbP9rwXncfa32seH/after-one-year-of-applying-for-ea-jobs-it-is-really-really

	
	2. https://www.facebook.com/groups/473795076132698/permalink/1077231712455695/
		
	3. https://physticuffs.tumblr.com/post/183108805284/slatestarscratchpad-this-post-is-venting-it
