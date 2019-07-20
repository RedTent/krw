context("add_abundantieklasse")


test <- tibble::tribble(
  ~naam, ~bedekkingspercentage, ~klasse,
  "c",                     1,       1,
  "e",                     5,       3,
  "f",                    25,       4,
  "g",                    49,       7,
  "h",                    50,       8,
  "i",                    51,       9
)

test_that("abundantieklassen met percentages", {
  res <- add_abundantieklasse(test, bedekkingspercentage, type = "percentage")
  expect_equal(res$abundantieklasse, c(1,2,2,2,2,3))
  
  res <- add_abundantieklasse(test, "bedekkingspercentage", type = "percentage")
  expect_equal(res$abundantieklasse, c(1,2,2,2,2,3))
  
})

test_that("abundantieklassen met klassen", {
  res <- add_abundantieklasse(test, klasse, type = "klasse")
  expect_equal(res$abundantieklasse, c(1,1,2,2,3,3))
  
  res <- add_abundantieklasse(test,"klasse", type = "klasse")
  expect_equal(res$abundantieklasse, c(1,1,2,2,3,3))
  
})



