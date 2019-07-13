# voor M-typen m.u.v. M30 voor de maatlatten van 2018
krw_mafa_ekr <- function(df, biotaxon.naam, krwwatertype.code, waarde, verbose = FALSE){
  
  #Waarschuwingen
  krwwatertypes <- dplyr::pull(df, {{krwwatertype.code}})
  if (any(krwwatertypes == "M30")) {warning("Deze functie is niet geschikt voor het watertype M30")}
  if (any(krwwatertypes == "R8")) {warning("Deze functie is niet geschikt voor het watertype R8")}

  ekrs <- 
    df %>% 
    # selectie en hernoemen kolommen
    dplyr::rename(biotaxon.naam = {{biotaxon.naam}}, krwwatertype.code = {{krwwatertype.code}}, waarde = {{waarde}}) %>% 
    dplyr::select(dplyr::group_vars(df), biotaxon.naam, krwwatertype.code, waarde) %>% 
    
    # omrekening naar abundanties
    dplyr::mutate(abundantie = n_to_abund(waarde)) %>% 
    
    # berekening inputparameters voor EKR-formule
    dplyr::left_join(krw_mafa_categorie_2018, by = c("krwwatertype.code", "biotaxon.naam")) %>% 
    dplyr::summarise(krwwatertype.code = dplyr::first(krwwatertype.code),
              abund_tot = sum(abundantie),
              abund_dn = sum(abundantie[categorie == "N"], na.rm = TRUE),
              abund_pt_km = sum(abundantie[categorie %in% c("P", "K")], na.rm = TRUE),
              dn_abund_perc = 100 * abund_dn / abund_tot,
              pt_km_abund_perc = 100 * abund_pt_km / abund_tot,
              pt = sum(categorie == "P", na.rm = TRUE),
              km = sum(categorie == "K", na.rm = TRUE),
              n_taxa = dplyr::n_distinct(biotaxon.naam),
              km_perc = 100 * km / n_taxa,
              ept_factor = ept_factor(biotaxon.naam, krwwatertype.code)) %>% 
    dplyr::left_join(krw_mafa_constanten_2018, by = "krwwatertype.code") %>% 
    
    # berekening
    dplyr::mutate(ekr_mafa = purrr::pmap_dbl(., ekr_formule))
  
  
  if (!verbose) {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_mafa)
  } else {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_mafa, dplyr::everything()) 
  }
    
  
  ekrs
}

