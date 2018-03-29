Exploring water quality
================
Nicolas F. S-Gelais
2018-03-29

### Read files

Import the canadian rivers dataset data on stations and the canadian guidelines

``` r
library(knitr)
library(kableExtra)
library(ReporteRs)
library(maps)
library(ggplot2)
rm(list=ls(all=TRUE))
source("R/functions.R")
load("data/dataCDN.RData")
load("data/sitesClassdoc.RData")
load("data/critLimdoc.RData")
```

### 1. Compare ecoservices guidelines

In this table, we compare the proportion of guidelines in each group (columns) that are used for each ecoservice (rows). For irrigation and livestock, most guidelines are for pesticides and metals, while for drinking and aquatic wildlife, most guidelines are for pesticides and organic chemicals. For recreational activities guidelines are biollogical, physical and ph, while for trophic state guidelines are mostly for inorganic chemicals (i.e. nutrients).

(add a venn diagram for guidelines overlap?)

<img src="figures/Explore guidelines -1.png" style="display: block; margin: auto;" /> <img src="figures/map -1.png" style="display: block; margin: auto;" />

    ## png 
    ##   2

### 2.Compare ecoservices in the dataset

In this table, we compare the occurence of the different ecoservices in the dataset. On the diagonal of this table, the proportion of sites for which a given criteria was met is reported. Outside the diagonal we are reporting how often the column criteria is met when the row criteria is met.

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
oligotrophic
</th>
<th style="text-align:right;">
mesotrophic
</th>
<th style="text-align:right;">
eutrophic
</th>
<th style="text-align:right;">
aquatic
</th>
<th style="text-align:right;">
recreational
</th>
<th style="text-align:right;">
drink
</th>
<th style="text-align:right;">
irrigation
</th>
<th style="text-align:right;">
livestock
</th>
<th style="text-align:right;">
DOC
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
oligotrophic
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.45
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.93
</td>
</tr>
<tr>
<td style="text-align:left;">
mesotrophic
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
0.61
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.76
</td>
</tr>
<tr>
<td style="text-align:left;">
eutrophic
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
0.91
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.59
</td>
</tr>
<tr>
<td style="text-align:left;">
aquatic
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.93
</td>
</tr>
<tr>
<td style="text-align:left;">
recreational
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.90
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.84
</td>
</tr>
<tr>
<td style="text-align:left;">
drink
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.87
</td>
</tr>
<tr>
<td style="text-align:left;">
irrigation
</td>
<td style="text-align:right;">
0.50
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
0.97
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.85
</td>
</tr>
<tr>
<td style="text-align:left;">
livestock
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.90
</td>
<td style="text-align:right;">
0.45
</td>
<td style="text-align:right;">
0.97
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.85
</td>
</tr>
<tr>
<td style="text-align:left;">
DOC
</td>
<td style="text-align:right;">
0.54
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
0.92
</td>
<td style="text-align:right;">
0.45
</td>
<td style="text-align:right;">
0.98
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.84
</td>
</tr>
</tbody>
</table>
In this dataset, 49 % of sites were oligotrophic, 19 % mesotrophic and 17% eutrophic. Only 26% of the samples were suitable for aquatic life, 90% for swimming and 43% for drinking. For gricultural use, in 97% of the samples the water was usable for irrigation and 100% for livestock.

When the water is oligotrophic are more often suitable for aquatic life (45%), recreation (99%), drinking (37%) and irrigation (100%) than mesotrpohic and eutrophic samples.

Because, the drinking and livestock criteria were met in the vast majority of samples, they were not included in the analyses.

#### Ecoservices PCA

------------------------------------------------------------------------

In the ecoservices PCA, the first and second axes are mainly trophic axes, on which, all ecoservices are more associated with oligotrophic water. On the third axis, we see a strong association between recreational and irrgations services, and between aquatic wildlife and drinking, but a negative association between the two groups. By looking at the ecoservices guideline table, it make sense that aquatic wildlife and drinking are associated, as their respectives guidelines are similar, but it isn't the case for irrigation and recreation. <img src="figures/services PCA-1.png" style="display: block; margin: auto;" /><img src="figures/services PCA-2.png" style="display: block; margin: auto;" />

#### Comparing the limiting guidelines

------------------------------------------------------------------------

In this table we compare the limiting guidelines for each ecoservice. For each guideline, we report how often when a sample cannot provide an ecoservice a specific guideline responsible for the none compliance. For trophic status, when a sample change from one trophic status to the other, TN and TP are almost always both over the guideline (Even if TP was measure more often)
<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:center;">
alkalinity
</th>
<th style="text-align:center;">
arsenic
</th>
<th style="text-align:center;">
atrazine
</th>
<th style="text-align:center;">
bromoxynil
</th>
<th style="text-align:center;">
cadmium
</th>
<th style="text-align:center;">
chla
</th>
<th style="text-align:center;">
chloride
</th>
<th style="text-align:center;">
copper
</th>
<th style="text-align:center;">
dic
</th>
<th style="text-align:center;">
dicamba
</th>
<th style="text-align:center;">
do
</th>
<th style="text-align:center;">
doc
</th>
<th style="text-align:center;">
fc
</th>
<th style="text-align:center;">
fluoride
</th>
<th style="text-align:center;">
hardness
</th>
<th style="text-align:center;">
iron
</th>
<th style="text-align:center;">
lead
</th>
<th style="text-align:center;">
metolachlor
</th>
<th style="text-align:center;">
molybdenum
</th>
<th style="text-align:center;">
nickel
</th>
<th style="text-align:center;">
nitrate
</th>
<th style="text-align:center;">
nitrite
</th>
<th style="text-align:center;">
simazine
</th>
<th style="text-align:center;">
tn
</th>
<th style="text-align:center;">
toluene
</th>
<th style="text-align:center;">
tp
</th>
<th style="text-align:center;">
turbidity
</th>
<th style="text-align:center;">
uranium
</th>
<th style="text-align:center;">
zinc
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
aquatic
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.06
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.65
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.18
</td>
<td style="text-align:center;">
0.43
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.53
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.48
</td>
<td style="text-align:center;">
0.43
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0.03
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0.04
</td>
</tr>
<tr>
<td style="text-align:left;">
irrigation
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.05
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.74
</td>
<td style="text-align:center;">
0.01
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.13
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.1
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
recreational
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.99
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
drink
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.94
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.02
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
eutrophic
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.86
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.97
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
mesotrophic
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.91
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.91
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
oligotrophic
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.67
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.9
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
livestock
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.45
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.06
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0.78
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
DOC
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
</tbody>
</table>
