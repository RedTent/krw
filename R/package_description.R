#' krw: Een package om EKR-scores uit te rekenen
#'
#' Functies voor om EKR-scores te bepalen volgens de maatlatten van 2018. 
#' Zie voor meer informatie de package-website <https://redtent.github.io/krw/> 
#' of de Github pagina: <https://github.com/RedTent/krw>
#' 
#'
#' @docType package
#' @name krw
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1")  {
  utils::globalVariables(c(".",
                           "abundantie",
                           "categorie",
                           "abund_dn",
                           "abund_tot",
                           "pt",
                           "n_taxa",
                           "n_tot",
                           "km",
                           "ekr_mafa",
                           "krw_mafa_constanten_2018",
                           "krw_mafa_categorie_2018",
                           "ept_taxa",
                           "abund_pt_km",
                           "score",
                           "groep",
                           "ekr_ss_tot",
                           "ekr_ss_helo",
                           "ekr_ss_hydro",
                           "ekr_ss_mafy",
                           "krw_mafy_taxonscore_2018",
                           "krw_mafy_constanten_2018",
                           "chloride_min",
                           "chloride_max"
                           
))
}
