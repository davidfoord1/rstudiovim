#' Path to rstudiovim example config
#'
#' Get the path to the `example.virmc` in the installed package.
#' This file is used as the default template for
#' `[rsvim_use_template()]`. You can use
#' this if you want to review the file in your editor.
#' You can also view the file online at
#' [GitHub example.virmc](https://github.com/davidfoord1/rstudiovim/blob/main/inst/example.vimrc)
#'
#' @return
#' String. The full path to the example file.
#' @export
#'
rsvim_example_path <- function() {
  system.file("example.vimrc", package = "rstudiovim")
}
