test_that("multiplication works", {
  expect_no_error(rsvim_example_path())

  default <- rsvim_example_path()
  expect_true(basename(default) == "basic.vimrc")

  basic <- rsvim_example_path("basic")
  expect_true(basename(default) == "basic.vimrc")

  full <- rsvim_example_path("full_example")
  expect_true(basename(full) == "full_example.vimrc")

  expect_error(rsvim_example_path("not an example"))
  expect_error(rsvim_example_path(NA_character_))
  expect_error(rsvim_example_path(1))
})
