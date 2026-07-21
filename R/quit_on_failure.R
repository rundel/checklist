#' Quit on Failure
#'
#' Evaluates the given check expression(s) and if any of the returned values
#' are not `TRUE` then exit with status 1.
#'
#' This is needed when using `check_*` functions within a continuous integration pipeline
#' to signal that a step failed.
#'
#' Multiple checks must be passed as separate arguments. Do not combine them
#' in a braced block, as `{ check_a(); check_b() }` only returns the value of
#' the last expression and the results of the other checks would be silently
#' ignored.
#'
#' @param ... One or more expressions, each returning a logical vector.
#' @param n_br Number of leading blank lines to print before any check output
#' (also printed again before exiting on failure).
#'
#' @return The value of the expression (or a list of values when more than
#' one expression is given), invisibly. If any element of any result is
#' not `TRUE` the R session is terminated with exit status 1.
#'
#' @examples
#' \dontrun{
#' quit_on_failure(check_required_files("hw1.Rmd"))
#'
#' quit_on_failure(
#'   check_required_files("hw1.Rmd"),
#'   check_disallowed_files("hw1.html")
#' )
#' }
#'
#' @export
#'
quit_on_failure = function(..., n_br = 1) {
  cat(strrep("\n", n_br))

  results = list(...)

  ok = vapply(results, function(res) isTRUE(all(res)), logical(1))

  if (!all(ok)) { # Fail for *any* non-TRUE value
    cat(strrep("\n", n_br))
    quit(save = "no", status = 1, runLast = FALSE)
  }

  if (length(results) == 1) invisible(results[[1]])
  else                      invisible(results)
}


#' Handle runtime errors
#'
#' Evaluates the given expression and then runs the `on_success`, `on_error`, or `on_warning`
#' expressions depending on the result of the initial evaluation.
#'
#' @param expr Expression to evaluate
#' @param on_success Expression to evaluate if `expr` succeeds. Evaluated after
#' `expr` completes; conditions it signals are not caught by `on_error` or
#' `on_warning`.
#' @param on_error Expression to evaluate if `expr` generates an error
#' @param on_warning Expression to evaluate if `expr` generates a warning
#' @param finally Expression to evaluate after `expr` and `on_success` or `on_error` or `on_warning`,
#' usually used for cleanup.
#'
#' @return Invisible result of `expr` if it succeeds, otherwise the error or warning object.
#'
#' @examples
#' handle_error(
#'   1 + 1,
#'   on_success = message("success"),
#'   on_error = message("error")
#' )
#'
#' handle_error(
#'   stop("Something went wrong"),
#'   on_success = message("success"),
#'   on_error = message("error")
#' )
#'
#' @export
#'
handle_error = function(expr, on_success = {}, on_error = {}, on_warning = {}, finally = {}) {
  on.exit(finally)

  success = FALSE
  res = tryCatch({
    res = expr
    success = TRUE
    res
  }, error = function(e) {
    on_error
    e
  }, warning = function(w) {
    on_warning
    w
  })

  if (success)
    on_success

  invisible(res)
}
