---
title: "Intro to R Workshop Book"
author: "Shaun Jackson, Marissa Chemotti"
date: "2019-07-17"
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

## Fundamental Concepts: Objects

An object is an entity that carries information.

In R, objects are the fundamental foundation to storing data, and manipulating it.

- R organizes the storage of data with datatypes. Which are different types of objects. 
- It also organizes the manipulation of data with functions, which perform operations on your data.

As we go over the most important datatypes in R, keep in mind the context- these are the pieces that allow us to store, and manipulate information for our needs.

## Datatypes

You can think of these datatypes like a pyramid of information.

- The bottom of the pyramid, the foundation, are the datatypes:
    - Numeric 
    - Character
    - Logical

- The middle of the pyramid consists of
    - Vectors (holding multiple values a single datatype in level 1)
    - Factors (holding multiple values of a single datatype but with additional attributes in level 1)

- The top of the pyramid consists of
    - Lists (flexible storage of both level 1 and 2 of the  pyramid)
    - Dataframes (rows and columns of vectors)
    
- Another name for a datatype is a class

We will talk about each datatype in this section.

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

Remember how objects are entities that hold information?

A function is also an object, that holds information about how to manipulate your data if used.

A function consists of 3 pieces:

- Input
- Body
- Output

In the previous section, we have already made use of functions. For example, the `class()` function is a function if you see `()` after a variable name.

- The **input** is any of the datatypes we've talked about
- The  **body** determines which type of datatype it is- a.k.a it's class
- The **output** returns the type of class the input is.
    
Other functions we  have already used:

- `c()`, 
    - takes in multiple values of one datatype as **input**, 
    - the **body** converts the values to a vector, 
    - and **outputs** a vector
- `list()`, 
    - takes in vectors as **input**, 
    - the **body** converts the vectors to a list, 
    - and **outputs** a list
- `data.frame()`, 
    - takes in vectors as **input**, 
    - the **body** converts the vectors to a dataframe,
    - and  **outputs** a data.frame


Now that we've covered fundamental R objects, we can begin the fun stuff- starting with Data Exploration
