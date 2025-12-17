# ADR-005: Soft delete a unikalność numeru strony

- **Status:** Zaakceptowana
- **Data:** 2025-12-16
- **Autorzy:** Sebastian Górski

---

## 1. Kontekst

System wykorzystuje soft delete (`deleted_at`) i jednocześnie `page_number` musi być unikalny tylko dla aktywnych stron, przy jednoczesnym udostępnieniu możliwości reaktywowania usuniętej strony.

Aplikacja lokalnie w celach devowych wykorzystuje bazę H2 (in-memory), natomiast środowiska testowe i produkcyjne używają PostgreSQL.

W bazie PostgreSQL jest możliwość wdrożenia warunkowego unique constraint, lecz w H2 jest to nie możliwe.

---

## 2. Rozważane opcje

### Opcja 1: Wymóg postawienia bazy psql dla profilu `local-dev`

**Zalety:**
- [+] Wszystkie środowiska zachowują się tak samo.
- [+] Jest jedno źródło prawdy.

**Wady:**
- [-] Wymaga dodatkowej konfiguracji.
- [-] Spowalnia proces wdrożenia aplikacji w środowisku lokalnym developerskim.

---

### Opcja 2: Zostajemy przy H2 w profilu `local-dev`

**Zalety:**
- [+] Prostota wdrożenia.
- [+] Nie wymaga zmian i instalacji dodatkowego oprogramowania.
- [+] Pozwala budować aplikację w celach szybkiego podglądu bez nadmiaru konfiguracji.

**Wady:**
- [-] Nie działa warunkowy unique constraint na kolumnie page_number.

---

## 3. Decyzja

Wybieramy **pozostanie przy bazie H2 w local-dev**

---

## 4. Uzasadnienie

Środowisko `local-dev` nie jest bardzo istotne, a zespół jest świadomy z różnicy w logice biznesowej na tym profilu i możliwych powikłaniach. Jendocześnie pozostawiamy łatwość konfiguracji akcpetując związane z tym ryzyko. 
Unikalność dalej będzie działać, jednakże nie utworzymy w tym środowisku stroyn o numerze strony, która jest już nieaktywna.

Jedyną zmianą, jaką należy wykonać to dodanie kolejnego profilu do testów integracyjnych i wdrożenie go w `github actions`.

---

## 5. Konsekwencje

### Pozytywne
- [+] Prosta implementacja i niski koszt utrzymania.
- [+] Łatwość uruchomienia aplikacji dla lokalnego rozwoju aplikacji.

### Negatywne
- [-] Brak poprawnej walidacji unikalności indexu stron.

---
