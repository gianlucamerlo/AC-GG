-- ============================================================
--  SUONA CON GIGI – Database Seeder
--  Corrisponde ESATTAMENTE a DatabaseSeeder.java → executeSeeding()
--  ⚠️  NON eseguire manualmente: lo gestisce il DatabaseSeeder all'avvio
--  Questo file è per documentazione e consegna del progetto
--
--  Password in chiaro per tutti gli utenti: suonacongigi
--  (BCrypt hash generato a runtime da Spring Security)
-- ============================================================

USE suonacongigi;

-- ── 1. GENERI MUSICALI (10) ─────────────────────────────────
-- Ordine esatto da DatabaseSeeder → genreNames[]

INSERT INTO genres (name) VALUES
('Rock'),        -- id 1
('Metal'),       -- id 2
('Jazz'),        -- id 3
('Blues'),       -- id 4
('Pop'),         -- id 5
('Electronic'),  -- id 6
('Classical'),   -- id 7
('Funk'),        -- id 8
('Reggae'),      -- id 9
('Soul');        -- id 10

-- ── 2. STRUMENTI MUSICALI (8) ───────────────────────────────
-- Ordine esatto da DatabaseSeeder → instNames[]

INSERT INTO instruments (name) VALUES
('Chitarra Elettrica'),  -- id 1
('Basso Elettrico'),     -- id 2
('Batteria'),            -- id 3
('Pianoforte'),          -- id 4
('Sassofono'),           -- id 5
('Violino'),             -- id 6
('Tromba'),              -- id 7
('Sintetizzatore');      -- id 8

-- ── 3. ARTISTI (50) ─────────────────────────────────────────
-- Ordine esatto da DatabaseSeeder → artistPool[]

INSERT INTO artists (name) VALUES
('Jimi Hendrix'),            -- id 1
('Led Zeppelin'),            -- id 2
('Pink Floyd'),              -- id 3
('Metallica'),               -- id 4
('Iron Maiden'),             -- id 5
('Miles Davis'),             -- id 6
('John Coltrane'),           -- id 7
('Bill Evans'),              -- id 8
('B.B. King'),               -- id 9
('Eric Clapton'),            -- id 10
('The Beatles'),             -- id 11
('Queen'),                   -- id 12
('David Bowie'),             -- id 13
('Daft Punk'),               -- id 14
('Kraftwerk'),               -- id 15
('Mozart'),                  -- id 16
('Beethoven'),               -- id 17
('Bach'),                    -- id 18
('James Brown'),             -- id 19
('Stevie Wonder'),           -- id 20
('Bob Marley'),              -- id 21
('Peter Tosh'),              -- id 22
('Aretha Franklin'),         -- id 23
('Ray Charles'),             -- id 24
('Prince'),                  -- id 25
('Nirvana'),                 -- id 26
('Pearl Jam'),               -- id 27
('Deep Purple'),             -- id 28
('Black Sabbath'),           -- id 29
('AC/DC'),                   -- id 30
('Chet Baker'),              -- id 31
('Charlie Parker'),          -- id 32
('Thelonious Monk'),         -- id 33
('Muddy Waters'),            -- id 34
('Buddy Guy'),               -- id 35
('Radiohead'),               -- id 36
('Arctic Monkeys'),          -- id 37
('The Strokes'),             -- id 38
('Depeche Mode'),            -- id 39
('New Order'),               -- id 40
('Aphex Twin'),              -- id 41
('Chemical Brothers'),       -- id 42
('Vivaldi'),                 -- id 43
('Chopin'),                  -- id 44
('Earth Wind & Fire'),       -- id 45
('Chaka Khan'),              -- id 46
('Marvin Gaye'),             -- id 47
('Al Green'),                -- id 48
('Red Hot Chili Peppers'),   -- id 49
('Foo Fighters');            -- id 50

-- ── 4. UTENTI (1 Admin + 3 User) ────────────────────────────
-- Password in chiaro: suonacongigi
-- Il BCrypt hash viene generato da Spring a runtime, qui usiamo un hash di esempio valido
-- Hash BCrypt di "suonacongigi" (cost 10):
-- $2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi

INSERT INTO users (username, email, password, role) VALUES
('admin',        'admin@suonacongigi.it', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ADMIN'), -- id 1
('mario_gibson', 'mario@email.it',        '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'USER'),  -- id 2
('elena_sax',    'elena@email.it',        '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'USER'),  -- id 3
('luca_synth',   'luca@email.it',         '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'USER');  -- id 4

-- ── 5. PROFILI MUSICALI (4) ─────────────────────────────────

INSERT INTO musical_profiles (user_id, bio) VALUES
(1, 'Founder della piattaforma e collezionista di vinili.'),           -- id 1 → admin
(2, 'Chitarrista rock vecchio stampo, cerco gente per jam session pesanti.'), -- id 2 → mario_gibson
(3, 'Sassofonista appassionata di jazz classico, sempre alla ricerca di nuovi groove.'), -- id 3 → elena_sax
(4, 'Produttore di musica elettronica, amo i sintetizzatori analogici.'); -- id 4 → luca_synth

-- ── 6. PROFILO ↔ GENERI ─────────────────────────────────────

INSERT INTO profile_genres (profile_id, genre_id) VALUES
-- admin: Pop (5), Soul (10)
(1, 5), (1, 10),
-- mario_gibson: Rock (1), Metal (2)
(2, 1), (2, 2),
-- elena_sax: Jazz (3), Blues (4), Soul (10)
(3, 3), (3, 4), (3, 10),
-- luca_synth: Electronic (6), Funk (8)
(4, 6), (4, 8);

-- ── 7. PROFILO ↔ STRUMENTI ──────────────────────────────────

INSERT INTO profile_instruments (profile_id, instrument_id) VALUES
-- admin: Pianoforte (4), Violino (6)
(1, 4), (1, 6),
-- mario_gibson: Chitarra Elettrica (1), Batteria (3)
(2, 1), (2, 3),
-- elena_sax: Sassofono (5), Tromba (7), Pianoforte (4)
(3, 5), (3, 7), (3, 4),
-- luca_synth: Sintetizzatore (8), Basso Elettrico (2)
(4, 8), (4, 2);

-- ── 8. PROFILO ↔ ARTISTI PREFERITI ─────────────────────────

INSERT INTO profile_artists (profile_id, artist_id) VALUES
-- admin: The Beatles (11), Aretha Franklin (23)
(1, 11), (1, 23),
-- mario_gibson: Jimi Hendrix (1), Led Zeppelin (2), Metallica (4), AC/DC (30)
(2, 1), (2, 2), (2, 4), (2, 30),
-- elena_sax: Miles Davis (6), John Coltrane (7), Bill Evans (8), Aretha Franklin (23)
(3, 6), (3, 7), (3, 8), (3, 23),
-- luca_synth: Daft Punk (14), Kraftwerk (15), Aphex Twin (41), James Brown (19)
(4, 14), (4, 15), (4, 41), (4, 19);

-- ── 9. EVENTI (1) ───────────────────────────────────────────

INSERT INTO events (title, description, event_date, location, max_seats, created_by_id) VALUES
('Summer Jam Session', 'Evento aperto a tutti i generi.',
 DATE_ADD(NOW(), INTERVAL 1 MONTH), 'Parco della Musica', 50, 1); -- id 1, creato da admin

-- ── 10. ISCRIZIONI EVENTI (2) ───────────────────────────────

INSERT INTO event_registrations (event_id, user_id) VALUES
(1, 2), -- mario_gibson iscritto a Summer Jam Session
(1, 3); -- elena_sax iscritto a Summer Jam Session

-- ── 11. CATEGORIE FORUM (2) ─────────────────────────────────

INSERT INTO forum_categories (name, description) VALUES
('Discussioni Generali', 'Chiacchiere sulla musica.'),      -- id 1
('Tendenze',             'Cosa ne sarà della musica in futuro?'); -- id 2

-- ── 12. THREAD DEL FORUM (2) ────────────────────────────────

INSERT INTO forum_threads (title, category_id, author_id) VALUES
('Consigli per iniziare la chitarra',                              1, 2), -- id 1, mario_gibson
('L''intelligenza artificiale sostituirà mai i compositori umani?', 2, 3); -- id 2, elena_sax

-- ── 13. POST (6) ────────────────────────────────────────────

INSERT INTO posts (content, thread_id, author_id) VALUES
-- Thread 1
('Quale Gibson consigliate per il Blues?',   1, 2), -- mario_gibson
('Inizia con una Les Paul Studio!',           1, 1), -- admin
-- Thread 2
('Domanda provocatoria: credete che un algoritmo potrà mai replicare il feeling e l''imprevedibilità di un assolo jazz registrato dal vivo?', 2, 3),
('Secondo me scordatevelo. Manca il sudore, le corde rotte e l''anima. La musica è emozione umana, non un calcolo di probabilità su una scala pentatonica.', 2, 2),
('Vero, però ho provato dei software che generano progressioni armoniche incredibili. Forse l''AI sarà solo il ''nuovo sintetizzatore'': all''inizio lo odiano tutti, poi diventa lo standard.', 2, 3),
('Finché un robot non spacca una chitarra sul palco dopo un feedback assordante, per me non è musica! 🎸', 2, 2);

-- ============================================================
--  RIEPILOGO DATI
--  10 generi | 8 strumenti | 50 artisti
--  4 utenti  | 4 profili musicali
--  1 evento  | 2 iscrizioni
--  2 categorie forum | 2 thread | 6 post
-- ============================================================
