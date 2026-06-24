<script setup>
import { computed, onMounted, ref, watch } from 'vue'
import { useNotesStore } from '@/stores/notesStores.js'
import { useAuthStore } from '@/stores/authStores.js'
import { Bar, Doughnut } from 'vue-chartjs'
import {
  Chart as ChartJS, Title, Tooltip, Legend,
  BarElement, CategoryScale, LinearScale,
  PointElement, LineElement, ArcElement
} from 'chart.js'

ChartJS.register(
  Title, Tooltip, Legend,
  BarElement, CategoryScale, LinearScale,
  PointElement, LineElement, ArcElement
)

const notesStore = useNotesStore()
const authStore = useAuthStore()

const listeEtudiants = ref([])
const idEtudiantSelectionne = ref('tous')
const toutesLesNotesOptionAdmin = ref([])

const estPrivilegie = computed(() => {
  return authStore.userRole === 'Enseignant' || authStore.userRole === 'Administrateur'
})

const chargerDonneesOptionAdmin = async () => {
  try {
    const resNotes = await fetch('http://localhost:3000/api/admin/notes')
    toutesLesNotesOptionAdmin.value = await resNotes.json()
  } catch (e) {
    console.error('Erreur chargement global des notes:', e)
  }
}

onMounted(async () => {
  if (estPrivilegie.value) {
    try {
      const response = await fetch('http://localhost:3000/api/admin/etudiants')
      listeEtudiants.value = await response.json()
      await chargerDonneesOptionAdmin()
    } catch (error) {
      console.error('Erreur initialisation admin:', error)
    }
  } else {
    const idEtudiant = authStore.user?.id_etudiant
    if (idEtudiant) {
      notesStore.chargerNotes(idEtudiant)
    }
  }
})

watch([idEtudiantSelectionne, () => notesStore.semestreActuel], async ([nouvelId]) => {
  if (!estPrivilegie.value) return
  
  if (nouvelId === 'tous') {
    await chargerDonneesOptionAdmin()
  } else {
    notesStore.chargerNotes(nouvelId)
  }
})


const moyenneGeneraleAffichee = computed(() => {
  if (estPrivilegie.value && idEtudiantSelectionne.value === 'tous') {
    if (toutesLesNotesOptionAdmin.value.length === 0) return '0.00'
    const total = toutesLesNotesOptionAdmin.value.reduce((sum, n) => sum + Number(n.note), 0)
    return (total / toutesLesNotesOptionAdmin.value.length).toFixed(2)
  }
  return notesStore.moyenneGenerale
})

const chartData = computed(() => {
  if (estPrivilegie.value && idEtudiantSelectionne.value === 'tous') {
    const moyennesUE = {}
    const comptesUE = {}
    
    toutesLesNotesOptionAdmin.value.forEach(n => {
      const nomUE = n.nom_module || 'Général'
      moyennesUE[nomUE] = (moyennesUE[nomUE] || 0) + Number(n.note)
      comptesUE[nomUE] = (comptesUE[nomUE] || 0) + 1
    })

    const labels = Object.keys(moyennesUE)
    const datasetData = labels.map(label => (moyennesUE[label] / comptesUE[label]).toFixed(2))

    return {
      labels,
      datasets: [{ label: 'Moyenne Promotion par UE', backgroundColor: '#4477ce', borderRadius: 6, data: datasetData }]
    }
  }

  const ues = notesStore.unitesEnseignementActuelles || []
  return {
    labels: ues.map(ue => ue.nom ? ue.nom.split(' - ')[0] : ''),
    datasets: [{ label: 'Moyenne par UE', backgroundColor: '#4477ce', borderRadius: 6, data: ues.map(ue => Number(notesStore.calculerMoyenneUE(ue))) }]
  }
})

const matieresChartData = computed(() => {
  const moyennesMatieres = {}
  const comptesMatieres = {}

  if (estPrivilegie.value && idEtudiantSelectionne.value === 'tous') {
    toutesLesNotesOptionAdmin.value.forEach(n => {
      moyennesMatieres[n.nom_matiere] = (moyennesMatieres[n.nom_matiere] || 0) + Number(n.note)
      comptesMatieres[n.nom_matiere] = (comptesMatieres[n.nom_matiere] || 0) + 1
    })
  } else {
    const ues = notesStore.unitesEnseignementActuelles || []
    ues.forEach(ue => {
      if (ue.matieres) {
        ue.matieres.forEach(m => {
          moyennesMatieres[m.nom] = Number(m.note)
          comptesMatieres[m.nom] = 1
        })
      }
    })
  }

  const labels = Object.keys(moyennesMatieres)
  const dataValues = labels.map(l => (moyennesMatieres[l] / comptesMatieres[l]).toFixed(2))

  return {
    labels,
    datasets: [{ label: 'Note Moyenne', backgroundColor: ['#4477ce', '#d97736', '#212529', '#adb5bd', '#56ccf2', '#27ae60'], data: dataValues }]
  }
})

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  scales: {
    y: { min: 0, max: 20, grid: { color: '#e9ecef' } },
    x: { grid: { display: false } }
  }
}

const ectsValides = computed(() => {
  if (estPrivilegie.value && idEtudiantSelectionne.value === 'tous') return '-'
  const ues = notesStore.unitesEnseignementActuelles || []
  return ues.reduce((total, ue) => {
    const moyenne = Number(notesStore.calculerMoyenneUE(ue))
    return moyenne >= 10 ? total + (ue.ects || 0) : total
  }, 0)
})
</script>

<template>
  <div class="dashboard-container">
    <div class="dashboard-header">
      <h1>Tableau de bord - Semestre {{ notesStore.semestreActuel }}</h1>
      
      <div class="controls-group">
        <div v-if="estPrivilegie" class="select-box">
          <label>Visualiser l'élève :</label>
          <select v-model="idEtudiantSelectionne">
            <option value="tous">Tous les étudiants (Moyenne globale)</option>
            <option v-for="e in listeEtudiants" :key="e.id_etudiant" :value="e.id_etudiant">
              {{ e.prenom }} {{ e.nom }} ({{ e.promotion }})
            </option>
          </select>
        </div>

        <div class="semester-buttons">
          <button :class="{ active: notesStore.semestreActuel === 1 }" @click="notesStore.setSemestre(1)">Semestre 1</button>
          <button :class="{ active: notesStore.semestreActuel === 2 }" @click="notesStore.setSemestre(2)">Semestre 2</button>
        </div>
      </div>
    </div>

    <div class="kpi-grid">
      <div class="kpi-card">
        <h3>{{ idEtudiantSelectionne === 'tous' ? 'Moyenne Générale Promotion' : 'Moyenne Générale' }}</h3>
        <p class="kpi-value">{{ moyenneGeneraleAffichee }} / 20</p>
      </div>

      <div class="kpi-card">
        <h3>Crédits ECTS Validés</h3>
        <p class="kpi-value">{{ ectsValides }}</p>
      </div>
    </div>

    <div class="dashboard-grid">
      <div class="chart-container">
        <h3>{{ idEtudiantSelectionne === 'tous' ? "Comparatif des UE (Moyenne Classe)" : "Comparatif des Unités d'Enseignement" }}</h3>
        <div class="chart-wrapper">
          <Bar :data="chartData" :options="chartOptions" />
        </div>
      </div>

      <div class="chart-container">
        <h3>{{ idEtudiantSelectionne === 'tous' ? "Répartition globale par matière (Moyenne Classe)" : "Répartition des notes par matière" }}</h3>
        <div class="chart-wrapper">
          <Doughnut :data="matieresChartData" :options="{ responsive: true, maintainAspectRatio: false }" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dashboard-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: system-ui, -apple-system, sans-serif;
  color: #212529;
}

.dashboard-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
  margin-bottom: 35px;
  border-bottom: 2px solid #e9ecef;
  padding-bottom: 20px;
}

.dashboard-header h1 {
  font-size: 1.8rem;
  font-weight: 700;
  margin: 0;
}

.controls-group {
  display: flex;
  align-items: center;
  gap: 20px;
  flex-wrap: wrap;
}

.select-box {
  display: flex;
  align-items: center;
  gap: 10px;
}

.select-box label {
  font-size: 0.9rem;
  font-weight: 600;
  color: #495057;
}

.select-box select {
  padding: 10px 16px;
  font-size: 0.95rem;
  border: 1px solid #dee2e6;
  border-radius: 8px;
  outline: none;
  background-color: #ffffff;
  color: #212529;
  cursor: pointer;
}

.select-box select:focus {
  border-color: #4477ce;
}

.semester-buttons {
  display: flex;
  gap: 8px;
}

.semester-buttons button {
  padding: 10px 20px;
  font-size: 0.9rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  background-color: #ffffff;
  color: #d97736;
  border: 1px solid #dee2e6;
  transition: all 0.2s ease;
}

.semester-buttons button:hover {
  background-color: #f8f9fa;
  border-color: #d97736;
}

.semester-buttons button.active {
  background-color: #d97736;
  color: #ffffff;
  border-color: #d97736;
}

.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 25px;
  margin-bottom: 40px;
}

.kpi-card {
  background: #ffffff;
  padding: 25px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  text-align: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.01);
}

.kpi-card h3 {
  font-size: 1rem;
  font-weight: 600;
  color: #6c757d;
  margin: 0 0 10px 0;
}

.kpi-value {
  font-size: 1.8rem;
  font-weight: 800;
  color: #4477ce;
  margin: 0;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(480px, 1fr));
  gap: 30px;
}

.chart-container {
  background: #ffffff;
  padding: 25px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.01);
}

.chart-container h3 {
  font-size: 1.1rem;
  font-weight: 700;
  margin-top: 0;
  margin-bottom: 20px;
  color: #212529;
}

.chart-wrapper {
  height: 320px;
  position: relative;
}

@media (max-width: 576px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
}
</style>