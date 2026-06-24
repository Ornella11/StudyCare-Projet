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
