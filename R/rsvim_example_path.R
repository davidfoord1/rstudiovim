#' Path to rstudiovim example config
#'
#' Get the path to the example `.vimrc`s in the installed package.
#' The basic file is used as the default template for
#' [rsvim_use_template()]. You can use
#' this if you want to review the file in your editor.
#' You can also view the files online in the GitHub
#' [inst folder](https://github.com/davidfoord1/rstudiovim/blob/main/inst/).
#'
#' @param name String. Name of the example file to find the path to. 2 are
#' provided, "basic" and "full_example".
#'
#' @return
#' String. The full path to the example file.
#' @export
#'
rsvim_example_path <- function(name = c("basic", "full_example")) {
  name = match.arg(name)

  system.file(paste0(name, ".vimrc"), package = "rstudiovim")
}
