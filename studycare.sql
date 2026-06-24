-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 24 juin 2026 à 21:02
-- Version du serveur : 5.7.40
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `studycare`
--

-- --------------------------------------------------------

--
-- Structure de la table `enseignants`
--

DROP TABLE IF EXISTS `enseignants`;
CREATE TABLE IF NOT EXISTS `enseignants` (
  `id_enseignant` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_enseignant`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `enseignants`
--

INSERT INTO `enseignants` (`id_enseignant`, `nom`, `prenom`, `email`) VALUES
(1, 'Lemoine', 'Sophie', 'sophie.lemoine@efrei.fr'),
(2, 'Garcia', 'Julien', 'julien.garcia@efrei.fr'),
(3, 'Fournier', 'Claire', 'claire.fournier@efrei.fr'),
(4, 'Roux', 'Marc', 'marc.roux@efrei.fr'),
(5, 'Girard', 'Nadia', 'nadia.girard@efrei.fr');

-- --------------------------------------------------------

--
-- Structure de la table `etudiants`
--

DROP TABLE IF EXISTS `etudiants`;
CREATE TABLE IF NOT EXISTS `etudiants` (
  `id_etudiant` int(11) NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int(11) DEFAULT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `promotion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_etudiant`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_etudiant_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `etudiants`
--

INSERT INTO `etudiants` (`id_etudiant`, `id_utilisateur`, `nom`, `prenom`, `email`, `promotion`) VALUES
(1, 1, 'Dupont', 'Lucas', 'lucas.dupont@efrei.fr', 'ING1'),
(2, 2, 'Martin', 'Emma', 'emma.martin@efrei.fr', 'ING1');

-- --------------------------------------------------------

--
-- Structure de la table `matieres`
--

DROP TABLE IF EXISTS `matieres`;
CREATE TABLE IF NOT EXISTS `matieres` (
  `id_matiere` int(11) NOT NULL AUTO_INCREMENT,
  `nom_matiere` varchar(100) DEFAULT NULL,
  `id_module` int(11) DEFAULT NULL,
  `id_enseignant` int(11) DEFAULT NULL,
  `coefficient` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_matiere`),
  KEY `id_module` (`id_module`),
  KEY `id_enseignant` (`id_enseignant`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `matieres`
--

INSERT INTO `matieres` (`id_matiere`, `nom_matiere`, `id_module`, `id_enseignant`, `coefficient`) VALUES
(1, 'HTML / CSS', 1, 1, 2),
(2, 'JavaScript', 1, 1, 3),
(3, 'Vue.js', 1, 2, 3),
(4, 'SQL', 2, 2, 3),
(5, 'Modélisation UML', 2, 3, 2),
(6, 'Algèbre', 3, 4, 2),
(7, 'Analyse', 3, 4, 2),
(8, 'TCP/IP', 4, 5, 3),
(9, 'Cybersécurité', 4, 5, 2),
(10, 'Java POO', 5, 3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id_module` int(11) NOT NULL AUTO_INCREMENT,
  `nom_module` varchar(100) DEFAULT NULL,
  `semestre` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_module`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `modules`
--

INSERT INTO `modules` (`id_module`, `nom_module`, `semestre`) VALUES
(1, 'Développement Web', 'S1'),
(2, 'Bases de Données', 'S1'),
(3, 'Mathématiques', 'S1'),
(4, 'Réseaux', 'S2'),
(5, 'Programmation Orientée Objet', 'S2');

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE IF NOT EXISTS `notes` (
  `id_note` int(11) NOT NULL AUTO_INCREMENT,
  `id_etudiant` int(11) DEFAULT NULL,
  `id_matiere` int(11) DEFAULT NULL,
  `note` decimal(4,2) DEFAULT NULL,
  `type_evaluation` varchar(50) DEFAULT NULL,
  `date_evaluation` date DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  KEY `id_etudiant` (`id_etudiant`),
  KEY `id_matiere` (`id_matiere`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`id_note`, `id_etudiant`, `id_matiere`, `note`, `type_evaluation`, `date_evaluation`) VALUES
(1, 1, 1, '14.00', 'Contrôle', '2026-01-15'),
(2, 1, 2, '14.00', 'Projet', '2026-01-22'),
(3, 1, 4, '17.00', 'Examen', '2026-02-05'),
(4, 2, 1, '13.00', 'Contrôle', '2026-01-15'),
(5, 2, 3, '16.50', 'Projet', '2026-01-30'),
(6, 2, 5, '15.00', 'Examen', '2026-02-06'),
(7, 3, 2, '12.50', 'Contrôle', '2026-01-20'),
(8, 3, 4, '18.00', 'Projet', '2026-02-01'),
(9, 3, 6, '14.50', 'Examen', '2026-02-10'),
(10, 4, 1, '11.00', 'Contrôle', '2026-01-15'),
(11, 4, 7, '13.50', 'Examen', '2026-02-12'),
(12, 4, 8, '10.50', 'Projet', '2026-02-20'),
(13, 5, 3, '17.50', 'Projet', '2026-01-30'),
(14, 5, 8, '16.00', 'Examen', '2026-02-20'),
(15, 5, 10, '15.50', 'Contrôle', '2026-03-01'),
(16, 6, 4, '14.00', 'Examen', '2026-02-05'),
(17, 6, 5, '12.50', 'Projet', '2026-02-06'),
(18, 6, 9, '13.00', 'Contrôle', '2026-02-25'),
(19, 7, 6, '16.00', 'Contrôle', '2026-02-10'),
(20, 7, 7, '15.00', 'Examen', '2026-02-12'),
(21, 7, 10, '18.00', 'Projet', '2026-03-01'),
(22, 8, 2, '9.50', 'Contrôle', '2026-01-20'),
(23, 8, 3, '11.50', 'Projet', '2026-01-30'),
(24, 8, 4, '13.00', 'Examen', '2026-02-05'),
(25, 9, 8, '14.50', 'Projet', '2026-02-20'),
(26, 9, 9, '16.50', 'Contrôle', '2026-02-25'),
(27, 9, 10, '12.00', 'Examen', '2026-03-01'),
(28, 10, 1, '18.00', 'Contrôle', '2026-01-15'),
(29, 10, 3, '17.00', 'Projet', '2026-01-30'),
(30, 10, 6, '15.50', 'Examen', '2026-02-10');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('Étudiant','Enseignant','Administrateur') NOT NULL,
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`, `date_creation`) VALUES
(1, 'Dupont', 'Lucas', 'lucas.dupont@studycare.fr', 'password123', 'Étudiant', '2026-06-24 16:25:03'),
(2, 'Martin', 'Emma', 'emma.martin@studycare.fr', 'password123', 'Étudiant', '2026-06-24 16:25:03'),
(3, 'Lemoine', 'Sophie', 'sophie.lemoine@studycare.fr', 'password123', 'Enseignant', '2026-06-24 16:25:03'),
(4, 'Garcia', 'Julien', 'julien.garcia@studycare.fr', 'password123', 'Enseignant', '2026-06-24 16:25:03'),
(5, 'Admin', 'Principal', 'admin@studycare.fr', 'admin123', 'Administrateur', '2026-06-24 16:25:03');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
