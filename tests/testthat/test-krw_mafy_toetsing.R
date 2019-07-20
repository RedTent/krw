context("Toetsing macrofyten soortensamenstelling")

test_that("KRW-toetsing soortensamenstelling werkt enkel", {
  
  test_data1 <- tibble::tribble(
                 ~mp, ~jaar, ~krwwatertype.code,     ~biotaxon.naam, ~abundantieklasse,
                 "A",  2018,              "M27",   "Acorus calamus",                 1,
                 "A",  2018,              "M27",    "Berula erecta",                 1,
                 "A",  2018,              "M27",   "Chara vulgaris",                 1,
                 "A",  2018,              "M27", "Elodea nuttallii",                 1
                 )
  
  test_data2 <- tibble::tribble(
    ~mp, ~jaar, ~krwwatertype.code,     ~biotaxon.naam, ~abundantieklasse,
    "A",  2018,              "M10",   "Acorus calamus",                 1,
    "A",  2018,              "M10",    "Berula erecta",                 1,
    "A",  2018,              "M10",   "Chara vulgaris",                 1,
    "A",  2018,              "M10", "Elodea nuttallii",                 1
  )

  resultaat1 <- krw_mafy_ekr_ss(test_data1, krwwatertype.code, biotaxon.naam, abundantieklasse)
  resultaat2 <- krw_mafy_ekr_ss(test_data2, krwwatertype.code, biotaxon.naam, abundantieklasse)
  
  expect_true(is.na(resultaat1$ekr_ss_hydro))
  expect_true(is.na(resultaat1$ekr_ss_helo))
  
  expect_equal(resultaat1$ekr_ss_mafy, 0.3607, tolerance = 0.001)
  
  expect_equal(resultaat2$ekr_ss_mafy, 0.444, tolerance = 0.001)
  expect_equal(resultaat2$ekr_ss_hydro, 0.666, tolerance = 0.001)
  expect_equal(resultaat2$ekr_ss_helo, 0, tolerance = 0.001)
  
})

test_that("KRW-toetsing soortensamenstelling werkt meervoudig", {
  
  test_data <- tibble::tribble(
    ~mp, ~jaar, ~krwwatertype.code,     ~biotaxon.naam, ~abundantieklasse,
    "A",  2018,              "M27",   "Acorus calamus",                 1,
    "A",  2018,              "M27",    "Berula erecta",                 1,
    "A",  2018,              "M27",   "Chara vulgaris",                 1,
    "A",  2018,              "M27", "Elodea nuttallii",                 1,
    "A",  2019,              "M27",   "Acorus calamus",                 1,
    "A",  2019,              "M27",    "Berula erecta",                 1,
    "A",  2019,              "M27",   "Chara vulgaris",                 1,
    "A",  2019,              "M27", "Elodea nuttallii",                 1,
    "B",  2018,              "M10",   "Acorus calamus",                 1,
    "B",  2018,              "M10",    "Berula erecta",                 1,
    "B",  2018,              "M10",   "Chara vulgaris",                 1,
    "B",  2018,              "M10", "Elodea nuttallii",                 1,
    "B",  2019,              "M10",   "Acorus calamus",                 1,
    "B",  2019,              "M10",    "Berula erecta",                 1,
    "B",  2019,              "M10",   "Chara vulgaris",                 1,
    "B",  2019,              "M10", "Elodea nuttallii",                 1
  ) %>% dplyr::group_by(mp, jaar)
  
  resultaat <- krw_mafy_ekr_ss(test_data, krwwatertype.code, biotaxon.naam, abundantieklasse)
  
  expect_equal(resultaat$ekr_ss_mafy, c(0.3607, 0.3607, 0.444, 0.444), tolerance = 0.001)
  
})
