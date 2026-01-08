# Teletext Backend API

**OpenAPI Version:** 3.1.0  
**API Version:** `0.0.1-SNAPSHOT`  
**Contact:** Teletext Dev Team – [sebastiangorski00@gmail.com](mailto:sebastiangorski00@gmail.com)

---

## Serwer

```text
http://localhost:8080
```

## Security

- `bearerAuth` (HTTP, scheme: bearer, bearerFormat: JWT)

---

## Tagi

- **Teletext Pages** — Endpoints for retrieving teletext pages  
- **Teletext Categories** — Endpoints for retrieving teletext categories

---

## Endpoints

### GET `/api/public/pages`

**Tag:** Teletext Pages  
**Summary:** Get all teletext pages by category  
**Description:** Retrieve a list of teletext pages filtered by category and optional title  
**OperationId:** `getAllPages`

#### Parameters

- `category` — **query**, **required**, `string`, enum: `NEWS`, `SPORTS`, `LOTTERY`, `TV`, `WEATHER`, `JOBS`, `HOROSCOPE`, `FINANCE`, `MISC`  
- `title` — **query**, optional, `string`

#### Responses

- `200 OK` — `application/json`: **Array** of `TeletextPageResponse`
- `400 Bad Request` — `application/json`: `ProblemDetail`
- `401 Unauthorized` — `application/json`: `ProblemDetail`
- `403 Forbidden` — `application/json`: `ProblemDetail`
- `404 Not Found` — `application/json`: `ProblemDetail`
- `409 Conflict` — `application/json`: `ProblemDetail`
- `422 Unprocessable Entity` — `application/json`: `ProblemDetail`
- `500 Internal Server Error` — `application/json`: `ProblemDetail`

---

### GET `/api/public/pages/{pageNumber}`

**Tag:** Teletext Pages  
**Summary:** Get teletext page by page number  
**Description:** Retrieve detailed information about a teletext page by its page number  
**OperationId:** `getPageByNumber`

#### Parameters

- `pageNumber` — **path**, **required**, `integer (int32)`

#### Responses

- `200 OK` — `application/json`: `TeletextDetailedPageResponse`
- (pozostałe kody jak wyżej)

---

### GET `/api/public/categories`

**Tag:** Teletext Categories  
**Summary:** Get All Categories  
**Description:** Retrieve a list of all teletext categories  
**OperationId:** `getCategories`

#### Responses

- `200 OK` — `application/json`: **Array** of `TeletextCategoryResponse`
- (pozostałe kody jak wyżej)

---

### GET `/api/public/categories/{category}`

**Tag:** Teletext Categories  
**Summary:** Get Category By Name  
**Description:** Retrieve a specific teletext category by its name  
**OperationId:** `getCategoryByName`

#### Parameters

- `category` — **path**, **required**, `string`, enum: `NEWS`, `SPORTS`, `LOTTERY`, `TV`, `WEATHER`, `JOBS`, `HOROSCOPE`, `FINANCE`, `MISC`

#### Responses

- `200 OK` — `application/json`: `TeletextCategoryResponse`
- (pozostałe kody jak wyżej)

---

## Components

### Schemas

#### `ProblemDetail`

```yaml
type: object
properties:
  type:
    type: string
    format: uri
  title:
    type: string
  status:
    type: integer
    format: int32
  detail:
    type: string
  instance:
    type: string
    format: uri
  properties:
    type: object
    additionalProperties: true
```

#### `TeletextCategoryResponse`

```yaml
type: object
properties:
  originalName:
    type: string
  category:
    type: string
  description:
    type: string
  mainPage:
    type: integer
    format: int32
  nextFreePage:
    type: integer
    format: int32
```

#### `TeletextPageResponse`

```yaml
type: object
properties:
  id:
    type: integer
    format: int64
  pageNumber:
    type: integer
    format: int32
  title:
    type: string
  category:
    $ref: '#/components/schemas/TeletextCategoryResponse'
  createdAt:
    type: string
    format: date-time
  updatedAt:
    type: string
    format: date-time
```

#### `TeletextDetailedPageResponse`

```yaml
type: object
properties:
  id:
    type: integer
    format: int64
  type:
    type: string
  pageNumber:
    type: integer
    format: int32
  category:
    $ref: '#/components/schemas/TeletextCategoryResponse'
  content:
    $ref: '#/components/schemas/TeletextFullPageContentResponse'
  createdAt:
    type: string
    format: date-time
  updatedAt:
    type: string
    format: date-time
```

#### `TeletextFullPageContentResponse`

```yaml
type: object
properties:
  source:
    type: string
  title:
    type: string
  description:
    type: string
  additionalData:
    type: object
    additionalProperties: true
  createdAt:
    type: string
    format: date-time
  updatedAt:
    type: string
    format: date-time
```

---

### Security Schemes

#### `bearerAuth`

```yaml
type: http
scheme: bearer
bearerFormat: JWT
```
