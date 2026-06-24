import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/authStores.js'
import AccueilView from '@/views/AccueilView.vue'
import ConnexionView from '@/views/ConnexionView.vue'
import NotesView from '@/views/NotesView.vue'
import DashboardView from '@/views/DashboardView.vue'
import AdminView from '@/views/AdminView.vue'

const routes = [
  { path: '/', component: AccueilView },
  { path: '/connexion', component: ConnexionView },
  
  { 
    path: '/notes', 
    component: NotesView, 
    meta: { requiresAuth: true, rolesAutorises: ['Étudiant', 'Enseignant', 'Administrateur'] } 
  },
  { 
    path: '/dashboard', 
    component: DashboardView, 
    meta: { requiresAuth: true, rolesAutorises: ['Étudiant', 'Enseignant', 'Administrateur'] } 
  },
  
  { 
    path: '/admin', 
    component: AdminView, 
    meta: { requiresAuth: true, rolesAutorises: ['Administrateur'] } 
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    alert("Vous devez vous connecter pour accéder à cette page.")
    return next('/connexion')
  }

  if (to.meta.rolesAutorises && !to.meta.rolesAutorises.includes(authStore.userRole)) {
    alert("Accès refusé : Vous n'avez pas les droits nécessaires.")
    return next('/') 
  }
  next()
})

export default router