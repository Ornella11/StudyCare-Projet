<script setup>
import { useNotesStore } from '@/stores/notesStores.js'
import { useAuthStore } from '@/stores/authStores.js'
import { jsPDF } from 'jspdf'
import autoTable from 'jspdf-autotable'

const notesStore = useNotesStore()
const authStore = useAuthStore() 

const telechargerPDF = () => {
  const doc = new jsPDF()

  doc.setFont("helvetica", "bold")
  doc.setFontSize(22)
  doc.setTextColor(40, 56, 123)
  doc.text("STUDYCARE - BULLETIN DE NOTES", 14, 20)
  
  doc.setFont("helvetica", "normal")
  doc.setFontSize(12)
  doc.setTextColor(100, 100, 100)
  doc.text(`Periode : Semestre ${notesStore.semestreActuel}`, 14, 28)
  doc.text(`Date de generation : ${new Date().toLocaleDateString()}`, 14, 34)
  
  doc.setDrawColor(200, 200, 200)
  doc.line(14, 38, 196, 38)

  const colonnesTableau = ["Matiere / Unite d'Enseignement", "Coefficient", "Note / 20"]
  const lignesTableau = []

  notesStore.unitesEnseignementActuelles.forEach(ue => {
    lignesTableau.push([
      ue.nom.toUpperCase(), 
      "-", 
      `${notesStore.calculerMoyenneUE(ue)} / 20 (Moyenne UE)`
    ])
    
    ue.matieres.forEach(matiere => {
      lignesTableau.push([
        `• ${matiere.nom}`, 
        matiere.coef.toString(),
        `${matiere.note} / 20`
      ])
    })
  })

  lignesTableau.push([
    "MOYENNE GENERALE DU SEMESTRE",
    "-",
    `${notesStore.moyenneGenerale} / 20`
  ])

  autoTable(doc, {
    startY: 45,
    head: [colonnesTableau],
    body: lignesTableau,
    theme: 'striped',
    headStyles: { fillColor: [40, 56, 123], textColor: [255, 255, 255], fontStyle: 'bold' },
    didParseCell: function (data) {
      if (data.section === 'body') {
        const estLigneMatiere = data.row.raw[0] && data.row.raw[0].toString().trim().startsWith('•');
        if (!estLigneMatiere || data.row.index === lignesTableau.length - 1) {
          data.cell.styles.fontStyle = 'bold';
          if (data.row.index === lignesTableau.length - 1) {
            data.cell.styles.fillColor = [240, 240, 240];
          }
        }
      }
    }
  })

  doc.save(`Bulletin_Semestre_${notesStore.semestreActuel}_StudyCare.pdf`)
}
</script>

<template>
  <div>
    <div>
      <h1>Notes de l'étudiant</h1>
    </div>

    <div>
      <div>
        <button @click="notesStore.setSemestre(1)" :class="{ active: notesStore.semestreActuel === 1 }">Semestre 1</button>
        <button @click="notesStore.setSemestre(2)" :class="{ active: notesStore.semestreActuel === 2 }">Semestre 2</button>
      </div>
    </div>

    <div>
      <div> 
        <button @click="telechargerPDF">Télécharger mon bulletin</button>
      </div>

      <div>
        <div v-for="ue in notesStore.unitesEnseignementActuelles" :key="ue.id">
          <h2>{{ ue.nom }} - (ECTS - /{{ ue.ects }})</h2>
          <h3>Moyenne UE : {{ notesStore.calculerMoyenneUE(ue) }} / 20</h3>
          <p>Matière | Coef | Note</p>

          <div>
            <li v-for="matiere in ue.matieres" :key="matiere.nom">
              {{ matiere.nom }} | Coef: {{ matiere.coef }} | 
              
              <span v-if="authStore.userRole === 'Étudiant'" class="note-badge">
                {{ matiere.note }} / 20
              </span>

              <input 
                v-else-if="authStore.userRole === 'Enseignant' || authStore.userRole === 'Administrateur'" 
                v-model.number="matiere.note" 
                type="number" 
                min="0" 
                max="20" 
                class="input-note"
              />
            </li>
          </div>
        </div>
      </div>
      
      <h3>Moyenne GENERALE : {{ notesStore.moyenneGenerale }} / 20</h3>
    </div>
  </div>
</template>