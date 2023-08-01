length_rule <- create_length_rule("x", 10)
test_that("create_length_rule returns valid rules", {
  expect_equal(
    length_rule |> eval(),
    dataverifyr::rule(x < 10,
      name = "x",
      allow_na = TRUE
    )
  )
})

min_max_rule <- create_min_max_rule("x", 2, 10)
test_that("create_min_max_rule returns valid rules", {
  expect_equal(
    min_max_rule |> eval(),
    dataverifyr::rule(x >= 2 && x <= 10,
      name = "x",
      allow_na = TRUE
    )
  )
})

categorical_rule <- create_categorical_rule("x", c(1, 2, 3, 4, 5))
test_that("create_categorical_rule returns valid rules", {
  expect_equal(
    categorical_rule |> eval(),
    dataverifyr::rule(x %in% c(1, 2, 3, 4, 5),
      name = "x",
      allow_na = TRUE
    )
  )
})

dummy_schema <- list()
dummy_schema$name <- c("length", "min_max", "categorical", "pattern")
dummy_schema$min_length <- c(NA, 0, NA, NA)
dummy_schema$max_length <- c(10, 10, NA, NA)
dummy_schema$length <- c(NA, NA, 1, NA)
dummy_schema$min_inclusive <- c(NA, 1, NA, NA)
dummy_schema$max_inclusive <- c(NA, 12, NA, NA)
dummy_schema$enumeration_values <- c(NA, NA, list(c("a", "b", "c")), NA)
dummy_schema$pattern_values <- c(NA, NA, NA, c("[0-9]*"))
test_that("Check create_simple_rule() handles length rules correctly", {
  expect_equal(
    create_simple_rule(
      name = dummy_schema$name[1],
      min_length = dummy_schema$min_length[1],
      max_length = dummy_schema$max_length[1],
      length = dummy_schema$length[1],
      min_inclusive = dummy_schema$min_inclusive[1],
      max_inclusive = dummy_schema$max_inclusive[1],
      enumeration_values = dummy_schema$enumeration_values[[1]],
      pattern_values = dummy_schema$pattern_values[[1]]
    ) |> eval(),
    dataverifyr::rule(length < 10, name = "length", allow_na = TRUE)
  )
})
test_that("Check create_simple_rule() handles min/max rules correctly", {
  expect_equal(
    create_simple_rule(
      name = dummy_schema$name[2],
      min_length = dummy_schema$min_length[2],
      max_length = dummy_schema$max_length[2],
      length = dummy_schema$length[2],
      min_inclusive = dummy_schema$min_inclusive[2],
      max_inclusive = dummy_schema$max_inclusive[2],
      enumeration_values = dummy_schema$enumeration_values[[2]],
      pattern_values = dummy_schema$pattern_values[[2]]
    ) |> eval(),
    dataverifyr::rule(min_max >= 0 && min_max <= 10, name = "min_max", allow_na = TRUE)
  )
})
test_that("Check create_simple_rule() handles categorical rules correctly", {
  expect_equal(
    create_simple_rule(
      name = dummy_schema$name[3],
      min_length = dummy_schema$min_length[3],
      max_length = dummy_schema$max_length[3],
      length = dummy_schema$length[3],
      min_inclusive = dummy_schema$min_inclusive[3],
      max_inclusive = dummy_schema$max_inclusive[3],
      enumeration_values = dummy_schema$enumeration_values[[3]],
      pattern_values = dummy_schema$pattern_values[[3]]
    ) |> eval(),
    dataverifyr::rule(categorical %in% c("a", "b", "c"), name = "categorical", allow_na = TRUE)
  )
})
test_that("Check create_simple_rule() handles pattern rules correctly", {
  expect_equal(
    create_simple_rule(
      name = dummy_schema$name[4],
      min_length = dummy_schema$min_length[4],
      max_length = dummy_schema$max_length[4],
      length = dummy_schema$length[4],
      min_inclusive = dummy_schema$min_inclusive[4],
      max_inclusive = dummy_schema$max_inclusive[4],
      enumeration_values = dummy_schema$enumeration_values[[4]],
      pattern_values = dummy_schema$pattern_values[[4]]
    ) |> eval(),
    dataverifyr::rule(pattern == "[0-9]*", name = "pattern", allow_na = TRUE)
  )
})
