#' Check for allowed or disallowed package dependencies within a project or directory using `pak::scan_deps()`.
#'
#' @param pkgs Character vector of package names
#' @param dir Directory to search.
#' @param regexp Regular expression used to select files, defaults to matching
#' `R`, `Rmd`, `Rnw`, and `qmd` files (and their case variants).
#' @param full Should the full data frame of dependencies be returned or just a vector of package names.
#' @param recurse Should directory be recursively explored (i.e. match files in subdirectories)
#' @param ... Additional arguments passed to [install.packages()].
#'
#' @return `installed_pkgs()`, `missing_pkgs()`, and `find_pkgs()` return a
#' character vector of package names (`find_pkgs()` returns a data frame of
#' dependency details when `full = TRUE`). `install_missing_pkgs()` and
#' `update_installed_pkgs()` are called for their side effect of installing
#' or updating packages and return `NULL` or the result of
#' [pak::pkg_install()] invisibly. The `check_*` functions return `TRUE` or
#' `FALSE` invisibly, indicating whether the check passed.
#'
#' @examples
#' \dontrun{
#' dir = system.file("examples/package", package = "checklist")
#'
#' find_pkgs(dir)
#' missing_pkgs(dir)
#'
#' check_allowed_pkgs(c("dplyr", "ggplot2"), dir)
#' check_disallowed_pkgs("nlme", dir)
#' check_required_pkgs("dplyr", dir)
#' }
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
missing_pkgs = function(dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", recurse = TRUE) {
  needed = find_pkgs(dir = dir, regexp = regexp, full = FALSE, recurse = recurse)
  installed = installed_pkgs()

  setdiff(needed, installed)
}

#' @describeIn check_pkgs Installs missing packages found by `missing_pkgs`.
#' @export
install_missing_pkgs = function(dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", recurse = TRUE, ...) {
  needed = missing_pkgs(dir = dir, regexp = regexp, recurse = recurse)
  utils::install.packages(pkgs = needed, ...)
}

update_refs = function(pkgs, available = NULL) {
  col = function(name) {
    if (is.null(pkgs[[name]])) rep(NA_character_, nrow(pkgs))
    else pkgs[[name]]
  }

  refs = col("remotepkgref")

  # packages installed from GitHub by remotes record Remote* fields
  # in their DESCRIPTION but not a RemotePkgRef
  user = col("remoteusername")
  repo = col("remoterepo")
  gh = is.na(refs) & col("remotetype") %in% "github" & !is.na(user) & !is.na(repo)
  refs[gh] = paste0(user[gh], "/", repo[gh])

  refs[is.na(refs)] = pkgs$package[is.na(refs)]

  # base packages ship with R and cannot be reinstalled from a repository
  refs = refs[!col("priority") %in% "base"]

  # a plain name ref that is not available from the configured repositories
  # (e.g. a package installed from a local tarball) fails pak's resolution
  # and aborts the entire update
  if (!is.null(available)) {
    plain = !grepl("::|/|@", refs)
    refs = refs[!plain | refs %in% available]
  }

  refs
}

#' @describeIn check_pkgs Updates installed packages using [pak::pkg_install()].
#' Packages installed from a remote such as GitHub are updated from that same
#' source, others are updated from the configured repositories. Packages that
#' are not available from a repository and were not installed from a remote
#' (e.g. packages installed from a local source tarball) are skipped, provided
#' the repository index can be retrieved via [utils::available.packages()].
#' @export
update_installed_pkgs = function() {
  available = tryCatch(
    rownames(utils::available.packages()),
    error = function(e) NULL
  )

  refs = update_refs(pak::pkg_list(), available = available)

  if (length(refs) == 0)
    return(invisible(NULL))

  invisible(pak::pkg_install(refs, upgrade = TRUE))
}

#' @describeIn check_pkgs Find all of the packages used within a project using `pak::scan_deps()`.
#' @export
find_pkgs = function(dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", full = FALSE, recurse = TRUE) {
  files = fs::dir_ls(path = dir, regexp = regexp, recurse = recurse,  type = "file")
  dir = fs::path_real(dir)
  files = fs::path_real(files)

  deps = pak::scan_deps(path = dir, root = dir)[]
  deps = deps[fs::path_real(fs::path(dir, deps$path)) %in% files, ]
  deps = unique(deps)

  if (!full)
    deps = unique(deps$package)

  deps
}


#' @describeIn check_pkgs Check that only the allowed packages are used
#' @export
check_allowed_pkgs = function(pkgs, dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, regexp = regexp, full = FALSE, recurse = recurse)

  problems = used_pkgs[!used_pkgs %in% pkgs]

  if (length(problems) != 0) {
    list_items("Disallowed packages used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}


#' @describeIn check_pkgs Check if any disallowed packages are used
#' @export
check_disallowed_pkgs = function(pkgs, dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, regexp = regexp, full = FALSE, recurse = recurse)

  problems = used_pkgs[used_pkgs %in% pkgs]

  if (length(problems) != 0) {
    list_items("Disallowed packages used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}

#' @describeIn check_pkgs Check that the required packages are used
#' @export
check_required_pkgs = function(pkgs, dir = here::here(), regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$", recurse = TRUE) {
  used_pkgs = find_pkgs(dir = dir, regexp = regexp, full = FALSE, recurse = recurse)

  problems = pkgs[!pkgs %in% used_pkgs]

  if (length(problems) != 0) {
    list_items("The following required packages were not used:", problems)
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}





