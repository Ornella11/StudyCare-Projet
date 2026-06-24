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
.home-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: system-ui, -apple-system, sans-serif;
  background-color: #ffffff;
}

.hero-section {
  text-align: center;
  padding: 60px 20px;
  background-color: #f8f9fa; 
  border-radius: 12px;
  margin-bottom: 20px;
}

h1 {
  font-size: 2.6rem;
  font-weight: 800;
  margin-bottom: 15px;
  color: #212529;
}

.brand-text {
  color: #d97736; 
  font-style: italic;
}

.hero-subtitle {
  font-size: 1.15rem;
  color: #495057;
  max-width: 650px;
  margin: 0 auto 30px auto;
  line-height: 1.6;
}

.btn-cta {
  padding: 12px 32px;
  font-size: 1rem;
  font-weight: 600;
  color: white;
  background-color: #d97736; 
  border: none;
  border-radius: 10px;
  cursor: pointer;
  transition: background-color 0.2s, transform 0.1s;
}

.btn-cta:hover {
  background-color: #c2652b;
}

.btn-cta:active {
  transform: scale(0.98);
}

.welcome-box {
  background: white;
  padding: 20px 30px;
  border-radius: 12px;
  display: inline-block;
  border: 1px solid #e9ecef;
}

.welcome-box strong {
  color: #4477ce; 
}

.role-badge {
  display: inline-block;
  margin-top: 8px;
  padding: 5px 16px;
  background-color: #f1f3f5;
  color: #d97736;
  font-weight: 600;
  border-radius: 20px;
  font-size: 0.85rem;
}

.separator {
  border: 0;
  height: 1px;
  background-color: #e9ecef;
  margin: 50px 0;
}

.features-section h2, 
.roles-section h2 {
  text-align: center;
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 40px;
  color: #212529;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
}

.feature-card {
  background: #ffffff;
  padding: 30px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  text-align: center;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.feature-card:hover {
  border-color: #4477ce; 
  box-shadow: 0 4px 12px rgba(68, 119, 206, 0.05);
}

.icon {
  font-size: 2.2rem;
  margin-bottom: 15px;
}

.feature-card h3 {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 12px;
  color: #212529;
}

.feature-card p {
  color: #6c757d;
  font-size: 0.95rem;
  line-height: 1.6;
  margin-bottom: 20px;
}

.card-link {
  color: #4477ce; 
  text-decoration: none;
  font-weight: 600;
  font-size: 0.95rem;
}

.card-link:hover {
  text-decoration: underline;
}

.roles-tabs {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.role-tab-card {
  background-color: #ffffff;
  padding: 24px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  border-top: 4px solid #dee2e6;
  transition: all 0.2s ease;
}

.role-tab-card h4 {
  margin-top: 0;
  margin-bottom: 10px;
  font-size: 1.1rem;
  font-weight: 600;
  color: #212529;
}

.role-tab-card p {
  font-size: 0.9rem;
  color: #6c757d;
  line-height: 1.5;
}

.role-tab-card.highlight {
  border-top-color: #4477ce;
  background-color: #f8fafc;
  border-left: 1px solid #e9ecef;
  border-right: 1px solid #e9ecef;
  border-bottom: 1px solid #e9ecef;
}

.card-link-admin {
  display: inline-block;
  margin-top: 15px;
  color: #d97736;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
}

.card-link-admin:hover {
  text-decoration: underline;
}
</style>