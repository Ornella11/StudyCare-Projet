const db = require('../config/database')

exports.afficherLesNotes = async (req, res) => {
  const [rows] = await db.query(`
    SELECT
      n.id_note,
      e.nom AS nom_etudiant,
      e.prenom AS prenom_etudiant,
      ma.nom_matiere,
      n.note,
      n.type_evaluation,
      n.date_evaluation
    FROM notes n
    JOIN etudiants e ON n.id_etudiant = e.id_etudiant
    JOIN matieres ma ON n.id_matiere = ma.id_matiere
    ORDER BY e.nom, ma.nom_matiere
  `)

  res.json(rows)
}

exports.updateNote = async (req, res) => {
  const { idNote } = req.params
  const { note } = req.body

  await db.query(
    'UPDATE notes SET note = ? WHERE id_note = ?',
    [note, idNote]
  )

  res.json({ message: 'Note modifiée' })
}