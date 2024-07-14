test_that("rsvim_default_path create the expected path", {
  path <- rsvim_default_path()

  expect_true(is.character(path))
  expect_true(endsWith(path, "AppData\\Roaming/RStudio/keybindings/.vimrc"))
})

test_that("rsvim_default_path gives a usable path", {
  path_dir <- dirname(rsvim_default_path())

  expect_no_error(dir(path_dir))
  expect_true(is.character(dir(path_dir)))
})
