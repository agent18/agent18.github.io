---
layout: post
comments: true
title:  "DP Examples 3"
date:    07-03-2019 
categories: dp
tags: DP
permalink: /:title.html
published: true
---

## Introduction

This is the 3rd DP practice session on improving the skill,
"identifying phrases that need examples and giving examples".

## Feedback on last essay by an STM

- split even further

    >You need to break down the "phrase" even further. Instead of
    >"designed specifically to improve performance", which has two
    >main parts, make it "designed specifically" and "improve
    >performance". That way, for "improve performance", you get to
    >know exactly what you mean by "performance".
	
	
    > feedback on results is continuously available
	
	>Again, chunk it up. What does "feedback on results" look like?
	>Say, shooting percentage. (Why not also measure categories like
	>"missed completely" and "hit the rim" and "nothing but net"?
	>Fine-grained feedback as opposed to "in" and "out".)

	>Next, what does "continuously available" look like? Maybe you're
	>counting the last 10 balls and the success percentage
	>therein. This is continuous, as opposed to "go home and log it
	>after taking a shower and maybe having dinner", which is the
	>exact opposite of "continuously available".
	
- Examples need to be concrete

    > > **E:** You will NEVER be better than your peers.
    >
    > I'm too dumb to understand this sentence, especially when there
    > is no concrete example for miles. Especially taxing on my brain
    > are the words "be better" and "peers".

etc...

## Mission #6 by an STM

> Mission #6: Your mission, should you choose to accept it, would be to
> clarify material that genuinely confuses you. (Did your spider-sense
> start tingling for the last two phrases? It should have.)
>
> Primary target: Some work-related document that you need to understand
> thoroughly but currently don't. Take it apart almost word-by-word and
> provide a *concrete* example for each one.
>
> For example, "habeas corpus" sounds like a confusing legal term. But
> once I've seen an example for it
> (https://en.wikipedia.org/wiki/Habeas_corpus#Examples), I know it
> pretty well and can follow along when I hear it in another case. Even
> somebody who has no idea of the jargon can understand by looking at
> the concrete example. Note that the theoretical definition ("Habeas
> corpus is a recourse in law through which a person can report an
> unlawful detention or imprisonment to a court and request that the
> court order the custodian of the person, usually a prison official, to
> bring the prisoner to court, to determine whether the detention is
> lawful.") is not good enough - it's not a concrete example.
>
> Secondary target: Some non-technical document that you want to
> understand thoroughly but currently don't.
>
> Reps: 200.
>
> Success criteria: Does it feel less confusing? Does it now feel
> crystal-clear? (<spider-sense tingling>)

---
<br>

## DP

**Note:**

I have marked with italic text in some places for the reader to help
me out with examples and feedback if possible. I have done this
where ever I have noticed "confusion or difficulty".

### Lecture notes on Dynamics (20)

**Source** is course notes for Engineering Dynamics.

**P:**  
> The (analytical approach)[1] to (mechanics)[2] (in this book), unlike (vector
> mechanics)[3], is based on the (concepts of energy)[4a] and (work)[4b] and
> therefore provides a (better understanding)[5] of (mechanical
> phenomena)[6]. (It provides)[7] at the same time a (very powerful
> tool)[8] for two main reasons:

> - (It)[9] (considerably simplifies)[10] the (analytical formulation)[11] of
>   the (motion equations)[12] for a (complex mechanical system)[13].  

**E:** For the work I did on the IC engine in [this paper](https://www.researchgate.net/publication/291747197_Design_of_Dynamically_Loaded_Components_Using_a_Kinetostatic_Approach), we find out
the equilibrium forces in the crank and piston when the crank rotates
from 0-360 degrees[2], we wrote the newton equations in XYRz for each
part and then solved all the equations simultaneously to obtain the
forces[1,7,9,11].

*Can I get away with saying "equilibrium forces", Last time you asked
me "who is crank?" If this is not good enough, can you give me an
example of how this is supposed to be? :)* 

For the truss problem shown below: We could write the individual force
equations for each part in the XYRz (3 equations per part)[3], or we
could write one equation using the energy stored in the spring[4a] and
the work done by the force F [4b] for a small displacement d and come
to the same solution[14]. This is also called Principle of virtual
works (POVW)).

![Truss problem](./images/images-DP-3/truss.jpg)

When we use POVW this is the equation: `F*dy=0.5*k*dx^2`. It contains
stiffness, force and geometry. You see the relation between F and k,
you increase F by factor 2 then k needs to be increased by factor 2 as
well [6] when all else is the same! With Vector mechanics we would
have 6 equations (ΣFX=0,ΣFY=0,ΣM=0--2x). Once we solve them we have a
relation like `f(geometry, reaction force, internal force,
stiffness)=0`. This doesn't allow to the see the increase in F by a
factor 2 and its subsequent increase in the stiffness by factor 2[5].

In vector mechanics, we have 6 equations and in POVW we have 1
equation[8,10] (`F*dy=0.5*k*dx^2`)[12] for this truss problem [13].

Consider a double pendulum system[13]. They are dynamic in nature
(position of the masses changes with time). As opposed to 6 equations
we have 2 equations [10] which describe the position information using
a differential equation like `m*l^2*\\ddot(\\theta) +
mgl*sin(\\theta)` [12] while using POVW.

> - (It)[14] (gives rise)[15] to (approximate numerical methods)[16] for the
>   solution of both (discrete)[17] and (continuous)[18] systems in the
>   most (natural manner)[19].

**P:** It

**E:** [Analytical approach using energy and work](https://www.youtube.com/watch?v=QBWk996hg5Et=277)[14]

**P:** gives rise in natural manner [15,19]

**E:** For [simple differential equations](https://mathinsight.org/ordinary_differential_equation_introduction_examples) it is possible to get the
solution. But for systems like the Navier-Stokes equations [it is
impossible to solve without many assumptions](https://www.quora.com/Is-it-possible-to-solve-every-differential-equation-in-this-world). Thus we need
something else.[15,19]

*I would assume this is not an example of giving rise in a natural
manner, maybe it was an explanation*

**P:** approximate numerical methods

**E:** Find the root of 𝑓(𝑥)=𝑥−5.

let's guess 𝑥=1: 𝑓(1)=1−5=−4. A negative number. Let's guess 𝑥=6:
𝑓(6)=6−5=1. A positive number.

The answer must be between them. Let's try 𝑥=(6+1)/2: 𝑓(7/2)<0

[Source](https://math.stackexchange.com/questions/935405/what-s-the-difference-between-analytical-and-numerical-approaches-to-problems)

**P:** discrete systems

**E:** double pendulum with mass positioned at a distance `l` apart.

**P:** continuous systems

**E:** A beam

*It was quite taxing to come up with examples. It was very hard, this
part. It took 5 phrases per hour. Very slow! Was racking my head for
"examples"*

### Principle of virtual work (7)

> Let us consider (a particle of mass m)[1], (submitted to a force field **X**)[2]
> (of components Xi)[3] in an (inertial frame)[4]. The (dynamic equilibrium)[5] of
> the particle can be expressed in (d’Alembert’s form)[6]

	m*üi − Xi = 0      where i=1,2,3

> where ui represents the (displacement of the particle)[7].

Imagine a pendulum[1] pulled to a height h from its rest position and
let go of. The gravitational force acts on it[2]. In the vertical
direction you have the weight of the mass `mg` [3]. The forces are
defined in a frame such that if the pendulum is in its mean position
(with 0 net force) then is does not accelerate [4].

When the pendulum is pulled to a height and let go of, the pendulum is
in dynamic equilibrium[5]. When it is stationary at the mean position it
is in static equilibrium. D'Alhembert's form is the `F-ma=0`
form [6]. 

*"dynamic equilibrium", means for me that I can use `F=ma` equation
at every instance but I don't know how else to give an example to
explain it*

**P:** Displacement of a particle[7]

**E:** When the pendulum moves from mean position to 90 degree position
the displacement in horizontal direction is length of the pendulum.

*After this things got way too complicated with the text so I stopped
there, as it was taking too much time and I was getting no where*

**P:**
> Let us next imagine that the (particle)[1] follows during the time interval
> [t1 , t2 ] a (motion trajectory ui*)[2] (distinct from the real one)[3]
> ui. This (allows us)[4] to define the (virtual displacement of the particle)[5]
> by the relationship (figure 1.1)
>
> 	δui = ui* − ui

![virtual displacement](./images/images-DP-3/VD.png)

**E:**
The pendulum[1] moves from the mean position to say 90 degrees (B) to the
right (ui). ui* is when the pendulum ball takes any other route to
B[2,3]. The difference between these 2 is the virtual displacement.

*I didn't understand this part at all and couldn't continue with
giving examples, so I stop here.*

### Maxwells equations (22)

Source from text book Mechatronics Systems Design by Robert Munning Schmidt

> (Electro magnetics)[1] is the (physics area)[2] that (describes the
> phenomena)[3], associated with (electric)[4] and (magnetic fields)[5]
> and (their interaction)[6].

**P:** Electro Magnetics

**E:** Door bell has a magnetic material with coil around it. When a
current is passed through this material, it creates a magnetic field
that makes a rod hit a plate to make sound. [Source](https://wonderopolis.org/wonder/how-does-a-doorbell-work#)

E2: Motors rotate because of the creation of magnetic field by the
rotor which is opposed to the magnetic field by the stator. The
magnetic field of the rotor is created from an electric field. [1]

**P:** Physics area

**E:** light, electromagnetism, electrons, atoms,  planets, [2]

**P:** describes the phenomena 

**E:** Door bell has a magnetic material with coil around it. When a
current is passed through this material, it creates a magnetic field
that makes something to move and hit a two-tone bar[3]

**P:** electric fields

**E:**  When you bring a positive charge close to a negative charge, they
are attracted towards each other[4]

**P:** magnetic fields

**E:** When you bring a magnetic material towards a magnet it gets
attracted due to the magnetic field[5].

**P:** their interaction

**E:** When you pass current through a conductor it creates a magnetic
field. (doorbell) [6]

> Although this book (focuses on comprehension)[1], rather than
> (mathematics)[2], it is not possible to (escape from the fact)[3],
> that the (physics)[4] in (electro magnetics)[5] are governed by
> (stipulated laws and models)[6]. (These laws)[7] in itself (can not
> be understood by definition)[8], but (have to be accepted)[9] for
> reason of their (capability to predict the behavior)[10] of
> (electromagnetic systems)[11].

**P:** comprehension

**E:** If you apply a current to a coil you will see a magnetic field. You
bring a magnetic material close to the coil it will get attracted
[1]. 
 
**P:** Mathematics

**E:** Maxwell's equation derivation https://en.wikipedia.org/wiki/Maxwell%27s_equations [2]

**E:** Physics can only go so deep, it cannot tell you why the
current carrying coil in the doorbell[5,11] creates the magnetic
field[3,4]. It can only tell you that the Maxwell's laws[6,7] inform the
creation of magnetic field from electric field[8].

If you jump off a building YOU WILL FALL DOWN[10], so you don't jump
off the building [9].

~~> Though this complicates the matter (for people, who want to know
> why things work as they do)[],~~ (these laws)[1] are taken as a (starting
> point)[2] and then the (subject is presented)[3] as if its
> (understood)[4] (what causes these laws to be true)[5].

So I started with a breadboard and was informed that a [certain way of
connections](https://learn.sparkfun.com/tutorials/transistors/applications-i-switches) the transistor acts as a switch with a very small base
control current[1]. I accepted this[2] and made the line follower
robot. I took a couple of transistors and made the circuit[3,4] as
though transistors acting as switches[5] was true.

*Struggled in explaining "understood" and "what causes these laws to
be true". This was hard. Couldn't continue beyond this so moved on to
another topic*

### Career guide career capital (38)

Source for the following is from: [career-guide of 80000 hrs](https://80000hours.org/career-guide/career-capital/).

**P:**  
> (Career capital)[1] is anything that puts you in a (better position)[2] to make
> a( difference in the future)[3], including (skills)[4], (connections)[5], (credentials)[6]
> and (runway)[7].

For example, if you look at data science in Google, you learn
programming, statistics, maths, and you learn about the industry
(cars, phones, clothing) you are working in[1,4]. These skills are
expected to become [increasingly valuable](https://80000hours.org/career-reviews/data-science/#career-capital) in the the future across
wide range of industries (Phones, Cars, clothing, supermarkets
etc...)[2]. So if you wanted to go into an NGO like GIVEWELL[3], the
skills learned could allow you to migrate into that sector.

*"learn about the industry" is vague?*

My colleagues at work helped me find jobs by giving me a list of
companies to apply to [5].

Working at Google or BCG, or Mckinsey is already a Green Flag on your
CV. People respect you just for that [6].

*Is this not an example? Are you going to ask me what is a "green
flag"?*

With my current job I should be able to save 10k€ per year. This
will last me for a year without work[7].

> (Gaining career capital)[1] is (important)[2] (throughout your career)[3], but
> (especially when you’re young)[4] and (you have a lot to learn)[5].

My cousin is 40 years old and is doing sales in Dubai, he is
constantly having to be on his toes to make connections[1] which will
allow him to make new sales. On the other spectrum if he doesn't make
connections he might lose his job and come back to India[2,3].

Learning a language at the age of 40 is much harder than when you
are 25. After 30 it is hard to learn new skills [4] (Source: Talent is
Overrated).

Now I am 27, and I am learning Data Science, working on "critical
thinking", learning dutch, and weight training so that it puts me in
the best possible position in the future (working at GiveWell or start
my own NGO)[5].

> (The earlier you are in your career)[1], and the (less certain you
> are)[2] about (what to do in the medium-term)[3], (the more you
> should focus)[4] on (gaining career capital)[5] that’s (flexible)[6]
> i.e.( useful in many different sectors)[7a] and (career paths)[7].

[Peter](https://80000hours.org/career-guide/career-capital/#3-develop-a-valuable-transferable-skill) was majoring in political science when he was 22[1]. He was
inclined to make a big difference in this world[3], but he didn't know
how. He could do law, charity work or programming[2]. He chose
computer programming as it would give him lot of income to donate and
a transferable skill[4,5]. If he didn't like it, it would be easier
for him to switch into an NGO to do charity work[6]. But not the other
way around. The organization he works for gives him skills in
programming business and finance [7], this seems to ensure he can work
for organizations like Google, Tesla, Walmart, Facebook, and even
GiveWell [7a].

---
<br>
> Some of the (best ways)[1] to (gain career capital)[2] (early on)[3] include:

**P:** best ways to gain career capital [1,2]

**E:** Rob Mather of AMF says that he started [his career in sales and
management consulting](https://80000hours.org/career-guide/career-capital/#3-develop-a-valuable-transferable-skill). And that these positions have him the
management and persuasion skills to make AMF efficient [1,2].

E2: [Economics Phd, Machine learning Phd, foundation grantmaker](https://80000hours.org/career-reviews/)

**E3:** Programming, Data Science, tech entrepreneurship

**P:** early on

**E:** 20-30 I guess

**P:**
> (Working in any organization)[4] which has, or with any people who
> have, (a reputation for high performance)[5] e.g. (top consultancy)[6] or
> (technology firms)[7], or any work with a (great mentor or team)[8].

**E:** Working in Google, Amazon, Apple, Facebook or Mckinsey[6], BCG[6]
[4,5,7].

My boss once made me take on customer support for our clients in
France, which I managed to do well, despite not knowing anything about
the module. He was there for me to ask questions and learn and helped
me dealing with the panic caused by the guys in France [8]. 

> Undertaking (certain graduate studies)[9], especially (applied
> quantitative subjects)[10] like economics, computer science and
> applied mathematics. Anything that gives you a (valuable)[11a]
> (transferable skill)[11] e.g. programming, data science, marketing.

**P:** certain graduate studies

**E:** [Economics Phd, Machine learning Phd](https://80000hours.org/career-reviews/)[9]

**P:** Applied quantitative subjects

**E:** "Economics, computer science and applied mathematics"[10]


**P:** Valuable transferable skill

**E:** "programming, data science, marketing"[11] are some transferable
skills that can be used in literally all industries [11a]

**P:**   
>(Taking opportunities)[12] which allow you to (achieve impressive and
> socially valuable things)[13] e.g. (founding an organization)[14],
> (doing anything at which you might excel)[15].

**E:** Arnold Schwarzenegger worked hard in bodybuilding[15] and turned his success into
movies[12,13] and now into politics.

Rob Mather started with management consulting[12] which allowed him to
make AMF one of the most effective organizations[13] in providing aid [14].

Benjamin Todd couldn't find good advice on careers, so he
started 80k hours[12,14] and now has had an impact on >3000 major
career change decisions[13].

> There are also (lots)[16] of ways to (gain career capital in any
> job)[17], which we cover in a later article.

**E:** Volunteering to work on a programming project so that you can learn and
get additional skills. [17]

*Would you consider the above as an example?*

**E2:** learn courses in addition to work like programming, marketing or
management

**E3:** improve on social skills by joining improv or toastmasters. Be
sure to apply those techniques everywhere.

**P:** lots  [16]

**E:** The above listed examples are a few [E,E2,E3]. Also many more
[here](https://80000hours.org/career-guide/how-to-be-successful/#9-try-out-this-list-of-ways-to-become-more-productive).


### Career Capital in detail (70)

Source for the following is from: [career-guide of 80000 hrs](https://80000hours.org/career-guide/career-capital/).

> (Skills)[1] – (what will you (learn)[2a] in this job)[2], and (how fast
> will you learn)[3]?  You can( break skills down)[4] into
> (transferable skills)[5], (knowledge)[6] and (personality
> traits)[7]. 

At my current job, I am a design engineer. My skills are designing to
position parts within a few microns, troubleshooting and customer
support [1,2]. I work on variety of different projects like designing
modules for clamping of a wafer, and designing stages that accelerate
at 40g's [2a]. I am able to make my own designs with little help from
senior designers in 5 years time[3]. The different skill types are
transferable skills, knowledge and personality traits [4]. I can
transfer my design skills to other high-tech companies like Philips in
Medical[5]. With the knowledge of the lithography industry I am able
to move to sales[6]. At my previous company I sucked a lot, I was
allowed to ask dumb questions. I didn't even know how to design a part
for milling. But I was softly pointed out my flaws and I pulled
through quite well after that. Now when I have recent hires to mentor,
I make sure I extend the same kindness I was offered [7].

*Does troubleshooting, customer support work for you? why? and why
not? Do you think these need examples? When I say troubleshooting, I
imagine the time when I found and fixed the rootcause for a failing
filter in the module. When I think about customer support, I imagine
me on the phone listening about a ticket raised to critical about
broken wafer tables, and frantically discussing with people on how to
solve it*

*Can you comment on 2a? When I think about learning, I think about the
different projects I will work on, and the experience I gain from
that*

> Some especially (useful)[8] transferable skills include: (personal
> productivity)[9], (analysis)[10] and (problem-solving)[11], the (ability
> to learn quickly)[12], (decision-making)[13], (social skills)[14],
> and (management)[15].

**P:** useful

**E:** programming, and marketing skills can be used in every single
sector, and are the least risk of getting automated

**P:** personal productivity 

**E:** When I really need to focus, and time is of the essence, I switch
off my phone, switch on leechblock to block sites like youtube and
linkedin, and go to the silent room in the library with ear plugs. The
days when I invariably clock the most hours (10.5 hrs even) is with
this above setup [9]. There is not a case in history where I did 6 hrs
say when I was at home and didn't have the above setup.

**P:** analysis and problem-solving 

**E:** At work I am often given a task which starts with a problem: "there
is leak in the vacuum chamber". My objective would be to identify why
there is leak ("Make experiments to check if the leak is virtual or
due to a faulty connection")[10] and then propose solutions to
overcome it ("replace connection and retry")[11].

**P:** ability to learn quickly

**E:** Following [spaced repetition](https://80000hours.org/2013/04/how-to-improve-your-memory/). For example, reviewing 100 flash
cards of GRE words and meanings everyday.[12]

*Is this a proper example? Should have I chunked it up to "ability"
and "learn quickly", if so can you write this out for me?*

**P:** decision-making

**E:** for example, ability to make decision without falling for the
Alias paradox

1A: 24k with 100% certainty
1B: 33/34 chance if winning

2A: 34% chance of winning 24k
2B: 33% chance of winning 27k

Choosing 1B and 2B makes sense as they are equivalent and are the
highest $$.

*Is this not an example? why? what would be an example? A real
decision that I made overcoming my bias would be the right example?*

**P:** social skills  
**E:** ability to sustain conversation with someone you met (not awkward
silence). 

*This seems to be a hard one, I can think of real life examples like
friends I have? Can you show me an example for this? I think what I
have written is an explanation (theory)*

**E:** A colleague of mine is a support technician, in my view a real dumb
dumb when it comes to understanding tech. But he is extremely
social. He is capable of having long conversations with anybody even
the CEO of my company (yes a support technician). He is 38 and got
invited to parties of girl students(22) who work part time in my
company.

*I think the above is an example.*

**P:** management

**E:** My boss at work, has 8 people under him. Everyone has a task to
do. For example, I was asked to work on the calculations for the
module, another on the design and another on the electrical parts
etc... In addition he also communicates with other teams to make sure
the module we make interfaces with modules other teams make.

> We cover(why)[16] and (how to learn them)[17] in a later article.

**P:** Why (to learn transferable skills)

**E:** Jobs like programming, management are the safest jobs not at the risk
of automation. [Source](https://80000hours.org/career-guide/career-capital/#which-jobs-are-best-early-career).

**P:** how to learn them

**E:** By means of Deliberate Practice. [Here](https://www.youtube.com/watch?v=a8RXei5Jn3Q&t=638s) is an example of someone
improving their shot percentage of 3 pointers from ~25% to ~40% over 4
weeks.

**P:**
> If (you want)[18] (to do good)[19], you also (need)[20] to (learn
> all about)[21] the (world’s most pressing problems)[22] and (how to
> solve them)[23].

**E:** Donating atleast 10% of your salary[18] to EA organizations [19]

**P:** need

**E:** ??

*thought for a while and left it*

**P:**(learn all about)[21] 

**E:** I read the entire career guide of 80k hours atleast 2-5 times and in
the end wrote a 21k word article about my decision based on it

**P:** world's most pressing problems

**E:** AI risks, Promoting EA, Global priorities research, developing
world health [22]

**P:**
> (A job)[24b] will be (best)[24a] (for learning)[24] when you are
> (pushed)[25] to (improve)[26] and get (lots)[27] of (feedback from
> mentors)[28].

My friend currently works in Apple after he had an ivy league
schooling in the US. Previously he worked in Mu Sigma a company in
India, catering to the fortune 500 in the field of Data
Science[24b]. He and several others who left their job in Mu Sigma 2
years later, are in some kickass positions now in the US[24a,24]. He
often worked long hours and was under a lot of pressure to
deliver[25,26] for the fortune 500 companies. Even on holiday trips he
had his laptop to do meetings to make changes or inform his
findings[27,28].

*squeezed lots of feedback together? Should have I done it separately?
can you show me how?*

> (Connections)[1] – (who will you work with)[2] and (meet in this
> job)[3]? Your connections are (how)[4] you’ll (find opportunities)[5],
> (spread)[6a] (ideas)[6] and (start new projects)[7]. The (people you spend
> time with)[8] also (shape your character)[9]. 

A few months back the company I used to work for went bankrupt. At
that time everyone was searching for jobs. People I had interacted
with related to work[2] and while having lunch[3], openly discussed
with each other where we are applying for jobs. They gave suggestions
on where to find companies and what companies they were applying
to[4,5]. My immediate boss gave me a recommendation and contact to speak
with which lead me to getting multiple interviews within the same
company[4,5]. I had met someone high up in the management ladder of another
company a few years back. I called him up directly and re-introduced
myself and got some great advice on where to look for jobs[5]. Another
colleague gave me a list of companies he had gotten from a bigshot to
apply to[4,5].

*squeezed "how" and "find opportunities" together? how would I split
it and what are the questions you ask yourself to come up with an
example in this case?*

My co-conspirator in the US constantly introduces me to new ideas on
life such as deliberate practice and effective altruism[6]. He does
this by way of giving me missions [6a] to complete under some strict
deadlines. Right now I am allocating a few hrs a day towards
Deliberate practice[7]. In tandem I am half way through the Coursera
course on Data Science[7].

Persuasion is real. I was once unfortunately third wheeling 2 couples
on new years[8]. One of the couples could not stop PDAing. We went out
for the fireworks and it made me feel so alone. I think I was fine
until I saw this shit[9]. Wanting to have a girlfriend peaked at that
time[9]. I was visibly sad or wanted to retreat into my shell!
HaHa. But now I think I am ok! Grinding and deeply thinking about the
concepts of 80k hours and reading about what people in the EA
community are doing[8] is filling me with more desire to be like
them[9] and not like those cuddly PDA-showing
not-caring-about-the-world couples!

> For both reasons, it’s (important)[11] to (make connections)[12] who
> are (influential)[13] and (who care about social impact)[14].

My colleagues informed me companies I could apply to, so that I can
get a job[11]. Engaging with an STM and the EA community is allowing
me to focus on deliberate practice[11] which is expected to make me
earn top $$ (200k in the next few years) or save 1000s of lives.

Talking to people at work, about design or just making jokes, drinking
beer with them seems to make solid connections. (I went to this guy for
so many tough questions I had to deal with. I drank with him till the
end on some occasions. I thanked him for all his support when mapper
went bankrupt, and he was touched by it. I just ask him for advice to
this day and he responds)[12]. He now has his own consultancy, with a
few more years of experience I could work for him[13].

People who care about social impact: STM, EA community, 80k hours,
Founders pledge, Elon Musk, Peter Singer, GiveWell :) [14]

> (Credentials)[1] – will (this job act as)[2] (a good signal)[3] to (future
> collaborators)[4] or (employers)[5]? Note that we don’t just mean (formal
> credentials)[6] like having a law degree[6], but also your (achievements)[7] and
> (reputation)[8]. If you’re a writer, it’s the (quality)[9] of your blog. If
> you’re a coder, it’s your GitHub.

A Masters degree, an award recognizing your work in the company, a
scholarship are some credentials [1]. Due to the bankruptcy of the
previous company I worked for I was looking for jobs in precision
engineering field like ASML, DEMCON [4,5]. I got about 5-8 interviews
quite easily[3], mainly by pitching my story in the previous
job[2]. Most of them converted[3]. Having a masters degree accounted
for more $$[6]. I constantly boasted with the help of my recommendation
letter, how much money I saved for the company (20k€ and 300 man
hours)[7], how well I performed in customer support[7], and how in one
project I was picked ahead of senior designers to do system
engineering[8].

In the Less Wrong community you see other people post as well; other
than Eliezer. For example when I saw this series "The Science of
Winning at life", I was excited for a second and immediately checked
the author's credentials. He has 65k people "Like" his posts[9]. Ok
now I am going to read it.

> (Runway)[1] – (how much money will you save in this job)[2]? Your
> runway is (how long)[3] you could (comfortably live)[4] with (no
> income)[5]. It depends on both your (savings)[6] and how much you
> could (reduce your expenses by)[7]. We (recommend)[8a] (aiming)[8] for at
> least six months of runway to (maintain your financial
> security)[9]. 12-18 months of runway is (even more useful)[10] because
> it gives you the (flexibility)[11] to make a (major career
> change)[12]. It’s (usually)[13] (worth)[14] (paying down)[14b] (high-interest
> debt)[15] before (donating)[16] more than 1% per year or (taking a big pay
> cut)[17] for greater impact.

With my previous job I could save about 6-8k [1,2]. Cost of living is
about 1200€ per month[4]. So I can withstand for about 6 months[3] for
every year I work, with 0€ income in a first world country like
Netherlands[5].

If I go to India I can cut it down to probably <500€[7]. Potentially I
could stay more months with no income. With my current savings of
12k€[6] I could probably stay without income for more than 1.5 years
in India.

8k bank balance for emergencies seems to be enough for 6 months [8].

*"recommend"? no idea!*

In case you lose your job then you need a few months to find a
job[9]. Typical time periods at large companies (ASML) are 2-4 months
of application process. From start to finish ASML took 2.5 months
before handing me the contract. 

Doing an MBA would mean more $$[10] in the bank. In case I decide to
do an MBA in Netherlands full time [12], I would need to quit my job
and pursue it[11]. So 15k for basic needs for a year and 50k of
tuition loan.

When people come for a masters to Netherlands[13], they take a loan in
India where people pay 7-8% interest[15] every year in addition to
paying off the base. (assuming the interest does not decrease over
years) For 40L rs of loan it will take 8 years if you pay 5L base, 3L
interest[14b] and make no donation. It will take 20 years if you pay 2L
base, 3L interest and 3L donation[16]. With the first option where you
pay your debt first, over a period of 20 years you can donate \~72L
and with the second option you can donate \~60L. It seems to add
another 12L rs if debt is paid first[14].

In Europe I would imagine working in an EA organization will probably
start with minimum wage ~25k€ (a paycut of 30k€). This gives not much
place for savings(maybe 2-3k), This would just cover the interest in
the above case of loan from India[17]. As you also need to pay the
base, it is not recommended at all.


### 80k hours misunderstood views (42)

Source for this text [here](https://80000hours.org/2017/12/annual-review/#people-misunderstand-our-views-on-career-capital).

> In the (main career guide)[1], (we promote the idea)[2] of (gaining
> “career capital”)[3a] (early in your career)[3b]. This has led to
> some (engaged users)[4] (to focus on)[4b] (options)[5] like
> (consulting)[6], (software engineering)[7], and (tech
> entrepreneurship)[8], when actually (we think)[9] (these)[9b] are
> (rarely)[10] the (best)[11] (early career options)[12] if you’re
> (focused on)[13] our (top problems areas)[14]. Instead, (it seems
> like)[15a] (most people)[15] (should focus)[15b] on (entering a
> priority path)[16] (directly)[17], or (perhaps)[18] (go to graduate
> school)[19].

In [this link](https://80000hours.org/career-guide/career-capital/#mistake-2-not-building-flexible-career-capital-that-will-be-useful-in-the-future)[1], 80k hours say "Gaining career capital is
important throughout your career, but especially when you’re young and
you have a lot to learn."[2]. 

Peter who was 22[3b] and majoring in political science moved to
programming, management and finance[3a].

**P:** engaged users **E:** Myself and people who have been using it to make
career changes [4]

**P:** to focus **E:** People like myself moving towards Data Science, taking
Data science courses [4b]

**P:** options **E:** "consulting, software engineering" [5]

**P:** consulting **E:** working at McKinsey [6]

**P:** software engineering **E:** working at Google [7]

**P:** tech entrepreneurship **E:** Airbnb [8]

**P:** we think  **E:** 80k hours website [9]

*Your comments on "we think"*

**P:** these **E:** consulting, SE, tech entrepreneurship [9b]

**P:** 
> (rarely)[10] the (best)[11] (early career options)[12] if you’re
> (focused on)[13] our (top problems areas)[14]

**E:** If you look at the [top 3 problem areas ](https://80000hours.org/articles/cause-selection/)[14] such as
AI, global priorities research, and promoting effective altruism, it
looks like none of them seem to need consulting or software
programming [10].

You can enter AI if you are really good in math heavy research,
support roles, policy and strategy. For promoting effective altruism,
working directly in EA organizations and doing internships and
volunteer work gets you inside. For global priorities research, an
economics related degree, or political science, philosophy,
decision-making helps etc... [11,12] [Source](https://80000hours.org/articles/cause-selection/).

Of the candidates featured in the 80k hours career guide,
I barely saw people with a consulting background or an MBA even, when
I surveyed it [here](http://agent18.github.io/Summary-before-applying-to-80k.html) [10]. 

**P:** focused on **E:** An example of 'being focused on' is Niel Bowerman
working on AI policy all the way from a PhD in climate physics. His
focus being on creating maximum impact (saving max lives)[13].

**P:**

> Instead, (it seems like)[15a] (most people)[15] (should focus)[15b]
> on (entering a priority path)[16] (directly)[17], or (perhaps)[18]
> (go to graduate school)[19].

**E:** Niel Bowerman works for AI policy now[16], from PhD in climate
physics [15b]. He got in touch with great people in the community
while being an advocate for climate change. This way he entered the
community and today he is AI Policy specialist at 80k hours[17]. He
didn't do an MBA or programming before getting into the priority
path[17]. On the other hand[Dillon](https://80000hours.org/career-guide/member-stories/dillon-bowen/) was going to pursue an
economics PhD to work on the priority paths [19] later.

Most people who applied or reported their career change to 80k hours
[15],showed interest in consulting rather than directly into the
priority paths[15]. Instead, according to [80k hours research](https://80000hours.org/articles/cause-selection/)
[15a], they should be working directly on the priority paths[15b].

*most people, how do I quantify it, I don't have any data? Maybe I
should dig into 80k hours?*

> We think there are several misunderstandings going on:
>
> There’s a (difference)[0] between (narrow)[1] and (flexible career
> capital)[2].

**P:** flexible career capital

**E:** Peter 22, works for a firm that needs his programming skills and
also learns about finance and management at work. So he has the option
in the future to move into 3 different kinds of paths and into
multiple sectors(Banks, automobile, EA organizations) and likely to
keep his job from the risk of automation.

**E2:** Doing Data science gives you skills in programming, "problem
solving", statistics and detailed knowledge of the industry you work
in (for example, if you are in self-driving cars, then you learn about
that industry and how it works as well")

**P:** Narrow career capital

**E:** Working in a non-profit straight out of university

**P:** difference

**E:** Kate ended up returning to the corporate sector for several years,
and would have ended up ahead if she’d done that straight away
(without starting at a non-profit straight out of university).

*"Would have ended up ahead"? Not good enough?*

Hard to build up runway for a 6 months by working for a year, as you
will be earning 50k$ when you begin.

It’s [widely accepted in the non-profit sector](https://80000hours.org/2015/09/what-do-leaders-of-effective-non-profits-say-about-working-in-non-profits-interviews-with-givedirectly-deworm-the-world-initiative-development-media-international-schistosomiasis-control-initiativ/) that it’s easier to
switch from a business job to a non-profit job than vice versa. So if
you’re unsure between the two, a business position offers more
flexibility. [Source](https://80000hours.org/career-guide/career-capital/#which-jobs-are-best-early-career)

**P:**

> (Narrow career capital)[3a] is useful for a (small number of
> paths)[3], while (flexible career capital)[3b] is useful in a (large
> number)[4].

**E:** Working at EAO's[3a] keeps you well positioned for senior positions
in EA organizations. One can move in wide range of sectors but only
within the EA community[3]. For example, Neil Bowerman, started with
Climate Change and now is in freaking AI policy[3]. While working in
data science[3b] can lead to job switches in several sectors (mobiles
phones, self-driving cars, food-chains, supermarkets, clothing and
EAO's)[4].

The technical skills you develop also open the possibility to
transition into different roles including software engineering,
founding or joining early-stage startups, academia,2 and quant
finance. [Source](https://80000hours.org/career-reviews/data-science/#career-capital)[4]

> If you’re (focused on)[5] our (top problem areas)[6], (narrow career
> capital in those areas)[7] is (usually)[8a] (more useful)[8] than
> (flexible career capital)[9]. 

**E:** Niel Bowerman was interested in climate advocacy[6] and pursued it
seriously and got several connections within the EA community[5]. He
ended up getting impressive achievements such as founding a think
tank[8]. He works now on AI policy[6] which he was able to use and
transfer his skills, reputation and connections into[7,8]. Contrast
this to him having taken up a job in Software Engineering [9].

*I think "usually"[8a] is not covered in the above! How would you write
an example for "usually" in this context?*

> (Consulting)[10A] (provides flexible career capital)[10], which means (it’s
> not top overall)[11] unless you’re (very uncertain)[12] about (what
> to aim for)[13]. 

Following work at Mckinsey[10A], people tend to occupy chief of staff
positions for senior/influential public official or become people of
the top management for large companies like Google. They also work on
strategy team for companies like Google, or work on the front lines
where they served as consultants, policy, private/equity etc... The
options seem to be a lot [10]. I [estimate here](./Summary-before-applying-to-80k.html) that working for
an EAO like 80k hours (with the "right skills and intention" it is
definitely possible, I think I can get in if I spend a "few years" on
my "skills") could save 1100 lives, where as the best case scenario of
becoming a consultant--- a partner--- seems to save 1050 lives not
including any probabilities of getting there (thumbs down for
consulting)[11].

**P:** very uncertain

**E:** You don't know if you can handle the stress of an Investment
banking/trading job, so you need to try something similar to see if
you are a good fit for it[12]. Hence you do not know if you want to Earn
to give or work directly [13].

**E2:** My friend was 26 when he decided to do a masters in computer
science in the US. He didn't know if he was up for AI research (say at
MIRI)[12] or if he should earn-to-give (say at Google).[13]

> You can get (good)[14a] (career capital)[14] in (positions with high
> immediate impact)[15] (especially problem-area specific career
> capital)[16], including (most of those we recommend)[17].

Tara gained skills in managing and making efficient[14,17] processes
while working at hospitals and with the RedCross. She managed to save
8m$ for the hospital in a year[14a]. This landed her the CEO position
at the Centre for Effective Altruism which seems to be Promoting
Effective Altruism[16].

## Reflection

When I was editing the text, I found that in many places, it was hard
to follow the example, what with all the numbering going
everywhere. For example:

> You can get (good career capital)[14] in (positions with high
> immediate impact)[15] (especially problem-area specific career
> capital)[16], including (most of those we recommend)[17].

**I wrote:**

Tara gained skills in managing and making efficient[14,17] processes
within organizations related to healthcare[16] while working in an
hospital and then later working in Bhutan with the RedCross[15]. Her
impressive achievements (saving 8M$ for the hospital) allowed her to
take on even bigger tasks like becoming the CEO of Centre for
Effective Altruism.

**I changed it to:**

Tara gained skills in managing and making efficient[14,17] processes
while working at hospitals and with the RedCross[15]. She managed to save
8m$ for the hospital in a year[14a]. This landed her the CEO position
at the Centre for Effective Altruism which seems to be Promoting
Effective Altruism[16].

I didn't spend much time editing this time. I wrote the text, edited
it once and did some grammar checks. I should probably spend more time
on making it readable. Atleast get 2 revisions of the text. 

## Statistics

<!-- 1st day 3.5 hours -->

<!-- 2nd day 3.9 hours -->

<!-- 3rd day 10.7 hours (quit bb practice as I didn't get much done in the -->
<!-- day) -->

<!-- Sucked in the morning, half hour of sleep, coundn't do the techinical -->
<!-- stuff. 80k hours was not too easy, but I was able to make up for the -->
<!-- lost time. -->

<!-- Overall I felt good towards the end of the day. Not really bored I -->
<!-- think during any part of the day. Morning was intense though. 4 hrs -->
<!-- went by and I was racking my head to find examples. -->

<!-- 4rth day   -->

<!-- Slow start but soodu pudikudhu! Finally figured out 3 secntences after -->
<!-- more than 1 hr. Takes time to research and right! -->

<!-- 5th day 5 hrs editing and making corrections to badly written -->
<!-- examples. -->

**Day1:** 3.5 hrs (reading STM's email and understanding what is expected)

Weekday with 8 hrs work and 2.5 hrs gym things

**Day2**: 3.9 hrs (DP)

Weekday with 8 hrs work and 2.5 hrs gym things

**Day3**: 10.7 hrs (DP)

Weekend, No sports, only DP from 9 am in the morning, slept for 36
mins 1hr after lunch.

Sucked in the morning, couldn't do the technical stuff. 80k hours was
not too easy, but I was able to make up for the lost time.

Overall I felt good towards the end of the day. Not really bored I
think during any part of the day. Morning was intense though. 4 hrs
went by and I was racking my head to find examples.

Finished 100 phrases.

**Day4**: 8.6 hrs (DP)

Weekend, Started at 9 am in the morning, slept after 1 hr of lunch for
20 mins.

Spent 6 hrs in the evening on playing basketball, and eating dinner
with friends despite the crucial deadline. Stayed up till 2 am to catch
up. :(

Finished another 100 phrases.

**Day5**: 6 hrs (editing and correcting DP examples)

Weekday with 7 hrs of work, 1 hour of dinner, slept for 25 mins right
at the beginning.


**Total hours**: 32.8 hrs in 5 days; average = 6.56 hrs per day (I think
PR)

**Total DP hours**: ~28 hrs

**Total words**: 6.5k

<!-- ## Material to work on -->

<!-- I am thinking something from the DSS course, as I don't have anything -->
<!-- related to work as yet. And Can't pull out documents! -->

<!-- How about stuff from Shigley? -->

<!-- or how about stuff from the thesis? or internship? -->

<!-- or maybe rob munning smidt on dynamics! -->

<!-- log log, dynamics -->

<!-- dynamics by rixen? -->

<!-- principle of virtual works! -->

<!-- Motivation articles! -->

<!-- https://80000hours.org/career-guide/career-capital/ -->
