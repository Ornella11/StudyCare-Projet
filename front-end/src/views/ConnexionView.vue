<script setup>
import { ref } from 'vue'
import { useAuthStore } from '@/stores/authStores.js'
import { useRouter } from 'vue-router'
import { useCyberStore } from '@/stores/cyberStores.js'

const authStore = useAuthStore()
const router = useRouter()
const cyberStore = useCyberStore()

const email = ref('')
const password = ref('')
const emailReset = ref('')
const mode = ref('login')
const messageSucces = ref('')

const handleLogin = async () => {
  try {
    const response = await fetch('http://localhost:3000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: email.value, password: password.value })
    })

    const data = await response.json()
    if (!response.ok) { alert(data.message); return }

    authStore.token = data.token
    authStore.user = data.user
    localStorage.setItem('user_token', data.token)
    localStorage.setItem('user_info', JSON.stringify(data.user))

    await cyberStore.chargerTout()


    router.push('/')

  } catch (error) {
    console.error(error)
    alert('Impossible de contacter le serveur.')
  }
} 

const handleResetPassword = () => {
  if (emailReset.value) {
    messageSucces.value = "Un e-mail de réinitialisation a été envoyé à votre administrateur !"
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
      <h2>CyberCare 🛡️</h2>

      <div v-if="mode === 'login'">
        <h3>Connexion</h3>
        <form @submit.prevent="handleLogin">
          <div class="input-group">
            <label>Adresse E-mail</label>
            <input v-model="email" type="email" placeholder="responsable@cybershield.fr..." required />
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
        <p class="info-text">Saisissez votre e-mail de sécurité pour recevoir un lien de récupération.</p>

        <div v-if="messageSucces" class="alert-success">{{ messageSucces }}</div>

        <form @submit.prevent="handleResetPassword">
          <div class="input-group">
            <label>Adresse E-mail</label>
            <input v-model="emailReset" type="email" placeholder="votre-email@cybershield.fr" required />
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

<style scoped>
.auth-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: calc(100vh - 80px);
  background-color: #fafafa;
  padding: 20px;
  box-sizing: border-box;
  font-family: system-ui, -apple-system, sans-serif;
}

.auth-card {
  background-color: #ffffff;
  width: 100%;
  max-width: 420px;
  padding: 40px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.02);
  box-sizing: border-box;
}

.auth-card h2 {
  text-align: center;
  font-size: 1.8rem;
  font-weight: 800;
  color: #4477ce;
  margin-top: 0;
  margin-bottom: 25px;
}

.auth-card h3 {
  font-size: 1.3rem;
  font-weight: 700;
  color: #212529;
  margin-top: 0;
  margin-bottom: 20px;
  text-align: center;
}

.info-text {
  font-size: 0.9rem;
  color: #6c757d;
  text-align: center;
  line-height: 1.5;
  margin-bottom: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 20px;
}

.input-group label {
  font-size: 0.85rem;
  font-weight: 600;
  color: #495057;
}

.input-group input {
  padding: 12px 16px;
  font-size: 0.95rem;
  border: 1px solid #dee2e6;
  border-radius: 8px;
  background-color: #ffffff;
  color: #212529;
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.input-group input:focus {
  border-color: #4477ce;
  box-shadow: 0 0 0 3px rgba(68, 119, 206, 0.1);
}

.input-group input::placeholder {
  color: #adb5bd;
}

.btn-primary {
  width: 100%;
  padding: 12px;
  font-size: 0.95rem;
  font-weight: 600;
  color: #ffffff;
  background-color: #4477ce;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s, transform 0.1s;
  margin-top: 5px;
}

.btn-primary:hover {
  background-color: #2f5bb5;
}

.btn-primary:active {
  transform: scale(0.98);
}

.switch-mode {
  text-align: center;
  margin-top: 25px;
  margin-bottom: 0;
  font-size: 0.9rem;
}

.switch-mode a {
  color: #4477ce;
  text-decoration: none;
  font-weight: 500;
  transition: text-decoration 0.2s;
}

.switch-mode a:hover {
  text-decoration: underline;
}

.alert-success {
  background-color: #e6f4ea;
  color: #137333;
  padding: 12px;
  border-radius: 6px;
  font-size: 0.85rem;
  font-weight: 500;
  text-align: center;
  margin-bottom: 20px;
  border: 1px solid #ceead6;
}
</style>