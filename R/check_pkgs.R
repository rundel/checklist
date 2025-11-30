#' Check for allowed or disallowed package dependencies within a project or directory using `pak::scan_deps()`.
#'
#' @param pkgs Character vector of package names
#' @param dir Directory to search.
#' @param glob File types to search for, defaults to `R`, `Rmd`, and `Rnw` files.
#' @param full Should the full data frame of dependencies be returned or just a vector of package names.
#' @param recurse Should directory be recursively explored (i.e. match files in sub directories)
#' @param ... Additional arguments passed to [install.packages()].
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
missing_pkgs = function(dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", recurse = TRUE) {
  needed = find_pkgs(dir = dir, glob = glob, full = FALSE, recurse = recurse)
  installed = installed_pkgs()

  setdiff(needed, installed)
}

#' @describeIn check_pkgs Installs missing packages found by `missing_pkgs`.
#' @export
install_missing_pkgs = function(dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", recurse = TRUE, ...) {
  needed = missing_pkgs(dir = dir, glob = glob, recurse = recurse)
  utils::install.packages(pkgs = needed, ...)
}

#' @describeIn check_pkgs Find all of the packages used within a project using renv.
#' @export
find_pkgs = function(dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", full = FALSE, recurse = TRUE) {
  files = fs::dir_ls(path = dir, glob = glob, recurse = recurse,  type = "file")
  files = fs::path_real(files) # need abs paths for renv
  dir = fs::path_real(dir)

  if (length(files) == 0 && recurse)
    files = dir

  deps = unique(pak::scan_deps(path = files, root = dir)[])

  if (!full)
    deps = unique(deps$package)

  deps
}


#' @describeIn check_pkgs Check that only the allowed packages are used
#' @export
check_allowed_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", full = FALSE, recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE, recurse = recurse)

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
check_disallowed_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", full = FALSE, recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE, recurse = recurse)

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
check_required_pkgs = function(pkgs, dir = here::here(), glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$", full = FALSE, recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, glob = glob, full = FALSE, recurse = recurse)

  problems = pkgs[!pkgs %in% used_pkgs]

  if (length(problems != 0)) {
    list_items("The following required packages were not used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}





