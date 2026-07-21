local_doc = function(dir, name, header, body = c("```{r}", "1 + 1", "```")) {
  file = fs::path(dir, name)
  writeLines(c("---", header, "---", "", body), file)
  file
}

test_that("check_rmd_renders errors for missing files", {
  expect_error(
    check_rmd_renders(fs::path_temp("does-not-exist.Rmd")),
    "could not be found"
  )
})

test_that("check_rmd_renders renders a valid Rmd", {
  skip_if_not(rmarkdown::pandoc_available())

  dir = fs::dir_create(fs::file_temp("rmd"))
  on.exit(fs::dir_delete(dir))

  file = local_doc(dir, "test.Rmd", c("title: Test", "output: md_document"))

  out = check_rmd_renders(file)
  expect_true(fs::file_exists(out))
  expect_equal(fs::path_ext(out), "md")
})

test_that("check_rmd_renders passes output_dir and quiet through", {
  skip_if_not(rmarkdown::pandoc_available())

  dir = fs::dir_create(fs::file_temp("rmd"))
  out_dir = fs::dir_create(fs::file_temp("rmd_out"))
  on.exit({
    fs::dir_delete(dir)
    fs::dir_delete(out_dir)
  })

  file = local_doc(dir, "test.Rmd", c("title: Test", "output: md_document"))

  check_rmd_renders(file, output_dir = out_dir, quiet = TRUE)
  expect_true(fs::file_exists(fs::path(out_dir, "test.md")))
})

test_that("check_rmd_renders errors when rendering fails", {
  skip_if_not(rmarkdown::pandoc_available())

  dir = fs::dir_create(fs::file_temp("rmd"))
  on.exit(fs::dir_delete(dir))

  file = local_doc(
    dir, "bad.Rmd", c("title: Test", "output: md_document"),
    body = c("```{r}", "stop('render failure')", "```")
  )

  expect_error(check_rmd_renders(file))
})

test_that("check_qmd_renders errors for missing files", {
  expect_error(
    check_qmd_renders(fs::path_temp("does-not-exist.qmd")),
    "could not be found"
  )
})

test_that("check_qmd_renders renders a valid qmd", {
  skip_on_cran()
  skip_if(is.null(quarto::quarto_path()), "quarto CLI not available")

  dir = fs::dir_create(fs::file_temp("qmd"))
  on.exit(fs::dir_delete(dir))

  file = local_doc(dir, "test.qmd", c("title: Test", "format: gfm"))

  check_qmd_renders(file, quiet = TRUE)
  expect_true(fs::file_exists(fs::path(dir, "test.md")))
})

test_that("check_qmd_renders errors when rendering fails", {
  skip_on_cran()
  skip_if(is.null(quarto::quarto_path()), "quarto CLI not available")

  dir = fs::dir_create(fs::file_temp("qmd"))
  on.exit(fs::dir_delete(dir))

  file = local_doc(
    dir, "bad.qmd", c("title: Test", "format: gfm"),
    body = c("```{r}", "stop('render failure')", "```")
  )

  expect_error(check_qmd_renders(file, quiet = TRUE))
})
