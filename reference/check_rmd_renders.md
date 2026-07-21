# Check an Rmd file renders using rmarkdown

Check an Rmd file renders using rmarkdown

## Usage

``` r
check_rmd_renders(
  file,
  install_missing = FALSE,
  update_packages = FALSE,
  output_dir = NULL,
  quiet = TRUE,
  ...
)
```

## Arguments

- file:

  Path of an Rmd file

- install_missing:

  Should any missing packages be installed. Default `FALSE`.

- update_packages:

  Should installed packages be updated, using
  [`update_installed_pkgs()`](https://rundel.github.io/checklist/reference/check_pkgs.md),
  before rendering. Default `FALSE`.

- output_dir:

  Directory for the rendered output, passed to
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  The default (`NULL`) renders next to the input file.

- quiet:

  Should knitting and pandoc output be suppressed. Default `TRUE`.

- ...:

  Additional arguments to pass to `render()`

## Value

The path of the rendered output file, as returned by
[`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).

## Examples

``` r
if (FALSE) { # \dontrun{
check_rmd_renders("hw1.Rmd")
} # }
```
