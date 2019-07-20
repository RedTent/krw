library(tidyverse)

watertype_met_groep <- c("M10", "M1a", "M1b", "M3", "M6a", "M6b", "M7a", "M7b", "M8", "M2", "M4", "M9")

krw_mafy_categorie <- 
  read_csv2("data-raw/krw_toetsing/250aMacrofyten-categorieen_20190625215518.csv", 
                          col_types = "cc_ci_" ) %>% 
  rename_all(tolower) %>% 
  filter(!(is.na(groep) & krwwatertype.code %in% watertype_met_groep))

krw_mafy_score <- read_csv2("data-raw/krw_toetsing/250cMacrofyten_scores_20190625220752.csv",
                            col_types = "cciii_") %>% 
  rename_all(tolower) %>% 
  rename(abundantieklasse = abundatieklasse)

krw_mafy_taxonscore_2018 <- krw_mafy_categorie %>% left_join(krw_mafy_score) %>% select(-categorie)

krw_mafy_constanten_2018 <- 
  read_csv2("data-raw/krw_toetsing/250dMacrofyten_constanten-a-b_20190625221227.csv",
            col_types = "ccii_") %>% 
  rename_all(tolower) %>% 
  filter(!(is.na(groep) & krwwatertype.code %in% watertype_met_groep)) %>% 
  gather(key = constante_type, value = constante_waarde, -groep, -krwwatertype.code) %>% 
  unite(constanten, groep, constante_type) %>% 
  spread(key = constanten, value = constante_waarde) %>% 
  rename(A_helo  = Helofyten_constante_a,
         B_helo  = Helofyten_constante_b,
         A_hydro = Hydrofyten_constante_a,
         B_hydro = Hydrofyten_constante_b,
         A_tot   = NA_constante_a,
         B_tot   = NA_constante_b)

use_data(krw_mafy_taxonscore_2018,
         krw_mafy_constanten_2018,
         overwrite = TRUE
         )
