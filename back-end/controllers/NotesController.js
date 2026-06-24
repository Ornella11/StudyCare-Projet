const db = require('../config/database')

exports.getNotesByEtudiant = async (req, res) => {
  const { idEtudiant } = req.params

  try {
    const [rows] = await db.query(`
      SELECT
        mo.id_module,
        mo.nom_module,
        mo.semestre,
        ma.id_matiere,
        ma.nom_matiere,
        ma.coefficient,
        n.id_note,
        n.note,
        n.type_evaluation,
        n.date_evaluation
      FROM notes n
      JOIN matieres ma ON n.id_matiere = ma.id_matiere
      JOIN modules mo ON ma.id_module = mo.id_module
      WHERE n.id_etudiant = ?
      ORDER BY mo.id_module, ma.id_matiere
    `, [idEtudiant])

    const unites = []

    rows.forEach(row => {
      let ue = unites.find(u => u.id === row.id_module)

      if (!ue) {
        ue = {
          id: row.id_module,
          nom: row.nom_module,
          semestre: row.semestre === 'S1' ? 1 : 2,
          ects: 6,
          matieres: []
        }

        unites.push(ue)
      }

      ue.matieres.push({
        id: row.id_matiere,
        nom: row.nom_matiere,
        coef: row.coefficient || 1,
        note: row.note,
        type_evaluation: row.type_evaluation,
        date_evaluation: row.date_evaluation
      })
    })

    res.json(unites)

  } catch (error) {
    console.error(error)
    res.status(500).json({
      message: 'Erreur serveur'
    })
  }
}