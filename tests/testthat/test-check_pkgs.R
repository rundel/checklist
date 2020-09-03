pkg_dir = system.file("examples/package", package = "checklist")

test_that("find_pkgs", {
  expect_equal(
    sort(find_pkgs(system.file("examples/hw1", package = "checklist"))),
    "rmarkdown"
  )

  expect_equal(
    sort(find_pkgs(pkg_dir)),
    c("A","B","C","D","F", "rmarkdown")
  )

  expect_equal(
    sort(find_pkgs(pkg_dir, glob = "*.Rmd")),
    c("A","B","C","D","F", "rmarkdown")
  )

  expect_equal(
    sort(find_pkgs(pkg_dir, glob = "*.R")),
    c("A","B","C","D")
  )
})

test_that("check_allowed_pkgs", {
  expect_true(
    check_allowed_pkgs(c("A", "B", "C", "D", "rmarkdown", "F"), pkg_dir)
  )

  expect_true(
    check_allowed_pkgs(c("A", "B", "C", "D", "rmarkdown", "F", "X", "Y", "Z"), pkg_dir)
  )


  expect_false( quietly(
    check_allowed_pkgs("A", pkg_dir)
  ) )

  expect_false( quietly(
    check_allowed_pkgs(c("A","B","C"), pkg_dir)
  ) )


  # Output
  expect_snapshot(
    check_allowed_pkgs(c("A", "B", "C", "D", "rmarkdown", "F", "X", "Y", "Z"), pkg_dir)
  )

  expect_snapshot(
    check_allowed_pkgs("A", pkg_dir)
  )

  expect_snapshot(
    check_allowed_pkgs(c("A","B","C"), pkg_dir)
  )
})

test_that("check_disallowed_pkgs", {

  expect_false( quietly(
    check_disallowed_pkgs("A", pkg_dir)
  ) )
  expect_true(
    check_disallowed_pkgs("Z", pkg_dir)
  )

  # Multiple deps
  expect_false( quietly(
    check_disallowed_pkgs(c("A", "B"), pkg_dir)
  ) )
  expect_false( quietly(
    check_disallowed_pkgs(c("A", "Z"), pkg_dir)
  ) )
  expect_true(
    check_disallowed_pkgs(c("Y", "Z"), pkg_dir)
  )


  # Output
  expect_snapshot(
    check_disallowed_pkgs(c("A", "B"), pkg_dir)
  )
  expect_snapshot(
    check_disallowed_pkgs(c("A", "Z"), pkg_dir)
  )
  expect_snapshot(
    check_disallowed_pkgs(c("Y", "Z"), pkg_dir)
  )


})

test_that("check_required_pkgs", {

  expect_true(
    check_required_pkgs("A", pkg_dir)
  )
  expect_false( quietly(
    check_required_pkgs("Z", pkg_dir)
  ) )

  # Multiple deps
  expect_true(
    check_required_pkgs(c("A", "B"), pkg_dir)
  )
  expect_false( quietly(
    check_required_pkgs(c("A", "Z"), pkg_dir)
  ) )
  expect_false( quietly(
    check_required_pkgs(c("Y", "Z"), pkg_dir)
  ) )


  # Output
  expect_snapshot(
    check_required_pkgs(c("A", "B"), pkg_dir)
  )
  expect_snapshot(
    check_required_pkgs(c("A", "Z"), pkg_dir)
  )
  expect_snapshot(
    check_required_pkgs(c("Y", "Z"), pkg_dir)
  )
})

test_that("missing_pkgs", {
  expect_equal(missing_pkgs(pkg_dir), c("A", "B", "C", "D", "F"))

  expect_equal(
    missing_pkgs(system.file("examples/hw1", package = "checklist")),
    character()
  )
})
