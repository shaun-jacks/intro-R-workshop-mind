---
title: "03-Data-Manipulation"
author: "Shaun Jackson, Marissa Chemotti"
date: "2019-07-15"
output: 
  rmdformats::material:
    self_contained: no
---


# Data Manipulation

## Goals
By the end of this chapter, you will be able to:

1. Gain Data Cleaning skills
    - Remove duplicate data
    - Clean data by replacing messy data with consistent data
        - using `ifelse()`
        - using `grepl()`, and `gsub()`
2. Gain data Manipulation skills
    - Learn how to efficiently manipulate data with `lapply()`
    - Score data with `rowSums()` and `rowMeans()` and `lapply()`
3. Combine datasets together
    - using `merge()`
    - using `rbind()` and `rbind.fill()`



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

## Messy Dataset

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
  item5Codes = c('0 (Never)', '1', '2', '3', '4', '5 (Always)')
)
```

## `ifelse()`

- `ifelse()` is a **vectorized** function that uses matrix-like operations for increased efficiency
- It can take in a vector of values, and return a vector of  values of the same length
- Function Signature: `ifelse(condition, value if condition true,  value if condition false)`
    - The `condition` is a logical vector which could be created with boolean operators (eg. ==, <, >) or any function that returns a logical operator: eg. `duplicated()`, `grepl()`, `is.na()`.
    - The second parameter is what value will be returned for all TRUEs in the preceding logical vector
    - The third parameter is what value will be returned for all FALSEs in the 1st condition logical vector

### Replacing values with `ifelse()`

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
    - `ifelse(condition1, value1 if true,`
       `ifelse(condition2, value2 if true,  value3 for all else false))`
        - This example replaces all TRUE values from **condition1** with **value 1**
        - It then replaces all TRUE values from **condition2** with **value2**, 
        - Lastly, all the **remaining FALSE** values are replaced with **value3**


```r
is.na(messyDf$item3)
```

```
## [1]  TRUE FALSE FALSE FALSE FALSE FALSE
```

```r
messyDf$item3 == '-999'
```

```
## [1]    NA FALSE  TRUE FALSE FALSE FALSE
```

```r
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
 

