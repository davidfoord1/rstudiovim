#' Execute vim command in source editor
#'
#' Pass a string to be executed as a Vim command in the RStudio source editor.
#' [`KeyboardSimulator`] is used to simulate navigating to source, entering
#' normal mode and typing out the command.
#'
#' @section Conditions:
#' Of course Vim keybindings must be enabled and you must have a file open in
#' the source editor so that you could execute the commands if you moved focus
#' to source yourself.
#'
#' @param command String. A vim command to execute. This is the text you would
#'   type in the vim command dialogue box after pressing `:` and before pressing
#'   `Enter`.
#'
#' @param focus_source String. Keyboard shortcut for `Move focus to source` e.g.
#'   as in `Tools -> Modify Keyboard Shortcuts`. The RStudio default is
#'   `Ctrl+1`.
#'
#' @details Strings for `focus_source` must be built as appropriate for
#' [KeyboardSimulator::keybd.press()].
#'
#' @return Returns `NULL` invisibly.
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
rsvim_exec <- function(command, focus_source = "Ctrl+1") {
  editor <- rstudioapi::getSourceEditorContext()

  if (is.null(editor)) {
    exec_stop(
      "rsvim could not find source editor at command:",
      command,
      "Is there no file open at the front of the source editor?"
    )
  }

  KeyboardSimulator::keybd.press(focus_source)

  focus <- rstudioapi::getActiveDocumentContext()[["id"]]

  if (focus == "#console") {
    exec_stop(
      "rsvim could not focus source at command:",
      command,
      "Is the focus_source keyboard shortcut incorrect?"
    )
  }

  KeyboardSimulator::keybd.press("Esc")
  KeyboardSimulator::keybd.press("Shift+;")
  KeyboardSimulator::keybd.type_string(command)
  KeyboardSimulator::keybd.press("Enter")

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
#' Exits running R.
exec_stop <- function(message, command, suggestion) {
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
