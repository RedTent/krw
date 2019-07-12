library(tidyverse)

krw_mafy_categorie <- 
  read_csv2("data-raw/krw_toetsing/250aMacrofyten-categorieen_20190625215518.csv", 
                          col_types = "cccci_" ) %>% 
  rename_all(tolower)

krw_mafy_score <- read_csv2("data-raw/krw_toetsing/250cMacrofyten_scores_20190625220752.csv",
                            col_types = "cciii_") %>% 
  rename_all(tolower) %>% 
  rename(abundantieklasse = abundatieklasse)

krw_mafy_constanten <- 
  read_csv2("data-raw/krw_toetsing/250dMacrofyten_constanten-a-b_20190625221227.csv",
            col_types = "ccii_") %>% 
  rename_all(tolower)

use_data(krw_mafy_categorie,
         krw_mafy_score,
         krw_mafy_constanten,
         overwrite = TRUE
         )
