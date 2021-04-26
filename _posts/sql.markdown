## SQL where to learn


Here, this 6 months to DSer suggests a [stanford course](https://towardsdatascience.com/how-i-went-from-zero-coding-skills-to-data-scientist-in-6-months-c2207b65f2f3). It looks
like this is the one: [Relational databases and SQL](https://www.edx.org/course/databases-5-sql).

Course length 8-10 hours and 2 weeks == 20 hrs

Each video 10 mins avg. and 19 video types.

## Introduction to Databases


Massive, Persistent, safe, multi-user, convenient (high-level info), Enquiry

People build databases applications using "frameworks" (janko, ruby on
rails)

**Goal:** Storing and operating data through a DBMS.


### Relational model

Relations --> Tables (students, college)
Attributest --> columns (id nma gpa photo)
tuple --> row
type --> dtype
schema --> Students : columns : dtypes
Instance --> contents of such a schema at a given type
key --> ID where everything is unique in the coalath or 2 cols together...

NULL --> unknown or undefined (as always be aware when you are
selecting it and not). (`gpa>3.5` does not get null values)




can have millions or billions of rows

### intro to sql

DDL create table drop table

DML select insert delete update

other commands indexes etc...

### select

Select attributes (coalaths)

From relations (tables)

where conditions (combine filter)

### Types of (relational) Daterbases out there (DBMS)

- SQL server (MS)
- SQLite
- Oracle
- DB2
- MySQL (most popular opensource daterbase)
- BigData
- Postgre SQL


## To get sql work king on your machine YOU NEED?

You need an database engine --> PostgreSQL, SQL Server Mysql etc...

[MySQL most popular opensource daterbase](https://youtu.be/7S_tz1z_5bA?t=147).

1. MySQL community server install

2. Graphical tool to connect to server and manage daterbases (MySQL workbench)


1. Init daterbase (or server)

2. Make connection (start server on workbench)


### To use on pythiath

you need mysql-connector or similar modules.


### installation of mysql community server

Install packages without verification, I said ok all the time.


**Remove sql**

	sudo apt-get remove -y mysql-*
	
	sudo apt-get purge -y mysql-*
	
	
**General proc**

As said [here](https://www.digitalocean.com/community/tutorials/how-to-install-the-latest-mysql-on-ubuntu-16-04):

	curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.3-1_all.deb
	

	sudo dpkg -i mysql-apt-config*


	sudo apt-get update


Got error that keyexpired. Didn't bother with it and moved on
nevertheless.

	rm mysql-apt-config*
	
	sudo apt-get install mysql-server
	
	systemctl status mysql


``` shell
Output
● mysql.service - MySQL Community Server
   Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2017-04-05 19:28:37 UTC; 3min 42s ago
 Main PID: 8760 (mysqld)
   CGroup: /system.slice/mysql.service
           └─8760 /usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid
```

	mysql_secure_installation

Got access denied a couple of times. Started from the top and this
time it was ok.


	mysqladmin -u root -p version


``` shell
eghx@eghx-nitro:~$ mysqladmin -u root -p version
Enter password: 
mysqladmin  Ver 8.42 Distrib 5.7.33, for Linux on x86_64
Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Server version		5.7.33
Protocol version	10
Connection		Localhost via UNIX socket
UNIX socket		/var/run/mysqld/mysqld.sock
Uptime:			2 min 34 sec

Threads: 1  Questions: 9  Slow queries: 0  Opens: 113  Flush tables: 1  Open tables: 106  Queries per second avg: 0.058
```

## password

a................

### installation workbench


	mysql --version
	
``` shell
$ mysql -V
mysql  Ver 14.14 Distrib 5.7.33, for Linux (x86_64) using  EditLine wrapper
```
	
	sudo apt-get install mysql-workbench
	
	
Double click workbench and open it and click all default local
connection and we are in.



## Learning and excercises

### Dater

zip file from this [Reference 1](https://www.youtube.com/watch?v=7S_tz1z_5bA): http://bit.ly/2LNdvCd which
contains text to run dbs.

Files from the stanford course are [schema](https://courses.edx.org/assets/courseware/v1/7be258f060155f581b3cf0d092235ce6/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/Schema.sql) and [dater](https://courses.edx.org/assets/courseware/v1/bc24afe0c983ffb91f39b37c56dc46c3/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/Data.Sq)

### Issue 1273 error while running `basicselect.sql`

- you will get 1273 error

Replace `utf8mb4_0900_ai_ci` with `utf8mb4_general_ci`


### Issue \*\*\*\* unable to delete

Preferences --> Sql editor --> allow to delete and update 

## coding

### create table

``` SQL
DROP DATABASE IF EXISTS `sql_stanford`;
CREATE DATABASE `sql_stanford`; 
USE `sql_stanford`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

create table College(cName text, state text, enrollment int);
create table Student(sID int, sName text, GPA real, sizeHS int);
create table Apply(sID int, cName text, major text, decision text);
```

### join


"inner join" and "join" --> inner join (pandas ref)

"natural join" --> join with assumed condition

none of the outer joins are associative when it comes to more than two
tables.

``` SQL
/**************************************************************
  JOIN OPERATORS
  Works for Postgres
  MySQL doesn't support FULL OUTER JOIN
  SQLite doesn't support RIGHT or FULL OUTER JOIN
**************************************************************/
```

`full outer join` on mysql

``` SQL
SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id
```

### join and where equivalency

**be careful about the type of join you use** can have impact on null
values

``` SQL
# Write a query to return the ratings data in a more readable format: 
# reviewer name, movie title, stars, and ratingDate. 
# Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

select name, title, stars, ratingDate
from Movie M, Rating Rat, Reviewer Rev
where M.mID=Rat.mID and Rev.rID=Rat.rID
order by name, title, stars;

select name, title, stars, ratingDate
from Movie join Rating using(mID) join Reviewer using(rID)
order by name, title, stars;
```

### Getting null values in an aggregation

``` SQL
/**************************************************************
  Number of colleges applied to by each student, including
  0 for those who applied nowhere
**************************************************************/

select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;

/*** Now add 0 counts ***/

select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID
union
select sID, 0
from Student
where sID not in (select sID from Apply);
```

### comments

``` SQL
# Comment
-- Comment
/* Comment */
```

### rename renaming

``` SQL
select year
from Movie M
```

### Using where exists and where not exists

``` SQL
## Find the titles of all movies that have no ratings.

Select mID,title
from Movie 
where mID not in (select mID from Rating);

Select title
from Movie 
where mID not in (select mID from Rating);

Select title
from Movie M
where not exists (select * from Rating R where M.mID=R.mID)
```

## order by first name and last name in mysql and sqllite

``` SQL
# order by last name in sql lite/
Select substr(name,    instr(name, ' ') + 1) AS last_name,  name
from Reviewer 
order by last_name;

# order by first name in
Select substr(name, 1,   instr(name, ' ') - 1) AS first_name,  name
from Reviewer 
order by first_name
```

Sorting by first name without any last name leads to null values

### choosing only the one with the top rating

For each director, return the director's name together with the
title(s) of the movie(s) they directed that received the highest
rating among all of their movies, and the value of that rating.
Ignore movies whose director is NULL.

``` SQL
SELECT director, title, stars
From (select * From Movie join Rating using(mID) where director is not null) as A1
order by director;

SELECT distinct director, title, stars
From (select * From Movie join Rating using(mID) where director is not NULL) as A1
where not exists (select * 
				From (select * From Movie join Rating using(mID) ) as A2
                where A1.director = A2.director and A1.stars<A2.stars)
order by director;
```
Using `A1.stars>A2.stars` with `where exists` is not good enough as
you get more than one value.


### Looking up result in another table (elegant way)

Find the names of all students who are friends with someone named Gabriel.

Highschooler ( ID, name, grade ) English: There is a high school
student with unique ID and a given first name in a certain grade.

Friend ( ID1, ID2 ) English: The student with ID1 is friends with the
student with ID2. Friendship is mutual, so if (123, 456) is in the
Friend table, so is (456, 123).

Likes ( ID1, ID2 ) English: The student with ID1 likes the student
with ID2. Liking someone is not necessarily mutual, so if (123, 456)
is in the Likes table, there is no guarantee that (456, 123) is also
present.

``` SQL
## another solution by someone else (very elegant) how to look up
SELECT name 
FROM Highschooler h
JOIN Friend f
ON f.ID1 = h.ID
WHERE f.ID2 in (
	SELECT ID 
	FROM Highschooler 
	WHERE name = "Gabriel")
```

My solution for the same thing:

``` SQL
Select distinct HS.name
From (select name,ID,ID1,ID2
		From Highschooler HS join Friend on HS.ID=Friend.ID1
		where name = 'Gabriel') as S1 join Highschooler HS on HS.ID=S1.ID2;
```

### Cant use columns from where subqueries in main query. Use join
instead

For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.

``` SQL
Select t1.name, t1.grade,t2.name,t2.grade
From (select name,ID1,grade FROM Likes L join Highschooler HS on L.ID1=HS.ID) as t1 
join (select name,ID1,ID2,grade FROM Likes L join Highschooler HS on L.ID2=HS.ID) as t2 using(ID1)
where t1.grade>=t2.grade+2;
```

### Use left outer join to get where NOT values

``` SQL
-- 4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.

SELECT h1.name, h1.grade
FROM Highschooler h1
LEFT OUTER JOIN Likes l1
ON h1.ID = l1.ID1 OR h1.ID = l1.ID2
WHERE l1.ID1 IS NULL
ORDER BY h1.grade, h1.name;
```


### Most complicated example in join

From [here](https://learning.edx.org/course/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@sequential+block@1b3d22bcd3324961a5be02519b54d292/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@vertical+block@40fd4c31dfff4e558928f89f0c449b4c), [schema](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/socialdata.html)

``` SQL
# For each student A who likes a student B where the two are not friends, 
# find if they have a friend C in common (who can introduce them!).
# For all such trios, return the name and grade of A, B, and C.

Select count(*)
From Friend;

Select L1.ID1,L1.ID2,F1.ID1,F1.ID2
From Likes L1 join Friend F1 using(ID1,ID2);

## For each student A who likes a student B where the two are not friends
Select L1.ID1,L1.ID2,F1.ID1,F1.ID2
From Likes L1 left outer join Friend F1 using(ID1,ID2)
where F1.ID1 is Null;

## Complexcated and returns the common friends
Select NFID1, NFID2, F2.ID2, F3.ID2
From (Select L1.ID1 NFID1,L1.ID2 NFID2
From Likes L1 left outer join Friend F1 using(ID1,ID2)
where F1.ID1 is Null) as NF join Friend F2 on NF.NFID1= F2.ID1 join Friend F3 on NF.NFID2=F3.ID1
where F2.ID2 = F3.ID2;


Select NFID1, NFID2, F2.ID2 as CF,C.name,C.grade
From (Select L1.ID1 NFID1,L1.ID2 NFID2
From Likes L1 left outer join Friend F1 using(ID1,ID2)
where F1.ID1 is Null) as NF join Friend F2 on NF.NFID1= F2.ID1 join Friend F3 on NF.NFID2=F3.ID1
join Highschooler A on A.ID=NF.NFID1
join Highschooler B on B.ID=NF.NFID2
join Highschooler C on C.ID=F2.ID2
where F2.ID2 = F3.ID2;


# final form

Select A.name, A.grade, B.name, B.grade, C.name,C.grade
From (Select L1.ID1 NFID1,L1.ID2 NFID2
From Likes L1 left outer join Friend F1 using(ID1,ID2)
where F1.ID1 is Null) as NF join Friend F2 on NF.NFID1= F2.ID1 join Friend F3 on NF.NFID2=F3.ID1
join Highschooler A on A.ID=NF.NFID1
join Highschooler B on B.ID=NF.NFID2
join Highschooler C on C.ID=F2.ID2
where F2.ID2 = F3.ID2;
```

### updating same table where select not possible in mysql

Q: For all movies that have an average rating of 4 stars or higher,
add 25 to the release year.  (Update the existing tuples; don't insert
new tuples.)

E: MySQL Error 1093 - Can't specify target table for update in FROM clause


Info [here](https://stackoverflow.com/a/9843719/5986651). [Schema](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/moviedata.html).

Q: For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)

``` SQL
Select *
From Movie
where mID in (Select mID
		From Movie join Rating using(mID)
		group by mID
		Having avg(stars)>=4);

Select *
From Movie;

Update Movie
Set year=year+25
Where mID in (select mID
				From (select mID
					From Movie join Rating using(mID)
					group by mID
					having avg(stars)>=4) as C);
```

### Null values can fuck you over

When you do simple joins, where there are null values as outcome, you
wont get anything.

`<>` does not care about null values, YOU NEED TO BE EXPLICIT. 

Schema: [schema](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/socialdata.html)

``` SQL
-- If two students A and B are friends, and A likes B but not
vice-versa,

# If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.

Select L1.ID2 as Alikes,F1.ID1 A,F1.ID2 B, L2.ID2 as Alikeslikes
From Friend F1 join Likes L1 on F1.ID1=L1.ID1 and L1.ID2=F1.ID2 left outer join Likes L2 on F1.ID2=L2.ID1
#Where L1.ID2=F1.ID2 #and L2.ID2<>F1.ID1
order by F1.ID1,F1.ID2;

```

Here I use a left outer join as shit gets removed otherwise...


### One of the hardest select statements

``` SQL
# For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
# Do not add duplicate friendships, friendships that already exist, or friendships with oneself.
# (This one is a bit challenging; congratulations if you get it right.)

## table with A and C pairs. Removed same A and C
Select distinct F1.ID1 as A, F2.ID2 as C
From Friend F1 join Friend F2 on F1.ID2=F2.ID1
where F1.ID1 <> F2. ID2
order by F1.ID1, F2.ID2;

## check if A and C pairs exist previously

Select distinct F1.ID1 as A, F1.ID2 as B, F2.ID2 as C
From Friend F1 join Friend F2 on F1.ID2=F2.ID1
where F1.ID1 <> F2. ID2 
and not exists (Select * 
				From Friend F3
                Where F1.ID1=F3.ID1 and F2.ID2=F3.ID2)
order by F1.ID1, F2.ID2;

## insert

Insert into Friend
	Select distinct F1.ID1 as A, F2.ID2 as C
	From Friend F1 join Friend F2 on F1.ID2=F2.ID1
	where F1.ID1 <> F2. ID2 
	and not exists (Select * 
					From Friend F3
					Where F1.ID1=F3.ID1 and F2.ID2=F3.ID2)
	order by F1.ID1, F2.ID2
```

## References

0. [Working on workbench](https://www.youtube.com/watch?v=7S_tz1z_5bA&list=PL3qez0X0oa1YyQgyo4-MlG2ZUPhtvf3yI&index=5&t=1232s)

1. [How to install on mac and windows and how to use MySQL](https://www.youtube.com/watch?v=7S_tz1z_5bA)

2. [Learn SQL in 1 hr](https://www.youtube.com/watch?v=9Pzj7Aj25lw)

3. [Complete getting started for pythiath and mysql](https://www.youtube.com/watch?v=x7SwgcpACng)

4. [answers1 ](https://github.com/nataliehan23/MySQL-Coursera/blob/master/movie_rating_extra.sql)

5. [answers2](https://github.com/ashmichheda/SQL-Stanford-Lagunita)
