const express = require('express')
const router = express.Router()

const notesController = require('../controllers/NotesController')

router.get('/:idEtudiant', notesController.getNotesByEtudiant)

module.exports = router