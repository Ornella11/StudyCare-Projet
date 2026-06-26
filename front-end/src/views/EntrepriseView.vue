<script setup>
import { onMounted, ref, watch } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'

const store = useCyberStore()

const formInfos = ref({
  nom: '',
  secteur: '',
  employes: 0,
  serveurs: 0,
  postes_clients: 0,
  services_exposes: ''
})

onMounted(async () => {
  await store.chargerTout()
})

watch(() => store.entreprise, (nouvellesInfos) => {
  if (nouvellesInfos) {
    formInfos.value = { ...nouvellesInfos }
  }
}, { immediate: true })

const handleModifier = async () => {
  try {
    await store.modifierEntreprise(formInfos.value)
    alert('Informations du périmètre de l\'entreprise mises à jour !')
  } catch (error) {
    console.error(error)
    alert('Erreur lors de la mise à jour.')
  }
}
</script>

<template>
  <div class="container">
    <h1>Périmètre de l'Entreprise 🏢</h1>
    <p class="subtitle">Définissez et ajustez la surface d'attaque globale de l'organisation.</p>

    <div class="stats-grid">
      <div class="stat-card">
        <h3>🏢 Organisation</h3>
        <p class="stat-value">{{ store.entreprise.nom || 'Non défini' }}</p>
        <span class="stat-label">Secteur : {{ store.entreprise.secteur || 'Inconnu' }}</span>
      </div>
      <div class="stat-card">
        <h3>👥 Collaborateurs</h3>
        <p class="stat-value">{{ store.entreprise.employes || 0 }}</p>
        <span class="stat-label">Comptes utilisateurs potentiels</span>
      </div>
      <div class="stat-card">
        <h3>🖥️ Serveurs physiques/cloud</h3>
        <p class="stat-value">{{ store.entreprise.serveurs || 0 }}</p>
        <span class="stat-label">Infrastructures critiques</span>
      </div>
      <div class="stat-card">
        <h3>💻 Postes Clients</h3>
        <p class="stat-value">{{ store.entreprise.postes_clients || 0 }}</p>
        <span class="stat-label">Terminaux utilisateurs</span>
      </div>
    </div>

    <div class="card edit-card">
      <h2>⚙️ Mettre à jour le périmètre SI</h2>
      <form @submit.prevent="handleModifier" class="styled-form">
        <div class="form-grid">
          <div class="input-group">
            <label>Nom de l'entreprise</label>
            <input v-model="formInfos.nom" required />
          </div>

          <div class="input-group">
            <label>Secteur d'activité</label>
            <input v-model="formInfos.secteur" placeholder="ex: Banque, Santé, Industrie..." required />
          </div>

          <div class="input-group">
            <label>Nombre d'employés</label>
            <input type="number" v-model.number="formInfos.employes" min="0" required />
          </div>

          <div class="input-group">
            <label>Nombre de serveurs</label>
            <input type="number" v-model.number="formInfos.serveurs" min="0" required />
          </div>

          <div class="input-group">
            <label>Nombre de postes clients</label>
            <input type="number" v-model.number="formInfos.postes_clients" min="0" required />
          </div>

          <div class="input-group full-width">
            <label>Services critiques exposés sur Internet</label>
            <input v-model="formInfos.services_exposes" placeholder="ex: VPN, O365, Serveur Web Apache..." required />
          </div>
        </div>

        <button type="submit" class="btn-submit">Sauvegarder les modifications</button>
      </form>
    </div>
  </div>
</template>

<style scoped>
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: 'Courier New', Courier, monospace; color: #0a0f0d; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 5px; color: #00ff66; text-shadow: 0 0 5px rgba(0, 255, 102, 0.2); text-transform: uppercase; letter-spacing: 1px; }
.subtitle { color: #22aa55; margin-bottom: 30px; font-size: 0.95rem; text-transform: uppercase; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }

.stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 40px; }
.stat-card { background: #ffffff; border: 1px solid #114422; padding: 20px; border-radius: 2px; box-shadow: 3px 3px 0px rgba(17, 68, 34, 0.1); }
.stat-card h3 { font-size: 0.9rem; color: #114422; margin: 0 0 10px 0; font-weight: 600; text-transform: uppercase; }
.stat-value { font-size: 1.8rem; font-weight: 800; color: #00ff66; margin: 0 0 5px 0; }
.stat-label { font-size: 0.8rem; color: #22aa55; text-transform: uppercase; }

.card { background: #ffffff; border: 2px solid #00ff66; padding: 30px; border-radius: 2px; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.1); }
.edit-card { background: #f5fbf7; border: 2px solid #114422; box-shadow: 4px 4px 0px rgba(17, 68, 34, 0.1); }
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
@media (max-width: 700px) { .form-grid { grid-template-columns: 1fr; } }
.full-width { grid-column: 1 / -1; }

.input-group { display: flex; flex-direction: column; gap: 6px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.input-group input { padding: 12px 14px; border: 1px solid #114422; border-radius: 2px; background: #fff; color: #0a0f0d; font-family: inherit; font-size: 0.95rem; outline: none; }
.input-group input:focus { border-color: #00ff66; box-shadow: 0 0 8px rgba(0, 255, 102, 0.3); }

.btn-submit { background: #00ff66; color: #0a0f0d; border: none; padding: 14px 28px; border-radius: 2px; font-weight: 600; cursor: pointer; transition: all 0.2s; font-size: 0.95rem; text-transform: uppercase; letter-spacing: 1px; }
.btn-submit:hover { background: #33ff77; box-shadow: 0 0 10px rgba(0, 255, 102, 0.4); }
</style>