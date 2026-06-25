import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/authStores'
import DashboardView from '@/views/DashboardView.vue'
import ConnexionView from '@/views/ConnexionView.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/login', component: ConnexionView, meta: { requiertAuth: false } },
    { path: '/', component: DashboardView, meta: { requiertAuth: true } },
  ]
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiertAuth && !authStore.estConnecte) {
    next('/login')
  } else if (to.path === '/login' && authStore.estConnecte) {
    next('/')
  } else {
    next()
  }
})

export default router
