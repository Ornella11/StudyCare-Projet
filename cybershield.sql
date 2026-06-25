-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 25 juin 2026 à 09:12
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
-- Base de données : `bdtpjava`
--
CREATE DATABASE IF NOT EXISTS `bdtpjava` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bdtpjava`;

-- --------------------------------------------------------

--
-- Structure de la table `programmeur`
--

DROP TABLE IF EXISTS `programmeur`;
CREATE TABLE IF NOT EXISTS `programmeur` (
  `NOM` varchar(25) DEFAULT NULL,
  `PRENOM` varchar(25) DEFAULT NULL,
  `ANNAISSANCE` varchar(4) DEFAULT NULL,
  `SALAIRE` varchar(5) DEFAULT NULL,
  `PRIME` varchar(5) DEFAULT NULL,
  `PSEUDO` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `programmeur`
--

INSERT INTO `programmeur` (`NOM`, `PRENOM`, `ANNAISSANCE`, `SALAIRE`, `PRIME`, `PSEUDO`) VALUES
('Simpson', 'Homer', '1989', '276', '12', 'homerdev'),
('Simpson', 'Bart', '1994', '277', '13', 'bartdev'),
('Lagaffe', 'Gaston', '1964', '278', '14', 'gastondev'),
('Mafalda', 'Querida', '1977', '279', '17', 'mafaldadev');
--
-- Base de données : `cinema`
--
CREATE DATABASE IF NOT EXISTS `cinema` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `cinema`;

-- --------------------------------------------------------

--
-- Structure de la table `artiste`
--

DROP TABLE IF EXISTS `artiste`;
CREATE TABLE IF NOT EXISTS `artiste` (
  `Nom` varchar(20) NOT NULL,
  `Prenom` varchar(15) DEFAULT NULL,
  `Annee_naissance` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`Nom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `artiste`
--

INSERT INTO `artiste` (`Nom`, `Prenom`, `Annee_naissance`) VALUES
('Allen', 'Woody', '1938'),
('Burton', 'Tim', '1958'),
('Cage', 'Nicolas', '1954'),
('Cameron', 'James', '1943'),
('Cruise', 'Tom', '1960'),
('Curtis', 'Michael', '1902'),
('De Palma', 'Brian', '1953'),
('Depp', 'Johnny', '1967'),
('DiCaprio', 'Leonardo', '1973'),
('Eastwood', 'Clint', '1932'),
('Gillian', 'Terry', '1944'),
('Hitchcock', 'Alfred', '1898'),
('Hudson', 'Hugh', NULL),
('Hunt', 'Greg', '1950'),
('Keitel', 'Harvey', '1940'),
('Kubrick', 'Stanley', '1935'),
('Kusturica', 'Emir', '1959'),
('Lambert', 'Christophe', '1953'),
('Lang', 'Fritz', '1899'),
('Lynch', 'David', '1946'),
('Novak', 'Kim', NULL),
('Ricci', 'Christina', '1974'),
('Spielberg', 'Steven', '1943'),
('Stewart', 'James', '1911'),
('Tarantino', 'Quentin', '1948'),
('Travolta', 'John', '1953'),
('Truffaut', 'Francois', '1938'),
('Willis', 'Bruce', '1952'),
('Woo', 'John', '1951');

-- --------------------------------------------------------

--
-- Structure de la table `cinema`
--

DROP TABLE IF EXISTS `cinema`;
CREATE TABLE IF NOT EXISTS `cinema` (
  `Nom_cinema` varchar(10) NOT NULL,
  `Arrondissement` decimal(2,0) DEFAULT NULL,
  `Adresse` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Nom_cinema`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `cinema`
--

INSERT INTO `cinema` (`Nom_cinema`, `Arrondissement`, `Adresse`) VALUES
('Halles', '1', 'Forum des Halles'),
('Kino', '15', '3 Bd Raspail'),
('Nations', '12', '3 Rue de Reuilly'),
('Rex', '2', '22 Bd Poissoniere');

-- --------------------------------------------------------

--
-- Structure de la table `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `ID_film` decimal(10,0) NOT NULL DEFAULT '0',
  `Titre` varchar(30) DEFAULT NULL,
  `Annee` decimal(4,0) DEFAULT NULL,
  `Nom_Realisateur` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_film`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `film`
--

INSERT INTO `film` (`ID_film`, `Titre`, `Annee`, `Nom_Realisateur`) VALUES
('1', 'Reservoir Dogs', '1992', 'Tarantino'),
('3', 'Twin Peaks', '1990', 'Lynch'),
('5', 'Underground', '1995', 'Kusturica'),
('6', 'Psychose', '1960', 'Hitchcock'),
('7', 'Shining', '1980', 'Kubrick'),
('10', 'Annie Hall', '1977', 'Allen'),
('11', 'Jurassic Park', '1992', 'Spielberg'),
('32', 'Rencontres du 3eme type', '1978', 'Spielberg'),
('33', 'Piege de cristal', '1990', 'Hunt'),
('34', 'Une journee en enfer', '1994', 'Hunt'),
('35', '48 minutes pour vivre', '1992', 'Hunt'),
('38', 'Metropolis', '1926', 'Lang'),
('43', 'Manhattan', '1979', 'Allen'),
('45', 'Impitoyable', '1992', 'Eastwood'),
('57', 'Brazil', '1984', 'Gillian'),
('65', 'Vertigo', '1958', 'Hitchcock'),
('73', 'Pulp Fiction', '1995', 'Tarantino'),
('85', 'Greystocke', '1984', 'Hudson'),
('89', 'Le dernier metro', '1980', 'Truffaut'),
('90', 'Casablanca', '1942', 'Curtis'),
('101', 'Broken Arrow', '1996', 'Woo'),
('102', 'Volte-Face', '1997', 'Woo'),
('104', 'Titanic', '1998', 'Cameron'),
('135', 'Mission Impossible 2', '2000', 'Woo'),
('136', 'Mission Impossible', '1997', 'De Palma'),
('141', 'Sleepy Hollow', '1999', 'Burton'),
('142', 'Edward scissorhands', '1990', 'Burton');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `Nom_Role` varchar(20) NOT NULL,
  `ID_film` decimal(10,0) NOT NULL DEFAULT '0',
  `Nom_acteur` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_film`,`Nom_acteur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`Nom_Role`, `ID_film`, `Nom_acteur`) VALUES
('Mr White', '1', 'Keitel'),
('Mr Brown', '1', 'Tarantino'),
('Jonas', '10', 'Allen'),
('Bernard', '32', 'Truffaut'),
('McLane', '33', 'Willis'),
('McLane', '34', 'Willis'),
('McLane', '35', 'Willis'),
('Davis', '43', 'Allen'),
('Munny', '45', 'Eastwood'),
('Elster', '65', 'Novak'),
('Ferguson', '65', 'Stewart'),
('Wolf', '73', 'Keitel'),
('Vega', '73', 'Travolta'),
('Coolidge', '73', 'Willis'),
('Tarzan', '85', 'Lambert'),
('Deakins', '101', 'Travolta'),
('Troy', '102', 'Cage'),
('Archer', '102', 'Travolta'),
('Dowson', '104', 'DiCaprio'),
('Howard', '135', 'Cruise'),
('Howard', '136', 'Cruise'),
('Crane', '141', 'Depp'),
('Van Tassel', '141', 'Ricci'),
('Edward', '142', 'Depp');

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

DROP TABLE IF EXISTS `salle`;
CREATE TABLE IF NOT EXISTS `salle` (
  `Nom_cinema` varchar(10) NOT NULL,
  `No_salle` decimal(2,0) NOT NULL DEFAULT '0',
  `Climatise` char(1) DEFAULT NULL,
  `Capacite` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`Nom_cinema`,`No_salle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `salle`
--

INSERT INTO `salle` (`Nom_cinema`, `No_salle`, `Climatise`, `Capacite`) VALUES
('Halles', '1', 'O', '75'),
('Halles', '2', 'N', '60'),
('Halles', '3', 'N', '60'),
('Kino', '1', 'N', '280'),
('Kino', '2', 'O', '120'),
('Kino', '3', 'O', '130'),
('Nations', '1', 'O', '130'),
('Nations', '2', 'N', '90'),
('Nations', '3', 'N', '60'),
('Rex', '1', 'O', '150'),
('Rex', '2', 'O', '100'),
('Rex', '3', 'N', '80'),
('Rex', '4', 'N', '80');

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

DROP TABLE IF EXISTS `seance`;
CREATE TABLE IF NOT EXISTS `seance` (
  `Nom_cinema` varchar(10) NOT NULL,
  `No_salle` decimal(2,0) NOT NULL DEFAULT '0',
  `No_seance` decimal(2,0) NOT NULL DEFAULT '0',
  `Heure_debut` decimal(4,2) DEFAULT NULL,
  `Heure_fin` decimal(4,2) DEFAULT NULL,
  `ID_film` decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Nom_cinema`,`No_salle`,`No_seance`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `seance`
--

INSERT INTO `seance` (`Nom_cinema`, `No_salle`, `No_seance`, `Heure_debut`, `Heure_fin`, `ID_film`) VALUES
('Halles', '1', '1', '9.99', '9.99', '32'),
('Halles', '1', '2', '9.99', '9.99', '32'),
('Halles', '1', '3', '9.99', '9.99', '32'),
('Halles', '2', '1', '9.99', '9.99', '5'),
('Halles', '2', '2', '9.99', '9.99', '5'),
('Halles', '2', '3', '9.99', '9.99', '45'),
('Halles', '3', '1', '9.99', '9.99', '3'),
('Halles', '3', '2', '9.99', '9.99', '3'),
('Halles', '3', '3', '9.99', '9.99', '3'),
('Kino', '1', '1', '9.99', '9.99', '34'),
('Kino', '1', '2', '9.99', '9.99', '73'),
('Kino', '1', '3', '9.99', '9.99', '34'),
('Kino', '2', '1', '9.99', '9.99', '43'),
('Kino', '2', '2', '9.99', '9.99', '7'),
('Kino', '2', '3', '9.99', '9.99', '43'),
('Kino', '3', '1', '9.99', '9.99', '101'),
('Kino', '3', '2', '9.99', '9.99', '102'),
('Kino', '3', '3', '9.99', '9.99', '104'),
('Kino', '3', '4', '9.99', '9.99', '104'),
('Nations', '1', '1', '9.99', '9.99', '65'),
('Nations', '1', '2', '9.99', '9.99', '65'),
('Nations', '1', '3', '9.99', '9.99', '65'),
('Nations', '2', '1', '9.99', '9.99', '43'),
('Nations', '2', '2', '9.99', '9.99', '43'),
('Nations', '2', '3', '9.99', '9.99', '43'),
('Nations', '3', '1', '9.99', '9.99', '7'),
('Nations', '3', '2', '9.99', '9.99', '7'),
('Nations', '3', '3', '9.99', '9.99', '7'),
('Rex', '1', '3', '9.99', '9.99', '1'),
('Rex', '1', '4', '9.99', '9.99', '6'),
('Rex', '2', '1', '9.99', '9.99', '34'),
('Rex', '2', '2', '9.99', '9.99', '34'),
('Rex', '2', '3', '9.99', '9.99', '7'),
('Rex', '2', '4', '9.99', '9.99', '65'),
('Rex', '3', '1', '9.99', '9.99', '11'),
('Rex', '3', '2', '9.99', '9.99', '11'),
('Rex', '3', '3', '9.99', '9.99', '11'),
('Rex', '4', '1', '9.99', '9.99', '38'),
('Rex', '4', '2', '9.99', '9.99', '38'),
('Rex', '4', '3', '9.99', '9.99', '38');
--
-- Base de données : `cybershield`
--
CREATE DATABASE IF NOT EXISTS `cybershield` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cybershield`;

-- --------------------------------------------------------

--
-- Structure de la table `actifs`
--

DROP TABLE IF EXISTS `actifs`;
CREATE TABLE IF NOT EXISTS `actifs` (
  `id_actif` int(11) NOT NULL AUTO_INCREMENT,
  `nom_actif` varchar(100) NOT NULL,
  `type_actif` enum('Serveur Web','Base de données','Poste utilisateur','Routeur','Pare-feu','Application métier') NOT NULL,
  `exposition_internet` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_actif`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `actifs`
--

INSERT INTO `actifs` (`id_actif`, `nom_actif`, `type_actif`, `exposition_internet`) VALUES
(1, 'Serveur Web Principal', 'Serveur Web', 1),
(2, 'BDD Production', 'Base de données', 0),
(3, 'Routeur Central', 'Routeur', 1);

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

DROP TABLE IF EXISTS `entreprise`;
CREATE TABLE IF NOT EXISTS `entreprise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `secteur` varchar(100) NOT NULL,
  `employes` int(11) NOT NULL,
  `serveurs` int(11) NOT NULL,
  `postes_clients` int(11) NOT NULL,
  `services_exposes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `entreprise`
--

INSERT INTO `entreprise` (`id`, `nom`, `secteur`, `employes`, `serveurs`, `postes_clients`, `services_exposes`) VALUES
(1, 'Ma Super Entreprise', 'Finance', 150, 12, 140, 'Portail Web HTTPS, Serveur SFTP, VPN');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nom_complet` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('Admin','Analyste','Invite') DEFAULT 'Analyste',
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_user`, `nom_complet`, `email`, `mot_de_passe`, `role`, `date_creation`) VALUES
(1, 'Responsable Cyber', 'admin@cybershield.fr', '$2b$10$EPf9kNJtS8M.OQ3N.yE7O.XvE1L2HjCg7N8XW7Z2xY8z9w0v1u2t3', 'Admin', '2026-06-25 08:50:12');

-- --------------------------------------------------------

--
-- Structure de la table `vulnerabilites`
--

DROP TABLE IF EXISTS `vulnerabilites`;
CREATE TABLE IF NOT EXISTS `vulnerabilites` (
  `id_vuln` int(11) NOT NULL AUTO_INCREMENT,
  `id_actif` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `criticite` enum('Faible','Moyen','Élevé') NOT NULL,
  PRIMARY KEY (`id_vuln`),
  KEY `id_actif` (`id_actif`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vulnerabilites`
--

INSERT INTO `vulnerabilites` (`id_vuln`, `id_actif`, `description`, `criticite`) VALUES
(1, 1, 'Logiciel obsolète (Apache old)', 'Élevé'),
(2, 1, 'Port exposé inutilement', 'Moyen'),
(3, 2, 'Mot de passe faible sur compte admin', 'Élevé'),
(4, 3, 'Absence de sauvegarde automatique', 'Faible');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `vulnerabilites`
--
ALTER TABLE `vulnerabilites`
  ADD CONSTRAINT `vulnerabilites_ibfk_1` FOREIGN KEY (`id_actif`) REFERENCES `actifs` (`id_actif`) ON DELETE CASCADE;
--
-- Base de données : `ecommerce`
--
CREATE DATABASE IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ecommerce`;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `description` text,
  `prix` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `nom`, `description`, `prix`, `image`) VALUES
(1, 'PC Portable', 'PC gaming', '999.99', 'pc.jpg'),
(2, 'Smartphone', 'Téléphone Android', '699.99', 'phone.jpg'),
(3, 'Casque Audio', 'Bluetooth', '89.99', 'headset.jpg');
--
-- Base de données : `entreprise`
--
CREATE DATABASE IF NOT EXISTS `entreprise` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `entreprise`;

-- --------------------------------------------------------

--
-- Structure de la table `departement`
--

DROP TABLE IF EXISTS `departement`;
CREATE TABLE IF NOT EXISTS `departement` (
  `NumDep` int(2) NOT NULL,
  `Nom` varchar(20) NOT NULL,
  `Ville` varchar(50) NOT NULL,
  PRIMARY KEY (`NumDep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `departement`
--

INSERT INTO `departement` (`NumDep`, `Nom`, `Ville`) VALUES
(10, 'FINANCES', 'PARIS'),
(20, 'DSI', 'NICE'),
(30, 'VENTES', 'PARIS'),
(40, 'RH', 'LYON'),
(50, 'MARKETING', 'NICE');

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `NumE` int(4) NOT NULL,
  `Nom` varchar(25) NOT NULL,
  `Fonction` varchar(50) NOT NULL,
  `NumChef` int(4) DEFAULT NULL,
  `DateEntree` date NOT NULL,
  `Salaire` decimal(6,2) NOT NULL,
  `Commission` decimal(6,2) DEFAULT NULL,
  `NumDep` int(2) DEFAULT NULL,
  PRIMARY KEY (`NumE`),
  KEY `Employe_FK_Departement` (`NumDep`),
  KEY `Employe_FK_Chef` (`NumChef`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`NumE`, `Nom`, `Fonction`, `NumChef`, `DateEntree`, `Salaire`, `Commission`, `NumDep`) VALUES
(7369, 'SARAH', 'SECRETAIRE', 7902, '2007-12-17', '1800.00', NULL, 20),
(7370, 'SARAH', 'SECRETAIRE', 7839, '2007-12-17', '2200.00', '200.00', 20),
(7499, 'PIERRE', 'VENDEUR', 7698, '2008-02-20', '1900.00', '300.00', 30),
(7521, 'MARIE', 'VENDEUR', 7698, '2008-02-22', '1950.00', '500.00', 30),
(7566, 'MARC', 'MANAGER', 7839, '2008-04-02', '2975.00', NULL, 20),
(7654, 'MARTIN', 'VENDEUR', 7698, '2008-09-28', '1950.00', '1400.00', 30),
(7698, 'JULIE', 'MANAGER', 7839, '2008-05-01', '2850.00', NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '2008-06-09', '2650.00', NULL, 10),
(7788, 'SCOTT', 'ANALYSTE', 7566, '2010-12-09', '2000.00', '200.00', 20),
(7839, 'KING', 'PRESIDENT', NULL, '2008-11-17', '5000.00', NULL, NULL),
(7844, 'TURNER', 'VENDEUR', 7698, '2008-09-08', '1500.00', '0.00', 30),
(7876, 'SAM', 'SECRETAIRE', 7788, '2011-12-01', '1400.00', NULL, 20),
(7900, 'JAMES', 'SECRETAIRE', 7698, '2008-02-03', '1950.00', NULL, 30),
(7902, 'FORD', 'ANALYSTE', 7566, '2011-12-03', '2200.00', NULL, 20),
(7934, 'HELENE', 'SECRETAIRE', 7782, '2020-01-23', '1300.00', '400.00', 10),
(8000, 'SARAH', 'MANAGER', 7839, '2007-12-17', '3000.00', NULL, 10);

-- --------------------------------------------------------

--
-- Structure de la table `mission`
--

DROP TABLE IF EXISTS `mission`;
CREATE TABLE IF NOT EXISTS `mission` (
  `NumM` int(3) NOT NULL,
  `NumE` int(4) DEFAULT NULL,
  `CIENAME` varchar(50) DEFAULT NULL,
  `Ville` varchar(25) DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  PRIMARY KEY (`NumM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `mission`
--

INSERT INTO `mission` (`NumM`, `NumE`, `CIENAME`, `Ville`, `DateDebut`, `DateFin`) VALUES
(209, 7654, 'BMW', 'BERLIN', '2011-02-09', '2011-02-24'),
(212, 7698, 'MacDo', 'LYON', '2011-03-04', '2012-12-24'),
(213, 7902, 'Oracle', 'NICE', '2012-04-11', '2014-12-24'),
(214, 7900, 'Fidal', 'PARIS', '2011-06-07', '2013-12-24'),
(216, 7698, 'IBM', 'PARIS', '2013-02-09', '2015-12-24'),
(218, 7499, 'Decathlon', 'LYON', '2011-12-26', '2013-12-23'),
(219, 7782, 'BMW', 'NICE', '2011-08-16', '2011-10-15'),
(220, 7369, 'IBM', 'LONDON', '2018-06-20', '2020-12-24'),
(300, 8000, 'EFREI', 'PARIS', '2020-10-16', '2020-12-15');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `employe`
--
ALTER TABLE `employe`
  ADD CONSTRAINT `Employe_FK_Chef` FOREIGN KEY (`NumChef`) REFERENCES `employe` (`NumE`),
  ADD CONSTRAINT `Employe_FK_Departement` FOREIGN KEY (`NumDep`) REFERENCES `departement` (`NumDep`);
--
-- Base de données : `esport`
--
CREATE DATABASE IF NOT EXISTS `esport` DEFAULT CHARACTER SET utf16 COLLATE utf16_unicode_ci;
USE `esport`;

-- --------------------------------------------------------

--
-- Structure de la table `editeur`
--

DROP TABLE IF EXISTS `editeur`;
CREATE TABLE IF NOT EXISTS `editeur` (
  `id_editeur` int(11) NOT NULL AUTO_INCREMENT,
  `nom_editeur` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  PRIMARY KEY (`id_editeur`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `editeur`
--

INSERT INTO `editeur` (`id_editeur`, `nom_editeur`) VALUES
(1, 'Riot Games'),
(2, 'Valve'),
(3, 'EA Sports'),
(4, 'Epic Games');

-- --------------------------------------------------------

--
-- Structure de la table `equipe`
--

DROP TABLE IF EXISTS `equipe`;
CREATE TABLE IF NOT EXISTS `equipe` (
  `id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `nom_equipe` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `date_creation` date NOT NULL,
  `pays_origine` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  PRIMARY KEY (`id_equipe`),
  UNIQUE KEY `uk_equipe_nom` (`nom_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `equipe`
--

INSERT INTO `equipe` (`id_equipe`, `nom_equipe`, `logo`, `date_creation`, `pays_origine`) VALUES
(1, 'Karmine Corp', 'logos/kcorp.png', '2020-03-31', 'France'),
(2, 'Team Vitality', 'logos/vitality.png', '2013-08-05', 'France'),
(3, 'Fnatic', 'logos/fnatic.png', '2004-07-23', 'Royaume-Uni'),
(4, 'G2 Esports', 'logos/g2.png', '2015-02-24', 'Allemagne'),
(5, 'T1', 'logos/t1.png', '2003-12-13', 'Corée du Sud');

-- --------------------------------------------------------

--
-- Structure de la table `equipe_tournoi`
--

DROP TABLE IF EXISTS `equipe_tournoi`;
CREATE TABLE IF NOT EXISTS `equipe_tournoi` (
  `id_equipe` int(11) NOT NULL,
  `id_tournoi` int(11) NOT NULL,
  `date_inscription` date NOT NULL,
  PRIMARY KEY (`id_equipe`,`id_tournoi`),
  KEY `id_tournoi` (`id_tournoi`)
) ENGINE=MyISAM DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `equipe_tournoi`
--

INSERT INTO `equipe_tournoi` (`id_equipe`, `id_tournoi`, `date_inscription`) VALUES
(4, 4, '2026-05-31');

-- --------------------------------------------------------

--
-- Structure de la table `jeu`
--

DROP TABLE IF EXISTS `jeu`;
CREATE TABLE IF NOT EXISTS `jeu` (
  `id_jeu` int(11) NOT NULL AUTO_INCREMENT,
  `nom_jeu` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `genre` enum('FPS','MOBA','Sport','Battle Royale','Autre') COLLATE utf16_unicode_ci NOT NULL,
  `annee_de_sortie` year(4) DEFAULT NULL,
  `id_editeur` int(11) NOT NULL,
  PRIMARY KEY (`id_jeu`),
  UNIQUE KEY `uk_jeu_nom` (`nom_jeu`),
  KEY `fk_jeu_editeur` (`id_editeur`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `jeu`
--

INSERT INTO `jeu` (`id_jeu`, `nom_jeu`, `genre`, `annee_de_sortie`, `id_editeur`) VALUES
(1, 'League of Legends', 'MOBA', 2009, 1),
(2, 'Valorant', 'FPS', 2020, 1),
(3, 'Counter-Strike 2', 'FPS', 2023, 2),
(4, 'EA Sports FC 25', 'Sport', 2024, 3);

-- --------------------------------------------------------

--
-- Structure de la table `joueurs`
--

DROP TABLE IF EXISTS `joueurs`;
CREATE TABLE IF NOT EXISTS `joueurs` (
  `id_joueur` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `nom_joueur` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `prenom_joueur` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `date_naissance` date NOT NULL,
  `nationalite` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `niveau_elo` int(11) NOT NULL,
  PRIMARY KEY (`id_joueur`),
  UNIQUE KEY `uk_joueur_pseudo` (`pseudo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `joueurs`
--

INSERT INTO `joueurs` (`id_joueur`, `pseudo`, `nom_joueur`, `prenom_joueur`, `date_naissance`, `nationalite`, `niveau_elo`) VALUES
(1, 'Faker', 'Lee', 'Sang-hyeok', '1996-05-07', 'Corée du Sud', 2900),
(2, 'Caps', 'Winther', 'Rasmus', '1999-11-17', 'Danemark', 2700),
(3, 'Boaster', 'Howlett', 'Jake', '1995-05-25', 'Royaume-Uni', 2500),
(4, 'ZywOo', 'Herbaut', 'Mathieu', '2000-11-09', 'France', 2950),
(5, 'Vatira', 'Benkirat', 'Axel', '2005-07-24', 'France', 2400),
(6, 'TenZ', 'Ngo', 'Tyson', '2001-05-05', 'Canada', 2650),
(7, 's1mple', 'Kostyliev', 'Oleksandr', '1997-10-02', 'Ukraine', 3000),
(8, 'Rekkles', 'Larsson', 'Martin', '1996-09-20', 'Suède', 2600),
(9, 'Perkz', 'Perkovic', 'Luka', '1998-09-30', 'Croatie', 2550),
(10, 'Niko', 'Kovacs', 'Nikola', '1997-02-16', 'Bosnie', 2850),
(11, 'Yike', 'Sari', 'Martin', '2000-10-15', 'Suède', 2450),
(12, 'Aspas', 'Santos', 'Erick', '2003-06-03', 'Brésil', 2750),
(13, 'Derke', 'Sirmitev', 'Nikita', '2003-02-06', 'Finlande', 2680),
(14, 'Keria', 'Ryu', 'Min-seok', '2002-10-14', 'Corée du Sud', 2780),
(15, 'Oner', 'Mun', 'Hyeon-jun', '2002-12-24', 'Corée du Sud', 2760),
(16, 'Zeus', 'Choi', 'Woo-je', '2004-01-31', 'Corée du Sud', 2790),
(17, 'Gumayusi', 'Lee', 'Min-hyeong', '2002-02-06', 'Corée du Sud', 2770),
(18, 'Sh1n', 'Kim', 'Seungwon', '2004-03-15', 'Corée du Sud', 2400),
(19, 'Exotiik', 'Marty', 'Brice', '2001-06-14', 'France', 2380),
(20, 'Alpha54', 'Arnould', 'Yanis', '2003-08-27', 'France', 2420),
(22, '', '', '', '2003-11-06', '', 25004),
(23, 'melek', 'ustun', 'melek', '2003-11-03', 'fr', 2000);

-- --------------------------------------------------------

--
-- Structure de la table `match`
--

DROP TABLE IF EXISTS `match`;
CREATE TABLE IF NOT EXISTS `match` (
  `id_match` int(11) NOT NULL AUTO_INCREMENT,
  `date_match` datetime NOT NULL,
  `score_equipe1` int(11) DEFAULT '0',
  `score_equipe2` int(11) DEFAULT '0',
  `resultat` varchar(50) COLLATE utf16_unicode_ci DEFAULT NULL,
  `nombre_maps` int(11) DEFAULT '1',
  `id_phase` int(11) NOT NULL,
  `id_equipe_1` int(11) NOT NULL,
  `id_equipe_2` int(11) NOT NULL,
  PRIMARY KEY (`id_match`),
  KEY `fk_match_phase` (`id_phase`),
  KEY `fk_match_equipe1` (`id_equipe_1`),
  KEY `fk_match_equipe2` (`id_equipe_2`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `match`
--

INSERT INTO `match` (`id_match`, `date_match`, `score_equipe1`, `score_equipe2`, `resultat`, `nombre_maps`, `id_phase`, `id_equipe_1`, `id_equipe_2`) VALUES
(1, '2025-10-02 18:00:00', 2, 1, 'Equipe 1', 3, 1, 1, 2),
(2, '2025-10-03 20:00:00', 2, 0, 'Equipe 1', 2, 1, 3, 4),
(3, '2025-10-10 19:00:00', 3, 2, 'Equipe 1', 5, 2, 1, 4),
(4, '2025-11-02 21:00:00', 3, 1, 'Equipe 1', 4, 3, 1, 5),
(5, '2025-08-11 17:00:00', 2, 1, 'Equipe 1', 3, 4, 2, 3),
(6, '2025-08-12 18:30:00', 2, 0, 'Equipe 1', 2, 4, 1, 4),
(7, '2025-08-20 20:00:00', 3, 2, 'Equipe 2', 5, 5, 2, 4),
(8, '2025-08-30 22:00:00', 3, 0, 'Equipe 1', 3, 6, 4, 1),
(9, '2025-09-13 16:00:00', 2, 1, 'Equipe 2', 3, 7, 2, 5),
(10, '2025-09-14 19:00:00', 2, 0, 'Equipe 1', 2, 7, 3, 1),
(11, '2025-09-20 20:00:00', 3, 1, 'Equipe 1', 4, 8, 2, 3),
(12, '2025-09-25 21:00:00', 3, 2, 'Equipe 2', 5, 9, 2, 1),
(13, '2025-09-26 18:00:00', 1, 0, 'Equipe 1', 1, 7, 4, 5),
(14, '2025-09-27 19:00:00', 0, 1, 'Equipe 2', 1, 8, 1, 5),
(15, '2025-09-28 20:00:00', 2, 1, 'Equipe 1', 3, 9, 3, 4),
(16, '2026-05-31 22:33:11', 2, 0, 'Equipe 1 gagne', 2, 1, 3, 4);

-- --------------------------------------------------------

--
-- Structure de la table `phase`
--

DROP TABLE IF EXISTS `phase`;
CREATE TABLE IF NOT EXISTS `phase` (
  `id_phase` int(11) NOT NULL AUTO_INCREMENT,
  `nom_phase` varchar(50) COLLATE utf16_unicode_ci NOT NULL,
  `id_tournoi` int(11) NOT NULL,
  PRIMARY KEY (`id_phase`),
  KEY `fk_phase_tournoi` (`id_tournoi`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `phase`
--

INSERT INTO `phase` (`id_phase`, `nom_phase`, `id_tournoi`) VALUES
(1, 'Phase de groupes', 1),
(2, 'Demi-finales', 1),
(3, 'Finale', 1),
(4, 'Phase de groupes', 2),
(5, 'Demi-finales', 2),
(6, 'Finale', 2),
(7, 'Phase de groupes', 3),
(8, 'Demi-finales', 3),
(9, 'Finale', 3);

-- --------------------------------------------------------

--
-- Structure de la table `roster`
--

DROP TABLE IF EXISTS `roster`;
CREATE TABLE IF NOT EXISTS `roster` (
  `id_jeu` int(11) NOT NULL,
  `id_joueur` int(11) NOT NULL,
  `id_equipe` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_jeu`,`id_joueur`,`id_equipe`,`date_debut`),
  KEY `fk_roster_joueur` (`id_joueur`),
  KEY `fk_roster_equipe` (`id_equipe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `roster`
--

INSERT INTO `roster` (`id_jeu`, `id_joueur`, `id_equipe`, `date_debut`, `date_fin`) VALUES
(1, 1, 5, '2023-01-01', NULL),
(1, 2, 4, '2024-01-01', NULL),
(1, 8, 3, '2023-01-01', NULL),
(1, 9, 4, '2023-01-01', NULL),
(1, 11, 4, '2024-01-01', NULL),
(1, 14, 5, '2023-01-01', NULL),
(1, 15, 5, '2023-01-01', NULL),
(1, 16, 5, '2023-01-01', NULL),
(1, 17, 5, '2023-01-01', NULL),
(2, 3, 2, '2024-01-01', NULL),
(2, 6, 1, '2024-01-01', NULL),
(2, 12, 3, '2024-01-01', NULL),
(2, 13, 3, '2024-01-01', NULL),
(3, 4, 2, '2022-01-01', NULL),
(3, 7, 4, '2021-01-01', NULL),
(3, 10, 4, '2021-01-01', NULL),
(3, 18, 2, '2024-01-01', NULL),
(4, 5, 1, '2024-01-01', NULL),
(4, 19, 1, '2024-01-01', NULL),
(4, 20, 2, '2024-01-01', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `statistiques`
--

DROP TABLE IF EXISTS `statistiques`;
CREATE TABLE IF NOT EXISTS `statistiques` (
  `id_joueur` int(11) NOT NULL,
  `id_match` int(11) NOT NULL,
  `nb_kills` int(11) DEFAULT '0',
  `nb_deaths` int(11) DEFAULT '0',
  `nb_assists` int(11) DEFAULT '0',
  `score` int(11) DEFAULT '0',
  PRIMARY KEY (`id_joueur`,`id_match`),
  KEY `fk_stats_match` (`id_match`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `statistiques`
--

INSERT INTO `statistiques` (`id_joueur`, `id_match`, `nb_kills`, `nb_deaths`, `nb_assists`, `score`) VALUES
(1, 1, 10, 2, 8, 95),
(1, 5, 10, 5, 1, 75),
(1, 6, 13, 5, 10, 91),
(1, 11, 13, 6, 8, 89),
(2, 1, 8, 4, 6, 82),
(2, 6, 9, 4, 6, 80),
(2, 11, 8, 5, 11, 78),
(3, 1, 12, 5, 7, 90),
(3, 6, 11, 7, 5, 82),
(3, 11, 12, 4, 7, 86),
(4, 1, 15, 3, 5, 98),
(4, 6, 18, 3, 7, 100),
(4, 11, 17, 5, 4, 99),
(5, 2, 9, 2, 4, 80),
(5, 7, 14, 6, 8, 89),
(5, 12, 10, 7, 9, 80),
(6, 2, 11, 6, 8, 85),
(6, 7, 10, 5, 9, 83),
(6, 12, 15, 3, 6, 94),
(7, 2, 14, 5, 3, 91),
(7, 7, 16, 4, 5, 95),
(7, 12, 18, 4, 5, 100),
(8, 2, 7, 4, 10, 79),
(8, 7, 7, 8, 6, 70),
(8, 12, 9, 6, 8, 77),
(9, 3, 13, 6, 5, 88),
(9, 8, 12, 4, 11, 90),
(9, 13, 11, 5, 7, 84),
(10, 3, 16, 7, 4, 96),
(10, 8, 17, 5, 4, 98),
(10, 13, 14, 4, 5, 92),
(11, 3, 10, 3, 11, 89),
(11, 8, 8, 3, 10, 79),
(11, 13, 8, 6, 12, 76),
(12, 3, 8, 5, 7, 78),
(12, 8, 9, 7, 6, 74),
(12, 13, 13, 7, 6, 85),
(13, 4, 17, 6, 9, 99),
(13, 9, 15, 6, 8, 93),
(13, 14, 16, 5, 8, 96),
(14, 4, 11, 4, 12, 92),
(14, 9, 10, 4, 9, 85),
(14, 14, 10, 4, 9, 82),
(15, 4, 9, 5, 6, 81),
(15, 9, 13, 5, 7, 88),
(15, 14, 12, 6, 7, 87),
(16, 4, 14, 7, 5, 90),
(16, 9, 11, 6, 12, 86),
(16, 14, 15, 5, 6, 93),
(17, 5, 15, 4, 8, 94),
(17, 10, 14, 5, 6, 90),
(17, 15, 13, 3, 10, 91),
(18, 5, 8, 6, 7, 76),
(18, 10, 9, 7, 8, 75),
(18, 15, 9, 5, 8, 79),
(19, 5, 10, 5, 9, 84),
(19, 10, 12, 4, 5, 84),
(19, 15, 11, 4, 7, 85),
(20, 5, 12, 3, 4, 87),
(20, 10, 16, 3, 7, 97),
(20, 15, 14, 6, 5, 90),
(23, 4, 5, 14, 6, 80);

-- --------------------------------------------------------

--
-- Structure de la table `tournoi`
--

DROP TABLE IF EXISTS `tournoi`;
CREATE TABLE IF NOT EXISTS `tournoi` (
  `id_tournoi` int(11) NOT NULL AUTO_INCREMENT,
  `nom_tournoi` varchar(100) COLLATE utf16_unicode_ci NOT NULL,
  `date_debut_tournoi` date NOT NULL,
  `date_fin_tournoi` date NOT NULL,
  `type` enum('En ligne','LAN') COLLATE utf16_unicode_ci NOT NULL,
  `dotation` decimal(10,2) NOT NULL,
  `statut` enum('À venir','En cours','Terminé') COLLATE utf16_unicode_ci NOT NULL,
  `id_jeu` int(11) NOT NULL,
  PRIMARY KEY (`id_tournoi`),
  KEY `fk_tournoi_jeu` (`id_jeu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Déchargement des données de la table `tournoi`
--

INSERT INTO `tournoi` (`id_tournoi`, `nom_tournoi`, `date_debut_tournoi`, `date_fin_tournoi`, `type`, `dotation`, `statut`, `id_jeu`) VALUES
(1, 'Worlds 2025', '2025-10-01', '2025-11-02', 'LAN', '2500000.00', 'À venir', 1),
(2, 'Valorant Champions 2025', '2025-08-10', '2025-08-30', 'LAN', '1500000.00', 'À venir', 2),
(3, 'Major CS2 Paris', '2025-09-12', '2025-09-25', 'LAN', '1800000.00', 'À venir', 3),
(4, 'CDM 2026', '2026-07-01', '2026-10-01', 'LAN', '500000.00', 'À venir', 4);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `jeu`
--
ALTER TABLE `jeu`
  ADD CONSTRAINT `fk_jeu_editeur` FOREIGN KEY (`id_editeur`) REFERENCES `editeur` (`id_editeur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `match`
--
ALTER TABLE `match`
  ADD CONSTRAINT `fk_match_equipe1` FOREIGN KEY (`id_equipe_1`) REFERENCES `equipe` (`id_equipe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_match_equipe2` FOREIGN KEY (`id_equipe_2`) REFERENCES `equipe` (`id_equipe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_match_phase` FOREIGN KEY (`id_phase`) REFERENCES `phase` (`id_phase`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phase`
--
ALTER TABLE `phase`
  ADD CONSTRAINT `fk_phase_tournoi` FOREIGN KEY (`id_tournoi`) REFERENCES `tournoi` (`id_tournoi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `roster`
--
ALTER TABLE `roster`
  ADD CONSTRAINT `fk_roster_equipe` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_roster_jeu` FOREIGN KEY (`id_jeu`) REFERENCES `jeu` (`id_jeu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_roster_joueur` FOREIGN KEY (`id_joueur`) REFERENCES `joueurs` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `statistiques`
--
ALTER TABLE `statistiques`
  ADD CONSTRAINT `fk_stats_joueur` FOREIGN KEY (`id_joueur`) REFERENCES `joueurs` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stats_match` FOREIGN KEY (`id_match`) REFERENCES `match` (`id_match`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tournoi`
--
ALTER TABLE `tournoi`
  ADD CONSTRAINT `fk_tournoi_jeu` FOREIGN KEY (`id_jeu`) REFERENCES `jeu` (`id_jeu`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de données : `helpmr`
--
CREATE DATABASE IF NOT EXISTS `helpmr` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `helpmr`;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Username` longtext,
  `PasswordHash` longtext,
  `Email` longtext,
  PRIMARY KEY (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
CREATE TABLE IF NOT EXISTS `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `__efmigrationshistory`
--

INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
('20241128211735_InitialCreate', '8.0.10');
--
-- Base de données : `prog_bd`
--
CREATE DATABASE IF NOT EXISTS `prog_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `prog_bd`;

-- --------------------------------------------------------

--
-- Structure de la table `programmeur`
--

DROP TABLE IF EXISTS `programmeur`;
CREATE TABLE IF NOT EXISTS `programmeur` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `adresse` varchar(1000) NOT NULL,
  `pseudo` varchar(255) NOT NULL,
  `responsable` varchar(255) NOT NULL,
  `hobby` varchar(255) NOT NULL,
  `anNaissance` int(11) NOT NULL,
  `salaire` double NOT NULL,
  `prime` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `programmeur`
--

INSERT INTO `programmeur` (`id`, `nom`, `prenom`, `adresse`, `pseudo`, `responsable`, `hobby`, `anNaissance`, `salaire`, `prime`) VALUES
(5, 'USTUN', 'Melek', '55 rue de l\'EFREI', 'Melek USTUN', 'melek', 'cuisine', 2003, 1000, 1000),
(11, 'hhh', 'jjoo', 'kjjkl', 'hgji', 'jhhik', 'hgyjhu', 2000, 3000, 100),
(8, 'motengo bauti', 'ornella', 'rue de l\'efrei', 'ornella', 'melek', 'danse', 2004, 2000, 50),
(9, 'jhjh', 'llk', 'rue du bkabla', 'mkjh', 'melek', 'hhj', 2000, 1000, 1000),
(14, 'doe', 'jean', 'rue de l\'efrei', 'jean doe', 'melek', 'tennis', 2003, 3000, 20);

-- --------------------------------------------------------

--
-- Structure de la table `programmeur_projet`
--

DROP TABLE IF EXISTS `programmeur_projet`;
CREATE TABLE IF NOT EXISTS `programmeur_projet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projet_id` int(11) NOT NULL,
  `programmeur_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_projet_programmeur` (`programmeur_id`),
  KEY `fk_programmeur_projet` (`projet_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `programmeur_projet`
--

INSERT INTO `programmeur_projet` (`id`, `projet_id`, `programmeur_id`) VALUES
(1, 1, 4),
(2, 1, 5),
(6, 2, 7),
(5, 2, 7),
(7, 2, 5),
(8, 2, 5),
(9, 2, 5),
(10, 1, 10),
(11, 3, 11),
(12, 5, 14);

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(255) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin_prevue` date NOT NULL,
  `etat` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id`, `intitule`, `date_debut`, `date_fin_prevue`, `etat`) VALUES
(1, 'Projet java', '2025-12-01', '2026-01-23', 'Non débuté'),
(2, 'Projet Test', '2024-02-15', '2024-04-10', 'Non débuté'),
(3, 'Projet x', '2026-01-23', '2026-03-23', 'Non débuté'),
(4, 'Projet Y', '2026-03-21', '2026-05-11', 'Non débuté'),
(5, 'Projet Python', '2026-02-10', '2026-04-10', 'Non débuté');
--
-- Base de données : `studycare`
--
CREATE DATABASE IF NOT EXISTS `studycare` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `studycare`;

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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

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
(7, 'Analyse', 5, 4, 2),
(12, 'python', 5, 1, 3),
(13, 'Anglais', 5, 1, 5),
(14, 'Anglais', 5, 1, 5);

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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `modules`
--

INSERT INTO `modules` (`id_module`, `nom_module`, `semestre`) VALUES
(1, 'Développement Web', 'S1'),
(2, 'Bases de Données', 'S1'),
(3, 'Mathématiques', 'S1'),
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
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`id_note`, `id_etudiant`, `id_matiere`, `note`, `type_evaluation`, `date_evaluation`) VALUES
(31, NULL, 3, '16.00', 'Contrôle', '2026-10-12'),
(2, 1, 2, '14.00', 'Projet', '2026-01-22'),
(3, 1, 4, '17.00', 'Examen', '2026-02-05'),
(4, 2, 1, '13.00', 'Contrôle', '2026-01-15'),
(5, 2, 3, '15.00', 'Projet', '2026-01-30'),
(6, 2, 5, '15.00', 'Examen', '2026-02-06'),
(7, 3, 2, '12.50', 'Contrôle', '2026-01-20'),
(8, 3, 4, '18.00', 'Projet', '2026-02-01'),
(9, 3, 6, '14.50', 'Examen', '2026-02-10'),
(10, 4, 1, '11.00', 'Contrôle', '2026-01-15'),
(11, 4, 7, '13.50', 'Examen', '2026-02-12'),
(13, 5, 3, '17.50', 'Projet', '2026-01-30'),
(16, 6, 4, '14.00', 'Examen', '2026-02-05'),
(17, 6, 5, '12.50', 'Projet', '2026-02-06'),
(19, 7, 6, '16.00', 'Contrôle', '2026-02-10'),
(20, 7, 7, '15.00', 'Examen', '2026-02-12'),
(22, 8, 2, '9.50', 'Contrôle', '2026-01-20'),
(23, 8, 3, '11.50', 'Projet', '2026-01-30'),
(24, 8, 4, '13.00', 'Examen', '2026-02-05'),
(34, 1, 12, '20.00', 'Contrôle', '2026-02-10'),
(33, 2, 1, '15.00', 'Contrôle', '2026-02-10'),
(28, 10, 1, '18.00', 'Contrôle', '2026-01-15'),
(29, 10, 3, '17.00', 'Projet', '2026-01-30'),
(30, 10, 6, '15.50', 'Examen', '2026-02-10'),
(32, 1, 1, '15.00', 'Contrôle', '2026-02-12');

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
--
-- Base de données : `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET utf32 COLLATE utf32_unicode_ci;
USE `test`;

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `NumE` int(4) NOT NULL,
  `Nom` varchar(25) COLLATE utf32_unicode_ci NOT NULL,
  `Fonction` varchar(50) COLLATE utf32_unicode_ci NOT NULL,
  `NumChef` int(4) DEFAULT NULL,
  `DateEntree` date NOT NULL,
  `Salaire` decimal(6,2) NOT NULL,
  `Commission` decimal(6,2) DEFAULT NULL,
  `NumDep` int(2) DEFAULT NULL,
  PRIMARY KEY (`NumE`),
  KEY `Employe_FK_Departement` (`NumDep`)
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mission`
--

DROP TABLE IF EXISTS `mission`;
CREATE TABLE IF NOT EXISTS `mission` (
  `NumM` int(3) NOT NULL,
  `NumE` int(4) DEFAULT NULL,
  `CIENAME` varchar(50) COLLATE utf32_unicode_ci DEFAULT NULL,
  `Ville` varchar(25) COLLATE utf32_unicode_ci DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  PRIMARY KEY (`NumM`)
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
