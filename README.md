# rstudiovim

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Windows-R-CMD-check](https://github.com/davidfoord1/rstudiovim/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/davidfoord1/rstudiovim/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Configure RStudio Vim key bindings ⌨️

RStudio supports Vim key bindings in the source editor, but 
[doesn't support a Vim config](https://github.com/rstudio/rstudio/issues/7350).
{rstudiovim} offers a 🪟 **Windows-only** workaround by reading Vim commands from 
a file and simulating key presses to execute them on your behalf.

Ok, slow down a moment. If you're here, you should probably be seriously
considering using a different editor, with more comprehensive and configurable
Vim features. Perhaps check out [Neovim](https://neovim.io/) with
[R.nvim](https://github.com/R-nvim/R.nvim) or
[quarto-nvim](https://github.com/quarto-dev/quarto-nvim). 
To be clear, this package is **not** a neat RStudio API integration with its Vim
mode, there is no such option. This is just: you list what buttons you want
pressed; the buttons are pressed automatically for you. Nonetheless, it kind of
works, so you are welcome to go crazy with me...

## Overview

Install and load the package:
``` r
# install.packages("remotes")
remotes::install_github("davidfoord1/rstudiovim")
# load and attach:
library(rstudiovim)
```

Create and edit a config file (`.vimrc`) with a Vim command on each line. Edit
at the suggested path:

``` r
file.edit(rsvim_default_path())
```

Use Vim commands `map`, `imap`, `nmap` and `vmap` in the file to
create new key bindings. Each command must be on its own line. 
You can add comment lines by preceding them with double quotes `"` like so:

```vim
" home-row exit from insert mode
imap jk <Esc>

```

You can then execute all the commands in the file with
one function call and they will persist for the RStudio session. Then by
having the package execute these commands at the start of every RStudio session 
with the following in your
[`.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup):

```r
if (interactive())  {
  rstudiovim::rsvim_exec_file(rprofile = TRUE)
}
```
### Config in the cloud ☁️

The `rsvim_exec_file()` points by default to the `rsvim_default_path()` path, 
but you can use any text file or connection object containing your Vim commands.
For instance you can use a web location to easily share the config between
machines, like this to execute the [example vimrc](https://github.com/davidfoord1/rstudiovim/blob/main/inst/example.vimrc):

```r
rsvim_exec_file("https://raw.github.com/davidfoord1/rstudiovim/main/inst/example.vimrc")
```

### Conditions for success. 📃

1. You're using RStudio on Windows.
2. Setting `Keybinding set for editor` must be Vim (of course!).
3. **A file must be open in the source editor**, so that you could execute Vim 
commands if you navigated to source yourself. It must be a file tab at the front,
not a non-file tab like a `View()` pane.
4. Don't give inputs while the button presses are being executed as you can 
interrupt it.



See `vignette("rstudiovim")` for a more detailed introduction.
