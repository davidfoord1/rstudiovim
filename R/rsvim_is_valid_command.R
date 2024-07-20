#' Check if a Vim ex command is valid
#'
#' Checks against the RStudio defaultExCommandMap in
#' [keybinding-vim-uncompressed.js](https://github.com/rstudio/rstudio/blob/main/src/gwt/src/org/rstudio/studio/client/workbench/views/source/editors/text/ace/keybinding-vim-uncompressed.js).
#' The list is not complete and doesn't include for example `:help` and `:R`.
#'
#' @param command String. Command to check for validity.
#'
#' @return
#' Logical. Whether the command is supported in RStudio's javascript
#' implementation of Vim.
#'
#' @seealso [rstudio_vim_commands] for all valid commands.
#'
#' @export
#'
#' @examples
#' # valid commands
#' rsvim_is_valid_command("map")
#' rsvim_is_valid_command("noremap")
#'
#' # not valid commands
#' rsvim_is_valid_command("hello")
#'
#' # it is not a complete list at present:
#' rsvim_is_valid_command("help")
rsvim_is_valid_command <- function(command) {
  stopifnot(length(command) == 1)

  if (!is.character(command)) return(FALSE)

  valid_commands <- c(rstudio_vim_commands[["name"]],
                      rstudio_vim_commands[["shortName"]])

  valid_commands <- valid_commands[!is.na(valid_commands)]

  command %in% valid_commands
}
