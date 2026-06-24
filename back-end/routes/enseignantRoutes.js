const express = require('express')
const router = express.Router()
const enseignantController = require('../controllers/EnseignantController')

router.get('/notes', enseignantController.afficherLesNotes)
router.put('/notes/:idNote', enseignantController.updateNote)

module.exports = router