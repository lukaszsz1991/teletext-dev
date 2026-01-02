# Backlog i estymata projektu (Roboczodni)

## Metodologia estymacji
Estymata została sporządzona w jednostkach **roboczodni (MD – Man-Days)**, gdzie 1 MD oznacza około 6-8 godzin pracy jednego członka zespołu. Ze względu na to, że zespół jest 4-osobowy i stawia pierwsze kroki w wykorzystanych technologiach, estymaty uwzględniają czas niezbędny na research, naukę narzędzi oraz rozwiązywanie problemów konfiguracyjnych.

## Lista zadań (Backlog)

| ID | Funkcjonalność / Zadanie | Priorytet | Estymata (MD) |
|:---|:---|:---|:---|
| 1 | Konfiguracja środowiska, Docker (PostgreSQL, Redis) i CI/CD | Wysoki | 2.5 |
| 2 | Analiza wymagań i projektowanie modelu bazy danych (ERD) | Wysoki | 1.0 |
| 3 | Implementacja szkieletu aplikacji (Spring Boot Setup + Flyway) | Wysoki | 1.5 |
| 4 | Core: Silnik nawigacji stron telegazety (logika 100-899) | Krytyczny | 4.0 |
| 5 | Backend: CRUD dla administratora (zarządzanie stronami) | Wysoki | 3.5 |
| 6 | Security: Integracja OAuth2 / Spring Security i obsługa sesji | Wysoki | 3.0 |
| 7 | Integracje: Budowa modułów dla 7 zewnętrznych API | Wysoki | 7.0 |
| 8 | Frontend: Budowa UI w stylu retro (Thymeleaf, CSS, ASCII Art) | Średni | 4.0 |
| 9 | Optymalizacja: Wdrożenie warstwy cache (Redis) dla treści API | Średni | 2.0 |
| 10 | Analityka: Moduł statystyk i liczników odwiedzin | Niski | 1.5 |
| 11 | Testy: Jednostkowe, integracyjne oraz manualne (QA) | Wysoki | 5.0 |
| 12 | Dokumentacja: Sporządzenie dokumentacji technicznej i użytkowej | Wysoki | 3.0 |
| 13 | Zarządzanie: Spotkania zespołu, Code Review i Bugfixing | Średni | 4.0 |

## Podsumowanie zasobów
* **Łączny nakład pracy:** 42.0 roboczodni.
* **Rozkład na zespół:** Przy 4 osobach pracujących nad projektem, przewidywany czas realizacji wynosi około 10.5 dnia roboczego na osobę.

## Opis kluczowych bloków czasowych
* **Integracje API (7.0 MD):** Zadanie podzielone na zespół. Każda integracja wymaga analizy dokumentacji zewnętrznej, parsowania danych i obsługi błędów połączenia.
* **Testowanie (5.0 MD):** Obejmuje pisanie testów JUnit/Mockito oraz testy końcowe całego systemu przed oddaniem.
* **Dokumentacja (3.0 MD):** Przygotowanie plików Markdown, instrukcji instalacji oraz finalnej dokumentacji projektowej w LaTeX.
* **Zarządzanie i Bugfixing (4.0 MD):** Czas zarezerwowany na synchronizację prac między 4 osobami oraz naprawianie błędów wykrytych w trakcie integracji modułów.
