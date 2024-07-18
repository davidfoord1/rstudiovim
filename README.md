# rstudiovim

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Windows-R-CMD-check](https://github.com/davidfoord1/rstudiovim/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/davidfoord1/rstudiovim/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Configure RStudio Vim keybindings ⌨️

RStudio supports Vim keybindings in the source editor, but 
[doesn't support a Vim keybinding config](https://github.com/rstudio/rstudio/issues/7350).
{rstudiovim} offers a 🪟 **Windows-only** workaround by reading Vim commands from 
a file and simulating key presses to execute them on your behalf.

Ok, slow down a moment. If you're here, you should probably be seriously
considering using a different editor, with more comprehensive and configurable
Vim features. Check out [Neovim](https://neovim.io/) with
[R.nvim](https://github.com/R-nvim/R.nvim) or
[quarto-nvim](https://github.com/quarto-dev/quarto-nvim). 
To be clear, this package is **not** a neat RStudio API integration with its Vim
mode, there is no such option. This is just: you list what buttons you want
pressed; the buttons are pressed automatically for you. Nonetheless, it kind of
works, so you are welcome to go crazy with me...

### Overview
You can install the package from
[GitHub](https://github.com/davidfoord1/rstudiovim) with:

``` r
# install.packages("remotes")
remotes::install_github("davidfoord1/rstudiovim")
```

Attach and load the package with:

``` r
library(rstudiovim)
```

Create and edit a config file (`.vimrc`) with a Vim command on each line. Edit
at the suggest path:

``` r
file.edit(rsvim_default_path())
```

Use Vim commands `map`, `imap`, `nmap` and `vmap` in the file to
create new keybindings. Execute all the commands in the file with
one function call and they will persist for the RStudio session. Go further by
having the package execute these commands at the start of every RStudio session using your
[`.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup):

```r
# Interactively
rsvim_exec_file()
# In your Rprofile
rstudiovim::rsvim_exec_file(rprofile = TRUE)
```

## Example 🔍

From editing in normal mode you press `:` to enter command-line mode, typing
your command and then pressing `Enter` to execute it. If you wanted a home-row
key chain to exit insert mode you might use the ex command `imap jk <Esc>`. Then
whenever you are insert mode and type `jk`, you will return to normal mode.
Again, these mappings only persist for your RStudio session, so {rstudiovim} is
here to help you apply these settings every time you are editing in RStudio.

**Write the commands in your .vimrc file**

Each command must be on its own line. Do not include the preceding `:`. Just use
the text you would enter in the command dialogue box. You can add comment lines
by preceding them with double quotes `"` like so:

```vim
" home-row exit from insert mode
imap jk <Esc>

```

**Edit your .Rprofile**

```r
file.edit("~/.Rprofile")
```

**Include the function call to execute the file's commands.**

```r
if (interactive())  {
  rstudiovim::rsvim_exec_file(rprofile = TRUE)
}
```

With those files saved, now every session, you can use `jk` to return to normal mode. 

## Config in the cloud ☁️

The exec file function points by default to the `rsvim_default_path()` path, 
but you can use any text file or connection object containing your Vim commands.
For instance you can use a web location to easily share the config between
machines, like this to execute the [example vimrc](https://github.com/davidfoord1/rstudiovim/blob/main/inst/example.vimrc):

```r
rsvim_exec_file("https://raw.github.com/davidfoord1/rstudiovim/main/inst/example.vimrc")
```

## Conditions for success. 📃

1. You're using RStudio on Windows.
2. Setting `Keybinding set for editor` must be Vim (of course!).
3. **A file must be open in the source editor**, so that you could execute Vim 
commands if you navigated to source yourself. It must be a file tab at the front,
not a non-file tab like a `View()` pane.
4. Don't give inputs while the button presses are being executed as you can 
interrupt it.
