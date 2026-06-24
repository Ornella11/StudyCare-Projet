const express = require('express')
const router = express.Router()
const adminController = require('../controllers/AdminController')

router.get('/etudiants', adminController.getEtudiants)
router.get('/enseignants', adminController.getEnseignants)
router.get('/modules', adminController.getModules)
router.post('/modules', adminController.ajouterModule)
router.delete('/modules/:idModule', adminController.supprimerModule)

router.get('/matieres', adminController.getMatieres)
router.post('/matieres', adminController.ajouterMatiere)
router.delete('/matieres/:idMatiere', adminController.supprimerMatiere)

router.get('/notes', adminController.getNotes)
router.post('/notes', adminController.ajouterNote)
router.put('/notes/:idNote', adminController.modifierNote)
router.delete('/notes/:idNote', adminController.supprimerNote)

module.exports = router