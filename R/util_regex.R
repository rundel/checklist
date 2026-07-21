escape_regex = function(x) {
  x = gsub("\\", "\\\\", x, fixed = TRUE)
  for (ch in c("^", "$", ".", "|", "+", "(", ")", "[", "]", "{", "}", "*", "?")) {
    x = gsub(ch, paste0("\\", ch), x, fixed = TRUE)
  }
  x
}

glob_to_regex = function(x) {
  x = escape_regex(x)
  x = gsub("\\*", ".*", x, fixed = TRUE)
  x = gsub("\\?", ".", x, fixed = TRUE)
  paste0("^", x, "$")
}

file_name_regex = function(file) {
  paste0("(^|/)", escape_regex(fs::path_file(file)), "$")
}
