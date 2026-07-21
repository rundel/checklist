test_that("handle_error", {
  expect_equal(
    handle_error(1+1, on_error = print("error"), on_warning = print("warning")),
    2
  )

  # on_success runs after expr succeeds and the result is preserved
  res = NULL
  expect_output(
    { res = handle_error(1 + 1, on_success = print("success")) },
    "success"
  )
  expect_equal(res, 2)

  # errors and warnings return the condition object
  expect_s3_class(handle_error(stop("Bad")), "simpleError")
  expect_s3_class(handle_error(warning("so-so")), "simpleWarning")

  # conditions signaled by on_success are not caught by the handlers
  expect_error(
    handle_error(1 + 1, on_success = stop("boom"), on_error = print("should not run")),
    "boom"
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
