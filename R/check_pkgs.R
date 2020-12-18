#' Check for allowed or disallowed package dependencies within a project or directory
#'
#' @param pkgs Character vector of package names
#' @param dir Directory to search.
#' @param glob File types to search for, defaults to `R`, `Rmd`, and `Rnw` files.
#' @param full Should the full data frame of dependencies be returned or just a vector of package names.
#'
#' @name check_pkgs
NULL

#' @describeIn check_pkgs Returns a vector of installed packages.
#' @export
installed_pkgs = function() {
  rownames( utils::installed.packages() )
}

#' @describeIn check_pkgs Returns a vector of packages found by `find_pkgs` that are not currently installed.
#' @export
missing_pkgs = function(dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw$") {
  needed = find_pkgs(dir = dir, glob = glob, full = FALSE)
  installed = installed_pkgs()

  setdiff(needed, installed)
}

#' @describeIn check_pkgs Find all of the packages used within a project using renv.
#' @export
find_pkgs = function(dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw$", full = FALSE) {
  files = fs::dir_ls(path = dir, glob = glob, recurse = TRUE,  type = "file")
  files = fs::path_real(files)

  if (length(files) == 0)
    files = dir

  deps = unique(renv::dependencies(files, root = dir, progress = FALSE, errors = "fatal"))

  if (!full)
    deps = unique(deps$Package)

  deps
}


#' @describeIn check_pkgs Check that only the allowed packages are used
#' @export
check_allowed_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw$", full = FALSE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE)

  problems = used_pkgs[!used_pkgs %in% pkgs]

  if (length(problems != 0)) {
    list_items("Disallowed packages used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}


#' @describeIn check_pkgs Check if any disallowed packages are used
#' @export
check_disallowed_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw$", full = FALSE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE)

  problems = used_pkgs[used_pkgs %in% pkgs]

  if (length(problems != 0)) {
    list_items("Disallowed packages used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}

#' @describeIn check_pkgs Check that the required packages are used
#' @export
check_required_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw$", full = FALSE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE)

  problems = pkgs[!pkgs %in% used_pkgs]

  if (length(problems != 0)) {
    list_items("The following required packages were not used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}





