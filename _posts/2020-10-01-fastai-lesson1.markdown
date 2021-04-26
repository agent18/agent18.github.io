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
the architecture (other options are **18, 50, 101, and 152**). Models
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


[my binder app](https://mybinder.org/v2/gh/tkravichandran/First-DL-Classifier/main?urlpath=voila%2Frender%2Fobama_classifier_min_binder.ipynb)

[Share your V2 projects here](https://forums.fast.ai/t/share-your-v2-projects-here/65757/3)

[Blogs, projects and other](https://forums.fast.ai/t/blog-posts-projects-and-articles/1736)

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

## Deployment errors

### binder does not work

[forked bear-viola](https://github.com/tkravichandran/bear_voila) from the main hosters and it didn't work with binder
and there was no way to see what the error was.

### Heroku

With heroku I had to add a `requirement.txt`, `runtime.txt`
(specifying the right version of python for the ones in the
`requirement.txt`). `Procfile` allows to add `--debug` option which
shows errors.

So, `Procfile` [with and without debug](https://github.com/tkravichandran/First-DL-Classifier/commit/a3f01b1081d08c8e335692adaf4d4c9284468a6e#diff-0a99231995da379e7aebabe76c9d849a23737a42c3b3a8994043e2aa80958424):

``` text
web: voila --port=$PORT --no-browser --enable_nbextensions=True obama_classifier_min_binder.ipynb
```

``` text
web: voila --debug --port=$PORT --no-browser --enable_nbextensions=True obama_classifier_min_binder.ipynb
```

`Requirement.txt` now has and seems to need only the following for
lesson 2. Note that **Haroku only allows 950Mb slugs, so we use CPU
version of pytorch** as a result:

``` text

https://download.pytorch.org/whl/cpu/torch-1.6.0%2Bcpu-cp38-cp38-linux_x86_64.whl
https://download.pytorch.org/whl/cpu/torchvision-0.7.0%2Bcpu-cp38-cp38-linux_x86_64.whl
fastai==2.0.11
voila
ipywidgets
```

Lastly we need to specify the exact python version in `runtime.txt`
other wise we get the ` not the right wheels` error.

``` text
python-3.8.5
```

Most useful links were that of the [old fast ai deployment on haroku
guide](https://course.fast.ai/deployment_heroku) and the link of someone for who this worked aka [whatgame](https://github.com/mesw/whatgame3).

**Useful links**

[Link 1](https://forums.fast.ai/t/deploying-in-heroku-error-not-a-supported-wheel-on-this-platform/76196)

[Link 2](https://forums.fast.ai/t/anyone-using-heroku-to-deploy-a-fastai2-model/79070)

[Other github repos](https://github.com/mahtabsyed/PyTorch-fastaiv2-bears-classification)

[Other github repos from which I copied ideas](https://github.com/mesw/whatgame3)

[Successful deployment by agent](https://github.com/tkravichandran/First-DL-Classifier)

## Writing the blog lessons fastai

I am thinking I should start with the basics of data.... how I clean,
how I do other things and then finish with the app. Basically take
people through the entire journey of development.

More info about [fast yaml front matter is here](https://github.com/fastai/fastpages#customizing-blog-posts-with-front-matter)

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
   
   done. 
   
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
	
	seed in Data loaders or split ahead of time.
	
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
	
	crops, pads adds pad, squish compresses image. random crop is
	preferred as all the information is still available at each epoch.
	
16. What is data augmentation? Why is it needed?

	To account for rotations in the image, change in contrast, black
    and white... better result on validity.
	
17. What is the difference between `item_tfms` and `batch_tfms`?

	One by one and the other one are transforms to be performed on a batch.
	
	
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

	widgets such as upload button.
	
22. When might you want to use CPU for deployment? When might GPU be
    better?
	
	CPU for running on one image (deployment)
	
	GPU for running on multiple images (aka modelling)
	
	
	
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

	Manual process
	limited scope
	gradual expansion

## Hacks Documentation

https://stackoverflow.com/a/64708015/5986651

All things should have __module__ attributes usually.

**Find info on**

Use `function.__module__` to know where it comes from. Use `?` and
`??` to see the code. And `doc()` to see what is happening with the 

`first?`, `first??` pandain le...

> In python, `__module__` is for class var, `requires_grad_` is a member
> method of torch.Tensor(), it is not a class instance, so it has no
> __module__ attr.




## Other lesson 2 Resources

- [What Jeremy says](https://youtu.be/BvHmRx14HQ8?t=4485)

- Example [blogs, projects and tutorial](https://forums.fast.ai/t/fastai2-blog-posts-projects-and-tutorials/65827)

- [Project Group thread](https://forums.fast.ai/t/official-project-group-thread/65817)

- [Official 2020 Project group thread](https://forums.fast.ai/t/official-project-group-thread/65817)

- Lesson 1 TOP examples


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

1. Look at data properly e.g., looking at "good skin" and getting
   white people touching their faces
   
2. Always create a baseline

3. 

### pytorch gradient

	xt = tensor([3.,4.,10.]).requires_grad_()
	yt=f(xt) #some function say def f(x): return x**2
	
	yt.backward() # makes the gradient
	xt.grad() # accesses the gradient at points in xt.

Cat is for concatenation, view is for reshaping. `-1` is for the
function to figure out the dimension.

	train_x = torch.cat([stacked_threes, stacked_sevens]).view(-1, 28*28)

`Unsqueeze` is for redimensioning "vector" into a a tensor of
different dimensions such as `2000,1` or `1,2000` from just `2000`.

	train_y = tensor([1]*len(threes) + [0]*len(sevens)).unsqueeze(1)

Getting a tuple from `image+label`

	dset = list(zip(train_x,train_y))
	x,y = dset[0]
	x.shape,y

## Todo

  * [ ] run and understand the cells
  * [ ] do hw cosins
## Lesson 3 HW questions and answers

### Coming days

  * [x] Lecture 3 video
  * [x] start with application notebook
  * [x] deploy application
  * [x] think of where it can be used in my current setting
  
  * [x]  Do the questions
  
    * [x] chapter 2 
	* [ ] chapter 3??
  
## Lesson 4

[Official topic](https://forums.fast.ai/t/lesson-4-official-topic/68643)

This is lesson 4, which is week 5 since last week was out of order.

Note: This is a wiki post - feel free to edit to add links from the lesson or other useful info.

## Resources

- [Video](https://youtu.be/p50s63nPq9I)
- [fastbook chapter 4](https://github.com/fastai/fastbook/blob/master/04_mnist_basics.ipynb)
- [fastbook chapter 4 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-4-questionnaire-solutions-wiki/67253)
- [fastbook chapter 5](https://github.com/fastai/fastbook/blob/master/05_pet_breeds.ipynb)
- [fastbook chapter 5 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-5-questionnaire-solutions-wiki/69301)
- [Non-beginner discussion](https://forums.fast.ai/t/lesson-4-non-beginner-discussion/68662)

## Links from lesson
- [Face Masks Against COVID-19: An Evidence Review](https://www.preprints.org/manuscript/202004.0203/v1)

## Other useful links
[Notes](https://www.notion.so/lankinen/Lesson-4-97aa1415857d48f9a1c8a0de70d71a06) by @Lankinen

### python R summary equivalent


Without pandas:

from scipy import stats

stats.describe(lst)
stats.scoreatpercentile(lst,(5,10,50,90,95))

Here is an example:

```python
from scipy import stats
import numpy as np

stdev = 10
mu =  10
a=stdev*np.random.randn(100)+mu
stats.describe(a)
```

```
[OUT1]: DescribeResult(nobs=100, minmax=(-13.180682481878286, 40.6109521437826), mean=10.352380786199149, variance=103.27168865119998, skewness=0.13852516641657087, kurtosis=0.2691915766145532)
```

``` python 
stats.scoreatpercentile(a,(5,10,50,90,95))
```

```
[OUT2]: array([-7.21731609, -3.22696662, 10.39364637, 21.78527621, 24.20685179])
```
### plot tensor

```
im3_t = tensor(im3)
df = pd.DataFrame(im3_t[4:15,4:22])
df.style.set_properties(**{'font-size':'6pt'}).background_gradient('Greys')
```


### list zip; combine two tensors

``` python
dset= list(zip(train_x,train_y))
x,y = dset[0]
x.shape,y

[Out1]: (torch.Size([784]), tensor([1]))
```

### generate quick tuples

https://discuss.pytorch.org/t/leaf-variable-was-used-in-an-inplace-operation/308

``` python
ds = L(enumerate(string.ascii_lowercase))
ds
```

### make a quick list

``` python
import random
my_randoms = random.sample(range(100), 10)
```
### leaf variable non-leaf variable

Loosely, tensors you create directly are leaf variables. Tensors that are the result of a differentiable operation are not leaf variables

For example:

``` python
w = torch.tensor([1.0, 2.0, 3.0]) # leaf variable
x = torch.tensor([1.0, 2.0, 3.0], requires_grad=True) # also leaf
variable
y = x + 1  # not a leaf variable
```

An in-place operation is something which modifies the data of a
variable. For example:

``` python
x += 1  # in-place
y = x + 1 # not in place
```

PyTorch doesn't allow in-place operations on leaf variables  that have
`requires_grad=True` (such as parameters of your model) because the
developers could not decide how such an operation should behave. If
you want the operation to be differentiable, you can work around the
limitation by cloning the leaf variable (or use a non-inplace version
of the operator).

``` python
x2 = x.clone()  # clone the variable
x2 += 1  # in-place operation
```

### runtimeerror leaf variable

``` python
RuntimeError: a leaf Variable that requires grad is being used in an
in-place operation.
```

> The new style to express this is to use torch.no_grad() to signify
> that you don’t want to track the gradient of this operation (but
> z.data is OK too):

### Shuffle=true not working in dataloader

I don't know what it is but in lesson 4, if I run with shuffle =true I
get validation results of 50% meaning somewhere things are lost in
translation. i.e., the correlation between pictures and their labels
don't exist anymore.


### Making grad zero

2 ways

``` python
/p.grad.zero_()
p.grad = None
```


## course to do

Statistics course, SQL, keras, tensorflow

## Lesson 4-5


## Notes 4-5


So basically we start with:

1. Predictions for each breed [1x37] per image (? Unsure how it is
   calculated). I know how to do predictions per value (`Tens@w +b`).

2. Predictions as probabilities using Softmax --> `e^x/e^x.sum()` -->
   e^x also hypes exagerrate the gap (e^1 and e^1.2 has a difference
   of 0.6) --> **Activations**
   
3. Loss is based on NLL (negative Log Likelihood) --> torch.where
   function for more than 2 classifications. 
   
		-sm_acts[idx, targ]
		
		F.nll_loss(sm_acts, targ, reduction='none')
		
	Loss based on target.

4. Take log of Activations to exaggerate difference between 0.99 and
   0.999.
   This is done in softmax as log_softmax. When we are optimizing the
   system will treat 0.999 from 0.99 as a crazy improvement. That is
   what we are going for as suggested [here](https://stats.stackexchange.com/questions/174481/why-to-optimize-max-log-probability-instead-of-probability).
   
5. Log_softmax + negative log likelihood is Cross entropy.


6. What does path object do? is it an object? 

7. Issues with my nn (why random was not working)? 

Time to delve deep into this shit? 

1. Understand whats happening with the DataBlock

2. using a number other than 0.5 in predictions

3. What do the @'s do?

4. Why value of preds,_ = `learn.get_preds(0)` takes time and is
   different from `preds,_ = learn.get_preds(dl=[(x,y)])`
   
5. How do you get many activations? for 3 and 7? How do you generate
   37 activations? What are the activations in the 3 or 7 case?
   get_preds()
   
   How do you get 2 predictions one for 3 category and 7 category
   where are the 2 activations?
   
   How to get 2 activations for binary case which then becomes [0.4
   and 0.6] based on softmax (exp(x)/exp(x).sum)


## Lesson 5 nb3

[Lesson 5 wiki](https://forums.fast.ai/t/lesson-5-official-topic/68039?u=thetj09)

[This](https://forums.fast.ai/t/lesson-5-official-topic/68039?u=thetj09) is a wiki post - feel free to edit to add links from the lesson or other useful info.

**Note that the video and this thread is called "lesson 5" because that's what this will be in the MOOC, even although it's week 4 of the course**

## Lesson resources

* [Edited video](https://youtu.be/krIVOb23EH8) (private)
* [fastbook chapter 3](https://github.com/fastai/fastbook/blob/master/03_ethics.ipynb)
* [Non-beginner discussion ](https://forums.fast.ai/t/lesson-4-non-beginner-discussion/68040)

## Links from lesson

- [Rachel's longer lesson on disinformation & coronavirus](https://www.youtube.com/watch?v=ogvPNzb9ai4&list=PLtmWHNX-gukIWztK2C0eHKnXbPDuiES7x&index=2&t=0s)

- [Rachel's follow-up post on privacy & surveillance during pandemic](https://forums.fast.ai/t/privacy-surveillance-during-a-pandemic/68084)

## Other useful links

* [Datasheets for datasets](https://arxiv.org/abs/1803.09010)
* [Weapons of math destruction](https://weaponsofmathdestructionbook.com/)
* [AI Generated Faces](https://www.thispersondoesnotexist.com/)
* [Papers/repos/tools on how to check for bias in your datasets/algorithms AND address it](https://forums.fast.ai/t/lesson-4-official-topic/68039/136?u=frapochetti)
* [Markkula Center - Ethical Toolkit](https://www.scu.edu/ethics-in-technology-practice/ethical-toolkit/)
* [ The Pollyannish Assumption](https://stratechery.com/2017/the-pollyannish-assumption/)
* [Understanding the context and consequences of pre-trial detention](https://facctconference.org/2018/livestream_vh210.html)
* [Fast.ai community ethics resources & discussion thread. Author credit: nbharatula](https://forums.fast.ai/t/ai-ml-ethics-biases-responsibility/45592)
* [Montreal AI Ethics Institute Weekly Newsletter #6:  Radioactive data, attacking deep RL, steering AI progress, sucker's list, AI ethics in marketing and more ...](https://aiethics.substack.com/p/ai-ethics-6-radioactive-data-attacking)


## Lesson 6 nb5 nb6 nb8

Note: This is a wiki post - feel free to edit to add links from the lesson or other useful info.

## Resources

* [Video](https://youtu.be/cX30jxMNBUw) (private)
* [fastbook chapter 5 ](https://github.com/fastai/fastbook/blob/master/05_pet_breeds.ipynb)
* [fastbook chapter 5 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-5-questionnaire-solutions-wiki/69301) - feel free to contribute!
* [fastbook chapter 6](https://github.com/fastai/fastbook/blob/master/06_multicat.ipynb)
* [fastbook chapter 6 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-6-questionnaire-solutions-wiki/69922) - feel free to contribute!
* [fastbook chapter 8](https://github.com/fastai/fastbook/blob/master/08_collab.ipynb)
* [fastbook chapter 8 questionnaire solutions](https://forums.fast.ai/t/fastbook-chapter-8-questionnaire-solutions-wiki/69926) - feel free to contribute!
* [Non-beginner discussion](https://forums.fast.ai/t/lesson-6-non-beginner-discussion/69308)

## Links from lesson
* Python for Data Analysis - Wes McKinney - [link](http://shop.oreilly.com/product/0636920023784.do)


## Other useful links
* BCE vs BCEWithLogitLoss - Pytorch Forum Discussion - [link](https://discuss.pytorch.org/t/bceloss-vs-bcewithlogitsloss/33586/5)
* Mixed Precision Training Comparison - [link](https://hackernoon.com/rtx-2080ti-vs-gtx-1080ti-fastai-mixed-precision-training-comparisons-on-cifar-100-761d8f615d7f)
* [Notes](https://www.notion.so/lankinen/Lesson-6-c5078fdd28e74dc8a443fb5923566a6e) by @Lankinen

## Lesson 6 nb 5 notes

**Learner explanation and how to get better accuracy**

- Learning rates need to be found
  - ROT: min/10
  
- Using the same LRs for all epochs doesn't work 
  - e.g., start with Lr of first epoch and then check LR using LR_find
    #pnn
  - Use `fit_one_cycle` --> Apparently it starts with low LR and then
    gradually increases it to the middle and reduces it again towards
    the end of layers. I guess this is when you use or provide an `lr_max`.
	
- Using the same LRs across all layers is another criminal waste of
  time. `Disciminative LRs` Lower layers barely need any change, upper layers need change.
  - 

- fine_tune() 
  - Freezes the layers until -1 (`self.freeze`)
  - Number of epocs where only the last layer is trained is usually
    `freeze_epocs=1`
  - now you do `fit_one_cycle` for epochs = Freeze_epochs
  - then `unfreeze()`
  - and `fit_one_cycle` for X number of epochs
  
- If you find that it plateaus at 8th epoch out of 12 epochs, rerun
  till 8. `overshooting`

- cnn_learner `freezes` by default <-- **Important**

- We could also choose a higher artchitechture (but it takes more time
  to work it and potnetially `cuda gpu error`)
  
- Might need to do cross-validation to improve accuracy



**Other things to speed up with same accuracy**

`learn = cnn_learner().to_fp16()`

```
from fastai.callback.fp16 import *
learn = cnn_learner(dls,resnet50,metrics=f1_score_multi).to_fp16() 
```


**Questions**




1. How is one epoch trained? 
Is SGD changing per batch

2. Why value of preds,_ = `learn.get_preds(0)` takes time and is
   different from `preds,_ = learn.get_preds(dl=[(x,y)])`
   
   
3. Why lr_steep is important? why not lr_min?

4. Why is Jeremy training frozen for 3 epocs?

5. how to make the model better at the issues raised by interpretation class.

6. - HOW TO IMPROVE FURTHER? WHAT HAVE OTHER PEOPEL DONE?

7. Look up the documentation for L and try using a few of the new methods is that it adds.
8. Look up the documentation for the Python pathlib module and try using a few methods of the Path class.
9. For the loss you go all the way with NLL, but for the PRedictions
   you only do softmax?


## Lesson 6 nb6 notes

**Datablocks**

> Dataset:: A collection that returns a tuple of your independent and
> dependent variable for a single item   
> DataLoader:: An iterator that provides a stream of mini-batches,
> where each mini-batch is a tuple of a batch of independent variables
> and a batch of dependent variables


> Datasets:: An object that contains a training Dataset and a
> validation Dataset  
> DataLoaders:: An object that contains a training DataLoader and a validation DataLoader


Dataset --> 1 tuple
DataLoader --> Contains mini-batch tuples

Dataset**s** --> contains both training and valid DS
DataLoader**s** --> mini batch tuples of both contains both training
and valid DL


1. Create DataBlock
2. Pass `get_x` `get_y` functions
3. `dblock` contains `dsets` (just tuples) and `dloaders` (mini-batch)
4. All components together including a regularized splitter function


``` python
def splitter(df):
    train = df.index[~df['is_valid']].tolist()
    valid = df.index[df['is_valid']].tolist()
    return train,valid

dblock = DataBlock(blocks=(ImageBlock, MultiCategoryBlock),
                   splitter=splitter,
                   get_x=get_x, 
                   get_y=get_y)

dsets = dblock.datasets(df)
dsets.train[0]
```

1. Including grabbing the right image portion using `item_tfms`

``` python
dblock = DataBlock(blocks=(ImageBlock, MultiCategoryBlock),
                   splitter=splitter,
                   get_x=get_x, 
                   get_y=get_y,
                   item_tfms = RandomResizedCrop(128, min_scale=0.35))
dls = dblock.dataloaders(df)
```


**Note** there is already some randomization within the `dsets` even,
whether you create mini-batch or not (within the training set and
within the valid set I mean)

**Tabular random splitter**

``` python
np.random.seed(42)
msk = np.random.rand(len(df)) < 0.8
splits = (list(np.where(msk)[0]),list(np.where(~msk)[0]))
```


**Losses**

- `binary Cross-entropy` loss is the same as `mnist_loss` except for the
  log function.   
  
  ``` python
  def binary_cross_entropy(inputs, targets):
    inputs = inputs.sigmoid()
    return -torch.where(targets==1, inputs, 1-inputs).log().mean()
  ```

- `Losses`

	- `MSELoss` --> distance measuring 
	
		- used for PointBlock (e.g., Regression image centers)
		
		- **Important** Need to math.sqrt(valid_loss) to get final
          "error rate"

	- `Mnist_loss` --> sigmoid the activations + `torch.where` (`if` statement)
      (basically an operation to check how your loss is based on
      target)
	  
	  - Used for binary Category blocks. (e.g., 3 or 7 or 8)
	  
	- `Cross-entropy loss` --> LOG softmax (normalizing with exp) the
	activation's + Indexing function similar to `torch.where`.
	
		- e.g., 3 or 7 or 
	
	- `Binary Cross-entropy Loss` --> `Sigmoid` and then `LOG` + `torch.where`.

    	- Used for Multi-Category blocks.  e.g., Pet breeds
		
	> F.binary_cross_entropy and its module equivalent nn.BCELoss
	> calculate cross-entropy on a one-hot-encoded target, but do
	>     not include the initial sigmoid. Normally for
	>     one-hot-encoded targets you'll want
	>     F.binary_cross_entropy_with_logits (or
	>     nn.BCEWithLogitsLoss), which do both sigmoid and binary
	>     cross-entropy in a single function, as in the preceding
	>     example.

	> The equivalent for single-label datasets (like MNIST or the Pet
	> dataset), where the target is encoded as a single integer, is
	> F.nll_loss or nn.NLLLoss for the version without the initial
	> softmax, and F.cross_entropy or nn.CrossEntropyLoss for the
	> version with the initial softmax.

**Accuracy**

- `Single Label Accuracy`

``` python
def accuracy(inp, targ, axis=-1):
    "Compute accuracy with `targ` when `pred` is bs * n_classes"
    pred = inp.argmax(dim=axis)
    return (pred == targ).float().mean()
```

- `Multi Label Accuracy`

``` python
def accuracy_multi(inp, targ, thresh=0.5, sigmoid=True):
    "Compute accuracy when `inp` and `targ` are the same size."
    if sigmoid: inp = inp.sigmoid()
    return ((inp>thresh)==targ.bool()).float().mean()
```

- We need to pass the Metrics as a function, so we use `partial` to do
  so with different thresholds.
  
		learn = cnn_learner(dls, resnet50, metrics=partial(accuracy_multi, thresh=0.2))
		learn.fine_tune(3, base_lr=3e-3, freeze_epochs=4)

**Partial**

``` python
def say_hello(name, say_what="Hello"): return f"{say_what} {name}."
say_hello('Jeremy'),say_hello('Jeremy', 'Ahoy!')
```

``` python
f = partial(say_hello, say_what="Bonjour")
f("Jeremy"),f("Sylvain")
```

**Threshold**

It's always good to be "practical". We are going to use the validation
set to determine the threshold needed. In theory we are "overfitting"

  - **Note** : We are not picking one value from a bumpy curve, but from a
	real smooth coirve.
	
  ``` python
  xs = torch.linspace(0.05,0.95,29)
  accs = [accuracy_multi(preds, targs, thresh=i, sigmoid=False) for i in xs]
  plt.plot(xs,accs);
  ```

**Looking at image files**

- Get them.

``` python
img_files = get_image_files(path)
def img2pose(x): return Path(f'{str(x)[:-7]}pose.txt')
img2pose(img_files[0])
```

- Open them.

``` python
im = PILImage.create(img_files[0])
im.shape
```
not shape is `col_len,row_len` :(


**Different types of Block**

- ImageBlock (for images)

- PointBlock (for 2 point tensors)

- MultiCategoryblock (mutple catergories selectable e.g., pet breeds)

- CategoryBlock (one category chosen at a time e.g., 3 or 7 or 9 ;) )

**Splitter**

Splits Training and Validation sets.

- Split just one person

		splitter=FuncSplitter(lambda o: o.parent.name=='13')

- Split according to given df

``` python
def splitter(df):
    train = df.index[~df['is_valid']].tolist()
    valid = df.index[df['is_valid']].tolist()
    return train,valid

dblock = DataBlock(blocks=(ImageBlock, MultiCategoryBlock),
                   splitter=splitter,
                   get_x=get_x, 
                   get_y=get_y)

dsets = dblock.datasets(df)
dsets.train[0]
```

- Random splitter
		
		splitter=RandomSplitter(seed=42)
		
- grandparent splitter

**`Y_range` Cnn learner**

Here y_range is chose for the regression model.

	learn = cnn_learner(dls, resnet18, y_range=(-1,1))

## Lesson 6 nb8 ka notes

Latent factors (scifi or action or comedy etc. but we don't have any
info on them), movielens ranking


**Collaborative Filtering** e.g., NETFLIX recommendations

- Uses are where we need to know what sort of diagnosis might be
  applicable to someone, figure out where to click next, where you
  learn from past behavior.
  
- `Cross tab` the data to look at 3 columns as x and y with some
  numbers in between.

- CollabDataLoaders.from_df() needs a `user_name`, `item_name` (title), and
  `rating_name`
  
  ``` python
  CollabDataLoaders.from_df(
    ratings,
    valid_pct=0.2,
    user_name=None,
    item_name=None,
    rating_name=None,
    seed=None,
    path='.',
    bs=64,
    val_bs=None,
    shuffle_train=True,
	device=None,
	)
  ```

- We know how to do matrix multiplication and find gradients for
  that. We don't know how to find indices. 
  
  So we use one-hot-coding to extract the corresponding rows and
  columns
  
- Embedding is the matrix multiplication of a matrix (5x1000) with a
  one hot coded vector (1000x1) but is done with just indices w**ithout
  really creating the one hot coded vector**.


**Embedding**

- So basically we have a batch (`x,y = dls.one(batch)`).

`x.shape` --> 64x2 (64 indices, 2 --> 1 `user_name` and 1
`title_name`)

- When we try to make a model, we can't work with indices so we want to
do matrix multiplication. i.e., for 5 factors -->

1000x5 will be the user_name matrix and 5x1000 will be the indices
matrix. We want only 64 out of them. So we would like to use a
`hot_coded` matrix. Therefore we have 

	1000x5^T @ 1000x1 for user_name
	
	5x1000 @ 1000x1 for user_title

- Instead of doing this for each batch, we try to use "embedding"
  which does the above with indices but can also enable calculation of
  gradient.
  
  
  **Embedding**
  
  `emb = Embedding(n_users,n_factors)` "generates" a random matrix of that
  size. To this you can pass *Tensor* integers to index by doing
  `emb(tensor(3)`, gives 3rd row.
  
**Creating a colab model from scratch to train**

For this we use a `pytorch` setting where we can create a Class
(`dotproduct` class --> `DotProduct(Module)`) where in by default it
always calls the `forward method`. 
  
  
In this `Forward` method we define the indexing using the `Embedding`
function.

Completely unsure how this embedding works but here is the model...

``` python
class DotProduct(Module):
    def __init__(self, n_users, n_movies, n_factors):
        self.user_factors = Embedding(n_users, n_factors)
        self.movie_factors = Embedding(n_movies, n_factors)
        
    def forward(self, x):
        users = self.user_factors(x[:,0])
        movies = self.movie_factors(x[:,1])
        return (users * movies).sum(dim=1)
```

With this, we get a random set of vectors at the start and then pass
of the indices of each batch to the `embed` object to index into
it. `forward` is called "similar" to `__call__` each time we call the
object as a function. i.e, `A = DotProduct(9,12,5)` followed by
`A(user_factors_batch)`

Pass the batch's independent variables to `forward`.


`Embedding` creates a random matrix with `n_users,n_factors` from
which we can index with the `user_names` within each batch with
self.user_factors(x[:,0]). The reason we use Embedding is it comes
with grad capabilities.

``` python
x,y = dls.one_batch()
a = Embedding(n_users,n_factors)
a(x[:,0]) # will select all `user_names` in that title.
```

With `y_range`, `sigmoid` and `bias` added :)

``` python
class DotProductBias(Module):
    def __init__(self, n_users, n_movies, n_factors, y_range=(0,5.5)):
        self.user_factors = Embedding(n_users, n_factors)
        self.user_bias = Embedding(n_users, 1)
        self.movie_factors = Embedding(n_movies, n_factors)
        self.movie_bias = Embedding(n_movies, 1)
        self.y_range = y_range
        
    def forward(self, x):
        users = self.user_factors(x[:,0])
        movies = self.movie_factors(x[:,1])
        res = (users * movies).sum(dim=1, keepdim=True)
        res += self.user_bias(x[:,0]) + self.movie_bias(x[:,1])
        return sigmoid_range(res, *self.y_range)
```

This is equivalent to: 

``` python
class DotProductBias(Module):
    def __init__(self, n_users, n_movies, n_factors, y_range=(0,5.5)):
        self.user_factors = create_params([n_users, n_factors])
        self.user_bias = create_params([n_users])
        self.movie_factors = create_params([n_movies, n_factors])
        self.movie_bias = create_params([n_movies])
        self.y_range = y_range
        
    def forward(self, x):
        users = self.user_factors[x[:,0]]
        movies = self.movie_factors[x[:,1]]
        res = (users*movies).sum(dim=1)
        res += self.user_bias[x[:,0]] + self.movie_bias[x[:,1]]
        return sigmoid_range(res, *self.y_range)
```

## Lesson 6 code learnings

**Transpose**

```python
dl_a = DataLoader(a,batch_size=8, shuffle=True)
b = first(dl_a)
b

list(zip(b[0],b[1]))
list(zip(*b))
```

**RGB**

``` python
im = image2tensor(Image.open("images/grizzly.jpg"))
_,axs = subplots(1,3)

for bear,ax,color in zip(im,axs,("Reds","Greens","Blues")):
    show_image(255-bear,ax=ax, cmap=color)
```

**Make own function using partial**

`partial` function in use:

	def sigmoid_range(x, lo, hi): return torch.sigmoid(x) * (hi-lo) + lo
	
	plot_function(partial(sigmoid_range,lo=-1,hi=1), min=-4, max=4)
	
	
**Pandas Join merge**

Join two tables by common column

	ratings = ratings.merge(movies)
	ratings.head()



## Lesson 6 q&A discussion
	
1. how to extract from DL? and db's in general

2. how to see summary `dblock.summary`

3. why we need to use `to_cpu`

``` python
x,y = to_cpu(dls.train.one_batch())
activs = learn.model(x)
activs.shape
```
1. `get_items` vs `get_x`

2. What does normalize do here?

``` python
biwi = DataBlock(
    blocks=(ImageBlock, PointBlock),
    get_items=get_image_files,
    get_y=get_ctr,
    splitter=FuncSplitter(lambda o: o.parent.name=='13'),
    batch_tfms=[*aug_transforms(size=(240,320)), 
                Normalize.from_stats(*imagenet_stats)]
)
```

1. discuss how embedding works

2. `(users * movies).sum(dim=1)` but why? why not a dot product?


## Lesson 7 nb 8

**Collab filtering**

1. DotProduct of factors.

2. NN

?? How does colabnn work


When you see overfitting (i.e., valid_loss increases while training
loss decreases).

**Reduce Overfitting by**

1. Reducing number of latent factors (but "biases" the shapes to
   simpler ones)
   
2. Weight decay


**Weight decay or L2 regularization**

It adds a "parabola-type" function to it.

When you have a steep function, tendency to overfit is high. When you
have a smooth function, tendency to overfit is reduced. By adding a
smooth function like `0.1 x param**2` to the `loss`, we control the
tendency to overfit "apparently". I don't get it but it works, let's
move on.

	loss_with_wd = loss + wd * (parameters**2).sum()
	
Also gradient is easy to calculate.

**Parameters**

Anything you need to "learn" should be wrapped in `nn.parameters`

``` python
class T(Module):
    def __init__(self): self.a = nn.Parameter(torch.ones(3))

L(T().parameters())
```

``` python
(#1) [Parameter containing:
tensor([1., 1., 1.], requires_grad=True)]
```

**Plotting the pca of the latent factors**


``` python
g = ratings.groupby('title')['rating'].count()## get movies and number of ratings for those movies
top_movies = g.sort_values(ascending=False).index.values[:1000] ## sort the above and get the name of movies
top_idxs = tensor([learn.dls.classes['title'].o2i[m] for m in top_movies]) ## from movie names get indexes?
movie_w = learn.model.movie_factors[top_idxs].cpu().detach() ## Get 50 factors for those indices
movie_pca = movie_w.pca(3) ## do PCA of those factors
fac0,fac1,fac2 = movie_pca.t() ## transpose 
idxs = np.random.choice(len(top_movies), 50, replace=False)
idxs = list(range(50))
X = fac0[idxs]
Y = fac2[idxs]
plt.figure(figsize=(12,12))
plt.scatter(X, Y)
for i, x, y in zip(top_movies[idxs], X, Y):
    plt.text(x,y,i, color=np.random.rand(3)*0.7, fontsize=11)
plt.show()
```

**Looking at data in the form of distance**

``` python
movie_factors = learn.model.i_weight.weight
idx = dls.classes['title'].o2i['Silence of the Lambs, The (1991)']
## Get angle between two vectors is used here. Trivial:)
distances = nn.CosineSimilarity(dim=1)(movie_factors, movie_factors[idx][None]) 
idx = distances.argsort(descending=True)[1]
dls.classes['title'][idx]
```
## Lesson 7 Decision tree and random forests tabular data

Decision tree (learn from statquest)

**handling dates in tabular**

Adds all these columns to the data. 

`'saleWeek saleYear saleMonth saleDay saleDayofweek saleDayofyear
saleIs_month_end saleIs_month_start saleIs_quarter_end
saleIs_quarter_start saleIs_year_end saleIs_year_start saleElapsed'`

``` python
df = add_datepart(df, 'saledate')
df_test = pd.read_csv(path/'Test.csv', low_memory=False)
df_test = add_datepart(df_test, 'saledate')
' '.join(o for o in df.columns if o.startswith('sale')) ## not sure
## what it does
```

**Processes**

See Explanation on the docs [here](https://docs.fast.ai/tabular.core.html#FillMissing)

Fastai's tabular comes with 2 processes `procs = [Categorify,
FillMissing]`, changes categories into numbers just like in
`dls.vocab`, and does NOT fill missing values with median value but
with #na with a new column with `True` or `False`.

For neural nets (nns) however we would also like to add `normalize` as
this could shoot the loss function of the system and make other
variables not work properly.

```python
dft = pd.DataFrame({'a':[1,2,np.nan,0,0,2]})
tot = TabularPandas(dft, Categorify,cat_names=["a"])
dft.dtypes,tot.items.dtypes
tot.items
```

Shows how categorify works. You see `0` instead of
`nan`. `tot.classes["a"]` gives the classes as `['#na#', 0.0, 1.0,
2.0]`. Not sure how to go back though.


**Splitting train and valid by date**

``` python
cond = (df.saleYear<2011) | (df.saleMonth<10)
train_idx = np.where( cond)[0]
valid_idx = np.where(~cond)[0]

splits = (list(train_idx),list(valid_idx))
```
**Split to cont and cat variables**

	cont,cat = cont_cat_split(df, 1, dep_var=dep_var)
	
**Defining a tabular dsets**

	to = TabularPandas(df, procs, cat, cont, y_names=dep_var, splits=splits)

`to.classes` shows the vocab and `to.show` shows the actual vocab  in
a table. `to.items` shows the table without translated vocabs


**Before initiating tabular dsets**

```python
## split to train and valid
msk = np.random.rand(len(df)) < 0.8
splits = (list(np.where(msk)[0]),list(np.where(~msk)[0]))
# df_tr = df[msk]
# df_vd = df[~msk]
# len(df_tr)/len(df), len(df_vd)/len(df)
len(splits[0])+len(splits[1]), len(df)
```

**Leaf nodes and number of rows**

1. At every leaf node, the dater is split. i.e., 50k gets split to 35k
   and 15k. 
   
   **Eventually all the leaf nodes sum of dater will give you total
   dater length.**

2. So if -->  no. of leaf nodes = length of dater,

	then --> in theory you have fit almost all of the training data
    one to one (#overfit).
	
	so use `min_samples_leaf=25`. It wont split below 25 samples.


Why are there more nodes than columns? There will be bruv. Max number
of leaf nodes is `2^n_columns`. This is an insane number of leaf nodes. But
you will max out on samples. So don't worry. :)

How to get deep trees without overfitting? Bagging.

How do we deal with N/A?

**Decision Tree**

``` python
from sklearn.tree import DecisionTreeRegressor, DecisionTreeClassifier
#!pip install dtreeviz
from dtreeviz.trees import *
m = DecisionTreeClassifier(max_leaf_nodes=4)
m.fit(xs,y)
draw_tree(m, xs, leaves_parallel=True, precision=2)
```

**Gini impurity**

Main idea is [here](https://victorzhou.com/blog/gini-impurity/). I make an example out of this
[statquest](https://www.youtube.com/watch?v=7VeUPuFGJHk). Also look at [this medium post](https://medium.com/@pandulaofficial/implementing-cart-algorithm-from-scratch-in-python-5dd00e9d36e).

I think it helps with some context: Let's say there is a machine that
can detect Heart Disease (HD). The machine can predict HD 30% of the
time. Following is the sample we have:

|         | HD | !HD |
|---------|----|-----|
| Machine | 30% | 70%  |

This means the following cases are possible:

1. Machine classify as HD and it is HD (P = 0.3*0.3)
2. Machine classify as !HD and it is !HD (P = 0.7*0.7)
3. Machine classify as HD but it is !HD 
4. Machine classify as !HD but it is HD

We pray that cases 3&4 happen less often. The sum of all probabilities
is 1.  P(3&4) is therefore given by `1-(0.3^2)-(0.7^2)`=0.42. P(3&4)
is the impurity or how bad the machines' prediction is, AKA
**GINI=0.42**.

The alternative is to check if someone is clutching his chest or not
due to chest pain (CP) and then guess based on probability data if he
has HD or not. The following is the sample we have. For each case we
calculate the GINI. Then we take the average of it (assuming similar
sample size) and this estimates the GINI impurity using CP to predict
HD.

|     | HD  | !HD | GINI  |
|-----|-----|-----|-------|
| !CP | 25% | 75% | 0.375 |
| CP  | 80% | 20% | 0.32  |
| avg | NA  | NA  | 0.38  |


Smaller the impurity the better. So we decide instead of buying the
machine (GINI=0.42) we can just use CP as an indicator (GINI=0.38).

**Feature importance's**

Weighted decrease in impurity and then normalized.

[Calculated as](https://stackoverflow.com/a/49171133/5986651) : `N_t / N * (impurity - N_t_R / N_t * right_impurity
                      - N_t_L / N_t * left_impurity)`

to get the raw sklearn "feature importances":
``m.tree_.compute_feature_importances(normalize=False)`

**Bootstrapping**

Making a dataset with random picking **with replacement**. Size of
dataset picked, is the same as the orginal.

**Bagging** (rand choose rows and make multiple models)

Here is the procedure that Breiman is proposing:

1. Randomly choose a subset of the rows of your data (i.e., "bootstrap
   replicates of your learning set").
2. Train a model using this subset.
3. Save that model, and then return to step 1 a few times.
4. This will give you a number of trained models. To make a
   prediction, predict using all of the models, and then take the
   average of each of those model's predictions.

Idea being you get random errors which are not correlated with one
another. so when you average it you reduce the uncertainty or the
error by `sqrt(number of models)`

**Random forest**

In addition to the above randomly chosen rows per model (**bagging**),
randomly selecting from a subset of columns at each node is Random
forest.

check out the "Elements of Statistical Learning"

Note: **You somehow don't overfit**, as you keep averaging and hence
you plateau with accuracy. Which is very interesting. (lesson 7 Jeremy)



**Out-of-bag-error**

There are two reasons why you training and validation rmse are
different.

1. Random forests was not accurate enough,

2. There is actual difference between training and validation set
   (e.g., time offset).

Using out-of-bag rmse error we can determine which of the ones it is, i.e.,
how accurate your training and validation rmse is.


*How is it done?*

1. Take each row and find the models where it is not used and compute
   the rmse
   
   It gives an impression of ho wthe rf works on not seen data (aka
   valid data). Beware this seems to defeat the point when we use time
   series dataset.
   
2. Do it for every row.

In [this lecture on tabular data](https://github.com/fastai/fastbook/blob/master/09_tabular.ipynb) they show a training error of
17%, OOB error of 21% and a validation error of 23%.  Is my
understanding below correct?

The training error is different from OOB error --> This implies
overfitting.  Because the OOB error is "much less" than the validation
error --> This implies that the validation set is "out of domain"
(e.g., from a different time series).

**Model interpretation**

- How confident are we in our predictions using a particular row of data?
- For predicting with a particular row of data, what were the most important factors, and how did they influence that prediction?
- Which columns are the strongest predictors, which can we ignore?
- Which columns are effectively redundant with each other, for purposes of prediction?
- How do predictions vary, as we vary these columns?


**Variance of prediction**

We usually look at the mean of all the predictions per row. This can
have high std or low std. In the case that the mean=0.23 and std=0.21
(I personally would not be very confident). We can use this info for
each prediction we make to see if we should take a deeper look at
something.

*Question* But am quite unsure about the how to interpret the data. Are you
supposed to look at other std of other rows or?


**Feature Importance** (not fully sure)

> The way these importances are calculated is quite simple yet
> elegant. The feature importance algorithm loops through each tree,
> and then recursively explores each branch. At each branch, it looks
> to see what feature was used for that split, and how much the model
> improves as a result of that split. The improvement (weighted by the
> number of rows in that group) is added to the importance score for
> that feature. This is summed across all branches of all trees, and
> finally the scores are normalized such that they add to 1.

**Remove columns that are not important**

From the above select only columns that are `>0.005` in importance.

**Remove redundant columns i.e., correlated columns, i.e., linearly
dependent colath**

1. Using clustering to see which columns are close to each other.

2. Jermey looks at oob when keeping the variables and removing them
and then finally removing all the ones that are a double. If you see
"little" oob change then they are fine to be thrown.

3. He uses only 50k samples here randomly chosen with replacement.

4. However I wonder why not also see the actual valid and train rmse
as a result of these. Actually he ends up doing it with the whole
dataset.

**Partial Dependence**

Book to understand formalism of subtleties: "The Book of Why"

How does yearmade affect `SalesPrice` all else being equal?

The thing is we can't just take average sale price for a particular
year. This does not account for changes in the other variables.

So we resort to another kind of study, where we generate different
datasets. DATASET1: all years changed to 1950, DATASET2: all years
changed to 1970...

We can predict using our model on each data set. and plot the values. 

> For instance, how does YearMade impact sale price, all other things being equal?

> To answer this question, we can't just take the average sale price for
> each YearMade. The problem with that approach is that many other
> things vary from year to year as well, such as which products are
> sold, how many products have air-conditioning, inflation, and so
> forth.

> Instead, what we do is replace every single value in the YearMade
> column with 1950, and then calculate the predicted sale price for
> every auction, and take the average over all auctions. Then we do
> the same for 1951, 1952, and so forth until our final year
> of 2011. This isolates the effect of only YearMade (even if it does
> so by averaging over some imagined records where we assign a
> YearMade value that might never actually exist alongside some other
> values).


But the N/A columns can also show up.

> The ProductSize partial plot is a bit concerning. It shows that the
> final group, which we saw is for missing values, has the lowest
> price. To use this insight in practice, we would want to find out
> why it's missing so often, and what that means. Missing values can
> sometimes be useful predictors—it entirely depends on what causes
> them to be missing. Sometimes, however, they can indicate data
> leakage.

Not sure how to broach such a topic or what it means. :(

**Tree interpreter**

Similar to "feature importance", but works with just one row of
data. So you can understand what you are trying to do.


**Random Forests is really bad on unseen data**

It can't predict what happens in a straight line projection between
sales price and year for example. 

Very hard for RF to extrapolate outside the data it has seen. Example,
time series. Make sure the data is not "OUT OF DOMAIN". HUh? what is
that?

**OUT OF DOMAIN DATER**

So to identify if the valid set and training set are "different" or if
they are "out of domain", we can do an rf to predict if dater from
training or valid.

If the rmse is small, or if the predicting power of the rf is high,
then we have different valid dataset. It is "different" than the
"training".

We can look at the feature importance. In the case of the problem
there is Sales Elapsed, MachineId and SalesID which are mostly
important to predict training and valid. It makes sense and it can be
imagined that the machine id keeps increasing over time, same with
sales id. :) So it's understandable that these predict the valid.

If we remove these then you loose predicting power. Also if you remove
this, then you error on the main model slightly improves. So we can
consider removing these time related parameters that we expect to not
make much of a difference. THis makes the system **more resillient to
time changes**.

Similarly you can also remove certain dates to train better or just
keep the latest dates.

**NN**

Also looks good for tab dater.

> By default, for tabular data fastai creates a neural network with
> two hidden layers, with 200 and 100 activations, respectively. This
> works quite well for small datasets, but here we've got quite a
> large dataset, so we increase the layer sizes to 500 and 250:

**Ensembling**

Some sort of weighted or equaly-weighted results from two models.


**Boosting**

IT WILL OVERFIT.

- Train a small model that underfits your dataset.
- Calculate the predictions in the training set for this model.
- Subtract the predictions from the targets; these are called the
  "residuals" and represent the error for each point in the training
  set.
- Go back to step 1, but instead of using the original targets, use
  the residuals as the targets for the training.
- Continue doing this until you reach some stopping criterion, such as
  a maximum number of trees, or you observe your validation set error
  getting worse.


Is training with small sample and getting residuals and training to
reduce these residuals... In the end you add up all of the predictions
unlike in bagging. There is gradient boosting machines and gradient boosting
decision trees and some other variants.

**Entity embedding**

**Conclusion**

- *Random forests* are the easiest to train, because they are
  extremely resilient to hyperparameter choices and require very
  little preprocessing. They are very fast to train, and should not
  overfit if you have enough trees. But they can be a little less
  accurate, especially if extrapolation is required, such as
  predicting future time periods.

- *Gradient boosting machines* in theory are just as fast to train as
  random forests, but in practice you will have to try lots of
  different hyperparameters. They can overfit, but they are often a
  little more accurate than random forests.

- *Neural networks* take the longest time to train, and require extra
  preprocessing, such as normalization; this normalization needs to be
  used at inference time as well. They can provide great results and
  extrapolate well, but only if you are careful with your
  hyperparameters and take care to avoid overfitting.
  
**HW**

1. Start a kaggle competition
2. Do KNN
3. and EE as well and see where that takes your results. Tabulate them.

### Data leakage example in nb 9

In the paper ["Leakage in Data Mining: Formulation, Detection, and
Avoidance"](https://dl.acm.org/doi/10.1145/2020408.2020496), Shachar Kaufman, Saharon Rosset, and Claudia Perlich
describe leakage as:

> : The introduction of information about the target of a data mining
    problem, which should not be legitimately available to mine
    from. A trivial example of leakage would be a model that uses the
    target itself as an input, thus concluding for example that 'it
    rains on rainy days'. In practice, the introduction of this
    illegitimate information is unintentional, and facilitated by the
    data collection, aggregation and preparation process.

They give as an example:

> : A real-life business intelligence project at IBM where potential
    customers for certain products were identified, among other
    things, based on keywords found on their websites. This turned out
    to be leakage since the website content used for training had been
    sampled at the point in time where the potential customer has
    already become a customer, and where the website contained traces
    of the IBM products purchased, such as the word 'Websphere' (e.g.,
    in a press release about the purchase or a specific product
    feature the client uses).

Data leakage is subtle and can take many forms. In particular, missing
values often represent data leakage.

For instance, Jeremy competed in a Kaggle competition designed to
predict which researchers would end up receiving research grants. The
information was provided by a university and included thousands of
examples of research projects, along with information about the
researchers involved and data on whether or not each grant was
eventually accepted. The university hoped to be able to use the models
developed in this competition to rank which grant applications were
most likely to succeed, so it could prioritize its processing.

Jeremy used a random forest to model the data, and then used feature
importance to find out which features were most predictive. He noticed
three surprising things:

- The model was able to correctly predict who would receive grants
  over 95% of the time.
- Apparently meaningless identifier columns were the most important
  predictors.
- The day of week and day of year columns were also highly predictive;
  for instance, the vast majority of grant applications dated on a
  Sunday were accepted, and many accepted grant applications were
  dated on January 1.

For the identifier columns, one partial dependence plot per column
showed that when the information was missing the application was
almost always rejected. It turned out that in practice, the university
only filled out much of this information *after* a grant application
was accepted. Often, for applications that were not accepted, it was
just left blank. Therefore, this information was not something that
was actually available at the time that the application was received,
and it would not be available for a predictive model—it was data
leakage.

In the same way, the final processing of successful applications was
often done automatically as a batch at the end of the week, or the end
of the year. It was this final processing date which ended up in the
data, so again, this information, while predictive, was not actually
available at the time that the application was received.

This example showcases the most practical and simple approaches to
identifying data leakage, which are to build a model and then:

- Check whether the accuracy of the model is *too good to be true*.
- Look for important predictors that don't make sense in practice.
- Look for partial dependence plot results that don't make sense in
  practice.

Thinking back to our bear detector, this mirrors the advice that we
provided in <<chapter_production>>—it is often a good idea to build a
model first and then do your data cleaning, rather than vice
versa. The model can help you identify potentially problematic data
issues.

It can also help you identifyt which factors influence specific
predictions, with tree interpreters.


## Computer Vision Assignment Kaggle

1. [Kaggle Competition](https://www.kaggle.com/c/herbarium-2020-fgvc7/overview)

2. [Fastchai](https://forums.fast.ai/t/fastchai-and-kaggle-group-based-projects/81384)

- Read about the competition (15 mins)

    > So what Kaggle does is to itself split the data into a training set
    > and a test set. They release these to us and the training set contains
    > the outcomes to predict, the test set does not. So the short answer is
    > that you submit your outcome list for the test set that Kaggle has
    > given you. What Kaggle does is to take your guesses and apply it to a
    > random 50% of the test set and give you your results back (the exact
    > metric used changes and can be found in the evaluation tab of the
    > competition info). So during the competition you are getting feedback
    > on a random static 50% of the test set. At the end of the competition
    > they release how you went on the other 50% for your chosen top 2
    > guesses. So one thing to watch out for is overfitting on the 50% of
    > the test set during the competition itself - it is common to see quite
    > big changes to the leader board once a competiton has finished because
    > of this. Hope this makes sense! --- [user](https://www.kaggle.com/getting-started/9551)




- Come up with a plan

	1. Submit one result (random selection or the top one)
	
	2. How to not overfit?
	
	3. Get a smaller subset
	
	4. Come up with most basic solution and submit
	
	5. How to improve?
	
- EDA

	1. how many species have one item to train with?
	2. what are strategies to not "remember a picture"? 


- Strategies

	1. More epochs? 
	2. Presizing?
	1. different model for the ones with few?
	2. Cross validation?
	3. Getting more data from the internet
	4. Augmentation for sure
	5. different sizes of tensor
	6. how to not overfit?

- Prepare your arsenal of tools (1hr)

- documentation?
## TODO

Goals ------------------------
by Monday, 7th Dec
@agent18 

  * [x] -Adding fastai and test one command 
  
    * [ ] download data as pdf from gradient
 
  * [x] Download fastai stuff from gradient
 
- [ ] Make a random "csv" submission and SUBMIT TO KAGGLE  (?)
- Make a simple model with shit accurcy and run with fastai (?)
- just find out how to increase time of GPU (?)
- Take a small subset (1%) and setup the CSV submission when species are missing


by Tuesday, morning

- Setup one run of the with shit accuracy with fastai
  - Using a random sample extract parts of json you need (done)
  - Make df with it
  - Make data block
	- getx
	- gety 
   - resnet 18/resnet50.fp16
- do an eda of the 32k and how many specimens they have


by wednesday

## Kaggle

[Getting started with Kaggle](https://www.kaggle.com/alexisbcook/getting-started-with-titanic)

1. Submit a csv for final results.

2. `Save Version` when you want to save a version or you want to
   submit that versions results as
   
3. Every Version seems to be like in VERSION CONTROL. e.g., you can
   select the Notebook Version and the output file generated.
   
4. Submit any versions output documents to get back on the leader
   board.
   
Don't understand difference bewtween final submission and non-final
submission.

> You may submit a maximum of 10 entries per day. You may select up to
> 5 final submissions for judging.


### installing dtreeviz

You might get errors. Just proceed it seems ok. Otherwise refer
[this](https://github.com/parrt/dtreeviz/issues/108)
### IEEE fraud detection

1. [First place solution part 1](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111284)
2. [First place Part 2](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111308#647776)
3. [First place Finding UID](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111510)
4. [First place XGB solution](https://www.kaggle.com/cdeotte/xgb-fraud-with-magic-0-9600)

5. [Data and description](https://www.kaggle.com/c/ieee-fraud-detection/discussion/101203)
6. notebook on [adverserial validation](https://www.kaggle.com/konradb/adversarial-validation-and-other-scary-terms)

7. [another competition](https://www.kaggle.com/c/lish-moa/discussion/202256)


### kaggle api installation and working

## Python Learnings

- pay more attention to code, don't take things for granted. preferably check with an example data
  frame so you are absolutely sure of the transactions. 
  
- discuss on how to generate hypothesis..

- I am quickly convinced by "proof". e.g., I was convinced that set(a)
  outputing 2000 values was enough proof that I had done it
  right. Which it was
  
- Look at what is happening different between you and another
  example. After identifying where things are going wrong I didn't
  know how to probe further (e.g., iloc, loc issue) Strip problem to
  basic issues. Try to see if you can write a MWE?

### Json file opening

If error: `UnicodeDecodeError: 'utf8' codec can't decode byte 0x96 in
position 0: invalid start byte`

```python
import json,codecs
with codecs.open("../input/herbarium-2020-fgvc7/nybg2020/train/metadata.json", 'r',
                 encoding='utf-8', errors='ignore') as f:
    train_meta = json.load(f)
```

``` python
with open(train_json_path, encoding="utf8", errors='ignore') as f:
     data = json.load(f)
```

### Dataframe index iloc loc pandas

**Very Big Disclaimer**: 

Sorting or any operations that shuffles the rows in the DF is
DANGEROUS. So Row number is not the same as Index (row name).


Pandas has Columns and indexes, column names and index names

**Indexing**

``` python
dft = pd.DataFrame(np.random.randint(0,100,size=(20, 4)), columns=list('ABCD'))
dft = dft.sort_values("D")
print(dft["C"].iloc[[0,1]],dft.loc[[0,1],"C"])
dft
```

`iloc` --> gives rows 0 and 1 (NOT INDEX) --> [99, 50]

`loc`  --> gives based on INDEX (rowname)--> [18,7]

`loc` is based on Labels (Index, rowname); LABEL BASED INDEXING

`iloc` is based on Positions (row number != index); POSITION BASED INDEXING

`Table: dft`

``` python
	A	B	C	D
18	33	87	99	5
4	98	77	50	9
1	25	61	7	10
5	47	90	86	11
6	0	40	42	18
2	29	51	99	22
17	22	20	35	30
10	93	39	59	30
13	70	65	61	35
16	2	74	48	39
9	42	30	13	40
14	33	91	51	49
7	99	38	91	53
0	69	76	18	58
12	96	65	48	69
11	75	64	14	72
8	41	33	18	74
19	63	71	53	81
3	34	2	20	92
15	36	76	33	96
```

**Using iloc and loc**

`iloc` --> `dft.iloc[0,1]` or `dft.iloc[0,]`
--> 33

`loc` --> `dft.loc[0,"A"]` --> 69

To use `iloc` but with `labels`

`dft.iloc[dft.index.get_loc(0),dft.columns.get_loc("C")]`

**Get index (rowname) or row number from value**

`dft.index` --> gives index order

`dft.index.values` --> gives an array of index order

`dft.index[dft["C"]==12]`, `dft[dft["C"]==12].index` both give same
answer i.e., row name (INDEX)

**Get row Number (!rowname)**

**Get colnumber and index number from value**

`dft.columns.get_loc("C")`

**Index order**

`dft.index.values`

``` python
array([17, 10,  2, 13,  9, 18,  5,  6,  8, 15,  4, 11,  3, 12, 19, 14, 16,
        0,  7,  1])
```

Can be reset using: `dft.reset_index(drop=True, inplace=True)`

**Avoid issues by using**

- reset index, pay attention to using loc (labels) or iloc (positions)

**doing multiple operations on pandas**


``` python
g = ratings.groupby('title')['rating'].count()
top_movies = g.sort_values(ascending=False).index.values[:1000]
```

`g` groups by `title` and then gets "ratings" and then counts listings
per group. Lists as `title` and `number of counts`. :)

`top_movies` sorts g in descending order, finds the index and
gets 

### Pandas groupby, sort_values, merge

Adding function by grouping.

``` python
df["len_rows"] = df.groupby("category_id")[["category_id"]].transform(len)
df = df.sort_values("len_rows")
df.reset_index(drop=True, inplace=True)
```

``` python
df = df_all.groupby("category_id").apply(lambda
x:x.sample(min(8,len(x)))).reset_index(drop=True) 
df = df_all.groupby("category_id").head(n=10) # displays 10 of the top
```
Random selection of index values.

``` python
train_ind_1 = [random.sample(df[df["category_id"]==ctg].index.tolist(),1)[0] for ctg in ctg_unq]
```
Merging...

``` python
df = transaction.merge(identity)
```

### reading fastai documents

Go here first and look at training. All important functions are
listed: https://docs.fast.ai/vision.learner.html

Fastai github: https://github.com/fastai/fastai/blob/master/fastai/metrics.py#L141

### Testing metrics Tracing the functions methods def

`F1Score` needs to be instantiated.

``` python
pred = torch.randint(0,10,(64,))
targ = torch.randint(0,10,(64,))
f1score_ins = F1Score(average="macro")
f1score_ins(pred,targ)
```
`Learn` needs a `metric` function. In this case `f1score_ins`. 

It looks like a function but is actually a class and needs to be
instantiated. `F1Score` is a class based on the `skm_to_fastai`
functions which returns a Class object (`AccumMetric`). `AccumMetric`
has function `__call__` which basically allows you to call the
`object` as a `function`


So It will be:

``` python
f1_score_multi = F1Score(average="macro") ## convert class to functie
learn = cnn_learner(dls,resnet18,metrics=f1_score_multi)
```
### Star variable `*variable`, `*self`

unpacks list or dict

``` python
>>> lis=[1, 2, 3, 4]
>>> dic={'a': 10, 'b':20}
>>> functionA(*lis, **dic)  #it is similar to functionA(1, 2, 3, 4, a=10, b=20)
(1, 2, 3, 4)
{'a': 10, 'b': 20}
```

### Unsqueeze using None,

``` python
xs_lin = x_lin.unsqueeze(1)
x_lin.shape,xs_lin.shape
```

``` python
x_lin[:,None].shape
```

Both output: `torch.Size([40, 1])` from `torch.Size([40])`

### GPU CPU usage

``` python
def print_cpu_gpu_usage():
    !gpustat -cp
    !free -m
    #!top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" |
    awk '{print 100 - $1"%"}'
```

### Nan na None Null inf

When you import a dataframe I think all missing values are encoded as
`NaN`. Whether it is an object, boolean or other. Use this to see all
in one goi.

	df.isna().sum()	
	
	
**Dropping them**

[Stack](https://stackoverflow.com/a/13434501/5986651), [python dropna()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html)

``` python
df.dropna()     #drop all rows that have any NaN values
df.dropna(how='all')     #drop only if ALL columns are NaN
df.dropna(thresh=2)   #Drop row if it does not have at least two values that are **not** NaN
```
**FASTAI**

The thing is  fastai's Tabular pandas has this attribute `classes` 

	to.classes["ProductCD"]
	
This shows : ['#na#', 'C', 'H', 'R', 'S', 'W']

FASTAI converts the dtype "categories or obejects" to numerical
(`int`). While providing the `VOCAB` it changes NaN types to `#na#`
string. 

It always shows "#na#" for categorical variables.

**Guess**: *I think categories can have "#na#" while working with skitlearn but
not cont variables*

**General**

`NaN` is not a number. `R` has `na` and `Null` etc... But `Python`
doesn't. `Pandas` is built on top of `numpy`.

> - To detect `NaN` values numpy uses `np.isnan()`.
>
> - To detect `NaN` values pandas uses either `.isna()` or `.isnull()`.
> The `NaN` values are inherited from the fact that `pandas` is built on
> top of `numpy`, while the two functions' names originate from `R`'s
> `DataFrames`, whose structure and functionality pandas tried to
> mimic. ---[Stack](https://datascience.stackexchange.com/a/37879/67821)

> dropna(), fillna() that handles missing values and it always helps
> to remember easily.

What are they? how to identify them in the context of pandas.

To check for both `None` and `NaN`

`np.inf` is to denote infinity.

**Pandas**

NaN in about missing values in pandas. use `np.isnan(array)`

``` python
x = np.array([np.NaN])
np.isnan(x)
```
`array([ True])`

**Fastest way to replace nan and inf**
[Stack](https://stackoverflow.com/a/17478495/5986651)

``` python
    In [11]: df = pd.DataFrame([1, 2, np.inf, -np.inf])
    
    In [12]: df.replace([np.inf, -np.inf], np.nan)
    Out[12]:
        0
    0   1
    1   2
    2 NaN
    3 NaN
```

### pandas and tabular with GPU

This [kaggle kernel](https://www.kaggle.com/cdeotte/rapids-feature-engineering-fraud-0-96/) is an introduction to using rapids.

> RAPIDS is a collection of libraries, GitHub page here. The library
> cuDF has the same API as Pandas and does what Pandas does. The
> library cuML has the same API has Scikit-learn and does what
> Scikit-learn does.

> Their purpose is to allows us to do our data analytics and machine
> learning on GPU instead of CPU giving us speed increases between 10x
> and 1000x! They are open source libraries currently in
> development. They still have some bugs and are still missing some
> features that Pandas and Scikit-learn have but the existing
> functions are very fast!


also check [this](https://www.kaggle.com/cdeotte/rapids-data-augmentation-mnist-0-985) out.

### Pass by reference

Immutable objects are those that when passed by reference (in a
function) get mutated. Understanding this shows why we can modify a
list and not an int variable.


``` python
## Column Names in dictionaries.
col_count = [0]
def count_col(str_sch,col_count=col_count):
    tf = [bool(re.search("^"+str_sch+"[0-9]+",col)) for col in xs.columns.to_list()]
    col_count[0]+=sum(tf)
    return [str_sch,cols[tf].to_list()]

col_lst = [["other",cols_sngl]]; col_count[0]+=len(cols_sngl)
[col_lst.append(count_col(str_sch)) for str_sch in str_mltpl]
col_dict = dict(col_lst)
col_count
```
### Pandas correlation

Pandas excludes nans while calculating corrs... So we really don't
know the contribution of the nans, and their spacing.

Calculating corr with other collumns

### remove certain columns pandas

``` python
tf_V = [bool(re.search("^V"+"[0-9]+",col)) for col in xs.columns.to_list()]
cols = xs.columns[list(~np.array(tf_V))]
len(cols)
```

### split column by another column and count groupby

Most elegant solution

``` python
df.groupby(["id_31","isFraud"]).size().unstack(fill_value=0).rename(columns={0:'isFraud0',1:'isFraud1'}).reset_index()
```
had to **reset index** otherwise kept getting keyerror, group error etc..... Huh!

### select and display one client

``` python
my_filter = df[uid].to_dict(orient='index')[10876]#[10302]
print(my_filter)
```

``` python
## Looking at one UID
df_all[feat].loc[(df_all[list(my_filter)] == pd.Series(my_filter)).all(axis=1)]
```
### pandas and aggregate

https://stackoverflow.com/a/53781645/5986651

``` python
temp.groupby(['A', 'B'])['C',"D"].agg([('average','mean'),('total','sum')])
```

``` python
pd.concat([temp,temp.groupby(['A', 'B'])['C',"D"].transform("mean").add_suffix("_mean_uid")],
          axis=1)
```



## Statistics learning

Several metrics are discussed [here](https://towardsdatascience.com/handling-imbalanced-datasets-in-machine-learning-7a0e84220f28).

### Confusion matrix, precision, recall

Everything adds up to total number. In python `confusion_matrix` from
`sklearn.metrics` has this transposed.

|                    | Actual isFraud | Actual !isFraud |
|--------------------|----------------|-----------------|
| Predicted isFraud  | TP             | FP              |
| Predicted !isFraud | FN             | TN              |

Sensitivity TPR (recall): What percentage of Frauds were correctly identified.

	TP/(TP+FN)

Specificity TNR (1-FNR) (recall): What percentage of !Frauds were correctly identified

	TN/(FP+TN)
	
**Precision** (across same prediction): The precision of a class define how
trustable is the result when the model answer that a point belongs to
that class. From what ever it predicts it does a good job if Precision
is high.

	TP/(FP+TN)_

Think of P and N as two classes. There could be more classes.

**recall** (across same Class): The recall of a class expresses how well the
model is able to detect that class. If recall is low for a class then
model is unable to 

	TP/(TP+FN)

Like your accuracy of prediction.


### ROC curve

1. Graph between TPR and FPR. If TPR is 1 it means that all samples
   have been correctly predicted for "true" class. If FPR is 1, it
   means that all samples of the "false" class, are predicted wrong. 
   
2. What we want thus is a low FPR and a high TPR for a given
threshold. We want the ratio of TPR to FPR to be as high as possible. 

3. Above the line is good. Below the line not.

### python Precision, confusion, recall, balanced_accuracy

Calculate the precision score or recallof one label alone.

``` python
precision_score(y,m.predict(xs), average=None, labels=[1,0])
precision_score(y,m.predict(xs), average="macro",labels=[1])
precision_score(y,m.predict(xs), average="binary", pos_label=1)
```

``` python
def m_conf(m,xs,y): 
    plot_confusion_matrix(m,xs,y)
    return confusion_matrix(y, m.predict(xs))
```

``` python
## Metrics functions
def r_mse(pred,y): return round(math.sqrt(((pred-y)**2).mean()), 6)
def m_rmse(m, xs, y): return r_mse(m.predict(xs), y)
#def m_accuracy(m,xs,y): return sum(m.predict(xs)==y)/len(xs)
def m_accuracy2(m,xs,y): return m.score(xs,y)
def m_conf(m,xs,y): 
    plot_confusion_matrix(m,xs,y)
    return confusion_matrix(y, m.predict(xs))
def m_prec(m,xs,y): return precision_score(y,m.predict(xs), average=None, labels=[1,0])
def m_recall(m,xs,y): return recall_score(y,m.predict(xs), average=None, labels=[1,0])
```
Why sample_weight does not work is still a mystery to me...???

``` python
## is balanced accuracy the same as recall average? YES

from sklearn.metrics import balanced_accuracy_score
avg1 = (tr_rep["1"]["recall"]+tr_rep["0"]["recall"])/2
sample_weight = np.array([1 if i == 0 else 1000 for i in y])
avg2 = balanced_accuracy_score(y,m.predict(xs),sample_weight=sample_weight)
avg1,avg2
```

### Unbalanced data

It is important to realize that we might not need to do anything for
this dataset regarding unbalanced dataset. 

> I did try that. It helped my CatBoost models using hyperparameter
> class_weights=[1,2.5] but over/under sampling didn't help my LGBM
> nor XGB models.
>
> I don't have any great insights but I think the proportion of
> isFraud in the test.csv file makes a difference. For example if the
> train.csv had 3% isFraud but the test.csv had 10% isFraud then it
> would be important to upsample so that your predictor would predict
> more isFraud than 3% in the test.csv. ---[topper](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111308#647776)

1. Balance the samples by over or undersampling

2. Sort of summary [here](https://machinelearningmastery.com/tactics-to-combat-imbalanced-classes-in-your-machine-learning-dataset/).

3. There are python libraries that do it. SMOTE, "UnbalancedDataset"
   module has other features too. Check it out.
   
I tried using a 29% data as opposed to 3% data of minority class, and
got .89 (auc) on vlid as opposed to 0.83 (auc).

consider undersampling (done ROCKS with 29% 5% increase in AUC)

Considering just oversampling with replacement (Done good for precision)

Considering oversampling with smote, Rose

Considering undersampling with oversampling (could try)

Considering weighting each observation [(apparently can be done on
RF)](https://stackoverflow.com/questions/20082674/unbalanced-classification-using-randomforestclassifier-in-sklearn) (improves by a percent). 

There are more resources [here](https://machinelearningmastery.com/tactics-to-combat-imbalanced-classes-in-your-machine-learning-dataset/)

[Classification when 80% of dataset is
one class](https://www.reddit.com/r/MachineLearning/comments/12evgi/classification_when_80_of_my_training_set_is_of/)

[Quora ideas on how to handle unb ds](http://www.quora.com/In-classification-how-do-you-handle-an-unbalanced-training-set)


**Smote implementation**

``` python
# ## Oversampling SMOTE
from imblearn.over_sampling import SMOTE
sm = SMOTE(random_state=42, n_jobs=-1,k_neighbors=15)
X,Y = sm.fit_resample(xs,y)
m = rf(X,Y)
Y.value_counts(), y.value_counts(),
```

**ROS implementation**


``` python
# #oversampling
from imblearn.over_sampling import RandomOverSampler
ros = RandomOverSampler(random_state=42)
X,Y = ros.fit_resample(xs,y)
m = rf(X,Y)
```

**Balancing weights manually**

Weighing the minority class.

``` python
## Weighting the samples
wt = y.value_counts()[0]/y.value_counts()[1]
y.value_counts(),wt
sample_weight = np.array([1 if i == 0 else wt for i in y])
m = rf(xs,y, sample_weight=sample_weight)
```

### trying pipeline for oversampling

```python
from imblearn.pipeline import Pipeline
from imblearn.over_sampling import RandomOverSampler
pipe_ros = RandomOverSampler(random_state=42)

pipeline = Pipeline([("ros", pipe_ros),("rf",pipe_rf)])
pipeline.fit(xs,y)
```
Doesn't work. testing pipeline with just rf and was able to reproduce
results.


**Pipline with ROS + RF and gridsearchcv**

``` python
from imblearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV
## define pipeline
steps =  [('ros', RandomOverSampler()), ('rf', RandomForestClassifier())]
pipeline = Pipeline(steps=steps)

# score={'AUC':'roc_auc', 
#            'RECALL':'recall'}

param_grid = {"rf__max_features":[0.2,0.3,0.4,0.5,0.7,0.8],
              "rf__max_samples":[0.2,0.4,0.5,0.6],
              "rf__min_samples_leaf":[1,5,15,25,35,50],
              "rf__n_estimators":[40]
             }

cv_rf = GridSearchCV(pipeline, param_grid=param_grid, scoring="roc_auc", n_jobs=-1,
                     cv=10, verbose=3, return_train_score=True)

cv_rf.fit(xs,y)
```

### Random forests

[Berkeley info](https://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#balance)

Using `m.estimators_` and getting the mean of predictions or using `m`
(the entire model) for predicting is the same. 

``` python
preds_p = np.stack([t.predict_proba(valid_xs)[:,1] for t in m.estimators_])
m.predict_proba(valid_xs)[:,1]==[preds_p.mean(0)]
```
	
### Remove out of domain data (adversarial validation) OOD

nb9 tabular

``` python
## finding out of domain dater 
df_dom = pd.concat([xs, valid_xs])
is_valid = np.array([0]*len(xs) + [1]*len(valid_xs))

m = rf(df_dom, is_valid)
rf_feat_importance(m, df_dom, df_dom)[:6]
```

``` python
## Removing OOD dater.
ood_drop = ["TransactionDT","TransactionID","D15"]
drop_var_xs(ood_drop, xs, valid_xs)
X.drop(ood_drop,axis=1, inplace=True)
m=rf(X,Y)
metrics(m,xs,y,valid_xs,valid_y)
```
Kaggle how to: [here](https://www.kaggle.com/konradb/adversarial-validation-and-other-scary-terms)

Link from previous: [here](http://fastml.com/adversarial-validation-part-two/)

Use of Adv Validation in IEEE fraudulent: [here](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111284)

**AV done for IEEE but with test**

``` python
## finding out of domain dater 
df_dom = pd.concat([xs, test_xs],ignore_index=True)
is_test = pd.DataFrame([0]*len(xs) + [1]*len(test_xs))
len(df_dom)
```

``` python
idxT,idxV = train_test_split(np.arange(len(df_dom)),test_size=0.2)
```

``` python
m = xgb_av_fun(df_dom.iloc[idxT], is_test.iloc[idxT], 
            eval_set=[(df_dom.iloc[idxV],is_test.iloc[idxV])])
```


The ideas online about AV is that do it and then select your train
data most similar to your test data...


### Grid search cv

``` python
## Getting best hyperparameters
from sklearn.model_selection import GridSearchCV
param_grid = {"max_features":[0.2,0.3,0.4,0.5,0.7,0.8],
              "max_samples":[0.2,0.4,0.5,0.6],
              "min_samples_leaf":[1,5,15,25,35,50]         
             }
cv_rf = GridSearchCV(estimator=m, param_grid=param_grid, scoring="roc_auc", n_jobs=-1,cv=5, verbose=3, return_train_score=True)
cv_rf.fit(xs,y)
## Get the results in a csv
pd.DataFrame(cv_rf.cv_results_).to_csv("gscv.csv")
## Save the pickle file of GSCV
import joblib
joblib.dump(cv_rf, 'GSCV1.pkl')
cv_rf_test = joblib.load("GSCV1.pkl")
```

Mean of all estimators gives the random forests results

``` python
## checking if mean of all estimators gives the random forest results
def r_mse(pred,y): return round(math.sqrt(((pred-y)**2).mean()), 6)
preds_p = np.stack([t.predict_proba(valid_xs)[:,1] for t in m.estimators_])
r_mse(m.predict_proba(valid_xs)[:,1],preds_p.mean(0))
```

### **Interpreting each decision tree** 
using waterfalls and tree interpreter

``` python
#hide
import warnings
warnings.simplefilter('ignore', FutureWarning)

from treeinterpreter import treeinterpreter
from waterfall_chart import plot as waterfall
```

``` python
draw_tree(m, xs, leaves_parallel=False, precision=2)

row = valid_xs.iloc[:5]
prediction,bias,contributions = treeinterpreter.predict(m, row.values)
print(prediction[0,1], bias[0,1], contributions[0][:,1].sum())

waterfall(valid_xs.columns, contributions[0][:,1], threshold=0.01, rotation_value=45,formatting='{:,.3f}');
```

The contributions are the difference in the mean values of internal
node and the previous node. In case they are probabilities they are
the ratios of "true" to "false" values at each internal node.

The bias is the mean value at the top most node (doesn't change for
any row. Sum of contributions + bias gives the prediction.


Docs description [here](http://blog.datadive.net/interpreting-random-forests/).



### Partial dependence plot

``` python
from sklearn.inspection import plot_partial_dependence

fig,ax = plt.subplots(figsize=(12, 4))
plot_partial_dependence(m, valid_xs_imp, fi.cols[0:2],
                        grid_resolution=20, ax=ax);
```

In this plot is done with the existing model. First the data
independent variable is all made X, then X+ 1 then X+2 etc... and
dependent variable is plotted.
						
						
### Handling missing values

In the IEEE fraud detection dataset, using RFs and removing variables
with 25% N/A values led to 1% increase (88%-->89%) ROSed sample.

- algorithms such as naive bayes, k nearest neigbours can work with
  it.
  
- [People seem to want to drop columns with more than 30% max](https://discuss.analyticsvidhya.com/t/what-should-be-the-allowed-percentage-of-missing-values/2456). But
  if the variable is "important" then you might want to keep it. It is
  said that the age column in the titanic dataset adds a lot of value
  to the final result despite not having 30% of the age data.

- could use linear regression to determine the missing values

- could use mean/median to determine the values (fastai in addition
  does another column where it finds where stuff is NaN)
  
- MICE imputation???, check out variance of the variable etc...

### Handling missing data only in test dataset

``` python
def na_check(col): return df.loc[:,col].isna().sum()>0,df_te.loc[:,col].isna().sum()>0
na_col = {col: na_check(col) for col in cont}
na_col_te = [col for col in cont if df.loc[:,col].isna().sum()==0 and df_te.loc[:,col].isna().sum()>0]
#na_col_te = ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14']
na_col_te
```

``` python
df = pd.concat([df.median().to_frame().T, df], ignore_index=True)

```

``` python
## add values to that row
df.loc[df.index[0],na_col_te] = np.nan
df.loc[df.index[0],"isFraud"]=0 ## forcing it to be an int rather than in between like 0.5
df.loc[df.index[0],na_col_te]
df.shape
```

### Gradient boosting

IT WILL OVERFIT.

- Train a small model that underfits your dataset.
- Calculate the predictions in the training set for this model.
- Subtract the predictions from the targets; these are called the
  "residuals" and represent the error for each point in the training
  set.
- Go back to step 1, but instead of using the original targets, use
  the residuals as the targets for the training.
- Continue doing this until you reach some stopping criterion, such as
  a maximum number of trees, or you observe your validation set error
  getting worse.


Is training with small sample and getting residuals and training to
reduce these residuals... In the end you add up all of the predictions
unlike in bagging. There is gradient boosting machines and gradient boosting
decision trees and some other variants.

1. Start with mean value one leaf

2. Get residual, and train an "underfit" tree with it

3. Scale it

4. now make many more with residuals.

Note: use 8 to 32 leafs as max.

Note2: We use "scaling" i.e., use a learning rate (0.1) to make
smaller steps towards the final value. "According to empirical
evidence", taking lots of small steps in the right direction results
in better predictions."


**GB classification**

Here we do classification by looking at log odds. Log(odds) if
something "isFraud" or not. We convert log(odds) to probability like
in logistic regression, to 

	e^(log(odds))/(1+e^log(odds))
	
	
**Links**

[Another explanation of GB](https://towardsdatascience.com/simplifying-gradient-boosting-5dcd934e9c76)

### saving tabular pandas and loading them


``` python
save_pickle("to.pkl",to)
to = load_pickle(input_path+"fraud-detection/to.pkl")
```

### XGBoost xgb

> xgboost decides at training time whether missing values go into the
> right or left node. It chooses which to minimise loss. If there are no
> missing values at training time, it defaults to sending any new
> missings to the right node.---[stack](https://stats.stackexchange.com/questions/235489/xgboost-can-handle-missing-data-in-the-forecasting-phase) 


### implement kfold or stratified k fold

```python
from sklearn.model_selection import KFold
skf = KFold(n_splits = 2, shuffle = True, random_state = 42)
from sklearn.model_selection import cross_validate
m_cv = cross_validate(m, df_dom, is_test, scoring='roc_auc', cv=skf,
n_jobs=-1, return_train_score=True)
```

`KFold` can be substituted by `StratifiedKFold`.

To get output you can do:

``` python
m_cv["test_score"],m_cv["train_score"],m_cv["fit_time"]
```


### feature importance handy definitions

``` python
## Plot  important features
def xgb_fi(m, df,df_real):
    fi = pd.DataFrame({'cols':df.columns, 'imp':m.feature_importances_}
                       ).sort_values('imp', ascending=False)
    #fi["isCont"] = fi.cols.isin(cont)
    fi["countNA"] = [df_real.loc[:,col].isna().sum()/len(df_real) if
    col in df_real.columns else float("NaN") for col in fi.cols]
	
    return fi

def plot_fi(fi):
    return fi.plot('cols', 'imp', 'barh', figsize=(12,7), legend=False)
```


### Metrics

``` python
def m_rep(m,xs,y): return classification_report(y, m.predict(xs), labels=[1,0], digits=4, output_dict=True)



def metrics(m, xs, y , valid_xs, valid_y): 
    tr_rep = m_rep(m,xs,y)
    vd_rep = m_rep(m,valid_xs,valid_y)
    tr_auc = roc_auc_score(y,m.predict_proba(xs)[:,1])
    oob_auc=0.0000
    #oob_auc = roc_auc_score(y,m.oob_decision_function_[:,1])
    vd_auc = roc_auc_score(valid_y,m.predict_proba(valid_xs)[:,1])
    tr_rec_1 = tr_rep["1"]["recall"]
    tr_rec_0 = tr_rep["0"]["recall"]
    vd_rec_1 = vd_rep["1"]["recall"]
    vd_rec_0 = vd_rep["0"]["recall"]
    tr_prec_1 = tr_rep["1"]["precision"]
    tr_prec_0 = tr_rep["0"]["precision"]
    vd_prec_1 = vd_rep["1"]["precision"]
    vd_prec_0 = vd_rep["0"]["precision"]
    
    print('{:.4f} ; {:.4f} ; {:.4f}; {:.4f}, {:.4f}; {:.4f}, {:.4f}; {:.4f}, {:.4f}; {:.4f}, {:.4f}'
          .format(tr_auc, oob_auc, vd_auc, tr_rec_1, tr_rec_0, vd_rec_1,vd_rec_0,tr_prec_1, tr_prec_0, vd_prec_1,vd_prec_0))
```

### xgb cv for loop OOF out of fold predictions

``` python
%%time
from sklearn.model_selection import KFold
skf = KFold(n_splits = 5, shuffle = False, random_state = 42)

tr_pred = np.zeros(len(xs))
oof_pred = np.zeros(len(xs))
#te_preds = np.zeros(len(X_test))

for i, (idxT, idxV) in enumerate(skf.split(xs,y)):
    print('Fold',i)
    print(' rows of train =',len(idxT),'rows of holdout =',len(idxV))
    m = xgb_fun(xs[cols].iloc[idxT], y.iloc[idxT], 
         eval_set=[(xs[cols].iloc[idxV],y.iloc[idxV])])
    
    tr_pred[idxT] += m.predict_proba(xs[cols].iloc[idxT])[:,1]/(skf.n_splits-1)
    oof_pred[idxV] += m.predict_proba(xs[cols].iloc[idxV])[:,1]
    #te_preds += clf.predict_proba(test_xs[cols])[:,1]/skf.n_splits
    del m; x=gc.collect()

print('{:.4f} ; {:.4f} ; {:.4f}'
          .format(roc_auc_score(y,tr_pred),0.0000, roc_auc_score(y,oof_pred)))
```

### Prediction of Test dataset code

``` python
def format_test_preds(preds,test_xs,comment):
    #preds = m.predict_proba(test_xs[cols])[:,1]
    print(pd.DataFrame(preds).describe())
    
    ## Make into submission dataframe
    df_pred = pd.DataFrame({"TransactionID":test_xs.TransactionID.to_list(),
                            "isFraud": preds})
    
    ## save
    df_pred.to_csv(comment+"my_subs.csv",index=False)
    print(df_pred.shape)
    del df_pred; x=gc.collect()
```
### regex

**R in front**

`r"ba[rzd]"` says to find exactly "ba[rzd]" and ignore the `[]`. `r`
helps to treat the whole thing as string. 


Cheat Sheet Table is [here](https://realpython.com/regex-python/)

**Getting True False values from regex'ed columns**

``` python
tf = [bool(re.search("^"+str_sch+"[0-9]+",col)) for col in
xs.columns.to_list()]
```

### heatmap correlation

``` python
%%time
import seaborn as sns
xs_corr = xs.corr()
plt.figure(figsize=(15,15))
#mask = np.triu(xs_corr)
sns.heatmap(xs_corr, cmap='RdBu_r', annot=False, center=0.0)#, mask=mask)
plt.title('All Cols',fontsize=14)
plt.show()
```

**corrwith**

``` python
df[cols].corrwith(
    df[col]).reset_index().sort_values(
    0, ascending=False).reset_index(drop=True).rename(
    {'index':'Column',0:'Correlation with ' + col}, axis=1)[:20]
```

### cardinality ordered and unordered categorical data

[Here](https://stackoverflow.com/a/34688604/5986651) they say when you need to model unordered categorical data
you could use one hot encoding. Other wise with label encoding you end
up treating it like an ordered category i.e., numerical
treatment... A>5, A<5 in the decision tree. Where certain pairs might
not be possible.

> man... Great find! damn! Never knew these things existed.  Thanks a
> ton. He essentially seems to be saying "not bad" about using
> "ordered categories" in a "non-ordered-way" with label
> encoding. right? and we can also specify that and label encode if
> necessary. I guess we can assume this is the case for "non-ordered
> categories" as well. What "not bad" means is not clear to me, but
> for now, this is good enough I guess. I can skip worrying about it
> and move on then... :slight_smile: thanks mate good
> one. :slight_smile: -- Pandian on discord

[Here](https://youtu.be/CzdWqFTmn0Y?t=3583), exactly jeremy talks about the above. For now we don't
think this is too big of a problem. :) Maybe we can check this later.

Also check [this](https://stats.idre.ucla.edu/other/mult-pkg/whatstat/what-is-the-difference-between-categorical-ordinal-and-numerical-variables/#:~:text=An%20ordinal%20variable%20is%20similar,clear%20ordering%20of%20the%20categories.&text=Even%20though%20we%20can%20order,the%20levels%20of%20the%20variables.) out.

[This](https://pbpython.com/categorical-encoding.html) describes how to do it in python



### splitting columns

cents and dollars

``` python
def split_cols(df, col = "TransactionAmt"):
    df['cents'] = df[col].mod(1)
    df[col] = df[col].floordiv(1)
```

R_emaildomain

``` python
def split_cols_str(df,col,delim="."):
    df[[col+str(1),col+str(2)]] = df[col].str.split(delim,expand=True,n=1)  
```

### Replace string in column

``` python
%%time
lst_to_rep = [r"^.*chrome.*$",r"^.*aol.*$",r"^.*[Ff]irefox.*$",r"^.*google.*$",r"^.*ie.*$",r"^.*safari.*$",r"^.*opera.*$",r"^.*[Ss]amsung.*$",r"^.*edge.*$",r"^.*[Aa]ndroid.*$"]

lst_val = ["chrome","aol","firefox","google","ie","safari","opera","samsung","edge","chrome"]
df_all["id_31_browser"].replace(to_replace=lst_to_rep, value=lst_val,
regex=True,inplace=True);
```

### day hr conversion from seconds

TransactionDT given in seconds...

``` python
df_all["TransactionHr"] = df_all["TransactionDT"]/(60*60)%24//1/24
df_all["TransactionHr2"] =
(df_all['TransactionDT']%(3600*24)/3600//1)/24.0 #CD's solution
```
Seconds to days...

``` python
df_all["TransactionDay"] = df_all["TransactionDT"]/(60*60)//24
df_all[["TransactionDay","TransactionDT"]].sample(10)
```
days to weekday

``` python
1477538/(3600*24)/7,1477538/(3600*24)%7,1477538/(3600*24)%7//1,1477538/(3600*24)%7/7
df_all["WkDayNum"] = df_all["TransactionDT"]/(3600*24)%7/7
df_all[["WkDayNum","TransactionDT"]].sample(10)
```



### Encoding labels

``` python
def change_col_dtype(df,col):

unum = len(df[col].unique())
#print(col,unum,df[col].dtype)

df[col],_ = df[col].factorize() # Label encoding, nans changed to -1
df[col] = df[col].replace(-1,np.nan)
#     if unum<128: df[col] = df[col].astype('int8')
#     elif unum<32768: df[col] = df[col].astype('int16')
#     else: df[col].astype('int32')

print(col,len(df[col].unique()),df[col].dtype)
```
### encoding combine

```python
def encode_CB2(df1,df2,uid):
    newcol = "_".join(uid)
    ## make combined column
    df1[newcol] = df1[uid].astype(str).apply(lambda x: '_'.join(x), axis=1)
    df2[newcol] = df2[uid].astype(str).apply(lambda x: '_'.join(x), axis=1)
    
    ## concat and then factorize
    temp_df = pd.concat([df1[newcol],df2[newcol]],axis=0)
    temp_df,_ = temp_df.factorize(sort=True)
    
    ## unconcat    
    if temp_df.max()>32000: 
        df1[newcol+"_fact"] = temp_df[:len(df1)].astype('int32')
        df2[newcol+"_fact"] = temp_df[len(df1):].astype('int32')
    else:
        df1[newcol+"_fact"] = temp_df[:len(df1)].astype('int16')
        df2[newcol+"_fact"] = temp_df[len(df1):].astype('int16')
    return [newcol,newcol+"_fact"]
```

## datacrunch setup

Docs are [here](https://datacrunch.io/docs/adding-a-new-user/).

What I did is, first ssh'ed into the system using

to create an instance you need to create a key set, for that I used:


	ssh-keygen -t ed25519 -C "your_email@example.com"

Then I provided the public key to DC and then to ssh into that shit I did

	ssh -i path-to-private-key host-ip-address
	
	sudo ssh -i /home/eghx/.ssh/id_ed25519 135.181.63.176
	
	sudo ssh -i /home/eghx/.ssh/id_ed25519 username@135.181.63.176
	
shortcutted as `dc_connect`

For the first time it is suggested to create a new user.

When you go into root you can create a new user follwoing these
[instructions](https://datacrunch.io/docs/adding-a-new-user).

To get into a user use `su - username`.


currently unable to open jupyter not as root:
https://askubuntu.com/questions/1038339/i-always-have-to-access-jupyter-notebook-as-a-root-user

**fastai image**

It turns out that in the "fastai" image there is already a user: "user". Only
in this "user" (not root or other users you yourself create) do the
things happen such as `conda` or `pip`. This is where anaconda is
installed.

To go into this I needed to ssh the following: 

	sudo ssh -i /home/eghx/.ssh/id_ed25519 user@135.181.63.176
	
	
**Kaggle API**

1. Go to kaggle account and then create token aPI

2. Copy the downloaded file from [B to A](https://unix.stackexchange.com/a/106482/267853).

		scp Desktop/kaggle.json user@135.181.63.176:~/.kaggle/

3. check if it has reached. :)

4. change permissions not sure why, but is on the [official kaggle
   documentation](https://github.com/Kaggle/kaggle-api)
   
		chmod 600 ~/.kaggle/kaggle.json

5. 401 permissions unauthorized?

Then just get a new token, possible that the old one expired. 

**changing permissions of folder created by root**

	sudo chown -R user:user agent18/
	
`user:user` refers to the user --> user and the group --> user.

**Extracting zip files from folder**

	for i in *.zip; do unzip "$i" -d "${i%%.zip}"; done


**Extracting datasets from yours and from kernels**


	kaggle datasets download -d thejravichandran/fraud-detection
	
	kaggle competitions download -c ieee-fraud-detection
	kaggle datasets download thejravichandran/ieee-fraud-detection-joined-tables 
	
	kaggle kernels pull thejravichandran/fraud-detection-v10-understanding-adv-val
	
**Error with import fastai vision related staments**

Check if fastcore version is correct using `conda list fast` and
comparing it with the fastai github yaml content.


## Setting up google cloud

https://www.kaggle.com/alexisbcook/get-started-with-google-cloud-platform

https://www.kaggle.com/akashram/auto-updating-data-using-kaggle-api-gcp

https://www.kaggle.com/rosebv/train-model-with-tensorflow-cloud (how
to work with tensorflowcloud)

https://www.kaggle.com/product-feedback/159602 --> direct upgrade

**Installing**

**Identify instance OS**

	cat /etc/*-release 
	
	
**Installing monitoring system**

follwing these instructions:  https://cloud.google.com/monitoring/agent/installation

`df -h #for disk space`

Follow this on SSH terminal (very very different from the terminal
associated with jupyterlabs).


**Check installed packages**

`dpkg --get-selections | grep nvidia`


## todo CV (11 days to go)

~~1. baseline~~
1. move to gcp or datacrunch.io
2. bigger dataset results 
3. callbacks to get export
4. Other architectures
5. Implement works from round 5
6. what can you find from confusion matrix
7. over-fitting, false +ves, false -ves result
8. Write a blog

## todo tabular

1. ~~look at data (common man)~~
2. clean tables (understand nan na type stuff)
3. build pipeline (markus)
4. baseline
5. Categories fixing
6. do the entire nb (by tomorrow)
7. tweak stuff (sunday)
8. see if you can do something else (add novelty) (monday)
9. overfitting reduction (tuesday)
10. Write blog on the learnings.(wednesday)

Am thinking of starting with rf working with the valid for now. Let's
see where that gets us. this includes, 

Decision trees don't work well here as we require prolties and AOC. So
let's kill it. Going back to the drawing board to look at the data.

Also Let's stick to basic techniques. Let's see what OOC error we get
then come back and fine tune... Min. effort. quick draft PG style?

- Cleaning (replacing zeros strategies? categorical variables?)
9- Bagging, RF, and DL 
- looking at data and what else to remove cluster etc...
- reduction of size of columns (svd, clustering etc...)
- boosting?
- regression anova and other stuff later?


Also want to implement sigmoid stuff today for the other assignment.
or test other architectures.

## today

predict to test,

understand conf matrix, understand what output is required? does label
selection make a difference. etc...

add  the split: 
https://www.kaggle.com/c/ieee-fraud-detection/discussion/99993

"Looks like the data has a time split… so make sure you are not using time as a feature."

"I confirm here that the data is a clean time series split on the TransactionDT. It looks like we might need to consider different validation techniques."

Heat map might require clustering and scaling to see how they
group. Not sure what to do after that...


## now (deprecated)

~~Test on the bigg data, "balanced subsample", and "oversampling", and
and use the metrics generated from gridcv.~~

~~- reproduce conf matrix, what is tfr and tfr?~~
~~- reproduce praba --> roc coiv~~

- fastai 5/5 plan to understand rf...

- look at removing time features as adviced by Peter?

- CV again understanding whats happening.

- check where you are today in the whole plan (today lets dag)

- remove time related features understand why?


- SETUP proper CV and do the whole feature importance based on validxs
  again.

- Make a plan for the coming days.

1. start new sheet

2. Print score function

3. Do gridsearchCV, do feature importance and clustering with check against valid,
   remove is_valid params, reduce overfitting, Look at params where
   you add shit loads of nans based on feature
   importance. Undersampling but not random... check correlation.
   
   Rewrite the whole thing. Clean version.
   
   Let's remove features and check for isna issues of top features
   then do testing...
   
   and then do the testing?
   
	1. remove the parts that make it non resilient?
	
	2. Set up RF
	
	3. Setup GridsearchCV with certain params and then run cv on
       it 5. Number of features, etc...
	
	4. Run weighted oversampling "balanced dataset" for unbalanced DS
       see if results change then try smote as well.
	
	5. Run RF and check feature importance 
	
	6. Filter to 20-50
	
	7. check isna for filled up columns and how we might be affecting it?
	
	8. Filter further by running induvidual tests
	
	9. Look at clustering to remove similar stuff.
	
	10. See how to look at clustering and remove
	
	11. run grid search one last time?
	
	12. Make sure you have provided some extra care for isna types and
        IMB
		
	13. Generating other columns with date?
	
	14. extrapolate to the all dater.

4. clusterning remove var, check current grid, make ok.
5. Tomo look at overfitting and do the same thing?
6. start with GBM asap
7. consider NNs perhaps.

8. final set

	1. try undersampling alone with not random undersampling but "most
       different row selection" undersampling.
	2. try what we have learnt so far...
   
9. Look at GBM and understand the scene... 

## now

Goal ultimately: XGB, regression types, NN, or [this](https://www.kaggle.com/c/lish-moa/discussion/202256).

1. ~~check if you increase the ood numbers if you get better results.~~

2. do adversarial validation on daterset between test and train using
   rfs and xgb. Now that I have access to both.

3. See an example of XGB 

4. what is XGB?

5. [reproduce](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111510) identifying "same clients" in test and train... 

6. Understand XGB, stratified kfold and then adverserial validation???
   (8 videos + notes)

7. come up with plan for next 7 days. where do you want to be and
   check everyday. Parkinson's law.

8. EDA reproing his plots and undersstanding what he means,

9. Run XGB and see where we are at with default

10. plan some tuning with cv


Also see stratified kfold. See what he has done and plan reproduction...


find out what they did for their unbalanced dataset. He didn't care.

	
## tomorrow
1. ensemble, gbm, regression

2. rf parameters and what they mean, what is the output actually
   outputting? auc? TP?

3. removing time elements

4. how to tune which parameters

5. why is rf overfitting. 

6. Improve ERROR

7. REMOVING 200 columns?

8. heatmaps, oversampling, undersampling, fastai checks (boosting
   etc...) and remove variables and test, remove time variables and
   it's corr variables, pca, normalizing?, isfraud a float or a class?
   
9. nn?

10. regression anova etc...


## Experiments

1. with valid without valid prediction for whole dataset
2. 100k prediction vs 590k prediction
3. wht columns can you remove?


## observations

1. categ split between 590k set and 50k sample is the same 3% in this
   case.
2. time based split.
3. Peter suggests to remove time details.
4. for the final set take everything
5. Apprently most of the ML techniques are expecting Balanced datasets
   ---Statquest
   
   |                        | tr recall  | vd recall  | tr prec       | vd prec        |
   |------------------------|------------|------------|---------------|----------------|
   | baseline               | 37.4       | 26.9       | 94.8          | 79.6           |
   | balanced  (1,26)       | 67.6 (80%) | 30.2 (12%) | 88.7 (-6.5%)  | 75.3 (-5.5%)   |
   | subsample balanced     | 67.5 (80%) | 32.9 (22%) | 88.0 (-7.2%)  | 70.9  (-11.7%) |
   | overweighting (1,1000) | 65.3 (80%) | 25.1 (-7%) | 84.5 (-10.9%) | 84.0  (5%)     |


6. You want to predict on a set where that has times that are not seen
   in training. This will give you how good your dater is. In my case
   Valid gives 0.88 while training gives 0.99 or something. Using OOB
   score I think is pointless as it behaves like cross-validation. The
   same reason why we think cv is useless, we also think oob is useles.

**Reason for difference in train and valid auc score**

1. different imbalance in train and valid 

	NO. Both have the same % of imbalance :) I would go on to say that
    the same will be the case of imbalance in the test dataset too as
    I get similar auc scores.
	
2. "overfitting"

3. time info inside

4. too many unnecessary rows

5. precision and recall of "1" too poor( 78% and 26% in valid). even
   training is bad.
   
## plannensie


0. USing GPU???? rapids?


0. Get data processed (done)

1. Do [AV like Konrad](https://www.kaggle.com/konradb/adversarial-validation-and-other-scary-terms/comments), but based on suggestions from [Chris](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111510)
   read part 1 and 2 of [this](http://fastml.com/adversarial-validation-part-one/) as linked by Konrad
   
2. Use XGB to predicta awards section without imputing.

2. Userid identify

3. EDA

4. tackle NaNs

5. feature importance

6. Check validation strategy
come back and see how to circumvent gpu issues. I am thinking of going
to datacrunch today... use GPU, get a bit faster computations... How
much faster are they... Please find out?


download the dater...

then we need to do other things...
check fastai install!
