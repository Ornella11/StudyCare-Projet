import { createRouter, createWebHistory } from 'vue-router'
import Accueil from '../views/AccueilView.vue'
import Connexion from '../views/ConnexionView.vue'
import Dashboard from '../views/DashboardView.vue'
import Notes from '../views/NotesView.vue'

const routes = [
    { path: '/', component: Accueil },
    { path: '/connexion', component: Connexion },
    {
        path: '/dashboard', component: Dashboard,
    },
    {
        path: '/notes', component: Notes,
    }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router