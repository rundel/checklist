# Changelog

## checklist 0.2.0

- Added
  [`update_installed_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  which uses
  [`pak::pkg_install()`](https://pak.r-lib.org/reference/pkg_install.html)
  to update installed packages, including packages installed from
  GitHub.
  [`check_rmd_renders()`](https://rundel.github.io/checklist/reference/check_rmd_renders.md)
  and
  [`check_qmd_renders()`](https://rundel.github.io/checklist/reference/check_qmd_renders.md)
  now use it when `update_packages = TRUE`, removing the dependency on
  the remotes package.

- [`quit_on_failure()`](https://rundel.github.io/checklist/reference/quit_on_failure.md)
  now accepts multiple check expressions as separate arguments. Its
  documentation warns against wrapping multiple checks in a braced
  block, which only returns the value of the last expression.

- [`check_rmd_renders()`](https://rundel.github.io/checklist/reference/check_rmd_renders.md)
  gains `output_dir` and `quiet` arguments; previously passing either
  through `...` produced an error about duplicated arguments.

- File names and glob patterns containing regular expression
  metacharacters (e.g. `+` or `{`) are now matched literally by
  [`find_files()`](https://rundel.github.io/checklist/reference/check_files.md)
  and the `check_*_files()` functions, and flagged names containing
  braces are displayed correctly instead of being interpreted as cli
  expressions.

- [`check_required_files()`](https://rundel.github.io/checklist/reference/check_files.md)
  now only accepts regular files, so a directory with a matching name no
  longer satisfies the check.

- With `install_missing = TRUE`,
  [`check_rmd_renders()`](https://rundel.github.io/checklist/reference/check_rmd_renders.md)
  and
  [`check_qmd_renders()`](https://rundel.github.io/checklist/reference/check_qmd_renders.md)
  now scan only the named file for dependencies rather than any file
  whose name ends with the same suffix.

- The example GitHub Actions workflow in `inst/templates/` now
  authenticates GitHub installs with the workflow’s `GITHUB_TOKEN` and
  requests read-only permissions.

- The example assignments in `inst/examples/` now use Quarto (`qmd`)
  documents instead of R Markdown, and an example GitHub Actions
  workflow is included in `inst/templates/`.

- Renamed the `glob` argument to `regexp` in
  [`find_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  [`missing_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  [`install_missing_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  and the `check_*_pkgs()` functions; file selection now uses a regular
  expression.

- Removed the unused `full` argument from
  [`check_allowed_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  [`check_disallowed_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  and
  [`check_required_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md).

- Fixed
  [`quit_on_failure()`](https://rundel.github.io/checklist/reference/quit_on_failure.md)
  so that a logical vector of all `TRUE` values no longer exits with an
  error status.

- [`find_files()`](https://rundel.github.io/checklist/reference/check_files.md)
  now treats an empty `files` vector as matching nothing (or everything
  when `invert = TRUE`), so
  [`check_disallowed_files()`](https://rundel.github.io/checklist/reference/check_files.md)
  with no patterns passes instead of reporting every file.

## checklist 0.1.1

- Added
  [`handle_error()`](https://rundel.github.io/checklist/reference/handle_error.md)
  to help manage the results of
  [`check_rmd_renders()`](https://rundel.github.io/checklist/reference/check_rmd_renders.md)
  and
  [`check_qmd_renders()`](https://rundel.github.io/checklist/reference/check_qmd_renders.md).

- Switch from using `renv` to `pak` for scanning files for dependencies.

## checklist 0.1.0

- Initial version of checklist.
