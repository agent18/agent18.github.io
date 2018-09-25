---
layout: post
comments: true
title:  " Bayes Theorem  "
date:    07-06-2017 21:46 
categories: drafts
permalink: /:title.html
---

#### **[A first look at Bayes][arbital_exp]**

>Bayesian reasoning is about how to revise our beliefs in the light of evidence.

>A nurse is screening a set of students for Diseasitis. From past studies we know that 20% of students will have Diseasitis at this time of the year. A color-changing tongue depressor, is used to identify who has Diseasitis and not. Among patients who have Diseasitis, 90% turn the tongue depressor black. It also turns black 30% of the time for healthy students.

>One of the students comes into the nurses office and takes a test and turns the tongue depressor black. what is the probability that he has Diseasitis.

I have read this article quite some time back and remember the solution. It seems easier to do it the following way as suggested in the same [article on Arbital][arbital_exp].

#### Glossary

No. of students who have Diseasitis = N_D

No. of students who do not have Diseasitis = N_dnD

No. of students whose tongue depressor turns black & have Diseasitis = N_D_B

No. of students whose tongue depressor turns black & _do not_ have Diseasitis = N_dnD_B

#### Action

Let's say there are 100 students.

>20% of students will have Diseasitis.

	$ N_D = 20 

	$ N_dnD = 80 

>Among patients who have Diseasitis, 90% turn the tongue depressor black.

	$ N_D_B = 90% of N_D = 18

>It also turns black 30% of the time for healthy students.

	$ N_dnD_B = 30% of N_dnD = 24

>One of the students comes into the nurses office and takes a test and turns the tongue depressor black. what is the probability that he has Diseasitis.

P (a student who has turned the depressor black has Deseasitis):
	$ (N_D_B)/(N_D_B + N_dnD_B) = 18/(24+18) = 18/42 = 3/7 = 43%

#### Open Issue

Why and where is Bayes theorem useful for us?



[arbital_exp]:https://arbital.com/p/bayes_frequency_diagram/?l=55z
