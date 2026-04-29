# 🎸 Suona con Gigi — Kickoff del Progetto
**Scrum Master:** Giorgia  
**Team:** 6 persone  
**Deadline:** 04/05


---

## Situazione di partenza

✅ Backend Spring Boot completo e funzionante su tutte le macchine  
✅ Swagger disponibile su `http://localhost:8080/swagger-ui.html`  
✅ Frontend Angular 21 costruito e funzionante su `http://localhost:4200`  
✅ Autenticazione JWT end-to-end funzionante  
✅ CRUD eventi, forum, profilo musicale implementati  
⏳ Sprint 4 in corso: validazioni form, moderazione contenuti, test, rifinitura UI

---

## Divisione dei moduli

| # |    Persona   |         Area     | Responsabilità principali |
|---|--------------|------------------|---------------------------|
| 1 |   Gianluca   | **Backend — Auth & Security** | `POST /api/auth/login` `POST /api/auth/register` · JWT · SecurityConfig · Bean Validation sui DTO |
| 2 |   Brandon    | **Backend — Forum & Eventi**  | CRUD eventi · iscrizione/disiscrizione · thread · post · moderazione contenuti |
| 3 |   Clorinda   | **Frontend — UI & Components** | EventsList · Navbar · CSS responsivo · feedback visivo · pagina 404 |
| 4 |   Eleonora   | **Frontend — Forms & Validazioni** | `GET /api/users/me` · profilo musicale · Reactive Forms · messaggi di errore · validatori custom |
| 5 |   Beatrice   | **DB & Testing** | Schema MySQL · DatabaseSeeder · Postman Collection · export .sql |
| 6 | Giorgia (SM) | **Scrum Master** | Coordinamento · review PR · integrazione · CORS demo · README · script demo |

> **Regola:** se sei bloccato più di 30 minuti, lo dici subito in chat — non aspettare il giorno dopo.

---

## Piano Sprint 4 — questa settimana

### Gianluca
- [ ] Aggiungere `@NotBlank` / `@Email` / `@Size` ai DTO `RegisterRequest` e `LoginRequest`
- [ ] Testare che un token JWT scaduto restituisca 401 e non 500
- [ ] Aggiornare CORS origin da `localhost:4200` all'IP della macchina demo

### Brandon
- [ ] Implementare `DELETE /api/forum/threads/{id}` (manca nel controller)
- [ ] Aggiungere `@Valid` sui DTO `EventRequest`: titolo obbligatorio, `maxSeats > 0`, data futura
- [ ] Aggiungere campo `hidden` ai Post per moderazione admin
- [ ] Verificare che `GET /api/events/{id}/registrants` restituisca 403 per utenti normali

### Clorinda
- [ ] Usare il signal `actionLoading` nel template HTML di EventsList per disabilitare il bottone durante l'attesa
- [ ] Aggiungere pagina 404 personalizzata (il path `**` attualmente redirige in silenzio)
- [ ] Revisione CSS responsivo: dashboard admin leggibile su schermi piccoli
- [ ] Verificare che il `notifySuccess` dopo iscrizione/disiscrizione sia visibile a schermo

### Eleonora
- [ ] Aggiungere messaggi di errore visibili nei template di `EventForm` e `ProfileForm`
- [ ] Aggiungere validatore custom Angular: `eventDate` deve essere nel futuro
- [ ] Bloccare il bottone submit se `form.invalid` (la logica TS c'è, manca nel template)
- [ ] Aggiungere `markAllAsTouched()` alla submit dell'`EventFormComponent`

### Beatrice
- [ ] Scrivere la Postman Collection: cartelle Auth, Events, Forum, Users con 2-3 request ciascuna
- [ ] Aggiungere test automatici (`pm.test`) per status code 200/201/403/404
- [ ] Aggiungere script "Tests" sul login per salvare il token automaticamente in `{{token}}`
- [ ] Esportare lo schema MySQL finale come file `.sql`
- [ ] Verificare che il DatabaseSeeder popoli correttamente: 1 admin, 2-3 utenti, 3+ eventi, thread e post

### Giorgia (SM)
- [ ] Daily standup ogni mattina (10 min): *cosa ho fatto / cosa faccio / sono bloccata?*
- [ ] Fix CORS nel `SecurityConfig`: aggiungere IP della macchina demo
- [ ] Verificare che tutti abbiano il progetto che gira in locale (backend 8080, frontend 4200)
- [ ] Review PR prima del merge su `develop`
- [ ] Preparare lo script della demo: ordine schermate + cosa dire alla commissione

### Lunedì — consegna
- [ ] Test finale completo end-to-end
- [ ] Demo del progetto alla commissione

---

## Regole Git (fondamentali con 6 persone)

```
main              ← solo codice funzionante, merge solo a fine giornata
develop           ← branch di integrazione comune
feature/auth      ← branch personale per area
feature/eventi
feature/forum
feature/profilo
feature/admin
feature/testing
```

**Flusso quotidiano:**
1. `git pull origin develop` (prima di iniziare)
2. Lavoro sul tuo branch `feature/nome-area`
3. `git push` del tuo branch
4. Pull Request verso `develop` — Giorgia fa la review
5. Merge solo se non ci sono conflitti

> ⚠️ **Non committare mai direttamente su main o develop.**

---

## Struttura cartelle Angular (come da codice)

```
src/
└── app/
    ├── core/
    │   ├── services/        ← AuthService, EventService, ForumService, DashboardService...
    │   ├── guards/          ← AuthGuard, AdminGuard
    │   ├── interceptors/    ← JwtInterceptor, ErrorInterceptor
    │   └── models/          ← interfacce TypeScript condivise
    ├── shared/
    │   ├── components/      ← Navbar, componenti riutilizzabili
    │   ├── base/            ← BaseComponent (LoadingService, UiService)
    │   └── musical-profile-form/
    └── features/
        ├── auth/            ← login, registrazione
        ├── profile/         ← profilo utente + profilo musicale
        ├── events/          ← lista eventi, dettaglio, form create/edit
        ├── forum/           ← categorie, thread, post
        └── admin/           ← dashboard admin con statistiche
```

---

## Cosa fa il backend — mappa rapida

| Area | Endpoint base | Chi lo usa |
|------|--------------|------------|
| Auth | `/api/auth` | Tutti (login/register) |
| Utenti | `/api/users` | Profilo (Eleonora) + Admin |
| Artisti | `/api/artists` | Profilo musicale + Admin (CRUD) |
| Generi | `/api/genres` | Profilo musicale + Admin (CRUD) |
| Strumenti | `/api/instruments` | Profilo musicale + Admin (CRUD) |
| Eventi | `/api/events` | Clorinda (lista/iscrizione) + Brandon (CRUD admin) |
| Forum | `/api/forum` | Brandon (tutto) |

**Header da aggiungere in ogni richiesta autenticata:**
```
Authorization: Bearer <token_jwt>
```
Il token si ottiene al login ed è gestito automaticamente dal `JwtInterceptor` Angular.

---

## Requisiti fuori scope
 
Funzionalità identificate e consapevolmente escluse da questo sprint per vincoli di tempo e complessità. Documentate per eventuali iterazioni future.
 
| ID | Requisito | Motivazione | Implementazione futura |
|----|-----------|-------------|------------------------|
| RF-U01 | Conferma via email alla registrazione | Richiede server SMTP, token di verifica su DB e logica asincrona — fuori scope per una settimana | `JavaMailSender` + token UUID su DB + endpoint `GET /api/auth/verify?token=...` |
 
> La registrazione funziona regolarmente — l'account viene creato e attivato immediatamente. Manca solo la verifica via email.

---

## Note tecniche chiave

- **Signals e standalone components**: tutto il frontend usa Angular 21 con Signals e `toSignal()` — citarlo nella demo come scelta architetturale moderna
- **GlobalExceptionHandler**: tutti gli errori backend sono centralizzati e restituiscono un `ApiEnvelope` uniforme
- **@PreAuthorize**: le rotte admin sono protette sia lato Angular (AdminGuard) che lato Spring (`hasRole('ADMIN')`)
- **DatabaseSeeder**: al primo avvio popola automaticamente il database con dati di esempio

---

## Contatti e strumenti

- **Swagger:** `http://localhost:8080/swagger-ui.html`
- **Repository Git:** https://github.com/gianlucamerlo/AC-GG 
- **Chat di gruppo:** WhatsApp / Discord
- **Scrum Master:** Giorgia

---