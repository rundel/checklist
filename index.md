# checklist

checklist provides tools for instructors to automatically check the
structure and reproducibility of student assignment submissions. The
goal is not to check an assignment for correctness, but rather that the
submission is complete, well-formed, and reproducible. The package
includes checks for:

- required, allowed, and disallowed files
- required, allowed, and disallowed package dependencies
- successful rendering of R Markdown and Quarto documents

Checks can be run locally or, more usefully, automatically against each
student submission using GitHub Actions or a similar continuous
integration service.

## Installation

You can install the development version of this package from
[GitHub](https://github.com/) with:

``` r

# install.packages("devtools")
devtools::install_github("rundel/checklist")
```

## Example

``` r

library(checklist)
```

Let’s look at a simple example of the type of assignment a student might
turn in. All of the files are available in `inst/examples/hw1` within
this repository. If you have already installed the package then the
directory can also be found using
`system.file("examples/hw1", package="checklist")`.

``` r

dir = system.file("examples/hw1", package="checklist")

# Show the project contents
fs::dir_tree("inst/examples/hw1")
#> inst/examples/hw1
#> ├── README.md
#> ├── hw1.Rproj
#> └── hw1.qmd
```

We can now use checklist to express simple checks for the files in this
directory. For example, if we wanted to make sure that the students
submit a rendered version of their homework we could use the following
check:

``` r

check_required_files("hw1.md", dir)
#> The following required files are missing:
#> ────────────────────────────────────────────────────────────────────────────────
#> ✖ hw1.md
```

Alternatively, we may want to prevent the students from turning in a
rendered version (to check the reproducibility of their work) and this
can be done explicitly with

``` r

check_disallowed_files("hw1.md", dir)
```

We may instead want to be explicit about which files are allowed,
ensuring students have not added or renamed anything:

``` r

check_allowed_files(c("README.md", "hw1.qmd", "hw1.Rproj"), dir)
```

By default
[`find_files()`](https://rundel.github.io/checklist/reference/check_files.md)
and
[`check_allowed_files()`](https://rundel.github.io/checklist/reference/check_files.md)
ignore hidden files (files whose name starts with a `.`); these can be
included using the `all = TRUE` argument.
[`check_disallowed_files()`](https://rundel.github.io/checklist/reference/check_files.md)
and
[`check_required_files()`](https://rundel.github.io/checklist/reference/check_files.md)
always consider hidden files.

``` r

check_allowed_files(c("README.md", "hw1.qmd", "hw1.Rproj"), dir, all = TRUE)
#> Disallowed files found: (please remove the following files)
#> ────────────────────────────────────────────────────────────────────────────────
#> ✖ .hidden
```

To refine this, we may want to allow `.gitignore` as well as the
`.Rproj.user/` folder. These can be added to the files argument, and
standard glob wildcards are supported to make our life easier:

``` r

check_allowed_files(
  c("README.md", "hw1.qmd", "hw1.Rproj", ".gitignore", ".Rproj.user/*"),
  dir, all = TRUE
)
#> Disallowed files found: (please remove the following files)
#> ────────────────────────────────────────────────────────────────────────────────
#> ✖ .hidden
```

## Using with GitHub Actions

These checks are most useful when they run automatically against student
submissions, for example via a GitHub Actions workflow in each student’s
repository.
[`quit_on_failure()`](https://rundel.github.io/checklist/reference/quit_on_failure.md)
ensures that a failed check also fails the workflow run; multiple checks
can be passed to it as separate arguments. An example workflow for the
`hw1` assignment above ships with the package in
`templates/check_assignment.yml`, which can be located with
`system.file("templates/check_assignment.yml", package = "checklist")`.
It can be copied into an assignment repository as
`.github/workflows/check_assignment.yml`:

``` yaml
on: push
name: Check Assignment
permissions:
  contents: read
jobs:
  check-allowed-files:
    runs-on: ubuntu-latest
    container:
      image: rocker/r2u:latest
    steps:
    - name: Checkout
      uses: actions/checkout@v7
    - name: Install checklist
      run: |
        installGithub.r rundel/checklist
      shell: bash
      env:
        GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
    - name: Check Files
      run: |
        checklist::quit_on_failure(
          checklist::check_allowed_files(c("hw1.qmd", "hw1.Rproj", "README.md"))
        )
      shell: Rscript {0}
  check-renders:
    runs-on: ubuntu-latest
    container:
      image: rocker/r2u:latest
    steps:
    - name: Checkout
      uses: actions/checkout@v7
    - name: Install quarto and checklist
      run: |
        apt-get update -qq && apt-get install -y --no-install-recommends wget
        wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-linux-amd64.deb
        apt-get install -y ./quarto-1.8.27-linux-amd64.deb && rm quarto-*.deb
        installGithub.r rundel/checklist
      shell: bash
      env:
        GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
    - name: Check Renders
      run: |
        checklist::check_qmd_renders("hw1.qmd", install_missing = TRUE)
      shell: Rscript {0}
```
