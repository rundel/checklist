# find_pkgs

    Code
      handle_error(stop("Bad"), on_error = print("error"), on_warning = print(
        "warning"))
    Output
      [1] "error"

---

    Code
      handle_error(warning("so-so"), on_error = print("error"), on_warning = print(
        "warning"))
    Output
      [1] "warning"

---

    Code
      handle_error(stop("Bad"), on_error = print("error"), on_warning = print(
        "warning"), finally = print("done"))
    Output
      [1] "error"
      [1] "done"

---

    Code
      handle_error(warning("so-so"), on_error = print("error"), on_warning = print(
        "warning"), finally = print("done"))
    Output
      [1] "warning"
      [1] "done"

