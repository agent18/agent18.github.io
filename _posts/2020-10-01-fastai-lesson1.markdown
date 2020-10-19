---
layout: post
comments: true
title:  "fastai-lessons"
date: 01-10-2020
categories: notes
tags: ml, dl
permalink: /:title.html
published: true
---

## Resources

2018 Lesson 1 wiki: https://forums.fast.ai/t/wiki-thread-lesson-1/6825

course 2018: https://course18.fast.ai/lessonsml1/lesson1.html

2020 setup help: https://forums.fast.ai/t/setup-help/65529

Ubuntu setup help used:

- https://forums.fast.ai/t/pytorch-installation-in-conda-environment-failing/6703/19
 
- https://forums.fast.ai/t/platform-local-server-ubuntu/65851

updates 2020:
https://forums.fast.ai/t/official-part-1-2020-updates-and-resources-thread/63376
  
> ^^ Has all the code pictures and text

2020 book:https://github.com/fastai/fastbook/blob/master/01_intro.ipynb

2020 software fastai repo: https://github.com/fastai/fastai

> ^^ this is fastai v2 written from scratch

2020 course nbs: https://github.com/fastai/fastbook/tree/master/clean

2020 readme page fastai: https://course.fast.ai/#How-do-I-get-started?

2020 lesson 1 wiki: https://forums.fast.ai/t/lesson-1-official-topic/65626

forums: https://forums.fast.ai/ 

Help with setup: https://forums.fast.ai/t/setup-help/65529


Questions and answers: [FASTai questions and answers for each
lesson](https://forums.fast.ai/t/fastbook-questionnaire-solutions-megathread/76955)

Fastai blogs: [fastaiblogs in the fastforum](https://forums.fast.ai/t/fastai2-blog-posts-projects-and-tutorials/65827)


**Old**

fastiai2 - https://github.com/fastai/fastai2 
coursev4 - https://github.com/fastai/course-v4 
fastbook - https://github.com/fastai/fastbook 

## Collection of example projects 



## Lesson 1 Resources

**Basics**

[Lesson 1 video course](https://course.fast.ai/videos/?lesson=1)

[Lesson 1 Official topic 2020](https://forums.fast.ai/t/lesson-1-official-topic/65626)

[fastbook chapter 1](https://github.com/fastai/fastbook/blob/master/01_intro.ipynb)

[MY Paperspace lesson 1 nb](https://n9lqa5lx.gradient.paperspace.com/notebooks/fastbook/clean/01_intro-Copy1.ipynb)

[Lesson 1 hw questions and solutions](https://forums.fast.ai/t/fastbook-chapter-1-questionnaire-solutions-wiki/65647)

**Extra**

[Podcast + Writeups: Summaries + Things Jeremy Says to do +
Qs](https://forums.fast.ai/t/podcast-writeup-summaries-things-jeremy-says-to-do-qs/66194)

[to do types](https://forums.fast.ai/t/did-you-do-the-homework/66034)

## Lesson 1 notes 

**Basic training loop**

``` python
#alt The basic training loop
gv('''ordering=in
model[shape=box3d width=1 height=0.7]
inputs->model->results; weights->model; results->performance
performance->weights[constraint=false label=update]''')
```

You basically have `inputs->model->results`. In DL case you have a
system that can learn and update something.

I.e, `inputs->model->results->performance`, so some metrics and
updating some weights


	inputs->model->results->Performance
	Weights->model
	Performance--> weights
	
For example in the below work:

Inputs: Images, how many times you look at the image (epoch), number of 
Model: CNN
results: trained model to find cat and dog with high probability
Performance: error_rate/accuracy of validation data set
Weights: tuning `parameter` values in the cnn model



**What does this do?**

``` python
# CLICK ME
from fastai.vision.all import *
path = untar_data(URLs.PETS)/'images'

def is_cat(x): return x[0].isupper()
dls = ImageDataLoaders.from_name_func(
    path, get_image_files(path), valid_pct=0.2, seed=42,
    label_func=is_cat, item_tfms=Resize(224))

learn = cnn_learner(dls, resnet34, metrics=error_rate)
learn.fine_tune(1)
```

**ImageDataLoaders**

There are various different classes for different kinds of deep
learning datasets and problems—here we're using ImageDataLoaders. *The
first part of the class name will generally be the type of data you
have, such as image, or text*.

	dls = ImageDataLoaders.from_name_func(
	path, get_image_files(path), valid_pct=0.2, seed=42,
		label_func=is_cat, item_tfms=Resize(224))

**Convolution Neural Networks**

The fifth line of the code training our image recognizer tells fastai
to create a convolution neural network (CNN) and specifies what
architecture to use (i.e. what kind of model to create), what data we
want to train it on, and what metric to use.

	learn = cnn_learner(dls, resnet34, metrics=error_rate)
	
There are many different architectures in fastai, which we will
introduce in this book (as well as discussing how to create your
own). Most of the time, however, **picking an architecture isn't a
very important part of the deep learning process**. It's something
that academics love to talk about, but in practice it is unlikely to
be something you need to spend much time on. **There are some standard
architectures that work most of the time**, and in this case we're
using one called **ResNet** that we'll be talking a lot about during
the book; it is both **fast and accurate for many datasets and
problems**. The **34 in resnet34 refers to the number of layers** in
this variant of the architecture (other options are 18, 50, 101, and
152). Models using architectures with more layers take longer to
train, and are more prone to overfitting (i.e. you can't train them
for as many epochs before the accuracy on the validation set starts
getting worse). On the other hand, when using more data, they can be
quite a bit more accurate.

cnn_learner also has a parameter *pretrained*, which defaults to True
(so it's used in this case, even though we haven't specified it),
which sets the weights in your model to values that have already been
trained by experts to recognize a thousand different categories across
1.3 million photos (using the famous ImageNet dataset). A model that
has weights that have already been trained on some other dataset is
called a pretrained model.

**fine_tune**

`cnn_learner` only describes the "architecture", 

A transfer learning technique where the parameters of a pretrained
model are updated by training for additional epochs using a different
task to that used for pretraining.

So you train for additional epochs (number of times you look at the
each image)

I dont' get this part:

**Don't get this part (Later!)**

When you use the `fine_tune` method, fastai will use these tricks for you. There are a few parameters you can set (which we'll discuss later), but in the default form shown here, it does two steps:

1. Use one epoch to fit just those parts of the model necessary to get the new random head to work correctly with your dataset.
2. Use the number of epochs requested when calling the method to fit the entire model, updating the weights of the later layers (especially the head) faster than the earlier layers (which, as we'll see, generally don't require many changes from the pretrained weights).

The *head* of a model is the part that is newly added to be specific to the new dataset. An *epoch* is one complete pass through the dataset. After calling `fit`, the results after each epoch are printed, showing the epoch number, the training and validation set losses (the "measure of performance" used for training the model), and any *metrics* you've requested (error rate, in this case).

**Note on resnet34**

The 34 in resnet34 refers to the number of layers in this variant of
the architecture (other options are 18, 50, 101, and 152). Models
using architectures with more layers take longer to train, and are
more prone to overfitting (i.e. you can't train them for as many
epochs before the accuracy on the validation set starts getting
worse). On the other hand, when using more data, they can be quite a
bit more accurate.

## Lesson 2 HW questions and answers

[Answers](https://forums.fast.ai/t/fastbook-chapter-1-questionnaire-solutions-wiki/65647)

1. Do you need these for deep learning?

   - Lots of math F
   - Lots of data T
   - Lots of expensive computers F
   - A PhD F
   
2. Name five areas where deep learning is now the best in the world.

	- Natural language processing (NLP):: Answering questions; speech
   recognition; summarizing documents; classifying documents; finding
   names, dates, etc. in documents; searching for articles mentioning a
   concept
   
	- Computer vision:: Satellite and drone imagery interpretation
     (e.g., for disaster resilience); face recognition; image
     captioning; reading traffic signs; locating pedestrians and
     vehicles in autonomous vehicles

	- Medicine:: Finding anomalies in radiology images, including CT,
      MRI, and X-ray images; counting features in pathology slides;
      measuring features in ultrasounds; diagnosing diabetic
      retinopathy
  
	- Biology:: Folding proteins; classifying proteins; many genomics
      tasks, such as tumor-normal sequencing and classifying
      clinically actionable genetic mutations; cell classification;
      analyzing protein/protein interactions
  
	- Image generation:: Colorizing images; increasing image
      resolution; removing noise from images; converting images to art
      in the style of famous artists
  
	- Recommendation systems:: Web search; product recommendations;
      home page layout
  
	- Playing games:: Chess, Go, most Atari video games, and many
      real-time strategy games
  
	- Robotics:: Handling objects that are challenging to locate
      (e.g., transparent, shiny, lacking texture) or hard to pick up
	
	- Other applications:: Financial and logistical forecasting, text
     to speech, and much more...
	 
3. What was the name of the first device that was based on the
   principle of the artificial neuron?
   
   Mark I Perceptron
   
4. Based on the book of the same name, what are the requirements for
   parallel distributed processing (PDP)?
   
   1. A set of *processing units*
   2. A *state of activation*
   3. An *output function* for each unit 
   4. A *pattern of connectivity* among units 
   5. A *propagation rule* for propagating patterns of activities
      through the network of connectivities
   6. An *activation rule* for combining the inputs impinging on a
      unit with the current state of that unit to produce an output
      for the unit
   7. A *learning rule* whereby patterns of connectivity are modified by experience 
   8. An *environment* within which the system must operate
   
   
5. What were the two theoretical misunderstandings that held back the
   field of neural networks?
   
   - NN could not handle functions like XOR
   - NN is slow and too big to be useful 
      
6. What is a GPU?

	GPUS can run NN 100 times faster
	
	Graphics Processing Unit
	
7. Open a notebook and execute a cell containing: `1+1`. What happens?

	2
	
8. Follow through each cell of the stripped version of the notebook
   for this chapter. Before executing each cell, guess what will
   happen.
   
   Documentation can be reached by `doc(PILImage.create)` for
   example.7
   
   didn't understand how to understand PILImage... but moving
   on... Let's try some motherfucking stuff. 
   
   
   
9. Complete the Jupyter Notebook online [appendix](https://github.com/fastai/fastbook/blob/master/app_jupyter.ipynb).

	done.
	
	
10. Why is it hard to use a traditional computer program to recognize
    images in a photo?
	
    > This is very difficult because cats, dogs, or other objects,
    > have a wide variety of shapes, textures, colors, and other
    > features, and it is close to impossible to manually encode this
    > in a traditional computer program.
	
	No simple heuristics that you can come up with for the whole
    general problem.
		
11. What did Samuel mean by "weight assignment"?

	how much each of the million parameters weigh!	
	
	“weight assignment” refers to the current values of the model parameters
	
12. What term do we normally use in deep learning for what Samuel
    called "weights"?
	
	parameters
	
13. Draw a picture that summarizes Samuel's view of a machine learning
    model.
	
	inputs + parameters --> architechutre --> predictions
	
	predictions + labels --> loss
	
	loss --> update
	
14. Why is it hard to understand why a deep learning model makes a
    particular prediction?
	
	because we are using an general function that can solve in theory everything
	
15. What is the name of the theorem that shows that a neural network
    can solve any mathematical problem to any level of accuracy?
	
	universal approximation theorem
	
16. What do you need in order to train a model?

	metric
	input
	program
	initial weights? pre-trained model

17. How could a feedback loop impact the rollout of a predictive
    policing model?
	
	You end up predicting with biases. You start with predicting
    arrests based on the data that already exists. You are not
    "predicting crime", but where "arrests" are going to be made.
	
	Arrests are different from if crime took place... Arrests are a
    proxy. You are only as good as your proxy.
	
18. Do we always have to use 224×224-pixel images with the cat
    recognition model?
	
	Nope we can use what ever the hell we want.
	
19. What is the difference between classification and regression?

	
	> Note: Classification and Regression: classification and regression
	> have very specific meanings in machine learning. These are the two
	> main types of model that we will be investigating in this book. A
	> classification model is one which attempts to predict a class, or
	> category. That is, it's predicting from a number of discrete
	> possibilities, such as "dog" or "cat." A regression model is one
	> which attempts to predict one or more numeric quantities, such as a
	> temperature or a location. Sometimes people use the word regression
	> to refer to a particular kind of model called a linear regression
	> model; this is a bad practice, and we won't be using that
	> terminology in this book!

20. What is a validation set? What is a test set? Why do we need them?


	Validation set to validate the model
	Test set to check at the very end to remain intellectually honest.
	
	Validation set is used to test the hyperparameters by us. So we
    see that the training was poor based on the validation set. Then
    we just go to varying the hyperparameters such as
    architecture. Although the algorithm doesn't see it see it, it
    actually sees it through us.
	
	We want to prevent the computer from memorizing.

	> The solution to this conundrum is to introduce another level of even
	> more highly reserved data, the test set. Just as we hold back the
	> validation data from the training process, we must hold back the
	> test set data even from ourselves. It cannot be used to improve the
	> model; it can only be used to evaluate the model at the very end of
	> our efforts. In effect, we define a hierarchy of cuts of our data,
	> based on how fully we want to hide it from training and modeling
	> processes: training data is fully exposed, the validation data is
	> less exposed, and test data is totally hidden. This hierarchy
	> parallels the different kinds of modeling and evaluation processes
	> themselves—the automatic training process with back propagation, the
	> more manual process of trying different hyper-parameters between
	> training sessions, and the assessment of our final result.

	> Having two levels of "reserved data"—a validation set and a test set,
    > with one level representing data that you are virtually hiding from
    > yourself—may seem a bit extreme. But the reason it is often necessary
    > is because models tend to gravitate toward the simplest way to do good
    > predictions (memorization), and we as fallible humans tend to
    > gravitate toward fooling ourselves about how well our models are
    > performing. The discipline of the test set helps us keep ourselves
    > intellectually honest. That doesn't mean we always need a separate
    > test set—if you have very little data, you may need to just have a
    > validation set—but generally it's best to use one if at all possible.

21. What will fastai do if you don't provide a validation set?

	20% default
	
22. Can we always use a random sample for a validation set? Why or why
    not?
	
	No, in time series you might want to use a time time frame in the
    past to predict a time frame in the future.
	
	why?  not representative of most business use cases (where you are
    using historical data to build a model for use in the future)
	
23. What is overfitting? Provide an example.

	Overfitting refers to when the model fits too closely to a limited
    set of data but does not generalize well to unseen data.

	When you fit both your validations and training set you are bound
    to overfit
	
	When function is not continuous anymore resulting in spurious values

24. What is a metric? How does it differ from "loss"?

	The concept of a metric may remind you of loss, but there is an
    important distinction. The entire purpose of loss is to define a
    "measure of performance" that the training system can use to
    update weights automatically. In other words, a good choice for
    loss is a choice that is easy for stochastic gradient descent to
    use. But a metric is defined for human consumption, so a good
    metric is one that is easy for you to understand, and that hews as
    closely as possible to what you want the model to do. At times,
    you might decide that the loss function is a suitable metric, but
    that is not necessarily the case.
	
	Sound exactly the same to me. I don't have an example for when
    loss and metric are different. I don't know how it would look.
	
	??

25. How can pretrained models help?

	
    > Pretrained models have been trained on other problems that may
    > be quite similar to the current task. For example, pretrained
    > image recognition models were often trained on the ImageNet
    > dataset, which has 1000 classes focused on a lot of different
    > types of visual objects. Pretrained models are useful because
    > they have already learned how to handle a lot of simple features
    > like edge and color detection. However, since the model was
    > trained for a different task than already used, this model
    > cannot be used as is.
	
26. What is the "head" of a model?

	The part that you remove from a pretrained model and then train
    your self. The last part.

27. What kinds of features do the early layers of a CNN find? How
    about the later layers?
	
    
    > Earlier layers learn simple features like diagonal, horizontal,
    > and vertical edges. Later layers learn more advanced features
    > like car wheels, flower petals, and even outlines of animals.
	
28. Are image models only useful for photos?

	no... sound examples exist or anything that you can convert to image.
		
29. What is an "architecture"?

	template for the mathematical functions

30. What is segmentation?
	
	Identifying every individual pixel.
	
31. What is `y_range` used for? When do we need it?

	target range... think of movie reviews.

32. What are "hyperparameters"?

	Knobs we want to tune which are based on the validation set. Sort
    of like parameters that will modify the parameters and
    simulation. 
	
	network architecture, learning rates, data augmentation
    strategies, and other factors
	
	
    > Training models requires various other parameters that define
    > how the model is trained. For example, we need to define how
    > long we train for, or what learning rate (how fast the model
    > parameters are allowed to change) is used. These sorts of
    > parameters are hyperparameters.



33. What's the best way to avoid failures when using AI in an
    organization?
	
	Have a training and a validation and a test set.




## Experiment time?

Experiment time - Most important step according alumni of course
	Signup for bing & extract images
Understand data block api
Build model to perform classification
Interpret confusion matrix
Analyse the results by plotting losses
Exporting model & Inference on any other image of your choice

## Lesson 2 Resources

[Lesson 2 video course](https://course.fast.ai/videos/?lesson=2)

[Lesson 3 video course](https://course.fast.ai/videos/?lesson=3)

[Lesson 2 Official Topic 2020](https://forums.fast.ai/t/lesson-2-official-topic/66294)

[Fastbook chapter 2](https://github.com/fastai/fastbook/blob/master/02_production.ipynb)

[My paperspace lesson 2 nb](https://nth44aap.gradient.paperspace.com/notebooks/fastbook/clean/02_production.ipynb)

[Lesson 2 hw questions and solutions](https://forums.fast.ai/t/fastbook-chapter-2-questionnaire-solutions-wiki/66392)

[Bear\_classifier](https://github.com/fastai/bear_voila)

[How to make a bash file](https://www.taniarascia.com/how-to-create-and-use-bash-scripts/)


binder app; https://mybinder.org/v2/gh/tkravichandran/First-DL-Classifier/main?urlpath=voila%2Frender%2Fobama_classifier_min_binder.ipynb

https://mybinder.org/v2/gh/tkravichandran/bear_voila/master?filepath=voila%2Frender%2Fbear_classifier.ipynb

https://mybinder.org/v2/gh/tkravichandran/bear_voila/master?filepath=voila%2Frender%2Fbear_classifier_2.ipynb

https://mybinder.org/v2/gh/tkravichandran/bear_voila/master?filepath=voila%2Frender%2Fbear_classifier_3.ipynb

https://mybinder.org/v2/gh/tkravichandran/bear_voila/master?urlpath=voila%2Frender%2Fbear_classifier_3.ipynb


### Lesson resources

- [Lesson video](https://youtu.be/BvHmRx14HQ8) (private)
- [Covid-19 masks video](https://youtu.be/BoDwXwZXsDI) (public)
- [fastbook chapter 2](https://github.com/fastai/fastbook/blob/master/02_production.ipynb)
- [fastbook Chapter 2 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-2-questionnaire-solutions-wiki/66392) - feel free to contribute!
- [Non-beginner discussion](https://forums.fast.ai/t/lesson-2-non-beginner-discussion/66511)
- [ Part 1 (2020) - Weekly Beginner Only Review and Q&A](https://forums.fast.ai/t/part-1-2020-weekly-beginner-only-review-and-q-a/66203)
- [Anki deck for Lessons 1 and 2](https://github.com/LauraLangdon/anki)

### Links from lesson

- [Masks research](https://docs.google.com/document/d/1HLrm0pqBN_5bdyysOeoOBX4pt4oFDBhsC_jpblXpNtQ/edit?usp=sharing)
- [masks4all](https://docs.google.com/document/d/1EWpWmyjzM4sNBF-7jp_1Y9a-pqiRg0wakGXy7kj11RA/edit) - from Czech Republic
- [Publication "The ASA Statement on *p* -Values"](https://amstat.tandfonline.com/doi/full/10.1080/00031305.2016.1154108) & [article "
  Null Hypothesis Significance Testing Never Worked"](https://www.fharrell.com/post/nhst-never/)
- [Designing great data products](https://www.oreilly.com/radar/drivetrain-approach-data-products/)
- [Bing Image Search API](https://azure.microsoft.com/en-us/services/cognitive-services/bing-image-search-api/)

### Deployment guides

- Deploying the Bear Detector app with Flask + Gunicorn + Domain name
  with SSL certificate, plus Dockerizing the app:
  https://github.com/fastai/course-v3/blob/master/docs/deployment_flask_gunicorn_docker.md
  (just sent pull request to correct missing /docs in link to image
  oops)
  
- Deployment Platform: [SeeMe.ai - the AI marketplace](https://seeme.ai): Easily
  deploy and share your Fastai (v1 and v2) models on the web, mobile,
  Python SDK, .... We have added support for `fastai2` and will
  continue to support it throughout its development to a stable
  version.  We created a [`fastai2` deployment quick guide](https://github.com/zerotosingularity/seeme-quick-guides/blob/master/seeme-quick-guide-fastai-v2.ipynb), taking
  you through all the steps of training, deploying, using, and sharing
  your model with your friends and the world.  Additional links:
  [Deployment platform: Seeme.ai - wiki topic](https://forums.fast.ai/t/deployment-platform-seeme-ai/66270/) | [Fastai v1 quick
  guide](https://github.com/zerotosingularity/seeme-quick-guides/blob/master/seeme-quick-guide-fastai-v1.ipynb)
  
- Deployment Platform: [Amazon SageMaker](https://aws.amazon.com/sagemaker/). Follow the steps
  outlined in the [following post](https://forums.fast.ai/t/deployment-platform-amazon-sagemaker/66439) to train and deploy your fastai2
  model with Amazon SageMaker.
  
- Deployment Platform: [Azure Functions](https://docs.microsoft.com/azure/azure-functions/). Follow the steps outlined
  in this [Github repo](https://github.com/gopitk/fastai2deployazure) to deploy a trained fastai2 model on Azure
  cloud's serverless infrastructure service -- the Azure
  Functions. Welcome your feedback and questions on this [topic
  thread](https://forums.fast.ai/t/deployment-platform-azure-functions/67076).

### Deployment examples

- [Bear Detector web app](https://github.com/muellerzr/fastai2-Starlette): a Starlette example for deployment in
  fastai2
- [Derotate](https://github.com/sebderhy/derotate): a code template for image-to-class and image-to-image
  fastai2 deployments with web app, mobile app (in [Flutter](https://github.com/flutter/flutter)), and
  [a notebook](https://github.com/sebderhy/derotate/blob/master/test_api.ipynb) showing how to call the model remotely as an API.
- [Bear detector web app deployed with flask](https://github.com/javismiles/bear-detector-flask-deploy): example of the bear
  detector app deployed with fast.ai v2, flask, gunicorn and nginx

### Other useful links

- [Lesson Summaries + Things Jeremy Says to do + Qs](/t/podcast-writeup-summaries-things-jeremy-says-to-do-qs/66194)
- [Notes](https://www.notion.so/Lesson-2-a286cc6495784ccf9917668fd42cb2a0) by @Lankinen
- [Statistical tests,  *P*  values, confidence intervals, and power: a guide to misinterpretations](https://link.springer.com/article/10.1007/s10654-016-0149-3)

## Lesson 2 notes

[Getting bing images](https://forums.fast.ai/t/getting-the-bing-image-search-key/67417) for the key

To get key once done go [here](https://azure.microsoft.com/en-us/try/cognitive-services/my-apis/?apiSlug=search-api-v7) or [generally](https://azure.microsoft.com/en-us/try/cognitive-services/?api=bing-image-search-api)

Metrics are printed out after we look at every single image ONCE (each
epoch each time you have "looked" at all the images).

overfitting example needed

loss and metric example needed

loss could be error_rate but in the classification problem, a small
change in parameters won't result in change in classification from dog
to cat. so we need something else other than `error_rate`. and we
continue to use metrics to understand overfitting.


**Overfitting**

Overfitting is measured by looking at the METRICS that come out of the
validation set. The fastai program doesn't see the validation set for
"training". training for data that hasn't seen before is the objective

Don't want to memorize

You still end up cheating/overfitting as you look at the metrics
(produced by the validation data) and change the `hyperparameters`.

Something about training loss validation loss and metric decrease and
how to identify if you are overtraining... din't quite get that `15:56`?


**Fine tuning unclear?**

is unclear what he means that first you use one epoch and then you use

> When you use the fine_tune method, fastai will use these tricks for
> you. There are a few parameters you can set (which we'll discuss
> later), but in the default form shown here, it does two steps:

> Use one epoch to fit just those parts of the model necessary to get
> the new random head to work correctly with your dataset.  Use the
> number of epochs requested when calling the method to fit the entire
> model, updating the weights of the later layers (especially the
> head) faster than the earlier layers (which, as we'll see, generally
> don't require many changes from the pretrained weights).


**transfer learning**

2012 imagenet winners using visualization Zeiler and Fergus

**Applications**

vision
tabular
text
recsys

**Where to look**

Modelzoo
pretrained model deep learning
imagenet

Medical images not there

**Read paper**

High temperature and High Humidity reduce the transmission of covid-19

check out blog post on how to do machine learning how to ask the right
questions `1:08:00`

**Brilliant**

Jeremy uses p-value to discredit a paper. Someone predicts a trend
between temperature and R (a measure of covid transmicsibility) by
plotting for 100 cities and shows the **situation** `52:00`.

Task being if this happened by chance? Of course there is the whole
causation correlation discussion. *But this chance thing is extremely
interesting.*

Jeremy takes a similar std deviation and a mean and randomly plots 100
cities and see what sort of R and temp he gets. Unrealistically he
then ends up discrediting the paper. I think what would be nice is a
p-value of many such simulations and where the prediction stands among
a null hypothesis. :) GREAT.

Here he also effectively tests what happens when you look at only 100
cities.

But the american statistical association **hates p-values**. Be
**Careful** while using them? What was the conclusion? `57:59`

One of the **Claim**: more data you use the p value becomes smaller!
so don't use threshold?

Jeremy **suggests** that a multivariate model i.e., transmission
dependent on gdp, density of cities and temperature and then you have
a p-value of 0.01

**Check out work by Frank Harell about p-values**

**Bing Image Search API**

Gives info such as URLs of images from the internet which are labeled.



## Error upon running notebook

	RuntimeError: DataLoader worker (pid 19862) is killed by signal:
	Killed.
	
Seems to be a [memory issue](https://forums.fast.ai/t/lesson-2-official-topic/66294/467?u=thetj09). Somehow it switched to only CPU and
the GPU plan got removed. Started a new notebook container.

Somehow the system in gradient changed from P5000 to CPU. I don't
understand how though.

|            | GPU  | CPU  |
|------------|------|------|
| Free-P5000 | 16GB | 30GB |
| Free-GPU   | 8GB  | 30GB |
| Free-cpu   | 0GB  | 2gGB |
| My PC      | 4GB  | 8GB  |


Follow [this issue](https://forums.fast.ai/t/lesson1-issues-with-gradient-instance/77813/3), apparently it is not supposed to go to
"Free-CPU". What a cunt program. And there seems to be a guy who
potentially could help from paperspace.

## Lesson 2 HW questions and answers

[Flashcards of Lesson 2 questions and answers](https://quizlet.com/512143734/fastai-chapter-2-questionnaire-flash-cards/?x=1jqt)

1. Provide an example of where the bear classification model might
   work poorly in production, due to structural or style differences
   in the training data.
   
   - Say black and white images
   - bear hiding behind tree
   - bear and people perhaps?
   - polar bear perhaps
   - hand drawn bears
   - night time images
   - small in the picture bear?

2. Where do text models currently have a major deficiency?

	> Deep learning is also very good at generating
	> context-appropriate text, such as replies to social media posts,
	> and imitating a particular author's style. It's good at making
	> this content compelling to humans too—in fact, even more
	> compelling than human-generated text. However, deep learning is
	> currently not good at generating correct responses! We don't
	> currently have a reliable way to, for instance, combine a
	> knowledge base of medical information with a deep learning model
	> for generating medically correct natural language
	> responses. This is very dangerous, because it is so easy to
	> create content that appears to a layman to be compelling, but
	> actually is entirely incorrect.
	
3. What are possible negative societal implications of text generation
   models?
   
    > Another concern is that context-appropriate, highly compelling
    > responses on social media could be used at massive
    > scale—thousands of times greater than any troll farm previously
    > seen—to spread disinformation, create unrest, and encourage
    > conflict. (fake news)
   
4. In situations where a model might make mistakes, and those mistakes
   could be harmful, what is a good alternative to automating a
   process?
   
   Regular interventions to check by human pros. E.g., medical
   diagnoses
   
   For example, a machine learning model for identifying strokes in CT
   scans can alert high priority cases for expedited review, while
   other cases are still sent to radiologists for review
   
5. What kind of tabular data is deep learning particularly good at?

    > Deep learning is good at analyzing tabular data that includes
    > natural language, or high cardinality categorical columns
    > (i.e. Zip codes)
	
6. What's a key downside of directly using a deep learning model for
   recommendation systems?
   
   
 
    > Machine learning approaches for recommendation systems will
    > often only tell what products a user might like, and may not be
    > recommendations that would be helpful to the user. For example,
    > if a user is familiar with other books from the same author, it
    > isn’t helpful to recommend those products even though the user
    > bought the author’s book. Or, recommending products a user may
    > have already purchased.
	
	After deep learning the model knows what X has bought in the
    past. But that doesn't mean X will buy that or similar stuff like
    (boxed set of Harry potter novels).
   
7. What are the steps of the Drivetrain Approach?

	Objective --> Levers --> DATA --> Models
	
	Show most relevant search --> rankings of search results --> get
    data on linked sites --> build model
	
	Vague... move on
	
8. How do the steps of the Drivetrain Approach map to a recommendation
   system?
   
   
    > The objective of a recommendation engine is to drive additional
    > sales by surprising and delighting the customer with
    > recommendations of items they would not have purchased without
    > the recommendation. The lever is the ranking of the
    > recommendations. New data must be collected to generate
    > recommendations that will cause new sales . This will require
    > conducting many randomized experiments in order to collect data
    > about a wide range of recommendations for a wide range of
    > customers. This is a step that few organizations take; but
    > without it, you don’t have the information you need to actually
    > optimize recommendations based on your true objective (more
    > sales!)
	
	Vague... Move on
   
9. Create an image recognition model using data you curate, and deploy
   it on the web.
   
   deploy not yet... Maybe after lesson 3????????/ as I don't know how
   to deploy it yet.
   
10. What is `DataLoaders`?

	> DataLoaders is a thin class that just stores whatever DataLoader
	> objects you pass to it, and makes them available as train and
	> valid. Although it's a very simple class, it's very important in
	> fastai: it provides the data for your model.
	
11. What four things do we need to tell fastai to create
    `DataLoaders`?
	
	> - What kinds of data we are working with
    > - How to get the list of items
    > - How to label these items
    > - How to create the validation set
	
12. What does the `splitter` parameter to `DataBlock` do?

	splits data to valid and train.
	
13. How do we ensure a random split always gives the same validation
    set?
	
	seed
	
14. What letters are often used to signify the independent and
    dependent variables?
	
	x for independent and y for dependent
	
	> The independent variable is the thing we are using to make
	> predictions from, and the dependent variable is our target. In
	> this case, our independent variables are images, and our
	> dependent variables are the categories (type of bear) for each
	> image
	
15. What's the difference between the crop, pad, and squish resize
    approaches? When might you choose one over the others?
	
	Not yet covered ?????????
	
16. What is data augmentation? Why is it needed?

	Not yet covered ????????
	
17. What is the difference between `item_tfms` and `batch_tfms`?

	Not yet coverd ????????
	
18. What is a confusion matrix?

	> let's see whether the mistakes the model is making are mainly
	> thinking that grizzlies are teddies (that would be bad for
	> safety!), or that grizzlies are black bears, or something else
	
	It is calculated (Of course) based on the valid set.

19. What does `export` save?

	pickle file i.e., model readily usable
	
	> export saves both the architecture, as well as the trained
	> parameters of the neural network architecture. It also saves
	> how the DataLoaders are defined.
	
20. What is it called when we use a model for getting predictions,
    instead of training?
	
	Inference
	
21. What are IPython widgets?

	
	
22. When might you want to use CPU for deployment? When might GPU be
    better?
	
	64 images batch at a time GPU
	
	CPU for serial stuff e.g., 
	
	
	
23. What are the downsides of deploying your app to a server, instead
    of to a client (or edge) device such as a phone or PC?
	
	> The application will require network connection, and there will
	> be extra network latency time when submitting input and
	> returning results. Additionally, sending private data to a
	> network server can lead to security concerns.
	
24. What are three examples of problems that could occur when rolling
    out a bear warning system in practice?
	
	- false positives
		- unseen data
	- unknown regions (night time imaging not good)
	- speed of prediction
	- resolution of images
	
25. What is "out-of-domain data"?

	> Data that is fundamentally different in some aspect compared to
	> the model’s training data. For example, an object detector that
	> was trained exclusively with outside daytime photos is given a
	> photo taken at night.

26. What is "domain shift"?

	
    > This is when the type of data changes gradually over time. For
    > example, an insurance company is using a deep learning model as
    > part of their pricing algorithm, but over time their customers
    > will be different, with the original training data not being
    > representative of current data, and the deep learning model
    > being applied on effectively out-of-domain data.
	
27. What are the three steps in the deployment process?

## hacks

use `function.__module__` to know where it comes from. Use `?` and
`??` to see the code. And `doc()` to see what is happening with the 

### Resources

- [What Jeremy says](https://youtu.be/BvHmRx14HQ8?t=4485)

- Example [blogs, projects and tutorial](https://forums.fast.ai/t/fastai2-blog-posts-projects-and-tutorials/65827)

- [Project Group thread](https://forums.fast.ai/t/official-project-group-thread/65817)

- Lesson 1 TOP examples

## todo
  * [ ] add and display blog locally
  * [ ] add comments to a fastpost
  * [ ] Decide what to write on the post
  * [ ] clean up the blog
  * [ ] Write and publish post

## Lesson 3 Resources

[Lesson 3 video course](https://course.fast.ai/videos/?lesson=3)

[Lesson 3 Official Topic 2020](https://forums.fast.ai/t/lesson-3-official-topic/67244)

* [fastbook chapter 2 ](https://github.com/fastai/fastbook/blob/master/02_production.ipynb)
* [fastbook chapter 4 ](https://github.com/fastai/fastbook/blob/master/04_mnist_basics.ipynb)

* [fastbook chapter 2 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-2-questionnaire-solutions-wiki/66392)
* [fastbook chapter 4 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-4-questionnaire-solutions-wiki/67253) 

### Lesson resources

* [Video link](https://youtu.be/5L3Ao5KuCC4) (private)
* [fastbook chapter 2 ](https://github.com/fastai/fastbook/blob/master/02_production.ipynb)
* [fastbook chapter 4 ](https://github.com/fastai/fastbook/blob/master/04_mnist_basics.ipynb)
* [Non-beginner discussion](https://forums.fast.ai/t/lesson-3-non-beginner-discussion/67248)
* [fastbook chapter 2 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-2-questionnaire-solutions-wiki/66392)
* [fastbook chapter 4 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-4-questionnaire-solutions-wiki/67253) - feel free to contribute!

### Links from lesson

* [#mask4all](https://masks4all.co/)
* [Jeremy's Washington Post article](https://www.washingtonpost.com/outlook/2020/03/28/masks-all-coronavirus/)
* [Building Machine Learning Powered Applications](https://www.oreilly.com/library/view/building-machine-learning/9781492045106/) - by Emmanuel Ameisen
* [Actionable Auditing](https://dam-prod.media.mit.edu/x/2019/01/24/AIES-19_paper_223.pdf) - by Deborah Raji

### Other useful links

[Notes](https://www.notion.so/Lesson-3-bce5575977c34c4db470f468bddb7c69) by @Lankinen

## Lesson 3 Notes



## Lesson 3 HW questions and answers
### Coming days

  * [x] Lecture 3 video
  * [x] start with application notebook
  * [ ] deploy application
  * [ ] think of where it can be used in my current setting
  
  * [ ]  Do the questions
  
    * [ ] chapter 2 
	* [ ] chapter 3
  
  

