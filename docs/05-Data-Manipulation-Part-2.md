---
title: "05-Data-Manipulation-Part-2"
author: "Shaun Jackson, Marissa Chemotti"
date: "2019-07-16"
output: 
  rmdformats::material:
    self_contained: no
---


# Data Manipulation Part 2

## Goals
By the end of this chapter, you will be able to:


0. Know how to create functions
1. Gain data Manipulation skills
    - Learn how to efficiently manipulate data with `lapply()`
    - Score data with `rowSums()` and `rowMeans()` and `lapply()`
2. Combine datasets together
    - using `merge()`
    - using `rbind()` and `rbind.fill()`
3. Combining Sections 1 and 2 to Score the ADOS Module 1

## But first.. Functions

A function is an entity that performs an operation on an input, and returns an ouput

- Notice how we use syntax that has `nameOfFunction` with a `()` after it
- These are functions that take an input within the `()` and return an output
- For example the `c()` takes in multiple elements of the same type, and returns a vector of values
- the `list()` takes an input of values, and returns a list, 
- the `data.frame()` takes an input of vectors of same length, and returns a dataframe

We can create functions by the following syntax:


```r
plusOneFunction <- function(input1) {
  # This is the function body
  # do something
  result <- input1 + 1
  return(result)  # output
}
```

- The inputs of our function are within the `()`
- The body of the function is where we perform operations on the input
- Calling `return()` will specify what output we want from our function
- The ` <- ` assigns the function to a variable we can later on use
    - In this case, plusOneFunction now can be used later on to  perform an operation
    

```r
a <- 1
b <- plusOneFunction(a)   # a will represent input1
b  # b is the result after the return()
```

```
## [1] 2
```



## Scoring and Cleaning Data


### Using the messy dataset


```r
messyDf <- data.frame(
  id = c(1, 1, 2, 2, 3, 3),
  visit = c('10 months', '20 months',  '10 months', '20 months', '10 months', '20 months'),
  item1 = c(1, 2, 3, 3, 5, 6),
  # item2 is a column with NAs
  item2 = c(NA, NA, 3, 4, 5, 6),
  # item3 is  a column with multiple missing codes and NAs
  item3 = c(NA, 'Missing', '-999', '4', '5', '6'),
  # item 4 is a character column with different codes for  same value
  item4Text = c('father', 'Father', 'fth', 'mother', 'Mother', 'Mother'),
  # item 5 is a coded variable with text embedded within
  item5Codes = c('0 (Never)', '1', '2', '3', '4', '5 (Always)'),
  item6 = c(1, 2, NA, NA, NA, NA),
  item7 = c(1, 2, 3, NA, NA, 6)
)
```

### `lapply()`: Applying a function over multiple columns with 

#### `lapply()`
- stands for list apply
- think of a column in a dataframe as a list.
- we apply a function to multiple lists with `lapply()`
    - so we could apply a function to multiple columns with `lapply()`

- Function Signature: `lapply(dataframe[, c(colsToApplyFunction)], functionToApply)`
    - The first parameter is a dataframe subsetted by the columns we want to manipulate
    - The second parameter is the function we want to apply to each column
    - It returns all the columns within the first parameter, but the result of what functionToApply did

- If we want to replace all NAs with 0 for items 2, 6, and 7:

```r
messyDf[, c('item2' , 'item6', 'item7')]
```

```
##   item2 item6 item7
## 1    NA     1     1
## 2    NA     2     2
## 3     3    NA     3
## 4     4    NA    NA
## 5     5    NA    NA
## 6     6    NA     6
```

```r
replaceNAsWithZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
  return(x)
}

lapply(messyDf[, c('item2' , 'item6', 'item7')], replaceNAsWithZero)
```

```
## $item2
## [1] 0 0 3 4 5 6
## 
## $item6
## [1] 1 2 0 0 0 0
## 
## $item7
## [1] 1 2 3 0 0 6
```

```r
# We can also just put the function within the second parameter like this:
lapply(messyDf[, c('item2' , 'item6', 'item7')], function(x) {
  x <- ifelse(is.na(x), 0, x)
  return(x)
})
```

```
## $item2
## [1] 0 0 3 4 5 6
## 
## $item6
## [1] 1 2 0 0 0 0
## 
## $item7
## [1] 1 2 3 0 0 6
```

```r
# We assign the result to the original columns to apply function to these cols
messyDf[, c('item2' , 'item6', 'item7')] <- 
  lapply(messyDf[, c('item2' , 'item6', 'item7')], function(x) {
  x <- ifelse(is.na(x), 0, x)
  return(x)
})

messyDf[, c('item2' , 'item6', 'item7')]
```

```
##   item2 item6 item7
## 1     0     1     1
## 2     0     2     2
## 3     3     0     3
## 4     4     0     0
## 5     5     0     0
## 6     6     0     6
```

### Scoring Data with `rowSums()` and `rowMeans()`

- Say we have a scoring algorithm where the sum of items 2, 6, and 7 represent one scale
- And means of items 2, 6, and 7 represent another scale
- Also say we want to count all the zeros, where a zero represents missing.
    - If more than 1 zero, the scales will be invalid

- `rowSums()` takes in a subsetted dataframe, and returns the sum of all those values
- `rowMeans()` takes in a subsetted dataframe, and returns the mean of all those values


```r
total_sum <- rowSums(messyDf[, c('item2', 'item6', 'item7')])
total_sum
```

```
## [1]  2  4  6  4  5 12
```

```r
# if there are NAs, we do
# rowSums(messyDf[, c('item2', 'item6', 'item7')], na.rm=TRUE)
total_mean <- rowMeans(messyDf[, c('item2', 'item6' ,'item7')])
total_mean
```

```
## [1] 0.6666667 1.3333333 2.0000000 1.3333333 1.6666667 4.0000000
```

```r
# to count all 0s, we sum the amount of TRUE values in a logical vector
messyDf[, c('item2', 'item6', 'item7')] == 0
```

```
##      item2 item6 item7
## [1,]  TRUE FALSE FALSE
## [2,]  TRUE FALSE FALSE
## [3,] FALSE  TRUE FALSE
## [4,] FALSE  TRUE  TRUE
## [5,] FALSE  TRUE  TRUE
## [6,] FALSE  TRUE FALSE
```

```r
total_missings <- rowSums(messyDf[, c('item2', 'item6', 'item7')] == 0)
total_missings
```

```
## [1] 1 1 1 2 2 1
```

```r
# store these values in columns
messyDf$total_sum <- total_sum
messyDf$total_mean <- total_mean
messyDf$total_missings <- total_missings
# if more than 1 zero, data invalid
messyDf$invalid_flag <- messyDf$total_missings > 1

messyDf[, c('total_sum', 'total_mean', 'total_missings', 'invalid_flag')]
```

```
##   total_sum total_mean total_missings invalid_flag
## 1         2  0.6666667              1        FALSE
## 2         4  1.3333333              1        FALSE
## 3         6  2.0000000              1        FALSE
## 4         4  1.3333333              2         TRUE
## 5         5  1.6666667              2         TRUE
## 6        12  4.0000000              1        FALSE
```


## Merging datasets together

- One important skill when working with R is merging data from multiple files into one dataframe
- There are multiple ways to do this, such as using `sqldf()` or `merge()`. 
- To stick with base R, we will use `merge()`

### Creating datasets to merge


```r
subjects <- data.frame(
  id = c(1, 2, 3),
  clincalBestEst = c('ASD', 'Non-ASD', 'Non-ASD')
)

visits <- data.frame(
  id = c(1, 1, 2, 2, 3, 3),
  visit = c('18mo', '36mo', '18mo', '36mo', '18mo', '36mo'),
  date_of_testing = c('2017-02-03', '2018-08-03', '2017-02-04',
                      '2018-08-04', '2018-01-04', '2019-07-03')
)

ados_scores <- data.frame(
  id = c(1, 2, 3),
  visit = c('36mo', '36mo', '36mo'),
  ados_sarb_total = c(10, 1, 2)
)

# if reading from different files, just replace <- data.frame()
# with read.csv(filepath, stringsAsFactors=FALSE) 
```


### Merging with `merge()`

- To merge a dataset, we first need to know the columns we will merge by
- In this case, we can merge the subjects and visits dataframes by id
- We can merge the result of the previous merge, with id and visit
- Using `merge()`, it takes in two dataframes, and a **by** parameter as well as a **all.x** or **all,.y** or **all** parameter

```r
# all.x creates a LEFT JOIN
master <- merge(subjects, visits, by = c('id'), all.x = TRUE)
master
```

```
##   id clincalBestEst visit date_of_testing
## 1  1            ASD  18mo      2017-02-03
## 2  1            ASD  36mo      2018-08-03
## 3  2        Non-ASD  18mo      2017-02-04
## 4  2        Non-ASD  36mo      2018-08-04
## 5  3        Non-ASD  18mo      2018-01-04
## 6  3        Non-ASD  36mo      2019-07-03
```

```r
master <- merge(master, ados_scores, by = c('id', 'visit'), all.x = TRUE)
master
```

```
##   id visit clincalBestEst date_of_testing ados_sarb_total
## 1  1  18mo            ASD      2017-02-03              NA
## 2  1  36mo            ASD      2018-08-03              10
## 3  2  18mo        Non-ASD      2017-02-04              NA
## 4  2  36mo        Non-ASD      2018-08-04               1
## 5  3  18mo        Non-ASD      2018-01-04              NA
## 6  3  36mo        Non-ASD      2019-07-03               2
```

```r
# if the first and second parameters have difference colnames that represent
# the same value, we can use by.x = , or by.y =,
```

### Stacking dataframes with `rbind`

#### Read in data to stack or row bind together


```r
adosm1 <- read.csv('./datasets/adosm1.csv', stringsAsFactors = FALSE)
adosm2 <- read.csv('./datasets/adosm2.csv', stringsAsFactors = FALSE)
ados   <- rbind(adosm1, adosm2)
# if datasets have columns that are not the same, use rbind.fill within plyr package
```

## Score ADOS Module 1- Assignment 2

### Instructions

1. Read in the adosm1.csv file
2. If item b1, 
    - replace NAs or Missings with 0, 
    - replace value 1 or 3, with 2,
    - replace items 0 or 2, with 0,
    - otherwise keep original value
3. For all other items,
    - replace NAs or Missing codes with 0,
    - replace value 3, with 2,
    - keep values between  0, 1, 2 the same as itself,
    - replace all others with 0
4. Score SA total
    - If ados_algorithm is 'no words', or 'few to no words', the sa_total = 
        - rowSums of ados_a2, ados_a8, ados_b1, ados_b3,  ados_b4, ados_b5, ados_b9, ados_b10, ados_b11
    - If ados_aglorithm is  some words, the sa_total = 
        - rowSums of ados_a2, ados_a7, ados_a8, ados_b1, ados_b3, ados_b4, ados_b5, ados_b9, ados_b10
5. Score RRB total
    - If ados_algorithm is 'no words', or 'few to no words', the rrb_total = 
        - rowSums of ados_a3, ados_d1, ados_d2, ados_d4
    - If ados_aglorithm is  some words, the rrb_total = 
        - rowSums of ados_a5, ados_d1, ados_d2, ados_d4
6. Score SARB total
    - SARB total = 
        - sa_total + rrb_total

### Solution


#### Solution Part 1


```r
# 1. Read in adosm1.csv
adosm1 <- read.csv('./datasets/adosm1.csv', stringsAsFactors = FALSE)
# store backup to restore original vals
adosm1_backup <- adosm1
```

#### Solution Part 2


```r
# 2. If item b1, 
#    - replace NAs or Missings with 0,
#    - replace value 1 or 3, with 2,
#    - replace items 0 or 2, with 0,
# create function to apply to item b1 and replace values properly
item_b1_replace <- function(item) {
  # items may be  characters because of missings codes, so first replace with
  # chars, then turn to numerics
  item <- as.character(item)
  newVal <- ifelse(is.na(item), '0', # replace NAs with 0
                   ifelse(item %in% c('-999', '9', 'Missing (-9)'),' 0',  # replace missings with 0
                          ifelse(item %in% c('1', '3'), '2',  # replace 1 or 3 with 2
                                 ifelse(item %in% c('0', '2'),  '0', item))))  # replace 0 or 2 with 0, else item
  newVal <- as.numeric(newVal)
  return(newVal)
}
adosm1$ados_b1 <- item_b1_replace(adosm1$ados_b1)
```


#### Solution Part 3


```r
# 3. For all other items,
#     - replace NAs or Missing codes with 0,
#     - replace value 3, with 2,
#     - keep values between  0, 1, 2 the same as itself,
#     - replace all others with 0.
item_replace <- function(item) {
  # items may be  characters because of missings codes, so first replace with
  # chars, then turn to numerics
  item <- as.character(item)
  newVal <- ifelse(is.na(item), '0', # replace NAs with 0
                   ifelse(item %in% c('-999', '9', 'Missing (-9)', '999'), '0',  # replace missings with 0
                          ifelse(item == '3', '2',  # replace 3 with 2
                                 ifelse(item %in% c('0', '1', '2'),  item, 
                                        '0'))))  
  newVal <- as.numeric(newVal)
  return(newVal)
  
}
names(adosm1)
```

```
##  [1] "id"                "visit"             "cbe_36"           
##  [4] "recruitment_group" "gender"            "ados_version"     
##  [7] "ados_algorithm"    "ados_a1"           "ados_a2"          
## [10] "ados_a3"           "ados_a4"           "ados_a5"          
## [13] "ados_a6"           "ados_a7"           "ados_a8"          
## [16] "ados_b1"           "ados_b2"           "ados_b3"          
## [19] "ados_b4"           "ados_b5"           "ados_b6"          
## [22] "ados_b7"           "ados_b8"           "ados_b9"          
## [25] "ados_b10"          "ados_b11"          "ados_b12"         
## [28] "ados_b13a"         "ados_b13b"         "ados_b14"         
## [31] "ados_b15"          "ados_b16"          "ados_c1"          
## [34] "ados_c2"           "ados_d1"           "ados_d2"          
## [37] "ados_d3"           "ados_d4"           "ados_e1"          
## [40] "ados_e2"           "ados_e3"
```

```r
# use regular expressions to obtain columns b1, or all other scoring columns
# we did not yet cover this, but here is an example. The alternative will
# be to write each individual colname
ados_all_items <- grep('ados_[abcde][0123456789]', names(adosm1), value=TRUE)
ados_all_not_b1 <- setdiff(ados_all_items, 'ados_b1')  # all items not ados_b1
adosm1[, ados_all_not_b1] <- lapply(adosm1[, ados_all_not_b1], item_replace)
```

#### Solution Part 4


```r
# 4. Score SA total
# - If ados_algorithm is 'no words', or 'few to no words', the sa_total = 
#     - rowSums of ados_a2, ados_a8, ados_b1, ados_b3,  ados_b4, ados_b5, ados_b9, ados_b10, ados_b11
# - If ados_aglorithm is  some words, the sa_total = 
#     - rowSums of ados_a2, ados_a7, ados_a8, ados_b1, ados_b3, ados_b4, ados_b5, ados_b9, ados_b10
no_words_sa_items <- c('ados_a2', 'ados_a8', 'ados_b1', 'ados_b3',  
                       'ados_b4', 'ados_b5', 'ados_b9', 'ados_b10', 'ados_b11')
no_words_sa <- rowSums(adosm1[, no_words_sa_items])
# we can use regExpr to obtain items
some_words_sa_items <- grep('^ados_a[278]$|^ados_b[13459]$|^ados_b1[01]$', 
                            names(adosm1), value=TRUE)
some_words_sa <- rowSums(adosm1[ some_words_sa_items])
adosm1$ados_sa_total <- 
  ifelse(adosm1$ados_algorithm %in% c('no words', 'few to no words'), no_words_sa,
       ifelse(adosm1$ados_algorithm %in% c('some words'), some_words_sa, NA))
```


#### Solution Part 5


```r
# 5. Score RRB total
# - If ados_algorithm is 'no words', or 'few to no words', the rrb_total = 
#     - rowSums of ados_a3, ados_d1, ados_d2, ados_d4
# - If ados_aglorithm is  some words, the rrb_total = 
#     - rowSums of ados_a5, ados_d1, ados_d2, ados_d4, 
#       ados_b3, ados_b4, ados_b5, ados_b9, ados_b10
no_words_rrb_items <- c('ados_a3', 'ados_d1', 'ados_d2', 'ados_d4')
no_words_rrb <- rowSums(adosm1[, no_words_rrb_items])
# we can use regExpr to obtain items
some_words_rrb_items <- grep('^ados_a[5]$|^ados_d[124]$', 
                            names(adosm1), value=TRUE)
some_words_rrb <- rowSums(adosm1[ some_words_rrb_items])
adosm1$ados_rrb_total <- 
  ifelse(adosm1$ados_algorithm %in% c('no words', 'few to no words'), no_words_rrb,
       ifelse(adosm1$ados_algorithm %in% c('some words'), some_words_rrb, NA))
```


#### Solution Part 6


```r
# 6. Score SARB total
# - SARB total = 
#     - sa_total + rrb_total
adosm1$ados_sarrb_total <- adosm1$ados_sa_total + adosm1$ados_rrb_total

# optional- replace all manipulated items back to original
adosm1[, ados_all_items] <- adosm1_backup[, ados_all_items]

head(adosm1)
```

```
##   id visit cbe_36 recruitment_group gender ados_version  ados_algorithm
## 1  1    18 Non-TD         High risk   Male       ADOS-1      some words
## 2  1    24     TD         High risk Female       ADOS-1      some words
## 3  2    18     TD          Low risk Female       ADOS-1      some words
## 4  2    24     TD         High risk Female       ADOS-1      some words
## 5  3    18     TD          Low risk   Male       ADOS-1 few to no words
## 6  4    18 Non-TD         High risk   Male       ADOS-1 few to no words
##   ados_a1 ados_a2 ados_a3 ados_a4 ados_a5 ados_a6 ados_a7 ados_a8 ados_b1
## 1       3       0       0       0       0       0       1       1       0
## 2       2       0       0       0       1       0       0       0       0
## 3       0       0       0       0       8       0       1       0       0
## 4       0       0       0       0       0       0       1       0       0
## 5       8       1       0       1       8       0       1       0       0
## 6       8       0       0       8       8       0       1       1       0
##   ados_b2 ados_b3 ados_b4 ados_b5 ados_b6 ados_b7 ados_b8 ados_b9 ados_b10
## 1       0       0       0       0       0       1       0       0        0
## 2       0       0       0       0       1       0       1       0        0
## 3       0       0       0       0       0       0       0       0        0
## 4       1       0       0       1       0       1       0       0        0
## 5       1       0       0       0       0       0       0       2        0
## 6       0       0       1       0       1       0       2       1        0
##   ados_b11 ados_b12 ados_b13a ados_b13b ados_b14 ados_b15 ados_b16 ados_c1
## 1        0        0        NA        NA       NA       NA       NA       0
## 2        0        0        NA        NA       NA       NA       NA       0
## 3        0        0        NA        NA       NA       NA       NA       1
## 4        0        0        NA        NA       NA       NA       NA       0
## 5        0        0        NA        NA       NA       NA       NA       0
## 6        2        0        NA        NA       NA       NA       NA       2
##   ados_c2 ados_d1 ados_d2 ados_d3 ados_d4 ados_e1 ados_e2 ados_e3
## 1       1       1       0       0       0       1      NA       1
## 2       0       0       0       0       0       0       0       1
## 3       0       0       0       0       0       1       0     999
## 4       1       0       0       0       1       0       0       1
## 5       1       0       0       0       0       0       0       0
## 6       1       1       1       0       2       1       0       0
##   ados_sa_total ados_rrb_total ados_sarrb_total
## 1             2              1                3
## 2             0              1                1
## 3             1              0                1
## 4             2              1                3
## 5             3              0                3
## 6             5              4                9
```

