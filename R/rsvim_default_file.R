#' Get suggested config file path
#'
#' The file is `.vimrc` located in
#' `%APPDATA%/RStudio/keybindings/` where you can also find RStudio's JSON
#' keybinding config files.
#'
#' @return String. The full file path to `.vimrc`
#'
#' @export
#'
#' @seealso [rsvim_exec_file()] To execute commands from a file at this path.
#'
#' @examples
#' \dontrun{
#' file.edit(rsvim_default_file())
#' }
rsvim_default_file <- function() {
  file.path(
    Sys.getenv("APPDATA"),
    "RStudio",
    "keybindings",
    ".vimrc"
  )
}
