# Product Requirements Document (PRD) - Teletext

## Cel projektu
Celem projektu jest stworzenie nowoczesnego systemu zarządzania telegazetą, ułatwiającego tworzenie, edycję i publikację treści w sposób szybki, intuicyjny i zgodny ze współczesnymi standardami cyfrowymi. System umożliwia użytkownikom zarówno przeglądanie dostępnych stron telegazety, jak i zarządzanie jej zawartością w czasie rzeczywistym.

## Założenia funkcjonalne
* **Przeglądanie stron:** Użytkownik może przeglądać strony telegazety z zachowaniem odpowiedniej struktury numerów stron.
* **Wyszukiwanie:** Użytkownik może wyszukiwać informacje po tytułach i kategoriach.
* **Zarządzanie treścią:** Administrator może tworzyć własne strony telegazety, które posiadają numer, tytuł, kategorię oraz treść (tekst i proste elementy graficzne ASCII).
* **Integracje:** System posiada minimum 7 integracji, takich jak pogoda, wyniki lotto, głosowania w Sejmie, ogłoszenia o pracę, kursy walut oraz ceny kruszców.
* **Analityka:** Administrator ma dostęp do statystyk najczęściej odwiedzanych stron przez użytkowników.

## Założenia niefunkcjonalne
* **Minimalistyczny design:** Zredukowana ilość elementów dekoracyjnych na rzecz funkcjonalności i czytelności treści.
* **Responsywność:** Interfejs zaprojektowany w sposób umożliwiający wygodne korzystanie zarówno na komputerach, jak i na urządzeniach mobilnych.
* **Konsekwentna kolorystyka:** Wykorzystanie zieleni jako koloru dominującego w panelach, przyciskach i nagłówkach (nawiązanie do klasycznej telegazety).
* **Niezawodność danych:** W przypadku błędów w formularzach dane wprowadzone przez użytkownika są zachowywane, co poprawia komfort pracy z systemem.
* **Wydajność:** Wykorzystanie systemu Redis do buforowania odpowiedzi i przechowywania danych tymczasowych.
