<script setup>
import { useAuthStore } from '@/stores/authStores.js'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

const naviguerVersConnexion = () => {
  router.push('/connexion')
}
</script>

<template>
  <div class="home-container">
    <header class="hero-section">
      <h1>Bienvenue sur <span class="brand-text">StudyCare</span></h1>
      <p class="hero-subtitle">
        La plateforme moderne de suivi de scolarité, de gestion des notes et d'analyse de performances académiques.
      </p>
      
      <div class="hero-actions">
        <button v-if="!authStore.isAuthenticated" @click="naviguerVersConnexion" class="btn-cta">
          Accéder à mon espace
        </button>
        <div v-else class="welcome-box">
          <p>Ravi de vous revoir, <strong>{{ authStore.user?.email }}</strong> !</p>
          <p class="role-badge">Espace {{ authStore.userRole }}</p>
        </div>
      </div>
    </header>

    <hr class="separator" />

    <section class="features-section">
      <h2>Nos Fonctionnalités Clés</h2>
      
      <div class="features-grid">
        <div class="feature-card">
          <div class="icon">📊</div>
          <h3>Visualisation des Résultats</h3>
          <p>Consultez vos notes par semestre et suivez vos moyennes d'Unités d'Enseignement (UE) calculées en temps réel.</p>
          <router-link v-if="authStore.isAuthenticated" to="/notes" class="card-link">Voir mes notes →</router-link>
        </div>

        <div class="feature-card">
          <div class="icon">📈</div>
          <h3>Analyses & Statistiques</h3>
          <p>Un tableau de bord complet avec des graphiques interactifs pour analyser vos forces, vos faiblesses et vos crédits ECTS.</p>
          <router-link v-if="authStore.isAuthenticated" to="/dashboard" class="card-link">Ouvrir le dashboard →</router-link>
        </div>

        <div class="feature-card">
          <div class="icon">📄</div>
          <h3>Bulletins PDF</h3>
          <p>Générez et téléchargez un bulletin de notes officiel et propre au format PDF en un seul clic à la fin de chaque semestre.</p>
        </div>
      </div>
    </section>

    <section class="roles-section">
      <h2>Espaces & Droits d'Accès</h2>
      <div class="roles-tabs">
        <div class="role-tab-card" :class="{ highlight: authStore.userRole === 'Étudiant' }">
          <h4>Espace Étudiant</h4>
          <p>Consultation des notes, suivi du tableau de bord et téléchargement du bulletin de notes.</p>
        </div>
        <div class="role-tab-card" :class="{ highlight: authStore.userRole === 'Enseignant' }">
          <h4>Espace Enseignant</h4>
          <p>Gestion et modification des notes des étudiants par matière, et suivi des statistiques globales.</p>
        </div>
        <div class="role-tab-card" :class="{ highlight: authStore.userRole === 'Administrateur' }">
          <h4>Espace Admin</h4>
          <p>Contrôle total : Gestion des comptes utilisateurs (création, suppression) et modification des notes.</p>
          <router-link v-if="authStore.userRole === 'Administrateur'" to="/admin" class="card-link-admin">Gérer les comptes →</router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
/* Css temporaire */
.home-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: #333;
}

.hero-section {
  text-align: center;
  padding: 60px 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 16px;
  margin-bottom: 40px;
}
h1 {
  font-size: 2.8rem;
  margin-bottom: 15px;
  color: #1e272e;
}
.brand-text {
  color: #28387b;
  font-weight: bold;
}
.hero-subtitle {
  font-size: 1.2rem;
  color: #57606f;
  max-width: 700px;
  margin: 0 auto 30px auto;
  line-height: 1.6;
}
.btn-cta {
  padding: 14px 30px;
  font-size: 1.1rem;
  font-weight: bold;
  color: white;
  background-color: #28387b;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s, background-color 0.2s;
}
.btn-cta:hover {
  background-color: #1b2654;
  transform: translateY(-2px);
}
.welcome-box {
  background: white;
  padding: 15px 25px;
  border-radius: 8px;
  display: inline-block;
  box-shadow: 0 4px 6px rgba(0,0,0,0.05);
}
.role-badge {
  display: inline-block;
  margin-top: 5px;
  padding: 4px 12px;
  background-color: #e3ece9;
  color: #10ac84;
  font-weight: bold;
  border-radius: 20px;
  font-size: 0.9rem;
}

.separator {
  border: 0;
  height: 1px;
  background: #dcdde1;
  margin: 40px 0;
}

/* Features Section */
.features-section h2, .roles-section h2 {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 40px;
  color: #2f3542;
}
.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}
.feature-card {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.05);
  border: 1px solid #f1f2f6;
  text-align: center;
  transition: translateY 0.2s;
}
.feature-card:hover {
  transform: translateY(-5px);
}
.icon {
  font-size: 2.5rem;
  margin-bottom: 15px;
}
.feature-card h3 {
  margin-bottom: 12px;
  color: #28387b;
}
.feature-card p {
  color: #747d8c;
  font-size: 0.95rem;
  line-height: 1.5;
  margin-bottom: 15px;
}
.card-link {
  color: #4a69bd;
  text-decoration: none;
  font-weight: bold;
}

/* Roles Section */
.roles-tabs {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
}
.role-tab-card {
  background-color: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  border-left: 4px solid #ced6e0;
}
.role-tab-card h4 {
  margin-top: 0;
  margin-bottom: 10px;
  font-size: 1.1rem;
  color: #2f3542;
}
.role-tab-card p {
  font-size: 0.9rem;
  color: #57606f;
  line-height: 1.4;
}
/* Si le rôle correspond à l'utilisateur connecté, on l'illumine en bleu */
.role-tab-card.highlight {
  border-left-color: #28387b;
  background-color: #edf2fa;
}
.card-link-admin {
  display: inline-block;
  margin-top: 10px;
  color: #ee5253;
  text-decoration: none;
  font-weight: bold;
  font-size: 0.9rem;
}
</style>