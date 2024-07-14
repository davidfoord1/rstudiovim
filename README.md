# rstudiovim

<!-- badges: start -->
<!-- badges: end -->

## Configure RStudio Vim keybindings ⌨️

RStudio supports Vim keybindings in the source editor, but 
[doesn't support a Vim keybinding config](https://github.com/rstudio/rstudio/issues/7350).
{rstudiovim} offers a 🪟 **Windows-only** workaround by reading Vim commands from 
a file and simulating key presses to execute them on your behalf.

### Overview
You can install the package from
[GitHub](https://github.com/davidfoord1/rstudiovim) with:

``` r
# install.packages("remotes")
remotes::install_github("davidfoord1/rstudiovim")
```

Load the package with:

``` r
library(rstudiovim)
```

Create and edit a config file (`.vimrc`) with a Vim command on each line. A
path is suggested by:

``` r
rsvim_default_file()
```

Use Vim commands `map`, `imap`, `nmap` and `vmap` in the file to
customise keybindings. Execute all the commands in the file with
one function call and they will persist for the RStudio session:

```r
rsvim_exec_file()
```

Execute these commands at the start of every RStudio session with the following in your
[`.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup):

```r
rstudiovim::rsvim_exec_file(rprofile = TRUE)
```

## Example 🔍

Going from insert mode to normal mode with `Esc` or `Ctrl+[` might feel like too
much movement for such a common action. It would be nice to have an option to do
so using home-row keys.

You can execute a command from Vim normal mode manually by pressing `:` to enter
command mode, typing your command and then pressing `Enter` to execute it. So
you might address this issue with something like `:imap jk <Esc>`. Then whenever
you are insert mode and type `jk` in one key chain, you will return to normal
mode.

Again, these mappings only persist for your RStudio session, so {rstudiovim} is 
here to help you apply these settings every time you are editing in RStudio.

**Create your .vimrc file**

```r
file.edit(rsvim_default_file())
```

**Write your commands**

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

The exec file function points by default to the `rsvim_default_file()` path, 
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
