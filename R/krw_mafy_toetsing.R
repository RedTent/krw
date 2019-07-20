#' KRW-toetsing macrofyten soortensamenstelling
#' 
#' Deze functie voert de KRW-toetsing uit voor de macrofyten-soortensamenstelling voor een of meerdere monsters. 
#' De toetsing is gebaseerd op de maatlatten uit het jaar 2018.
#'
#' @param df Een dataframe met macrofyten. Als het dataframe meerdere monsters bevat
#' moet dit dataframe een *grouped dataframe* worden met de functie [dplyr::group_by()]
#' @param krwwatertype.code Naam van de kolom met de KRW-watertype code
#' @param biotaxon.naam Naam van de kolom met de taxonnamen.
#' @param abundantieklasse Naam van de kolom met de abundantieklassen van het betreffende taxon. 
#' De abundantieklasse dient de waarde 1, 2, of 3 te bevatten. De functie AANVULLEN kan worden gebruikt
#' om om te rekenen naar abundantieklassen.
#' @param verbose Logical. Als `TRUE` dan worden behalve de EKR ook de onderliggende parameters
#' en constanten in de uitvoer meegenomen. Deze zijn vooral relevant om e.e.a. te kunnen controleren.
#'
#' @return Een dataframe met groepkolommen (alleen indien van toepassing), het watertype en:
#' 
#'  - `ekr_ss_mafy` - de EKR voor de soortensamenstelling
#'  - `ekr_ss_hydrofyten` - de deel-EKR voor de soortensamenstelling hydrofyten (alleen sloten en kanalen)
#'  - `ekr_ss_helofyten` - de deel-EKR voor de soortensamenstelling helofyten (alleen sloten en kanalen)
#'  
#' @export
#'
#' @details 
#' De kolomnamen van de kolommen met taxon, watertype en waarde kunnen zowel met als zonder quotes ("") 
#' worden ingevoerd door het gebruik van non-standard-evaluation (NSE).
#'
#' @note 
#' Het is van belang dat de biotaxonnamen in de TWN-lijst voorkomen. De KRW-watertypecode dient overeen te komen met de
#' codes uit de codes uit de aquo-standaard.
#' 
#' @examples
#' \dontrun{
#' 
#' # Een enkel monster
#' 
#' krw_mafy_ekr_ss(df_1_monster, watertype, taxon, abundantie)
#' krw_mafy_ekr_ss(df_1_monster, "watertype", "taxon", "abundantie")
#'
#'  
#' # Meerdere monsters in 1 dataframe
#' 
#' grouped_df <- group_by(df_meerdere_monsters, meetpunt, datum)
#' krw_mafy_ekr_ss(grouped_df, watertype, taxon, abundantie)  
#' 
#' # of met het pipe-teken (%>%)
#' 
#' df_meerdere_monsters %>% 
#'   group_by(meetpunt, datum) %>% 
#'   krw_mafy_ekr_ss(watertype, taxon, abundantie)
#' 
#' }
krw_mafy_ekr_ss <- function(df, krwwatertype.code, biotaxon.naam, abundantieklasse, verbose = FALSE){
  
  # Waarschuwingen
  df_abundanties <- dplyr::pull(df, {{abundantieklasse}}) 
  if (any(!df_abundanties %in% c(1, 2, 3)) ) warning("De abundantie mag alleen de waarde 1, 2, of 3 hebben")
  
  # Bepalen parameters en berekening ekrs
  ekrs <- 
    df %>% 
    dplyr::rename(biotaxon.naam = {{biotaxon.naam}}, krwwatertype.code = {{krwwatertype.code}}, abundantieklasse = {{abundantieklasse}}) %>% 
    dplyr::select(dplyr::group_vars(df), krwwatertype.code, biotaxon.naam, abundantieklasse) %>% 
    dplyr::left_join(krw_mafy_taxonscore_2018, by = c("krwwatertype.code", "biotaxon.naam", "abundantieklasse")) %>% 
    
    dplyr::summarise(krwwatertype.code = dplyr::first(krwwatertype.code),
                     som_score_tot     = sum(score, na.rm = TRUE),
                     som_score_hydro   = sum(score[groep == "Hydrofyten"], na.rm = TRUE),
                     som_score_helo    = sum(score[groep == "Helofyten"], na.rm = TRUE),
                     n_scorend_tot     = dplyr::n_distinct(biotaxon.naam[!is.na(score)]),
                     n_scorend_hydro   = dplyr::n_distinct(biotaxon.naam[!is.na(score) & groep == "Hydrofyten"]),
                     n_scorend_helo    = dplyr::n_distinct(biotaxon.naam[!is.na(score) & groep == "Helofyten"])
                     ) %>% 
    dplyr::left_join(krw_mafy_constanten_2018, by = "krwwatertype.code") %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(ekr_ss_tot   = purrr::pmap_dbl(., ss_formule_tot),
                  ekr_ss_hydro = purrr::pmap_dbl(., ss_formule_hydro),
                  ekr_ss_helo  = purrr::pmap_dbl(., ss_formule_helo),
                  ekr_ss_mafy  = ifelse(is.na(ekr_ss_tot), (2 * ekr_ss_hydro + ekr_ss_helo) / 3, ekr_ss_tot)
                  )
  
  # Opschonen
  if (!verbose) {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_ss_mafy, ekr_ss_hydro, ekr_ss_helo)
  } else {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_ss_mafy, ekr_ss_hydro, ekr_ss_helo, ekr_ss_tot, dplyr::everything())
  }
 
  ekrs 
}



