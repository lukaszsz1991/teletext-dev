# Jooble — Integracja

## Zakres integracji

Moduł pobiera oferty pracy z API Jooble.  
Klient umożliwia wyszukiwanie ofert według słów kluczowych i lokalizacji.

---

## Endpoint wykorzystywany w integracji

`POST /api/{joobleSecret}`  

Parametry w ciele żądania (`JoobleRequest`):
- `keywords` — słowa kluczowe wyszukiwania, np. "Java Developer"
- `location` — lokalizacja, np. "Warszawa"

---

## Zwracane dane (DTO)

Dane z Jooble są mapowane na ujednolicony format `ExternalDataResponse`.  
Poniżej opis pól oraz przykładowa odpowiedź JSON.

### Struktura odpowiedzi

Pole             | Typ                     | Opis
-----------------|-------------------------|------------------------------------------------------
source           | String                  | Źródło danych, stała wartość: "job-offers".
title            | String                  | Tytuł oferty pracy.
description      | String                  | Krótki opis oferty (snippet).
additionalData   | Map<String, Object>     | Dane specyficzne dla oferty pracy.

### Struktura additionalData

Klucz            | Typ                     | Opis
-----------------|-------------------------|------------------------------------------------------
totalResults     | int                     | Liczba wszystkich wyników dla zapytania.
searchKeywords   | String                  | Słowa kluczowe użyte w wyszukiwaniu.
searchLocation   | String                  | Lokalizacja użyta w wyszukiwaniu.
location         | String                  | Lokalizacja oferty pracy.
salary           | String                  | Wynagrodzenie (jeśli dostępne).
company          | String                  | Nazwa firmy oferującej pracę.
updatedAt        | LocalDateTime           | Data ostatniej aktualizacji oferty.

### Przykładowa odpowiedź JSON

```json
{
  "source": "job-offers",
  "title": "Java Developer",
  "description": "Poszukujemy doświadczonego Java Developera do zespołu IT",
  "additionalData": {
    "totalResults": 120,
    "searchKeywords": "Java Developer",
    "searchLocation": "Warszawa",
    "location": "Warszawa",
    "salary": "10000-15000 PLN",
    "company": "TechCorp",
    "updatedAt": "2025-11-26T09:15:00"
  }
}
```

---

## Kluczowe komponenty

### WebClient (joobleWebClient)
Konfigurowany z:  
`webclient.jooble-base-url`  
Sekret API: przechowywany w `joobleSecret`.

### JoobleClient
Obsługuje wywołania API Jooble i błędy HTTP, mapując je na `ExternalApiException`.  
Zawiera metodę:
- `getJobs(JoobleRequest request)` — pobiera listę ofert pracy zgodnie z żądaniem.

### JobsService
Mapuje dane z Jooble na `JobResponse` i udostępnia metody:
- `getAllJobs(JoobleRequest request)` — Flux<JobResponse> z listą ofert, posortowanych po dacie aktualizacji malejąco.
- `getJobByAddingOrder(JoobleRequest request, int addedOrder)` — pobiera konkretną ofertę na podstawie kolejności dodania.

---

## Przykład użycia

```java
JoobleRequest request = new JoobleRequest("Java Developer", "Warszawa");
jobsService.getAllJobs(request)
    .subscribe(job -> {
        System.out.println("Tytuł: " + job.title());
        System.out.println("Firma: " + job.company());
        System.out.println("Lokalizacja: " + job.location());
        System.out.println("Opis: " + job.snippet());
    });
```
