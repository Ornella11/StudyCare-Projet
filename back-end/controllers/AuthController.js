const db = require('../config/database')

exports.login = async (req, res) => {
  const { email, mot_de_passe } = req.body

    try {
   const [rows] = await db.query(`
  SELECT
    u.id_utilisateur,
    u.nom,
    u.prenom,
    u.email,
    u.mot_de_passe,
    u.role,
    e.id_etudiant
  FROM utilisateurs u
LEFT JOIN etudiants e ON e.id_utilisateur = u.id_utilisateur
  WHERE u.email = ?
`, [email])

    if (rows.length === 0) {
      return res.status(401).json({
        message: 'Utilisateur introuvable'
      })
    }

    const user = rows[0]

    if (user.mot_de_passe !== mot_de_passe) {
      return res.status(401).json({
        message: 'Mot de passe incorrect'
      })
    }

   res.json({
  id: user.id_utilisateur,
  id_etudiant: user.id_etudiant,
  nom: user.nom,
  prenom: user.prenom,
  email: user.email,
  role: user.role
})
  } catch (error) {
    console.error(error)
    res.status(500).json({
      message: 'Erreur serveur'
    })
  }
}