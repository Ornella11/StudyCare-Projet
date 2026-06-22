<script setup>
import { computed } from 'vue'
import { useNotesStore } from '@/stores/notesStores.js'
import { Bar, Line, Doughnut } from 'vue-chartjs'
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

// extrait les labels et les données
const chartData = computed(() => {
  const ues = notesStore.unitesEnseignementActuelles
  
  return {
    labels: ues.map(ue => ue.nom.split(' - ')[0]),
    datasets: [
      {
        label: 'Moyenne par UE',
        backgroundColor: '#28387b',
        data: ues.map(ue => Number(notesStore.calculerMoyenneUE(ue)))
      }
    ]
  }
})

const matieresChartData = computed(() => {
  const ues = notesStore.unitesEnseignementActuelles
  const toutesLesMatieres = []

  ues.forEach(ue => {
    ue.matieres.forEach(m => {
      toutesLesMatieres.push(m)
    })
  })

  return {
    labels: toutesLesMatieres.map(m => m.nom),
    datasets: [
      {
        label: 'Note',
        backgroundColor: ['#28387b', '#4a69bd', '#10ac84', '#ffb8b8', '#ee5253', '#00d2d3'],
        data: toutesLesMatieres.map(m => m.note)
      }
    ]
  }
})

const historiqueChartData = computed(() => {
  const numerosSemestres = Object.keys(notesStore.allSemestres)

  const moyennesParSemestre = numerosSemestres.map(num => {
    const ues = notesStore.allSemestres[num] || []
    if (ues.length === 0) return 0
    
    let totalMoyennesUE = 0
    ues.forEach(ue => {
      totalMoyennesUE += Number(notesStore.calculerMoyenneUE(ue))
    })
    return (totalMoyennesUE / ues.length).toFixed(2)
  })

  return {
    labels: numerosSemestres.map(num => `Semestre ${num}`),
    datasets: [
      {
        label: 'Moyenne Générale',
        borderColor: '#ee5253', 
        backgroundColor: 'rgba(238, 82, 83, 0.1)',
        data: moyennesParSemestre,
        tension: 0.2 
      }
    ]
  }
})

// Options de configuration du graphique
const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  scales: {
    y: {
      min: 0,
      max: 20 
    }
  }
}

const ectsValides = computed(() => {
  return notesStore.unitesEnseignementActuelles.reduce((total, ue) => {
    const moyenne = Number(notesStore.calculerMoyenneUE(ue))
    return moyenne >= 10 ? total + ue.ects : total
  }, 0)
})
</script>

<template>
  <div class="dashboard-container">
    <h1>Tableau de bord - Semestre {{ notesStore.semestreActuel }}</h1>

    <div class="kpi-grid">
      <div class="kpi-card">
        <h3>Moyenne Générale</h3>
        <p class="kpi-value">{{ notesStore.moyenneGenerale }} / 20</p>
      </div>
      
      <div class="kpi-card">
        <h3>Crédits ECTS Validés</h3>
        <p class="kpi-value">{{ ectsValides }} ECTS</p>
      </div>
    </div>

    <div class="chart-container">
      <h3>Comparatif des Unités d'Enseignement</h3>
      <div class="chart-wrapper">
        <Bar :data="chartData" :options="chartOptions" />
      </div>
    </div>
  </div>
  <div class="dashboard-grid">
      
      <div class="chart-container">
        <h3>Répartition des notes par matière</h3>
        <div class="chart-wrapper">
          <Doughnut :data="matieresChartData" :options="{ responsive: true, maintainAspectRatio: false }" />
        </div>
      </div>

      <div class="chart-container">
        <h3>Évolution sur tous les Semestres</h3>
        <div class="chart-wrapper">
          <Line :data="historiqueChartData" :options="chartOptions" />
        </div>
      </div>

    </div>
</template>

<style scoped>
.dashboard-container {
  padding: 20px;
}
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}
.kpi-card {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  text-align: center;
}
.kpi-value {
  font-size: 24px;
  font-weight: bold;
  color: #28387b;
}
.chart-container {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.chart-wrapper {
  height: 300px; 
}
.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
  gap: 20px;
  margin-top: 20px;
}
</style>