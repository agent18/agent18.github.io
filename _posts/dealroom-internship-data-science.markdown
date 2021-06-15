## final output

- 1 pg description file that summarises the logic and code used for
  the assignment.
- will be graded based on code and thought process
- instructions in readme to run the code

Good luck and send us an email if you have any questions at
pierre@dealroom.co.


## Assignment 1

Exercise 1: G2 Scraper

In the attachments you will find a file called
“data_scientist_intern_g2_scraper.csv”, which contains 1,350
companies. Each company has an id, name, website, short description,
address and industry.

Your task is to build a scraper for https://www.g2.com/ (G2 is a
website providing product reviews). Your script should look up the
companies from the file and return the corresponding product
information for each company.

The scraper should get the ~~product URL~~
(e.g. https://www.g2.com/products/trello/reviews), ~~website~~, rating,
number of reviews, description, product and seller details,
alternatives (optional) and pricing (also optional). You can save the
scraped data to the initial companies file and send it to us together
with the script you’ve built to scrape the data.

If you get blocked by G2, it’s ok, just share the results you
scraped. The point is the code and the logic.

## readme

## 1 page description

**Goal**

Scrape information from product websites from G2.

**Method and pseudo code**

1. Get search results
   1. Initial cleaning of name (to make it searchable)
   2. Open Search results directly using company name (`cname`)
   `driver.get("https://www.g2.com/search?utf8=%E2%9C%93&query="+cname)`
2. Scrape upto first 20 results and find which is the "right company"
   1. Get g2-website for each of the results
   2. Search the g2-website to get company website
   3. Check if the company website matches the website from the CSV
   4. Thus identify the "right company"
   5. When there is no company or no match step 3 is skipped.
3. Extract details in `try` `except` statements **including pricing and
   alternatives** when available.
   1. For alternatives the site of alternatives is extracted from which
      all 20 of the alternatives are taken.
4. Save to pandas and eventually to CSV.

**Types of Cases to test to ensure robustness of script**

1. Search gives no results
2. Search gives results but no company website matches CSV data
3. Search gives many results and the top one matches
4. Search gives many results and one them matches
5. Additional cases where g2-website structure is different.

**Method: scraping**

- `Urllib` did not even allow me to access the website, despite
  changing the `user-agent`. Worked on other websites but not on G2.

- Using `Selenium` to navigate G2 resulted in `CAPTCHA` for every
  single page. This CAPTCHA seemed so hard that I was unable to
  solve it even with human intervention.
  
- What seems to work is *opening and closing websites directly without interacting
  with their hyperlinks*.

- Used `Selenium` as the single tool for web navigation and
  scraping along with `fake_useragent`. 
  


**Avoiding captcha and other prevention measures**

1. I was able to access websites using Selenium, but only the
  navigation was the issue.
  
  - So in order to search through the website, I directly searched

	    url = "https://www.g2.com/search?utf8=%E2%9C%93&query="+cname
		driver = open_website(url)
  - Every time I just closed and opened a new website directly and this way I
	didn't get blocked at all. No clicking on hyperlinks or search bars.
	
2. I added random times `>5s` to overcome the "DDOS Protection by
CloudFare".

**Issues**

- Slow processing (>5s only to open a file) mainly due to avoiding
  "DDOS Protection"
- Sometimes not all values are scraped as "try excepts" are not made
for every single output extracted, but for a group of outputs (but this could be done).

- There is variation in g2-product-websites accessed. Current script
is able to handle many variations but not all. Program will continue
but we might be missing some data. (Example, Company Alan gives no
additional data as the site Xpath is considerable different.)

**Salient features**
- Able to extract alternatives and pricing when available
- Exceptions handled to keep the script going on.

<div class="fw-semibold c-midnight-100 word-break-word">Woliba</div>
**Verbose Print output for checking**

``` python
---------------------------------------------
Forecast is being searched
title is G2 Search: Forecast
Number of search results are 20
['https://www.g2.com/products/forecast-forecast/reviews', 'https://www.g2.com/products/forecast/reviews', 'https://www.g2.com/products/amazon-forecast/reviews', 'https://www.g2.com/products/forecast-pro/reviews', 'https://www.g2.com/products/forecast-5/reviews', 'https://www.g2.com/products/site-forecast/reviews', 'https://www.g2.com/products/forecast-edge/reviews', 'https://www.g2.com/products/sas-forecast-server/reviews', 'https://www.g2.com/products/buyer-s-toolbox-forecast/reviews', 'https://www.g2.com/products/floodmapp-forecast/reviews', 'https://www.g2.com/products/demand-forecast-planning/reviews', 'https://www.g2.com/products/sales-forecast-navigator/reviews', 'https://www.g2.com/products/sas-forecast-analyst-workbench/reviews', 'https://www.g2.com/products/construction-cash-flow-forecast/reviews', 'https://www.g2.com/products/demand-management-forecast-management/reviews', 'https://www.g2.com/products/claplan-forecast-monitor-training-plans-and-needs/reviews', 'https://www.g2.com/products/forecastx-wizard/reviews', 'https://www.g2.com/products/forecastingsoftware-com/reviews', 'https://www.g2.com/products/forecastable/reviews', 'https://www.g2.com/products/dude-solutions-capital-forecasting/reviews']


Looping through the different search results
title is Forecast Reviews 2021: Details, Pricing, & Features | G2
found match with company website from CSV @ 0 index
getting details for Forecast
showing more


id                                                            975908
NAME                                                        Forecast
WEBSITE                                     https://www.forecast.app
TAGLINE            AI-powered resource & project management platform
ADDRESS              20, Frederiksborggade, 1360 Copenhagen, Denmark
INDUSTRIES                                       enterprise software
TYPE                                                             NaN
current_url        https://www.g2.com/products/forecast-forecast/...
website                             https://www.forecast.app/product
rating                                                           4.3
n_reviews                                                 48 reviews
desc               Forecast is a full-suite platform for improvin...
prod_det           All-in-one Project and Portfolio Management So...
language                  Languages SupportedDanish, English, French
seller_who                                            SellerForecast
seller_location                       HQ LocationCopenhagen, Denmark
seller_year                                         Year Founded2016
pricing_lite                                       $29per seat/month
pricing_pro                                        $29per seat/month
alternatives       ForecastVSmonday.com-ForecastVSAvaza-ForecastV...
Name: 4, dtype: object
```

## todo

- pandas export
- run over night

## algo v3

- Get csv into pandas

- outer loop through everything
  - get website with options (open website)
  - scrape the options (extract g2 sites)
  - how many options do we have?
	- 0 options quit and make N/A list
	- >0 options scroll through scrape and detect the right website
		- if not detected then quit and make N/A list
		- pick the detected website and extract itengal

- Keep error handling in mind

- put it in pandas, regex clean it. 

- testing 1 test with 8,10,0,4 as n

- testing 2 with 10 continuously

### algo 

- Get the csv into pandas

- a function that takes company name

    - search g2
	
	- distinguish (separate fencties)
		- check if no links --> conclude ("Matera (formerly
          illiCopros)" ), --> do nothing
		- check if links --> select one by one and go through until website
		match, else next ("forecast" search 1st link, "envision
		technologies")
			- open sites, and check against website Need to find which is the right site match, 
			- get it's credentials
			- update the corresponding CSV
			- write all in functions
			- loop it
			- test it for atleast 10 items and run in background
			- clean up
			- write 1 page doc
	
	- If match, then extract dater (separate fenctie)
		- and gives URL and rating
		- and then the rest: , website, rating, number of reviews,
		description, product and seller details, alternatives (optional) and
		pricing(optional)

For now print, Later put in list and extract from list.

- update pandas with the additional columns and info.		

- optional alternatives and pricing...
	
### cases for later

1. get no selections: what to do

2. get many selections: what to do 

3. Somehow check if the selection you need is there: what to do ???
	

### unable to use search function because of bullshit capch
requirements which I am not able to ever pass.

## other things to do to bypass this 

g2 question suprisingly.
https://stackoverflow.com/questions/59265355/python-selenium-go-around-detection

https://stackoverflow.com/questions/33225947/can-a-website-detect-when-you-are-using-selenium-with-chromedriver

## write in notes

It was not possible to go inside without capcha and do a search. so I
resorted to restarting a browser with different searches.


## algo

- get company website from g2 site

- compare it after regex with cwebsite

- Write the loop after wards,

	- If correct then go further with that driver, 

	- otherwise ditch the driver


## algo clean website

- remove www and https: or http

## Assign3

Exercise 3: Duplicate detection In
“data_scientist_intern_duplicate_detection.csv” you will find a sample
dataset of Dealroom company data containing some duplicates. Your task
is to **identify the duplicate profiles** based on the information
provided in the file. Please **create a separate file to store the
duplicate profiles** that you identified. In this file you should show
which of the profiles (data rows) are duplicates and which fields they
are duplicated on.

## plan

Assumption: Something is duplicate if the name country and city are
the same.



1. Get df and make copy 

2. Explore the data (check Nan, unique, dtypes and duplicates for applicable
   columns)

3. group by Name Country and City and count them

4. Add column: Join(Name country and City)

5. Filer counts>1 (i.e., duplicates)

6. Make CSV


When is something duplicated

1. When id is the same?
2. When name country and city of the row is the same


3. file with duplicate profiles with columns showing about which id or name

Checked if it needed cleaning the name and the id but they looked
pretty ok to me...

1. file with duplicates profiles (both dupes)
2. mark duplicates in the dup file
3. add on which columns those are duplicate.

4. An item is duplicate if id repeats
5. An item is duplicate if id Name repeats
6. Name partially repeats along with city and country

- have a look at pandas object unique values etc...
- have a look at the csv

## Find the unique ones

id seems to be unique. Let's go from there. Let's say name and tagline
should also be unique... industry, countries can be common.

There are

``` ipython
In [14]: df.nunique()
Out[14]: 
id               15895
name             15126
tagline          14553
industry            27
industry_2          27
type                 9
address           7147
street            3296
street_number      907
zip               3471
country             98
city              3002
sectors           6574
dtype: int64
```

``` ipython
In [16]: df.count()
Out[16]: 
id               15896
name             15896
tagline          14972
industry         11495
industry_2        2591
type             15896
address          15896
street            4286
street_number     2893
zip               7283
country          15896
city             15896
sectors           9810
dtype: int64
```

Find that id that is repeating...
