# OpenMeteo — Integracja

## Zakres integracji

Moduł pobiera prognozę pogody dla tygodnia dla wskazanych miast. Klient umożliwia pobranie prognozy dla pojedynczego miasta lub dla wszystkich miast znajdujących się w systemie.

---

## Endpoint wykorzystywany w integracji

`GET /v1/forecast?latitude={lat}&longitude={lon}&daily=temperature_2m_max,temperature_2m_min&timezone=auto`

Parametry:
- latitude — szerokość geograficzna miasta
- longitude — długość geograficzna miasta

---

## Zwracane dane (DTO)

Dane z OpenMeteo są mapowane na ujednolicony format `ExternalDataResponse`.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|------------------------|------------------------------------------------------
source           | String                  | Źródło danych, stała wartość: "weather".
title            | String                  | Nazwa miasta, np. "Wrocław".
description      | String                  | Opis przeznaczenia danych, np. "Tygodniowa prognoza pogody".
additionalData   | Object                  | Dane specyficzne dla odpowiedzi z OpenMeteo.

### Struktura additionalData

Klucz           | Typ                     | Opis
----------------|------------------------|-------------------------------------------
dailyWeathers   | List<DailyWeather>      | Lista dziennych prognoz pogody dla miasta.

### Format elementów dailyWeathers

Każdy element listy `dailyWeathers` ma strukturę:
```
DailyWeather {
  String date,
  double maxTemperature,
  String maxTemperatureUnit,
  double minTemperature,
  String minTemperatureUnit
}
```

Opis pól:

Pole                 | Typ      | Opis
-------------------- |---------|---------------------------------------
date                 | String  | Data prognozy w formacie "YYYY-MM-DD".
maxTemperature       | double  | Maksymalna temperatura w ciągu dnia.
maxTemperatureUnit   | String  | Jednostka maksymalnej temperatury, np. "°C".
minTemperature       | double  | Minimalna temperatura w ciągu dnia.
minTemperatureUnit   | String  | Jednostka minimalnej temperatury, np. "°C".

---

### Przykładowa odpowiedź JSON

```json
{
  "source": "weather",
  "title": "Wrocław",
  "description": "Tygodniowa prognoza pogody",
  "additionalData": {
    "dailyWeathers": [
      {
        "date": "2025-11-26",
        "maxTemperature": 8.5,
        "maxTemperatureUnit": "°C",
        "minTemperature": 2.3,
        "minTemperatureUnit": "°C"
      },
      {
        "date": "2025-11-27",
        "maxTemperature": 9.1,
        "maxTemperatureUnit": "°C",
        "minTemperature": 1.8,
        "minTemperatureUnit": "°C"
      }
    ]
  }
}
```

---

## Kluczowe komponenty

### WebClient (weatherWebClient)

Konfigurowany z:
`webclient.open-meteo-base-url`

### OpenMeteoClient

Obsługuje wywołanie API, buduje query parametry i mapuje błędy HTTP na `ExternalApiException`.

### WeatherService

Umożliwia pobranie prognozy dla pojedynczego miasta lub dla wszystkich miast w systemie (Flux). Współpracuje z `CityService` w celu pobrania listy miast.

### CityService

Zarządza listą miast i ich współrzędnych. Normalizuje nazwy miast i rzuca wyjątek `CityNotFoundException` jeśli miasto nie istnieje. Lista miast jest pobierana poprzez `CityRepository`, które korzysta z pliku `cities.csv`, umieszczonym w folderze `resources/data`.

Plik CSV zawiera liste miast wraz z ich współrzędnymi geograficznymi. Każdy wiersz ma format:

```
nazwa_miasta,szerokosc_geograficzna,dlugosc_geograficzna
```

Przykład wiersza:

```
Wrocław,51.1,17.0333
```

Aby dodać nowe miasto, należy dopisać je w nowej linii w pliku csv z formatem jw.

## Przykład użycia

`weatherService.getWeeklyWeatherForCity("Wrocław");` — zwraca tygodniową prognozę pogody dla Wrocławia.

`weatherService.getWeeklyWeatherForAllCities();` — zwraca tygodniową prognozę pogody dla wszystkich miast w systemie.
