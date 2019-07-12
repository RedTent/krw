#' krw: Een package om EKR-scores uit te rekenen
#'
#' Functies voor om EKR-scores te bepalen volgens de maatlatten van 2018. 
#' Deze functies zijn vooralsnog uitsluitend bedoeld voor de toetsing van M-typen.
#' Zie voor meer informatie: <https://github.com/RedTent/krw>
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
                           "krw_mafa_categorie_2018"
))
}