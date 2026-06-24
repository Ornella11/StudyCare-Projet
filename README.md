# StudyCare 🎓

StudyCare est une application web de gestion pédagogique et de suivi des notes développée pour les étudiants, les enseignants et les administrateurs. Elle permet un suivi en temps réel des performances académiques à travers des tableaux de bord dynamiques et des outils d'administration simplifiés.

---

## 🚀 Installation

### Prérequis

* **Node.js** (version 16 ou supérieure)
* **MySQL** / **MAMP** / **XAMPP** (avec phpMyAdmin)

### 1. Clonage et configuration du projet

```bash
git clone <https://github.com/Ornella11/StudyCare-Projet.git>
cd StudyCare
```

### 2. Configuration de la base de données

1. Lancez votre serveur local MySQL (via XAMPP, MAMP ou WampServer).
2. Ouvrez phpMyAdmin et créez une base de données nommée `studycare`.
3. Importez le fichier `studycare.sql` situé à la racine du projet afin de charger la structure des tables et les données de test initiales.

### 3. Installation des dépendances Back-end

```bash
cd backend
npm install
```

### 4. Installation des dépendances Front-end

```bash
cd frontend
npm install
```

---

## 💻 Exécution

Pour faire fonctionner l'application, vous devez lancer simultanément le serveur Back-end et le serveur Front-end.

### 1. Démarrer le Back-end (API)

```bash
cd backend
node server.js
```

Le serveur démarre sur :

```text
http://localhost:3000
```

### 2. Démarrer le Front-end (Vue.js)

```bash
cd frontend
npm run dev
```

L'application sera accessible sur l'URL locale fournie par Vite :

```text
http://localhost:5173
```

---


## 🛠️ Technologies utilisées

### Front-end

* HTML5
* CSS3
* JavaScript ES6+
* Vue.js 3
* Vue Router
* Pinia
* Axios / Fetch API

### Back-end

* Node.js
* Express.js
* MySQL

### Architecture

* Architecture Frontend / Backend
* API REST

---

## 👨‍🎓 Espace Étudiant

### Tableau de bord personnel

* Visualisation de la moyenne générale.
* Affichage du nombre total de crédits ECTS validés.

### Graphiques de performance

* Suivi des moyennes par Unité d'Enseignement (UE) sous forme de diagramme à barres.
* Répartition détaillée des résultats par matière sous forme de graphique Doughnut.

### Filtre par semestre

* Consultation des résultats du Semestre 1.
* Consultation des résultats du Semestre 2.
* Mise à jour dynamique des statistiques et graphiques.

---

## 👨‍🏫 Espace Enseignant

### Suivi global de la promotion

* Affichage des statistiques globales de la classe.
* Visualisation des moyennes générales et des performances par UE.

### Analyse individuelle

* Sélection d'un étudiant via un menu déroulant.
* Consultation de son évolution académique.
* Visualisation détaillée des notes et résultats.

### Gestion des notes

* Ajout d'une nouvelle évaluation.
* Modification en temps réel des notes existantes.
* Suppression d'évaluations directement depuis l'interface.

---

## 👨‍💼 Espace Administrateur

### Contrôle global des données

* Accès aux statistiques complètes de la promotion.
* Consultation des profils individuels des étudiants.

### Gestion des modules

* Création de nouveaux modules d'enseignement.
* Association des modules à un semestre.
* Suppression des modules existants.

### Gestion des matières

* Création de nouvelles matières.
* Association dynamique à un module existant.
* Attribution d'un enseignant responsable.
* Définition du coefficient de la matière.

### Modération des notes

* Attribution de nouvelles notes.
* Modification des notes existantes.
* Suppression des notes sur l'ensemble du système.

---

## 📈 Objectif du projet

StudyCare vise à centraliser la gestion pédagogique d'un établissement d'enseignement en proposant une plateforme unique permettant :

* Aux étudiants de suivre leurs résultats en temps réel.
* Aux enseignants de gérer les évaluations et d'analyser les performances de leurs classes.
* Aux administrateurs de superviser l'ensemble du système pédagogique.

---

## 👥 Auteurs

Projet réalisé dans le cadre du module de Développement Web.

* Ornella MOTENGO BAUTI
* Melek USTUN
