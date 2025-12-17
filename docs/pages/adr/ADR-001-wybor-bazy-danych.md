# ADR-001: Wybór bazy danych dla projektu Teletext

- **Status:** Zaakceptowana
- **Data:** 2025-11-25
- **Autorzy:** Sebastian Górski

---

## 1. Kontekst

Projekt Teletext wymaga stabilnej i bezpiecznej bazy danych obsługującej:
- treści stron telegazety (strony, kategorie),
- statystyki wyświetleń,
- konta administratorów.

System musi zapewniać:
- transakcyjność i spójność danych,
- obsługę wymagających zapytań (np. sortowanie i filtrowanie stron),
- łatwą integrację ze Spring Boot,
- możliwość działania w środowisku lokalnym, serwerowym i kontenerowym,
- brak dodatkowych kosztów licencyjnych.

Zespół posiada doświadczenie w SQL, a szczególnie w PostgreSQL.

---

## 2. Rozważane opcje

### Opcja 1: PostgreSQL 17.2

**Zalety:**
- [+] Darmowy i open-source.
- [+] Stabilny, powszechnie stosowany, dobrze wspierany.
- [+] Pełne wsparcie ACID.
- [+] Bardzo dobra integracja ze Spring Boot i Flyway.
- [+] Wygodna konfiguracja w Dockerze.
- [+] Doświadczenie zespołu obniża czas wdrożenia.

**Wady:**
- [-] Przy bardzo dużych datasetach wymaga tuningu (standard dla RDBMS).

### Opcja 2: Microsoft SQL Server

**Zalety:**
- [+] Zaawansowane narzędzia administracyjne.
- [+] Bardzo dobre wsparcie enterprise.
- [+] Rozbudowany T-SQL.

**Wady:**
- [-] Wymaga licencji, co zwiększa koszty projektu.
- [-] Cięższa konfiguracja w Dockerze i środowiskach developerskich.
- [-] Zespół ma mniejsze doświadczenie, co wydłuży wdrożenie.
- [-] Mniej naturalne dopasowanie do open-source stacku (Spring Boot + Docker).

---

## 3. Decyzja

Wybieramy **PostgreSQL 17.2** jako główną bazę danych dla projektu Teletext.

---

## 4. Uzasadnienie

PostgreSQL jest darmowy, łatwy w konfiguracji i w pełni zgodny z wymaganiami projektu. Oferuje stabilność, transakcyjność oraz funkcje przydatne w systemie Teletext. Integruje się naturalnie ze Spring Boot i narzędziami migracyjnymi. Zespół ma doświadczenie w pracy z tą bazą, co skraca czas implementacji.

MSSQL został odrzucony ze względu na koszty licencji, trudniejszą konfigurację oraz brak potrzeby wprowadzania technologii o wyższym poziomie złożoności w projekcie tego typu.

---

## 5. Konsekwencje

### Pozytywne
- [+] Niższe koszty (brak licencji).
- [+] Szybkie wdrożenie dzięki znajomości technologii.
- [+] Łatwa integracja z backendem oraz środowiskiem Docker.
- [+] Dobre wsparcie dla wyszukiwania i zapytań analitycznych.

### Negatywne
- [-] Potencjalna potrzeba tuningu przy bardzo dużych wolumenach danych.
- [-] Migracja do innego RDBMS wymagałaby zmian w SQL i schemacie.

---
