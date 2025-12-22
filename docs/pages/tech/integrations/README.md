# Integracje z zewnętrznymi serwisami

## Dostępne źródła

Aplikacja integruje się z siedmioma zewnętrznymi API dostarczającymi dane do wyświetlenia w telegazecie:
- [Narodowy Bank Polski](https://api.nbp.pl/) - kursy walut
- [OpenMeteo](https://open-meteo.com/en/docs) - dane pogodowe
- [Lotto](https://developers.lotto.pl/) - dane losowań lotto
- [News Data](https://newsdata.io/) - wiadomości
- [Jooble](https://help.jooble.org/en/support/solutions/articles/60001448238-rest-api-documentation) - oferty pracy
- [Mój codzienny horoskop](https://www.moj-codzienny-horoskop.com/webmaster/api-horoskop-xml-json.htm) - horoskop
- [Highlightly](https://highlightly.net/documentation/football/) - dane piłkarskie
- [TVP](https://www.tvp.pl/prasa) - program TVP

## Konfiguracja web clientów

W backendzie aplikacji w pliku `application.properties` jest wyznaczona specjalna sekcja do konfiguracji webclientów.

Wszystkie pola muszą być wypełnione, aby program działał poprawnie. Pola dotyczące webclientów mają prefix `webclient`. Pole te zaleca się dostarczyć do aplikacji przez zmienne środowiskowe.

Konfiguracja web clientów dotyczy: timeoutów, baz adresów url oraz api-keys, jeśli są potrzebne w danym kliencie.

Wszystkie połączenia do zewnętrznych API odbywają się asynchronicznie, co poprawia doświadczenia użytkownika i przyspiesza pobieranie większej ilości danych. Każde źródło ma skonfigurowanego osobnego klienta.

### Tabelka konfiguracyjna

W poniższej tabeli znajdują się wszystkie klucze wymagane do konfiguracji web clientów. Secrety należy przekazać przez zmienne środowikowe, jest to krok wymagany. Dodatkowo można edytować bazowy adres url i czas timeoutów ustawiając odpowiednią wartość w zmiennej przypisanej do klucza. Jeśli zmienna nie jest ustawiona, przypisania zostanie wartość domyślna. Zaleca się nie edytować bazowych adresów URL - obecne są przetestowane i poprawne (stan na: 2025-11-26).

| Kategoria    | Klucz konfiguracji                | Domyślna wartość                          | Zmienna środowiskowa               | Opis                                          |
|--------------|-----------------------------------|-------------------------------------------|------------------------------------|-----------------------------------------------|
| **General**  | `webclient.response-timeout-ms`   | `5000`                                    | WEBCLIENT_RESPONSE_TIMEOUT_MS      | maksymalny czas oczekiwania na odpowiedź w ms |
|              | `webclient.connection-timeout-ms` | `5000`                                    | WEBCLIENT_TIMEOUT_MS               | maksymalny czas zestawienia połączenia w ms   |
| **Base URL** | `webclient.nbp-base-url`          | `https://api.nbp.pl/`                     | WEBCLIENT_NBP_API_BASE_URL         | adres URL api NBP                             |
|              | `webclient.open-meteo-base-url`   | `https://api.open-meteo.com/`             | WEBCLIENT_OPEN_METEO_API_BASE_URL  | adres URL api OpenMeteo                       |
|              | `webclient.lotto-base-url`        | `https://developers.lotto.pl/`            | WEBCLIENT_LOTTO_API_BASE_URL       | adres URL api Lotto                           |
|              | `webclient.news-data-base-url`    | `https://newsdata.io/`                    | WEBCLIENT_NEWS_DATA_API_BASE_URL   | adres URL api NewsData                        |
|              | `webclient.jooble-base-url`       | `https://jooble.org/`                     | WEBCLIENT_JOOBLE_API_BASE_URL      | adres URL api Jooble                          |
|              | `webclient.horoscope-base-url`    | `https://www.moj-codzienny-horoskop.com/` | WEBCLIENT_HOROSCOPE_API_BASE_URL   | adres URL api moj-codzienny-horoskop          |
|              | `webclient.highlightly-base-url`  | `https://sports.highlightly.net/`         | WEBCLIENT_HIGHLIGHTLY_API_BASE_URL | adres URL api Highlightly                     |
|              | `webclient.tvp-base-url`          | `https://www.tvp.pl/`                     | WEBCLIENT_TVP_API_BASE_URL         | adres URL api TVP                             |
| **Secrets**  | `webclient.lotto-secret`          | `secret-must-be-provided`                 | WEBCLIENT_LOTTO_SECRET             | wymagany - Api Key Lotto                      |
|              | `webclient.news-data-secret`      | `secret-must-be-provided`                 | WEBCLIENT_NEWS_DATA_SECRET         | wymagany - Api Key NewsData                   |
|              | `webclient.jooble-secret`         | `secret-must-be-provided`                 | WEBCLIENT_JOOBLE_SECRET            | wymagany - Api Key Jooble                     |
|              | `webclient.highlightly-secret`    | `secret-must-be-provided`                 | WEBCLIENT_HIGHLIGHTLY_SECRET       | wymagany - Api Key Highlightly                |

## Format zwracanego contentu

Wszystkie integracja mają ujednolicone DTO (`ExternalDataResponse`), które zawiera pola:
- `source` - źródło danych (String)
- `title` - tytuł contentu (String)
- `description` - główny opis contentu (String)
- `additionalData` - dodatkowe informacje, zależne od pola `source` (Map<String, Object>)

Zawartości pól `additionalData` oraz `source` są zależne od integracji, a szczegóły a ich temat znajdują się w załącznikach poniżej:
- [Narodowy Bank Polski](./nbp.md)
- [OpenMeteo](./openmeteo.md)
- [Lotto](./lotto.md)
- [News Data](./newsdata.md)
- [Jooble](./jooble.md)
- [Mój codzienny horoskop](./horoskop.md)
- [Highlightly](./highlightly.md)
- [TVP](./tvp.md)

## Obsługa błędów

W przypadku gdy pobranie danych z zewnętrznego serwisu zakończy się niepowodzeniem, błąd zostanie przekazany dalej wraz z źródłowym kodem błedu.

Błąd będzie wyświetlony w tym samym formacie, co pozostałe błędy w aplikacji: ([ProblemDetail](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/http/ProblemDetail.html)
