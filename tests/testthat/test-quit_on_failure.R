# quit_on_failure() terminates R on failure so it is exercised in a callr
# subprocess; the environment rebase lets the closure serialize without
# requiring an installed copy of the package
local_qof = function() {
  f = quit_on_failure
  environment(f) = globalenv()
  f
}

test_that("quit_on_failure passes through TRUE results", {
  skip_if_not_installed("callr")

  expect_true(
    callr::r(function(f) f(TRUE), args = list(f = local_qof()))
  )

  expect_equal(
    callr::r(function(f) f(c(TRUE, TRUE)), args = list(f = local_qof())),
    c(TRUE, TRUE)
  )
})

test_that("quit_on_failure handles multiple check arguments", {
  skip_if_not_installed("callr")

  expect_equal(
    callr::r(function(f) f(TRUE, c(TRUE, TRUE)), args = list(f = local_qof())),
    list(TRUE, c(TRUE, TRUE))
  )

  expect_error(
    callr::r(function(f) f(FALSE, TRUE), args = list(f = local_qof())),
    class = "callr_status_error"
  )

  expect_error(
    callr::r(function(f) f(TRUE, FALSE), args = list(f = local_qof())),
    class = "callr_status_error"
  )
})

test_that("quit_on_failure exits with status 1 on any non-TRUE value", {
  skip_if_not_installed("callr")

  expect_error(
    callr::r(function(f) f(FALSE), args = list(f = local_qof())),
    class = "callr_status_error"
  )

  expect_error(
    callr::r(function(f) f(c(TRUE, FALSE)), args = list(f = local_qof())),
    class = "callr_status_error"
  )

  expect_error(
    callr::r(function(f) f(c(TRUE, NA)), args = list(f = local_qof())),
    class = "callr_status_error"
  )
})
