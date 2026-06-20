// Garder les données séparées dans un autre fichier 

export const mockUnitesEnseignement = [
  {
    id: 1,
    nom: "UE60APP - Formation professionnelle",
    ects: 10,
    matieres: [
      { nom: "Evaluation entreprise - Livret électronique", coef: 1, note: 18 },
      { nom: "Mission d'apprentissage", coef: 1, note: 15 }
    ]
  },
  {
    id: 2,
    nom: "UUE61LSI - Logiciels et Systèmes d'Information",
    ects: 14,
    matieres: [
      { nom: "Architecture des ordinateurs", coef: 1, note: 12 },
      { nom: "Bases de données", coef: 1, note: 15 },
      { nom: "Optimisation et complexité", coef: 1, note: 9 },
      { nom: "Développement Web", coef: 1, note: 16 }
    ]
  }
]