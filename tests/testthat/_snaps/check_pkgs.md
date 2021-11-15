# check_allowed_pkgs

    Code
      check_allowed_pkgs(c("A", "B", "C", "D", "rmarkdown", "F", "X", "Y", "Z"),
      pkg_dir)

---

    Code
      check_allowed_pkgs("A", pkg_dir)
    Message <cliMessage>
      Disallowed packages used:
      --------------------------------------------------------------------------------
      x B
      x C
      x D
      x F
      x rmarkdown

---

    Code
      check_allowed_pkgs(c("A", "B", "C"), pkg_dir)
    Message <cliMessage>
      Disallowed packages used:
      --------------------------------------------------------------------------------
      x D
      x F
      x rmarkdown

# check_disallowed_pkgs

    Code
      check_disallowed_pkgs(c("A", "B"), pkg_dir)
    Message <cliMessage>
      Disallowed packages used:
      --------------------------------------------------------------------------------
      x A
      x B

---

    Code
      check_disallowed_pkgs(c("A", "Z"), pkg_dir)
    Message <cliMessage>
      Disallowed packages used:
      --------------------------------------------------------------------------------
      x A

---

    Code
      check_disallowed_pkgs(c("Y", "Z"), pkg_dir)

# check_required_pkgs

    Code
      check_required_pkgs(c("A", "B"), pkg_dir)

---

    Code
      check_required_pkgs(c("A", "Z"), pkg_dir)
    Message <cliMessage>
      The following required packages were not used:
      --------------------------------------------------------------------------------
      x Z

---

    Code
      check_required_pkgs(c("Y", "Z"), pkg_dir)
    Message <cliMessage>
      The following required packages were not used:
      --------------------------------------------------------------------------------
      x Y
      x Z

