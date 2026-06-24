const db = require('../config/database')

exports.getEtudiants = async (req, res) => {
  const [rows] = await db.query('SELECT * FROM etudiants')
  res.json(rows)
}

exports.getEnseignants = async (req, res) => {
  const [rows] = await db.query('SELECT * FROM enseignants')
  res.json(rows)
}

exports.getModules = async (req, res) => {
  const [rows] = await db.query('SELECT * FROM modules')
  res.json(rows)
}

exports.ajouterModule = async (req, res) => {
  const { nom_module, semestre, ects } = req.body

  const [result] = await db.query(
    'INSERT INTO modules (nom_module, semestre) VALUES (?, ?)',
    [nom_module, semestre, ects]
  )

  res.status(201).json({ id_module: result.insertId })
}

exports.supprimerModule = async (req, res) => {
  const { idModule } = req.params

  await db.query('DELETE FROM notes WHERE id_matiere IN (SELECT id_matiere FROM matieres WHERE id_module = ?)', [idModule])
  await db.query('DELETE FROM matieres WHERE id_module = ?', [idModule])
  await db.query('DELETE FROM modules WHERE id_module = ?', [idModule])

  res.json({ message: 'Module supprimé' })
}

exports.getMatieres = async (req, res) => {
  const [rows] = await db.query(`
    SELECT 
      m.id_matiere,
      m.nom_matiere,
      m.coefficient,
      mo.nom_module,
      e.nom AS nom_enseignant,
      e.prenom AS prenom_enseignant
    FROM matieres m
    JOIN modules mo ON m.id_module = mo.id_module
    JOIN enseignants e ON m.id_enseignant = e.id_enseignant
  `)

  res.json(rows)
}

exports.ajouterMatiere = async (req, res) => {
  const { nom_matiere, id_module, id_enseignant, coefficient } = req.body

  const [result] = await db.query(
    `INSERT INTO matieres 
     (nom_matiere, id_module, id_enseignant, coefficient)
     VALUES (?, ?, ?, ?)`,
    [nom_matiere, id_module, id_enseignant, coefficient]
  )

  res.status(201).json({ id_matiere: result.insertId })
}

exports.supprimerMatiere = async (req, res) => {
  const { idMatiere } = req.params

  await db.query('DELETE FROM notes WHERE id_matiere = ?', [idMatiere])
  await db.query('DELETE FROM matieres WHERE id_matiere = ?', [idMatiere])

  res.json({ message: 'Matière supprimée' })
}

exports.getNotes = async (req, res) => {
  const [rows] = await db.query(`
    SELECT
      n.id_note,
      et.nom AS nom_etudiant,
      et.prenom AS prenom_etudiant,
      ma.nom_matiere,
      n.note,
      n.type_evaluation,
      n.date_evaluation
    FROM notes n
    JOIN etudiants et ON n.id_etudiant = et.id_etudiant
    JOIN matieres ma ON n.id_matiere = ma.id_matiere
    ORDER BY et.nom
  `)

  res.json(rows)
}

exports.ajouterNote = async (req, res) => {
  const { id_etudiant, id_matiere, note, type_evaluation, date_evaluation } = req.body

  const [result] = await db.query(
    `INSERT INTO notes
     (id_etudiant, id_matiere, note, type_evaluation, date_evaluation)
     VALUES (?, ?, ?, ?, ?)`,
    [id_etudiant, id_matiere, note, type_evaluation, date_evaluation]
  )

  res.status(201).json({ id_note: result.insertId })
}

exports.modifierNote = async (req, res) => {
  const { idNote } = req.params
  const { note } = req.body

  await db.query(
    'UPDATE notes SET note = ? WHERE id_note = ?',
    [note, idNote]
  )

  res.json({ message: 'Note modifiée' })
}

exports.supprimerNote = async (req, res) => {
  const { idNote } = req.params

  await db.query('DELETE FROM notes WHERE id_note = ?', [idNote])
  res.json({ message: 'Note supprimée' })
}