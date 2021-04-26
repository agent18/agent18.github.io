
## Introduction

- Tabular time series data with 590k train transactions and 500k test
  transactions.
- 443 columns as independent variables
- "isFraud" is the dependent variable
- Leader Board (LB) is based on the public and private AUC score.

**Goal**: Predict transactions that are `isFraud==1`.

**Submission**: `TransactionID` and Probability of `isFraud==1`.

This is a year old competition that wont doesn't allow "final
submissions" anymore. Nevertheless I picked this competition to get
experience in Tabular data, attempt my best solutions and learn from
the greats.

Following is my systematic growth to a top 10% solution.

## TL;DR

The following are roughly the things that improved my score.

| Method                 | Public LB | Private LB | Percentile |
|------------------------|-----------|------------|------------|
| baseline               | 0.9384    | 0.9096     | Top 90%    |
| remove 200 `V`         | 0.9377    | 0.9107     | Top 80%    |
| remove time cols       | 0.9374    | 0.9109     | Top 80%    |
| Transform `D`          | 0.9429    | 0.9117     | Top 50%    |
| Combine and FE         | 0.9471    | 0.9146     | Top 30%    |
| Aggregation on uid1    | 0.9513    | 0.9203     | Top 20%    |
| Additional aggregation | 0.9535    | 0.9220     | Top 10%    |
| fillna                 | 0.9537    | 0.9223     | Top 10%    |


**AUC score increase over time:**

  * [x] `chart.png`



## The Part that makes it harder to predict

- We are **not predicting Fraudulent Transactions**. Once a client has
  a fraudulent transaction [all the posterior transactions (associated
  with the useraccount, email address or billing address) are marked
  as fraud](https://www.kaggle.com/c/ieee-fraud-detection/discussion/101203).
  
  And it is not known as to **What constitutes the client**. But here
  is an example of an "assumed client-variable set"
  
    * [x] Example of is fraud and not fraud mix (client-isFraud1.png)
  
- To make this even more difficult the meaning of most of the
columns are obscured. For example, we know that `D1` to `D15` are some
"timedelta" such as days between each transaction, but don't know what
they stand for. This goes for all 433 columns.

## EDA

### Lots of NaNs

- The data has "many" variables with >25% Nans (254 columns out of 439
  columns)

- I tried both fillna, removing the columns completely and also just
  leaving them as NANs

- I found best results with filling NaNs with an artificial number
  such as `-9999`. Removing `>25%` NaN columns seems to remove
  critical information. Results with `fillna` were better by 0.0002
  than leaving `NaN`s as it is.


**Median Imputing doens't make sense**

There are columns such as "card1" and "addr1" which denote credit card
and address information respectively, but there is no way a median
imputation makes any sense. So this is not done.

### **Reducing 339 `V` columns to 139 `V` columns**
	
There were about 340 `V` columns said to be "engineered" by the
company conducting the competition. They are engineered from the rest
of the 100 columns. It thus appears that the `V` columns might not be
so important.

The `V` columns share a "lot" of correlation and large number of
Nan's. The goal of this step is to find "similar" columns based on
number of "NaN's", and Correlation>`0.75`.

- First group by NaN's
- Within each Nan group, highly correlated columns are binned together
- The column with maximum unique values is chosen from each bin.

For example, `V35` to `V52` (17 columns) contain the exact same number
of NaNs (168k). They contain 8 pairs of highly correlated
columns. From this we select `['V36', 'V44', 'V39', 'V49', 'V47',
'V41', 'V40', 'V38']`. Using a script this process is automated for
all the different `Nan` groups.

```
plt.figure(figsize=(15,15))
#mask = np.triu(xs_corr)
sns.heatmap(xs_corr, cmap='RdBu_r', annot=False, center=0.0)#, mask=mask)
plt.title('All Cols',fontsize=14)
plt.show()
```

  * [x] Display heatmap from 08v11 (corr.png (png is missing add it later))


**Effect on LB and time:**

|                      | public | private | time   |
|----------------------|--------|---------|--------|
| baseline             | 0.9384 | 0.9096  | 11mins |
| remove 200 V columns | 0.9377 | 0.9107  | 7mins  |


Small decrease in score for a large gain in computation time.

### Reducing further

Tried reducing other columns, such as the `C` columns and `M` columns
and `ID` columns in a same manner but then they reduced the LB by
0.01, so this is as far as the reduction goes.

### Understanding D columns

`D1` column is known from the discussions to be "days since the client
credit card began".  Subtracting this value from the "Transaction Day"
will result in CONSTANT values for per client. Following is an example
of an "assumed client-variable set".

  * [x] D1n vs D1 per client (`D1-D1n.png`)

We do the same for all `D` columns irrespective and allow the model to
decide what is important and what is not.

`D9` denotes the hours at which the transactions are done. This is
tested using ` df["Hr"] = df["TransactionDT"]/(60*60)%24//1/24`. The
following plot clearly shows it's relation to determining if a
transaction is Fraud or not.

  * [x] `D9.png`

### **Unbalanced data**

The Data has only 3.7% transactions names as "Fraud"
(`isFraud`=1). `RandomOverSampling` and `Smote` didn't do much for the
score so it has been skipped. 

## EDA for UID

As said before this competition is not just about predicting
fraudulent transactions over time, it's about predicting clients who
are more likely to have `isFraud` transactions. Client account, client
email addresses and client address associated with a Fraudulent
transaction is made `isFraud==1` in a posterior fashion. We need to
thus find these client variables (UIDs) to be able to predict better.

**Finding the UIDs**

I stood on the [shoulders of giants](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111510), to find help on this part.

UIDs are nothing but variables that help identify a particular
clients' transactions. Not all transactions are fraud for a client but
"most" are expected to be. This allows us to determine the quality of
a UID.

To find the UID a bit of guess and **adversarial validation** (AV) is
used (AV is explained later). Based on how "isFraud" is defined we can
already guess that `card1`, `addr1` & `P_emaildomain` are probably
part of UID. In addition we use AV to determine the rest of the
columns.

* [x] `fi.png`

To evaluate how good the UID is, we look at how much percent of the
clients have both `isFraud==0` and `isFraud==1` and we check manually
if they happen one after the other in sequential manner. Shown below
are the evaluations for different UIDs.

|      | Mixed | isFraud==1 | isFraud==0 |
|------|-------|------------|------------|
| uid0 | 1.9%  | 1.9%       | 96%        |
| uid1 | 1.4%  | 2.3%       | 96.3%      |
| uid2 | 0.79% | 2.6%       | 96.5%      |
| uid3 | 0.43% | 2.6%       | 96.9%      |
| uid4 | 0.38  | 2.6%       | 97%        |

UID0: D10n, card1, addr1
UID1: D1n, card1, addr1
UID2: D1n,card1,addr1,p\_emaildomain
UID3: D1n,card1,addr1,p\_emaildomain, D3n
UID4: D1n,card1,addr1,p_emaildomain, D3n, V1, M7

In all cases "many" of the "Mixed" clients don't have `isFraud==0` and
`isFraud==1` sequentially. So it looks like most of the Mixed clients
are wrongly classified. I tried refining it with several other
combinations but had little success. So I moved on to the testing out
how these UIDs actually helped.

  * [x] `mixed-isFraud.png`

## Model

I started off with Random Forests, but didn't get far with it. XGB
Catboost and LGBM seem to be preferred decision trees models in the ML
community. So I choose XGB and stuck with it till the end to see what
are the best results I can get with it.

I used the default values and that was just good enough. 

My classifier was made of: 

``` python
    clf = xgb.XGBClassifier(n_estimators=2000, 
                        max_depth=8, 
                        learning_rate= 0.05,
                        subsample= 0.6,
                        colsample_bytree= 0.4, 
                        random_state = r.randint(0,9999),
                        use_label_encoder=False,
                        tree_method='gpu_hist')

```

As I wanted to get the max score possible, I used `random_state =
r.randint(0,9999)`, as this would not keep the random_state
constant. Simulations in this manner produced variation in the order
of `+-0.002` AUC score in some cases. So when it is unclear if a
hypothesis works or not, I run the same simulation a few times and
take its average.

Ensembling is also an option but I haven't tried it in this
competition. Based on the top solutions they seem to improve the score
too.

## Feature engineering

1. Fillna
   
   `df.fillna(-9999,inplace=True)`
   
   XGB is capable of handling NaNs. It places the NaN rows in one of
   the splits at each node, (based on which gives a better impurity
   score). However if we choose a number to represent NaNs then it
   treats the NaNs like just another value/category. And it is a bit
   faster, due to lesser computations.
   
   However `fillna` boosts the score by `0.0002`.

2. Label Encoding of Categorical data

	This is done to reduce the ram usage. A string in python uses
    almost [twice as much memory](https://stackoverflow.com/q/58041687/5986651) as an integer. This is done
    using:
	
	`df.factorize()`
	
	
3. One hot encoding the NaN structure for certain columns.

	`D2` has 50% NaNs and is highly correlated (`0.98`) with `D1`. In
    this case `D2` is removed and the NaN structure is alone kept.
	
	`D9` columns represents the time of transaction in a day. But it
    contains 86% NaN values. So a new `D9` (`HrOfDay`) column was
    created from `TransactionDT` using ` df["Hr"] =
    df["TransactionDT"]/(60*60)%24//1/24`. And the nan structure is
    One Hot Encoded.

4. Splitting

	There are many categorical columns, that would allow for better
    models when split. For example, we have "TransactionAmt", which
    allows for the split: "dollars" and "cents". `cents` could be a
    proxy for identifying if the transaction is from another country
    than US. Possibly there could be a pattern on how frauds happen
    with "cents". The "split" is done using the following function:
	
	``` python
	def split_cols(df, col):
    df['cents'] = df[col].mod(1)
    df[col] = df[col].floordiv(1)
	```
	  * [x] `cents.png`

	Another example is `id_31`. It has values such as `chrome 65.0`,
    `chrome 66.0 for android`. Browser with version. To aid the model
    we would split the version number and browser using the following
    commands:
	
	``` python
	lst_to_rep = [r"^.*chrome.*$",r"^.*aol.*$",r"^.*[Ff]irefox.*$",r"^.*google.*$",r"^.*ie.*$",r"^.*safari.*$",r"^.*opera.*$",r"^.*[Ss]amsung.*$",r"^.*edge.*$",r"^.*[Aa]ndroid.*$"]

lst_val = ["chrome","aol","firefox","google","ie","safari","opera","samsung","edge","chrome"]
df["id_31_browser"].replace(to_replace=lst_to_rep, value=lst_val, regex=True,inplace=True);
	```
	
	  * [x] `id_41.png`
	
The same has been done for several other columns and kept if it
resulted in an increase in score.	
	
5. Combining

	Combining values such as `card1` and `addr1`. By themselves they
    might not mean much, but together they could correlate to
    something meaningful. One such combination is the UID.

6. Frequency encoding

	The frequency of the values of a column turns out to be important
    to detect if a transaction is fraud or not.
	
	``` python
	def encode_CB2(df1,uid):
		newcol = "_".join(uid)
		## make combined column
		df1[newcol] = df1[uid].astype(str).apply(lambda x: '_'.join(x), axis=1)
	```
	Added several features based on this.

7. Aggregation (transforms) while imputing NaNs

	This is one of the most important parts of the solution which
    boosted the score all the way into top 10% from top 30%.  Why
    Aggregations work is explained [here](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111453). The aggregation is done
    after combining the train and test dataframes.
	
	`df_all.groupby(uid,dropna=False)["TransactionAmt"].transform("mean").reset_index(drop=True)`
	
	It is very important to add `dropna=False`, as there are many NaN
    rows which would be dropped otherwise. 
	
	`fillna` is not done yet. This way, Nan's in the aggregated column
    get imputed.

	Finding the columns to be aggregated was possible using just the
    AV feature importance seen above and a bit of logic.

9. Removing redundant columns based on FI

	As far as I have seen, removing redundant columns makes the model
    faster and rarely improves the score. Having said that I tried to
    remove columns that seemed redundant but got the score reduced by
    0.002, which is a LOT in this competition. So I kept all those
    variables. However removing redundant `V` columns (200 of them)
    gives a large decrease in time of computation. So those ones are
    only removed.

10. Removing time columns such as `TransactionDT` and `TransactionID`

  * [x] `TransactionID.png`


**What worked and by how much**

| Method           | Public LB |         | Private LB |         | Percentile |
|------------------|-----------|---------|------------|---------|------------|
| baseline         | 0.9384    |         | 0.9096     |         | Top 80%    |
| remove 200 `V`   | 0.9377    | -0.003  | 0.9107     | +0.001  |            |
| remove time cols | 0.9374    | -0.0003 | 0.9109     | +0.0002 |            |
| Transform `D`    | 0.9429    | +0.0055 | 0.9117     | +0.0008 | top 50%    |
| Combine and FE   | 0.9471    | +0.0042 | 0.9146     | +0.0029 | top 30%    |
| Agg on uid1      | 0.9513    | +0.0042 | 0.9203     | +0.0057 | top 20%    |
| additional agg   | 0.9535    | +0.0022 | 0.9220     | +0.0017 | top 10%    |
| fillna           | 0.9537    | +0.0002 | 0.9223     | +0.0003 | top 10%    |

## PostProc

Tried averaging the "identified-client's" probabilities for
`isFraud==1` resulted in a poorer score by upto `0.003`. So didn't end
up using it.

## Local Validation and Prediction Strategy

Initially I started with a 50k sample dataset and looked at a hold
out. Tried different experiments to see what features
work. Considering that it took 7 mins per simulation for the entire
dataset, I went on to use the entire dataset instead of just the
sample.

I tried a couple of strategies here and compared to test solution:

1. Holdout and predict average of 5 models
2. 5Fold CV unshuffled.
3. Group 5fold CV based on Month

The following are the results:


|                     | Local    | Public LB | Private LB |
|---------------------|----------|-----------|------------|
| 5Fold CV unshuffled | baseline | baseline  | baseline   |
| Holdout (5x)        | -0.01    | -0.013    | -0.016     |
| Month 5fold CV      | +0.0022  | -0.0006   | +0.0000    |


The Holdout method seems obviously not good. `Month 5fold CV` did not
produce significant increases (>0.002) in LB so I skip it. All are
compared to the baseline values (`5fold CV unshuffled`).


**Note** As this is a time series simulation people had warned about
not using CV: [here](https://www.kaggle.com/c/ieee-fraud-detection/discussion/99993#577626), and [here](https://www.kaggle.com/c/ieee-fraud-detection/discussion/99993#576742). However the best results,
including that of the 1st solution for this competition were only
possible due to CV.

## Memory reduction

1. Label encoding of categorical variables
  
2. Converting variables to float32 should be [good enough](https://stackoverflow.com/a/64069641/5986651).

	16bit: 0.1235
	32bit: 0.12345679
	64bit: 0.12345678912121212

	With the AUC numbers, 8 digits beyond the decimal seems good enough.
	
3. Removing 200 V columns out of the 439 columns with little change in score.

## Preventing overfitting

There are usually two reasons why the Trained model gives poor results
with the Test data.

1. Overfitting

2. Out of Domain Data 

	i.e., test and train data are from different times, or different
    clients

There is a nice trick to see what is causing the difference in scores
between the training and the test data: Determining OOF (out-of-fold)
scores.

OOF (out-of-fold) scores < Train scores ==> **Overfitting**

Test scores < OOF scores ==> **Out-of-domain data**

For example, from the beginning I have suffered mainly with
overfitting rather than out-of-domain data.

|              | train | OOF    | test (public) |
|--------------|-------|--------|---------------|
| baseline AUC | 0.99  | 0.9292 | 0.9384        |

**Preventing overfitting**

What appears to reduce overfitting are

1. removal of time and client columns such as `TransactionID` and
   `TransactionDT`, Created UIDs.

2. Other Feature Engineering methods such as Frequency Encoding,
   combining columns, and most important of all Aggregations.

3. Choosing the right parameters for the XGB model.

In this case the default parameters were already good enough.

## What can your AV do for you?

Adverserial Validation is a simple technique that helps distinguish
difference in data in the train and the test. It involves the
following steps:

1. Concat the train and the test data set. 
2. Append a new column "is_test"
3. Split data into training and validation
4. train model and get AUC score on `istest==1` (not shown below).


```python
    df_dom = pd.concat([xs, test_xs]).reset_index(drop=True)
    df_dom["is_test"] = pd.DataFrame([0]*len(xs) + [1]*len(test_xs))
	idxT,idxV = train_test_split(np.arange(len(df_dom)),test_size=0.2)
```

**What does it mean if AV `AUC==1`?**

AUC=1 implies that the test and train are very different, i.e., there
is out of domain data. But is this a problem? It depends. The
explanation is as follows.

  * [x] print picture `av-overfitting.png`

In the image above, the circles denote training data. The blue line
denotes the line fit. Red line denotes an overfit line. Different
colored stars denote different types of test data. 

There are three marked regions where `AUC==1`. (I have identified
these using this [kaggle kernel](https://www.kaggle.com/thejravichandran/adverserial-validation-where-auc-1))

a. In this region the training seems to predict some of the "out of
domain" data with "small" error, despite `AUC==1`.

b. In this region the actual Y values corresponding to the data are
small and hence wont have a "significant" impact on the final score.

c. This is where we will have our biggest errors as the data is out of
bounds while thee prediction will most likely not capture the
variation in the test data.

**I had AV `AUC>0.9` for most of the competition**

From the beginning to the end for all cases I have >0.9 AUC, but ended
up with very good results (0.953-->top 10%). Also the OOF score (from
training) was less than the TEST score informing that the OUT-OF-DOMAIN
data was not the problem for the score.

**How AV is used in this kaggle competition**

1. Identify and Remove time columns like "TransactionID" and
   "TransactionDT"
   
   When AV is first run on this dataset, two columns standout:
   TransactionDT and TransactionID. One is the time info in seconds
   and the other is the id of each transaction. Ideally we don't want
   to be using such time columns, as we would like to predict without
   the influence of time. We don't want the model to learn anything
   specific to the Date or the ID of transactions. AV provides a
   platform to identify such variables and eventually we can get rid
   of them.

2. Removing very different columns for negligible score loss.

	In one of the iterations I had 203 columns with an lb score of
	`0.953`. Removing 20 of the most important AV columns resulted in
	a small decrease in score `0.9511`. This is one of the things I
	always try to see how the "out of domain" data affects our result.

3. AV helps find aggregations that we need

	This is and will be the greatest reason for doing AV. AV is so
	powerful that improving my score from top 80% to a top 10% score
	was done purely by looking at the important AV columns. 

	I pretty much used the first 10-20 important AV columns (and a few
	columns on my own) to determine which columns to choose as UID and
	which to aggregate over.

4. Find mistakes with your AV

	I applied aggregation to the train and accidentally did not apply
	it to the test. This was prompty visible in the AV as the
	aggregated columns showed up first in the "AV important
	columns". A quick look at the top AV important columns and I found
	my error.

	For example, in one of the experiments I got the following:

	|     | train  | OOF    | test (public) |
	|-----|--------|--------|---------------|
	| AUC | 0.9971 | 0.9426 | 0.9043        |


	From this it is possible to infer that there is both overfitting
	(train>>OOF) and Out of Domain issue (OOF>>test). Using AV, I was
	able to find out which columns were giving me the problem. When I
	probed in deeper into the columns, it turned out that I had
	accidentally added NaN's to the test data.

	Once I corrected for it, I ended up with:

	|     | train | OOF    | test (public) |
	|-----|-------|--------|---------------|
	| AUC | 0.998 | 0.9474 | 0.9530        |

## References

1. [Data description](https://www.kaggle.com/c/ieee-fraud-detection/discussion/101203)
1. [Plots and much more for many features](https://www.kaggle.com/alijs1/ieee-transaction-columns-reference)
1. [Top Solution ](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111284), [top solution model](https://www.kaggle.com/cdeotte/xgb-fraud-with-magic-0-9600/notebook#The-Magic-Feature---UID)
1. [How the Magic UID solution Works](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111453)
1. [Other ideas to find UIDs](https://www.kaggle.com/c/ieee-fraud-detection/discussion/111320)
1. [Notes on Feature Engineering](https://www.kaggle.com/c/ieee-fraud-detection/discussion/108575)
1. [Lessons learnt from Top solution](https://www.kaggle.com/c/ieee-fraud-detection/discussion/107697)
1. [Other nice EDAs](https://www.kaggle.com/nroman/eda-for-cis-fraud-detection#ProductCD), and [here](https://www.kaggle.com/jesucristo/fraud-complete-eda#Memory-reduction)
1. 17th place solution
1. [How to investigate D features](https://www.kaggle.com/akasyanama13/eda-what-s-behind-d-features)
1. [Don't use Time features](https://www.kaggle.com/c/ieee-fraud-detection/discussion/99993#576742)


## planning


  * [x] introduction until UID
  
  * [x] UID EDA
  
  * [x] What can your AV do for you?
  
  * [x] Validation Strategy
  
  * [x] Feature engineering
  
  * [x] preventing overfirring
  
  * [x] rest
  
  

1. Finish AV
2. reqrite

3. post on kaggle first
4. post on personal site.


1. plot off private and public 
2. add details of columns for understanding
## planning 2

clean up the posts this post and the previosu version

clean up v16

figure out how to imrpove score on own and update posts.

write up image recognition

write a small brief ppt...
