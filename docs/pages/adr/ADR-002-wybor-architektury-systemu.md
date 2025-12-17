# ADR-002: Wybór architektury monolitycznej zamiast mikroserwisowej

- **Status:** Zaakceptowana  
- **Data:** 2025-11-25  
- **Autorzy:** Sebastian Górski

---

## 1. Kontekst

Projekt Teletext obejmuje panel administratora, zarządzanie stronami telegazety, kategoriami, statystykami oraz kontami użytkowników. Całość jest rozwijana jako aplikacja webowa z backendem w Spring Boot oraz możliwym prostym frontendem.

Zakres funkcjonalny systemu jest spójny i silnie powiązany: logowanie admina, edycja stron, aktualizacja kategorii oraz generowanie statystyk są częścią jednej domeny. Projekt rozwija niewielki zespół, a wymagania dotyczą przede wszystkim szybkości implementacji, prostoty wdrożenia i łatwego utrzymania.

Nie ma wymagań dotyczących niezależnego skalowania modułów ani rozproszonego środowiska na wiele serwisów. System ma działać stabilnie i wydajnie w pojedynczym środowisku produkcyjnym.

---

## 2. Rozważane opcje

### Opcja 1: Architektura monolityczna

**Zalety:**
- [+] Prostsza implementacja i szybszy rozwój.
- [+] Jedno repozytorium, jedna aplikacja, jeden proces wdrożenia.
- [+] Brak konieczności wprowadzania komunikacji między usługami (REST/Kafka/RabbitMQ).
- [+] Łatwiejsze debugowanie i monitorowanie.
- [+] Brak ryzyka związanego z rozproszoną architekturą (sieć, latencja, spójność).
- [+] Niższe koszty utrzymania.

**Wady:**
- [-] Możliwy wzrost złożoności przy bardzo dużej liczbie modułów.
- [-] Mniej elastyczne skalowanie (skalowanie całości zamiast poszczególnych funkcji).

### Opcja 2: Architektura mikroserwisowa

**Zalety:**
- [+] Niezależne skalowanie poszczególnych komponentów.
- [+] Jasny podział odpowiedzialności między usługami.
- [+] Możliwość różnicowania technologii per serwis.

**Wady:**
- [-] Złożona komunikacja między usługami, potrzeba integracji synchronicznej i asynchronicznej.
- [-] Wyższy próg wejścia: potrzeba wdrożenia gatewaya, CI/CD per serwis, rejestru usług, monitoringów, retry, circuit breaker.
- [-] Duży narzut operacyjny.
- [-] Brak głębszego uzasadnienia przy małym, zwartym projekcie takim jak Teletext.

---

## 3. Decyzja

Wybieramy **architekturę monolityczną** jako podstawę projektu Teletext.

---

## 4. Uzasadnienie

Monolit zapewnia najszybszy czas wdrożenia i najłatwiejsze utrzymanie. Funkcjonalności projektu są ze sobą silnie powiązane, nie wymagają niezależnego skalowania i korzystają z jednolitego modelu danych. Mikroserwisy wprowadziłyby niepotrzebną złożoność bez realnych korzyści biznesowych.

Architektura monolityczna pozwala na swobodny rozwój, łatwe testowanie oraz prosty pipeline wdrożeniowy. Dodatkowo jego naturalna integracja ze Spring Boot jest uproszczona i dojrzała.

---

## 5. Konsekwencje

### Pozytywne
- [+] Szybszy rozwój funkcjonalności.
- [+] Prostsze wdrożenia i mniejszy narzut operacyjny.
- [+] Łatwe debugowanie i monitoring.
- [+] Niski koszt utrzymania.
- [+] Jednolity model danych i brak integracji między usługami.

### Negatywne
- [-] Skalowanie tylko poprzez powielanie całej aplikacji.
- [-] W miarę rozwoju projektu konieczna może być modularizacja kodu, aby uniknąć „big ball of mud”.

---
