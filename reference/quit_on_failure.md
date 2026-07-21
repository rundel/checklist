# Quit on Failure

Evaluates the given check expression(s) and if any of the returned
values are not `TRUE` then exit with status 1.

## Usage

``` r
quit_on_failure(..., n_br = 1)
```

## Arguments

- ...:

  One or more expressions, each returning a logical vector.

- n_br:

  Number of leading blank lines to print before any check output (also
  printed again before exiting on failure).

## Value

The value of the expression (or a list of values when more than one
expression is given), invisibly. If any element of any result is not
`TRUE` the R session is terminated with exit status 1.

## Details

This is needed when using `check_*` functions within a continuous
integration pipeline to signal that a step failed.

Multiple checks must be passed as separate arguments. Do not combine
them in a braced block, as `{ check_a(); check_b() }` only returns the
value of the last expression and the results of the other checks would
be silently ignored.

## Examples

``` r
if (FALSE) { # \dontrun{
quit_on_failure(check_required_files("hw1.Rmd"))

quit_on_failure(
  check_required_files("hw1.Rmd"),
  check_disallowed_files("hw1.html")
)
} # }
```
