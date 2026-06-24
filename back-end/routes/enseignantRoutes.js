const express = require('express')
const router = express.Router()
const enseignantController = require('../controllers/EnseignantController')

router.get('/notes', enseignantController.afficherLesNotes)
router.put('/notes/:idNote', enseignantController.updateNote)
router.post('/notes', enseignantController.ajouterNote)
router.delete('/notes/:idNote', enseignantController.supprimerNote)

router.post('/matieres', enseignantController.ajouterMatiere)
router.delete('/matieres/:idMatiere', enseignantController.supprimerMatiere)

module.exports = router