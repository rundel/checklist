# pak's subprocess refuses to run during R CMD check unless a cache
# directory is explicitly provided
if (Sys.getenv("R_USER_CACHE_DIR") == "") {
  Sys.setenv(R_USER_CACHE_DIR = file.path(tempdir(), "cache"))
}
