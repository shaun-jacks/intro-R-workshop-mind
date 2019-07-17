---
title: "02-Data-Manipulation"
author: "Shaun Jackson, Marissa Chemotti"
date: "2019-07-16"
output: 
  rmdformats::material:
    self_contained: no
---


# Data Manipulation Part 1

## Goals
By the end of this chapter, you will be able to:

1. Gain Data Cleaning skills
    - Remove duplicate data
    - Clean data by replacing messy data with consistent data
        - using `ifelse()`
2. Write your resulting dataframe with `write.csv()`




## Removing Duplicates


```r
# Create duplicated dataframe 
dupDf <- data.frame(id = c(1, 1, 2, 2, 3, 3),
                    visit = c('10 months', '20 months',  '10 months', '10 months', '20 months', '20 months'),
                    item1 = c(1, 2, 3, 3, 5, 6))
# save logical vector of duplicate indices
dupIndGrouped <- duplicated(dupDf[, c("id", "visit")])
dupIndGrouped
```

```
## [1] FALSE FALSE FALSE  TRUE FALSE  TRUE
```

- Before removing duplicates, it's important to understand why there would be duplicates, and try to fix that issue 
- Otherwise, here is another way to quickly remove them

- To remove duplicates, we use the same logical vector that found the duplicates
- We then inverse the vector by adding a (not sign) ! to toggle TRUES to FALSES and FALSES to TRUES
- By subsetting in this way, we will make a cleaner dataframe excluding all duplicate rows


```r
notDuplicateCases <- !dupIndGrouped
fixedDf <- dupDf[notDuplicateCases, ]
View(fixedDf)  # View fixed dataframe
```

## Cleaning, Scoring Messy Data

### Messy Dataset

- We will create a dataset that is 'unclean' in order to teach you how to clean it


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

### Replacing values with `ifelse()`

- `ifelse()` is a **vectorized** function that uses matrix-like operations for increased efficiency
- It can take in a vector of values, and return a vector of  values of the same length
- Function Signature: `ifelse(condition, value if condition true,  value if condition false)`
    - The `condition` is a logical vector which could be created with boolean operators (eg. ==, <, >) or any function that returns a logical operator: eg. `duplicated()`, `grepl()`, `is.na()`.
    - The second parameter is what value will be returned for all TRUEs in the preceding logical vector
    - The third parameter is what value will be returned for all FALSEs in the 1st condition logical vector

### Replacing NAs with `ifelse()`

- For example, we can replace all NAs with 0 by also using the `is.na()`. 
    - `is.na()` takes in a vector of values
     - This function will take the input vector, and return a logical vector, same as what `duplicated()` did, where TRUEs are where an NA was found, and FALSE otherwise.


```r
is.na(messyDf$item2)
```

```
## [1]  TRUE  TRUE FALSE FALSE FALSE FALSE
```

```r
# for all NAs replace with 0, otherwise replace with original value
ifelse(is.na(messyDf$item2), 0, messyDf$item2)  
```

```
## [1] 0 0 3 4 5 6
```

```r
# We use this vector and assign it to the original column to clean it
messyDf$item2 <- ifelse(is.na(messyDf$item2), 0, messyDf$item2) 
```


### Nesting `ifelse()` to replace multiple values

- To fix item3, we need to have a consistent code for **Missing**
- Notice how NA, Missing, and -999, all represent **Missing**
- To replace all 3 cases, we can do so by nesting `ifelse` statements.
- To do this, we nest ifelse statements:




```r
ifelse(condition1, value1,
       ifelse(condition2, value2, value3))
```

- This example replaces all TRUE values from **condition1** with **value 1**
- It then replaces all TRUE values from **condition2** with **value2**, 
- Lastly, all the **remaining FALSE** values are replaced with **value3**


#### Replacing multiple values: NAs, -999s, Missing codes


```r
# See  logical vector of NAs
is.na(messyDf$item3)
```

```
## [1]  TRUE FALSE FALSE FALSE FALSE FALSE
```

```r
# See  logical vector of -999s
messyDf$item3 == '-999'
```

```
## [1]    NA FALSE  TRUE FALSE FALSE FALSE
```

```r
# See  logical vector of 'Missing'
messyDf$item3 == 'Missing'
```

```
## [1]    NA  TRUE FALSE FALSE FALSE FALSE
```

```r
# for all NAs replace with 0, otherwise replace with original value
ifelse(is.na(messyDf$item3), '-9', 
       ifelse(messyDf$item3 == '-999', '-9',
         ifelse(messyDf$item3 == 'Missing', '-9', messyDf$item3)))
```

```
## [1] "-9" "-9" "-9" "2"  "3"  "4"
```

```r
# We use this vector and assign it to the original column to clean it
messyDf$item3 <- 
  ifelse(is.na(messyDf$item3), '-9', 
       ifelse(messyDf$item3 == '-999', '-9',
         ifelse(messyDf$item3 == 'Missing', '-9', messyDf$item3)))
```


#### Replacing multiple values with the `%in%`
- we can condense the previous ifelse statements with `%in%`


```r
ifelse(is.na(messyDf$item3), '-9',
       ifelse(messyDf$item3 %in% c('-999', 'Missing'), '-9', messyDf$item3))
```


## Writing Data

### `write.csv`
- We can write data from our R environment to a CSV file with `write.csv`
- `write.csv` takes in a dataframe within our R environment, as the first parameter
- the second parameter is the location and filename to write it to.
- For example, after scoring our  adosm1 dataset, we can now write it to a location


```r
# write.csv(adosm1, './datasets/ADOS Module 1 Scored', row.names = FALSE)
```


Congratulations! We have now covered and combined some essentials in working with data manipulation.

In the next section, we will cover data visualization and analysis tools within R

 

