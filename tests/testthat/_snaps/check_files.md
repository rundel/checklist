# find_files with regex metacharacters in names

    Code
      check_required_files("hw{n}.qmd", dir)
    Message
      The following required files are missing:
      --------------------------------------------------------------------------------
      x hw{n}.qmd

# check_allowed_files

    Code
      check_allowed_files(c("hw1.qmd", "hw1.Rproj"), dir = system.file("examples/hw1",
        package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x README.md

---

    Code
      check_allowed_files(c(""), dir = system.file("examples/hw1", package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x README.md
      x hw1.Rproj
      x hw1.qmd

# check_disallowed_files

    Code
      check_disallowed_files("hw1.qmd", dir = system.file("examples/hw1", package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.qmd

---

    Code
      check_disallowed_files(c("hw1.md", "hw1.pdf"), dir = system.file("examples/hw1",
        package = "checklist"))

---

    Code
      check_disallowed_files("*.md", dir = system.file("examples/hw1", package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x README.md

---

    Code
      check_disallowed_files(c("hw1.qmd", "hw1.md"), dir = system.file("examples/hw1",
        package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.qmd

---

    Code
      check_disallowed_files(c("hw1.Rproj", "hw1.qmd"), dir = system.file(
        "examples/hw1", package = "checklist"))
    Message
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.Rproj
      x hw1.qmd

# check_required_files

    Code
      check_required_files(c("hw1.md", "hw1.qmd"), dir = system.file("examples/hw1",
        package = "checklist"))
    Message
      The following required files are missing:
      --------------------------------------------------------------------------------
      x hw1.md

---

    Code
      check_required_files(c("hw1.Rproj", "hw1.qmd"), dir = system.file(
        "examples/hw1", package = "checklist"))

