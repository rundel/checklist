## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new submission.

* There is a note about the hidden file `inst/examples/hw1/.hidden`.
  This file is intentionally included as it is used to test and
  demonstrate functionality around detecting hidden files.

## Additional comments

* `quit_on_failure()` calls `quit()`. This is the documented purpose of
  the function (signaling a failed check from a noninteractive script,
  e.g. in a continuous integration pipeline) and it is never called in
  examples, tests, or vignettes.

* `install_missing_pkgs()` installs packages. This is the documented
  purpose of the function and it is never run in examples, tests, or
  vignettes.
