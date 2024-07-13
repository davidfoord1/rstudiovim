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
  KeyboardSimulator::keybd.press(focus_source)
  KeyboardSimulator::keybd.press("Esc")
  KeyboardSimulator::keybd.press("Shift+;")
  KeyboardSimulator::keybd.type_string(command)
  KeyboardSimulator::keybd.press("Enter")

  invisible()
}
