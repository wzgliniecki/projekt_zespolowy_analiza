# Metoda predykcji Random Forest
# Wykorzystuje bibliotekę randomForest do treningu i predykcji

# Zainstaluj pakiet jeśli nie istnieje
if (!requireNamespace("randomForest", quietly = TRUE)) {
  install.packages("randomForest")
}

random_forest_predict <- function(train_data, newdata, target_col = "NAME_CONTRACT_STATUS", 
                                 ntree = 100, seed = 42) {
  library(randomForest)
  set.seed(seed)
  
  # Jeśli zmienna celu nie istnieje, zwróć błąd
  if (!target_col %in% names(train_data)) {
    stop(paste("Kolumna celu", target_col, "nie istnieje w danych!"))
  }
  
  # Usuń wiersze z NA w zmiennej celu
  train_data <- train_data[!is.na(train_data[[target_col]]), ]
  
  # Wybierz tylko kolumny numeryczne (predyktory)
  numeric_cols <- sapply(train_data, is.numeric)
  X_train <- train_data[, numeric_cols]
  
  # Usuń kolumny identyfikacyjne i kolumny z wszystkimi NA
  id_cols <- c("SK_ID_PREV", "SK_ID_CURR")
  X_train <- X_train[, !names(X_train) %in% id_cols]
  X_train <- X_train[, colSums(is.na(X_train)) < nrow(X_train)]
  
  # Imputacja NA - średnia dla każdej kolumny
  for (col in names(X_train)) {
    if (any(is.na(X_train[[col]]))) {
      X_train[[col]][is.na(X_train[[col]])] <- mean(X_train[[col]], na.rm = TRUE)
    }
  }
  
  # Zmienna celu - konwertuj na factor
  y_train <- as.factor(train_data[[target_col]])
  
  # Walidacja
  if (nrow(X_train) == 0 || ncol(X_train) == 0 || length(unique(y_train)) < 2) {
    stop("Brak wystarczających danych do trenowania modelu klasyfikacji!")
  }
  
  cat("Zmienne do trenowania modelu:\n")
  cat("  Liczba predyktorów:", ncol(X_train), "\n")
  cat("  Liczba obserwacji:", nrow(X_train), "\n")
  cat("  Liczba klas:", length(unique(y_train)), "\n")
  cat("  Klasy:", paste(unique(y_train), collapse = ", "), "\n")
  
  # Trenuj model Random Forest
  rf_model <- randomForest(
    x = X_train,
    y = y_train,
    ntree = ntree
  )
  
  # Przygotuj dane testowe - wybierz te same kolumny
  newdata_clean <- newdata[, intersect(names(newdata), names(X_train)), drop = FALSE]
  
  # Imputacja NA w danych testowych
  for (col in names(newdata_clean)) {
    if (any(is.na(newdata_clean[[col]]))) {
      newdata_clean[[col]][is.na(newdata_clean[[col]])] <- mean(X_train[[col]], na.rm = TRUE)
    }
  }
  
  # Przewidywania dla danych testowych
  if (nrow(newdata_clean) > 0) {
    predictions <- predict(rf_model, newdata_clean, type = "prob")
  } else {
    # Jeśli brak danych do predykcji, zwróć dummy predictions
    predictions <- matrix(NA, nrow = 0, ncol = length(unique(y_train)))
  }
  
  # Zwróć wyniki
  list(
    model = rf_model,
    predictions = predictions,
    predictors = names(X_train),
    classes = unique(y_train),
    importance = importance(rf_model)
  )
}
