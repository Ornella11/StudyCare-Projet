<script setup>
import Navbar from './components/NavbarView.vue'
import { useAuthStore } from '@/stores/authStores.js' 

const authStore = useAuthStore()
</script>

<template>
  <div>
    <Navbar />

    <button v-if="authStore.isAuthenticated" @click="authStore.logout()">Déconnexion</button>
    <router-link v-if="authStore.userRole === 'Administrateur'" to="/admin">Espace Admin</router-link>
    
    <main>
      <RouterView />
    </main>
  </div>
</template>