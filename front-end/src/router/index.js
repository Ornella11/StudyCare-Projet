import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/authStores.js'
import DashboardView from '@/views/DashboardView.vue'
import EntrepriseView from '@/views/EntrepriseView.vue'
import ActifsView from '@/views/ActifView.vue'
import VulnerabilitesView from '@/views/VulnerabilitesView.vue'
import ConnexionView from '@/views/ConnexionView.vue'
import RapportView from '@/views/RapportView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/connexion',
      name: 'connexion',
      component: ConnexionView,
      meta: { requiertAuth: false }
    },
    {
      path: '/',
      name: 'dashboard',
      component: DashboardView,
      meta: { requiertAuth: true }
    },
    {
      path: '/entreprise',
      name: 'entreprise',
      component: EntrepriseView,
      meta: { requiertAuth: true }
    },
    {
      path: '/actifs',
      name: 'actifs',
      component: ActifsView,
      meta: { requiertAuth: true }
    },
    {
      path: '/vulnerabilites',
      name: 'vulnerabilites',
      component: VulnerabilitesView,
      meta: { requiertAuth: true }
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/'
    },
   {
     path: '/rapport',
     name: 'rapport',
     component: RapportView,
     meta: { requiertAuth: true }
   }
  ]
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiertAuth && !authStore.estConnecte) {
    next('/connexion')
  } 
  else if (to.path === '/connexion' && authStore.estConnecte) {
    next('/')
  } 
  else {
    next()
  }
})

export default router