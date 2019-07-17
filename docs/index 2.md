---
title: "Intro to R Workshop Book"
author: "Shaun Jackson, Marissa Chemotti"
date: "2019-07-16"
site: bookdown::bookdown_site
documentclass: book
biblio-style: apalike
link-citations: yes
github-repo: shaun-jacks/intro-R-workshop-mind
description: "Introduction to R Workshop"
---

# Overview and Introduction

The aim of this workshop is to get you up and running with R as quick as possible by teaching you how to connect the most important R constructs through hands-on examples.
One of the toughest parts about  learning a programming language is feeling overwhelmed by the abundance of material to learn.

By giving you an overview of the most useful functions, in the lens of close-to-real-world artificial datasets, we hope that you can apply these concepts to your own data. 

As with everything else, the best way to learn R is through **consistent** practice with a real world project.

## Datatypes
- R is a statistical software that allows user to perform a multitude of data tasks.
- In order to manipulate data, one would need to understand the fundamental R datatypes.

### Numeric, Character, Logical, Factor

#### Numeric

- A numeric is self-explanatory. It could be a number that is either an integer, or a decimal
- In R we can assign a numeric to a number with the assignment operator `<-`, or with an `=` sign.
    - `a <- 1`

#### Character

- A character is a representation of letters and or numbers and symbols. You would wrap the letters and numbers in either `""` or `''` marks to store as a character
- Assign a character value to a variable named a
    - `a <- 'abc'` 

#### Logical

- A logical value also called a boolean value can only be `TRUE` or `FALSE`.
- These are powerful and allows the user to filter their data based on certain conditions.
- Assign a flag to TRUE
    `flag <- TRUE`

##### Boolean operators

- Boolean operators are
    - `<` (less than)
    - `>` (greater than)
    - `==` (equal to) notice two equal signs
    - `!` NOT operator: Turns a TRUE to FALSE or a FALSE to TRUE
    - `&` AND operator: Returns TRUE if all values TRUE, else FALSE
    - `|` OR operator: Returns FALSE if all values FALSE, else TRUE
- A boolean operator returns a logical value or vector (will be explained) or matrix (will be explained)


```r
# quick example of boolean operators
boolVal <- 1 < 5
boolVal
```

```
## [1] TRUE
```

```r
boolVal <- 5 == 5
boolVal
```

```
## [1] TRUE
```

```r
boolVal <- !(5 == 5)
boolVal
```

```
## [1] FALSE
```


### Vectors, Factors, Lists

#### Vectors

- A vector is a combination of values that have  the same datatype.
- We use a function called `c()` to **combine** the values into a vector
- We put various values within the `()` separated by  a comma


```r
vector1 <- c(1, 2, 3)
vector1
```

```
## [1] 1 2 3
```

```r
vector2 <- c('a', 'b', 'c')
vector2
```

```
## [1] "a" "b" "c"
```

```r
vector3 <- c(TRUE, FALSE, TRUE)
vector3
```

```
## [1]  TRUE FALSE  TRUE
```

- Vectors are the fundamental datatypes that can make up a list, or a dataframe, which is how R represents a piece of data by rows and columns.

- We can names vectors by using the `names()`


```r
names(vector1) <- c('a','b', 'c')
vector1
```

```
## a b c 
## 1 2 3
```

#### Factor

- A factor is a special datatype that summarizes your data into a set of levels, where each level is a unique value of your  data.
- It can be used to create Statistical Models
- we can create factors with the function:  `as.factor()`


```r
factor1 <- as.factor(c('a', 'b', 'b', 'c'))
factor1
```

```
## [1] a b b c
## Levels: a b c
```

#### Lists

- A list is similar to a vector in that it could hold  multiple values. However, it is much  more flexible.
- The difference is that it can hold multiple values of **different** datatypes.
- we can create lists with the function: `list()`
- it can also have names for each element in the list by doing:
    - `list(nameOfElement = valuesOfElement)`


```r
list1 <- list(a = 1, 
              b = c(TRUE, FALSE),
              c = 'hi')
list1
```

```
## $a
## [1] 1
## 
## $b
## [1]  TRUE FALSE
## 
## $c
## [1] "hi"
```

### Dataframes

- Dataframes are useful in that it organizes your data into rows and columns, similar to how data would be represented in a database, and excel sheet, or a simple CSV or TSV file.

- Every column has the same length could be thought of as a vector with one datatype.
- It holds additional attributes covered in the next section

- we can create dataframes with `data.frame()`

```r
dataframe1 <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c('a', 'b', 'c')
)
dataframe1
```

```
##   col1 col2
## 1    1    a
## 2    2    b
## 3    3    c
```


### Viewing datatypes with `class()`
- Using the `class()` function, we could see what datatype a variable is


```r
class(list1)
```

```
## [1] "list"
```

```r
class(vector1)
```

```
## [1] "numeric"
```

```r
class(dataframe1)
```

```
## [1] "data.frame"
```

## Functions

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


Now that we've covered fundamental R types, we can begin the fun stuff- starting with Data Exploration
