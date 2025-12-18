# Narodowy Bank Polski — Integracja

## Zakres integracji

Moduł pobiera kursy walut z API Narodowego Banku Polskiego (tabela C). Klient umożliwia pobranie ostatnich *N* notowań dla wskazanej waluty.

---

## Endpoint wykorzystywany w integracji

`GET /api/exchangerates/rates/C/{currencyCode}/last/{lastCount}?format=json`

Parametry:
- currencyCode — kod waluty, np. "USD", "EUR"
- lastCount — ile ostatnich notowań pobrać

---

## Zwracane dane (DTO)

Dane z NBP są mapowane na ujednolicony format ExternalDataResponse.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|------------------------|------------------------------------------------------
source           | String                  | Źródło danych, stała wartość: "exchange-rate".
title            | String                  | Tytuł opisujący zakres danych, np. "Kursy dla: USD".
description      | String                  | Opis przeznaczenia danych, tutaj: "Kursy walut z NBP".
additionalData   | Object                  | Dane specyficzne dla odpowiedzi z NBP.

### Struktura additionalData

Klucz      | Typ                     | Opis
-----------|------------------------|-------------------------------------------
currency   | String                  | Pełna nazwa waluty, np. "dolar amerykański".
code       | String                  | Kod waluty zgodny z ISO 4217, np. "USD".
rates      | List<NbpSingleRate>     | Lista notowań waluty zwróconych przez NBP.

### Format elementów rates

Każdy element listy rates ma strukturę:

```
NbpSingleRate {
  LocalDate effectiveDate,
  double bid,
  double ask
}
```

Opis pól:

Pole            | Typ        | Opis
----------------|-----------|---------------------------------------
effectiveDate   | LocalDate | Data obowiązywania danego notowania.
bid             | double    | Kurs kupna waluty.
ask             | double    | Kurs sprzedaży waluty.

### Przykładowa odpowiedź JSON

```
{
  "source": "exchange-rate",
  "title": "Kursy dla: USD",
  "description": "Kursy walut z Narodowego Banku Polskiego",
  "additionalData": {
    "currency": "dolar amerykański",
    "code": "USD",
    "rates": [
    {
        "effectiveDate": "2025-01-15",
        "bid": 3.8521,
        "ask": 3.9302
      }
    ]
  }
}
```

---

## Kluczowe komponenty

### WebClient (nbpWebClient)
Konfigurowany z:
`webclient.nbp-base-url`

### NbpClient
Obsługuje wywołanie API i błędy HTTP mapuje na ExternalApiException.

### CurrencyService
Umożliwia pobieranie kursów dla wielu walut jednocześnie (Flux).

---

## Przykład użycia

`currencyService.getLastCurrencyRates(new String[]{"USD", "EUR"}, 5);` - zwraca notowania z 5 ostatnich dni dla dolarów amerykańskich i euro.
