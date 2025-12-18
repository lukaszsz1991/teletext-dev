# Mój Codzienny Horoskop — Integracja

## Zakres integracji

Moduł pobiera horoskopy dzienne dla wszystkich znaków z API „Mój Codzienny Horoskop”.  
Klient umożliwia pobranie horoskopu na dzisiaj lub jutro dla wskazanego znaku zodiaku.

---

## Endpoint wykorzystywany w integracji

`GET /webmaster/api_JSON.php?type={param}`  

Parametry:
- `type` — `"1"` dla horoskopu dzisiejszego, `"2"` dla horoskopu jutrzejszego.

---

## Zwracane dane (DTO)

Dane z API horoskopu są mapowane na ujednolicony format `ExternalDataResponse`.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|------------------------|-----------------------------------------------
source           | String                  | Źródło danych, stała wartość: "horoscope".
title            | String                  | Tytuł horoskopu, np. "Baran - 2025-11-26".
description      | String                  | Treść przepowiedni.
additionalData   | Map<String, Object>     | Szczegółowe oceny horoskopu.

### Struktura additionalData

Klucz            | Typ  | Opis
-----------------|------|-------------------------------------------
ratingMood       | int  | Ocena nastroju (0-5).
ratingLove       | int  | Ocena życia miłosnego (0-5).
ratingMoney      | int  | Ocena finansów (0-5).
ratingWork       | int  | Ocena kariery/pracy (0-5).
ratingLeasures   | int  | Ocena czasu wolnego/rozrywek (0-5).

### Przykładowa odpowiedź JSON

```json
{
  "source": "horoscope",
  "title": "Baran - 2025-11-26",
  "description": "Dziś będziesz mieć energię do działania i nowe możliwości w pracy.",
  "additionalData": {
    "ratingMood": 4,
    "ratingLove": 3,
    "ratingMoney": 2,
    "ratingWork": 5,
    "ratingLeasures": 3
  }
}
```

---

## Kluczowe komponenty

### WebClient (horoscopeWebClient)
Konfigurowany z: `webclient.horoscope-base-url`.

### HoroscopeClient
Obsługuje wywołania API i błędy HTTP, mapując je na `ExternalApiException`.  
Metody:
- `getTodayHoroscope()` — pobiera horoskop dzisiejszy.
- `getTomorrowHoroscope()` — pobiera horoskop na jutro.

### HoroscopeService
Mapuje dane na `TeletextHoroscopeResponse` i udostępnia metodę:
- `getSingleSignHoroscope(HoroscopeSign sign, boolean forTomorrow)` — pobiera horoskop dla wskazanego znaku, dzisiaj lub jutro.

---

## Przykład użycia

```java
horoscopeService.getSingleSignHoroscope(HoroscopeSign.ARIES, false)
    .subscribe(horoscope -> {
        System.out.println("Tytuł: " + horoscope.title());
        System.out.println("Prognoza: " + horoscope.prediction());
        System.out.println("Oceny: nastrój=" + horoscope.ratingMood() +
                           ", miłość=" + horoscope.ratingLove() +
                           ", pieniądze=" + horoscope.ratingMoney());
    });
```
