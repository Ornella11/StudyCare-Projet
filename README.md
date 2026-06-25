# CyberCare 🛡️ - Simulateur de Risque Cyber pour PME

CyberCare est une application web Fullstack de simulation et de gestion du risque cyber conçue spécifiquement pour les PME. Elle permet de modéliser une infrastructure d'entreprise, de cartographier ses actifs numériques (serveurs, postes clients, routeurs, etc.), d'identifier ses vulnérabilités et d'évaluer automatiquement son niveau de risque global grâce à un moteur d'analyse embarqué.

---

# 🚀 Installation

## Prérequis

* **Node.js** (version 16 ou supérieure)
* **MySQL** / **MAMP** / **XAMPP** (avec phpMyAdmin)

## 1. Clonage et configuration du projet

```bash
git clone https://github.com/Ornella11/StudyCare-Projet.git
cd CyberTwin
```

## 2. Configuration de la base de données

1. Lancez votre serveur local MySQL (via XAMPP, MAMP ou WampServer).
2. Ouvrez phpMyAdmin et créez une base de données nommée **cybershield**.
3. Importez le fichier SQL de configuration situé à la racine du projet afin de charger la structure des tables :

   * entreprise
   * actifs
   * vulnerabilites
   * utilisateurs

   ainsi que le jeu de données initial.

## 3. Installation des dépendances Back-end (Node.js)

```bash
cd backend
npm install
```

## 4. Installation des dépendances Front-end (Vue.js)

```bash
cd frontend
npm install
```

---

# 💻 Exécution

Pour faire fonctionner l'application, vous devez lancer simultanément le serveur Back-end et le serveur Front-end.

## 1. Démarrer le Back-end (API Express)

```bash
cd backend
node server.js
```

Le serveur démarre sur :

```text
http://localhost:3000
```

## 2. Démarrer le Front-end (Vue.js 3 / Vite)

```bash
cd frontend
npm run dev
```

L'application sera accessible sur :

```text
http://localhost:5173
```

---

# 🛠️ Technologies utilisées

## Front-end

* HTML5
* CSS3
* JavaScript ES6+
* Vue.js 3 (Composition API)
* Vue Router (Navigation Guards pour la sécurité des routes)
* Pinia (Gestion de l'état global avec authStores et cyberStores)
* Chart.js / vue-chartjs (Visualisation des données graphiques)
* Fetch API (Communications asynchrones)

## Back-end

* Node.js
* Express.js
* MySQL2
* JSON Web Tokens (JWT)

## Architecture

* Architecture Frontend / Backend
* API REST sécurisée
* Authentification par jeton JWT

---

# 📊 Fonctionnalités de l'application

## 🏢 1. Gestion du périmètre de l'entreprise

### Modélisation sur-mesure

* Définition du nom de l'entreprise.
* Définition du secteur d'activité.
* Déclaration du nombre de collaborateurs.

### Dimensionnement de l'infrastructure

* Nombre de serveurs physiques ou cloud.
* Nombre de postes clients.

### Surface d'attaque

Déclaration des services critiques exposés sur Internet :

* VPN
* Serveurs Web
* Services métiers
* Applications externes

---

## 🖥️ 2. Cartographie et gestion des actifs (CRUD)

### Inventaire des ressources

Gestion centralisée des équipements et ressources du système d'information :

* Serveur Web
* Base de données
* Poste utilisateur
* Routeur
* Pare-feu
* Application métier

### Gestion CRUD complète

* Création d'actifs
* Consultation d'actifs
* Modification d'actifs
* Suppression d'actifs

### Analyse d'exposition

Chaque actif peut être marqué comme :

* Exposé à Internet
* Interne uniquement

Cette information est utilisée dans le calcul du risque global.

---

## ⚠️ 3. Registre des vulnérabilités

### Gestion des vulnérabilités

Association dynamique de vulnérabilités aux actifs existants.

### Niveaux de criticité

Chaque vulnérabilité possède un niveau :

| Niveau | Score  |
| ------ | ------ |
| Faible | 2 pts  |
| Moyen  | 5 pts  |
| Élevé  | 10 pts |

### Suivi des remédiations

Possibilité de :

* Marquer une vulnérabilité comme résolue.
* Consulter les vulnérabilités actives.
* Consulter l'historique des corrections.

---

## 🧮 4. Moteur de calcul automatique du risque

CyberTwin intègre un algorithme d'évaluation qui calcule en temps réel un score de risque global sur 100 points.

### Critères pris en compte

#### Vulnérabilités actives

* Faible = 2 points
* Moyen = 5 points
* Élevé = 10 points

#### Densité d'exposition

Ratio des actifs exposés sur Internet par rapport au nombre total d'actifs.

#### Taille du système d'information

* Nombre de collaborateurs
* Nombre de serveurs
* Nombre d'équipements

### Résultat

Génération automatique d'un indicateur visuel :

🟢 Faible

🟠 Moyen

🔴 Élevé

---

## 📈 5. Tableau de bord dynamique

### KPIs de sécurité

Affichage des indicateurs principaux :

* Nombre total d'actifs
* Nombre de vulnérabilités
* Nombre d'actifs exposés
* Score de risque global

### Visualisations graphiques

Graphique en barres dynamique représentant :

* La répartition des actifs par catégorie
* La cartographie globale du système d'information

Les données sont mises à jour automatiquement après chaque modification.

---

# 🔒 Sécurité et fonctionnalités avancées

## Authentification JWT

Le système protège les accès sensibles grâce à l'utilisation de JSON Web Tokens.

### Fonctionnement

* Authentification utilisateur
* Génération d'un Token JWT
* Transmission du Token dans l'en-tête Authorization

```http
Authorization: Bearer <token>
```

### Protection des routes

Les routes sensibles de l'API REST nécessitent un Token valide :

* Création d'actifs
* Modification d'actifs
* Gestion des vulnérabilités
* Accès aux statistiques

---

# 👥 Auteurs

Projet de binôme réalisé dans le cadre du module de Développement Fullstack (Vue.js / Node.js).

### Ornella MOTENGO BAUTI
### Melek USTUN
