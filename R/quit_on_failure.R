#' Quit on Failure
#'
#' Evaluate the given expression and if any of the returned values are `FALSE` then
#' exit with status 1.
#'
#' This is needed when using `check_*` functions within a continuous integration pipeline
#' to signal that a step failed.
#'
#' @param expr Expression returning a logical vector
#' @param n_br Number of leading and trailing blank lines to print
#'
#' @return expr
#' @export
#'
quit_on_failure = function(expr, n_br = 1) {
  cat(rep("\n", n_br))

  force(expr) # evaluate the expression

  if (any(!isTRUE(expr))) { # Fail for *any* non-TRUE value
    cat(rep("\n", n_br))
    quit(save = "no", status = 1, runLast = FALSE)
  }

  invisible(expr)
}


#' Handle runtime errors
#'
#' Evaluates the given expression and then runs the `on_success`, `on_error`, or `on_warning`
#' expressions depending on the result of the initial evaluation.
#'
#' @param expr Expression to evaluate
#' @param on_success Expression to evaluate if `expr` succeeds
#' @param on_error Expression to evaluate if `expr` generates an error
#' @param on_warning Expression to evaluate if `expr` generates a warning
#' @param finally Expression to evaluate after `expr` and `on_success` or `on_error` or `on_warning`,
#' usually used for cleanup.
#'
#' @return Invisible result of `expr` if it succeeds, otherwise the error or warning object.
#'
#' @export
#'
handle_error = function(expr, on_success = {}, on_error = {}, on_warning = {}, finally = {}) {
  invisible(
    tryCatch({
      res = expr
      on_success
      res
    }, error = function(e) {
      on_error
      e
    }, warning = function(w) {
      on_warning
      w
    }, finally = {
      finally
    })
  )
}
