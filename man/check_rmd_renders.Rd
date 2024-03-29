% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_rmd.R
\name{check_rmd_renders}
\alias{check_rmd_renders}
\title{Check an Rmd file renders using rmarkdown}
\usage{
check_rmd_renders(file, install_missing = FALSE, update_packages = FALSE, ...)
}
\arguments{
\item{file}{Path of an Rmd file}

\item{install_missing}{Should any missing packages be installed. Default \code{FALSE}.}

\item{update_packages}{Should installed packages be updated before rendering. Default \code{FALSE}.}

\item{...}{Additional arguments to pass to \code{render()}}
}
\description{
Check an Rmd file renders using rmarkdown
}
