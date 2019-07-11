<div style="margin-bottom:100px;">
Introduction
============

<hr />
The aim of this document is to present you with the bare minimum
essentials to get you up and running with R. One of the toughest parts
about learning a programming language is feeling overwhelmed by the
abundance of material to learn.

By giving you an overview of the most useful functions, in the lens of a
real dataset, we hope that you can apply these concepts to your own
data.

As with everything else, the best way to learn R is through
**consistent** practice with a real world project.

<hr />
Goals of this Document
----------------------

By the end of this document, you will be able to:

1.  Learn about the fundamental R Datatypes
2.  Read a CSV file into your R environment
3.  Write from your R environment to a CSV file
4.  Explore different attributes of a dataframe
    -   column names
    -   row names
    -   more with `attributes()`
    -   Subset a dataframe by rows and columns
    -   Filter a dataframe by the values of a column
5.  Use two data exploration and cleaning functions
    -   Frequency counts of unique values with `table()`
    -   Search for any duplicates within your data with `duplicated()`

</div>
<div style="margin-bottom:100px;">
Datatypes
=========

<hr />
Numeric, Logical, Character, Factor
-----------------------------------

Lists, Vectors, Matrices
------------------------

Dataframes
----------

</div>
<div style="margin-bottom:100px;">
Reading in Data
===============

<hr />
Read CSV Files
--------------

-   store the filepath within a character variable
-   the filepath could be relative to your working directory, or
    absolute
-   `read.csv` is a function that could read CSV files into your R
    environment

<!-- -->

    # define relative filepath
    pathToAdosFile <- './datasets/adosm1.csv'

    # Use read.csv() and filepath variable as first argument to function
    adosm1 <- read.csv(pathToAdosFile, 
                       stringsAsFactors = FALSE)
    # stringsAsFactors is an optional argument that tells read.csv to
    # not turn a string column into a R factor variable

    # adosm1 is now considered a datraframe

`View()`
--------

-   To view your dataframe call the `View()` function.
-   Note the capital **V**iew().

<!-- -->

    View(adosm1)

See Dataframe attributes
------------------------

-   display column names `names()`
-   display rownames with `row.names()`
-   see all attributes with `attributes(dataframe)`

<!-- -->

    # display column names
    # names(dataframe), we will use our adosm1 dataframe
    # wrap function with head() to show first 5
    head(names(adosm1))

    ## [1] "id"                "visit"             "cbe_36"           
    ## [4] "recruitment_group" "gender"            "ados_version"

    # display rownames, wrap function with head() to show first 5
    head(row.names(adosm1))

    ## [1] "1" "2" "3" "4" "5" "6"

</div>
<div style="margin-bottom:100px;">
Writing Data
============

<hr />
`write.csv`
-----------

-   We can write data from our R environment to a CSV file with
    `write.csv`
-   `write.csv` takes in a dataframe within our R environment, as the
    first parameter
-   the second parameter is the location and filename to write it to.

<!-- -->

    # write.csv(adosm1, 'datasets/practice write csv ados.csv', row.names = FALSE)

`data.table::fwrite()`
----------------------

-   One you are comfortable with write.csv, I would suggest looking into
    the `fwrite` function within data.table. It is much much faster and
    more efficient.

</div>
<div style="margin-bottom:100px;">
Subsetting Data
===============

<hr />
Subset by columns
-----------------

-   In our case, adosm1 is within our R environment, so we would call
    -   `adosm1[namesOfRows, namesOfColumns]`
    -   Note: it is best practice to access columns by their names, not
        their numbers

<!-- -->

    # To access the id column, we would write
    adosm1[, "id"]

    # To access id and visit
    adosm1[, c("id", "visit")]

    # in order to make code less verbose, when accessing one column, we use
    # the $ operator
    # to access the id column
    adosm1$id

Subset by rows
--------------

-   We could similarly access rows by rownames or row numbers
    -   `adosm1[c(1, 2, 5), ]`

<!-- -->

    # access 1st, 2nd, and 5th rows
    adosm1[c(1, 2, 5), ]

Subset by rows and columns
--------------------------

    # access 1st, 2nd, and 5th rows, within id and visit columns
    adosm1[c(1, 2, 5), c("id", "visit")]

</div>
<div style="margin-bottom:100px;">
Filtering a dataframe: Subsetting part 2
========================================

<hr />
Subset with a logical vector
----------------------------

-   What is very powerful in this is we could subset a dataframe in
    order to answer specific questions
-   This is done by using a **logical vector** to subset or slice a
    dataframe

Subset logical vector example
-----------------------------

    # To Filter for all visits at 36 months:
    # Create logical vector
    visits36mo <- adosm1$visit == "36"

    # use  our visits36mo  logical vector to filter dataframe
    adosm1[visits36mo, ]  # returns  a dataframe of all visits at 36mo

    adosm1[visits36mo, "id"] # returns all the ids with a visit at 36mo

    # returns alg and version at 36 months
    adosm1[visits36mo, c("ados_algorithm", "ados_version")] 

</div>
Functions to explore data
=========================

-   Out of all the functions to explore a dataframe, I personally find
    -   `table()`
    -   `duplicated()`

to be the most useful

Example `table()`
-----------------

    # To get a frequency count of  all unique values,
    # we use the  table()

    # table() takes in 1 or more vectors as input
    # since every dataframe column could be considered a vector (or list)
    # we could check for every unique visit with freq counts with
    table(adosm1$visit)

    ## 
    ##  18  21  24  30  36 
    ## 445   5 396  32 146

    # we could check  for every unique combination of vectors by 
    # providing multiple vector inputs

    # To see every unique combination of visit and ados algorithm
    table(adosm1$visit, adosm1$ados_algorithm)

    ##     
    ##          few to no words no words some words
    ##   18   3             157       93        192
    ##   21   0               0        2          3
    ##   24   4              65       30        297
    ##   30   0               4        0         28
    ##   36   6               8       20        112

Checking for duplicates: `duplicated()`
---------------------------------------

-   We will first generate a dataframe that has duplicates, to show how
    to detect duplicates by different subgroups

<!-- -->

    dupDf <- data.frame(id = c(1, 1, 2, 2, 3, 3),
                        visit = c('10 months', '20 months',  '10 months', '10 months', '20 months', '20 months'),
                        item1 = c(1, 2, 3, 3, 5, 6))

`duplicated()` explained
------------------------

-   The `duplicated` function returns a logical vector of the duplicates
    that exist in a dataframe.
-   The TRUE values represent the index locations of where a duplicate
    row was found.
-   We could use this logical vector to see where a duplicate exists

`duplicated()` example
----------------------

    duplicateIndices <- duplicated(dupDf)  # store dup vector in variable

    duplicateIndices  # view logical vector of duplicates

    ## [1] FALSE FALSE FALSE  TRUE FALSE FALSE

    dupDf[duplicateIndices, ]

    ##   id     visit item1
    ## 4  2 10 months     3

`Duplicated()` by key variables: id and visit
---------------------------------------------

-   we could check for duplicates by columns that should represent a
    unique combination.
-   in this example: id and visit

<!-- -->

    # to check duplicates by groups
    dupIndGrouped <- duplicated(dupDf[, c("id", "visit")])
    dupDf[dupIndGrouped, ]

    ##   id     visit item1
    ## 4  2 10 months     3
    ## 6  3 20 months     6

<div style="margin-bottom:100px;">
Assignment: adosm2 dataset
==========================

<hr />
Instructions
------------

1.  Read in the adosm2.csv file
2.  What is the frequency count for every unique visit?
3.  What are the ids that exist for the 30 month visit?
4.  Are there duplicates by id and visit?
5.  What is the frequency count of duplicates vs non-duplicates?

</div>
<div style="margin-bottom:300px">
Additional Resources
====================

<hr />
</div>
<div style="margin-bottom:100px">
Solution
========

<hr />
    # 1. Read in the adosm2.csv file
    adosm2Path <- './datasets/adosm2.csv'
    adosm2 <- read.csv(adosm2Path, stringsAsFactors = FALSE)

    # 2. What is the frequency count for every unique visit?
    table(adosm2$visit)

    ## 
    ##  24  30  36 sa1 sa2 
    ##  42  14 469   2   2

    # 3, What are the ids that exist for the 30 month visit?
    adosm2[adosm2$visit == "30", "id"]

    ##  [1]  20  53  57  71  78 104 222 252 304 306 385 444 451 455

    # This works too- adosm2$id[adosm2$visit == "30"]

    # 4. Are there duplicates by id and visit?
    any(duplicated(adosm2[, c("id", "visit")]))

    ## [1] FALSE

    # 5. What are the frequency count of duplicates vs non-duplicates
    table(duplicated(adosm2))

    ## 
    ## FALSE 
    ##   529

</div>
Bonus Material (Optional)
=========================

String Manipulation
-------------------

-   What are the most useful use cases for string manipulation?
    -   Pattern matching: One can easily automate trudging through a
        dataset by hand, by finding patterns within the character
        columns in their dataset
    -   Data cleaning, Are their some mispelled or case sensitive
        datasets? How do we group these cases?

### Regular Expressions

-   To find patterns within data that has characters within it, we use
    **regular expressions**

Regular expressions are expressions that allow one to find patterns.

-   To implement a regular expression in R, we can use the `grep`
    function to find patterns, or `gsub` to both find patterns and
    substitute patterns with another one.

#### grep

-   `grep` is a function that we will use to find patterns in a vector
    of strings
-   the first argument will be the regular expression
-   the second argument will be the vector we are searching within

<!-- -->

    stringVecToSearch <- c('a', 'b', 'c', 'd', 'bad', 'jab')
    regExprPattern <- 'a'
    grep(regExprPattern, stringVecToSearch)  # indices of all strings with  an 'a'

    ## [1] 1 5 6

    # Find patterns that STARTS with a pattern with ^
    regExprPattern <- '^b'
    # in this case, starts with a 'b'
    grep(regExprPattern, stringVecToSearch)

    ## [1] 2 5

    # Find patterns that ENDS with a pattern with $
    regExprPattern <- 'b$'
    # in this case, ends with a b
    grep(regExprPattern, stringVecToSearch)

    ## [1] 2 6

    # If we want to see the values, not the indices of where patterns exist
    grep(regExprPattern, stringVecToSearch, value=TRUE)

    ## [1] "b"   "jab"

#### Grep Applied to a dataframe

    # see all columns that STARTS with ados
    ados_cols <- grep('^ados', names(adosm1), value=TRUE)
    adosm1[, ados_cols]

    # see all rows that have a an ados algorithm of no words
    # grep will return row numbers of where a pattern of no words
    # exists in ados_version
    no_words_vals <- grep('no words', adosm1$ados_version)
    # use row numbers to filter dataframe
    adosm1[no_words_vals, ]

#### gsub

-   gsub can be thought of as using grep to find the patterns, but
    replacing the patterns found with something new.
-   The first argument is the pattern to find
-   The second argument is what to replace with the pattern found
-   The third argument is the vector that holds the pattern to search
    and replace

<!-- -->

    stringVecToSub <- c('id', 'visit', 'ad1', 'ad2', 'ad3', 'ad4')
    gsub('ad', 'ados_', stringVecToSub)

    ## [1] "id"     "visit"  "ados_1" "ados_2" "ados_3" "ados_4"

### String Concatenation

#### paste

#### paste0

#### sprintf

DataFrame Manipulation Extras
-----------------------------

### Rename columns

Programming Constructs
----------------------

### control statements essentials

### if else

### for loops

Vectorization
-------------

### ifelse()

Write Clean Code
----------------

### Max Line Length

### Speak through Code

### A Comment on Comments