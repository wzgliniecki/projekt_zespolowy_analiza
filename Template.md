Identyfikacja docelowych odbiorców pożyczki
================
Julia Labuda (191145), Wojciech Zgliniecki (154790)

## Wprowadzenie

Celem tego projektu jest analiza danych poprzednich aplikacji w celu
wyodrębnienia informacji, które mogą pomóc w zrozumieniu zachowania
klientów i ulepszeniu procesów podejmowania decyzji.

## Pytania Badawcze

1.  Pierwsze pytanie
2.  Drugie pytanie

# **Wstęp**

Studium przypadku „Kredyty – Identyfikacja docelowych odbiorców
pożyczki” koncentruje się na analizie ryzyka w procesie udzielania
finansowania klientom. Wykorzystując techniki eksploracyjnej analizy
danych (EDA), projekt ma na celu zrozumienie, w jaki sposób cechy
konsumentów oraz parametry pożyczek wpływają na prawdopodobieństwo
terminowej spłaty zobowiązań.

Firmy udzielające pożyczek stoją przed podwójnym wyzwaniem: z jednej
strony ryzykują utratę potencjalnych zysków, jeśli odrzucą wnioski
klientów zdolnych do spłaty, z drugiej – mogą ponieść straty finansowe,
jeśli zaakceptują wnioski osób, które nie wywiążą się ze zobowiązań.
Dlatego kluczowe jest zidentyfikowanie zmiennych, które są silnymi
wskaźnikami niewypłacalności.

### Dane

W niniejszym projekcie wykorzystane zostaną dane z pliku
„previous_application_new.csv”, zawierającego informacje o decyzjach
kredytowych (zatwierdzone, anulowane, odrzucone, niewykorzystane), oraz
słownik zmiennych „opis_zmiennych.xlsx”, który ułatwi interpretację
atrybutów. Analiza pozwoli wskazać wzorce zachowań klientów i czynniki
ryzyka, które mogą wspierać proces podejmowania decyzji kredytowych.

### Repozytorium na GitHub

Prace zostały wykonane z użyciem systemu kontroli wersji Git, a jako
zdalne miejsce do przechowania repozytorium wykorzystano platformę
GitHub.

Link do
repozytorium:<https://github.com/wzgliniecki/projekt_zespolowy_analiza.git>

### Użyte biblioteki

Podczas analizy użyto następujących bibliotek:

``` r
library(readr)
library(gt)
library(tidyverse)
library(naniar)
library(VIM)
library(ggplot2)
library(kableExtra)
library(dplyr)
library(tidyr)
library(corrplot)
library(ggstatsplot)
```

#### Wczytanie i wizualizacja danych

W tabeli pokazano 10 pierwszych wierszy zbioru danych. Można zauważyć,
że w zbiorze występują brakujące dane.

``` r
dane <- read_csv("Data/previous_application_new.csv")
```

Zbiór previous_application_new.csv zawiera 25 000 obserwacji oraz 37
zmiennych.

16 zmiennych jest typu tekstowego (chr) – np. NAME_CONTRACT_TYPE,
WEEKDAY_APPR_PROCESS_START, FLAG_LAST_APPL_PER.

21 zmiennych to zmienne numeryczne (dbl) – np. SK_ID_PREV, SK_ID_CURR,
AMT_ANNUITY, AMT_APPLICATION, AMT_CREDIT.

Dane obejmują zarówno informacje opisowe, jak i wartości liczbowe
związane z kwotami i identyfikatorami. Dzięki temu możliwa jest analiza
zarówno jakościowa, jak i ilościowa wniosków kredytowych.

``` r
gt(head(dane,10))
```

<div id="obyqxhwpar" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#obyqxhwpar table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#obyqxhwpar thead, #obyqxhwpar tbody, #obyqxhwpar tfoot, #obyqxhwpar tr, #obyqxhwpar td, #obyqxhwpar th {
  border-style: none;
}
&#10;#obyqxhwpar p {
  margin: 0;
  padding: 0;
}
&#10;#obyqxhwpar .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#obyqxhwpar .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#obyqxhwpar .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#obyqxhwpar .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#obyqxhwpar .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#obyqxhwpar .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#obyqxhwpar .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#obyqxhwpar .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#obyqxhwpar .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#obyqxhwpar .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#obyqxhwpar .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#obyqxhwpar .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#obyqxhwpar .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#obyqxhwpar .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#obyqxhwpar .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#obyqxhwpar .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#obyqxhwpar .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#obyqxhwpar .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#obyqxhwpar .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#obyqxhwpar .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#obyqxhwpar .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#obyqxhwpar .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#obyqxhwpar .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#obyqxhwpar .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#obyqxhwpar .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#obyqxhwpar .gt_left {
  text-align: left;
}
&#10;#obyqxhwpar .gt_center {
  text-align: center;
}
&#10;#obyqxhwpar .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#obyqxhwpar .gt_font_normal {
  font-weight: normal;
}
&#10;#obyqxhwpar .gt_font_bold {
  font-weight: bold;
}
&#10;#obyqxhwpar .gt_font_italic {
  font-style: italic;
}
&#10;#obyqxhwpar .gt_super {
  font-size: 65%;
}
&#10;#obyqxhwpar .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#obyqxhwpar .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#obyqxhwpar .gt_indent_1 {
  text-indent: 5px;
}
&#10;#obyqxhwpar .gt_indent_2 {
  text-indent: 10px;
}
&#10;#obyqxhwpar .gt_indent_3 {
  text-indent: 15px;
}
&#10;#obyqxhwpar .gt_indent_4 {
  text-indent: 20px;
}
&#10;#obyqxhwpar .gt_indent_5 {
  text-indent: 25px;
}
&#10;#obyqxhwpar .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#obyqxhwpar div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="SK_ID_PREV">SK_ID_PREV</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="SK_ID_CURR">SK_ID_CURR</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_CONTRACT_TYPE">NAME_CONTRACT_TYPE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="AMT_ANNUITY">AMT_ANNUITY</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="AMT_APPLICATION">AMT_APPLICATION</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="AMT_CREDIT">AMT_CREDIT</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="AMT_DOWN_PAYMENT">AMT_DOWN_PAYMENT</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="AMT_GOODS_PRICE">AMT_GOODS_PRICE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="WEEKDAY_APPR_PROCESS_START">WEEKDAY_APPR_PROCESS_START</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="HOUR_APPR_PROCESS_START">HOUR_APPR_PROCESS_START</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="FLAG_LAST_APPL_PER_CONTRACT">FLAG_LAST_APPL_PER_CONTRACT</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="NFLAG_LAST_APPL_IN_DAY">NFLAG_LAST_APPL_IN_DAY</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="RATE_DOWN_PAYMENT">RATE_DOWN_PAYMENT</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="RATE_INTEREST_PRIMARY">RATE_INTEREST_PRIMARY</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="RATE_INTEREST_PRIVILEGED">RATE_INTEREST_PRIVILEGED</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_CASH_LOAN_PURPOSE">NAME_CASH_LOAN_PURPOSE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_CONTRACT_STATUS">NAME_CONTRACT_STATUS</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_DECISION">DAYS_DECISION</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_PAYMENT_TYPE">NAME_PAYMENT_TYPE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="CODE_REJECT_REASON">CODE_REJECT_REASON</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_TYPE_SUITE">NAME_TYPE_SUITE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_CLIENT_TYPE">NAME_CLIENT_TYPE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_GOODS_CATEGORY">NAME_GOODS_CATEGORY</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_PORTFOLIO">NAME_PORTFOLIO</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_PRODUCT_TYPE">NAME_PRODUCT_TYPE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="CHANNEL_TYPE">CHANNEL_TYPE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="SELLERPLACE_AREA">SELLERPLACE_AREA</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_SELLER_INDUSTRY">NAME_SELLER_INDUSTRY</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="CNT_PAYMENT">CNT_PAYMENT</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="NAME_YIELD_GROUP">NAME_YIELD_GROUP</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="PRODUCT_COMBINATION">PRODUCT_COMBINATION</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_FIRST_DRAWING">DAYS_FIRST_DRAWING</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_FIRST_DUE">DAYS_FIRST_DUE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_LAST_DUE_1ST_VERSION">DAYS_LAST_DUE_1ST_VERSION</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_LAST_DUE">DAYS_LAST_DUE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="DAYS_TERMINATION">DAYS_TERMINATION</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="NFLAG_INSURED_ON_APPROVAL">NFLAG_INSURED_ON_APPROVAL</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">1044104</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">358675</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">NA</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">0</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">0</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">NA</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">FRIDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">16</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Canceled</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-169</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">XNA</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Credit and cash offices</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">XNA</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">XNA</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">1228470</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">344960</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">16015.860</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">378000</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">378000</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">378000</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">SUNDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">12</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Refused</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-474</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">HC</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">Cash</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">x-sell</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Contact center</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">XNA</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">36</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">low_normal</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash X-Sell: low</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">1212786</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">208259</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Consumer loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">6190.965</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">30141</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">31635</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">0</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">30141</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">THURSDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">20</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">0.0000000</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XAP</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Approved</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-2226</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">Cash through the bank</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">Unaccompanied</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">Photo / Cinema Equipment</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">POS</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Country-wide</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">1500</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">Consumer electronics</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">6</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">high</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">POS household with interest</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">365243</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">-2195</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">-2045</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">-2045</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">-2041</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">0</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">2750575</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">293651</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">12598.200</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">67500</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">67500</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">67500</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">WEDNESDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">9</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Approved</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-486</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">Cash through the bank</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">Cash</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">x-sell</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Country-wide</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">60</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">Furniture</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">6</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">middle</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash X-Sell: middle</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">365243</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">-456</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">-306</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">-306</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">-300</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">0</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">2188643</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">251267</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">16591.500</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">135000</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">135000</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">0</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">135000</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">SATURDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">20</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">0.0000000</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Approved</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-2799</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Refreshed</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">Cash</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">x-sell</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Country-wide</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">Consumer electronics</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">10</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">middle</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash Street: middle</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">365243</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">-2769</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">-2499</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">-2499</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">-2490</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">0</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">2337373</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">394154</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Consumer loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">39423.150</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">3015000</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">1035000</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">1980000</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">3015000</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">SATURDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">9</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">0.7152239</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XAP</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Refused</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-789</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">Cash through the bank</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">VERIF</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">New</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">Cars</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Car dealer</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">329</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">Industry</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">36</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">low_normal</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">POS industry with interest</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">1169959</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">365865</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">NA</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">0</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">0</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">NA</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">WEDNESDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">9</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Refused</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-245</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">HC</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">XNA</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Credit and cash offices</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">XNA</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">XNA</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">2405817</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">158643</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">NA</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">0</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">0</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">NA</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">FRIDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">20</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Canceled</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-283</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">XNA</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Contact center</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">XNA</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">XNA</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">1101830</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">447361</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Consumer loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">6290.730</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">55386</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">55386</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">0</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">55386</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">MONDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">18</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">0.0000000</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XAP</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Approved</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-21</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">Cash through the bank</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">Mobile</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">POS</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Country-wide</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">25</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">Connectivity</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">10</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">low_normal</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">POS mobile without interest</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">365243</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">365243</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">282</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">365243</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">365243</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">0</td></tr>
    <tr><td headers="SK_ID_PREV" class="gt_row gt_right">2176627</td>
<td headers="SK_ID_CURR" class="gt_row gt_right">106729</td>
<td headers="NAME_CONTRACT_TYPE" class="gt_row gt_left">Cash loans</td>
<td headers="AMT_ANNUITY" class="gt_row gt_right">NA</td>
<td headers="AMT_APPLICATION" class="gt_row gt_right">0</td>
<td headers="AMT_CREDIT" class="gt_row gt_right">0</td>
<td headers="AMT_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="AMT_GOODS_PRICE" class="gt_row gt_right">NA</td>
<td headers="WEEKDAY_APPR_PROCESS_START" class="gt_row gt_left">MONDAY</td>
<td headers="HOUR_APPR_PROCESS_START" class="gt_row gt_right">6</td>
<td headers="FLAG_LAST_APPL_PER_CONTRACT" class="gt_row gt_left">Y</td>
<td headers="NFLAG_LAST_APPL_IN_DAY" class="gt_row gt_right">1</td>
<td headers="RATE_DOWN_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIMARY" class="gt_row gt_right">NA</td>
<td headers="RATE_INTEREST_PRIVILEGED" class="gt_row gt_right">NA</td>
<td headers="NAME_CASH_LOAN_PURPOSE" class="gt_row gt_left">XNA</td>
<td headers="NAME_CONTRACT_STATUS" class="gt_row gt_left">Canceled</td>
<td headers="DAYS_DECISION" class="gt_row gt_right">-381</td>
<td headers="NAME_PAYMENT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CODE_REJECT_REASON" class="gt_row gt_left">XAP</td>
<td headers="NAME_TYPE_SUITE" class="gt_row gt_left">NA</td>
<td headers="NAME_CLIENT_TYPE" class="gt_row gt_left">Repeater</td>
<td headers="NAME_GOODS_CATEGORY" class="gt_row gt_left">XNA</td>
<td headers="NAME_PORTFOLIO" class="gt_row gt_left">XNA</td>
<td headers="NAME_PRODUCT_TYPE" class="gt_row gt_left">XNA</td>
<td headers="CHANNEL_TYPE" class="gt_row gt_left">Credit and cash offices</td>
<td headers="SELLERPLACE_AREA" class="gt_row gt_right">-1</td>
<td headers="NAME_SELLER_INDUSTRY" class="gt_row gt_left">XNA</td>
<td headers="CNT_PAYMENT" class="gt_row gt_right">NA</td>
<td headers="NAME_YIELD_GROUP" class="gt_row gt_left">XNA</td>
<td headers="PRODUCT_COMBINATION" class="gt_row gt_left">Cash</td>
<td headers="DAYS_FIRST_DRAWING" class="gt_row gt_right">NA</td>
<td headers="DAYS_FIRST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE_1ST_VERSION" class="gt_row gt_right">NA</td>
<td headers="DAYS_LAST_DUE" class="gt_row gt_right">NA</td>
<td headers="DAYS_TERMINATION" class="gt_row gt_right">NA</td>
<td headers="NFLAG_INSURED_ON_APPROVAL" class="gt_row gt_right">NA</td></tr>
  </tbody>
  &#10;</table>
</div>

Tabela przedstawia pierwsze 10 wierszy zbioru danych. Widać, że liczba
zmiennych jest duża (37 kolumn). Już na tym etapie można zauważyć
obecność brakujących wartości (NA), co wskazuje na konieczność dalszej
analizy braków danych i ich wpływu na wyniki.

# **Data Cleansing, Wrangling**

### Początkowa liczba i proporcje NA

Najpierw sprawdzono liczbę braków w każdej kolumnie, aby zidentyfikować
zmienne najbardziej narażone na problem niekompletnych informacji.

``` r
kolumny_NA <- colSums(is.na(dane))
sort(kolumny_NA[kolumny_NA>0])
```

    ##       PRODUCT_COMBINATION               AMT_ANNUITY               CNT_PAYMENT 
    ##                         4                      5589                      5589 
    ##           AMT_GOODS_PRICE        DAYS_FIRST_DRAWING            DAYS_FIRST_DUE 
    ##                      5754                      9940                      9940 
    ## DAYS_LAST_DUE_1ST_VERSION             DAYS_LAST_DUE          DAYS_TERMINATION 
    ##                      9940                      9940                      9940 
    ## NFLAG_INSURED_ON_APPROVAL           NAME_TYPE_SUITE          AMT_DOWN_PAYMENT 
    ##                      9940                     12246                     13261 
    ##         RATE_DOWN_PAYMENT     RATE_INTEREST_PRIMARY  RATE_INTEREST_PRIVILEGED 
    ##                     13261                     24922                     24922

Braki występują w wielu kolumnach, a ich skala jest zróżnicowana:

- Najmniej braków ma zmienna PRODUCT_COMBINATION – tylko 4 przypadki, co
  oznacza, że praktycznie cała informacja jest dostępna.

- Średni poziom braków obserwujemy w zmiennych finansowych:

  - AMT_ANNUITY oraz CNT_PAYMENT – po 5589 braków każda,

  - AMT_GOODS_PRICE – 5754 braków.

- Znaczne braki pojawiają się w zmiennych związanych z terminami, gdzie
  każda z poniższych kolumn ma dokładnie 9940 braków:

  - DAYS_FIRST_DRAWING,

  - DAYS_FIRST_DUE,

  - DAYS_LAST_DUE_1ST_VERSION,

  - DAYS_LAST_DUE,

  - DAYS_TERMINATION,

  - NFLAG_INSURED_ON_APPROVAL.

- Jeszcze większe braki występują w:

  - NAME_TYPE_SUITE – 12246 braków,

  - AMT_DOWN_PAYMENT oraz RATE_DOWN_PAYMENT – po 13261 braków każda.

- Najwięcej braków mają zmienne dotyczące stóp procentowych:

  - RATE_INTEREST_PRIMARY oraz RATE_INTEREST_PRIVILEGED – po 24922
    braków każda, czyli niemal cały zbiór.

``` r
kolumny_z_NA <- names(which(colSums(is.na(dane)) > 0))
vis_miss(dane[, kolumny_z_NA], warn_large_data = FALSE)
```

![](Template_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
missing_summary <- data.frame(
  variable = names(dane),
  n_missing = colSums(is.na(dane)),
  perc_missing = colMeans(is.na(dane)) * 100
)
missing_summary%>%
  filter(n_missing>0)%>%
  arrange(perc_missing)
```

    ##                                            variable n_missing perc_missing
    ## PRODUCT_COMBINATION             PRODUCT_COMBINATION         4        0.016
    ## AMT_ANNUITY                             AMT_ANNUITY      5589       22.356
    ## CNT_PAYMENT                             CNT_PAYMENT      5589       22.356
    ## AMT_GOODS_PRICE                     AMT_GOODS_PRICE      5754       23.016
    ## DAYS_FIRST_DRAWING               DAYS_FIRST_DRAWING      9940       39.760
    ## DAYS_FIRST_DUE                       DAYS_FIRST_DUE      9940       39.760
    ## DAYS_LAST_DUE_1ST_VERSION DAYS_LAST_DUE_1ST_VERSION      9940       39.760
    ## DAYS_LAST_DUE                         DAYS_LAST_DUE      9940       39.760
    ## DAYS_TERMINATION                   DAYS_TERMINATION      9940       39.760
    ## NFLAG_INSURED_ON_APPROVAL NFLAG_INSURED_ON_APPROVAL      9940       39.760
    ## NAME_TYPE_SUITE                     NAME_TYPE_SUITE     12246       48.984
    ## AMT_DOWN_PAYMENT                   AMT_DOWN_PAYMENT     13261       53.044
    ## RATE_DOWN_PAYMENT                 RATE_DOWN_PAYMENT     13261       53.044
    ## RATE_INTEREST_PRIMARY         RATE_INTEREST_PRIMARY     24922       99.688
    ## RATE_INTEREST_PRIVILEGED   RATE_INTEREST_PRIVILEGED     24922       99.688

Analizuje wiersze, które mają po 5589 braków

``` r
dane_na_annuity <- dane[is.na(dane$AMT_ANNUITY), ]
table(dane_na_annuity$NAME_CONTRACT_STATUS)
```

    ## 
    ##     Canceled      Refused Unused offer 
    ##         4599          596          394

Powinniśmy chyba rozdzielić klientów, którzy mieli faktycznie wyliczoną
ratę, od tych, którzy nie doszli do etapu umowy. NA to nie brak, tylko
wynika z logiki procesu.

Analizuje wiersze, które mają równo po 9940 braków - możliwe powiązanie

``` r
table(dane$NAME_CONTRACT_STATUS, useNA = "ifany")
```

    ## 
    ##     Approved     Canceled      Refused Unused offer 
    ##        15663         4741         4194          402

``` r
dane_na <- dane[is.na(dane$DAYS_FIRST_DRAWING), ]
table(dane_na$NAME_CONTRACT_STATUS)
```

    ## 
    ##     Approved     Canceled      Refused Unused offer 
    ##          603         4741         4194          402

Z 9940 braków w DAYS_FIRST_DRAWING, 99337 nie doszło do skutku, więc
realnie mamy tylko 603 NA. Do analizy co z tym robimy, może warto
rozdzielić klientów od tych których wniosek faktycznie był uruchomiony
od tych którzy nie mają żadnej historii? Wydaje mi się że powinniśmy ich
analizować osobno

``` r
dane_goodp <- dane[is.na(dane$AMT_GOODS_PRICE), ]
table(dane_goodp$NAME_CONTRACT_STATUS)
```

    ## 
    ## Approved Canceled  Refused 
    ##      632     4596      526

Nadal 632 NA to były zaakceptowane wnioski - do analizy co robimy.
Pozostałe braki: NAME_TYPE_SUITE (kto towarzyszył klientowi) - Prawie
połowa braków (49%), braki są naturalne, bo klient mógł przyjść sam albo
bank nie zbierał tej informacji, do analizy co z tym

AMT_DOWN_PAYMENT (wpłata własna) + RATE_DOWN_PAYMENT (procent wkładu
własnego) - Ponad 53% braków, braki logiczne: jeśli klient nie wnosił
wkładu własnego, pole pozostaje puste, możemy zamienić NA na 0 (brak
wpłaty) albo zostawić jako NA

RATE_INTEREST_PRIMARY i RATE_INTEREST_PRIVILEGED (oprocentowanie) -
prawie 100% braków (99,7%) - to zmienne praktycznie bezużyteczne – nie
ma danych, najlepiej je usunąć ze zbioru, bo nie wniosą informacji.

``` r
naniar::vis_miss(dane, warn_large_data = FALSE)
```

![](Template_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
library(VIM)
aggr(dane, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(dane), cex.axis=.7, gap=3, ylab=c("Procent braków danych","Wzorzec braków danych"))
```

![](Template_files/figure-gfm/unnamed-chunk-10-2.png)<!-- -->

    ## 
    ##  Variables sorted by number of missings: 
    ##                     Variable   Count
    ##        RATE_INTEREST_PRIMARY 0.99688
    ##     RATE_INTEREST_PRIVILEGED 0.99688
    ##             AMT_DOWN_PAYMENT 0.53044
    ##            RATE_DOWN_PAYMENT 0.53044
    ##              NAME_TYPE_SUITE 0.48984
    ##           DAYS_FIRST_DRAWING 0.39760
    ##               DAYS_FIRST_DUE 0.39760
    ##    DAYS_LAST_DUE_1ST_VERSION 0.39760
    ##                DAYS_LAST_DUE 0.39760
    ##             DAYS_TERMINATION 0.39760
    ##    NFLAG_INSURED_ON_APPROVAL 0.39760
    ##              AMT_GOODS_PRICE 0.23016
    ##                  AMT_ANNUITY 0.22356
    ##                  CNT_PAYMENT 0.22356
    ##          PRODUCT_COMBINATION 0.00016
    ##                   SK_ID_PREV 0.00000
    ##                   SK_ID_CURR 0.00000
    ##           NAME_CONTRACT_TYPE 0.00000
    ##              AMT_APPLICATION 0.00000
    ##                   AMT_CREDIT 0.00000
    ##   WEEKDAY_APPR_PROCESS_START 0.00000
    ##      HOUR_APPR_PROCESS_START 0.00000
    ##  FLAG_LAST_APPL_PER_CONTRACT 0.00000
    ##       NFLAG_LAST_APPL_IN_DAY 0.00000
    ##       NAME_CASH_LOAN_PURPOSE 0.00000
    ##         NAME_CONTRACT_STATUS 0.00000
    ##                DAYS_DECISION 0.00000
    ##            NAME_PAYMENT_TYPE 0.00000
    ##           CODE_REJECT_REASON 0.00000
    ##             NAME_CLIENT_TYPE 0.00000
    ##          NAME_GOODS_CATEGORY 0.00000
    ##               NAME_PORTFOLIO 0.00000
    ##            NAME_PRODUCT_TYPE 0.00000
    ##                 CHANNEL_TYPE 0.00000
    ##             SELLERPLACE_AREA 0.00000
    ##         NAME_SELLER_INDUSTRY 0.00000
    ##             NAME_YIELD_GROUP 0.00000

# Tutaj koniec analizy braków, trzeba to przenieść do odpowiednich rozdziałów.

## Predykcje

Na podstawie załadowanych danych możemy przeprowadzić ich analizę oraz
predykcję.

## Random Forest

``` r
# Załaduj dane (jeśli nie zostały załadowane wcześniej)
if (!exists("dane") || nrow(dane) == 0) {
  dane <- read_csv(here("Data", "previous_application_new.csv"))
}

# Podziel dane na treningowe i testowe (80-20)
set.seed(42)
split_idx <- sample(1:nrow(dane), size = 0.8 * nrow(dane))
train_data <- dane[split_idx, ]
test_data <- dane[-split_idx, ]

# Trenuj model Random Forest
# Zmienne:
#  - target_col = "NAME_CONTRACT_STATUS" (Status umowy: Approved, Cancelled, Denied, Unused)
#  - Predyktory: wszystkie kolumny numeryczne (kwoty, terminy, identyfikatory)
rf_result <- random_forest_predict(
  train_data = train_data,
  newdata = test_data,
  target_col = "NAME_CONTRACT_STATUS",
  ntree = 100
)
```

    ## Zmienne do trenowania modelu:
    ##   Liczba predyktorów: 19 
    ##   Liczba obserwacji: 20000 
    ##   Liczba klas: 4 
    ##   Klasy: Canceled, Approved, Unused offer, Refused

``` r
cat("\nModel Random Forest wytrenowany!\n")
```

    ## 
    ## Model Random Forest wytrenowany!

### Wyniki predykcji

``` r
# Pokaż pierwsze 10 predykcji
head_predictions <- head(rf_result$predictions, 10)
kable(
  data.frame(
    Obs = 1:nrow(head_predictions),
    head_predictions
  ),
  caption = "Pierwsze 10 predykcji (prawdopodobieństwa dla każdej klasy)",
  digits = 4
)
```

| Obs | Approved | Canceled | Refused | Unused.offer |
|----:|---------:|---------:|--------:|-------------:|
|   1 |     1.00 |     0.00 |    0.00 |            0 |
|   2 |     0.00 |     1.00 |    0.00 |            0 |
|   3 |     0.09 |     0.13 |    0.78 |            0 |
|   4 |     0.09 |     0.07 |    0.84 |            0 |
|   5 |     1.00 |     0.00 |    0.00 |            0 |
|   6 |     1.00 |     0.00 |    0.00 |            0 |
|   7 |     1.00 |     0.00 |    0.00 |            0 |
|   8 |     1.00 |     0.00 |    0.00 |            0 |
|   9 |     0.99 |     0.01 |    0.00 |            0 |
|  10 |     1.00 |     0.00 |    0.00 |            0 |

Pierwsze 10 predykcji (prawdopodobieństwa dla każdej klasy)

### Ważność zmiennych

``` r
# Pokaż 10 najważniejszych zmiennych
importance_df <- data.frame(
  Variable = rownames(rf_result$importance),
  Importance = rf_result$importance[, 1]
)
importance_df <- importance_df[order(-importance_df$Importance), ]
head_imp <- head(importance_df, 10)

ggplot(head_imp, aes(x = reorder(Variable, Importance), y = Importance)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "10 najważniejszych zmiennych w Random Forest",
       x = "Zmienna",
       y = "Ważność (Mean Decrease Accuracy)") +
  theme_minimal()
```

![](Template_files/figure-gfm/rf-importance-1.png)<!-- -->

``` r
# Use global_data that was loaded in data_loading section
dane <- global_data$newdata
print_summary(dane)
```

    ## Placeholder podsumowania danych
