context("Macrofauna toetsing")

test_that("krw_mafa_toetsing werkt", {
  library(dplyr)
  soorten <- c("Baetis niger", "Asellus aquaticus")
  aantallen <- c(20, 100)
  
  test1 <- tibble::tibble(watertype = "M1a", soorten, aantallen, mp = "A")
  test2 <- tibble::tibble(watertype = "M8", soorten, aantallen, mp = "B")
  test3 <- tibble::tibble(watertype = "M27", soorten, aantallen, mp = "C")
  test4 <- tibble::tibble(watertype = "R16", soorten = soorten, aantallen = aantallen, mp = "D")
  test5 <- tibble::tibble(watertype = "R6", soorten, aantallen, mp = "E")
  test6 <- tibble::tibble(watertype = "R7", soorten, aantallen, mp = "F")
  

  test <- dplyr::bind_rows(test1, test2, test3, test4, test5, test6) %>% dplyr::group_by(mp)
  resultaat <- krw_mafa_ekr(test, watertype, soorten, aantallen)
  
  expect_equal(resultaat$ekr_mafa, c(0, 0, 0.1, 0.168, 0.64, 0.168), tolerance = 0.001)
})

test_that("afwijkende watertypen",{
  soorten <- c("Asellus aquaticus", "Baetis niger", "Chironomus salinarius")
  aantallen <- c(100, 20, 4)
  test7 <- tibble::tibble(watertype = "R8", soorten, aantallen, mp = "G")
  test8 <- tibble::tibble(watertype = "M30", soorten, aantallen, mp = "G")
  
  expect_warning(krw_mafa_ekr(test7, watertype, soorten, aantallen))
  expect_message(krw_mafa_ekr(test8, watertype, soorten, aantallen))
  
  result_m30 <- krw_mafa_ekr(test8, watertype, soorten, aantallen, verbose = TRUE)
  expect_equal(result_m30$ekr_mafa, c(0.917, 0.823, 0.673), tolerance = 0.001)
})

test_that("multiple group_by", {
  
  test <- tibble::tribble(
    ~meetpunt, ~jaar, ~krwwatertype.code,              ~taxon, ~aantal,
    "A",  2018,              "M1a", "Asellus aquaticus",     100,
    "A",  2018,              "M1a",      "Baetis niger",      20,
    "B",  2018,               "R6", "Asellus aquaticus",     100,
    "B",  2018,               "R6",      "Baetis niger",      20,
    "B",  2019,               "R6", "Asellus aquaticus",     150,
    "B",  2019,               "R6",      "Baetis niger",      35
  ) %>% group_by(meetpunt, jaar)
  
  resultaat <- krw_mafa_ekr(test, krwwatertype.code, taxon, aantal)
  expect_equal(resultaat$ekr_mafa, c(0, 0.64 , 0.67272), tolerance = 0.001)
  
})
