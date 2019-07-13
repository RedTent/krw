#library(tidyverse)

set.seed(1234)
soorten <- sample(krw_mafa_categorie_2018$biotaxon.naam, 40)
aantallen <- exp(c(runif(37, 0.5, 6), runif(3, 3, 8))) %>% round(0)
soorten2 <- sample(krw_mafa_categorie_2018$biotaxon.naam, 40)
aantallen2 <- exp(c(runif(37, 0.5, 6), runif(3, 3, 8))) %>% round(0)

soorten <- c("Baetis niger", "Asellus aquaticus")
aantallen <- c(20, 100)

test3 <- tibble::tibble(watertype = "M1a", soorten, aantallen, mp = "A")
test2 <- tibble::tibble(watertype = "M8", soorten, aantallen, mp = "B")
test4 <- tibble::tibble(watertype = "M27", soorten, aantallen, mp = "C")
test5 <- tibble::tibble(watertype = "R16", soorten = soorten, aantallen = aantallen, mp = "D")
#test5 <- tibble::tibble(watertype = "M1a", soorten = soorten2, aantallen = aantallen2, mp = "D")
test6 <- tibble::tibble(watertype = "R6", soorten, aantallen, mp = "E")
test7 <- tibble::tibble(watertype = "R7", soorten, aantallen, mp = "F")

# test <- dplyr::bind_rows(test2, test3) %>% dplyr::group_by(mp)
# krw_mafa_ekr(test, soorten, watertype, aantallen)


test <- dplyr::bind_rows(test2, test3, test4, test5, test6, test7) %>% dplyr::group_by(mp)
krw_mafa_ekr(test, soorten, watertype, aantallen)
krw_mafa_ekr(test, soorten, watertype, aantallen, verbose = TRUE) %>% View()


krw_mafa_ekr(test, "soorten", "watertype", "aantallen") #%>% View("monster")
krw_mafa_ekr(test, soorten, watertype, aantallen) %>% View()
krw_mafa_ekr(test, soorten, watertype, aantallen, verbose = TRUE) -> x

test %>% dplyr::left_join(krw_mafa_categorie_2018, by = c(watertype = "krwwatertype.code",soorten =  "biotaxon.naam")) %>% View("test")
