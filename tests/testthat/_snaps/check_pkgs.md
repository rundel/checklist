# check_allowed_pkgs

    Code
      check_allowed_pkgs(c("A", "B", "C", "D", "rmarkdown", "F", "X", "Y", "Z"),
      pkg_dir)

---

    Code
      check_allowed_pkgs("A", pkg_dir)
    Message <simpleMessage>
      Disallowed packages used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
      x B
    Message <simpleMessage>
      x C
    Message <simpleMessage>
      x D
    Message <simpleMessage>
      x rmarkdown
    Message <simpleMessage>
      x F

---

    Code
      check_allowed_pkgs(c("A", "B", "C"), pkg_dir)
    Message <simpleMessage>
      Disallowed packages used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
      x D
    Message <simpleMessage>
      x rmarkdown
    Message <simpleMessage>
      x F

# check_disallowed_pkgs

    Code
      check_disallowed_pkgs(c("A", "B"), pkg_dir)
    Message <simpleMessage>
      Disallowed packages used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
      x A
    Message <simpleMessage>
      x B

---

    Code
      check_disallowed_pkgs(c("A", "Z"), pkg_dir)
    Message <simpleMessage>
      Disallowed packages used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
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
    Message <simpleMessage>
      The following required packages were not used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
      x Z

---

    Code
      check_required_pkgs(c("Y", "Z"), pkg_dir)
    Message <simpleMessage>
      The following required packages were not used:
    Message <simpleMessage>
      --------------------------------------------------------------------------------
    Message <simpleMessage>
      x Y
    Message <simpleMessage>
      x Z

