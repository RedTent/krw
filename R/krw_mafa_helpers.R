n_to_abund <- function(x){
  
  abund <- 
    x %>% 
    log() %>% 
    +1.5 %>% 
    floor() %>% 
    ifelse(. > 9 , 9, .)
  
  abund
}


# pt aantal pos taxa, 
# dn_perc 100 * abundantie_N gedeeld door som_abundantie_tot
# pt_perc, 100 * pos-taxa gedeeld door tot_n_taxa, 
# km_perc, 100 * pos-taxa gedeeld door tot_n_taxa, 
ekr_formule_m_typen <- function(pt, pt_perc, ptmax, dn_perc, dnmax, km_perc, kmmax, ...){
  if (!is.na(ptmax) & ptmax > 0) {
    pt_frac <- pt / ptmax
    dn_frac <- dn_perc / dnmax
    
    ekr <- (2 * pt_frac + 1 - dn_frac) / 3
    return(ekr)
  }
  
  if (!is.na(kmmax) & kmmax > 0) {
    km_frac <- km_perc / kmmax
    # dn_frac <- dn_perc / 100
    
    ekr <- ((200 * km_frac) + 100 - dn_perc + km_perc + pt_perc) / 400
    
    
    return(ekr)
  }
  message("Er gaat iets mis")
}
