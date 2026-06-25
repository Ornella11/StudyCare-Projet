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
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: system-ui, sans-serif; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 5px; color: #212529; }
.subtitle { color: #6c757d; margin-bottom: 30px; font-size: 0.95rem; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #495057; }

/* Grille des KPIs */
.stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 40px; }
.stat-card { background: #ffffff; border: 1px solid #e9ecef; padding: 20px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.01); }
.stat-card h3 { font-size: 0.9rem; color: #6c757d; margin: 0 0 10px 0; font-weight: 600; }
.stat-value { font-size: 1.8rem; font-weight: 800; color: #4477ce; margin: 0 0 5px 0; }
.stat-label { font-size: 0.8rem; color: #adb5bd; }

/* Formulaire */
.card { background: #ffffff; border: 1px solid #e9ecef; padding: 30px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.01); }
.edit-card { background: #f8f9fa; }
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
@media (max-width: 700px) { .form-grid { grid-template-columns: 1fr; } }
.full-width { grid-column: 1 / -1; }

.input-group { display: flex; flex-direction: column; gap: 6px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #495057; }
.input-group input { padding: 12px 14px; border: 1px solid #dee2e6; border-radius: 6px; background: #fff; font-size: 0.95rem; outline: none; }
.input-group input:focus { border-color: #4477ce; box-shadow: 0 0 0 3px rgba(68,119,206,0.1); }

.btn-submit { background: #4477ce; color: #fff; border: none; padding: 14px 28px; border-radius: 6px; font-weight: 600; cursor: pointer; transition: background 0.2s; font-size: 0.95rem; }
.btn-submit:hover { background: #2f5bb5; }
</style>