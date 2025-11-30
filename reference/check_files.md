# Check for allowed or disallowed files in a project or directory

Check for allowed or disallowed files in a project or directory

## Usage

``` r
find_files(
  files,
  dir = here::here(),
  all = FALSE,
  recurse = TRUE,
  type = c("file", "directory", "any"),
  regex = FALSE,
  invert = FALSE
)

check_allowed_files(
  files,
  dir = here::here(),
  all = FALSE,
  recurse = TRUE,
  type = c("file", "directory", "any"),
  regex = FALSE
)

check_disallowed_files(files, dir = here::here(), regex = FALSE)

check_required_files(files, dir = here::here())
```

## Arguments

- files:

  Character vector of allowed file names

- dir:

  Directory to check

- all:

  If `TRUE` include hidden files

- recurse:

  If `TRUE` recurse fully, if a positive number the number of levels to
  recurse

- type:

  File type to return, one of "file", "directory", or "any"

- regex:

  If `TRUE` use `allowed_files` as a regular expression otherwise assume
  wildcard (glob) patterns

- invert:

  If `TRUE` return files which do *not* match

## Functions

- `find_files()`: Find all files that match the given pattern (glob or
  regex) within the given directory

- `check_allowed_files()`: Check that only the allowed file(s) exist

- `check_disallowed_files()`: Check if any disallowed file(s) exist

- `check_required_files()`: Check that the required file(s) exist
