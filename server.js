const mysql = require('mysql2/promise')
require('dotenv').config()

const express = require('express')
const cors = require('cors')
const routes = require('./back-end/routes/routes')
const notesRoutes = require('./back-end/routes/notesRoutes')
const enseignantRoutes = require('./back-end/routes/enseignantRoutes')
const adminRoutes = require('./back-end/routes/adminRoutes')


const app = express()

app.use(cors())
app.use(express.json())

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
})

app.get('/', (req, res) => {
  res.send('API StudyCare fonctionne')
})

app.post('/api/login', async (req, res) => {
  const { email, mot_de_passe } = req.body

  try {
    const [rows] = await db.query(
      `SELECT
        u.id_utilisateur,
        u.nom,
        u.prenom,
        u.email,
        u.mot_de_passe,
        u.role,
        e.id_etudiant
      FROM utilisateurs u
      LEFT JOIN etudiants e
        ON e.id_utilisateur = u.id_utilisateur
      WHERE u.email = ?`,
      [email]
    
    )

    if (rows.length === 0) {
      return res.status(401).json({ message: 'Utilisateur introuvable' })
    }

    const utilisateur = rows[0]

    if (utilisateur.mot_de_passe !== mot_de_passe) {
      return res.status(401).json({ message: 'Mot de passe incorrect' })
    }

   res.json({
  id: utilisateur.id_utilisateur,
  id_etudiant: utilisateur.id_etudiant,
  nom: utilisateur.nom,
  prenom: utilisateur.prenom,
  email: utilisateur.email,
  role: utilisateur.role
})

  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Erreur serveur' })
  }
})


app.use('/api/notes', notesRoutes)

app.use('/api/enseignant', enseignantRoutes)

app.use('/api/admin', adminRoutes)

app.listen(process.env.PORT, () => {
  console.log(`Serveur démarré sur le port ${process.env.PORT}`)
})

