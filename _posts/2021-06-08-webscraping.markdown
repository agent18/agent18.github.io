---
layout: post
comments: true
title:  "webscraping"
date: 04-06-2021
categories: notes
tags: data
permalink: /:title.html
published: false
---

## Webscraping

Basic webscraping done with urllib and beautiful soup based on
[RealPython](https://realpython.com/python-web-scraping-practical-introduction/#install-beautiful-soup).

``` python
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup

url = "https://www.g2.com/products/shift/reviews"
req = Request(url, headers={'User-Agent': 'Mozilla/5.0'})

page = urlopen(req).read()
#page = urlopen(url)
html = page.decode("utf-8")
soup = BeautifulSoup(html, "html.parser")
```

This gives an error: 

`HTTPError: HTTP Error 403: Forbidden`

not sure what to do... Tried changing the `User-Agent` but doesn't
work in the end. Tried the whole thing with VPN and Kaggle. Other
websites work but this particular website doesn't seem to work.

## Considering selenium

Different [things available](https://www.bestproxyreviews.com/scrapy-vs-selenium-vs-beautifulsoup-for-web-scraping/#:~:text=While%20Scrapy%20is%20the%20tool,a%20better%20web%20scraping%20developer.). Scrapy Bs4 and selenium.

Neik Deitmers uses Selenium to do [webscraping for his dealroom assignment](https://github.com/NickDeitmers/dealroom_assignment/blob/main/dealroom_internship_case.ipynb).

## Selenium tutorials

**docs**:
https://www.selenium.dev/selenium/docs/api/py/index.html#example-0

https://selenium-python.readthedocs.io/navigating.html

**Youtube**

The best tutorials I got from are the docs above and [this guy](https://www.youtube.com/watch?v=U6gbGk5WPws).


### installation

[Here](https://selenium-python.readthedocs.io/installation.html)

1. `conda install -c conda-forge selenium`

2. We need webdriver and google chrome

https://sites.google.com/a/chromium.org/chromedriver/downloads

1. Version 90.0.4430.93 (Official Build) (64-bit); get webdriver for
   your chrome version+

2. Unzip and store it in a seeable location. And that is it you are
   pretty much good to ga.

## Examples of using selenium

**Get title, open a browser and then close it**   

``` python
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
from selenium import webdriver
import time

url = "https://www.g2.com/products/shift/reviews"
url2 = "https:\\techwithtim.net"

path = "../dater/driver/chromedriver"
driver = webdriver.Chrome(path)

driver.get(url2)
print(driver.title)
time.sleep(10)
#driver.close()
print(driver.title)
driver.quit()
```

**Write text, hit enter, scrape certain tags inside certain id**

``` python
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from random import randint

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

url = "https://www.g2.com/products/shift/reviews"
url3 = "https://www.g2.com/"
url2 = "https:\\techwithtim.net"

## Driver setup and access title
path = "../dater/driver/chromedriver"
driver = webdriver.Chrome(path)
driver.get(url2)
time.sleep(randint(5,10))
#driver.close() # to just close the tab
print("title is", driver.title)

## Search 
search = driver.find_element_by_name("s")#"query"
search.send_keys("test")
search.send_keys(Keys.RETURN)

#time.sleep(randint(5,20))

## Extract main from the new page and then headers
try:
    main = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.ID, "main"))
    )
    
    #print(main.text)
    header=[]
    articles = main.find_elements_by_tag_name("article")
    for article in articles:
        header.append(article.find_element_by_tag_name("a").get_attribute("textContent"))#text)
    print(header)
except:
    driver.quit()
```

**Accepting cookies from facebook by xpath**

Xpath is the greatest way to access stuff: 


``` python
## waiting

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from random import randint

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

urlfb = "https://www.facebook.com/"

## Driver setup and access title

path = "../dater/driver/chromedriver"
driver = webdriver.Chrome(path)
driver.get(urlfb)
time.sleep(randint(5,20))
print("title is", driver.title)

## Accept the fucking cookies
element1 = driver.find_element_by_xpath("//button[@title='Alles
accepteren']").click()
## xpath format as `//tag[@anythingintag=value]`
```
**Different ways of finding the same object**

``` python
In [819]: url
Out[819]: 'https://www.g2.com/search?utf8=%E2%9C%93&query=Forecast'
```

``` python

results=[]
try:
    results = WebDriverWait(driver, 10).until(lambda x:
    x.find_elements_by_xpath("//div[@class='paper mb-1']"))
except:
    driver.close()


links = []
if len(results)>0:
    for result in results:
        links.append(result.find_element_by_xpath(
            "//a[@class='link js-log-click'][text()='Reviews']").get_attribute("href"))

links = []
if len(results)>0:
    for result in results:
        links.append(result.find_element_by_tag_name(
            "a").get_attribute("href"))
links=[]
if len(results)>0:
    for result in results:
        links.append(result.find_element_by_link_text(
            "Reviews").get_attribute("href"))
print(links)
```


## html basics

id is guarenteed to be unique.

name not necessarily unique but on a page it might be

class might also be ok, but when we search with selenium we get the
first hit instead...

tags are things like div, h1, article etc...

## Installation of bs4 was done with miniconda and not anaconda

too many conflicts with fucking any other package I wanted in
anaconda. Fuck!




## help to another person who did

I am not sure showing you the solution is the a good idea. Having said
that I will suggest some tips and my experience...

I spent all of 5 days on this task. I had my moments of utter despair, but
don't giveup. I am 100% sure you can do it.

1. Have a basic idea of the things you need to do, i.e., import csv,
   clean, open g2, search something, scrape those results by going
   into the respective html code and looking at tags and then updating
   it back into pandas. Goal is to go to the finish line fast and then
   add as much detail as you want, like scraping all sorts of
   information.
   
2. I used `selenium` in and out. Nothing else worked so well. There is
   a brilliant tutorial that shows how to use selenium [here](https://www.youtube.com/watch?v=Xjv1sY630Uc&list=PLzMcBGfZo4-n40rB1XaJ0ak1bemvlqumQ): I
   spent sharpening my axe here for a while before actually working. I
   literally learnt webscraping here. I couldn't even open the g2 link
   with other methods. Selenium needs some setup, but the instructions
   seemed to be straight forward.
   
3. I populated things into pandas as a way of keeping track of
   things. Printed a lot of things to make sure everything was
   ok. There are many different use cases once you search identify them.

4. I used [this link](https://selenium-python.readthedocs.io/navigating.html) to find how to scrape objects I wanted. Read
   this carefully and it will make your life easy as hell.

5. Use a varying timer to make sure G2 doesn't think of you as a
   bot. A 15 sec random timer when I was opening and doing some
   actions on the website was good enough. 
   
6. In the end I scraped like 150 sites or something by then g2 blocked
   me.

7. Look at your results and improve the code

8. I couldn't use any of the buttons on G2, like search. So I had to
   scrape links and directly open the links. The capcha is
   "impossible" to solve even for a human.
   
9. they are not interested in the perfect answer, cause of the
   timing. They just want to know how you think and if you can handle
   their full time duties.
   
10. You have one week. I would grind day in and day out on this alone
    and the other task I spent about 6-8 hrs or less. I spent most of
    my time on this task.
	
Hope this helps.

**Here are some HTML basics**

- id is guarenteed to be unique.

- name not necessarily unique but on a page it might be

- class might also be ok, but when we search with selenium we get the
first hit instead...

- tags are things like div, h1, article etc...
