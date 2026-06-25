import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('user_token') || null)
  const user = ref(JSON.parse(localStorage.getItem('user_info')) || null)

  const estConnecte = computed(() => !!token.value)

  const connecter = async (email, password) => {
    const res = await fetch('http://localhost:3000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password })
    })
    const data = await res.json()
    if (!res.ok) throw new Error(data.message || 'Identifiants incorrects')

    token.value = data.token
    user.value = data.user

    localStorage.setItem('user_token', data.token)
    localStorage.setItem('user_info', JSON.stringify(data.user))
  }

  const deconnecter = () => {
    token.value = null
    user.value = null
    localStorage.removeItem('user_token')
    localStorage.removeItem('user_info')
  }

  return { token, user, estConnecte, connecter, deconnecter }
})
