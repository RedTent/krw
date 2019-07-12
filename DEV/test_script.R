# library(tidyverse)

soorten <- sample(krw_mafa_categorie_2018$biotaxon.naam, 40)
aantallen <- exp(c(runif(37, 0.5, 6), runif(3, 3, 8))) %>% round(0)

test3 <- tibble::tibble(watertype = "M1a", soorten, aantallen, mp = "A")
test2 <- tibble::tibble(watertype = "M8", soorten, aantallen, mp = "B")
test4 <- tibble::tibble(watertype = "M27", soorten, aantallen, mp = "C")

test <- dplyr::bind_rows(test2, test3) %>% dplyr::group_by(mp)
krw_mafa_ekr(test, soorten, watertype, aantallen)


test <- dplyr::bind_rows(test2, test3, test4) %>% dplyr::group_by(mp)
krw_mafa_ekr(test, soorten, watertype, aantallen)


krw_mafa_ekr(test, "soorten", "watertype", "aantallen") #%>% View("monster")
krw_mafa_ekr(test, soorten, watertype, aantallen) %>% View()
krw_mafa_ekr(test, soorten, watertype, aantallen, verbose = TRUE) -> x

test %>% dplyr::left_join(krw_mafa_categorie_2018, by = c(watertype = "krwwatertype.code",soorten =  "biotaxon.naam")) %>% View("test")
