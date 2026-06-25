<script setup>
import { onMounted, computed, ref } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const store = useCyberStore()
const modeEdition = ref(false)
const formEntreprise = ref({})

onMounted(async () => {
  await store.chargerTout()
  formEntreprise.value = { ...store.entreprise }
})

const sauvegarderEntreprise = async () => {
  await store.modifierEntreprise(formEntreprise.value)
  modeEdition.value = false
}

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
<p><strong>Nom :</strong> {{ store.entreprise.nom }}</p>
<p><strong>Secteur :</strong> {{ store.entreprise.secteur }}</p>
<p><strong>Employés :</strong> {{ store.entreprise.employes }}</p>
<p><strong>Serveurs :</strong> {{ store.entreprise.serveurs }}</p>
<p><strong>Postes clients :</strong> {{ store.entreprise.postes_clients }}</p>
<p><strong>Services exposés :</strong> {{ store.entreprise.services_exposes }}</p>
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
<p class="kpi-value">{{ store.stats.totalActifs }}</p>
</div>
<div class="kpi-card">
<h3>Total Vulnérabilités</h3>
<p class="kpi-value color-orange">{{ store.stats.totalVulnerabilites }}</p>
</div>
<div class="kpi-card" :class="'status-' + store.stats.niveauRisque.toLowerCase()">
<h3>Niveau de Risque Cyber</h3>
<p class="kpi-value uppercase">{{ store.stats.niveauRisque }}</p>
<small>Score cumulé : {{ store.stats.scoreRisqueGlobal }} pts</small>
</div>
</div>

    <div class="chart-container">
<h3>Répartition et cartographie des Actifs</h3>
<div class="chart-wrapper">
<Bar :data="chartData" :options="chartOptions" />
</div>
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
.status-faible { background-color: #e3f2fd; border-color: #bbdefb; }
.status-faible .kpi-value { color: #1e88e5; }
.status-moyen { background-color: #fff3e0; border-color: #ffe0b2; }
.status-moyen .kpi-value { color: #f4511e; }
.status-élevé { background-color: #ffebee; border-color: #ffcdd2; }
.status-élevé .kpi-value { color: #e53935; }
.chart-container { background: #ffffff; border: 1px solid #e9ecef; padding: 24px; border-radius: 12px; }
.chart-wrapper { height: 300px; }
.btn-primary { background: #4477ce; color: #fff; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; font-weight: 600; }
.btn-secondary { background: #ffffff; color: #212529; border: 1px solid #dee2e6; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-weight: 600; }
</style>
