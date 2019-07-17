
# taxon + watertype + abundantie = score
# 
# taxon + watertype = groep
# 
# 
# temp %>% left_join(test)  
# 
# dataframe --> join scores+groep --> summarise ekr_NA ekr_hydro ekr_helo

# temp <- tibble::tibble(mp = c("A", "A", "B", "B"),
#                        biotaxon.naam = c("Acorus calamus", "Berula erecta", "Chara vulgaris", "Elodea nuttallii"), 
#                        krwwatertype.code = c("M10", "M10", "M10", "M10"), 
#                        abundantieklasse = c(1, 1, 1, 1)
# ) #%>% dplyr::group_by(mp)
# 
# temp2 <- tibble::tibble(mp = c("A", "A", "B", "B"),
#                        biotaxon.naam = c("Acorus calamus", "Berula erecta", "Chara vulgaris", "Elodea nuttallii"), 
#                        krwwatertype.code = c("M10", "M10", "M10", "M10"), 
#                        abundantieklasse = c(1, 1, 1, 1)
# ) %>% dplyr::group_by(mp)
# 
# temp3 <- tibble::tibble(mp = c("A", "A", "B", "B"),
#                        biotaxon.naam = c("Acorus calamus", "Berula erecta", "Chara vulgaris", "Elodea nuttallii"), 
#                        krwwatertype.code = c("M10", "M10", "M10", "M10"), 
#                        abundantieklasse = c(1, 1, 1, 1)
# ) %>% dplyr::group_by(mp)
# 
# controle_fun <- function(df, krwwatertype.code, biotaxon.naam, abundantieklasse){
#   
#   #Waarschuwingen
#   df_abundanties <- dplyr::pull(df, {{abundantieklasse}}) 
#   if (any(!df_abundanties %in% c(0, 1, 2, 3)) ) warning("De abundantie mag alleen de waarde 1, 2, of 3 hebben")
#   
#   
#   df %>% 
#     dplyr::rename(biotaxon.naam = {{biotaxon.naam}}, krwwatertype.code = {{krwwatertype.code}}, abundantieklasse = {{abundantieklasse}}) %>% 
#     dplyr::select(dplyr::group_vars(df), krwwatertype.code, biotaxon.naam, abundantieklasse) %>% 
#     dplyr::left_join(krw_mafy_taxonscore_2018, by = c("krwwatertype.code", "biotaxon.naam", "abundantieklasse"))
# }

krw_mafy_ekr_ss <- function(df, krwwatertype.code, biotaxon.naam, abundantieklasse, verbose = FALSE){
  
  #Waarschuwingen
  df_abundanties <- dplyr::pull(df, {{abundantieklasse}}) 
  if (any(!df_abundanties %in% c(0, 1, 2, 3)) ) warning("De abundantie mag alleen de waarde 1, 2, of 3 hebben")
  
  
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
    dplyr::left_join(krw_mafy_constanten_2018) %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(ekr_ss_tot   = purrr::pmap_dbl(., ss_formule_tot),
                  ekr_ss_hydro = purrr::pmap_dbl(., ss_formule_hydro),
                  ekr_ss_helo  = purrr::pmap_dbl(., ss_formule_helo),
                  ekr_ss_mafy  = ifelse(is.na(ekr_ss_tot), (2 * ekr_ss_hydro + ekr_ss_helo) / 3, ekr_ss_tot)
                  )
  
  if (!verbose) {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_ss_mafy, ekr_ss_hydro, ekr_ss_helo, ekr_ss_tot)
  } else {
    ekrs <- ekrs %>% dplyr::select(dplyr::group_vars(df), krwwatertype.code, ekr_ss_mafy, ekr_ss_hydro, ekr_ss_helo, ekr_ss_tot, dplyr::everything())
  }
 
  ekrs 
}

# #devtools::load_all()
# krw_mafy_ekr_ss(temp, krwwatertype.code, biotaxon.naam, abundantieklasse)
# krw_mafy_ekr_ss(temp, krwwatertype.code, biotaxon.naam, abundantieklasse, verbose = TRUE) %>% View()
# controle_fun(temp, krwwatertype.code, biotaxon.naam, abundantieklasse) %>% View()


