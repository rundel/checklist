#' Quit on Failure
#'
#' Evaluate the given expression and if any of the returned values are `FALSE` then
#' exit with status 1.
#'
#' This is needed when using `check_*` functions within a continuous integration pipeline
#' to signal that a step failed.
#'
#' @param expr Expression returning a logical vector
#'
#' @return expr
#' @export
#'
quit_on_failure = function(expr) {
  if (any(!isTRUE(expr))) { # Fail for *any* non-TRUE value
    quit(save = "no", status = 1, runLast = FALSE)
  }

  invisible(expr)
}
