<script setup>
import { useAuthStore } from '@/stores/authStores.js'
const authStore = useAuthStore()
</script>

<template>
  <nav class="navbar">
    <div class="navbar-brand">
      <router-link to="/">Student<span class="orange-text">Care</span></router-link>
    </div>

    <div class="navbar-links">
      <router-link to="/" class="nav-link">Accueil</router-link>

      <template v-if="authStore.isAuthenticated">
        <router-link to="/notes" class="nav-link">Mes notes</router-link>
        <router-link to="/dashboard" class="nav-link">Mes statistiques</router-link>
      </template>
    <template v-if="authStore.isAuthenticated">
      <router-link
        v-if="authStore.userRole === 'Étudiant'"
        to="/notes"
      >
        Mes Notes
      </router-link>

      <router-link
        v-else-if="authStore.userRole === 'Enseignant'"
        to="/enseignant"
      >
        Gérer les notes
      </router-link>

      <router-link
        v-else-if="authStore.userRole === 'Administrateur'"
        to="/admin"
      >
        Administration
      </router-link>
    <router-link to="/dashboard">Dashboard</router-link>
    </template>

      <router-link v-if="authStore.userRole === 'Administrateur'" to="/admin" class="nav-link nav-admin">
        Gestion Utilisateurs
      </router-link>
    </div>

    <div class="navbar-actions">
      <router-link v-if="!authStore.isAuthenticated" to="/connexion" class="btn-auth">
        Sign in
      </router-link>

      <button v-if="authStore.isAuthenticated" @click="authStore.logout()" class="btn-auth">
        Déconnexion ({{ authStore.userRole }})
      </button>
    </div>
  </nav>
</template>

<style scoped>
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #ffffff;
  padding: 10px 40px;
  height: 80px;
  border-bottom: 1px solid #e9ecef;
  box-sizing: border-box;
  font-family: system-ui, -apple-system, sans-serif;
}

.navbar-brand {
  display: flex;
  align-items: center;
  gap: 10px;
}
.navbar-brand img {
  height: 45px;
  width: auto;
}
.navbar-brand a {
  font-size: 1.3rem;
  font-weight: 700;
  color: #d97736;
  text-decoration: none;
  font-style: italic;
}

.navbar-links {
  display: flex;
  align-items: center;
  gap: 25px;
}

.nav-link {
  color: #495057;
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding: 8px 20px;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.router-link-active.nav-link {
  background-color: #4477ce;
  color: #ffffff !important;
}

.nav-link:not(.router-link-active):hover {
  color: #4477ce;
  background-color: #f1f3f5;
}


.navbar-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.btn-auth {
  background-color: #d97736;
  color: #ffffff;
  border: none;
  padding: 10px 24px;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 10px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-auth:hover {
  background-color: #c2652b;
}

/* Icône de profil si connecté (Optionnel - Style SVG) */
.profile-icon {
  width: 32px;
  height: 32px;
  color: #212529;
}
</style>
