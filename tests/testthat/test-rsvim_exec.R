test_that("arg validation", {
  valid_command <- "imap jk <Esc>"

  # valid args
  expect_no_error(rsvim_exec(valid_command))
  expect_no_error(rsvim_exec(valid_command, 0.0001))

  # invalid command
  expect_error(rsvim_exec(1))
  expect_error(rsvim_exec(c("hello", "world")))
  expect_error(rsvim_exec(NA_character_))
  expect_error(rsvim_exec(""))


  # invalid wait
  expect_error(rsvim_exec(valid_command, "abc"))
  expect_error(rsvim_exec(valid_command, c(1, 2)))
  expect_error(rsvim_exec(valid_command, NA_real_))
})
