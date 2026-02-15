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

# Eksploracja i czyszczenie danych
- identyfikacja braków danych i ich logiki biznesowej,
- wykrycie bloków braków związanych z harmonogramem kredytu, ratami czy wkładem własnym,
- usunięcie zmiennych nieistotnych oraz imputację opartą na procesach kredytowych.

# Analiza statystyczna i wizualizacje
- zależności między kwotą kredytu, liczbą rat, typem klienta, kanałem sprzedaży i innymi cechami,
- statystyki opisowe, testy zależności i porównania między grupami,
- identyfikacja czynników różnicujących statusy kontraktów.

# Modelowanie predykcyjne
- dwa modele regresji logistycznej binarnej,
- jeden model wielokategorialny przewidujący wszystkie statusy kontraktu,
- porównanie jakości predykcji i ocena wpływu zmiennych niefinansowych.

## Najważniejsze wnioski

- Braki danych wynikają z logiki procesu kredytowego, a nie z losowości.
- Status kontraktu silnie różnicuje parametry finansowe.
- Wyższe kwoty kredytu wiążą się z większym ryzykiem odmowy lub rezygnacji.
- Typ klienta i kanał pozyskania mają istotny wpływ na decyzję kredytową.
- Zmienne niefinansowe znacząco poprawiają jakość modeli predykcyjnych.

Projekt łączy analizę jakości danych, eksplorację statystyczną i modelowanie predykcyjne w spójną całość.

Pełny raport dostępny na RPubs: https://rpubs.com/jullab/1391499
