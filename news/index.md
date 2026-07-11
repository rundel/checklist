# Changelog

## checklist 0.2.0

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
