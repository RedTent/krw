
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Package krw

<!-- badges: start -->

<!-- badges: end -->

Het doel van het package **krw** is om KRW-toetsingen uit te kunnen
voeren in R. Het package is te installeren vanaf
[GitHub](https://github.com/) met:

``` r
# install.packages("devtools")
devtools::install_github("RedTent/krw")
```

Op dit moment zijn de volgende soortgroepen geimplementeerd.

  - Macrofauna
      - *m.u.v M30, R8 en K- en O-typen*

## Macrofauna

Dit is een simpel voorbeeld van de KRW-toetsing van macrofauna.

Eerst maken we twee eenvoudige datasets.

``` r
library(krw)

dataset1 <- 
  tibble::tribble(
    ~meetpunt, ~krwwatertype.code,              ~taxon, ~aantal,
          "A",              "M27", "Asellus aquaticus",     100,
          "A",              "M27",      "Baetis niger",      20,
          "A",              "M27",    "Caenis horaria",      40,
    )

dataset2 <- 
  tibble::tribble(
     ~meetpunt, ~jaar, ~krwwatertype.code,              ~taxon, ~aantal,
           "A",  2018,              "M1a", "Asellus aquaticus",     100,
           "A",  2018,              "M1a",      "Baetis niger",      20,
           "B",  2018,               "R6", "Asellus aquaticus",     100,
           "B",  2018,               "R6",      "Baetis niger",      20,
           "B",  2019,               "R6", "Asellus aquaticus",     150,
           "B",  2019,               "R6",      "Baetis niger",      35
     )
```

### Toetsing van een enkel monster

De toetsing van een enkel monster kan eenvoudig worden uitgevoerd met de
functie `krw_mafa_ekr()`.

``` r

krw_mafa_ekr(dataset1, 
             biotaxon.naam = taxon, 
             krwwatertype.code = krwwatertype.code, 
             waarde = aantal)
#> # A tibble: 1 x 2
#>   krwwatertype.code ekr_mafa
#>   <chr>                <dbl>
#> 1 M27                  0.233

# 
# krw:::krw_mafa_ekr(dataset1, biotaxon.naam = "taxon", 
#                    krwwatertype.code = "krwwatertype.code", waarde = "aantal")
# 
# Meer detail informatie kan worden verkregen met de optie `verbose = TRUE`
```

### Toetsing van meerdere monsters

Meerdere monsters kunnen met tegelijk met dezelfde functie worden
getoetst. Het is hiervoor wel noodzakelijk dat het dataframe met de
dataset wordt gegroepeerd per monster met de functie `group_by` uit de
package `dplyr`.

``` r
suppressMessages(
  library(dplyr)
  )

dataset2 %>% 
  dplyr::group_by(meetpunt, jaar) %>% 
  krw_mafa_ekr(biotaxon.naam = taxon, 
               krwwatertype.code = krwwatertype.code, 
               waarde = aantal)
#> # A tibble: 3 x 4
#>   meetpunt  jaar krwwatertype.code ekr_mafa
#>   <chr>    <dbl> <chr>                <dbl>
#> 1 A         2018 M1a                  0    
#> 2 B         2018 R6                   0.64 
#> 3 B         2019 R6                   0.673
```
