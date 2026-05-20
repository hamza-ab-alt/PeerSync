CREATE DATABASE peersync;
USE peersync;
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(50) NOT NULL UNIQUE
);

-- 3. Table des Utilisateurs
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       nom VARCHAR(100) NOT NULL,
                       prenom VARCHAR(100) NOT NULL,
                       email VARCHAR(150) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL, -- Stockera le hash (password_hash)
                       points INT DEFAULT 0,
                       role_id INT NOT NULL,
                       FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- 4. Table des Compétences (Tags)
CREATE TABLE skills (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Table Pivot: Compétences de l'utilisateur (Maîtrisées vs À travailler)
CREATE TABLE user_skills (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             user_id INT NOT NULL,
                             skill_id INT NOT NULL,
                             niveau ENUM('maitrise', 'a_travailler') NOT NULL, -- ENUM strict pour séparer Tuteur/Apprenant
                             FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                             FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
                             UNIQUE KEY unique_user_skill (user_id, skill_id) -- Évite les doublons
);

-- 6. Table des Demandes d'Aide (Tickets)
CREATE TABLE help_requests (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               title VARCHAR(255) NOT NULL,
                               description TEXT NOT NULL,
                               status ENUM('pending', 'assigned', 'resolved') DEFAULT 'pending',
                               student_id INT NOT NULL, -- L'apprenant en difficulté
                               tutor_id INT DEFAULT NULL, -- Le tuteur (NULL au début)
                               skill_id INT NOT NULL, -- La techno concernée
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               resolved_at TIMESTAMP NULL DEFAULT NULL,
                               FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
                               FOREIGN KEY (tutor_id) REFERENCES users(id) ON DELETE SET NULL,
                               FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE RESTRICT
);

-- 7. Table des Avis / Commentaires (US 5 intégrée avec rating)
CREATE TABLE reviews (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         comment TEXT DEFAULT NULL,
                         rating INT NOT NULL, -- Note de 1 à 5 (La validation stricte se fera aussi en PHP)
                         id_helprequest INT NOT NULL UNIQUE, -- Une seule review par ticket
                         FOREIGN KEY (id_helprequest) REFERENCES help_requests(id) ON DELETE CASCADE
);

-- 8. Table des Badges (Bonus Gamification)
CREATE TABLE badges (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        title VARCHAR(100) NOT NULL UNIQUE,
                        description TEXT NOT NULL
);

-- 9. Table Pivot: Badges obtenus par les tuteurs
CREATE TABLE user_badges (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             user_id INT NOT NULL,
                             badge_id INT NOT NULL,
                             awarded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                             FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
                             UNIQUE KEY unique_user_badge (user_id, badge_id)
);