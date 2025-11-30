# Check for allowed or disallowed package dependencies within a project or directory using `pak::scan_deps()`.

Check for allowed or disallowed package dependencies within a project or
directory using
[`pak::scan_deps()`](https://pak.r-lib.org/reference/scan_deps.html).

## Usage

``` r
installed_pkgs()

missing_pkgs(
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  recurse = TRUE
)

install_missing_pkgs(
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  recurse = TRUE,
  ...
)

find_pkgs(
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  full = FALSE,
  recurse = TRUE
)

check_allowed_pkgs(
  pkgs,
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  full = FALSE,
  recurse = TRUE
)

check_disallowed_pkgs(
  pkgs,
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  full = FALSE,
  recurse = TRUE
)

check_required_pkgs(
  pkgs,
  dir = here::here(),
  glob = "*.R$|*.r$|*.Rmd$|*.rmd$|*.Rnw$|*.rnw|*.Qmd|*.qmd$",
  full = FALSE,
  recurse = TRUE
)
```

## Arguments

- dir:

  Directory to search.

- glob:

  File types to search for, defaults to `R`, `Rmd`, and `Rnw` files.

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

## Functions

- `installed_pkgs()`: Returns a vector of installed packages.

- `missing_pkgs()`: Returns a vector of packages found by `find_pkgs`
  that are not currently installed.

- `install_missing_pkgs()`: Installs missing packages found by
  `missing_pkgs`.

- `find_pkgs()`: Find all of the packages used within a project using
  renv.

- `check_allowed_pkgs()`: Check that only the allowed packages are used

- `check_disallowed_pkgs()`: Check if any disallowed packages are used

- `check_required_pkgs()`: Check that the required packages are used
