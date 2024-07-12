#' Execute vim command in source editor
#'
#' Pass a string to be executed as vim command. [`KeyboardSimulator`] is used
#' to simulate navigating to source, and typing
#'
#' @param command String. A vim command to execute. This is the text you would
#'   type in the vim command dialogue box after pressing `:` and before
#'   pressing `Enter`.
#'
#' @param focus_source String. Keyboard shortcut for focusing on the source
#'   pane, e.g. as in Tools --> Modify Keyboard Shortcuts.... The RStudio
#'   default is `Ctrl+1`. Build strings as appropriate for
#'   [KeyboardSimulator::keybd.press()].
#'
#' @return
#' Returns `NULL` invisibly.
#' @export
#'
#' @examples
#' # Create a home-row binding jk to go from insert mode to normal mode.
#' rsvim_exec("imap jk <Esc>")
#'
#' # Replace "text" with "rep" everywhere in the active document.
#' rsvim_exec("%s/text/rep/g")
#'
#'
rsvim_exec <- function(command, focus_source = "Ctrl+1") {
  KeyboardSimulator::keybd.press(focus_source)
  KeyboardSimulator::keybd.press("Esc")
  KeyboardSimulator::keybd.press("Shift+;")
  KeyboardSimulator::keybd.type_string(command)
  KeyboardSimulator::keybd.press("Enter")

  invisible()
}
