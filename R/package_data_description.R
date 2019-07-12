#' KRW-maatlatten: Macrofauna categorieen
#'
#' Aanduiding voor macrofauna taxa of een taxon voor een bepaald watertype behoort 
#' tot de positieve (P), kenmerkende (K) of negatieve (N) soorten. Deze tabel gaat over alle watertypen
#' maar alleen over de maatlatten van 2018.
#'
#' @format 
#' Dataframe
#' 
#' - `biotaxon.naam` Naam van het biotaxon, inclusief ondersoorten die niet expliciet in het
#' maatlatdocument zijn opgenomen.
#' - `krwwatertype.code` KRW-watertypecode
#' - `categorie` Categorie van het taxon voor het betreffende watertype. 
#' Mogelijk categorieen zijn:
#'     - **P** - Positief taxon
#'     - **K** - Kenmerkend taxon
#'     - **N** - Negatief taxon
#' 
#' @details 
#' 
#' Macrofauna kan getoetst worden voor de Kaderrichtlijn Water d.m.v. zogenaamde maatlatten. 
#' De documentatie voor deze maatlatten kan gevonden worden op de website van [STOWA](www.stowa.nl). 
#' Het betreft:
#' 
#' - Referenties en maatlatten voor natuurlijke watertypen voor de Kaderrichtlijn Water 2021-2027
#' - Omschrijving MEP en maatlatten voor sloten en kanalen voor de Kaderrichtlijn Water 2021-2027
#' 
#' 
#' @section Metadata dataset: 
#' 
#' - **Naam:** Macrofauna-categorieen
#' - **Oorspronkelijke Naam:** Somparametersamenstelling, de macrofauna-categorieen zijn hier een subset van.
#' - **Bronhouder:** IHW (voor Aquo-kit) en STOWA voor de onderliggende data
#' - **Herkomst:** Aquo-kit <https://www.aquo-kit.nl/>
#' - **Auteurs:** Diverse
#' - **Datum dataset:** 2018
#' - **Datum opname dataset:** 6-7-2019
#' - **Gebruiksrechten:** Onbeperkt
#' - **Soortgroep:** Macrofauna
#' 
#' @note 
#' 
#' In deze tabel zijn alleen de categorieën van de maatlat van 2018 opgenomen.
#' 
#' @section Bewerkingen:
#' 
#' De kolomnamen zijn omgezet naar lowercase.
#' 
#' @seealso 
#' 
#' Verwijzing
#' 
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
#' @examples 
#' 
#' head(krw_mafa_categorie_2018)
"krw_mafa_categorie_2018"


#' KRW-maatlatten: Macrofauna constanten
#'
#' Constanten per watertype die nodig zijn voor de berekening van de EKR voor macrofauna. In deze tabel
#' zijn alleen de constanten voor de maatlat van 2018 opgenomen.
#'
#' @format 
#' Dataframe
#' 
#' - `krwwatertype.code` KRW-watertypecode
#' - `chloride_min` Ondergrens van de chlorideconcentratie in mg/l. Alleen voor watertype M30.
#' - `chloride_max`Bovengrens van de chlorideconcentratie in mg/l. Alleen voor watertype M30.
#' - `kmmax` Maximaal aantal kenmerkende taxa. Alleen voor natuurlijke watertypen
#' - `ptmax` Maximaal aantal positieve taxa. Alleen voor kunstmatige watertypen
#' - `dnmax` Maximaal aandeel in de abundantie. Alleen voor
#' 
#' @details 
#' 
#' Macrofauna kan getoetst worden voor de Kaderrichtlijn Water d.m.v. zogenaamde maatlatten. 
#' De documentatie voor deze maatlatten kan gevonden worden op de website van [STOWA](www.stowa.nl). 
#' Het betreft:
#' 
#' - Referenties en maatlatten voor natuurlijke watertypen voor de Kaderrichtlijn Water 2021-2027
#' - Omschrijving MEP en maatlatten voor sloten en kanalen voor de Kaderrichtlijn Water 2021-2027
#' 
#' 
#' @section Metadata dataset: 
#' 
#' - **Naam:** Macrofauna-constanten
#' - **Oorspronkelijke Naam:** 35xMacrofauna-constanten-berekening-kwaliteitselement_yyyymmdduummss.csv
#' - **Bronhouder:** IHW (voor Aquo-kit) en STOWA voor de onderliggende data
#' - **Herkomst:** Aquo-kit <https://www.aquo-kit.nl/>
#' - **Auteurs:** Diverse
#' - **Datum dataset:** 2018
#' - **Datum opname dataset:** 6-7-2019
#' - **Gebruiksrechten:** Onbeperkt
#' - **Soortgroep:** Macrofauna
#' 
#' @note 
#' 
#' In deze tabel zijn alleen de constanten van de maatlat van 2018 opgenomen.
#' 
#' @section Bewerkingen:
#' 
#' De kolomnamen zijn omgezet naar lowercase.
#' 
#' De kolomnamen van de chlorideconcentraties zijn omgezet naar een meer computervriendelijke naam.
#' 
#' @seealso 
#' 
#' Verwijzing
#' 
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
#' @examples 
#' 
#' head(krw_mafa_constanten_2018)
"krw_mafa_constanten_2018"