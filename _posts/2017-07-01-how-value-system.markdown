---
layout: post
comments: true
title:  "How to determine your value system?(deprecated)"
date:    1-07-2017
categories: drafts
permalink: /:title.html
---
Post discussion with an STM.

##### Introduction
Goal is to come to the best answer we can with the resources we have at hand.

#### Example application of Bayes theorem
Let's say there is a system in front of you and you have no idea how to operate it, neither are there instructions, what would you do?
You would give some inputs and see what outputs happen. Bayes theorem I am informed is a much better way to proceed with determining what needs to be done. Let us understand it with the following example:s

Say there a 8 worlds. Each world has its own rules. You wan't to determine which world you are in. The 8 worlds are characterized by an outcome from three coin tosses. When we toss a coin 3 times we get about 8 outcomes. Each outcome uniquely characterizing one world. In world 1, an outcome of HHH (Head Head Head) is expected. In world 2, an outcome of HHT is expected. And HTH, THH, HTT, THT,TTH,TTT.

Given the task of determining which world we are in currently, we are provided with a coin. At this moment we have no clue as to which world we are in. Our confidence on us being in each of the worlds is 12.5 %. 

The first coin is tossed. We get Heads. This means that we are not in worlds based on, TTT, for example. Immediately our confidence in HHH, HHT, HTH, HTT, goes up to 25% and the confidence in the other worlds pretty much goes to 0. Next we get another heads. Our confidence in HHH,HHT,THH goes up to 33.3% and the rest goes to 0. Next we get another heads, confidence on HHH reaches 100% and we have thus determined the world we live in by using the Bayes theorem.



[wiki_scope]:https://en.wikipedia.org/wiki/Scope_neglect
[th_purpose]:/purpose-of-life-continued.html

