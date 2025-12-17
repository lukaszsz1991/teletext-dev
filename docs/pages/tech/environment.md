# Opis środowiska i infrastruktury

## Baza danych - PostgreSQL 17.2
System bazodanowy wykorzystywany w projekcie to PostgreSQL w wersji 17.2. Jest to wydajny i stabilny system zarządzania relacyjną bazą danych. Konfiguracja dostępu do bazy danych została zdefiniowana w pliku `docker-compose.yml`.

## Migracje schematu – Flyway 10.20.1
Do zarządzania wersjonowaniem i migracjami schematu bazy danych wykorzystywane jest narzędzie Flyway w wersji 10.20.1. Flyway umożliwia automatyczne stosowanie zmian w strukturze bazy danych w różnych środowiskach (deweloperskim, testowym i produkcyjnym).

**Kluczowe cechy użycia Flyway w projekcie:**
* Migracje są definiowane w postaci skryptów SQL w katalogu `db/migration`.
* System automatycznie wykrywa i stosuje nowe migracje podczas startu aplikacji.
* Narzędzie wspiera rollbacki oraz walidację historii migracji.

## Cache – Redis 7.4.2-alpine
Do przechowywania danych tymczasowych oraz buforowania odpowiedzi system wykorzystuje Redis w wersji 7.4.2-alpine. Redis funkcjonuje jako zewnętrzny, szybki magazyn danych typu key-value. Jest on wykorzystywany między innymi do cache’owania wyników zapytań oraz danych sesyjnych. Wersja alpine została wybrana ze względu na minimalny rozmiar obrazu oraz szybki czas uruchamiania kontenera.

## Infrastruktura uruchomieniowa
Projekt jest w pełni skonteneryzowany, co zapewnia powtarzalność środowiska. Do poprawnego działania wymagane jest zainstalowanie aplikacji Docker, GitHub CLI oraz narzędzia make (w przypadku systemu Windows). Zarządzanie cyklem życia kontenerów odbywa się za pomocą przygotowanych komend automatyzujących.
