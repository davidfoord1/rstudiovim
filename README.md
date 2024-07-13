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

Create and edit a config file (`.vimrc`), adding a Vim command on each line:

``` r
file.edit(rsvim_default_file())
```

Then execute all the commands in the file with one function call:

```r
rsvim_exec_file()
```

We can use Vim commands `map`, `imap`, `nmap` and `vmap` in our file to 
customise our keybindings. These bindings persist for the duration of the 
RStudio session. Then by using `rsvim_exec_file()` in our 
[`.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup) 
to execute R code at the start of every R session, we can ensure that these 
bindings are always active.

Alternatively execute individual commands with a string like:

```r
rsvim_exec("help")
```

## Example 🔍

Going from insert mode to normal mode with `Esc` or `Ctrl+[` might feel like too
much movement for such a common action. It can be nice to have an option to do
so using home-row keys. You can achieve this with a command like `:imap jk <Esc>` 
from normal mode in the source editor.

Again, these mappings only persist for your RStudio session, so {rstudiovim} is 
here to help you apply these settings every time you are editing in RStudio:

**Create a file containing the commands.** 

There is a suggested .vimrc path you can edit with:

```r
file.edit(rsvim_default_file())
```

Each command must be on its own line. Do not include the preceding `:`. Just use
the text you would enter in the command dialogue box. You can add comment lines
by preceding them with double quotes `"`:

```vim
" home-row exit from insert mode
imap jk <Esc>

```

**Execute config on R session start.** 

With the package installed, add the following to your `.Rprofile`:

```r
if (interactive) rstudiovim::rsvim_exec_file()
```

With this, whenever you are insert mode and type `jk` in one key chain, you will
return to normal mode, and this binding will be applied for every R session.

### Config in the cloud ☁️

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
commands if you navigated to source yourself. Otherwise it will probably 
try Vim commands in the R console.
