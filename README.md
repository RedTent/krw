
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Package krw

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/RedTent/krw.svg?branch=master)](https://travis-ci.org/RedTent/krw)
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
      - *m.u.v R8 en K- en O-typen*
  - Macrofyten
      - Soortensamenstelling

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
functie `krw_mafa_ekr()`. De omrekening van aantallen naar abundanties
wordt automatisch door de functie gedaan.

``` r

krw_mafa_ekr(dataset1, 
             biotaxon.naam = taxon, 
             krwwatertype.code = krwwatertype.code, 
             waarde = aantal,
             verbose = FALSE)
#> # A tibble: 1 x 2
#>   krwwatertype.code ekr_mafa
#>   <chr>                <dbl>
#> 1 M27                  0.233

# Alternatieve notatie
# 
# krw:::krw_mafa_ekr(dataset1, 
#                    biotaxon.naam = "taxon", 
#                    krwwatertype.code = "krwwatertype.code", 
#                    waarde = "aantal")
# 
# Meer detail informatie kan worden verkregen met de optie `verbose = TRUE`
```

### Toetsing van meerdere monsters

Meerdere monsters kunnen met tegelijk met dezelfde functie worden
getoetst. Het is hiervoor wel noodzakelijk dat het dataframe met de
dataset wordt gegroepeerd per monster met de functie `group_by` uit de
package `dplyr`.

``` r
library(dplyr)

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

## Macrofyten - soortensamenstelling

De toetsing voor de macrofytensoortensamenstelling is zeer vergelijkbaar
met de macrofaunatoetsing. Het is mogelijk om meerdere monsters tegelijk
te toetsen door met de functie `dplyr::group_by` van elk monster een
groep te maken.

Eerst maken we weer een testdata set.

``` r
mafy_data <- tibble::tribble(
    ~mp, ~jaar, ~watertype,             ~taxon,     ~waarde,
    "A",  2018,      "M27",   "Acorus calamus",           1,
    "A",  2018,      "M27",    "Berula erecta",           1,
    "A",  2018,      "M27",   "Chara vulgaris",          10,
    "A",  2018,      "M27", "Elodea nuttallii",          30,
    "A",  2019,      "M27",   "Acorus calamus",           1,
    "A",  2019,      "M27",    "Berula erecta",           1,
    "A",  2019,      "M27",   "Chara vulgaris",          30,
    "A",  2019,      "M27", "Elodea nuttallii",          10,
    "B",  2018,      "M10",   "Acorus calamus",           1,
    "B",  2018,      "M10",    "Berula erecta",           1,
    "B",  2018,      "M10",   "Chara vulgaris",          10,
    "B",  2018,      "M10", "Elodea nuttallii",          30,
    "B",  2019,      "M10",   "Acorus calamus",           1,
    "B",  2019,      "M10",    "Berula erecta",           1,
    "B",  2019,      "M10",   "Chara vulgaris",          30,
    "B",  2019,      "M10", "Elodea nuttallii",          10
)
```

Voor macrofyten moet de bedekking eerst omgerekend worden naar een
abundantieklasse. Voor de macrofyten gebeurt dit met de functie
`add_abundantieklasse()`. Deze functie rekent zowel percentages (`type =
"percentage"`) als klassen (1 t/m 9 `type = "klasse"`) om.

Voor de kunstmatige wateren worden ook de onderliggende EKR’s voor
hydrofyten en helofyten weergegeven.

``` r
library(dplyr)

mafy_met_abundantie <- mafy_data %>% 
  add_abundantieklasse(bedekking = waarde, type = "percentage")
head(mafy_met_abundantie)
#> # A tibble: 6 x 6
#>   mp     jaar watertype taxon            waarde abundantieklasse
#>   <chr> <dbl> <chr>     <chr>             <dbl>            <int>
#> 1 A      2018 M27       Acorus calamus        1                1
#> 2 A      2018 M27       Berula erecta         1                1
#> 3 A      2018 M27       Chara vulgaris       10                2
#> 4 A      2018 M27       Elodea nuttallii     30                2
#> 5 A      2019 M27       Acorus calamus        1                1
#> 6 A      2019 M27       Berula erecta         1                1

mafy_met_abundantie %>% 
  dplyr::group_by(mp, jaar) %>% 
  krw_mafy_ekr_ss(krwwatertype.code = watertype, 
                  biotaxon.naam = taxon, 
                  abundantieklasse = abundantieklasse,
                  verbose = FALSE)
#> # A tibble: 4 x 6
#>   mp     jaar krwwatertype.code ekr_ss_mafy ekr_ss_hydro ekr_ss_helo
#>   <chr> <dbl> <chr>                   <dbl>        <dbl>       <dbl>
#> 1 A      2018 M27                     0.420       NA              NA
#> 2 A      2019 M27                     0.420       NA              NA
#> 3 B      2018 M10                     0.444        0.666           0
#> 4 B      2019 M10                     0.444        0.666           0
```
