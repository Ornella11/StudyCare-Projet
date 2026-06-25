import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useAuthStore } from './authStores'

export const useCyberStore = defineStore('cyber', () => {
  const entreprise = ref({})
  const actifs = ref([])
  const vulnerabilites = ref([])
  const stats = ref({ 
    totalActifs: 0, 
    totalVulnerabilites: 0, 
    scoreRisqueGlobal: 0, 
    niveauRisque: 'Faible',
    couleurRisque: '#2e7d32',
    actifsExposes: 0
  })

  const getHeaders = () => {
    const authStore = useAuthStore()
    const token = authStore.token || localStorage.getItem('user_token')
    return {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    }
  }

  const chargerTout = async () => {
    try {
      const headers = getHeaders()

      entreprise.value = await fetch('http://localhost:3000/api/entreprise', { headers }).then(r => r.json())

      actifs.value = await fetch('http://localhost:3000/api/actifs', { headers }).then(r => r.json())

      vulnerabilites.value = await fetch('http://localhost:3000/api/vulnerabilites', { headers }).then(r => r.json())

      stats.value = await fetch('http://localhost:3000/api/risk/calculate', { 
        method: 'POST',
        headers 
      }).then(r => r.json())

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
    await chargerTout()
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

  return { 
    entreprise, 
    actifs, 
    vulnerabilites, 
    stats, 
    chargerTout, 
    modifierEntreprise, 
    ajouterActif, 
    supprimerActif, 
    ajouterVuln, 
    supprimerVuln 
  }
})