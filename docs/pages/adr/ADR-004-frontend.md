# ADR-004: Architektura frontendu i stylizacja retro telegazety

- **Status:** Zaakceptowana
- **Data:** 2025-12-12
- **Autorzy:** Rafał Wilczewski

---

## 1. Kontekst

Aplikacja telegazety wymaga unikalnego, retro designu nawiązującego do klasycznych telegazet z lat 80/90. Frontend musi obsługiwać zarówno panel administratora, jak i widok użytkownika końcowego.

Wymagania funkcjonalne:
- stylizacja retro z efektami kineskopowymi (CRT),
- obsługa ASCII art w treści stron,
- responsywny design,
- podział na widok użytkownika i panel administratora,
- routing z obsługą numerów stron telegazety,
- komunikacja z backendem przez REST API,
- możliwość mockowania danych podczas developmentu.

Wymagania techniczne:
- nowoczesny stack frontendowy,
- szybki development i hot reload,
- łatwa integracja z backendem Spring Boot,
- możliwość precyzyjnej kontroli nad stylizacją,
- minimalna wielkość bundle'a.

---

## 2. Rozważane opcje

### 2.1. Framework frontendowy

#### Opcja A: React + Vite

**Zalety:**
- [+] Szybki development dzięki Vite (hot module replacement).
- [+] Duża społeczność i ekosystem bibliotek.
- [+] Doskonała dokumentacja i wsparcie.
- [+] Łatwa integracja z React Router dla routingu stron telegazety.
- [+] Możliwość użycia hooków do zarządzania stanem.
- [+] Vite zapewnia szybkie buildy i małe bundle size.

**Wady:**
- [-] Wymaga dodatkowych bibliotek do zarządzania stanem (opcjonalnie).
- [-] Więcej boilerplate niż w Vue.

---

#### Opcja B: Vue.js + Vite

**Zalety:**
- [+] Prostsza składnia dla początkujących.
- [+] Wbudowany system reaktywności.

**Wady:**
- [-] Mniejsza społeczność niż React.
- [-] Zespół ma większe doświadczenie z Reactem.
- [-] Mniej bibliotek dedykowanych do specyficznych zastosowań.

---

#### Opcja C: Angular

**Zalety:**
- [+] Full-featured framework z wszystkim out-of-the-box.

**Wady:**
- [-] Zbyt ciężki jak na relatywnie prosty projekt.
- [-] Dłuższy czas nauki i wdrożenia.
- [-] Wolniejszy development experience.
- [-] Overkill dla aplikacji telegazety.

---

### 2.2. Stylizacja CSS

#### Opcja A: CSS Modules + Vanilla CSS (dla efektów retro)

**Zalety:**
- [+] Pełna kontrola nad efektami CRT (scanlines, glow, animacje).
- [+] Precyzyjne stylowanie ASCII art i monospace fonts.
- [+] Brak dodatkowych zależności dla custom efektów.
- [+] Scoped styles dzięki CSS Modules (brak konfliktów nazw).
- [+] Najlżejszy bundle size.
- [+] Łatwe tworzenie unikalnych animacji @keyframes.

**Wady:**
- [-] Więcej ręcznego pisania CSS dla powtarzalnych komponentów.
- [-] Brak utility classes dla szybkiego prototypowania.

---

#### Opcja B: Tailwind CSS

**Zalety:**
- [+] Szybkie budowanie layoutów (grid, flexbox, spacing).
- [+] Wbudowana responsywność.
- [+] Utility-first approach dla powtarzalnych elementów.

**Wady:**
- [-] Efekty CRT i retro animacje wymagają custom CSS mimo wszystko.
- [-] Większy bundle size.
- [-] Utility classes mogą być nadmiarowe dla prostych komponentów.
- [-] Pixel-perfect ASCII art design cięższy do osiągnięcia.

---

#### Opcja C: Styled Components

**Zalety:**
- [+] CSS-in-JS z scoped styles.
- [+] Dynamiczne style based on props.

**Wady:**
- [-] Runtime overhead - wolniejszy niż CSS Modules.
- [-] Globalne efekty (CRT na całą stronę) trudniejsze do implementacji.
- [-] Większy bundle size.
- [-] Nie ma sensu dla statycznego retro designu.

---

### 2.3. Routing

#### Opcja A: React Router v6

**Zalety:**
- [+] Standard dla React applications.
- [+] Łatwa obsługa parametrów URL (np. `/page/:pageNumber`).
- [+] Protected routes dla panelu admina.
- [+] Wsparcie dla nested routing.

**Wady:**
- [-] Dodatkowa zależność (ale standardowa).

---

#### Opcja B: Custom routing solution

**Wady:**
- [-] Reinventing the wheel.
- [-] Większy nakład pracy.
- [-] Brak wsparcia społeczności.

---

### 2.4. Zarządzanie stanem

#### Opcja A: React Context API + useState/useReducer

**Zalety:**
- [+] Wbudowane w React, brak dodatkowych bibliotek.
- [+] Wystarczające dla prostego stanu (auth, current page).
- [+] Łatwe do zrozumienia i implementacji.

**Wady:**
- [-] Może być nieoptymalne dla bardzo złożonego stanu.

---

#### Opcja B: Redux / Zustand

**Zalety:**
- [+] Centralny store dla całej aplikacji.
- [+] DevTools do debugowania.

**Wady:**
- [-] Overkill dla prostej aplikacji telegazety.
- [-] Dodatkowa złożoność i boilerplate.

---

### 2.5. Komunikacja z API

#### Opcja A: Axios

**Zalety:**
- [+] Automatyczna transformacja JSON.
- [+] Interceptory dla JWT tokens.
- [+] Lepsze error handling.
- [+] Cancel requests.

**Wady:**
- [-] Dodatkowa zależność (lekka).

---

#### Opcja B: Fetch API

**Zalety:**
- [+] Natywne API przeglądarki.
- [+] Brak dodatkowych zależności.

**Wady:**
- [-] Brak interceptorów out-of-the-box.
- [-] Więcej boilerplate dla error handling.

---

## 3. Decyzja

Wybieramy następujący stack technologiczny dla frontendu:

### **Framework:** React 18 + Vite
- React do budowy komponentów UI.
- Vite jako build tool dla szybkiego developmentu.

### **Stylizacja:** CSS Modules (główne) + opcjonalnie Tailwind CSS (layout)
- CSS Modules / Vanilla CSS dla efektów retro (CRT, scanlines, glow, ASCII art).
- Opcjonalnie Tailwind CSS wyłącznie dla layoutu (grid, spacing) jeśli okaże się potrzebne.
- Czcionka: VT323 lub Press Start 2P (Google Fonts).

### **Routing:** React Router v6
- Obsługa parametrów URL dla numerów stron (`/page/:pageNumber`).
- Protected routes dla panelu admina (`/admin/*`).

### **Stan:** React Context API + hooks
- Context dla autoryzacji (JWT token, user info).
- useState/useReducer dla lokalnego stanu komponentów.

### **API:** Axios
- Centralna konfiguracja z interceptorami dla JWT.
- Mockowanie danych podczas developmentu.

---

## 4. Uzasadnienie

**React + Vite** zapewnia najszybszy development experience przy zachowaniu wysokiej wydajności. Zespół ma doświadczenie z Reactem, co przyspieszy implementację.

**CSS Modules** dają pełną kontrolę nad unikalnymi efektami retro, których nie da się osiągnąć utility classami. Dla telegazety z efektami CRT, ASCII art i pixel-perfect designem, custom CSS jest niezbędny. Tailwind może być dodany opcjonalnie tylko dla podstawowego layoutu, jeśli okaże się to przydatne.

**React Router** jest standardem i doskonale obsługuje parametryzowany routing potrzebny dla struktury numerów stron telegazety.

**Context API** jest wystarczający dla prostego stanu aplikacji (auth, current page), bez niepotrzebnej złożoności Redux.

**Axios** ułatwia obsługę JWT tokenów przez interceptory i zapewnia lepszy developer experience niż czysty Fetch API.

---

## 5. Konsekwencje

### Pozytywne
- [+] Szybki development dzięki Vite (HMR w < 100ms).
- [+] Pełna kontrola nad stylizacją retro (CRT effects, ASCII art).
- [+] Małe bundle size dzięki Vite tree-shaking i CSS Modules.
- [+] Łatwe mockowanie danych podczas developmentu.
- [+] Prosta architektura - łatwa do utrzymania przez mały zespół.
- [+] Protected routes zabezpieczają panel admina.
- [+] Interceptory Axios automatycznie dodają JWT do requestów.

### Negatywne
- [-] Więcej ręcznego pisania CSS niż z Tailwind (ale konieczne dla retro efektów).
- [-] Wymaga dyscypliny w organizacji plików CSS.
- [-] Context API może wymagać optymalizacji jeśli stan się rozrośnie.

---

## 6. Struktura projektu

```
/frontend/
├── public/
│   └── fonts/           # Retro fonts (VT323, Press Start 2P)
├── src/
│   ├── assets/          # Images, ASCII art
│   ├── components/
│   │   ├── admin/       # Admin panel components
│   │   ├── user/        # User view components
│   │   └── shared/      # Shared components (Navbar, etc.)
│   ├── contexts/
│   │   └── AuthContext.jsx
│   ├── hooks/           # Custom hooks
│   ├── mocks/           # Mock API data
│   │   ├── authMock.js
│   │   ├── pagesMock.js
│   │   └── integrationsMock.js
│   ├── pages/
│   │   ├── admin/       # Admin pages
│   │   └── user/        # User pages
│   ├── services/
│   │   └── api.js       # Axios configuration
│   ├── styles/
│   │   ├── global.css   # Reset, fonts
│   │   ├── retro.css    # CRT effects, animations
│   │   └── components/  # CSS Modules
│   ├── utils/           # Helper functions
│   ├── App.jsx
│   └── main.jsx
├── .env.example
├── vite.config.js
└── package.json
```

---

## 7. Przykładowa implementacja

### Efekt CRT (retro.css):
```css
@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');

body {
  background: #000;
  color: #0f0;
  font-family: 'VT323', monospace;
  overflow: hidden;
}

/* CRT Screen Effect */
.crt-effect {
  position: relative;
  animation: flicker 0.15s infinite;
  text-shadow: 0 0 5px #0f0, 0 0 10px #0f0;
}

/* Scanlines */
.crt-effect::before {
  content: " ";
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  background: linear-gradient(
    rgba(18, 16, 16, 0) 50%,
    rgba(0, 0, 0, 0.25) 50%
  );
  background-size: 100% 4px;
  z-index: 2;
  pointer-events: none;
}

/* Screen curvature */
.crt-effect::after {
  content: " ";
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  background: rgba(18, 16, 16, 0.1);
  border-radius: 10% / 50%;
  z-index: 2;
  pointer-events: none;
}

@keyframes flicker {
  0% { opacity: 0.97; }
  5% { opacity: 1; }
  10% { opacity: 0.97; }
  100% { opacity: 1; }
}

/* ASCII Art Container */
.ascii-art {
  font-family: 'Courier New', monospace;
  line-height: 1.2;
  letter-spacing: 0;
  white-space: pre;
  color: #0f0;
}
```

### Protected Route:
```jsx
// components/ProtectedRoute.jsx
import { Navigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

export const ProtectedRoute = ({ children }) => {
  const { token } = useAuth();
  
  if (!token) {
    return <Navigate to="/admin/login" replace />;
  }
  
  return children;
};
```

### Axios Configuration:
```javascript
// services/api.js
import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8080/api',
});

// Request interceptor - add JWT token
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('jwt_token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor - handle errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('jwt_token');
      window.location.href = '/admin/login';
    }
    return Promise.reject(error);
  }
);

export default api;
```

---

## 8. Mockowanie danych

Podczas developmentu, przed gotowością backendu, używamy mock danych:

```javascript
// mocks/pagesMock.js
export const mockPages = [
  {
    id: 1,
    pageNumber: 100,
    title: 'STRONA GŁÓWNA',
    category: 'Ogólne',
    content: `╔════════════════════════════════╗
              ║   WITAMY W TELEGAZECIE 2025   ║
              ╚════════════════════════════════╝`,
    integration: null
  },
  // ... więcej stron
];

export const getMockPage = (pageNumber) => {
  return mockPages.find(p => p.pageNumber === pageNumber) || null;
};
```

Mockowanie można później łatwo podmienić na prawdziwe API calls:
```javascript
// BYŁO:
const data = getMockPage(100);

// BĘDZIE:
const { data } = await api.get(`/pages/100`);
```

---

## 9. Alternatywy do rozważenia w przyszłości

- **TypeScript** - jeśli projekt się rozrośnie, może warto dodać type safety.
- **Zustand** - jeśli stan aplikacji znacząco wzrośnie.
- **React Query** - dla lepszego cachowania danych z API.
- **Vitest** - do testów jednostkowych.

---
