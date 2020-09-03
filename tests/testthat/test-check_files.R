test_that("find_files", {

  dir = system.file("examples/hw1", package="checklist")

  # Literal
  expect_equal(find_files("hw1.Rmd", dir), "hw1.Rmd", ignore_attr=TRUE)
  # Glob
  expect_equal(find_files("hw1.*", dir), c("hw1.Rmd", "hw1.Rproj"), ignore_attr=TRUE)
  # Regex
  expect_equal(find_files("hw1\\.(Rmd|Rproj)", dir, regex = TRUE, recurse = FALSE),
               c("hw1.Rmd", "hw1.Rproj"), ignore_attr=TRUE)
  # Missing file
  expect_true(length(find_files("hw1.Rnw", dir)) ==  0)

  # Multiple literal files
  expect_equal(
    find_files(c("hw1.Rmd", "hw1.Rproj"), dir),
    c("hw1.Rmd", "hw1.Rproj"),
    ignore_attr=TRUE
  )

  # Hidden files
  expect_false(".gitignore" %in% find_files(".*", dir))
  expect_true(".gitignore" %in% find_files(".*", dir, all=TRUE))

  # Invert
  expect_false( "hw1.Rmd" %in% find_files("hw1.Rmd", dir, invert = TRUE) )
  expect_true( "hw1.Rproj" %in% find_files("hw1.Rmd", dir, invert = TRUE) )
})

test_that("check_allowed_files", {

  expect_true(
    check_allowed_files(
      c("fizzbuzz.png", "hw1.Rmd", "hw1.Rproj", "README.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_false( quietly(
    check_allowed_files(
      c("hw1.Rmd", "hw1.Rproj", "README.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  # Check output
  expect_snapshot(
    check_allowed_files(
      c("hw1.Rmd", "hw1.Rproj", "README.md"),
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

test_that("check_disallowed_files", {

  # Single literal file
  expect_true(
    check_disallowed_files("hw1.md", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_false( quietly(
    check_disallowed_files("hw1.Rmd", dir = system.file("examples/hw1", package="checklist"))
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
      c("hw1.Rmd", "hw1.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  expect_false( quietly(
    check_disallowed_files(
      c("hw1.Rmd", "hw1.Rproj"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )


  # Check glob
  expect_false( quietly(
    check_disallowed_files("*.md", dir = system.file("examples/hw1", package="checklist"))
  ) )

  # Check output
  expect_snapshot(
    check_disallowed_files("hw1.Rmd", dir = system.file("examples/hw1", package="checklist"))
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
      c("hw1.Rmd", "hw1.md"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_disallowed_files(
      c("hw1.Rmd", "hw1.Rproj"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

})

test_that("check_required_files", {
  expect_false( quietly(
    check_required_files("hw1.md", dir = system.file("examples/hw1", package="checklist"))
  ) )

  expect_true(
    check_required_files("hw1.Rmd", dir = system.file("examples/hw1", package="checklist"))
  )

  expect_true(
    check_required_files(".gitignore", dir = system.file("examples/hw1", package="checklist"))
  )


  # Multiple files
  expect_false( quietly(
    check_required_files(
      c("hw1.md", "hw1.Rmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  ) )

  expect_true(
    check_required_files(
      c("hw1.Rproj", "hw1.Rmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  # Snapshots
  expect_snapshot(
    check_required_files(
      c("hw1.md", "hw1.Rmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

  expect_snapshot(
    check_required_files(
      c("hw1.Rproj", "hw1.Rmd"),
      dir = system.file("examples/hw1", package="checklist")
    )
  )

})

