Exploring water quality
================
Nicolas F. S-Gelais
2018-02-13

Read files
----------

Import the canadian rivers dataset data on stations and the canadian guidelines

Check units
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
0.33
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
0.74
</td>
<td style="text-align:right;">
0.98
</td>
<td style="text-align:right;">
0.58
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
0.43
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.56
</td>
<td style="text-align:right;">
0.97
</td>
<td style="text-align:right;">
0.39
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
0.25
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
0.93
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
0.46
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.70
</td>
<td style="text-align:right;">
0.97
</td>
<td style="text-align:right;">
0.54
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
0.43
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
0.95
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
drink
</td>
<td style="text-align:right;">
0.33
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
0.41
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
0.46
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
0.41
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
0.43
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
Remove undersired units
