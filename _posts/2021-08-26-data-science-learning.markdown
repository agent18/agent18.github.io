## importing files

``` python
with open(json_path, encoding="utf8", errors='ignore') as f:
     file = json.load(f)
```

## Matplotlib


- x axis when there is a lot
- rotate x axis
- make log axis
- add grids
- make multiple graphs
- what else can matplotlib dag?

**Import statements**

``` python
import matplotlib.pyplot as plt
import numpy as np
```

**Basic plot**

``` python
## plot (+ label + color + texture + limits + move_label around etc.)

x = np.linspace(1,5,10000)
a = np.log(x) #loge
b = np.log10(x) #log10
c = 2.303*b

plt.plot(x,a)
plt.plot(x,b)
plt.plot(x,c)

plt.ylabel("log_base(x)")
plt.xlabel("x")

plt.title("testing differen log bases")

plt.legend(["ln","log10","2.203 x log10"])

plt.show()
```

**Basic plot with Legend variation**

``` python

x = np.linspace(1,5,10000)
a = np.log(x) #loge
b = np.log10(x) #log10
c = 2.303*b

plt.plot(x,a, label="loge")
plt.plot(x,b, label="log10")
plt.plot(x,c, label="2.303 x log10")

plt.ylabel("log_base(x)")
plt.xlabel("x")

plt.legend()

plt.title("testing differen log bases")

#plt.legend(["ln","log10","2.203 x log10"])

plt.show()

```

**Format strings color**
https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html#matplotlib.pyplot.plot

```python
#marker line color
plt.plot(x,a, "+:k",  label="loge")
plt.plot(x,a, color="k", linestyle=":", marker=".")
```

**Styles**

With styles don't worry about line width,grid and try choosing default
colors, try leaving it to automatic stuff.

	plt.style.available # shows what style names are available
	plt.style.use("fivethirtyeight")
	
	#or comic style
	
	plt.xkcd() 
	
**Save**

	plt.savefig("test.png")
	


### Plotting a bar chart side-by-side

**Keypoints**

1. To get side-by-side plots we need to use `width` of bar and also
   change the x-position of each bar-plot
   
2. We make indices and width compatible, we generate our own indices.

3. We replace the x_labels using `plt.xticks(ticks=x_indexes, labels=ages_x)`


``` python

## ploting bar

from matplotlib import pyplot as plt

plt.style.use("fivethirtyeight")

ages_x = [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]

x_indexes = np.arange(len(ages_x))
width = 0.25

dev_y = [38496, 42000, 46752, 49320, 53200,
         56000, 62316, 64928, 67317, 68748, 73752]
plt.bar(x_indexes + width, dev_y, width=width, color="#444444", label="All Devs")

py_dev_y = [45372, 48876, 53850, 57287, 63016,
            65998, 70003, 70000, 71496, 75370, 83640]
plt.bar(x_indexes, py_dev_y, width=width, color="#008fd5", label="Python")

js_dev_y = [37810, 43515, 46823, 49293, 53437,
            56373, 62375, 66674, 68745, 68746, 74583]
plt.bar(x_indexes+2*width, js_dev_y, width=width, color="#e5ae38", label="JavaScript")

plt.legend()

plt.title("Median Salary (USD) by Age")
plt.xlabel("Ages")
plt.ylabel("Median Salary (USD)")

plt.xticks(ticks=x_indexes, labels=ages_x)

#plt.tight_layout()

plt.show()
```

## Machine Learning 
### types

> As from what I understood the assignment will be around
> cluster/segmentation analysis; with machine learning as a bonus. I
> don’t know if this helps you or makes any sense – but hopefully it
> gives you a bit of an understanding

1. types of Machine Learning

2. clustering statquest

3. segmentation analysis (example customer segmentation)

4. find example 

5. and reproduce

6. do your own example with fraud detection data


**Types of ML**

https://www.youtube.com/watch?v=yN7ypxC7838

1. Supervised

	1. regression (continuous variables)
		- linear regression
		- multiple regression
		- polynomial regression
		- decision tree
		- random tree (multiple dts using bootstrapped datasets)
		- xgboost
		- nueral network
	2. classification (discrete)
		- logistic regression
		- Support vector machine (sounds like multiple regression but
          for classification)
		- naive bayes
		- DT, rf and nn

2. unsupervised

	- clustering 
		- kmeans
		- hirarchecal
		- mean shift
		- density based
	- dimensionality reduction
		- feature elemination
		- feature extraction
		- PCA

### **K-means clustering**

https://www.youtube.com/watch?v=4b5d3muPQmA

https://www.kaggle.com/thejravichandran/kmeans-learning

- k stands for how many clusters you want to identify.
- process
  - standardize (normalize)
  - choose k random points for clustering
  - now go over every point and classify them as belonging to cluster
    based on "distance"
  - Calculate mean of all the different clusters
  - Repeat step 2. Stop when you see no change in clustering
  - track variation of different clusters and start over till N outcomes
    are reached. 
- variation in cluster around different clusters shows how good or bad
  out clustering is.
- **what value for k?**
  - Plot silouette coefficient vs k And take highest sc k value
  - find elbow in varience vs k plot (varience decrease stops becoming
    worth while)
  - look for uniform k value and highest siloutte coeff in the
    siloutte sample histogram plot
- distance => euclidean distance (basically sqrt(sumsq(x-x1,x-x2...)))

- **uses:** clustering to see how each sample is different? and using
  it in the Machine Learning model
  
what about categorical variables???

Are we expected to normalize the results? what are the caveats?

It is **only for numerical** variables and not for
categorical. Ordinal, maybe.

**Coding**:

- nan strategy
- making categories with kmeans
- making sense of categories with kmeans

https://www.kaggle.com/fabiendaniel/customer-segmentation

Top voted stuff but too much info

https://www.kaggle.com/mgmarques/customer-segmentation-and-market-basket-analysis

Nice plots and info above... Does not explain the point of seeing the distribution.

- to keep it mind
  - check number of elements in a cluster
  - what to do categorical variables?
   Perhaps as [here](https://datascience.stackexchange.com/a/9385/67821), maybe we just [one hot encode](https://pbpython.com/categorical-encoding.html) them?
  - get silouette score and plot the variables to visibly see the
    variables and how they're clustering is...
  - compare different variables for each cluster (using avg for
    example), or look at the centroid values ...
  - log the scaled values or not?
  - get deeper into clustering using hierarchical

  
    > StandardScaler : It transforms the data in such a manner that it
    > has mean as 0 and standard deviation as 1. In short, it
    > standardizes the data. Standardization is useful for data which
    > has negative values. It arranges the data in a standard normal
    > distribution. It is more useful in classification than
    > regression. You can read this blog of mine.
    >
    > Normalizer : It squeezes the data between 0 and 1. It performs
    > normalization. Due to the decreased range and magnitude, the
    > gradients in the training process do not explode and you do not
    > get higher values of loss. Is more useful in regression than
    > classification. You can read this blog of mine.


1. get kmeans of several values stopping at ones with least variation
2. check elbow plot
3. check silouette score for each
4. plot silouette score histogram for each cluster
5. plot another variable and the different clusters to see where you
   are at.
6. hirarchical clustering example with categorical variable?
7. PCA
8. linear and multivariate 
9. how to... do linear and multivariate
10. plotting basics

7. Look at the case ikea on github?


**[Silhouette Coefficient](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.silhouette_samples.html?highlight=silhouette%20samples#sklearn.metrics.silhouette_samples), silhouette score:**

 Its value ranges from -1 to 1. 
 
 
 >The best value is 1 and the worst value is -1. Values near 0
 >indicate overlapping clusters.

1: Means clusters are well apart from each other and clearly
distinguished.  
0: Means clusters are indifferent, or we can say that the distance
between clusters is not significant.  
-1: Means clusters are assigned in the wrong way.  

Silhouette Score = (b-a)/max(a,b) where,  
a= Average distance of a sample from all other points in the same
cluster   
b = Average distance of a sample from all other points from
neighboring cluster.



**Hierarchical clustering** associated with heatmaps and dendograms

https://www.youtube.com/watch?v=7xHsRkOdVwo

https://www.kaggle.com/vipulgandhi/hierarchical-clustering-explanation

What two things are most similar. I have used it in the context of
trying to find out what two variables are close to each other.

- HC heatmap shows rows or columns "similar" to each other
  - e.g., heatmap of genes and samples. 
- process
  - compare every row with each other on how "similar" it is.
  - make the first cluster on the most similarest
  - then do again and again and make the dendogram and arrangement
  - height of dendogram is the first cluster and the most similar

- assessing new data points and their cluster
  - centroid
  - closest
  - furthest

- "similar" ==> euclidean distance is used a lot
		    ==> Manhattan distance --> sum(abs(diff))
- choice is arbitrary. They give different outcomes.

**Segmentation analysis**

Follow this page to do clustering and segmentation reporting...

https://towardsdatascience.com/customer-segmentation-arvato-bertelsmann-project-44e73210a1b7

- Data Overview and Data Cleaning;
- Exploratory Data Analysis;
- Unsupervised Machine Learning Task: Cluster Analysis;
- Customer Segmentation Report;
- Supervised Machine Learning Task: Targeting Customers for a Marketing Campaign.

**difference between segmentation and clustering**
https://dfrieds.com/machine-learning/segmentation-vs-clustering.html

**one hot encoding categorical variables**

https://towardsdatascience.com/what-is-one-hot-encoding-and-how-to-use-pandas-get-dummies-function-922eb9bd4970



### PCA


  

