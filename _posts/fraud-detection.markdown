firtst let me setup up with chroms pages and where they need to be...


then the goal for today is do adv and see what the results are like.

perhaps try gscv on the other side and find the right parameters.


Ultimately waht we want is a quick way to test. i.e., start to
validation with shit inbetween.

then we want an easy way to scale it. I think this is not a problem. 


Do we have the dater? yes... 

the other I wanted to see was what would be the effect of 

We want to test the effect of AV on xgboost.

**Need one file which can do start to predictaawrds....**

**Claim**: Removing variables with by doing AV improves baseline

7**Example-sub**: 

|              | 50k   | allk |
|--------------|-------|------|
| baseline     | .8906 |      |
| non-baseline | .8898 |      |


???

**Definition**: 

**Checklist**: sub; Yes; pre; Yes; ecm; Yes;

**Time**: 


**Followup**: see what he CD has done.


**how did they do with single kaggle kernel?** how?????? did they
optimize their shit with it? tomo


**What is oof score?** cv score based on group training.

**Why has he used skf?**clearn he is using group cv

**come up with answer for above?**

1. start with claim above. GENERATE BASELINE...

how many vars do I have after categorify?????

**See how to handle memory**

Most imbartent


**Claim**: You don't get the same results when you repeat calcs


**Observations1 local validation**

1. Repeating xgb doens't change result.
2. Restarting kernel doesn't change result. 
3. But changing seed changes value drastically.
4. Seed of AV also has an impact.


**Observations on CV**

1. CD's method of using oof for prediction is very neat. Let's do
   that. Here the oof score is similar to out oob score. which is
   nice. And we don't really generate a valid score. We can also
   predict in the same way using preds. The validation takes 45s.
   
2. Tried `cross_validate` but that doesn't output the verbose xbg
   output. Also I think it takes longer than regular solve. 30-40s for 1
   cv iteration is not acceptable as it takes 5 s for one xgb solve.
   
   Just doing CV and averaging the scores does not do oof style
   prediction. Let's roll with CD's way for now.
   
3. using xgb's cv means to use it's own api on that. 



**Consitency of valid result**

Different seeds give different results. When you don't specify a seed
the same seed is chosen in the case of xgboost. Maybe I should try
``random.int` and see how value varies over 3 times....

**Changing seed**

Changed seed 4 times with the latest cv out, and got the following
answers:

8857,8912,8858,8885, (within 0.006 max-min) with avg being: 8878... So I think we need to
take this value... For validation considering that there are such
small changes looking at average makes feels better than just saying
something works or not based on one fucking value.

for now just run it 5 times.

Getting much better "repro" 

9927,8903
9963,8914
9921,8884
9916,8895

Within 0.002 max-min... If better is needed need to go for more reps.

**Next**

go into EDR! Start with his eda again... see other edas if possible...
setup a test thing so we can use it in Google cloud?


What happens when you run nthread =4 and gpu??? try with 50k daterset

## EDA ids

1. heatmap to see correlation

Only one side of the ting is relevant.  Group them by ones that are
\>0.75 and choose only one of them, and test it...

1. Look at nan pattern, nan counts

2. PCA to reduce columns such as V columns, and then test

3. looking at wrong predictions and seeing what columns are part of
   it, 
   Seeing right predictions and seeing what columns are part of it.

what about FI? 

What about other things?


Look at each column... Get number of unique values, dtype, number of
nans, top 10 correlations.

### Removing correlation columns... 

It looks like the result reduces or barely increases but we do it as
it results in barely any high increase in solution with reduction in
dimensionality, i.e., faster speeds, lesser ram.... I think that is
the point of correlation.


**always check what is the contribution of removing things from your
correlation**. Perhaps group them and this reduces dimension.


  * [x] plot correlations
  * [x] How does corr handle nans it doesn't
  * [x] Generate nan groups see also nans representation... in it...
  * [x] plot corr and hist per group (automate for all?)
  * [x] select v columns
  * [x] Test on the dataset

**observation:** OOF 50k compares to private dataset output

1. Removed V columns based on NaN and then on unq values by 0.0013
   from baseline
2. Removed all V columns baseline reduces by 0.002 from baseline
   (private ds)
3. Removed further columns as above reduces by from 50k baseline by
   0.008... Not advisible to keep reducing the outcome. 
   
Sticking to just keeping 120 v columns. ok.

-- first set dtype based on 

### Column selection based on nan > % 
```
cols_lna= xs.columns[(xs.isna().sum()<0.25*len(xs)).to_list()]
cols = cols_lna
cols_lna
```

### look at eda and see whats happening for other 94 cols?

### Doing AV and removing transaction id and transactionDT

1. Split AV sheet, xgb sheet and EDA sheet.
2. Look at the AV and try to understand whats happening with the
   columns...
3. Look at other solutions and CD's solution again...

### plan to do aggregation, freq encoding

### determin the UID ideas

### making other features from D1 to Dn what are those features??

## Thinking


I am confused about what to do... 

There are three things,,, Which rows to group (so find UIDs), which
columns should participate in that aggregation? And What aggregation
to use, std or mean?. This is one part of the problem....

To find UIDs AV is suggested as the prefered method and from there you
try various versions to find which UID set predicts all as
isfraud=0/1. This gives you the UIDs.

Problem 1: My AV is in xgb and looks nothing like his...

- Maybe start with getting FI for regular solution
- look at aggregating card address adn domain to determine Userid

Problem 2: How to decide if I need to mod D1 etc...

I can do this... Learn meanings of these columns

Problem 3: How to use AV?

Problem4: Based on what to generate means and std's.... 

Problem5: engineer other columns such as cents and dollars

- consider other features for feature encodeing.

## Which validation strategy seems to predict the final scores
increase?

1. LV with 5 times has lesser variance than kfold for 50k scene [KFOLD
   METHOD GIVES BEST RESULTS]
2. LV in 50k scene seems to predict the decrease that happens in the
   500k scene results.

3. I might need to check 50k DS... and what it is outputting.... as it
   is not "representative"??? YES IT IS,

## After a few days we go to aggregation

## Dater needed

1. df, df 50k, df te, df te 50k, df dom, df dom 50k;

2. Categorified df denoted by C... 

and xs's and y's NO `to's` to be saved.

1. LE stuff (so that the nans are quickly detectable)

Look at dates


**focus on understanding d columns and transaction amount.**

## Splitting (serious waste of time)

Take each columns... I need encoded df and regular df...

with encoded DF I look at plots and with regular df the labels. Look
at the plot and see if there is something useful in the plots.

1. Splitting Cents improves 0.001/0.002 (pub/ private)

2. card3 seems different. Fraud is located at particular locations in
   large amounts....
   
3. split email domains, check how to add more info to Device info, id 30,31

4. check correlation once for the 94 cols. and see where they are
   highly corr'ed.

5. make hr, week type


make hr and week 


### Observations

1. 0.002 error with repeat for 50k
2. 0.0005 error with repeat for all and kfold.

Made new columsn id_brow but were highly correlated, didn't produce
increase but decrease of 0.0001... :(

If made items are highly correlated and have very similar nans then
don't bother adding that feature.

**Moral:** Adding new highly correlated columns (0.95) seems to
confuse the model. when I added both id_31 and id_31_browser, the
model auc dropped by 0.002 compared to when I had one of the columns
the auc only varied by 0.0001. Basically there could sitll be changes
with succeccive LV's. But nevertheless it is not promising or the
change is small (+-0.002) I doubt it gets better.

**Private Varies** Also noted that despite LV increasing over
different iterations the max min value is varying by 0.002 (.9109,
0.9093, 0.9083).


### Testing (done)

1. Get baseline without all the additional columns...

2. contribution of r_emaildomain and not... vs `r_email domain` on 50k
   dset
   
3. contribution of P_emaildomain

4. id_31 vs browser

### todo

Id30, ID31, Device type, device info, browser, windows stuff, need to
do some work on it.

Also grouping cols like cards and then using it to group and make new
feature. card1,2,3,4 gives increase in output value... apprently.

1. Change NA to -9999 in all cols
or OHE D1 to D9 in addition to that and make 0...

2. REmove D2 and add D1 + D2 OHE

3. Remove D9 and substitute with Hr + D9_ohe

4. Keep D6 D4 and remove d12 as it has more nans and less unq values

5. plot with is fraud to detect more disturbances

~~Add transaction hr and add days from previous transaction...~~

Check whats the deal with D1n and why it is done...

frequency of transactions over a given time.

### UID

Do av find important feature... Identify different clients using
AV... make aggregations...

Select column combinations that allow identification of "clients". How
to test this?

  * [ ] Select different UIDs
  * [ ] Number of UIDs in test already seen?
  * [ ] see other data for selected uid
  * [ ] aggregate based on them, remove them and run few versions to
        test
  * [ ] move on to other things
  
  
For UID there are certain checks, 

1. isFraud

2. D1n should be jhon constantine

D1 is the number of days elapsed since the first transaction of a card.

1. user account, email address or billing address

The logic of our labeling is define reported chargeback on the card as
fraud transaction (isFraud=1) and transactions posterior to it with
either user account, email address or billing address directly linked
to these attributes as fraud too.


1. Going to pick certain UID's based on lesser nans and measure it
against D1n, D3n and isfraud splitting of olumnes

2. Set up aggregation for mean atleast

	- Test only AV colaths
	- test M and C colaths
	
3. check number of clients in test and train (same vs new clients)
	
	
4. Set up av with v colaths only

5. impute nan with constant number for addr1 and d1n and see where
   that takes us
   
6. post process choose all uids in test and avg results.

## D colath, C colath, 94 colaths correlation


- D olaths
- C colaths
- 94 colath corr
- 


## D colath

No idea whats in it... Want to find out what each column
means. Starting with the eda on it...

D9 is hour.

Could check what happens when I add Dwkday

D1 D2 heavy corr

D12 D4 heavy corr D6

D7 D5 heavy corr


**TEsts** 

38v10 and then 12v16
1. check corr and remove along with nans... Do that here.

2. Add hr and week

3. look at d1n and see how to go about it.

Impute nans with -999 and without -999 and see what gives better result...

## questions to call team

1. what service do you use? had issues with datacrunch and it quickly
   gets pricy... 10 euros per day.

2. validation score ( do you average it, run it more than once... seed
   matters...)

## aggregation

Starting with C and d4n and hr of day... Let's see where that gets
me...

then add all sorts of other aggregations...

  * [ ] int vars
  * [ ] Selection of vars
  * [ ] also change nans of uid so that they work
  * [ ] Maybe remove corr items?
  * [ ] check difference between the different cv's
  * [ ] postprocessing of all clients to same value
  
## difference in test vs cv

  * [ ] remove corr columns 
  * [x] remove AV columns (But CD has those exact AV columns)
  * [x] Removed 6,7,2 daynum (result exctly the same as before...)
  * [x] Remove C3 from the rest (NO CHANGE expected)
  * [ ] Remove D extra columns?
  * [ ] Change deptha dn LR?
  * [ ] adding nans while selecting (encoding nans in uid)
  trying this now?
  * [ ] Run simple LV instead?
  
  * [x] remove aggregations
	Already D1n columns are giving me a boost to 94.3 in lb from 92.6
	in lb before adding them.
	
    * [x] Add freq encoder ( no improvement)

	* [x] Add numunique encoder ( no improvement)
	
	
   * [x] **add post proc**
 
   * [x] check how to overcome timeseries

  * [x] month grouping ( No changes in the order of 0.002. public
        reduced in this iteration)

  * [x] Repro him first (sucks) 
	  - missing time consistancy and D coalaths removal
  - [x] Repro first including time consistance and D coalaths
		trying (mine is somehow not same as his. He gets 0.95 as described.)
  - [x] Are there categories? is that the issue?
  - [x] Compare na columns between yours and his (how much na is there
        in each...)
  - [x] Maybe it is the V and id colaths
  
  - Maybe it's my aggretions which are wrong.. Try my aggs on his
  
  - Compare nans and columns structure after doing FE, etc... Maybe
  there is some error there.
  
plot resulting columns on a time scale
  
  Why are certain aggregations out of domain dater?
  C1-15 mean and std (better than mean), and also hrofday and d4n
  What are the units of all the columns?
  
  
add everything and then figure out how to do this...

### TEsts

- add post proc
- See if month adding is necessary
- Recreate CD solution and comment it.
- Rev engineer CD's solution
- How to reduce AUC? Does that help?
- Remove V and id colaths
- aggregate auc based variables.
- Should I fillna or not?
- two types ( reducing columns 1 skill, increasing important coalaths)
- check combine solution (if ok or not)

1. Reproduce magic solution.

2. Add post proc?

3. Reverse engineer CD's solution

4. Check your AV and see if those agg add to the magic?

5. Should we reduce AV AUC? Is that necessary?

5. Write blog post? plan...
   - how to solve?
   - Seeing errors from AV about overfitting and OOD.

6. Lessons learnt...
   - XGB sensitivity to fillna, having corr colaths, post proc
   - hwat increased the score and by how much...
   - 

### issues

1. fillna of uid done after FE? Doesn't look like it.
2. nan in AV colaths test why? Nope
3. nunique possible causing issues? Nope
4. why 50k has nans? Investigating... Done... Not it.
5. df vs xs
6. Try CD's functions and use them to encode and see if you are able
   to make the numbers.... Trying...
7. Missing postproc?
8. fillna missing everywhere?
9. DT_M
   


### diff bet CD and min

- Pre LE, I do prior.
- diff way of aggregation (test by using your agg on his sheet)
- diff V colaths
- way of categorification
My results go to shit as soon as I aggregate or as soon as I FE.
- nan in other cats
- nan while aggregating?
- float64 in mins vs float 32 in his
- np.rand in clf

We both have identical colaths. but some

### Where are the differences?

1. what I see is that FE nans are replaced by somenumber... That is ok, I
think...

2. 

one col FE Matches except the NAN count

two col FE 100% matches

three col FE Matches 100%???

one col UID groupism small difference due to use of -1 as
np.nan. Where D11n actually has -1 values in addition to np.nans


### tomorroow changes

1. DT_M what will happen

2. V coalaths, mine vs CD?

3. Using own AV to determine the agg colaths

4. Reducing AUC by removing variables... 

5. how to choose variables and their uids... 

6. is it possible to choose better UIDs? where isfraud and otherfraud
   is split 100%?
   
7. What is my contribution? 


	1. D9 to Hr
	2. all av colaths but add FE mean and STD and remove them?
	3. add cols
	4. add then V, try some variations on it
	5. remove AV cols for final value
	6. cehck Post
	7. That is my final stuff


## final solution


V + col c and M + lr rate 0.02 and 12 + v agg + remove v colaths?

## Kernels

[D9 is hour of the day](https://www.kaggle.com/c/ieee-fraud-detection/discussion/100400)

[94 col EDA](https://www.kaggle.com/alijs1/ieee-transaction-columns-reference/notebook)

[Labels and meanings](https://www.kaggle.com/c/ieee-fraud-detection/discussion/101203)

[How everything goes together](https://www.kaggle.com/c/ieee-fraud-detection/discussion/107697) by Konstantin (rank 1)

[What's behind D features](https://www.kaggle.com/akasyanama13/eda-what-s-behind-d-features)

[Comment about how to choose the aggregations main column and UID](https://www.kaggle.com/cdeotte/xgb-fraud-with-magic-0-9600/notebook#645369)
by CD

> Great question RunningZ. Here is my thought process:
>
> (1) First I evaluate every feature in public kernels. Konstantin had aggreagations, Roman had aggreagations, and two others had aggregations. This only takes a few minutes. You cut and paste the code into your model. Next you do forward feature selection with blocks. I do not add one feature at a time because sometimes the increase is too small to notice. I see how the aggregations can be logically grouped in blocks. So if someone aggregates 5 D columns over uid, then I add all 5 of those features at once and see if AUC increases. Next they aggregate 5 C columns and C columns are similar to I add these 5 at once.
>
> After evaluating all public aggregations (about 100 features), the only few that helped my model were TransactionAmt and D9 over uid with std and mean. (Note the reason so many public aggregations didn't work is because nobody had the magic uid yet. But TransactionAmt and D9 were so good they worked on simple uid like card1 + addr1).
>
> (2) Next if you read my post here, that's how I learned about the importance of D4, D10, D15, C13, C14, V127, V136, V307, V309, V314, V320. Even before I performed adversarial validation, I already started noticing how this columns were important for identifying credit cards and was experimenting with aggregating them over uid.
>
> (3) I added P_emaildomain, dist1, DT_M, id_02, cents by thinking about it. Note that these five use function AG2 this aggregates nunique over uid. I said to myself if a credit card has many email addresses, that is suspicious. If a credit card ships stuff to many locations dist1, that is suspicious. If a credit card makes many purchases each month or few purchases each month, that means something DT_M. And I choose id_02 because it is a floating point number with 115,000 unique values. So the purpose of id_02 is to count how many rows of identity information a credit card has. I could have created a has_identity? boolean and summed it instead. Using cents is a proxy for checking whether a credit card makes the same purchases over and over.
>
> (4) Lastly I removed C3 from aggregation because it failed time consistency.
>
> (5) In conclusion, you basically aggregate all important numeric features over uid with mean and std and aggregate all important categorical features over uid with nunique. I basically aggregated all the base 53 columns, TransactionAmt, dist, email, C, D, M. (I don't have the D's with lots of NAN, and I don't have card1-6, addr1-2, D1-2 because they created uid). Then I was more careful with V and ID because they weren't very important to begin with and there were too many of them. (You can nearly score LB 0.96 without any V nor ID so we don't want to add all this worthless stuff as aggregations and add 400 mean plus 400 std new features).


### todo

  * [ ] write 1 posts (cross post in home webpage)
  * [ ] clean up v16 kaggle sheet
  
  * [ ] Upload to github and wrap up
  
  * [ ] Clean up the two dacuments in personal blog or atleast
        deprecate it.
  
  * [ ] Write one post for computer vision as well
  
  * [ ] finish computer vision with one last step
	
