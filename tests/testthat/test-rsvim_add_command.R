test_that("arg validation works", {


  expect_error(rsvim_add_command(1))
  expect_error(rsvim_add_command(NA_character_))
  expect_error(rsvim_add_command(c("hello", "world")))

  test_command <- "test"

  expect_error(rsvim_add_command(test_command, comment = 1))
  expect_error(rsvim_add_command(test_command, comment = NA_character_))
  expect_error(rsvim_add_command(test_command, comment = c("hello", "world")))

  expect_error(rsvim_add_command(test_command, to = 1))
  expect_error(rsvim_add_command(test_command, to = NA_character))
  expect_error(rsvim_add_command(test_command, to = c("hello", "world")))
})
