#' Check an Rmd file renders using rmarkdown
#'
#' @param file Path of an Rmd file
#' @param install_missing Should any missing packages be installed. Default `FALSE`.
#' @param update_packages Should installed packages be updated, using
#' [update_installed_pkgs()], before rendering. Default `FALSE`.
#' @param output_dir Directory for the rendered output, passed to
#' [rmarkdown::render()]. The default (`NULL`) renders next to the input file.
#' @param quiet Should knitting and pandoc output be suppressed. Default `TRUE`.
#' @param ... Additional arguments to pass to `render()`
#'
#' @return The path of the rendered output file, as returned by
#' [rmarkdown::render()].
#'
#' @examples
#' \dontrun{
#' check_rmd_renders("hw1.Rmd")
#' }
#'
#' @export
check_rmd_renders = function(file, install_missing = FALSE, update_packages = FALSE,
                             output_dir = NULL, quiet = TRUE, ...) {
  if (!fs::file_exists(file))
    stop("File: ", file, " could not be found.", call. = FALSE)

  file = fs::path_real(file)

  if (install_missing) {
    install_missing_pkgs(dir = fs::path_dir(file), regexp = file_name_regex(file), recurse = FALSE)
  }

  if (update_packages) {
    update_installed_pkgs()
  }

  rmarkdown::render(file, output_dir = output_dir, quiet = quiet, ...)
}


#' Check a qmd file renders using Quarto
#'
#' @param file Path of a qmd file
#' @param install_missing Should any missing packages be installed. Default `FALSE`.
#' @param update_packages Should installed packages be updated, using
#' [update_installed_pkgs()], before rendering. Default `FALSE`.
#' @param ... Additional arguments to pass to `quarto_render()`
#'
#' @return `NULL` invisibly, called for the side effect of rendering the
#' document. An error is signaled if rendering fails.
#'
#' @examples
#' \dontrun{
#' check_qmd_renders("hw1.qmd")
#' }
#'
#' @export
check_qmd_renders = function(file, install_missing = FALSE, update_packages = FALSE, ...) {
  if (!fs::file_exists(file))
    stop("File: ", file, " could not be found.", call. = FALSE)

  file = fs::path_real(file)

  if (install_missing) {
    install_missing_pkgs(dir = fs::path_dir(file), regexp = file_name_regex(file), recurse = FALSE)
  }

  if (update_packages) {
    update_installed_pkgs()
  }

  quarto::quarto_render(file, ...)
}
