#' Check an Rmd file renders using rmarkdown
#'
#' @param file Path of an Rmd file
#' @param install_missing Should any missing packages be installed. Default `FALSE`.
#' @param update_packages Should installed packages be updated before rendering. Default `FALSE`.
#' @param ... Additional arguments to pass to `render()`
#'
#' @export
check_rmd_renders = function(file, install_missing = FALSE, update_packages = FALSE, ...) {
  if (!fs::file_exists(file))
    stop("File: ", file, " could not be found.", call. = FALSE)

  file = fs::path_real(file)

  if (install_missing) {
    install_missing_pkgs(dir = fs::path_dir(file), glob = fs::path_file(file))
  }

  if (update_packages) {
    remotes::update_packages(upgrade = "always")
  }

  rmarkdown::render(file, output_dir = fs::path_dir(file), quiet = TRUE, ...)
}


#' Check a qmd file renders using Quarto
#'
#' @param file Path of an qmd file
#' @param install_missing Should any missing packages be installed. Default `FALSE`.
#' @param update_packages Should installed packages be updated before rendering. Default `FALSE`.
#' @param ... Additional arguments to pass to `quarto_render()`
#'
#' @export
check_qmd_renders = function(file, install_missing = FALSE, update_packages = FALSE, ...) {
  if (!fs::file_exists(file))
    stop("File: ", file, " could not be found.", call. = FALSE)

  file = fs::path_real(file)

  if (install_missing) {
    install_missing_pkgs(dir = fs::path_dir(file), glob = fs::path_file(file))
  }

  if (update_packages) {
    remotes::update_packages(upgrade = "always")
  }

  quarto::quarto_render(file, ...)
}
