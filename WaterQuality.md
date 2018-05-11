Exploring water quality
================
Nicolas F. S-Gelais
2018-05-07

### Read files

Import the canadian rivers dataset data on stations and the canadian guidelines

``` r
library(knitr)
library(kableExtra)
library(ReporteRs)
library(maps)
library(fmsb)
library(ggplot2)
library(tidyr)
rm(list=ls(all=TRUE))
source("R/functions.R")
load("data/dataCDN.RData")
load("data/sitesClassfc.RData")
load("data/critLimdoc.RData")
colFreq<-function(x)sum(!is.na(x))/length(x)
```

### 1. Compare ecoservices guidelines

In this table, we compare the proportion of guidelines in each group (columns) that are used for each ecoservice (rows). For irrigation and livestock, most guidelines are for pesticides and metals, while for drinking and aquatic wildlife, most guidelines are for pesticides and organic chemicals. For recreational activities guidelines are biollogical, physical and ph, while for trophic state guidelines are mostly for inorganic chemicals (i.e. nutrients).

(add a venn diagram for guidelines overlap?)

<img src="figures/Explore guidelines -1.png" style="display: block; margin: auto;" /> <img src="figures/map -1.png" style="display: block; margin: auto;" />

    ## png 
    ##   2

    ## [1] 0.08627159

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
freq
</th>
<th style="text-align:left;">
Chemical.groups
</th>
<th style="text-align:left;">
aquatic
</th>
<th style="text-align:left;">
drink
</th>
<th style="text-align:left;">
irrigation
</th>
<th style="text-align:left;">
livestock
</th>
<th style="text-align:left;">
mesotrophic
</th>
<th style="text-align:left;">
oligotrophic
</th>
<th style="text-align:left;">
recreational
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
fc
</td>
<td style="text-align:right;">
8.63
</td>
<td style="text-align:left;">
Biological
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
11
</td>
<td style="text-align:left;">
100
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
200
</td>
</tr>
<tr>
<td style="text-align:left;">
chloride
</td>
<td style="text-align:right;">
76.78
</td>
<td style="text-align:left;">
Inorganic chemical
</td>
<td style="text-align:left;">
120000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
fluoride
</td>
<td style="text-align:right;">
15.51
</td>
<td style="text-align:left;">
Inorganic chemical
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
1500
</td>
<td style="text-align:left;">
1000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
nitrate
</td>
<td style="text-align:right;">
73.65
</td>
<td style="text-align:left;">
Inorganic chemical
</td>
<td style="text-align:left;">
13000
</td>
<td style="text-align:left;">
45000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
nitrite
</td>
<td style="text-align:right;">
80.73
</td>
<td style="text-align:left;">
Inorganic chemical
</td>
<td style="text-align:left;">
11820
</td>
<td style="text-align:left;">
3000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
10000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
arsenic
</td>
<td style="text-align:right;">
23.99
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
100
</td>
<td style="text-align:left;">
25
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
cadmium
</td>
<td style="text-align:right;">
60.02
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
0.09
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
5.1
</td>
<td style="text-align:left;">
80
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
copper
</td>
<td style="text-align:right;">
75.98
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
iron
</td>
<td style="text-align:right;">
77.20
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
300
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
5000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
lead
</td>
<td style="text-align:right;">
48.54
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
200
</td>
<td style="text-align:left;">
100
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
molybdenum
</td>
<td style="text-align:right;">
59.11
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
73
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
500
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
nickel
</td>
<td style="text-align:right;">
62.00
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
25
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
200
</td>
<td style="text-align:left;">
1000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
uranium
</td>
<td style="text-align:right;">
25.82
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
15
</td>
<td style="text-align:left;">
20
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
200
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
zinc
</td>
<td style="text-align:right;">
75.33
</td>
<td style="text-align:left;">
Metal
</td>
<td style="text-align:left;">
30
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
50000
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:right;">
28.42
</td>
<td style="text-align:left;">
Nutrients
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
1500
</td>
<td style="text-align:left;">
700
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
tp
</td>
<td style="text-align:right;">
96.10
</td>
<td style="text-align:left;">
Nutrients
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
75
</td>
<td style="text-align:left;">
25
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
toluene
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:left;">
Organic chemical
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
60
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
24
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
atrazine
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:left;">
Pesticide
</td>
<td style="text-align:left;">
1.8
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
bromoxynil
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:left;">
Pesticide
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
0.33
</td>
<td style="text-align:left;">
11
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
dicamba
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:left;">
Pesticide
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
0.006
</td>
<td style="text-align:left;">
122
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
metolachlor
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:left;">
Pesticide
</td>
<td style="text-align:left;">
7.8
</td>
<td style="text-align:left;">
50
</td>
<td style="text-align:left;">
28
</td>
<td style="text-align:left;">
50
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
simazine
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:left;">
Pesticide
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
0.5
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>
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
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
oligotrophic
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
0.85
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.71
</td>
<td style="text-align:right;">
1
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
0.39
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
1
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
0.18
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
0.31
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
aquatic
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
0.81
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
0.66
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
recreational
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.66
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
0.78
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
drink
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
irrigation
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
livestock
</td>
<td style="text-align:right;">
0.33
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
In this dataset, 32 % of sites were oligotrophic, 39 % mesotrophic and 18% eutrophic. Only 22% of the samples were suitable for aquatic life, 66% for swimming and 15% for drinking. For gricultural use, in 51% of the samples the water was usable for irrigation and 100% for livestock.

When the water is oligotrophic are more often suitable for aquatic life (29%), recreation (85%), drinking (25%) and irrigation (71%) than mesotrpohic and eutrophic samples.

Because, the drinking and livestock criteria were met in the vast majority of samples, they were not included in the analyses.

    ##        [,1]
    ## red   0.116
    ## green 0.828
    ## blue  0.116

<img src="figures/radar plot  -1.png" style="display: block; margin: auto;" /><img src="figures/radar plot  -2.png" style="display: block; margin: auto;" />

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
