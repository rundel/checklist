
Statistical Programming - Homework 0
-------------

<br/>

![fizz buzz](fizzbuzz.png?raw=true)

## Background

The FizzBuzz test is a common programming interview question used to establish if a candidate can actually program in a language that they claim experience in.

The problem statement is as follows:

> "Write a program that given a list of numbers as input, prints each number on their own line. But for multiples of three prints "Fizz" instead of the number and for the multiples of five prints "Buzz". For numbers which are multiples of both three and five prints "FizzBuzz"."

<br/>

## Task 1 - Implement FizzBuzz 

Your goal here is to implement FizzBuzz as a generalized function in R called `fizzbuzz`. Your `fizzbuzz` function should conform to the description provided above in terms of output, but should accept an integer argument (which can either be a scalar or vector). As such, your function should correctly print `Fizz`, `Buzz`, `FizzBuzz`, or the actual number for each integer supplied on a separate line. You should program defensively - validate any input and make sure that you have a sane response to any invalid input. A detailed list or requirements is included below.

You must also include a write up of your implementation that broadly describes how you approached the problem and constructed your solution (think something along the lines of the methods section of a journal article). 

This is not a terribly complex or difficult task, and solutions in R and many other languages are easily Googleable - the point of this exercise is to get use to the workflow and tools we will be using in this class. This includes RStudio, RMarkdown, git, GitHub, etc. - so use this ungraded homework as opportunity to familiarize yourself and get comfortable with these tools as we will be using them throughout the rest of the semester.

Detailed requirements for input validation:
* Input must be a numeric vector (either double or integer)
* If input is a double then all values must be coercible to integer without rounding or truncating (i.e. 5 or 5.0 should be allowed but 5.1 should not)
* All input values must be >=0
* All input values must be finite
* An invalid input values should immediately result in an appropriate error message

<br/>

## Task 2 - FizzBuzz validation

Test if your FizzBuzz function displays the correct output for a variety of inputs, make sure to show what happens for both good and bad input. Some sample test cases have been provided in the template, feel free to add additional test cases you think are interesting / useful.

<br/><br/>

## Submission and Grading

This homework will not be graded however, you are encouraged to complete the assignment as an individual and to keep everything (code, write ups, etc.) on your personal repository (commit & push early and often). 

The final product for this assignment should be a single Rmd document (a template of which is provided in your repo) that contains all code and text for the tasks described above. This document should be clearly and cleanly formated and present all of your results. Style and formating will count for future assignments, so please take the time to make sure everything looks good and your text and code are properly formated. 

In this class we will not be enforcing any particular coding style, however it is important that the code you produce is *readable* and *consistent* in its formating. There are several R style guides online, e.g. from [Google](https://google.github.io/styleguide/Rguide.xml) and from the [tidyverse team](https://style.tidyverse.org/) that are a good place to start.

<br/>
