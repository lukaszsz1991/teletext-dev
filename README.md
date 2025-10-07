# Teletext Infra

To repozytorium zawiera konfigurację infrastruktury projektu **Teletext**, w tym:
- repozytoria `teletext-backend` i `teletext-frontend`
- `Makefile` ze skryptami pomocnicznymi

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

Jeszcze nie wdrożono.

---

## Autorzy
- [Sebastian Górski](https://github.com/sgorski00/)
- [Jakub Grzymisławski](https://github.com/jgrzymislawski/)
- [Łukasz Szenkiel](https://github.com/lukaszsz1991/)
- [Rafał Wilczewski](https://github.com/Rafal-wq/)

---

> Projekt wykonywany w ramach kursu *Projektowanie i programowanie systemów internetowych II*
