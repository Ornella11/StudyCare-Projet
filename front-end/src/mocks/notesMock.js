// Garder les données séparées dans un autre fichier 

export const mockSemestres = {
  1: [ // semestre 1
    {
    id: 1,
    nom: "UE50APP - Formation professionnelle",
    ects: 10,
    matieres: [
      { nom: "Evaluation entreprise - Livret électronique", coef: 1, note: 18 },
      { nom: "Mission d'apprentissage", coef: 1, note: 15 }
    ]
  },
  {
    id: 2,
    nom: "UUE51LSI - Logiciels et Systèmes d'Information",
    ects: 14,
    matieres: [
      { nom: "Architecture des ordinateurs", coef: 1, note: 12 },
      { nom: "Bases de données", coef: 1, note: 15 },
      { nom: "Optimisation et complexité", coef: 1, note: 9 },
      { nom: "Développement Web", coef: 1, note: 16 }
    ]
  }
  ],
  2: [  // semestre 2
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
      { nom: "Algorithmes et théorie des graphes", coef: 1, note: 13.9 },
      { nom: "Introduction aux systèmes d'information", coef: 1, note: 20 },
      { nom: "Programmation en C et C++", coef: 1, note: 8 },
      { nom: "Programmation en Java", coef: 1, note: 12.6 }
    ]
  }
  ],
}