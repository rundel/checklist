# checklist 0.2.0

* The example assignments in `inst/examples/` now use Quarto (`qmd`) documents instead of R Markdown, and an example GitHub Actions workflow is included in `inst/templates/`.

* Renamed the `glob` argument to `regexp` in `find_pkgs()`, `missing_pkgs()`, `install_missing_pkgs()`, and the `check_*_pkgs()` functions; file selection now uses a regular expression.

* Removed the unused `full` argument from `check_allowed_pkgs()`, `check_disallowed_pkgs()`, and `check_required_pkgs()`.

* Fixed `quit_on_failure()` so that a logical vector of all `TRUE` values no longer exits with an error status.

* Added examples and return value documentation for all exported functions.

# checklist 0.1.1

* Added `handle_error()` to help manage the results of `check_rmd_renders()` and `check_qmd_renders()`.

* Switch from using `renv` to `pak` for scanning files for dependencies.

# checklist 0.1.0

* Initial version of checklist.

* Added a `NEWS.md` file to track changes to the package.
