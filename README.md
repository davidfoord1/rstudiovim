# rstudiovim

<!-- badges: start -->
<!-- badges: end -->

## Configure RStudio Vim keybindings 

RStudio supports Vim keybindings in the source editor, but 
[doesn't support a Vim keybinding config](https://github.com/rstudio/rstudio/issues/7350).
{rstudiovim} offers a **Windows-only** workaround by reading Vim commands from 
a file and simulating key presses to execute them on your behalf.

#### Overview
You can install the package  from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("davidfoord1/rstudiovim")
```

Load the package with:

``` r
library(rstudiovim)
```

Create and edit a config file, adding a Vim command on each line:

``` r
file.edit(rsvim_default_file())
```

Execute all the commands in the config file:

```r
rsvim_exec_file()
```

We can use Vim commands `map`, `imap`, `nmap` and `vmap` in our file to 
customise our keybindings. These bindings persist for the duration of the 
RStudio session. Then by using `rsvim_exec_file()` in our 
[`.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup) 
to execute R code at the start of every R session, we can ensure that these 
bindings are always active.

Alternatively execute individual commands like:

```r
rsvim_exec("help")
```

## Example

Say you want to have a way to go from insert mode to normal mode using home-row
keys. You can achieve this by executing something like `:imap jk <Esc>` from 
normal mode in the source editor. Here are the steps to have the setting apply
every time you are editing in RStudio:

**Create a file containing the commands.** 

{rstudiovim} suggests a file path you can edit with:

```r
file.edit(rsvim_default_file())
```

Each command must be on its own line and the last line should be a new line. Do
not include the preceding `:`, just the text you would enter in the command
dialogue box, like:

```
imap jk <Esc>


```

**Execute config on R session start.** 

With the package installed, add the following to your `.Rprofile`:

```r
if (interactive) rstudiovim::rsvim_exec_file()
```

Then whenever your are insert mode and type `jk` in one keychain, you will 
return to normal mode. By default this function points to the 
`rsvim_default_file()` path, but you can use any
text file or connection object containing your Vim commands:

```r
rsvim_exec_file("path/to/file")
```

### Conditions for success

1. You're using RStudio on Windows
2. `Keybinding set for editor` must be Vim.
3. A file must be open in the source editor, so that you could execute Vim 
commands if you navigated to source yourself.
