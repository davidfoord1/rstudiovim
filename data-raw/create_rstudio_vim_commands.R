# Extract command list from RStudio's keybinding-vim-uncompressed.js

# Get command map content -------------------------------------------------

js_file_path <- paste0(
  "https://raw.githubusercontent.com/rstudio/rstudio/main/src/gwt/src/",
  "org/rstudio/studio/client/workbench/views/source/editors/text/ace/",
  "keybinding-vim-uncompressed.js"
)

# Collapse to one line and capture section
js_content <- readLines(js_file_path) |>
  suppressWarnings() |>
  paste(collapse = "\n")

command_map_pattern <- "var defaultExCommandMap = \\[(.*?\\n)*?\\];"

stopifnot(grepl(command_map_pattern, js_content))

command_map_section <- regmatches(js_content,
                             regexpr(command_map_pattern, js_content, perl = TRUE))

# Cleaning
command_map_string <- gsub("var defaultExCommandMap = |\\];", "", command_map_section)
command_map_string <- gsub("\\}\\s*,\\s*\\{", "},{", command_map_string)
command_map_string <- gsub("\n", "", command_map_string)

# Split back to individual lines
command_strings <- unlist(strsplit(command_map_string, "\\},\\{"))


# Parse individual lines --------------------------------------------------

parse_command <- function(command_string) {
  name <- regmatches(command_string, regexpr("name: '\\w+'", command_string))
  short_name <- regmatches(command_string, regexpr("shortName: '\\w+'", command_string))

  name <- gsub("name: '|'", "", name)
  short_name <- ifelse(length(short_name) > 0, gsub("shortName: '|'", "", short_name), NA)

  list(name = name, short_name = short_name)
}

rstudio_vim_commands <- lapply(command_strings, parse_command)

# Store as data.frame
rstudio_vim_commands <- do.call(
  rbind,
  lapply(rstudio_vim_commands, as.data.frame, stringsAsFactors = FALSE)
)

# Output to data/ ---------------------------------------------------------


usethis::use_data(rstudio_vim_commands, overwrite = TRUE)
