#' Build a Vim config from a template
#'
#' Create a new config file from an existing config file. By default this is
#' based on the
#' [example.virmc](https://github.com/davidfoord1/rstudiovim/blob/main/inst/example.vimrc).
#'
#' @param to String. File path to write the Vim config file.
#' @param from String. File path to the config file to copy from.
#' @param overwrite Logical. By default this function will error if there is
#' already a file at the location. Use `overwrite = TRUE` to replace the existing
#' file at `to` with the contents of `from`.
#'
#' @return
#' Returns the `to` path invisibly.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' rsvim_use_template()
#'
#' rsvim_use_template(
#'   "path/to/my/custom/.virmc",
#'   "path/to/template/.virmc"
#' )
#' }
rsvim_use_template <- function(to = rsvim_default_path(),
                               from = rsvim_example_path(),
                               overwrite = FALSE){
  # checks
  if (file.exists(to) & !overwrite) {
    stop(paste("File already exists at", to))
  }

  stopifnot(file.exists(from))

  if (file.exists(to) & overwrite) {
    message("Overwriting Vim config file.")
  }

  # copy from template
  file.copy(from, to, overwrite)

  # navigate to file
  if (rstudioapi::isAvailable() && rstudioapi::hasFun("navigateToFile")) {
    rstudioapi::navigateToFile(to)
  }
  else {
    utils::file.edit(to)
  }

  invisible(to)
}

