# Teletext Infra

To repozytorium zawiera konfigurację infrastruktury projektu **Teletext**, w tym:
- repozytoria `teletext-backend` i `teletext-frontend`
- folder `docker-files` z plikami obrazami Dockera i logami serwisów
- plik `Makefile` ze skryptami pomocnicznymi
- konfigurację serwisów Dckera w pliku `compose.yml` 

---

## Jak pracować z submodułami

Każdy submoduł jest osobnym repozytorium Git. Wchodząc do odpowiedniego podfolderu (`backend` lub `frontend`) pracujemy w tym repozytroium. Oznacza to, że możemy w nim tworzyć gałęzie, aktualizować kod, robić commity, PR itd.

:exclamation: Po wdrożeniu zmian w submodułach w branchu `main`, należy zaktualizować repozytorium `teletext-dev`:

```
make rebase # (opcjonalnie)
make push-backend # dla zmian w backendzie
make push-frontend # dla zmian w frontendzie
```

lub dla większej kontroli (np. modyfikacja commit message):

```
cd teletext-dev
make rebase
git add backend # lub git add frontend, w zależności od zaktualizowanego repozytorium
git commit -m "chore: update submodules"
git push -u origin xxx # xxx należy zastąpić aktualnym lokalnym branchem
```

> Ten commit w `teletext-dev` aktualizuje referencję submodułu do najnowszej wersji `main` i pozwala wszystkim współpracownikom pobrać aktualny stan projektu.

### Aktualizacja submodułów

Przed rozpoczęciem pracy warto upewnić się, że wszystkie repozytoria są aktualne. 

W tym celu wystarczy uruchomić komendę:
```
make rebase
```

Pod tą komendą kryje się ten skrpyt:
```
git pull --rebase
git submodule update --init --recursive --remote --jobs 2
```

Wykonanie jednej z powyższych komend spowoduje pobranie najnowszej wersji repozytoriów z branchy `main`.

---

## Docker Compose

Wykorzystujemy Docker Compose do uruchamiania wszystkich serwisów lokalnie, w tym:
- bazę danych PostgreSQL (`postgres`)
- backend Spring Boot (`backend`)
- frontend React + Nginx (`frontend`)

### Uruchomienie
1. Upewnij się, że masz zainstalowanego Dockera.
2. Skopiuj plik `.env.example` do `.env` i dostosuj zmienne środowiskowe według potrzeb.
3. Uruchom serwisy za pomocą komendy:
   ```
   docker-compose up --build -d
   ```
   
   lub użyj:

   ```
   make up
   ```

---

## Makefile

Pomocne komendy do pracy nad projektem:

| Komenda                 | Opis                                                  |
|-------------------------|-------------------------------------------------------|
| `make rebase`           | Aktualizuje repozytorium i submoduły                  |
| `make push-backend`     | Wypycha zmiany w backendzie do zdalnego repozytorium  |
| `make push-frontend`    | Wypycha zmiany w frontendzie do zdalnego repozytorium |
| `make build`            | Buduje obrazy Docker dla wszystkich serwisów          |
| `make up`               | Uruchamia serwisy Docker Compose                      |
| `make down`             | Zatrzymuje serwisy Docker Compose                     |
| `make logs`             | Wyświetla logi wszystkich serwisów                    |
| `make restart`          | Przebudowuje i restaruje wszystkie serwisy            |
| `make restart-backend`  | Przebudowuje i restaruje backend aplikacji            |
| `make restart-frontend` | Przebudowuje i restaruje frontend aplikacji           |

---

## Autorzy
- [Sebastian Górski](https://github.com/sgorski00/)
- [Jakub Grzymisławski](https://github.com/jgrzymislawski/)
- [Łukasz Szenkiel](https://github.com/lukaszsz1991/)
- [Rafał Wilczewski](https://github.com/Rafal-wq/)

---

> Projekt wykonywany w ramach kursu *Projektowanie i programowanie systemów internetowych II*
