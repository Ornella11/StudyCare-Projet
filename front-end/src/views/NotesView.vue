<script setup>
import { ref, computed } from 'vue'
import { mockUnitesEnseignement } from '../mocks/notesMock.js'

const unitesEnseignement = ref(mockUnitesEnseignement)
// Calculer la moyenne
const calculerMoyenneUE = (ue) => {
  if (!ue.matieres || ue.matieres.length === 0) return 0
  
  let totalPoints = 0
  let totalCoefficients = 0

  ue.matieres.forEach(matiere => {
    totalPoints += matiere.note * matiere.coef
    totalCoefficients += matiere.coef
  })

  const moyenne = totalPoints / totalCoefficients
  return moyenne.toFixed(2)
}
const moyenneGenerale = computed(() => {
  let totalMoyennesUE = 0
  let nombreUE = unitesEnseignement.value.length

  if (nombreUE === 0) return 0

  unitesEnseignement.value.forEach(ue => {
    totalMoyennesUE += Number(calculerMoyenneUE(ue))
  })

  return (totalMoyennesUE / nombreUE).toFixed(2)
})
</script>

<template>
  <div>
    <div>
      <h1>Notes de l'étudiant</h1>
    </div>

    <div>
      <div>Semestre 1</div>
      <div>Semestre 2</div>
    </div>

    <div>
      <div> 
        <button>Télécharger mon bulletin</button> 
      </div>

      <div>
        <div v-for="ue in unitesEnseignement" :key="ue.id">
          <h2>{{ ue.nom }} - (ECTS - /{{ ue.ects }})</h2>
          <h3>Moyenne UE : {{ calculerMoyenneUE(ue) }} / 20</h3>
          <p>Matière | Coef | Note</p>

          <div>
            <li v-for="matiere in ue.matieres" :key="matiere.nom">
              {{ matiere.nom }} | {{ matiere.coef }} | {{ matiere.note }}
            </li>
          </div>
        </div>
      </div>
      
      <h3>Moyenne GENERALE : {{ moyenneGenerale }} / 20</h3>
    </div>
  </div>
</template>