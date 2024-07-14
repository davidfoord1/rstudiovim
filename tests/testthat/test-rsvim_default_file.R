test_that("rsvim_default_file create the expected path", {
  path <- rsvim_default_file()

  expect_true(is.character(path))
  expect_true(endsWith(path, "AppData\\Roaming/RStudio/keybindings/.vimrc"))
})

test_that("rsvim_default_file gives a usable path", {
  path_dir <- dirname(rsvim_default_file())

  expect_no_error(dir(path_dir))
  expect_true(is.character(dir(path_dir)))
})
