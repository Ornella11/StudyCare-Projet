<script setup>
import Navbar from './components/NavbarView.vue'
import { useAuthStore } from '@/stores/authStores.js'


const authStore = useAuthStore()
const router = useRouter()
import { useRouter } from 'vue-router'

const handleLogout = () => {
  authStore.logout()
  router.push('/')
}
</script>

<template>
  <div>
    <Navbar />

    <button v-if="authStore.isAuthenticated" @click="handleLogout()">Déconnexion</button>
    <router-link v-if="authStore.userRole === 'Administrateur'" to="/admin">Espace Admin</router-link>

    <main>
      <RouterView />
    </main>
  </div>
</template>
