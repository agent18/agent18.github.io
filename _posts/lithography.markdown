## body

1. design of experiements (56 jobs)
root cause analysis

1. ""productivity improvement projects and the work typically involves
   a lot of (machine and customer) data crunching, detailed breakdowns
   of tact time of stages, handlers and track, bottle neck analyses
   and the creation of options and solutions to enhance throughput and
   output""
   
   Customer support
   
   hands dirty with data (difficult data) comprehensive data
   story.... workign with unclean data answer data.
   
2. I look at data from ASML's customers to suggest customised
   productivity improvements based on their usage of lithography
   machines. I am involved in new product introduction, and multiple
   stages of the product generation process. I also do data analysis
   and reporting as part of application and business support.
   
   
3. Data mining with some home made tools, to suggest improvements

Big data:

> make recommendation, create data impact, insights
> statistics
>
> hypothesis testing
>
> deisgn
>
> correlation analysis
>
> drivers (feature importation types)
>
> A/B testing hypothesis (randomised unbiased) truly unbiased outcome,
> causal. 
>
> Writing queries, cleaning, manipulating it, adding features, if
> required data products, making insights and presenting it
>
> Full stack data analyst --> ^^^^ good analysis...  ML and more
> statistical rigor is Dat scientist.
>
> operations analyst --> understands data to create impact...
>
> You will be sucked into domain...
>
>
> Big data ()

## lith

In device and on-product metrology

 

In-device --> using actual device repetitive features not specific marks

On-product metrology --> using marks placed inbetween chips

 

Machine overlay --> overlay within the machine scanner

On-product overlay --> actual overlay over the entire process


### process

https://www.youtube.com/watch?v=oBKhN4n-EGI

https://youtu.be/TdwUGOxCdUc?t=1062

1. **Cleaning** H202 cleaning the substrate

	- Layer of silicon (masking film)

2. **Preparation: HDMS** (increase adhesion of photoresits) RRC reduce resist
   consumption
   
3. **Coating and prebake** 

	- photo resist --> thin coating (0.5 to 2.5 um)
	- spin coating
	- apply heat
	- extra photo resist is removed edge bead removal (FLAT LAYER)
	- pre bake (drive off excess photo resist)

4. **Exposure:  light** --> conddenser lens (collimated beath) --> photo mask -->
	projection lens or objective lens (to reduce size of mask light) --> photo resist has a pattern now
   
5. **Development:** wash away exposed parts of the photoresist (+ve
   resist) (soluble photoresist)

6. **etching process**: remove upper most layer of substrate (silicon)
   unprotected by photoresist   
   
7. **Photoresist Cleaning** remove insoluble photoresist


8. **SiO2 deposition**  is deposited  --> so we have Si unexposed region and Si02 in
    the exposed region gaps

9. make several layers

10. **Etch** SiO2 to reveal 3d stretcher of Si

### Resolution and optics

R ~lambda/na;

N/A - nsin alpha

alpha --> half angle of cone of light

ArF 193nm KrF 248nm

Current 14nm, CD

Condensor lens --> condenses the light on to the mask (in litho) or
condenses the light on to the specimen (like a cone)

Magnification: height of mask by height of print

things to know... diffraction, YS, interference, aberrations of lens?


Different types of chips, dram (25) logic (50 steps) etc...

### diffraction and interference

https://physics.stackexchange.com/a/382815/214354

- wave of light through a slit acts like it's own light source. This
  spreading out is **diffraction.**

- 2 lits produce an in interference pattern of varying intensities due
  to construction and destruction.

- constructive interference in 1d --> path difference had to be 0,
  lambda, 2lambda etc...
  
- Destructive interference in 1d --> path difference had to be
  lambda/2, 3lambda/2 etc...


- small features diffract more.


**Youngs double slit**

[Link](https://youtu.be/Pk6s2OlKzKQ)

- Light is wave (visible light 400nm to 600nm) 

- one initial wave and 2 slits, so sources in phase

- double slit (d (um) is close to each other of lambda)

- shows a pattern of alternative bright and dark spots

	- this is waver interference in 2d
	
sin(theta) = delx/d  <-- you can measure d with the youngs double slit
equation.

I don't understand why the intensity decreases. Apparently has to do
with the size of the 

**Pattern**

delx = lambda (CI)

delx = lambda/2 (DI)

delx = 0 (CI)

delx = lambda/2 (DI)

delx = lambda (CI)

**Diffraction grating**

https://youtu.be/F6dZjuw1KUo

Having 2 points gets the above pattern with spots getting weaker wiht
intensity, but with more slits you get bright spots and empty space
and then bright spots when we have CI.


### terminology

- camera stepper or scanner that projects an image of photomast onto photoresist


## what to dag

See who the people are indrewing?

1. Explain CV

	
2. prep

	- basics of programming (classes etc... OOPS) (1 youtube video)
	- lithography process in and out (2-3 videos and the practice
      explaining it)
	- definitions (on-product, inproduct, PWC, imaging, alignment,
      focus, overlay, EPE)
	- hypothesis testing
	- statistical sleuth (1st chapter), understand random exp,
      sampling ideas
	
3. What do you want in a job ? Mathivanan?

4. what do you think there is in the job?

5. Explain statistics work clearly

6. Explain work of fraud detection (data analysis)

7. explain work done for trouble shooting (that assignment)

8. explain work done for optics perhaps? different abberations, look
   up contributions in that vidoe thingy
   
9. explain recent test setups clearly and perhaps one contribution
   that you made.


**Statistics**

1. stat sleuth (understand random exp with example)
2. hypothesis testing
3. statistics explnation from CV
4. understanding sampling and how much to sample
5. perhaps the tt I did for wafer alignment repro

**Lithography**

1. 2 videos
   - explain litho process without seeing
   - how metrology works by seeing the marks (diffraction)
2. all definitions
3. looking at herman borgs description, peiter discsssion etc...

**Troubleshooting**

1. that assignment (impartnet)
2. general work in it
3. recent test setups and one contribution I made

**Data analysis**

1. fraud detection explanation

**Optics**

1. litho optics lambda/na
2. abberations and understanding from that RMS book?


## Explanation

1. how to identify the number of measurements you need in a random
   setting (based on [CI and Margins of errors](https://youtu.be/hlM7zdf7zwU))
   
   
   Based on expected values of 
   
2. Check that we are using the normal condition

3. Margin of error

## XYRZ verification

**repro estimation**

1. Make 10 clamps, 10 images per clamp

2. Randomness components--> clamp, lighting, aperture variation,
   software variation
   

**Measurement repro**

We assume we have the population statistic, other wise we have to get
into some complicated Standard error calculation of the standard
deviation.

1. recipe: make 10 images

This results in a 95%CI of 3s of 10 images +- 100urad (emperically)

**Clamp repro**

1.  recipe: make 10 images per clamp and make 9 clamps

Results in 90 measurements:

This is results in a 95%CI of 3s of 100images +- 26urad (emperically)

1. Results in 3s for each clamp and then averaged value.

This results in a 95CI of 3s for each clamp of +-34urad (emperically
and using sqrt(n))

**Accuracy**


## XYRz verification

https://physics.stackexchange.com/a/57354/214354 shows how to deal
with uncertainties

**Highlevel situation**: Meausure clamp repro and accuracy in Rz

**Task 1**: Get Measurement error of single clamp

**Action 1**: 

1. Make 10 pictures (random (software,aperture!,lighting), "normal",
independent)

2. Estimating the uncertainty in measurement using Sample distribution
   of sample mean (95% CI)
   
		Mean +- t* x se
	   
		se = ssd/sqrt(n)


**Pitfalls**

1. Not sure if I need to bootstrap, as this might not be totally
   random
2. normality was not checked
3. however the independence condition holds

**Result**: 

The uncertainty is acceptable considering the budget for now. It
varies from 20 to 40urad. Therefore we stick to 10 images.

Margin of error is `+- ssd/sqrt(n)`. It is in the order of
43um.  Therefore every measurement of mean comes with it's own
uncertainty due to measurement.

**Task 2**: Get Clamp repro ( sd of population) (with measurement error)

**Action 2**: Estimating a naive unbiased estimate

- Clamp1 --> M1 +- t* x se1
- Clamp2 --> M2 +- t* x se2
.
.
.
- Clamp --> M9 +- t* x se9


3SD of M1 and M9 -->  3sd of sample x n/n-1
	   
**Pitfalls**: 

1. Estimating population SD is complicated because of the
[complicated formula for SE](https://stats.stackexchange.com/a/157305/217983). So all we have is sample SD.

Sample SD for 10 measurements seems to be lesser than the True SD only
50% of the times.

For a true 3sd of 150urad, I get the following:

```R
> quantile(3*sd.dist*n/(n-1))
       0%       25%       50%       75%      100% 
 46.70241 134.98926 160.52134 186.77589 326.96752 
```

99% value is --> 273.7urad

1. Measurement error is "supposed to be contained" in the clamp repro.

**Result**:

Estimated population clamp repro (3s) to be 153urad < 172urad.

**Task 3**: Get Accuracy (set point-measurement) (contains clamp
repro, measurement and accuracy)

**Action 3**: Estimating a naive unbiased estimate

- Clamp1 --> M1 +- t* x se1 and then change position
- Clamp2 --> M2 +- t* x se2 ...
.
.
.
- Clamp --> M9 +- t* x se9

3SD of error (Mi-Ai) --> 3sd of sample x n/n-1

**Pitfall**

Same as clamp repro

**Result**: 

Estimated population clamp repro (3s) to be 472urad < 275urad.

**Task 4**: Meet accuracy requirements

**Action 4**: 

1. 1 cycle --> 472urad value --> 99% chance of success

2. 1 cycle --> 275urad value --> 92% chance of success

3. 2 cycles --> 92% + 8% x 92% --> 99.3% chance of success





