#' Check for allowed or disallowed files in a directory
#'
#' @param files Character vector of allowed file names
#' @param dir Directory to check
#' @param all If `TRUE` include hidden files
#' @param recurse If `TRUE` recurse fully, if a positive number
#' the number of levels to recurse.
#' @param type File type to return, one of "file", "directory", or "any".
#' @param regexp If `TRUE` use `allowed_files` as regexp patterns,
#' otherwise assume wildcard (glob) patterns
#'
#' @name check_files
NULL

check_files = function(files, dir, all, recurse, type, regexp, invert) {
  f = fs::dir_ls(path = dir, all = all, recurse = recurse, type = type)

  if (regexp) {
    problems = fs::path_filter(f, regexp = files, invert = invert)
  } else {
    problems = fs::path_filter(f, glob = files, invert = invert)
  }

  if (length(problems != 0)) {
    list_files("Disallowed files found: (please remove the following files)", problems)

    return(invisible(FALSE))
  }

  return(invisible(TRUE))
}

#' @describeIn check_files Check that only the allowed file(s) exist
#' @export
check_allowed_files = function(
  files = "", dir = ".", all = FALSE, recurse = TRUE,
  type = c("file", "directory", "any"), regexp = FALSE
) {
  type = match.arg(type)

  check_files(files, dir, all, recurse, type, regexp, TRUE)
}


#' @describeIn check_files Check if any disallowed file(s) exist
#' @export
check_disallowed_files = function(files = "", dir = ".", regexp = FALSE) {
  check_files(files, dir, all = TRUE, recurse = TRUE, type = "any",
              regexp = regexp, invert = FALSE)
}



#' @describeIn check_files Check that the required file(s) exist
#' @export
check_required_files = function(files = "", dir = ".") {
  f = fs::dir_ls(path = dir, all = TRUE, recurse = TRUE, type = "any")
  missing =  files[!files %in% f]

  if (length(missing != 0)) {
    list_files("Missing the following required files:", missing)

    return(invisible(FALSE))
  }

  return(invisible(TRUE))
}

list_files = function(text, files, sub = NULL, symbol = cli::col_red(cli::symbol$cross), indent = 0) {
  cli::cli_div(theme = list(ul = list("list-style-type" = symbol, "padding-left" = indent)))

  cli::cli_text(text)
  cli::cli_rule()
  cli::cli_ul(files)

  cli::cli_end()
}

