test_that("rsvim_is_valid_command correctly validates commands", {
  expect_true(rsvim_is_valid_command("map"))
  expect_true(rsvim_is_valid_command("imap"))
  expect_true(rsvim_is_valid_command("nmap"))
  expect_true(rsvim_is_valid_command("vmap"))
  expect_true(rsvim_is_valid_command("noremap"))
  expect_true(rsvim_is_valid_command("inoremap"))
  expect_true(rsvim_is_valid_command("nnoremap"))
  expect_true(rsvim_is_valid_command("vnoremap"))

  expect_false(rsvim_is_valid_command("hello"))
  expect_false(rsvim_is_valid_command("world"))
  expect_false(rsvim_is_valid_command(""))

  expect_error(rsvim_is_valid_command(1))
  expect_error(rsvim_is_valid_command(NA_character_))
  expect_error(rsvim_is_valid_command(c("map", "imap")))
  expect_error(rsvim_is_valid_command(LETTERS))
})
