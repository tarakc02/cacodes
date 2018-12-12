---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->


# cacodes

An R package to look up text from [CA Legislative Information](https://leginfo.legislature.ca.gov/)

## how to use


```r
library(cacodes)
codes <- c("PC 602", "VC 23153", "HS 11377(A)")    
leg_info(codes)
#> 
#>  PC 602 ~~~~~~~~~~~~~
#>      Penal Code - PEN PART 1. OF CRIMES AND PUNISHMENTS [25 - 680] TITLE 14.
#>     MALICIOUS MISCHIEF [594 - 625c] 602.   Except as provided in subdivisions (u),
#>     (v), and (x), and Section 602.8, every person who willfully commits a trespass
#>     by any of the following acts is guilty of a misdemeanor: (a) Cutting down,
#>     destroying, or injuring a ...
#> 
#>  VC 23153 ~~~~~~~~~~~~~
#>      Vehicle Code - VEH DIVISION 11. RULES OF THE ROAD [21000 - 23336] CHAPTER 12.
#>     Public Offenses [23100 - 23249.50] ARTICLE 2. Offenses Involving Alcohol and
#>     Drugs [23152 - 23229.1] 23153.   (a) It is unlawful for a person, while under
#>     the influence of any alcoholic beverage, to drive a vehicle and concurrently
#>     do any act forbidden ...
#> 
#>  HS 11377(A) ~~~~~~~~~~~~~
#>      Health and Safety Code - HSC DIVISION 10. UNIFORM CONTROLLED SUBSTANCES ACT
#>     [11000 - 11651] CHAPTER 6. Offenses and Penalties [11350 - 11392] ARTICLE 5.
#>     Offenses Involving Controlled Substances Formerly Classified as Restricted
#>     Dangerous Drugs [11377 - 11382.5] 11377.   (a) Except as authorized by law
#>     and as otherwise provided i ...
```

Using with `data.frame`s:


```r
library(dplyr)
charges <- data_frame(id = 1:3, charge = codes)
charges
#> # A tibble: 3 x 2
#>      id charge     
#>   <int> <chr>      
#> 1     1 PC 602     
#> 2     2 VC 23153   
#> 3     3 HS 11377(A)
charges %>%
    mutate(law = leg_info(charge),
           law_text = as.character(law))
#> # A tibble: 3 x 4
#>      id charge    law          law_text                                   
#>   <int> <chr>     <list>       <chr>                                      
#> 1     1 PC 602    <S3: xml_do… "Penal Code - PEN\nPART 1. OF CRIMES AND P…
#> 2     2 VC 23153  <S3: xml_do… "Vehicle Code - VEH\nDIVISION 11. RULES OF…
#> 3     3 HS 11377… <S3: xml_do… "Health and Safety Code - HSC\nDIVISION 10…
```

## Installation

This package is still under development. The development version can be installed from GitHub using the [devtools pacakge](https://cran.r-project.org/package=devtools)

``` r
devtools::install_github("tarakc02/cacodes")
```
