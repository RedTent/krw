# omrekenfunctie van aantallen naar abundanties
n_to_abund <- function(x){
  
  abund <- 
    x %>% 
    log() %>% 
    +1.5 %>% 
    floor() %>% 
    ifelse(. > 9, 9, .)
  
  abund
}

ept_factor <- function(taxa, krwwatertype.code){
  
  if (!krwwatertype.code %in% c("R7", "R16")) return(1)
  
  families <- unique(twn::increase_taxonlevel(taxa, "Familia"))
  
  aantal_ept_families <- sum(families %in% krw::ept_families)
  
  ept_factor <- min(c(1, 0.6 + aantal_ept_families * 0.1))
  
}


# pt aantal pos taxa, 
# dn_perc 100 * abundantie_N gedeeld door som_abundantie_tot
# pt_perc, 100 * pos-taxa gedeeld door tot_n_taxa, 
# km_perc, 100 * pos-taxa gedeeld door tot_n_taxa, 
ekr_formule <- function(pt, ptmax, dn_abund_perc, dnmax, pt_km_abund_perc, km_perc, kmmax, krwwatertype.code, ept_factor, ...){
  
  # Kunstmatige wateren M1 t/m M10
  if (!is.na(ptmax) & ptmax > 0) {
    pt_frac <- pt / ptmax
    dn_frac <- dn_abund_perc / dnmax
    
    ekr <- (2 * pt_frac + 1 - dn_frac) / 3
    ekr <- max(0, ekr)
    return(ekr)
  }
  
  # Natuurlijke wateren
  if (!is.na(kmmax) & kmmax > 0) {
    # Afwijkende weegfactor voor negatieve taxa voor de meeste stromende wateren
    stromende_wateren_fact <- c("R4", "R5", "R6", "R7", "R12", "R13", "R14", "R15", "R16", "R17", "R18")
    R_fact <- ifelse(krwwatertype.code %in% stromende_wateren_fact, 1, 0)
    
    km_frac <- min(km_perc / kmmax, 1)
    
    ekr <- ept_factor * ((200 * km_frac) + (1 + R_fact) * (100 - dn_abund_perc) + pt_km_abund_perc) / (400 + R_fact * 100)
    ekr <- max(0, ekr)
    return(ekr)
  }
  
  return(NA_real_)
}
