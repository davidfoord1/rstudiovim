test_that("arg validation", {
  test_path <- "test"

  # invalid con
  expect_error(rsvim_exec_file(c("hello", "world")))

  # invalid rprofile
  expect_error(rsvim_exec_file(test_path, rprofile = 1))
  expect_error(rsvim_exec_file(test_path, rprofile = "true"))

  # invalid wait
  expect_error(rsvim_exec(test_path, wait = "abc"))
  expect_error(rsvim_exec(test_path, wait = c(1, 2)))
  expect_error(rsvim_exec(test_path, wait = NA_real_))
})
