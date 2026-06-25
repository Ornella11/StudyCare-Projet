import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useAuthStore } from './authStores'

export const useCyberStore = defineStore('cyber', () => {
  const entreprise = ref({})
  const actifs = ref([])
  const vulnerabilites = ref([])
  const stats = ref({ totalActifs: 0, totalVulnerabilites: 0, scoreRisqueGlobal: 0, niveauRisque: 'Faible' })

  // Fonction utilitaire pour récupérer les headers avec le Token JWT automatiquement
  const getHeaders = () => {
    const authStore = useAuthStore()
    return {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${authStore.token}`
    }
  }

  const chargerTout = async () => {
    try {
      const headers = getHeaders()
      // /api/entreprise et /api/dashboard/stats n'ont pas forcément besoin du token selon ton server.js,
      // mais on leur passe les headers par sécurité et uniformité.
      entreprise.value = await fetch('http://localhost:3000/api/entreprise').then(r => r.json())
      stats.value = await fetch('http://localhost:3000/api/dashboard/stats').then(r => r.json())
      // Ces deux-là requièrent obligatoirement le token !
      actifs.value = await fetch('http://localhost:3000/api/actifs', { headers }).then(r => r.json())
      vulnerabilites.value = await fetch('http://localhost:3000/api/vulnerabilites', { headers }).then(r => r.json())
    } catch (error) {
      console.error("Impossible de contacter le serveur lors du chargement :", error)
    }
  }

  const modifierEntreprise = async (infos) => {
    await fetch('http://localhost:3000/api/entreprise', {
      method: 'PUT',
      headers: getHeaders(),
      body: JSON.stringify(infos)
    })
    await chargerTout()
  }

  const ajouterActif = async (actif) => {
    await fetch('http://localhost:3000/api/actifs', {
      method: 'POST',
      headers: getHeaders(),
      body: JSON.stringify(actif)
    })
    await chargerTout() // Ne pas oublier de rafraîchir le dashboard après l'ajout !
  }

  const supprimerActif = async (id) => {
    await fetch(`http://localhost:3000/api/actifs/${id}`, {
      method: 'DELETE',
      headers: getHeaders()
    })
    await chargerTout()
  }

  const ajouterVuln = async (vuln) => {
    await fetch('http://localhost:3000/api/vulnerabilites', {
      method: 'POST',
      headers: getHeaders(),
      body: JSON.stringify(vuln)
    })
    await chargerTout()
  }

  const supprimerVuln = async (id) => {
    await fetch(`http://localhost:3000/api/vulnerabilites/${id}`, {
      method: 'DELETE',
      headers: getHeaders()
    })
    await chargerTout()
  }

  return { entreprise, actifs, vulnerabilites, stats, chargerTout, modifierEntreprise, ajouterActif, supprimerActif, ajouterVuln, supprimerVuln }
})
