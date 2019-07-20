ss_formule <- function(som_score, n_scorend, A, B){
  # Als de A of B ontbreekt
  if (is.na(A) | is.na(B)) return(NA_real_)
  
  # als er geen scorende soorten worden aangetroffen
  if (n_scorend == 0) return(0)
  
  ekr <- (
    (som_score / sqrt(n_scorend)) - (3 / n_scorend) + B
  ) / A
  
  if (n_scorend == 0 | ekr < 0) ekr <- 0
  if (ekr > 1) ekr <- 1
  ekr
}

#Alternatieve argumentnamen om toetsing met purrr::pmap te vereenvoudigen
ss_formule_tot <- function(som_score_tot, n_scorend_tot, A_tot, B_tot, ...){
  ss_formule(som_score = som_score_tot, n_scorend = n_scorend_tot, A = A_tot, B = B_tot)
}

ss_formule_hydro <- function(som_score_hydro, n_scorend_hydro, A_hydro, B_hydro, ...){
  ss_formule(som_score = som_score_hydro, n_scorend = n_scorend_hydro, A = A_hydro, B = B_hydro)
}

ss_formule_helo <- function(som_score_helo, n_scorend_helo, A_helo, B_helo, ...){
  ss_formule(som_score = som_score_helo, n_scorend = n_scorend_helo, A = A_helo, B = B_helo)
}
