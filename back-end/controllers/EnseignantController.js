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

exports.ajouterNote = async (req, res) => {
  const { id_etudiant, id_matiere, note, type_evaluation, date_evaluation } = req.body

  try {
    const [result] = await db.query(
      `INSERT INTO notes 
      (id_etudiant, id_matiere, note, type_evaluation, date_evaluation)
      VALUES (?, ?, ?, ?, ?)`,
      [id_etudiant, id_matiere, note, type_evaluation, date_evaluation]
    )

    res.status(201).json({ id_note: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Erreur ajout note' })
  }
}

exports.supprimerNote = async (req, res) => {
  const { idNote } = req.params

  try {
    await db.query('DELETE FROM notes WHERE id_note = ?', [idNote])
    res.json({ message: 'Note supprimée' })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Erreur suppression note' })
  }
}

exports.ajouterMatiere = async (req, res) => {
  const { nom_matiere, id_module, id_enseignant, coefficient } = req.body

  try {
    const [result] = await db.query(
      `INSERT INTO matieres 
      (nom_matiere, id_module, id_enseignant, coefficient)
      VALUES (?, ?, ?, ?)`,
      [nom_matiere, id_module, id_enseignant, coefficient]
    )

    res.status(201).json({ id_matiere: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Erreur ajout matière' })
  }
}

exports.supprimerMatiere = async (req, res) => {
  const { idMatiere } = req.params

  try {
    await db.query('DELETE FROM notes WHERE id_matiere = ?', [idMatiere])
    await db.query('DELETE FROM matieres WHERE id_matiere = ?', [idMatiere])

    res.json({ message: 'Matière supprimée' })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Erreur suppression matière' })
  }
}