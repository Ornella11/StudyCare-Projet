<script setup>
import { onMounted, computed, ref, watch } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const store = useCyberStore()
const modeEdition = ref(false)
const formEntreprise = ref({})

onMounted(async () => {
  await store.chargerTout()
})

watch(() => store.entreprise, (nouvellesInfos) => {
  if (nouvellesInfos) {
    formEntreprise.value = { ...nouvellesInfos }
  }
}, { immediate: true })

const sauvegarderEntreprise = async () => {
  await store.modifierEntreprise(formEntreprise.value)
  modeEdition.value = false
}

const classeRisque = computed(() => {
  if (!store.stats.niveauRisque) return 'status-faible'
  const niveau = store.stats.niveauRisque.toLowerCase()
  return niveau === 'élevé' ? 'status-eleve' : `status-${niveau}`
})

const chartData = computed(() => {
  const types = ['Serveur Web', 'Base de données', 'Poste utilisateur', 'Routeur', 'Pare-feu', 'Application métier']
  const counts = types.map(t => store.actifs.filter(a => a.type_actif === t).length)

  return {
    labels: types,
    datasets: [{
      label: "Nombre d'actifs",
      backgroundColor: '#4477ce',
      borderRadius: 6,
      data: counts
    }]
  }
})

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  scales: { y: { beginAtZero: true, grid: { color: '#e9ecef' } } }
}
</script>

<template>
  <div class="container">
    <h1>Dashboard de CyberSécurité 🛡️</h1>

    <div class="card bg-light">
      <div class="header-box">
        <h2>Fiche descriptive de l'Entreprise</h2>
        <button @click="modeEdition = !modeEdition" class="btn-secondary">
          {{ modeEdition ? 'Annuler' : 'Modifier les infos' }}
        </button>
      </div>

      <div v-if="!modeEdition" class="info-grid">
        <p><strong>Nom :</strong> {{ store.entreprise.nom || 'Non défini' }}</p>
        <p><strong>Secteur :</strong> {{ store.entreprise.secteur || 'Non défini' }}</p>
        <p><strong>Employés :</strong> {{ store.entreprise.employes || 0 }}</p>
        <p><strong>Serveurs :</strong> {{ store.entreprise.serveurs || 0 }}</p>
        <p><strong>Postes clients :</strong> {{ store.entreprise.postes_clients || 0 }}</p>
        <p><strong>Services exposés :</strong> {{ store.entreprise.services_exposes || 'Aucun' }}</p>
      </div>

      <form v-else @submit.prevent="sauvegarderEntreprise" class="form-inline">
        <input v-model="formEntreprise.nom" placeholder="Nom" required />
        <input v-model="formEntreprise.secteur" placeholder="Secteur" required />
        <input v-model.number="formEntreprise.employes" type="number" placeholder="Employés" required />
        <input v-model.number="formEntreprise.serveurs" type="number" placeholder="Serveurs" required />
        <input v-model.number="formEntreprise.postes_clients" type="number" placeholder="Postes" required />
        <input v-model="formEntreprise.services_exposes" placeholder="Services exposés" required />
        <button type="submit" class="btn-primary">Enregistrer</button>
      </form>
    </div>

    <div class="kpi-grid">
      <div class="kpi-card">
        <h3>Total Actifs</h3>
        <p class="kpi-value">{{ store.stats.totalActifs || 0 }}</p>
      </div>
      <div class="kpi-card">
        <h3>Total Vulnérabilités</h3>
        <p class="kpi-value color-orange">{{ store.stats.totalVulnerabilites || 0 }}</p>
      </div>
      <div class="kpi-card" :class="classeRisque">
        <h3>Niveau de Risque Cyber</h3>
        <p class="kpi-value uppercase">{{ store.stats.niveauRisque || 'FAIBLE' }}</p>
        <small>Score cumulé : {{ store.stats.scoreRisqueGlobal || 0 }} pts</small>
      </div>
    </div>

    <div class="chart-container">
      <h3>Répartition et cartographie des Actifs</h3>
      <div class="chart-wrapper">
        <Bar :data="chartData" :options="chartOptions" />
      </div>
    </div>

    <div class="card history-container">
  <h3>📜 Historique des Analyses de Risque</h3>
  <table class="history-table">
    <thead>
      <tr>
        <th>Date de l'analyse</th>
        <th>Score global</th>
        <th>Niveau de Risque</th>
        <th>Actifs / Vulns</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="h in store.historique" :key="h.id_historique">
        <td>{{ new Date(h.date_analyse).toLocaleString('fr-FR') }}</td>
        <td><strong>{{ h.score }} / 100</strong></td>
        <td>
          <span class="badge-status" :class="h.niveau.toLowerCase() === 'élevé' ? 'b-eleve' : h.niveau.toLowerCase() === 'moyen' ? 'b-moyen' : 'b-faible'">
            {{ h.niveau }}
          </span>
        </td>
        <td>💻 {{ h.total_actifs }} actifs | ⚠️ {{ h.total_vulnerabilites }} failles</td>
      </tr>
      <tr v-if="store.historique.length === 0">
        <td colspan="4" class="text-center">Aucune analyse enregistrée pour le moment.</td>
      </tr>
    </tbody>
  </table>
</div>
  </div>
</template>

<style scoped>
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: system-ui, sans-serif; color: #212529; }
h1 { font-size: 2rem; font-weight: 800; margin-bottom: 30px; }
h2 { font-size: 1.2rem; margin: 0; }
h3 { font-size: 1.1rem; margin-bottom: 20px; }
.card { background: #ffffff; border: 1px solid #e9ecef; padding: 24px; border-radius: 12px; margin-bottom: 30px; }
.bg-light { background: #f8f9fa; }
.header-box { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 15px; }
.form-inline { display: flex; flex-wrap: wrap; gap: 12px; }
.form-inline input { flex: 1; min-width: 150px; padding: 10px; border: 1px solid #dee2e6; border-radius: 6px; }
.kpi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
.kpi-card { background: #ffffff; border: 1px solid #e9ecef; padding: 20px; border-radius: 12px; text-align: center; }
.kpi-value { font-size: 2rem; font-weight: 800; margin: 10px 0 0 0; color: #4477ce; }
.color-orange { color: #d97736; }
.uppercase { text-transform: uppercase; }

.status-faible { background-color: #e8f5e9; border-color: #c8e6c9; }
.status-faible .kpi-value { color: #2e7d32; }

.status-moyen { background-color: #fff3e0; border-color: #ffe0b2; }
.status-moyen .kpi-value { color: #ef6c00; }

.status-eleve { background-color: #ffebee; border-color: #ffcdd2; }
.status-eleve .kpi-value { color: #c62828; }

.chart-container { background: #ffffff; border: 1px solid #e9ecef; padding: 24px; border-radius: 12px; }
.chart-wrapper { height: 300px; }
.btn-primary { background: #4477ce; color: #fff; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; font-weight: 600; }
.btn-secondary { background: #ffffff; color: #212529; border: 1px solid #dee2e6; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-weight: 600; }
.history-container { margin-top: 30px; background: #fff; }
.history-table { width: 100%; border-collapse: collapse; text-align: left; }
.history-table th { padding: 12px; background: #f8f9fa; border-bottom: 2px solid #dee2e6; font-size: 0.9rem; }
.history-table td { padding: 12px; border-bottom: 1px solid #dee2e6; font-size: 0.95rem; }
.badge-status { padding: 4px 10px; border-radius: 4px; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }
.b-faible { background: #e8f5e9; color: #2e7d32; }
.b-moyen { background: #fff3e0; color: #ef6c00; }
.b-eleve { background: #ffebee; color: #c62828; }
</style>