#' Toevoegen van de abundantieklasse
#' 
#' Deze functie voegt aan een dataframe een kolom `abundantieklasse` toe met de driedelige 
#' abundantieklassen die bij de KRW-toetsing van macrofyten wordt gebruikt. De functie kan 
#' zowel percentages als de 9-delige STOWA-klasse (afgeleid van Tansley en/of Braun-Blanquet)
#' omzetten in de abundantieklassen.
#'
#' @param df Een dataframe met vegetatiegegevens
#' @param bedekking Naam van de kolom met de waarden van de bedekking. Mag met en zonder "".
#' @param type `"percentage"` of `"klasse"`. Geeft aan of in de kolom `bedekking` percentages of 
#' klassen (1 t/m 9) staan.
#'
#' @return Het input dataframe met een toegevoegde kolom `abundantieklasse`
#' @export
#'
#' @note 
#' Missende en/of ongeldige waarden (bijv. 0, <0% klasse 1.5 of klasse 10) worden 
#' omgezet in `NA`. In deze gevallen geeft de functie wel een melding dat deze 
#' waarden geen correcte waarden zijn.
#' 
#'
#' @examples
#' test <- tibble::tribble(
#' ~naam, ~bedekkingspercentage, ~klasse,
#' "c",                     1,       1,
#' "e",                     5,       3,
#' "f",                    25,       4,
#' "g",                    49,       7,
#' "h",                    50,       8,
#' "i",                    51,       9
#' )
#' 
#' add_abundantieklasse(test, bedekkingspercentage, type = "percentage")
#' add_abundantieklasse(test, "bedekkingspercentage", type = "percentage")
#' 
#' add_abundantieklasse(test, klasse, type = "klasse")
#' 
add_abundantieklasse <- function(df, bedekking, type = "percentage") {
  
  bedekking <- rlang::ensym(bedekking)
  
  bedekkingen <-
    dplyr::pull(df, !!bedekking)
  if (any(is.na(bedekkingen))) warning("Er ontbreken bedekkingen in de bedekking-kolom")
  
  #percentages
  if (type == "percentage") {
    if (any(bedekkingen > 100)) warning("Bedekkingspercentages kunnen niet boven de 100% uitkomen")
    if (any(bedekkingen <= 0)) message("Bedekkingspercentages met de waarde 0 of kleiner krijgen de waarde NA")
    
    result <- 
      df %>%
      dplyr::mutate(abundantieklasse = dplyr::case_when(
        is.na(!!bedekking) ~ NA_integer_,
        !!bedekking <= 0   ~ NA_integer_,
        !!bedekking < 5    ~ 1L,
        !!bedekking <= 50  ~ 2L,
        !!bedekking > 50   ~ 3L,
        TRUE                 ~ NA_integer_
      ))
  }
  
  #bedekkingsklasse
  if (type == "klasse") {
    if (any(!bedekkingen %in% seq(1,9))) warning("Klassen kunnen alleen de waarden 1 tot en met 9 hebben, andere waarden krijgen de waarde NA")
    
    result <- 
      df %>%
      dplyr::mutate(abundantieklasse = dplyr::case_when(
        is.na(!!bedekking)        ~ NA_integer_,
        !!bedekking %in% seq(1,3) ~ 1L,
        !!bedekking %in% seq(4,7) ~ 2L,
        !!bedekking %in% seq(8,9) ~ 3L,
        TRUE                        ~ NA_integer_
      ))
  }
  
  result
}
