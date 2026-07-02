# Check for allowed or disallowed package dependencies within a project or directory using `pak::scan_deps()`.

Check for allowed or disallowed package dependencies within a project or
directory using
[`pak::scan_deps()`](https://pak.r-lib.org/reference/scan_deps.html).

## Usage

``` r
installed_pkgs()

missing_pkgs(
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  recurse = TRUE
)

install_missing_pkgs(
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  recurse = TRUE,
  ...
)

find_pkgs(
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  full = FALSE,
  recurse = TRUE
)

check_allowed_pkgs(
  pkgs,
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  recurse = TRUE
)

check_disallowed_pkgs(
  pkgs,
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  recurse = TRUE
)

check_required_pkgs(
  pkgs,
  dir = here::here(),
  regexp = "[.](R|r|Rmd|rmd|Rnw|rnw|Qmd|qmd)$",
  recurse = TRUE
)
```

## Arguments

- dir:

  Directory to search.

- regexp:

  Regular expression used to select files, defaults to matching `R`,
  `Rmd`, `Rnw`, and `qmd` files (and their case variants).

- recurse:

  Should directory be recursively explored (i.e. match files in sub
  directories)

- ...:

  Additional arguments passed to
  [`install.packages()`](https://rdrr.io/r/utils/install.packages.html).

- full:

  Should the full data frame of dependencies be returned or just a
  vector of package names.

- pkgs:

  Character vector of package names

## Value

`installed_pkgs()`, `missing_pkgs()`, and `find_pkgs()` return a
character vector of package names (`find_pkgs()` returns a data frame of
dependency details when `full = TRUE`). `install_missing_pkgs()` is
called for its side effect of installing packages and returns `NULL`
invisibly. The `check_*` functions return `TRUE` or `FALSE` invisibly,
indicating whether the check passed.

## Functions

- `installed_pkgs()`: Returns a vector of installed packages.

- `missing_pkgs()`: Returns a vector of packages found by `find_pkgs`
  that are not currently installed.

- `install_missing_pkgs()`: Installs missing packages found by
  `missing_pkgs`.

- `find_pkgs()`: Find all of the packages used within a project using
  [`pak::scan_deps()`](https://pak.r-lib.org/reference/scan_deps.html).

- `check_allowed_pkgs()`: Check that only the allowed packages are used

- `check_disallowed_pkgs()`: Check if any disallowed packages are used

- `check_required_pkgs()`: Check that the required packages are used

## Examples

``` r
if (FALSE) { # \dontrun{
dir = system.file("examples/package", package = "checklist")

find_pkgs(dir)
missing_pkgs(dir)

check_allowed_pkgs(c("dplyr", "ggplot2"), dir)
check_disallowed_pkgs("nlme", dir)
check_required_pkgs("dplyr", dir)
} # }
```
