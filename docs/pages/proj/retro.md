# Retrospekcje i przebieg prac zespołowych

## Sesja Event Stormingu
Na wczesnym etapie projektu zespół przeprowadził sesję **Event Stormingu**, której celem było zrozumienie procesów biznesowych zachodzących w systemie Teletext oraz identyfikacja kluczowych zdarzeń.

### Wnioski z sesji:
* **Zdarzenia kluczowe (Domain Events):** Zidentyfikowano główne akcje, takie jak: *Strona wyświetlona*, *Treść zaktualizowana*, *Dane z API pobrane*, *Użytkownik zalogowany*.
* **Aktorzy:** Wyodrębniono role Administratora (zarządzanie treścią) oraz Czytelnika (przeglądanie i wyszukiwanie).
* **Złożoność integracji:** Sesja obnażyła ryzyko związane z różnorodnością formatów danych z 7 zewnętrznych API, co zaowocowało decyzją o stworzeniu ujednoliconego modułu mapującego dane na format ASCII.

## Spotkania statusowe (Daily Sync)
Zespół spotykał się regularnie (2-3 razy w miesiącu) na krótkich sesjach synchronizacyjnych. Podczas spotkań omawiano:
1. Co zostało zrobione od ostatniego spotkania?
2. Jakie napotkano problemy (blokery)?
3. Co planujemy zrealizować w następnym kroku?

### Kluczowe punkty zwrotne (Milestones):
* **Retrospekcja 1:** Po próbie wdrożenia pierwszej integracji API (Pogoda), zespół zdecydował o wprowadzeniu warstwy **Redis Cache**, aby uniknąć blokowania interfejsu przy opóźnieniach serwerów zewnętrznych.
* **Retrospekcja 2:** Decyzja o uproszczeniu CSS na rzecz "czystego" stylu retro, co pozwoliło zaoszczędzić czas i poprawić czytelność na urządzeniach mobilnych.
* **Retrospekcja 3:** Optymalizacja pracy z bazą danych – przejście z ręcznego tworzenia tabel na automatyczne migracje **Flyway** po tym, jak wystąpiły konflikty w strukturze bazy między członkami zespołu.

## Komunikacja i narzędzia
* **GitHub:** Centralne repozytorium kodu, wykorzystanie *Pull Requests* do wzajemnego sprawdzania kodu (Code Review).
* **Jira/WhatsApp:** Bieżąca komunikacja techniczna i szybkie rozwiązywanie problemów.
* **Google Meet:** Regularne wideokonferencje wykorzystywane do planowania zadań i omawiania dalekobieżnych zadań.

## Podsumowanie współpracy
Mimo statusu osób początkujących, zespół sprawnie podzielił kompetencje:
* **Backend:** Skupienie na logice Spring Boot i integracjach API.
* **Frontend & UX:** Praca nad szablonami Thymeleaf i estetyką ASCII.
* **DevOps & QA:** Zarządzanie kontenerami Docker, Flyway oraz przygotowanie scenariuszy testowych.
