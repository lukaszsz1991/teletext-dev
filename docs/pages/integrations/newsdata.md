# NewsData — Integracja

## Zakres integracji

Moduł pobiera najnowsze wiadomości z API NewsData.  
Klient umożliwia pobranie ostatnich wiadomości dla wskazanej kategorii oraz języka (polski / inny).

---

## Endpoint wykorzystywany w integracji

`GET /api/1/latest`  

Parametry query:
- `language` — język wiadomości, np. "pl"
- `country` — filtrowanie po kraju (tylko dla polskich wiadomości)
- `excludeCountry` — wykluczenie kraju (dla wiadomości zagranicznych)
- `category` — kategoria wiadomości

---

## Zwracane dane (DTO)

Dane z NewsData są mapowane na ujednolicony format ExternalDataResponse.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|------------------------|------------------------------------------------------
source           | String                  | Źródło danych, stała wartość: "news".
title            | String                  | Tytuł wiadomości, np. "Najważniejsze wydarzenia dnia".
description      | String                  | Krótki opis wiadomości.
additionalData   | Object                  | Dane specyficzne dla wiadomości.

### Struktura additionalData

Klucz           | Typ                     | Opis
----------------|------------------------|------------------------------------------------------
link            | String                  | URL do pełnej treści artykułu.
keywords        | String[]                | Lista słów kluczowych powiązanych z artykułem.
creator         | String                  | Autor lub źródło artykułu.
country         | String                  | Kraj publikacji.
category        | String                  | Kategoria wiadomości.
publicationDate | String / LocalDateTime  | Data i czas publikacji artykułu.
sourceName      | String                  | Nazwa źródła wiadomości.
sourceUrl       | String                  | Strona źródła wiadomości.

### Przykładowa odpowiedź JSON

```json
{
  "source": "news",
  "title": "Nowe technologie w Polsce",
  "description": "Przegląd najważniejszych wydarzeń technologicznych w kraju",
  "additionalData": {
    "link": "https://example.com/news/123",
    "keywords": ["technologia","Polska","IT"],
    "creator": "News Agency",
    "country": "PL",
    "category": "technology",
    "publicationDate": "2025-11-26T08:30:00",
    "sourceName": "NewsData",
    "sourceUrl": "https://newsdata.io"
  }
}
```

---

## Kluczowe komponenty

### WebClient (newsWebClient)
Konfigurowany z:  
`webclient.newsdata-base-url`  
Domyślny nagłówek: `X-Access-Key` — klucz API dla NewsData.

### NewsClient
Obsługuje wywołania API i błędy HTTP, mapując je na ExternalApiException.  
Zawiera metodę:
- `getLatestNews(boolean isPolish, NewsCategory category)` — pobiera najnowszą wiadomość w wybranej kategorii i języku.

### NewsService
Mapuje dane z NewsData na `NewsResponse` i udostępnia metodę:
- `getLatestNews(boolean isPolish, NewsCategory category)` — Mono<NewsResponse> z pełną informacją o artykule.

### NewsCategory
Enum z listą dostępnych kategorii newsów.
Dostępne kategorie: (stan na 2025-11-26):
- BUSINESS,
- CRIME,
- DOMESTIC,
- EDUCATION,
- ENTERTAINMENT,
- ENVIRONMENT,
- FOOD,
- HEALTH,
- LIFESTYLE,
- OTHER,
- POLITICS,
- SCIENCE,
- SPORTS,
- TECHNOLOGY,
- TOP,
- TOURISM,
- WORLD

---

## Przykład użycia

```java
newsService.getLatestNews(true, NewsCategory.TECHNOLOGY)
    .subscribe(news -> {
        System.out.println("Tytuł: " + news.title());
        System.out.println("Opis: " + news.description());
        System.out.println("Link: " + news.link());
    });
```
