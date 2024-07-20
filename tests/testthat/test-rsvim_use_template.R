test_that("arg validation works", {

  expect_error(rsvim_use_template(1))
  expect_error(rsvim_use_template(NA_character_))
  expect_error(rsvim_use_template(c("hello", "world")))

  expect_error(rsvim_use_template(from = 1))
  expect_error(rsvim_use_template(from = NA_character_))
  expect_error(rsvim_use_template(from = c("hello", "world")))

  expect_error(rsvim_use_template(overwrite = 1))
  expect_error(rsvim_use_template(overwrite = NA))
  expect_error(rsvim_use_template(overwrite = c(TRUE, FALSE)))
})
