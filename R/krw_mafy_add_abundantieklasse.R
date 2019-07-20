add_abundantieklasse <- function(df, bedekking, type = "percentage") {
  
  df <- dplyr::rename(df, bdk_temp = {{bedekking}})
  
  bedekkingen <-
    dplyr::pull(df, bdk_temp)
  if (any(is.na(bedekkingen))) warning("Er ontbreken bedekkingen in de bedekking-kolom")

  #percentages
  if (type == "percentage") {
    if (any(bedekkingen > 100)) warning("Bedekkingspercentages kunnen niet boven de 100% uitkomen")
    if (any(bedekkingen <= 0)) message("Bedekkingspercentages met de waarde 0 of kleiner krijgen de waarde NA")

    result <- 
      df %>%
      dplyr::mutate(abundantieklasse = dplyr::case_when(
        is.na(bdk_temp) ~ NA_integer_,
        bdk_temp <= 0   ~ NA_integer_,
        bdk_temp < 5    ~ 1L,
        bdk_temp <= 50  ~ 2L,
        bdk_temp > 50   ~ 3L,
        TRUE                 ~ NA_integer_
      ))
  }
  
  #bedekkingsklasse
  if (type == "klasse") {
    if (any(!bedekkingen %in% seq(1,9))) warning("Klassen kunnen alleen de waarden 1 tot en met 9 hebben, andere waarden krijgen de waarde NA")

    result <- 
      df %>%
      dplyr::mutate(abundantieklasse = dplyr::case_when(
        is.na(bdk_temp)        ~ NA_integer_,
        bdk_temp %in% seq(1,3) ~ 1L,
        bdk_temp %in% seq(4,7) ~ 2L,
        bdk_temp %in% seq(8,9) ~ 3L,
        TRUE                        ~ NA_integer_
      ))
  }
  # dplyr::select(result, -bdk_temp)
  
  dplyr::rename(result, {{bedekking}} := bdk_temp)
}

