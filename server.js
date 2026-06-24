const mysql = require('mysql2/promise')
require('dotenv').config()

const express = require('express')
const cors = require('cors')

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
      'SELECT * FROM utilisateurs WHERE email = ?',
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

app.listen(process.env.PORT, () => {
  console.log(`Serveur démarré sur le port ${process.env.PORT}`)
})