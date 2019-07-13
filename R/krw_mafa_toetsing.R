# voor M-typen m.u.v. M30 voor de maatlatten van 2018

#' KRW-toetsing macrofauna
#'
#' Deze functie voert de KRW-toetsing voor macrofauna uit voor een of meerdere monsters. De toetsing is gebaseerd op de 
#' maatlatten uit het jaar 2018.
#'
#' @param df Een dataframe met macrofauna-data. Als het dataframe meerdere monsters bevat
#' moet dit dataframe een *grouped dataframe* worden met de functie [dplyr::group_by()]
#' @param biotaxon.naam Naam van de kolom met de taxonnamen.
#' @param krwwatertype.code Naam van de kolom met de KRW-watertype code
#' @param waarde Naam van de kolom met aantallen van het betreffende taxon.
#' @param verbose Logical. Als `TRUE` dan worden behalve de EKR ook de onderliggende parameters
#' en constanten in de uitvoer meegenomen. Deze zijn vooral relevant om e.e.a. te kunnen controleren.
#'
#' @return Een dataframe met groepkolommen (alleen indien van toepassing), het watertype en de macrofauna EKR.
#' @export
#' 
#' @details 
#' 
#' De kolomnamen van de kolommen met taxon, watertype en waarde kunnen zowel met als zonder quotes ("") 
#' worden ingevoerd door het gebruik van non-standard-evaluation (NSE).
#' 
#' @note 
#' 
#' Het is van belang dat de biotaxonnamen in de TWN-lijst voorkomen. De KRW-watertypecode dient overeen te komen met de
#' codes uit de codes uit de aquo-standaard.
#' 
#' Deze functie is niet geschikt voor de watertypen M30 en R8. 
#' 
#' @examples
#' \dontrun{
#' 
#' # Een enkel monster
#' 
#' krw_mafa_ekr(df_1_monster, taxon, watertype, aantallen)
#' krw_mafa_ekr(df_1_monster, "taxon", "watertype", "aantallen")
#' 
#' 
#' # Meerdere monsters in 1 dataframe
#' 
#' grouped_df <- group_by(df_meerdere_monsters, meetpunt, datum)
#' krw_mafa_ekr(grouped_df, taxon, watertype, aantallen)  
#' 
#' # of met het pipe-teken (%>%)
#' 
#' df_meerdere_monsters %>% 
#'   group_by(meetpunt, datum) %>% 
#'   krw_mafa_ekr(taxon, watertype, aantallen)
#' 
#' }
#' 
#' 
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
    dplyr::ungroup() %>% 
    
    # berekening
    dplyr::mutate(ekr_mafa = purrr::pmap_dbl(., ekr_formule))
  
  
  if (!verbose) {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_mafa)
  } else {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_mafa, dplyr::everything()) 
  }
    
  
  ekrs
}

