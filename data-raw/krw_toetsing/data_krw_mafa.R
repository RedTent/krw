library(tidyverse)

krw_mafa_categorie_2018 <- 
  read_csv2("data-raw/krw_toetsing/Somparametersamenstelling_20190706.csv") %>% 
  filter(str_detect(Somparameter.code, "MAF_soort")) %>% 
  mutate(categorie = str_remove(str_remove(Somparameter.code, "MAF_soort"), "D")) %>% 
  filter(categorie %in% c("P", "K", "N"), 
         str_detect(Normgroep.omschrijving, "2018")) %>% 
  select(biotaxon.naam = Deelparameter.omschrijving, krwwatertype.code = KRWwatertype.code, categorie) %>% 
  arrange(biotaxon.naam, krwwatertype.code) 

krw_mafa_constanten_2018 <-
  read_delim("data-raw/krw_toetsing/35xMacrofauna-constanten-berekening-kwaliteitselement_20190706134913.csv", 
             delim = ";",
             locale = locale(decimal_mark = ".")) %>%
  rename_all(tolower) %>%
  rename(chloride_min = `chloride(mg/l)_laag`, chloride_max = `chloride(mg/l)_hoog`) %>%
  filter(str_detect(normgroep.omschrijving, "2018")) %>%
  select(-normgroep.omschrijving, -8) %>% 
  rename_at(vars(starts_with("constante_")), str_remove, pattern = "constante_")

ept_taxa <- read_csv2("data-raw/krw_toetsing/340Macrofauna-R8_families-haften-steenvliegen-kokerjuffers_20190713132936.csv") %>% 
  .$Biotaxon.naam

use_data(krw_mafa_categorie_2018,
         krw_mafa_constanten_2018,
         ept_taxa,
         overwrite = TRUE)





