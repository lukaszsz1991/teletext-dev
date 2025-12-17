# Model bazy danych

## Struktura bazy danych
Baza danych aplikacji **Teletext** została zaprojektowana w celu efektywnego zarządzania treściami telegazety, użytkownikami oraz automatycznymi integracjami. System opiera się na relacyjnej bazie danych **PostgreSQL 17.2**.

## Diagram encji (ERD)
Poniższy diagram przedstawia kluczowe tabele oraz relacje między nimi (użytkownicy, strony telegazety, kategorie oraz statystyki).

```mermaid
erDiagram
    USER ||--o{ PAGE : "tworzy"
    CATEGORY ||--o{ PAGE : "klasyfikuje"
    PAGE ||--o{ STATISTIC : "generuje"
    PAGE ||--o{ INTEGRATION : "posiada"

    USER {
        bigint id
        string username
        string password
        string role
    }

    PAGE {
        int page_number
        string title
        text content
        timestamp last_updated
    }

    CATEGORY {
        int id
        string name
    }

    INTEGRATION {
        int id
        string type
        string api_endpoint
    }

    STATISTIC {
        int id
        int view_count
        timestamp date
    }
