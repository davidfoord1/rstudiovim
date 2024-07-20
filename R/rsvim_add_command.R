#' Append command to config file
#'
#' Append a Vim ex command to the end of a config file, optionally preceded by a
#' descriptive comment.
#'
#' @param command String. A Vim ex command.
#' @param comment String. Text describing the purpose of the command. This will
#' be written one line above the command, preceded by double-quotes `"` to be
#' treated as a comment.
#' @param to String. File path to config file.
#'
#' @return
#' Returns `NULL` invisibly.
#' @export
#'
#' @examples
#' \dontrun{
#' rsvim_add_command("imap jk <Esc>")
#'
#' rsvim_add_command("map \o o<Esc>",
#'                   "create a new line and stay in normal mode")
#' }
rsvim_add_command <- function(command,
                              comment = "",
                              to = rsvim_default_path()) {
  stopifnot(is.character(command))
  stopifnot(length(command) == 1)
  stopifnot(!is.na(command))

  stopifnot(is.character(comment))
  stopifnot(length(comment) == 1)
  stopifnot(!is.na(comment))

  stopifnot(is.character(to))
  stopifnot(length(to) == 1)
  stopifnot(!is.na(to))

  stopifnot(file.exists(to))

  write("\n", to, append = TRUE)

  if (nchar(comment > 0)) {
    comment <- paste('"', comment)
    write(comment, to, append = TRUE)
  }

  write(command, to, append = TRUE)

  invisible()
}
