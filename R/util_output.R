list_items = function(text, files, sub = NULL, symbol = cli::col_red(cli::symbol$cross), indent = 0) {

  if (getOption("checklist.quiet", default = FALSE))
    return()

  theme = list(
    ul = list("list-style-type" = symbol, "padding-left" = indent)
  )

  cli::cli_div(theme = theme)

  cli::cli_text("")
  cli::cli_text(text)
  cli::cli_rule()
  cli::cli_ul(files)
  cli::cli_text("")

  cli::cli_end()
}

quietly = function(code) {
  old = options(checklist.quiet = TRUE)
  on.exit(options(old))
  code
}
