# Analiza decyzji kredytowych

## Opis projektu

Projekt został zrealizowany w ramach przedmiotu **„Analiza danych z R”** i 
obejmuje kompleksowe badanie danych dotyczących decyzji kredytowych. 
Celem pracy było zrozumienie, w jaki sposób parametry finansowe i 
informacje procesowe wpływają na zatwierdzanie, odrzucanie, anulowanie 
lub niewykorzystanie ofert kredytowych. Analiza została przeprowadzona w 
języku R z wykorzystaniem nowoczesnych narzędzi do eksploracji danych, 
wizualizacji oraz modelowania statystycznego.

## Zakres analizy

Praca rozpoczyna się od szczegółowej eksploracji struktury danych, 
identyfikacji braków oraz oceny ich logiki biznesowej. 
Wykryto charakterystyczne bloki braków związane z harmonogramem kredytu, 
ratami czy wkładem własnym, a także anomalie systemowe, 
które wymagały odpowiedniego traktowania podczas czyszczenia danych. 
Proces przygotowania danych obejmował imputację opartą na logice procesów 
kredytowych i usunięcie zmiennych nie dodających żadnej wartości.

W dalszej części przeprowadzono rozbudowaną wizualizację danych,
która pozwoliła uchwycić zależności między kwotami kredytu, liczbą rat, 
typem klienta, kanałem sprzedaży i innymi cechami. Analiza statystyczna 
obejmowała zarówno statystyki opisowe, jak i testy zależności oraz 
porównania między grupami, co umożliwiło identyfikację kluczowych 
czynników różnicujących statusy kontraktów.

Ostatnim etapem było modelowanie predykcyjne. Zbudowano trzy modele 
regresji logistycznej: dwa binarne (zatwierdzenie vs pozostałe decyzje) oraz 
jeden wielokategorialny, pozwalający przewidywać wszystkie statusy kontraktu 
jednocześnie. Modele porównano pod względem jakości predykcji, 
a szczególną uwagę poświęcono roli zmiennych niefinansowych, które 
okazały się istotnie poprawiać dopasowanie modeli.

## Najważniejsze wnioski

Analiza wykazała, że braki danych nie są przypadkowe, lecz wynikają z 
logiki procesu kredytowego. Status kontraktu silnie różnicuje 
parametry finansowe, a wysokie kwoty wiążą się z większym ryzykiem odmowy 
lub rezygnacji. Typ klienta oraz kanał pozyskania mają istotny wpływ na 
decyzję kredytową, a modele predykcyjne potwierdziły, że zmienne 
niefinansowe znacząco zwiększają zdolność wyjaśniania decyzji.

Projekt dostarcza pełnego obrazu funkcjonowania procesu kredytowego, 
łącząc analizę jakości danych, eksplorację statystyczną i modelowanie 
predykcyjne w spójną całość.