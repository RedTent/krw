# Macrofauna-data ---------------------------------------------------------

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
#' AANVULLEN
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
#' AANVULLEN
#' 
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
#' @examples 
#' 
#' head(krw_mafa_constanten_2018)
"krw_mafa_constanten_2018"

#' EPT-Families
#'
#' Families die behoren tot de groep Ephemeroptera (haften), Plecoptera (steenvliegen) en Trichoptera (kokerjuffers).
#'
#' @format 
#' Vector met EPT-families
#'
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
"ept_families"


# Macrofyten-data - soortensamenstelling ----------------------------------

#' KRW-maatlatten: Macrofytenscores
#'
#' Score per watertype, taxon en abundantie. Dit is een gecombineerde tabel gebaseerde op de 
#' macrofytencategorieen en de macrofytenscores. Alleen de scores voor de maatlatten van 
#' 2018 zijn opgenomen.
#'
#' @format 
#' Dataframe
#' 
#' - `groep` Hydrofyten of Helofyten. Alleen voor sloten en kanalen, M1 t/m M10.
#' - `biotaxon.naam` Naam van het biotaxon, inclusief ondersoorten die niet expliciet in het
#' maatlatdocument zijn opgenomen.
#' - `krwwatertype.code` KRW-watertypecode
#' - `abundantieklasse` Abundantieklasse: 1, 2 of 3
#' - `score` De score voor de betreffende taxon + watertype + abundantie
#' 
#' @details 
#' 
#' Macrofyten kunnen getoetst worden voor de Kaderrichtlijn Water d.m.v. zogenaamde maatlatten. 
#' De documentatie voor deze maatlatten kan gevonden worden op de website van [STOWA](www.stowa.nl). 
#' Het betreft:
#' 
#' - Referenties en maatlatten voor natuurlijke watertypen voor de Kaderrichtlijn Water 2021-2027
#' - Omschrijving MEP en maatlatten voor sloten en kanalen voor de Kaderrichtlijn Water 2021-2027
#' 
#' 
#' @section Metadata dataset: 
#' 
#' - **Naam:** Macrofyten taxonscores 2018
#' - **Oorspronkelijke Namen:** 
#'     - 250aMacrofyten-categorieen_yyyymmdduummss
#'     - 250cMacrofyten_scores_yyyymmdduummss
#' - **Bronhouder:** IHW (voor Aquo-kit) en STOWA voor de onderliggende data
#' - **Herkomst:** Aquo-kit <https://www.aquo-kit.nl/>
#' - **Auteurs:** Diverse
#' - **Datum dataset:** 2018
#' - **Datum opname dataset:** 25-6-2019
#' - **Gebruiksrechten:** Onbeperkt
#' - **Soortgroep:** Macrofyten
#' 
#' @note 
#' 
#' In deze tabel zijn alleen de scores van de maatlat van 2018 opgenomen.
#' 
#' @section Bewerkingen:
#' 
#' De twee originele tabellen zijn gecombineerd tot 1 tabel.
#' 
#' De kolomnamen zijn omgezet naar lowercase. 
#' 
#' @seealso 
#' 
#' AANVULLEN
#' 
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
#' @examples 
#' 
#' head(krw_mafy_taxonscore_2018)
"krw_mafy_taxonscore_2018"

#' KRW-maatlatten: Macrofytenconstanten
#'
#' Constanten voor de berekening van de macrofyten-EKR voor soortensamenstelling.
#'
#' @format 
#' Dataframe
#' 
#' - `krwwatertype.code` KRW-watertypecode
#' - `A_helo` A-constante voor helofyten (sloten en kanalen)
#' - `B_helo` B-constante voor helofyten (sloten en kanalen)
#' - `A_hydro` A-constante voor hydrofyten (sloten en kanalen)
#' - `B_hydro` B-constante voor hydrofyten (sloten en kanalen)
#' - `A_tot` A-constante (natuurlijke watertypen)
#' - `B_tot` B-constante (natuurlijke watertypen)
#' 
#' @details 
#' 
#' Macrofyten kunnen getoetst worden voor de Kaderrichtlijn Water d.m.v. zogenaamde maatlatten. 
#' De documentatie voor deze maatlatten kan gevonden worden op de website van [STOWA](www.stowa.nl). 
#' Het betreft:
#' 
#' - Referenties en maatlatten voor natuurlijke watertypen voor de Kaderrichtlijn Water 2021-2027
#' - Omschrijving MEP en maatlatten voor sloten en kanalen voor de Kaderrichtlijn Water 2021-2027
#' 
#' 
#' @section Metadata dataset: 
#' 
#' - **Naam:** Macrofyten constanten 2018
#' - **Oorspronkelijke Namen:** 250dMacrofyten_constanten-a-b_yyyymmdduummss
#' - **Bronhouder:** IHW (voor Aquo-kit) en STOWA voor de onderliggende data
#' - **Herkomst:** Aquo-kit <https://www.aquo-kit.nl/>
#' - **Auteurs:** Diverse
#' - **Datum dataset:** 2018
#' - **Datum opname dataset:** 25-6-2019
#' - **Gebruiksrechten:** Onbeperkt
#' - **Soortgroep:** Macrofyten
#' 
#' @note 
#' 
#' In deze tabel zijn alleen de constanten van de maatlat van 2018 opgenomen.
#' 
#' @section Bewerkingen:
#' 
#' De A en B constanten zijn gesplitst op basis van de groep omdat dit de berekening later vereenvoudigd.
#' 
#' De kolomnamen zijn omgezet naar lowercase. 
#' 
#' @seealso 
#' 
#' AANVULLEN
#' 
#' @source 
#' 
#' [Aquo-kit](https://www.aquo-kit.nl/)
#' 
#' @examples 
#' 
#' head(krw_mafy_taxonscore_2018)
"krw_mafy_constanten_2018"
