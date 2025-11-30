# Check a qmd file renders using Quarto

Check a qmd file renders using Quarto

## Usage

``` r
check_qmd_renders(file, install_missing = FALSE, update_packages = FALSE, ...)
```

## Arguments

- file:

  Path of an qmd file

- install_missing:

  Should any missing packages be installed. Default `FALSE`.

- update_packages:

  Should installed packages be updated before rendering. Default
  `FALSE`.

- ...:

  Additional arguments to pass to `quarto_render()`
