# AC-GG

Piattaforma web per musicisti che permette di scoprire eventi dal vivo, iscriversi, partecipare a forum tematici e costruire un profilo musicale personale.
---
 
## Indice
 
- [Stack tecnologico](#stack-tecnologico)
- [Funzionalità](#funzionalità)
- [Architettura](#architettura)
- [Avvio in locale](#avvio-in-locale)
- [Struttura del progetto](#struttura-del-progetto)
- [API — panoramica endpoint](#api--panoramica-endpoint)
- [Autenticazione](#autenticazione)
- [Team](#team)
---
 
## Stack tecnologico
 
**Backend**
- Java 21 + Spring Boot 3.5
- Spring Security + JWT (JJWT 0.12.6)
- Spring Data JPA + Hibernate
- MySQL
- Lombok
- Swagger / OpenAPI 3 — disponibile su `http://localhost:8080/swagger-ui.html`
- Bean Validation (Jakarta)
**Frontend**
- Angular 21 — standalone components, Signals
- Reactive Forms
- HTTP interceptors (JWT, error handling)
- Route guards (AuthGuard, AdminGuard)
---
 
## Funzionalità
 
**Utenti**
- Registrazione e login con autenticazione JWT
- Profilo musicale: strumenti suonati, generi preferiti, artisti preferiti
- Visualizzazione e modifica del proprio profilo
**Eventi**
- Lista degli eventi con disponibilità posti in tempo reale
- Ricerca per titolo, descrizione o location
- Iscrizione e disiscrizione con feedback immediato
- Sezione "I miei eventi"
**Forum**
- Categorie tematiche con thread e post
- Creazione di nuovi thread e risposte
- Eliminazione dei propri contenuti
**Admin**
- Dashboard con statistiche (utenti, eventi, thread)
- CRUD completo sugli eventi
- Gestione categorie del forum
- Abilitazione e disabilitazione degli account utente
---
 
### Prerequisiti
 
- Java 21
- Node.js 18+
- MySQL in esecuzione
- Angular CLI (`npm install -g @angular/cli`)
### Backend
 
```bash
cd suonacongigi-backend
 
# Configura il database in src/main/resources/application.properties
# spring.datasource.url=jdbc:mysql://localhost:3306/suonacongigi
# spring.datasource.username=root
# spring.datasource.password=tuapassword
 
mvn spring-boot:run
```
 
Il `DatabaseSeeder` popola automaticamente il database al primo avvio con un utente admin, alcuni utenti di esempio, eventi, thread e post.
 
Backend disponibile su: `http://localhost:8080`  
Swagger UI: `http://localhost:8080/swagger-ui.html`
 
### Frontend
 
```bash
cd suonacongigi-frontend
npm install
ng serve
```
 
Frontend disponibile su: `http://localhost:4200`
 
---
 
## Team
 
| Nome | Ruolo |
|------|-------|
| Giorgia | Scrum Master — integrazione, CORS, review PR |
| Gianluca | Backend — Auth & Security |
| Brandon | Backend — Forum & Eventi |
| Clorinda | Frontend — UI & Components |
| Eleonora | Frontend — Forms & Validazioni |
| Beatrice | DB & Testing |
 
Corso: **Generation Italy — Junior Java Developer**
