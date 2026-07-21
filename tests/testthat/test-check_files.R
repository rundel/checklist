test_that("find_files", {

  dir = system.file("examples/hw1", package="checklist")

  # Literal
  expect_equal(find_files("hw1.qmd", dir), "hw1.qmd", ignore_attr=TRUE)
  # Glob
  expect_setequal(find_files("hw1.*", dir), c("hw1.Rproj", "hw1.qmd"))
  # Regex
  expect_setequal(find_files("hw1\\.(qmd|Rproj)", dir, regex = TRUE, recurse = FALSE),
                  c("hw1.Rproj", "hw1.qmd"))
  # Missing file
  expect_true(length(find_files("hw1.Rnw", dir)) ==  0)

  # Multiple literal files
  expect_setequal(
    find_files(c("hw1.Rproj", "hw1.qmd"), dir),
    c("hw1.Rproj", "hw1.qmd")
  )

  # Hidden files
  expect_false(".hidden" %in% find_files(".*", dir))
  expect_true(".hidden" %in% find_files(".*", dir, all=TRUE))

  # Invert
  expect_false( "hw1.qmd" %in% find_files("hw1.qmd", dir, invert = TRUE) )
  expect_true( "hw1.Rproj" %in% find_files("hw1.qmd", dir, invert = TRUE) )

  # Empty pattern vector matches nothing (everything when inverted)
  expect_equal(length(find_files(character(0), dir)), 0)
  expect_setequal(
    find_files(character(0), dir, invert = TRUE),
    c("README.md", "hw1.Rproj", "hw1.qmd")
  )
})

test_that("find_files with regex metacharacters in names", {

  dir = fs::dir_create(fs::file_temp("meta"))
  on.exit(fs::dir_delete(dir))
  fs::file_create(fs::path(dir, c("hw1.qmd", "hw1+notes.qmd", "hw{1}.md")))

  expect_equal(find_files("hw1+notes.qmd", dir), "hw1+notes.qmd", ignore_attr = TRUE)
  expect_equal(find_files("hw{1}.md", dir), "hw{1}.md", ignore_attr = TRUE)
  expect_setequal(find_files("hw1*", dir), c("hw1.qmd", "hw1+notes.qmd"))

  expect_true(
    check_allowed_files(c("hw1.qmd", "hw1+notes.qmd", "hw{1}.md"), dir)
  )

  expect_false( quietly(
    check_disallowed_files("hw1+notes.qmd", dir)
  ) )

  # flagged names containing braces are displayed literally, not
  # interpreted as cli expressions
  expect_false( quietly(
    check_allowed_files("hw1.qmd", dir)
  ) )
  expect_snapshot(
    check_required_files("hw{n}.qmd", dir)
  )
})

test_that("find_files type and recurse arguments", {

  pkg_dir = system.file("examples/package", package = "checklist")

  expect_setequal(find_files("*", pkg_dir, type = "directory"), c("R", "inst"))
  expect_setequal(
    find_files("*", pkg_dir, recurse = FALSE),
    c("DESCRIPTION", "NAMESPACE", "example.Rproj")
  )
  expect_setequal(
    find_files("*", pkg_dir, recurse = 1),
    c("DESCRIPTION", "NAMESPACE", "example.Rproj", "R/packages.R", "inst/packages.qmd")
  )
})

test_that("check_allowed_files", {

  expect_true(
    check_allowed_files(
      c("hw1.qmd", "hw1.Rproj", "README.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_false( quietly(
    check_allowed_files(
      c("hw1.qmd", "hw1.Rproj"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  # Check output
  expect_snapshot(
    check_allowed_files(
      c("hw1.qmd", "hw1.Rproj"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_allowed_files(
      c(""),
      dir = system.file("examples/hw1", package="checklist")
    )
  )
})

test_that("check_files with empty file vectors", {

  dir = system.file("examples/hw1", package="checklist")

  expect_true( check_disallowed_files(character(0), dir) )
  expect_true( check_required_files(character(0), dir) )
  expect_false( quietly( check_allowed_files(character(0), dir) ) )
})

test_that("check_disallowed_files", {

  # Single literal file
  expect_true(
    check_disallowed_files("hw1.md", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_false( quietly(
    check_disallowed_files("hw1.qmd", dir = system.file("examples/hw1", package="checklist"))
  ) )


  # Check multiple literal files
  expect_true(
    check_disallowed_files(
      c("hw1.md", "hw1.pdf"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_false( quietly(
    check_disallowed_files(
      c("hw1.qmd", "hw1.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  expect_false( quietly(
    check_disallowed_files(
      c("hw1.Rproj", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )


  # Check glob
  expect_false( quietly(
    check_disallowed_files("*.md", dir = system.file("examples/hw1", package="checklist"))
  ) )

  # Check output
  expect_snapshot(
    check_disallowed_files("hw1.qmd", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_snapshot(
    check_disallowed_files(
      c("hw1.md", "hw1.pdf"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_disallowed_files("*.md", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_snapshot(
    check_disallowed_files(
      c("hw1.qmd", "hw1.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_disallowed_files(
      c("hw1.Rproj", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

})

test_that("check_required_files requires files, not directories", {

  dir = fs::dir_create(fs::file_temp("reqdir"))
  on.exit(fs::dir_delete(dir))
  fs::dir_create(fs::path(dir, "hw1.qmd"))

  expect_false( quietly( check_required_files("hw1.qmd", dir) ) )
})

test_that("check_required_files", {
  expect_false( quietly(
    check_required_files("hw1.md", dir = system.file("examples/hw1", package="checklist"))
  ) )

  expect_true(
    check_required_files("hw1.qmd", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_true(
    check_required_files(".hidden", dir = system.file("examples/hw1", package="checklist"))
  )


  # Multiple files
  expect_false( quietly(
    check_required_files(
      c("hw1.md", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  expect_true(
    check_required_files(
      c("hw1.Rproj", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  # Snapshots
  expect_snapshot(
    check_required_files(
      c("hw1.md", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_required_files(
      c("hw1.Rproj", "hw1.qmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

})

