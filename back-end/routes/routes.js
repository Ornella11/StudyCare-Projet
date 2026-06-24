const express = require('express')
const router = express.Router()

const authController = require('../controllers/AuthController')
const notesController = require('../controllers/NotesController')

router.post('/login', authController.login)


router.get('/:idEtudiant', notesController.getNotesByEtudiant)

module.exports = router
