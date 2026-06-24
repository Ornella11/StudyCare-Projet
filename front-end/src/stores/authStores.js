import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')) || null
  }),

  getters: {
    isAuthenticated: (state) => !!state.user,
    userRole: (state) => state.user?.role || null
  },

  actions: {
    setUser(user) {
      this.user = user
      localStorage.setItem('user', JSON.stringify(user))
    },

    logout() {
      this.user = null
      this.userRole = null
      this.isAuthenticated =""
    },

    resetPassword(email) {
      console.log(`Demande de réinitialisation envoyée pour : ${email}`)
      return true
    }
  }
})
