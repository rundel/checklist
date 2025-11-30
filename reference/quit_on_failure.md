# Quit on Failure

Evaluate the given expression and if any of the returned values are
`FALSE` then exit with status 1.

## Usage

``` r
quit_on_failure(expr, n_br = 1)
```

## Arguments

- expr:

  Expression returning a logical vector

- n_br:

  Number of leading and trailing blank lines to print

## Value

expr

## Details

This is needed when using `check_*` functions within a continuous
integration pipeline to signal that a step failed.
