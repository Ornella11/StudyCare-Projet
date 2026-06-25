<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStores.js'

const authStore = useAuthStore()
const router = useRouter()

const deconnexion = () => {
  authStore.deconnecter()
  router.push('/connexion')
}
</script>

<template>
  <nav class="navbar">
    <div class="navbar-brand">
      <router-link to="/">Cyber<span class="blue-text">Shield</span> 🛡️</router-link>
    </div>

    <div class="navbar-links">
      <template v-if="authStore.estConnecte">
        <router-link to="/" class="nav-link">Tableau de bord</router-link>
        <router-link to="/entreprise" class="nav-link">Mon Entreprise</router-link>
        <router-link to="/actifs" class="nav-link">Gestion des Actifs</router-link>
        <router-link to="/vulnerabilites" class="nav-link">Vulnérabilités</router-link>
        <RouterLink to="/rapport" class="nav-link">Rapport</RouterLink>
      </template>
    </div>

    <div class="navbar-actions">
      <router-link v-if="!authStore.estConnecte" to="/connexion" class="btn-auth">
        Sign in
      </router-link>

      <button v-if="authStore.estConnecte" @click="deconnexion" class="btn-auth">
        Déconnexion ({{ authStore.user?.role || 'User' }})
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

.navbar-brand a {
  font-size: 1.4rem;
  font-weight: 800;
  color: #212529;
  text-decoration: none;
}

.blue-text {
  color: #4477ce;
}

.navbar-links {
  display: flex;
  align-items: center;
  gap: 10px;
}

.navbar-links a {
  color: #495057;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.95rem;
  padding: 10px 20px;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.navbar-links a.router-link-exact-active {
  background-color: #4477ce;
  color: #ffffff !important;
}

.navbar-links a:not(.router-link-exact-active):hover {
  color: #4477ce;
  background-color: #f1f3f5;
}

.navbar-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.btn-auth {
  background-color: #212529;
  color: #ffffff;
  border: none;
  padding: 10px 24px;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
  text-decoration: none;
  display: inline-block;
}

.btn-auth:hover {
  background-color: #4477ce;
}
</style>