---
title: "Bonus Materials (Optional)"
author: "Shaun Jackson, Marissa Chemotti"
date: "7/3/2019"
output: 
  rmdformats::material:
    self_contained: no
---




# Bonus Material (Optional)

## String Manipulation

- What are the most useful use cases for string manipulation?
    - Pattern matching: One can easily automate trudging through a dataset by hand, by finding patterns within the character columns in their dataset
    - Data cleaning, Are their some mispelled or case sensitive datasets? How do we group these cases?

### Regular Expressions

- To find patterns within data that has characters within it, we use **regular expressions**

Regular expressions are expressions that allow one to find patterns. 

- To implement a regular expression in R, we can use the `grep` function to find patterns, or `gsub` to both find patterns and substitute patterns with another one.

#### grep

- `grep` is a function that we will use to find patterns in a vector of strings
- the first argument will be the regular expression
- the second argument will be the vector we are searching within


```r
stringVecToSearch <- c('a', 'b', 'c', 'd', 'bad', 'jab')
regExprPattern <- 'a'
grep(regExprPattern, stringVecToSearch)  # indices of all strings with  an 'a'
```

```
## [1] 1 5 6
```

```r
# Find patterns that STARTS with a pattern with ^
regExprPattern <- '^b'
# in this case, starts with a 'b'
grep(regExprPattern, stringVecToSearch)
```

```
## [1] 2 5
```

```r
# Find patterns that ENDS with a pattern with $
regExprPattern <- 'b$'
# in this case, ends with a b
grep(regExprPattern, stringVecToSearch)
```

```
## [1] 2 6
```

```r
# If we want to see the values, not the indices of where patterns exist
grep(regExprPattern, stringVecToSearch, value=TRUE)
```

```
## [1] "b"   "jab"
```

#### Grep Applied to a dataframe


```r
# see all columns that STARTS with ados
ados_cols <- grep('^ados', names(adosm1), value=TRUE)
adosm1[, ados_cols]

# see all rows that have a an ados algorithm of no words
# grep will return row numbers of where a pattern of no words
# exists in ados_version
no_words_vals <- grep('no words', adosm1$ados_version)
# use row numbers to filter dataframe
adosm1[no_words_vals, ]
```



#### gsub

- gsub can be thought of as using grep to find the patterns, but replacing the patterns found with something new.
- The first argument is the pattern to find
- The second argument is what to replace with the pattern found
- The third argument is the vector that holds the pattern to search and replace


```r
stringVecToSub <- c('id', 'visit', 'ad1', 'ad2', 'ad3', 'ad4')
gsub('ad', 'ados_', stringVecToSub)
```

```
## [1] "id"     "visit"  "ados_1" "ados_2" "ados_3" "ados_4"
```

### String Concatenation

#### paste

#### paste0

#### sprintf

### Rename columns

## Programming Constructs

### control statements essentials

### if else

### for loops


## Vectorization

### ifelse()

## Write Clean Code

### Max Line Length

### Speak through Code

### A Comment on Comments


