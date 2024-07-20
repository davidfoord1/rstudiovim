test_that("multiplication works", {
  expect_no_error(rsvim_example_path())

  result <- rsvim_example_path()

  expect_true(basename(result) == "example.vimrc")
  expect_true(grepl("rstudiovim/inst/example.vimrc$", result))
})
