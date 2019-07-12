# voor M-typen m.u.v. M30 voor de maatlatten van 2018
krw_mafa_ekr <- function(df, biotaxon.naam, krwwatertype.code , waarde, verbose = FALSE){
  
  ekrs <- 
    df %>% 
    dplyr::rename(biotaxon.naam = {{biotaxon.naam}}, krwwatertype.code = {{krwwatertype.code}}, waarde = {{waarde}}) %>% 
    dplyr::select(dplyr::group_vars(df), biotaxon.naam, krwwatertype.code, waarde) %>% 
    
    dplyr::mutate(abundantie = n_to_abund(waarde)) %>% 
    
    dplyr::left_join(krw_mafa_categorie_2018, by = c("krwwatertype.code", "biotaxon.naam")) %>% 
    dplyr::summarise(krwwatertype.code = dplyr::first(krwwatertype.code),
              n_taxa = dplyr::n_distinct(biotaxon.naam),
              abund_tot = sum(abundantie),
              abund_dn = sum(abundantie[categorie == "N"], na.rm = TRUE),
              dn_perc = 100 * abund_dn / abund_tot,
              pt = sum(categorie == "P", na.rm = TRUE),
              pt_perc = 100 * pt / n_taxa,
              km = sum(categorie == "K", na.rm = TRUE),
              km_perc = 100 * km / n_taxa) %>% 
    dplyr::left_join(krw_mafa_constanten_2018, by = "krwwatertype.code") %>% 
    
    dplyr::mutate(ekr_mafa = purrr::pmap_dbl(., ekr_formule_m_typen))
  
  
  if (!verbose) {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_mafa)
  }
  
  ekrs
}

