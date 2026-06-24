import { defineStore } from 'pinia'

export const useNotesStore = defineStore('notes', {
  state: () => ({
    semestreActuel: 1,
    unitesEnseignement: []
  }),

  getters: {
    unitesEnseignementActuelles: (state) =>
      state.unitesEnseignement.filter(ue => ue.semestre === state.semestreActuel),

    moyenneGenerale() {
      let total = 0
      let coefTotal = 0

      this.unitesEnseignementActuelles.forEach(ue => {
        ue.matieres.forEach(m => {
          total += Number(m.note) * Number(m.coef)
          coefTotal += Number(m.coef)
        })
      })

      return coefTotal ? (total / coefTotal).toFixed(2) : '0.00'
    }
  },

  actions: {
    setSemestre(semestre) {
      this.semestreActuel = semestre
    },

    calculerMoyenneUE(ue) {
      let total = 0
      let coefTotal = 0

      ue.matieres.forEach(m => {
        total += Number(m.note) * Number(m.coef)
        coefTotal += Number(m.coef)
      })

      return coefTotal ? (total / coefTotal).toFixed(2) : '0.00'
    },

    async chargerNotes(idEtudiant) {
      console.log('Appel notes pour étudiant :', idEtudiant)

      const response = await fetch(`http://localhost:3000/api/notes/${idEtudiant}`)
      const data = await response.json()

      console.log('Données reçues :', data)

      this.unitesEnseignement = data
    }
  }
})
