## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a new submission.

* There is a note about the hidden file `inst/examples/hw1/.hidden`.
  This file is intentionally included as it is used to test and
  demonstrate functionality around detecting hidden files.

## Additional comments

* `quit_on_failure()` calls `quit()`. This is the documented purpose of
  the function (signaling a failed check from a noninteractive script,
  e.g. in a continuous integration pipeline). It is never called in
  examples or vignettes, and in tests it is only invoked inside a
  separate `callr` subprocess so the session running the checks is
  never terminated.

* `install_missing_pkgs()` and `update_installed_pkgs()` install or
  update packages. This is the documented purpose of these functions
  and they are never run in examples, tests, or vignettes.

* The examples for the `check_*_pkgs()` family are wrapped in \dontrun{}
  because `pak::scan_deps()` runs in a subprocess that requires a writable
  package cache directory, which cannot be guaranteed in the example
  checking environment. This functionality is fully exercised by the
  package tests, which redirect the cache to the session temp directory.

* The examples for `check_rmd_renders()` and `check_qmd_renders()` are
  wrapped in \dontrun{} because rendering writes output next to the
  input document (for the shipped example files this would be inside
  the installed package library) and requires pandoc or the Quarto CLI,
  which are not guaranteed to be available. Rendering is exercised by
  the package tests when these tools are present.
