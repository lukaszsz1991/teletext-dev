# ADR-003: Mechanizm autoryzacji

- **Status:** Zaakceptowana
- **Data:** 2025-11-25
- **Autorzy:** Sebastian Górski

---

## 1. Kontekst

W aplikacji jest tylko jeden typ użytkownika - administrator. Nie ma potrzeby, żeby uzytkownicy końcowi mogli/musieli się logować. Użytkownicy odwiedzają stronę ogólnodostępną.

Panel administratora musi być silnie zabezpieczony przed niepożądanymi logowaniami.

Wymagania autoryzacyjne obejmują:

- bezpieczne logowanie administratorów,
- hasła przechowywane w postaci silnie zahashowanej,
- brak sesji serwerowych (architektura stateless),
- prosta integracja ze Spring Boot,
- minimalna złożoność przy zachowaniu wysokiego bezpieczeństwa,
- obecność tylko jednej roli: **ADMIN**.

Mechanizm autoryzacji musi być wystarczająco bezpieczny, niewymagający dodatkowej infrastruktury oraz łatwy do rozbudowy w przyszłości (np. o kolejne role).

---

## 2. Rozważane opcje

### Opcja 1: JWT + Argon2 (stateless)

**Zalety:**
- [+] Prosty i lekki mechanizm autoryzacji.
- [+] Brak sesji – pełna zgodność z architekturą stateless.
- [+] Bardzo dobra integracja ze Spring Boot Security.
- [+] Argon2id zapewnia wysoki poziom bezpieczeństwa haseł.
- [+] Brak dodatkowych usług (np. Keycloak), mniejsza złożoność projektu.
- [+] Łatwe wdrożenie i utrzymanie przez mały zespół.

**Wady:**
- [-] Wymaga zarządzania czasem życia tokenów.
- [-] Brak centralnego miejsca do unieważniania tokenów.

---

### Opcja 2: Sesje HTTP + Spring Security

**Zalety:**
- [+] Prosty model sesyjny, automatyczna obsługa wygasania.
- [+] Unieważnienie sesji jest natychmiastowe.

**Wady:**
- [-] Serwer musi przechowywać stan.
- [-] Utrudnione skalowanie poziome bez sticky sessions.
- [-] Większa złożoność konfiguracji i infrastruktury.
- [-] Ciężkie do wykorzystania w aplikacji z podzielonym frontendem i backendem.

---

### Opcja 3: Keycloak / OAuth2

**Zalety:**
- [+] Bardzo rozbudowany IAM z rolami, grupami i politykami.
- [+] Tokeny, refresh tokeny, audyt, SSO.

**Wady:**
- [-] Duży narzut infrastrukturalny.
- [-] Zbyt skomplikowane jak na prosty panel admina.
- [-] Wymaga utrzymania osobnej usługi.
- [-] Dłuższy czas wdrożenia.

---

## 3. Decyzja

Wybieramy **JWT + Argon2id w modelu stateless** jako mechanizm autoryzacji dla panelu administracyjnego.

---

## 4. Uzasadnienie

JWT z Argon2id spełnia wszystkie wymagania bezpieczeństwa, jednocześnie nie zwiększając złożoności projektu.  
Mechanizm jest naturalnie wspierany przez Spring Boot, nie wymaga dodatkowych serwerów i idealnie pasuje do architektury stateless.  
Ponieważ system obsługuje wyłącznie administratorów, pełne rozwiązania IAM zostały uznane za przerost formy.  
Model autoryzacji pozostaje prosty, czytelny i łatwy do ewentualnej rozbudowy w przyszłości.

---

## 5. Konsekwencje

### Pozytywne
- [+] Prosta implementacja i niski koszt utrzymania.
- [+] Wysokie bezpieczeństwo dzięki Argon2id i krótkim JWT.
- [+] Brak sesji umożliwia łatwe skalowanie backendu.
- [+] Minimalna złożoność kodu i konfiguracji.
- [+] Łatwe dodanie kolejnych ról lub uprawnień w przyszłości.

### Negatywne
- [-] Brak natychmiastowego unieważniania tokenów (cecha JWT).
- [-] Wymaga przemyślanej polityki czasu życia tokenów.

---
