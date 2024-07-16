#' Execute vim command in source editor
#'
#' Pass a string to be executed as a Vim command in the RStudio source editor.
#' This function then sends the input key presses to type out the command.
#'
#' @section Conditions:
#' Vim keybindings must be enabled and you must have a file open at the front in
#' the source editor so that you could execute the commands if you moved focus
#' to source yourself. It will error with a different at the front like a
#' [View()] tab.
#'
#' @param command String. A vim command to execute. This is the text you would
#'   type in the vim command dialogue box after pressing `:` and before pressing
#'   `Enter`.
#'
#' @return Returns `NULL` invisibly.
#'
#' @import Rcpp
#' @useDynLib rstudiovim
#' @export
#'
#' @seealso [rsvim_exec_file()] to run all commands from a config file.
#'
#' @examples
#' \dontrun{
#' #' # Create a home-row binding jk to go from insert mode to normal mode.
#' rsvim_exec("imap jk <Esc>")
#'
#' # Replace "text" with "rep" everywhere in the active document.
#' rsvim_exec("%s/text/rep/g")
#'
#' # Bring up RStudio's Vim help (see Ex Commands for other commands)
#' rsvim_exec("help")
#' }
rsvim_exec <- function(command) {
  editor <- rstudioapi::getSourceEditorContext()

  if (is.null(editor)) {
    exec_stop(
      "rsvim could not find source editor at command:",
      command,
      "Is there no file open at the front of the source editor?"
    )
  }

  rstudioapi::executeCommand("activateSource")
  focus <- rstudioapi::getActiveDocumentContext()[["id"]]

  if (focus == "#console") {
    exec_stop(
      "rsvim could not focus source at command:",
      command
    )
  }

  keybd_press("Esc")
  keybd_type_string(":")
  keybd_type_string(command)
  keybd_press("Enter")

  invisible()
}

#' Error while executing Vim command
#'
#' Helper function for rsvim_exec
#'
#' @param message statement that describes the error that occurred.
#' @param command the Vim command that was being attempted.
#' @param suggestion suggest a possible cause/fix for the error.
#'
#' @return
#' Exits R execution.
exec_stop <- function(message, command, suggestion = "") {
  stop(
    paste(
      message,
      command,
      "",
      suggestion,
      sep = "\n"
    ),
    call. = FALSE
  )
}
