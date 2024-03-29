% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/package_data_description.R
\docType{data}
\name{krw_mafy_constanten_2018}
\alias{krw_mafy_constanten_2018}
\title{KRW-maatlatten: Macrofytenconstanten}
\format{
Dataframe
\itemize{
\item \code{krwwatertype.code} KRW-watertypecode
\item \code{A_helo} A-constante voor helofyten (sloten en kanalen)
\item \code{B_helo} B-constante voor helofyten (sloten en kanalen)
\item \code{A_hydro} A-constante voor hydrofyten (sloten en kanalen)
\item \code{B_hydro} B-constante voor hydrofyten (sloten en kanalen)
\item \code{A_tot} A-constante (natuurlijke watertypen)
\item \code{B_tot} B-constante (natuurlijke watertypen)
}
}
\source{
\href{https://www.aquo-kit.nl/}{Aquo-kit}
}
\usage{
krw_mafy_constanten_2018
}
\description{
Constanten voor de berekening van de macrofyten-EKR voor soortensamenstelling.
}
\details{
Macrofyten kunnen getoetst worden voor de Kaderrichtlijn Water d.m.v. zogenaamde maatlatten.
De documentatie voor deze maatlatten kan gevonden worden op de website van \href{www.stowa.nl}{STOWA}.
Het betreft:
\itemize{
\item Referenties en maatlatten voor natuurlijke watertypen voor de Kaderrichtlijn Water 2021-2027
\item Omschrijving MEP en maatlatten voor sloten en kanalen voor de Kaderrichtlijn Water 2021-2027
}
}
\note{
In deze tabel zijn alleen de constanten van de maatlat van 2018 opgenomen.
}
\section{Metadata dataset}{

\itemize{
\item \strong{Naam:} Macrofyten constanten 2018
\item \strong{Oorspronkelijke Namen:} 250dMacrofyten_constanten-a-b_yyyymmdduummss
\item \strong{Bronhouder:} IHW (voor Aquo-kit) en STOWA voor de onderliggende data
\item \strong{Herkomst:} Aquo-kit \url{https://www.aquo-kit.nl/}
\item \strong{Auteurs:} Diverse
\item \strong{Datum dataset:} 2018
\item \strong{Datum opname dataset:} 25-6-2019
\item \strong{Gebruiksrechten:} Onbeperkt
\item \strong{Soortgroep:} Macrofyten
}
}

\section{Bewerkingen}{


De A en B constanten zijn gesplitst op basis van de groep omdat dit de berekening later vereenvoudigd.

De kolomnamen zijn omgezet naar lowercase.
}

\examples{

head(krw_mafy_taxonscore_2018)
}
\seealso{
AANVULLEN
}
\keyword{datasets}
