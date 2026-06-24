<script setup>
import { onMounted } from 'vue'
import { useNotesStore } from '@/stores/notesStores.js'
import { useAuthStore } from '@/stores/authStores.js'
import { jsPDF } from 'jspdf'
import autoTable from 'jspdf-autotable'

const notesStore = useNotesStore()
const authStore = useAuthStore()


onMounted(() => {
  notesStore.chargerNotes(authStore.user.id_etudiant)
})

const telechargerPDF = () => {
  const doc = new jsPDF()

  doc.setFont('helvetica', 'bold')
  doc.setFontSize(22)
  doc.text('STUDYCARE - BULLETIN DE NOTES', 14, 20)

  doc.setFont('helvetica', 'normal')
  doc.setFontSize(12)
  doc.text(`Période : Semestre ${notesStore.semestreActuel}`, 14, 28)
  doc.text(`Date : ${new Date().toLocaleDateString()}`, 14, 34)

  const lignesTableau = []

  notesStore.unitesEnseignementActuelles.forEach(ue => {
    lignesTableau.push([
      ue.nom.toUpperCase(),
      '-',
      `${notesStore.calculerMoyenneUE(ue)} / 20`
    ])

    ue.matieres.forEach(matiere => {
      lignesTableau.push([
        `• ${matiere.nom}`,
        matiere.coef,
        `${matiere.note} / 20`
      ])
    })
  })

  lignesTableau.push([
    'MOYENNE GÉNÉRALE',
    '-',
    `${notesStore.moyenneGenerale} / 20`
  ])

  autoTable(doc, {
    startY: 45,
    head: [['Matière / UE', 'Coefficient', 'Note']],
    body: lignesTableau
  })

  doc.save(`Bulletin_Semestre_${notesStore.semestreActuel}.pdf`)
}
</script>

<template>
  <div>
    <h1>Notes de l'étudiant</h1>

    <button @click="notesStore.setSemestre(1)">
      Semestre 1
    </button>

    <button @click="notesStore.setSemestre(2)">
      Semestre 2
    </button>

    <button @click="telechargerPDF">
      Télécharger mon bulletin
    </button>

    <div v-for="ue in notesStore.unitesEnseignementActuelles" :key="ue.id">
      <h2>{{ ue.nom }} - ECTS : {{ ue.ects }}</h2>
      <h3>Moyenne UE : {{ notesStore.calculerMoyenneUE(ue) }} / 20</h3>

      <ul>
        <li v-for="matiere in ue.matieres" :key="matiere.id">
          {{ matiere.nom }} |
          Coef : {{ matiere.coef }} |

          <span v-if="authStore.userRole === 'Étudiant'">
            {{ matiere.note }} / 20
          </span>

          <input
            v-else
            v-model.number="matiere.note"
            type="number"
            min="0"
            max="20"
          />
        </li>
      </ul>
    </div>

    <h3>Moyenne générale : {{ notesStore.moyenneGenerale }} / 20</h3>
  </div>
</template>

<style scoped>
div {
  max-width: 1000px;
  margin: 0 auto;
  padding: 30px 20px;
  font-family: system-ui, -apple-system, sans-serif;
  color: #212529;
}

h1 {
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 30px;
  color: #212529;
}

button:not(:last-of-type) {
  padding: 10px 24px;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  margin-right: 12px;
  margin-bottom: 30px;
  transition: all 0.2s ease;
  background-color: #ffffff;
  color: #d97736;
  border: 1px solid #dee2e6;
}

button:not(:last-of-type):hover {
  background-color: #f8f9fa;
  border-color: #d97736;
}

button:nth-of-type(1) {
  background-color: #d97736;
  color: #ffffff;
  border-color: #d97736;
}

button:last-of-type {
  padding: 10px 24px;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  background-color: #4477ce;
  color: #ffffff;
  border: none;
  float: right;
  transition: background-color 0.2s;
}

button:last-of-type:hover {
  background-color: #335ca3;
}

div[key] {
  background: #ffffff;
  border: 1px dashed #4477ce;
  border-radius: 12px;
  padding: 0;
  margin-bottom: 30px;
  box-shadow: 0 4px 12px rgba(68, 119, 206, 0.02);
  overflow: hidden;
  clear: both;
}

h2 {
  font-size: 1.1rem;
  font-weight: 700;
  font-style: italic;
  color: #4477ce;
  padding: 20px 24px;
  margin: 0;
  border-bottom: 1px solid #e9ecef;
}
h3:not(:last-of-type) {
  display: none; 
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 24px;
  font-size: 0.95rem;
  border-bottom: 1px solid #f1f3f5;
  color: #212529;
}

li:last-child {
  border-bottom: none;
}

li:nth-child(even) {
  background-color: #f8f9fa;
}

li::text {
  font-weight: 600;
}

span, input {
  font-weight: 700;
  color: #212529;
}

input[type="number"] {
  width: 70px;
  padding: 6px 10px;
  font-size: 0.95rem;
  font-weight: 600;
  border: 1px solid #dee2e6;
  border-radius: 6px;
  text-align: center;
  outline: none;
}

input[type="number"]:focus {
  border-color: #4477ce;
}

h3:last-of-type {
  font-size: 1.2rem;
  font-weight: 700;
  color: #212529;
  text-align: right;
  margin-top: 40px;
  padding-top: 20px;
  border-top: 1px solid #e9ecef;
}
</style>