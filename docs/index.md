---
title: "Intro to R Workshop Book"
author: "Shaun Jackson, Marissa Chemotti"
date: "7/3/2019"
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

# Part 1: Introduction and Data Exploration

<hr />
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