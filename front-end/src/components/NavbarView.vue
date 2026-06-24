<script setup>
import { useAuthStore } from '@/stores/authStores.js'
const authStore = useAuthStore()
</script>

<template>
  <nav class="navbar">
    <router-link to="/">Accueil</router-link>

    <router-link v-if="!authStore.isAuthenticated" to="/connexion">Connexion</router-link>

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

    <router-link v-if="authStore.userRole === 'Administrateur'" to="/admin">Gestion Utilisateurs</router-link>

    <button v-if="authStore.isAuthenticated" @click="authStore.logout()" class="btn-logout">
      Déconnexion ({{ authStore.userRole }})
    </button>
  </nav>
</template>
