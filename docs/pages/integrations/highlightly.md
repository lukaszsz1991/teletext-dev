# Highlightly — Piłka Nożna - Integracja

Moduł integruje dane piłkarskie z API Highlightly.  
Dane są podzielone na **tabele ligowe** i **wyniki/nadchodzące mecze**.

---

## 1. Tabele ligowe

### Zakres

Top 5 lig europejskich + Ekstraklasa.  
Dane obejmują aktualny sezon i stan tabeli.

### DTO

- `FootballTableResponse`
  - `league` — nazwa ligi
  - `season` — rok sezonu
  - `data.standings` — lista drużyn z pozycją, punktami i statystykami.

#### FootballStandingDetails

Pole           | Typ | Opis
----------------|-----|--------------------------------------------
team            | String | Nazwa drużyny
position        | int    | Pozycja w tabeli
points          | int    | Punkty
wins            | int    | Wygrane
draws           | int    | Remisy
loses           | int    | Przegrane
scoredGoals     | int    | Bramki zdobyte
receivedGoals   | int    | Bramki stracone

### Przykładowa odpowiedź JSON

```json
{
  "source": "sport-table",
  "title": "Premier League - sezon 2025",
  "description": "Tabela ligowa - stan na dzień 2025-11-26",
  "additionalData": {
    "standings": [
      { "team": "Manchester City", "position": 1, "points": 30, "wins": 10, "draws": 0, "loses": 0, "scoredGoals": 35, "receivedGoals": 10 },
      { "team": "Liverpool", "position": 2, "points": 27, "wins": 9, "draws": 0, "loses": 1, "scoredGoals": 28, "receivedGoals": 12 },
      { "team": "Chelsea", "position": 3, "points": 24, "wins": 8, "draws": 0, "loses": 2, "scoredGoals": 25, "receivedGoals": 15 }
    ]
  }
}
```

---

## 2. Mecze w danym tygodniu

### Zakres

- Wyniki i nadchodzące mecze dla wskazanej ligi i tygodnia sezonu.
- Obiekt `FootballMatchesResponse` zawiera listę meczów (`matches`) i numer tygodnia (`week`).

### DTO

#### FootballMatchDetails

Pole               | Typ         | Opis
------------------ |------------ |-------------------------------------------------
round              | String      | Kolejka / runda meczu
date               | LocalDateTime | Data i godzina meczu
state              | FootballMatchState | Stan meczu (jeśli już grany)
homeTeam           | String      | Drużyna gospodarzy
awayTeam           | String      | Drużyna gości

#### FootballMatchState

Pole               | Typ   | Opis
------------------ |-------|-------------------------------------------
clock              | int   | Minuta meczu
currentScore       | String | Aktualny wynik
penaltiesScore     | String | Wynik rzutów karnych
description        | String | Dodatkowy opis stanu meczu

### Przykładowa odpowiedź JSON

```json
{
  "source": "sport-matches",
  "title": "Premier League - sezon 2025",
  "description": "Mecze w tygodniu 12",
  "additionalData": {
    "matches": [
      {
        "round": "12",
        "date": "2025-11-26T20:00:00",
        "state": { "clock": 45, "currentScore": "1-0", "penaltiesScore": null, "description": "First half" },
        "homeTeam": "Manchester City",
        "awayTeam": "Arsenal"
      },
      {
        "round": "12",
        "date": "2025-11-27T17:30:00",
        "state": { "clock": nyll, "currentScore": null, "penaltiesScore": null, "description": "Not started" },
        "homeTeam": "Liverpool",
        "awayTeam": "Chelsea"
      }
    ]
  }
}
```

---

## Kluczowe komponenty

### HighlightlyClient
- `getStandingsInfo(FootballLeague league, int season)` — pobiera tabelę ligi.
- `getMatchesInfo(FootballLeague league, int season)` — pobiera wszystkie mecze, stronicowane, zwraca `Flux<HighlightlyMatchInfo>`.

### FootballService
- `getTableForLeague(FootballLeague league)` — zwraca tabelę dla podanej ligi.
- `getMatchesForLeague(FootballLeague league, int week)` — zwraca mecze w danym tygodniu sezonu.

> Serwis zawsze pobiera dane z aktualnego sezonu.

### FootballLeague - enum
- EKSTRAKLASA
- PREMIER_LEAGUE
- LA_LIGA
- SERIE_A
- BUNDESLIGA
- LIGUE_1

---

## Przykład użycia

```java
// Pobranie tabeli Premier League
footballService.getTableForLeague(FootballLeague.PREMIER_LEAGUE)
    .subscribe(table -> System.out.println("Top drużyny: " + table.getData().getStandings()));

// Pobranie meczów Premier League w tygodniu 12
footballService.getMatchesForLeague(FootballLeague.PREMIER_LEAGUE, 12)
    .subscribe(matches -> matches.getData().getMatches())
    .forEach(match -> System.out.println(match.homeTeam() + " vs " + match.awayTeam() + " : " + match.state()));
```
