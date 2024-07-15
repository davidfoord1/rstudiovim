#' Execute all commands in a vim config file
#'
#' @description Execute each line in a file as Vim commands. Include Vim
#'   commands `map`, `imap`, `nmap` and `vmap` in your file to customise your
#'   source editor keybindings.
#'
#'   Use `rsvim_exec_file()` to execute all of the commands. Bindings persist
#'   for the duration of the RStudio session.
#'
#'   Use `rsvim_exec_file(rprofile = TRUE)` in your [.Rprofile] to execute the
#'   commands on RStudio startup, so they are always active.
#'
#' @param con A string file path or connection object for a file with Vim
#'   commands to execute.
#'
#' @param rprofile Logical. Set to `TRUE` if calling this function within the
#'   `.Rprofile` i.e. before the RStudio API is available. This changes the
#'   behaviour from immediate execution to waiting for the RStudio API to become
#'   available. Currently only works on RStudio startup, not any R session
#'   restart.
#'
#' @details You can execute a command from Vim normal mode manually by pressing
#'   `:` to enter command mode, typing your command and then pressing `Enter`.
#'   To use this function you write these commands in your file
#'   passed to `con`. You can include comments in lines starting with double
#'   quotes `"`. Each command should be on it's own line, like:
#'
#'
#' `imap jk <Esc>`
#'
#' This function will simulate the key presses to execute the commands in your
#' file. The default file is called `.vimrc`, but it can be any file with text
#' in the right format.
#'
#' @section Rprofile execution:
#' When `rprofile = TRUE` this function uses [setHook()] to wait for the RStudio
#' API to become available before executing the commands. This is only triggered
#' the first time the RStudio session is opened, so not on every R session
#' restart.
#'
#' @return Returns `NULL` invisibly
#' @export
#'
#' @seealso [rsvim_exec()] to execute individual commands.
#'
#' [rsvim_default_path()] to get the default file path.
#'
#' @examples
#' \dontrun{
#' # Execute interactively:
#' rsvim_exec_file()
#'
#' # Execute on startup with this in your .Rprofile file:
#' if (interactive()) rsvim_exec_file(rprofile = TRUE)
#' }
rsvim_exec_file <- function(con = rsvim_default_path(), rprofile = FALSE) {
  # check and execute individual lines
  exec_command <- function(command) {
    is_comment <- startsWith(command, '\"')
    is_blank   <- nchar(trimws(command)) == 0

    if (!is_comment & !is_blank) rsvim_exec(command)
  }

  # check if the key presses could be executed and apply to each line
  exec_commands <- function() {
    commands <- readLines(con)
    lapply(commands, exec_command)
    message(".vimrc executed.")
  }

  # set hook for execution on RStudio start up
  # else execute immediately
  if (rprofile) {
    setHook(
      hookName = "rstudio.sessionInit",
      value = function(newSession) {
        if (newSession) {

          exec_commands()

        }
      },
      action = "append"
    )
  } else {

    exec_commands()

  }

  invisible()
}
