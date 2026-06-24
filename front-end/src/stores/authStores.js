import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,          
    userRole: null, 
    isAuthenticated: false
  }),

  actions: {
    // Connexion simulée sans le Back-end)
    login(email, password) {
      this.isAuthenticated = true
      this.user = { email }

      if (email.includes('admin')) {
        this.userRole = 'Administrateur'
      } else if (email.includes('teacher') || email.includes('prof')) {
        this.userRole = 'Enseignant'
      } else {
        this.userRole = 'Étudiant'
      }
      
      return this.userRole
    },
    logout() {
      this.user = null
      this.userRole = null
      this.isAuthenticated = false
    },

    resetPassword(email) {
      console.log(`Demande de réinitialisation envoyée pour : ${email}`)
      return true
    }
  }
})