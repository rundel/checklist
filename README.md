
<!-- README.md is generated from README.Rmd. Please edit that file -->

checklist
=========

<!-- badges: start -->
<!-- badges: end -->

The goal of this package is to provide a variety of tools for checking
RStudio project based assignments. These tools are not specifically
about testing for the correctness of an assignment, but rather about
testing the process and reproducibility of that assignment. For example:

-   does the project compile (knit)
-   does the project only include the files want
-   does the include Rmd document have the correct structure
-   and many more

Installation
------------

<!--
You can install the released version of checklist from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("checklist")
```
-->

You can install the the development version of this package from
[GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("rundel/checklist")

Example
-------

This is a basic example which shows you how to solve a common problem:

    library(checklist)
    ## basic example code
