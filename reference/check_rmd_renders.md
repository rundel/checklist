# Check an Rmd file renders using rmarkdown

Check an Rmd file renders using rmarkdown

## Usage

``` r
check_rmd_renders(file, install_missing = FALSE, update_packages = FALSE, ...)
```

## Arguments

- file:

  Path of an Rmd file

- install_missing:

  Should any missing packages be installed. Default `FALSE`.

- update_packages:

  Should installed packages be updated before rendering. Default
  `FALSE`.

- ...:

  Additional arguments to pass to `render()`
