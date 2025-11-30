# Handle runtime errors

Evaluates the given expression and then runs the `on_success`,
`on_error`, or `on_warning` expressions depending on the result of the
initial evaluation.

## Usage

``` r
handle_error(
  expr,
  on_success = {
 },
  on_error = {
 },
  on_warning = {
 },
  finally = {
 }
)
```

## Arguments

- expr:

  Expression to evaluate

- on_success:

  Expression to evaluate if `expr` succeeds

- on_error:

  Expression to evaluate if `expr` generates an error

- on_warning:

  Expression to evaluate if `expr` generates a warning

- finally:

  Expression to evaluate after `expr` and `on_success` or `on_error` or
  `on_warning`, usually used for cleanup.

## Value

Invisible result of `expr` if it succeeds, otherwise the error or
warning object.
