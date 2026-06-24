<script setup>
import { ref } from 'vue'
import { useAuthStore } from '@/stores/authStores.js'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()
const email = ref('')
const password = ref('')
const emailReset = ref('')
const mode = ref('login')
const messageSucces = ref('')

const handleLogin = async () => {
  try {
    const response = await fetch('http://localhost:3000/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email: email.value,
        mot_de_passe: password.value
      })
    })

    const data = await response.json()

    if (!response.ok) {
      alert(data.message)
      return
    }

    authStore.setUser(data)

    if (data.role === 'Administrateur') {
      router.push('/admin')
    } else if (data.role === 'Enseignant') {
      router.push('/dashboard')
    } else {
      router.push('/notes')
    }

  } catch (error) {
    console.error(error)
    alert('Impossible de contacter le serveur')
  }
}

const handleResetPassword = () => {
  if (emailReset.value) {
    authStore.resetPassword(emailReset.value)
    messageSucces.value = "Un email de réinitialisation a été envoyé !"
    setTimeout(() => {
      messageSucces.value = ""
      mode.value = 'login'
    }, 3000)
  }
}
</script>

<template>
  <div class="auth-container">
    <div class="auth-card">
      <h2>StudyCare</h2>

      <div v-if="mode === 'login'">
        <h3>Connexion</h3>
        <form @submit.prevent="handleLogin">
          <div class="input-group">
            <label>Adresse E-mail</label>
            <input v-model="email" type="email" placeholder="etudiant@univ.fr, admin@univ.fr..." required />
          </div>

          <div class="input-group">
            <label>Mot de passe</label>
            <input v-model="password" type="password" placeholder="••••••••" required   />
          </div>

          <button type="submit" class="btn-primary">Se connecter</button>
        </form>

        <p class="switch-mode">
          <a href="#" @click.prevent="mode = 'forgot'">Mot de passe oublié ?</a>
        </p>
      </div>

      <div v-else-if="mode === 'forgot'">
        <h3>Réinitialiser le mot de passe</h3>
        <p class="info-text">Saisissez votre e-mail pour recevoir un lien de récupération.</p>

        <div v-if="messageSucces" class="alert-success">{{ messageSucces }}</div>

        <form @submit.prevent="handleResetPassword">
          <div class="input-group">
            <label>Adresse E-mail</label>
            <input v-model="emailReset" type="email" placeholder="votre-email@univ.fr" required />
          </div>

          <button type="submit" class="btn-primary">Envoyer la demande</button>
        </form>

        <p class="switch-mode">
          <a href="#" @click.prevent="mode = 'login'">Retour à la connexion</a>
        </p>
      </div>
    </div>
  </div>
</template>
