# Lotto — Integracja

## Zakres integracji

Moduł pobiera aktualne informacje i wyniki ostatniego losowania gry Lotto.  
Klient umożliwia pobranie danych o następnym losowaniu oraz wyników ostatniego losowania.

---

## Endpointy wykorzystywane w integracji

- `GET /api/lotto/info` — pobiera informacje o grze Lotto (typ gry, data następnego losowania, przewidywana pula nagród itp.)
- `GET /api/lotto/draw-results/last-results-per-game` — pobiera wyniki ostatniego losowania dla gry Lotto

---

## Zwracane dane (DTO)

Dane z Lotto są mapowane na ujednolicony format ExternalDataResponse.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|------------------------|------------------------------------------------------
source           | String                  | Źródło danych, stała wartość: "lottery".
title            | String                  | Tytuł opisujący zakres danych, np. "Informacje o grze Lotto".
description      | String                  | Opis przeznaczenia danych, np. "Aktualne informacje oraz wyniki ostatniego losowania gry Lotto".
additionalData   | Object                  | Dane specyficzne dla odpowiedzi z Lotto.

### Struktura additionalData

Klucz           | Typ                     | Opis
----------------|------------------------|-------------------------------------------------------
gameType        | String                  | Typ gry, np. "Lotto".
nextDrawDate    | LocalDateTime           | Data i godzina następnego losowania.
nextDrawPrize   | Double                  | Przewidywana pula nagród na następne losowanie.
lastDrawDate    | LocalDateTime           | Data i godzina ostatniego losowania.
lastDrawResults | int[]                   | Wyniki ostatniego losowania (liczby wylosowane).
couponPrice     | String                  | Cena kuponu, np. "3.50 PLN".
draws           | String                  | Liczba lub typ losowań (jeżeli dostępne).

### Przykładowa odpowiedź JSON

```json
{
  "source": "lottery",
  "title": "Informacje o grze Lotto",
  "description": "Aktualne informacje oraz wyniki ostatniego losowania gry Lotto",
  "additionalData": {
    "gameType": "Lotto",
    "nextDrawDate": "2025-11-28T21:40:00",
    "nextDrawPrize": 20000000.0,
    "lastDrawDate": "2025-11-25T21:40:00",
    "lastDrawResults": [3, 12, 25, 33, 40, 42],
    "couponPrice": "3.50 PLN",
    "draws": "Lotto"
  }
}
```

---

## Kluczowe komponenty

### WebClient (lottoWebClient)
Konfigurowany z:  
`webclient.lotto-base-url`  
Domyślny nagłówek: `secret` — klucz API dla Lotto.

### LottoClient
Obsługuje wywołania API i błędy HTTP, mapując je na ExternalApiException.  
Zawiera metody:
- `getLottoInfo()` — pobiera informacje o grze
- `getLastLottoResult()` — pobiera wyniki ostatniego losowania

### LotteryService
Mapuje dane z Lotto na `LotteryResponse` i udostępnia metodę:
- `getLottoResponse()` — Mono<LotteryResponse> z pełną informacją o grze i ostatnich wynikach.

---

## Przykład użycia

```java
lotteryService.getLottoResponse()
    .subscribe(response -> {
        System.out.println("Typ gry: " + response.gameType());
        System.out.println("Następne losowanie: " + response.nextDrawDate());
        System.out.println("Wyniki ostatniego losowania: " + Arrays.toString(response.lastDrawResults()));
    });
```
