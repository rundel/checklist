% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_rmd.R
\name{check_qmd_renders}
\alias{check_qmd_renders}
\title{Check a qmd file renders using Quarto}
\usage{
check_qmd_renders(file, install_missing = FALSE, update_packages = FALSE, ...)
}
\arguments{
\item{file}{Path of an qmd file}

\item{install_missing}{Should any missing packages be installed. Default \code{FALSE}.}

\item{update_packages}{Should installed packages be updated before rendering. Default \code{FALSE}.}

\item{...}{Additional arguments to pass to \code{quarto_render()}}
}
\description{
Check a qmd file renders using Quarto
}
