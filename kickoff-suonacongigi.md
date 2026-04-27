# 🎸 Suona con Gigi — Kickoff di Progetto
**Data:** oggi  
**Scrum Master:** Giorgia  
**Team:** 6 persone  
**Deadline:** lunedì prossimo

---

## Situazione di partenza

✅ Backend del docente funzionante su tutte le macchine  
✅ Swagger disponibile su `http://localhost:8080/swagger-ui.html`  
⏳ Angular: installazione domani in aula  
⏳ Frontend: da costruire interamente questa settimana

---

## Divisione dei moduli

Ognuno è responsabile di **un'area verticale** — dalla chiamata API al componente Angular.

| # |    Persona   |         Area        | Endpoints principali |
|---|--------------|---------------------|----------------------|
| 1 |   Clorinda   | **Auth + Routing**  | `POST /api/auth/login` `POST /api/auth/register` + guard + interceptor JWT |
| 2 |   Eleonora   | **Profilo utente**  | `GET /api/users/me` `PUT /api/users/me/musical-profile` + cataloghi generi/strumenti/artisti |
| 3 |   Brandon    | **Eventi (utente)** | `GET /api/events` `POST /api/events/:id/register` `DELETE /api/events/:id/unregister` |
| 4 |   Beatrice   | **Forum**           | `GET /api/forum/categories` thread, post, creazione, eliminazione |
| 5 |   Gianluca   | **Area admin**      | CRUD eventi, lista iscritti, moderazione post |
| 6 | Giorgia (SM) | **Scaffolding + layout + sblocchi** | Navbar, routing principale, struttura cartelle, review PR |

> **Regola:** se sei bloccato più di 30 minuti, lo dici subito in chat — non aspettare il giorno dopo.

---

## Piano della settimana

### Oggi (senza Angular)
- [ ] Compilare la tabella sopra con i nomi reali
- [ ] Aprire Swagger e esplorare gli endpoint della propria area
- [ ] Studiare le interfacce TypeScript condivise (`models.ts`)
- [ ] Disegnare su carta le schermate da costruire
- [ ] Decidere la struttura delle cartelle Angular insieme

### Domani — setup Angular
- [ ] `ng new suona-con-gigi-frontend` (uno solo crea, gli altri clonano da Git)
- [ ] Struttura cartelle concordata
- [ ] `AuthService` con login, register, salvataggio JWT in localStorage
- [ ] `JwtInterceptor` che aggiunge il token a ogni richiesta
- [ ] `AuthGuard` per proteggere le rotte
- [ ] Routing principale con lazy loading per ogni modulo

### Mercoledì–Giovedì
- [ ] Ogni persona sviluppa i componenti della propria area
- [ ] Daily standup mattina (10 min): *cosa ho fatto / cosa faccio / sono bloccato?*

### Venerdì
- [ ] Prima integrazione completa — test con il backend reale
- [ ] Ogni area deve mostrare almeno una schermata funzionante end-to-end

### Sabato–Domenica
- [ ] Fix, validazioni form (Reactive Forms), gestione errori
- [ ] Stile e pulizia UI
- [ ] Postman Collection (almeno i flussi principali)

### Lunedì — consegna
- [ ] Test finale completo
- [ ] Demo del progetto

---

## Regole Git (fondamentali con 6 persone)

```
main          ← solo codice funzionante, si mergia solo a fine giornata
develop       ← branch di integrazione comune
feature/auth  ← branch personale per area (es: feature/eventi, feature/forum)
```

**Flusso quotidiano:**
1. `git pull origin develop` (prima di iniziare)
2. Lavoro sul tuo branch `feature/nome-area`
3. `git push` del tuo branch
4. Pull Request verso `develop` — Giorgia fa la review
5. Merge solo se non ci sono conflitti

> ⚠️ **Non committare mai direttamente su main o develop.**

---

## Struttura cartelle Angular (da concordare insieme oggi)

```
src/
└── app/
    ├── core/
    │   ├── services/        ← AuthService, EventService, ForumService...
    │   ├── guards/          ← AuthGuard, AdminGuard
    │   ├── interceptors/    ← JwtInterceptor
    │   └── models/          ← models.ts (interfacce TypeScript condivise)
    ├── shared/
    │   └── components/      ← Navbar, Footer, componenti riutilizzabili
    └── features/
        ├── auth/            ← login, registrazione
        ├── profile/         ← profilo utente
        ├── events/          ← lista e dettaglio eventi
        ├── forum/           ← categorie, thread, post
        └── admin/           ← dashboard admin
```

---

## Cosa fa il backend — mappa rapida

| Area | Endpoint base | Chi lo usa |
|------|--------------|------------|
| Auth | `/api/auth` | Tutti (login/register) |
| Utenti | `/api/users` | Profilo + Admin |
| Artisti | `/api/artists` | Profilo (selezione) + Admin (CRUD) |
| Generi | `/api/genres` | Profilo (selezione) + Admin (CRUD) |
| Strumenti | `/api/instruments` | Profilo (selezione) + Admin (CRUD) |
| Eventi | `/api/events` | Evento (lista/iscrizione) + Admin (CRUD) |
| Forum | `/api/forum` | Forum (tutto) |

**Header da mandare in ogni richiesta autenticata:**
```
Authorization: Bearer <token_jwt>
```
Il token si ottiene al login e va salvato in `localStorage`.

---

## Contatti e strumenti

- **Swagger:** `http://localhost:8080/swagger-ui.html`
- **Repository Git:** _______ (inserire link)
- **Chat di gruppo:** _______ (WhatsApp / Discord)
- **Scrum Master:** Giorgia

---

> *"Backend pronto. Frontend da costruire. Una settimana. Ce la facciamo."* 🎵
