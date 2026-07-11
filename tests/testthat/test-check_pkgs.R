pkg_dir = system.file("examples/package", package = "checklist")

test_that("find_pkgs", {
  expect_equal(
    sort(find_pkgs(system.file("examples/hw1", package = "checklist"))),
    c("cli", "here", "rmarkdown")
  )

  expect_equal(
    sort(find_pkgs(pkg_dir)),
    c("A","B","C","D","F", "rmarkdown")
  )

  expect_equal(
    sort(find_pkgs(pkg_dir, regexp = "[.]qmd$")),
    c("A","B","C","D","F", "rmarkdown")
  )

  expect_equal(
    sort(find_pkgs(pkg_dir, regexp = "[.]R$")),
    c("A","B","C","D")
  )
})

test_that("find_pkgs full = TRUE", {
  res = find_pkgs(pkg_dir, full = TRUE)

  expect_s3_class(res, "data.frame")
  expect_true(all(c("path", "package") %in% names(res)))
  expect_equal(sort(unique(res$package)), c("A", "B", "C", "D", "F", "rmarkdown"))
})

test_that("find_pkgs recurse = FALSE", {
  expect_equal(
    find_pkgs(pkg_dir, recurse = FALSE),
    character(0)
  )
})

test_that("find_pkgs with no matching files", {
  expect_equal(
    find_pkgs(pkg_dir, regexp = "[.]py$"),
    character(0)
  )

  expect_equal(
    find_pkgs(pkg_dir, regexp = "[.]py$", full = TRUE),
    find_pkgs(pkg_dir, full = TRUE)[0, ]
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

test_that("update_refs", {
  pkgs = data.frame(
    package = c("a", "b", "c", "d", "stats"),
    remotepkgref = c("github::user/a", NA, NA, NA, NA),
    remotetype = c("github", "github", "standard", NA, NA),
    remoteusername = c("user", "user", NA, NA, NA),
    remoterepo = c("a", "b", NA, NA, NA),
    priority = c(NA, NA, NA, NA, "base")
  )

  expect_equal(
    update_refs(pkgs),
    c("github::user/a", "user/b", "c", "d")
  )

  # remote metadata columns are absent when no package in the library has them
  minimal = data.frame(package = c("a", "b"))
  expect_equal(update_refs(minimal), c("a", "b"))

  expect_length(update_refs(minimal[0, , drop = FALSE]), 0)

  # plain name refs not available from a repository are skipped,
  # structured refs are kept regardless
  pkgs2 = data.frame(
    package = c("a", "b", "c", "d"),
    remotepkgref = c("github::user/a", "local:://path/b", NA, NA)
  )
  expect_equal(
    update_refs(pkgs2, available = c("c", "x", "y")),
    c("github::user/a", "local:://path/b", "c")
  )
  expect_equal(
    update_refs(pkgs2, available = character(0)),
    c("github::user/a", "local:://path/b")
  )
})

test_that("missing_pkgs", {
  expect_equal(sort(missing_pkgs(pkg_dir)), c("A", "B", "C", "D", "F"))

  expect_equal(
    missing_pkgs(system.file("examples/hw1", package = "checklist")),
    character()
  )
})
