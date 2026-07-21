#' Check for allowed or disallowed files in a project or directory
#'
#' @param files Character vector of file names or patterns to match
#' (wildcards by default, regular expressions when `regex = TRUE`).
#' Patterns are matched against file paths relative to `dir`, not just
#' file names, so `"data/*.csv"` matches csv files in the `data`
#' subdirectory. Note that `*` also matches `/`, so `"*.csv"` matches
#' csv files at any depth. `check_required_files()` matches file names
#' literally and does not support patterns.
#' @param dir Directory to check
#' @param all If `TRUE` include hidden files
#' @param recurse If `TRUE` recurse fully, if a positive number
#' the number of levels to recurse
#' @param type File type to return, one of "file", "directory", or "any"
#' @param regex If `TRUE` use `files` as regular expressions
#' otherwise assume wildcard (glob) patterns
#' @param invert If `TRUE` return files which do *not* match
#'
#' @return `find_files()` returns a character vector of matching file paths.
#' The `check_*` functions return `TRUE` or `FALSE` invisibly, indicating
#' whether the check passed.
#'
#' @examples
#' dir = system.file("examples/hw1", package = "checklist")
#'
#' find_files("*.qmd", dir)
#'
#' check_allowed_files(c("README.md", "hw1.qmd", "hw1.Rproj"), dir)
#' check_disallowed_files("hw1.md", dir)
#' check_required_files("hw1.pdf", dir)
#'
#' @name check_files
NULL

abs_to_rel_path = function(f, dir) {
  substr(f, nchar(dir)+2, nchar(f))
}

#' @describeIn check_files Find all files that match the given pattern (glob or regex)
#' within the given directory
#' @export
find_files = function(
  files, dir = here::here(), all = FALSE, recurse = TRUE,
  type = c("file", "directory", "any"), regex = FALSE, invert = FALSE
) {
  dir = fs::path_real(dir)
  type = match.arg(type)

  f = fs::dir_ls(path = dir, all = all, recurse = recurse, type = type)
  f = abs_to_rel_path(f, dir)

  if (length(files) == 0) {
    if (invert) return(f)
    else        return(f[0])
  }

  if (!regex)
    files = glob_to_regex(files)

  pat = paste(files, collapse = "|")
  fs::path_filter(f, regexp = pat, invert = invert)
}


check_files = function(files, dir, all, recurse, type, regex, invert) {

  problems = find_files(files = files, dir = dir, all = all,
                        recurse = recurse, type = type,
                        regex = regex, invert = invert)

  if (length(problems) != 0) {
    list_items("Disallowed files found: (please remove the following files)", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}

#' @describeIn check_files Check that only the allowed file(s) exist
#' @export
check_allowed_files = function(
  files, dir = here::here(), all = FALSE, recurse = TRUE,
  type = c("file", "directory", "any"), regex = FALSE
) {
  type = match.arg(type)

  check_files(files = files, dir = dir, all = all,
              recurse = recurse, type = type,
              regex = regex, invert = TRUE)
}


#' @describeIn check_files Check if any disallowed file(s) exist
#' @export
check_disallowed_files = function(files, dir = here::here(), regex = FALSE) {
  check_files(files = files, dir = dir, all = TRUE,
              recurse = TRUE, type = "any",
              regex = regex, invert = FALSE)
}


#' @describeIn check_files Check that the required file(s) exist; file names
#' are matched literally (patterns are not supported)
#' @export
check_required_files = function(files, dir = here::here()) {
  dir = fs::path_real(dir)
  f = fs::dir_ls(path = dir, all = TRUE, recurse = TRUE, type = "file")
  f = abs_to_rel_path(f, dir)

  missing =  files[!files %in% f]

  if (length(missing) != 0) {
    list_items("The following required files are missing:", missing)

    return(invisible(FALSE))
  }

  return(invisible(TRUE))
}



