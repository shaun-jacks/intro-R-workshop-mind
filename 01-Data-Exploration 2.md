---
title: "Intro to R- Part 1: Data Exploration"
author: "Shaun Jackson, Marissa Chemotti"
date: "7/3/2019"
output: 
  rmdformats::material:
    self_contained: no
---



# Introduction and Data Exploration

## Goals
By the end of this document, you will be able to:

1. Learn about the fundamental R Datatypes
2. Read a CSV file into your R environment
3. Write from your R environment to a CSV file
4. Explore different attributes of a dataframe
    - column names
    - row names
    - more with `attributes()`
    - Subset a dataframe by rows and columns
    - Filter a dataframe by the values of a column
5. Use two data exploration and cleaning functions
    - Frequency counts of unique values with `table()`
    - Search for any duplicates within your data with `duplicated()`

In this section, we introduce to you the Fundamental R Datatypes, Data input and data output, as well as some useful data exploration functions.


## Datatypes

### Numeric, Logical, Character, Factor

### Lists, Vectors, Matrices

### Dataframes

## Reading in Data

### Read CSV Files

- store the filepath within a character variable
- the filepath could be relative to your working directory, or absolute
- `read.csv` is a function that could read CSV files into your R environment


```r
# define relative filepath
pathToAdosFile <- './datasets/adosm1.csv'

# Use read.csv() and filepath variable as first argument to function
adosm1 <- read.csv(pathToAdosFile, 
                   stringsAsFactors = FALSE)
# stringsAsFactors is an optional argument that tells read.csv to
# not turn a string column into a R factor variable

# adosm1 is now considered a datraframe
```

## Writing Data

### `write.csv`
- We can write data from our R environment to a CSV file with `write.csv`
- `write.csv` takes in a dataframe within our R environment, as the first parameter
- the second parameter is the location and filename to write it to.


```r
# write.csv(adosm1, 'datasets/practice write csv ados.csv', row.names = FALSE)
```
  
### `data.table::fwrite()`
- One you are comfortable with write.csv, I would suggest looking into the `fwrite` function within data.table. It is much much faster and more efficient.
  

## Subsetting Data

### Subset by columns

- In our case, adosm1 is within our R environment, so we would call
    - `adosm1[namesOfRows, namesOfColumns]`
    - Note: it is best practice to access columns by their names, not their numbers


```r
# To access the id column, we would write
adosm1[, "id"]

# To access id and visit
adosm1[, c("id", "visit")]

# in order to make code less verbose, when accessing one column, we use
# the $ operator
# to access the id column
adosm1$id
```

### Subset by rows

- We could similarly access rows by rownames or row numbers
     - `adosm1[c(1, 2, 5), ]`
     

```r
# access 1st, 2nd, and 5th rows
adosm1[c(1, 2, 5), ]
```

### Subset by rows and columns


```r
# access 1st, 2nd, and 5th rows, within id and visit columns
adosm1[c(1, 2, 5), c("id", "visit")]
```


## Filtering a dataframe: Subsetting part 2

### Subset with a logical vector


- What is very powerful in this is we could subset a dataframe in order to answer specific questions
- This is done by using a **logical vector** to subset or slice a dataframe

### Subset logical vector example



```r
# To Filter for all visits at 36 months:
# Create logical vector
visits36mo <- adosm1$visit == "36"

# use  our visits36mo  logical vector to filter dataframe
adosm1[visits36mo, ]  # returns  a dataframe of all visits at 36mo

adosm1[visits36mo, "id"] # returns all the ids with a visit at 36mo

# returns alg and version at 36 months
adosm1[visits36mo, c("ados_algorithm", "ados_version")] 
```

## Functions to explore data

### `View()`

- To view your dataframe call the `View()` function.
- Note the capital **V**iew().


```r
View(adosm1)
```

### See Dataframe attributes

- display column names `names()`
- display rownames with `row.names()`
- see all attributes with `attributes(dataframe)`


```r
# display column names
# names(dataframe), we will use our adosm1 dataframe
# wrap function with head() to show first 5
head(names(adosm1))
```

```
## [1] "id"                "visit"             "cbe_36"           
## [4] "recruitment_group" "gender"            "ados_version"
```

```r
# display rownames, wrap function with head() to show first 5
head(row.names(adosm1))
```

```
## [1] "1" "2" "3" "4" "5" "6"
```

### `table()`


```r
# To get a frequency count of  all unique values,
# we use the  table()

# table() takes in 1 or more vectors as input
# since every dataframe column could be considered a vector (or list)
# we could check for every unique visit with freq counts with
table(adosm1$visit)
```

```
## 
##  18  21  24  30  36 
## 445   5 396  32 146
```

```r
# we could check  for every unique combination of vectors by 
# providing multiple vector inputs

# To see every unique combination of visit and ados algorithm
table(adosm1$visit, adosm1$ados_algorithm)
```

```
##     
##          few to no words no words some words
##   18   3             157       93        192
##   21   0               0        2          3
##   24   4              65       30        297
##   30   0               4        0         28
##   36   6               8       20        112
```


### Checking for duplicates: `duplicated()`
- We will first generate a dataframe that has duplicates, to show how to detect duplicates by different subgroups



```r
dupDf <- data.frame(id = c(1, 1, 2, 2, 3, 3),
                    visit = c('10 months', '20 months',  '10 months', '10 months', '20 months', '20 months'),
                    item1 = c(1, 2, 3, 3, 5, 6))
```

- The `duplicated` function returns a logical vector of the duplicates that exist in a dataframe.
- The TRUE values represent the index locations of where a duplicate row was found.
- We could use this logical vector to see where a duplicate exists


```r
duplicateIndices <- duplicated(dupDf)  # store dup vector in variable

duplicateIndices  # view logical vector of duplicates
```

```
## [1] FALSE FALSE FALSE  TRUE FALSE FALSE
```

```r
dupDf[duplicateIndices, ]
```

```
##   id     visit item1
## 4  2 10 months     3
```

### `Duplicated()` by key variables: id and visit

- we could check for duplicates by columns that should represent a unique combination.
- in this example: id and visit


```r
# to check duplicates by groups
dupIndGrouped <- duplicated(dupDf[, c("id", "visit")])
dupDf[dupIndGrouped, ]
```

```
##   id     visit item1
## 4  2 10 months     3
## 6  3 20 months     6
```

## Assignment: adosm2 dataset

### Instructions

1. Read in the adosm2.csv file
2. What is the frequency count for every unique visit?
3. What are the ids that exist for the 30 month visit?
4. Are there duplicates by id and visit?
5. What is the frequency count of duplicates vs non-duplicates?

### Solution


```r
# 1. Read in the adosm2.csv file
adosm2Path <- './datasets/adosm2.csv'
adosm2 <- read.csv(adosm2Path, stringsAsFactors = FALSE)

# 2. What is the frequency count for every unique visit?
table(adosm2$visit)
```

```
## 
##  24  30  36 sa1 sa2 
##  42  14 469   2   2
```

```r
# 3, What are the ids that exist for the 30 month visit?
adosm2[adosm2$visit == "30", "id"]
```

```
##  [1]  20  53  57  71  78 104 222 252 304 306 385 444 451 455
```

```r
# This works too- adosm2$id[adosm2$visit == "30"]

# 4. Are there duplicates by id and visit?
any(duplicated(adosm2[, c("id", "visit")]))
```

```
## [1] FALSE
```

```r
# 5. What are the frequency count of duplicates vs non-duplicates
table(duplicated(adosm2))
```

```
## 
## FALSE 
##   529
```





