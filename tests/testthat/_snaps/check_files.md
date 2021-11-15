# check_allowed_files

    Code
      check_allowed_files(c("hw1.Rmd", "hw1.Rproj", "README.md"), dir = system.file(
        "examples/hw1", package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x fizzbuzz.png

---

    Code
      check_allowed_files(c(""), dir = system.file("examples/hw1", package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x README.md
      x fizzbuzz.png
      x hw1.Rmd
      x hw1.Rproj

# check_disallowed_files

    Code
      check_disallowed_files("hw1.Rmd", dir = system.file("examples/hw1", package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.Rmd

---

    Code
      check_disallowed_files(c("hw1.md", "hw1.pdf"), dir = system.file("examples/hw1",
        package = "checklist"))

---

    Code
      check_disallowed_files("*.md", dir = system.file("examples/hw1", package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x README.md

---

    Code
      check_disallowed_files(c("hw1.Rmd", "hw1.md"), dir = system.file("examples/hw1",
        package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.Rmd

---

    Code
      check_disallowed_files(c("hw1.Rmd", "hw1.Rproj"), dir = system.file(
        "examples/hw1", package = "checklist"))
    Message <cliMessage>
      Disallowed files found: (please remove the following files)
      --------------------------------------------------------------------------------
      x hw1.Rmd
      x hw1.Rproj

# check_required_files

    Code
      check_required_files(c("hw1.md", "hw1.Rmd"), dir = system.file("examples/hw1",
        package = "checklist"))
    Message <cliMessage>
      The following required files are missing:
      --------------------------------------------------------------------------------
      x hw1.md

---

    Code
      check_required_files(c("hw1.Rproj", "hw1.Rmd"), dir = system.file(
        "examples/hw1", package = "checklist"))

