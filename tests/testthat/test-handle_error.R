test_that("find_pkgs", {
  expect_equal(
    handle_error(1+1, on_error = print("error"), on_warning = print("warning")),
    2
  )

  # Error
  expect_snapshot(
    handle_error(
      stop("Bad"),
      on_error = print("error"),
      on_warning = print("warning")
    )
  )

  # Warning
  expect_snapshot(
    handle_error(
      warning("so-so"),
      on_error = print("error"),
      on_warning = print("warning")
    )
  )

  # Error + finally
  expect_snapshot(
    handle_error(
      stop("Bad"),
      on_error = print("error"),
      on_warning = print("warning"),
      finally = print("done")
    )
  )

  # Warning + finally
  expect_snapshot(
    handle_error(
      warning("so-so"),
      on_error = print("error"),
      on_warning = print("warning"),
      finally = print("done")
    )
  )
})

