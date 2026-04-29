-- ============================================================
--  SUONA CON GIGI – Schema MySQL
--  Corrisponde ESATTAMENTE a DatabaseSeeder.java → rebuildDatabaseSchema()
--  ⚠️  NON eseguire manualmente: lo gestisce il DatabaseSeeder all'avvio
--  Questo file è per documentazione e consegna del progetto
-- ============================================================

CREATE DATABASE IF NOT EXISTS suonacongigi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE suonacongigi;

-- ── 1. TABELLE INDIPENDENTI (nessuna FK) ────────────────────

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE genres (
    id   BIGINT       AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE instruments (
    id   BIGINT       AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE artists (
    id   BIGINT       AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE forum_categories (
    id          BIGINT       AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- ── 2. TABELLE CON FK VERSO users ───────────────────────────

CREATE TABLE musical_profiles (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    bio     TEXT,
    CONSTRAINT fk_profile_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE events (
    id            BIGINT       AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(200) NOT NULL,
    description   TEXT,
    event_date    DATETIME     NOT NULL,
    location      VARCHAR(255) NOT NULL,
    max_seats     INT          NOT NULL,
    created_by_id BIGINT       NOT NULL,
    CONSTRAINT fk_event_creator
        FOREIGN KEY (created_by_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- ── 3. TABELLE CON FK MULTIPLE ──────────────────────────────

CREATE TABLE event_registrations (
    id            BIGINT    AUTO_INCREMENT PRIMARY KEY,
    event_id      BIGINT    NOT NULL,
    user_id       BIGINT    NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (event_id, user_id),
    CONSTRAINT fk_reg_event
        FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    CONSTRAINT fk_reg_user
        FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE forum_threads (
    id          BIGINT       AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    category_id BIGINT       NOT NULL,
    author_id   BIGINT       NOT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_thread_category
        FOREIGN KEY (category_id) REFERENCES forum_categories(id) ON DELETE CASCADE,
    CONSTRAINT fk_thread_author
        FOREIGN KEY (author_id)   REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE posts (
    id         BIGINT    AUTO_INCREMENT PRIMARY KEY,
    content    TEXT      NOT NULL,
    thread_id  BIGINT    NOT NULL,
    author_id  BIGINT    NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_post_thread
        FOREIGN KEY (thread_id) REFERENCES forum_threads(id) ON DELETE CASCADE,
    CONSTRAINT fk_post_author
        FOREIGN KEY (author_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- ── 4. TABELLE DI JOIN ManyToMany ───────────────────────────

CREATE TABLE profile_genres (
    profile_id BIGINT NOT NULL,
    genre_id   BIGINT NOT NULL,
    PRIMARY KEY (profile_id, genre_id),
    CONSTRAINT fk_pg_profile
        FOREIGN KEY (profile_id) REFERENCES musical_profiles(id) ON DELETE CASCADE,
    CONSTRAINT fk_pg_genre
        FOREIGN KEY (genre_id)   REFERENCES genres(id)           ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE profile_instruments (
    profile_id    BIGINT NOT NULL,
    instrument_id BIGINT NOT NULL,
    PRIMARY KEY (profile_id, instrument_id),
    CONSTRAINT fk_pi_profile
        FOREIGN KEY (profile_id)    REFERENCES musical_profiles(id) ON DELETE CASCADE,
    CONSTRAINT fk_pi_instrument
        FOREIGN KEY (instrument_id) REFERENCES instruments(id)      ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE profile_artists (
    profile_id BIGINT NOT NULL,
    artist_id  BIGINT NOT NULL,
    PRIMARY KEY (profile_id, artist_id),
    CONSTRAINT fk_pa_profile
        FOREIGN KEY (profile_id) REFERENCES musical_profiles(id) ON DELETE CASCADE,
    CONSTRAINT fk_pa_artist
        FOREIGN KEY (artist_id)  REFERENCES artists(id)          ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--  RIEPILOGO: 13 tabelle totali
--  Indipendenti  : users, genres, instruments, artists, forum_categories
--  Con FK        : musical_profiles, events, event_registrations,
--                  forum_threads, posts
--  Join N:M      : profile_genres, profile_instruments, profile_artists
-- ============================================================
