# Telewizja Polska - integracja

## Zakres integracji

Moduł pozwala na pobierania programu telewizyjnego TVP na wybrany dzień. Dane są pobierane z oficjalnej strony TVP w formacie XML.

---

## Endpoint wykorzystywany w integracji

`GET /prasa/{nazwa-kanalu}/{rok}/xml_OMI/{nazwa-pliku}.xml`

Parametry:
- nazwa-kanalu — nazwa kanału TVP (np. TVP3Wrocław, TVP1, TVPHistoria2 itd.)
- rok — rok, który szukamy (np. 2025)
- nazwa-pliku — nazwa pliku w formacie `m{rrrr}{MM}{dd}_{kod-kanalu}`, np.: `m20250115_XTT`

Uwagi:
- W niektórych przypadkach rok jest wyższy niż rzeczywisty - np. dla daty 2025-12-29 i wyżej należy podać rok 2026. Aby uniknąć błędów zaprogramowany został fallback w przypadku błędnego roku, który sprawdza rok wyższy o 1.
- kod i nazwa kanału są zaszyte w ENUM'ie dostępnym w kodzie źródłowym.

---

## Zwracane dane (DTO)

Dane z TVP są mapowane na ujednolicony format ExternalDataResponse.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

| Pole           | Typ    | Opis                                                                   |
|----------------|--------|------------------------------------------------------------------------|
| source         | String | Źródło danych, stała wartość: "tv-program".                            |
| title          | String | Tytuł opisujący zakres danych, np. "Program TVP2".                     |
| description    | String | Opis przeznaczenia danych, tutaj np: "Program TV na dzień 2026-01-01". |
| additionalData | Object | Dane specyficzne dla odpowiedzi z TVP.                                 |

### Struktura additionalData

| Klucz       | Typ               | Opis                                         |
|-------------|-------------------|----------------------------------------------|
| date        | LocalDateTime     | Data, dla której pobraliśmy program          |
| channelName | String            | Nazwa kanału, dla którego pobraliśmy program |
| program     | List<ProgramSlot> | Lista programów nadawnych w danym dniu.      |

### Format elementów progra

Każdy element listy program ma strukturę:

```
ProgramSlot {
  LocalDateTime time,
  Strin title,
  String description
}
```

Opis pól:

| Pole        | Typ           | Opis                                 |
|-------------|---------------|--------------------------------------|
| time        | LocalDateTime | Data i godzina rozpoczęcia programu. |
| title       | double        | Tytuł programu.                      |
| description | double        | Opis programu.                       |

### Przykładowa odpowiedź JSON

```
{
  "source": "tv-program",
  "title": "Program TVP 1",
  "description": "Program TV na dzień 2025-12-31",
  "additionalData": {
    "date": "2025-12-31",
    "channelName": "TVP 1",
    "program": [
      {
        "time": "2025-12-31T05:25:00",
        "title": "Wichrowe wzgórze - odc. 327",
        "description": "(N) Selma ma ciążowe zachcianki. Eren robi wszystko, by je spełnić. Gozde próbuje poróżnić chłopca z Zeynep. Kumru zaczyna rozpatrywać ślub z Umutem w kategoriach za i przeciw. Songul skarży się Gulhan na swoje położenie."
      },
      {
        "time": "2025-12-31T06:15:00",
        "title": "Akacjowa 38 - odc. 763",
        "description": "Antonito twierdzi, że został oszukany przez swojego wspólnika Belarmina. Inspektor nawet nie wierzy w jego istnienie. Trini dowiaduje się od Victora, że Belarmino istnieje i spotykał się z Antonitem w La Deliciosie."
      }
    ]
  }
}
```

---

## Kluczowe komponenty

### WebClient (tvpWebClient)
Konfigurowany z:
`webclient.tvp-base-url`

### TvpClient
Obsługuje wywołanie API i błędy HTTP mapuje na ExternalApiException.

### TvProgramService
Pozwala pobierać program dla danego kanału i daty, mapując odpowiedź na ExternalDataResponse.

### JaxbLocalDateTimeAdapter
Adapter do mapowania daty i czasu z formatu XML na LocalDateTime. Adapter utworzony wyłącznie na potrzeby tej integracji. Pozostałe integracje korzystają z wbudowanych adapterów Jacksona (JSON).

---

## Przykład użycia

`tvProgramService().getTvProgram(TvpChannel.TVP3_WROCLAW, LocalDate.now());` - zwraca program telewizyjny kanału TVP3 Wrocław na dzisiejszy dzień.
