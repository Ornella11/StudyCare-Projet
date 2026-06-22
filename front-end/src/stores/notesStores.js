import { defineStore } from 'pinia'
import { mockSemestres } from '../mocks/notesMock.js'

export const useNotesStore = defineStore('notes', {
  state: () => ({
    allSemestres: mockSemestres,
    semestreActuel: 1
  }),

  getters: {
    unitesEnseignementActuelles: (state) => {
      return state.allSemestres[state.semestreActuel] || []
    },

    moyenneGenerale: (state) => {
      let totalMoyennesUE = 0
      const ues = state.unitesEnseignementActuelles
      let nombreUE = ues.length

      if (nombreUE === 0) return 0

      ues.forEach(ue => {
        totalMoyennesUE += Number(state.calculerMoyenneUE(ue))
      })

      return (totalMoyennesUE / nombreUE).toFixed(2)
    }
  },

  actions: {
    setSemestre(numeroSemestre) {
      this.semestreActuel = numeroSemestre
    },
    
    calculerMoyenneUE(ue) {
      if (!ue.matieres || ue.matieres.length === 0) return 0
      let totalPoints = 0
      let totalCoefficients = 0
      ue.matieres.forEach(matiere => {
        totalPoints += matiere.note * matiere.coef
        totalCoefficients += matiere.coef
      })
      return (totalPoints / totalCoefficients).toFixed(2)
    }
  }
})