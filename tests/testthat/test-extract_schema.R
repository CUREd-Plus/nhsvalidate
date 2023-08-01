length_rule <- create_length_rule("x", 10)
test_that("create_length_rule returns valid rules", {
  expect_equal(
    length_rule,
    dataverifyr::rule(x < 10,
      name = "x",
      allow_na = TRUE
    )
  )
})

min_max_rule <- create_min_max_rule("x", 2, 10)
test_that("create_min_max_rule returns valid rules", {
  expect_equal(
    min_max,
    dataverifyr::rule(x >= 2 & x <= 10,
      name = "x",
      allow_na = TRUE
    )
  )
})

categorical_rule <- create_categorical_rule("x", c(1, 2, 3, 4, 5))
test_that("create_categorical_rule returns valid rules", {
  expect_equal(
    categorical_rule,
    dataverifyr::rule(x %in% c(1, 2, 3, 4, 5),
      name = "x",
      allow_na = TRUE
    )
  )
})
