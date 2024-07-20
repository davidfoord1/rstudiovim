#' RStudio Vim Commands data.frame
#'
#' A data.frame of commands valid for use taken from the RStudio Vim key-binding
#' javascript file. See pre-processing in `create_rstudio_vim_commands.R`. This
#' is not a fully comprehensive list as it doesn't include commands like `help`
#' and `R`.
#'
#' @format
#' A data frame with < 50 rows and 2 columns:
#' \describe{
#'   \item{name}{Full command name}
#'   \item{short_name}{Shorthand that can be used instead}
#' }
#' @source <https://github.com/rstudio/rstudio/blob/main/src/gwt/src/org/rstudio/studio/client/workbench/views/source/editors/text/ace/keybinding-vim-uncompressed.js>
"rstudio_vim_commands"
