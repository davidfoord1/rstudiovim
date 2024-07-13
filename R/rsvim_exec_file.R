#' Execute all commands in rsvim config file
#'
#' @description Execute each line in a file as Vim commands. In the file each
#'   line should contain a single Vim command and the last line should be a new
#'   line.
#'
#'   We can use Vim commands `map`, `imap`, `nmap` and `vmap` in our file to
#'   customise our source editor keybindings. These bindings persist for the
#'   duration of the RStudio session. Then by using `rsvim_exec_file()` in our
#'   [.Rprofile] to execute R code at the start of every R session, we can
#'   ensure that these bindings are always active.
#'
#' @param con A string file path or connection object for a file with Vim
#'   commands to execute.
#'
#' @details A command is the text you would type in the Vim command dialogue box
#'   after pressing `:` and before pressing `Enter`. This function will simulate
#'   the key presses to execute all of the commands in the file. You can include
#'   comments in lines starting with double quotes `"`.
#'
#'   You can set up a binding from Vim normal mode like `:imap jk <Esc>`. If you
#'   include the line `imap jk <Esc>` in the `con` file, this function will
#'   execute it for you.
#'
#'   The default file is called `.vimrc`, but it can be any file with text in
#'   the right format.
#'
#' @return Returns `NULL` invisibly
#' @export
#'
#' @seealso
#' [rsvim_exec()] to execute individual commands.
#'
#' [rsvim_default_file()] to get the default file path.
#'
#' @examples
#' \dontrun{
#' # Put something like this in your .Rprofile file:
#' if (interactive()) rsvim_exec_file()
#' }
rsvim_exec_file <- function(con = rsvim_default_file()) {
  commands <- readLines(con)

  exec_commands <- function(command) {
    is_comment <- startsWith(command, '\"')
    is_blank   <- nchar(trimws(command)) == 0

    if (!is_comment & !is_blank) rsvim_exec(command)
  }

  lapply(commands, exec_commands)

  invisible()
}
