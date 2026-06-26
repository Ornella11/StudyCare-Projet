<script setup>
import { onMounted, ref } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'

const store = useCyberStore()

const nouvelleVuln = ref({
  id_actif: '',
  description: '',
  criticite: 'Faible'
})

onMounted(async () => {
  await store.chargerTout()
})

const handleAjouter = async () => {
  if (!nouvelleVuln.value.id_actif || !nouvelleVuln.value.description.trim()) {
    alert('Veuillez sélectionner un actif et décrire la vulnérabilité.')
    return
  }
  
  await store.ajouterVuln(nouvelleVuln.value)
  
  nouvelleVuln.value = { id_actif: '', description: '', criticite: 'Faible' }
}

const handleSupprimer = async (id) => {
  if (confirm("Êtes-vous sûr de vouloir supprimer cette vulnérabilité ?")) {
    await store.supprimerVuln(id)
  }
}
</script>

<template>
  <div class="container">
    <h1>Registre des Vulnérabilités et Failles 🛡️</h1>
    <p class="subtitle">Identifiez, qualifiez et suivez les vulnérabilités découvertes sur vos actifs.</p>

    <div class="layout-grid">
      <div class="form-column">
        <div class="card form-box">
          <h2>⚠️ Déclarer une Faille</h2>
          <form @submit.prevent="handleAjouter">
            
            <div class="input-group">
              <label>Actif affecté</label>
              <select v-model="nouvelleVuln.id_actif" required>
                <option value="" disabled>-- Choisir un actif --</option>
                <option v-for="actif in store.actifs" :key="actif.id_actif" :value="actif.id_actif">
                  {{ actif.nom_actif }} ({{ actif.type_actif }})
                </option>
              </select>
              <p v-if="store.actifs.length === 0" class="error-text">
                ⚠️ Aucun actif disponible. Créez d'abord un actif dans "Gestion des Actifs".
              </p>
            </div>

            <div class="input-group">
              <label>Description de la vulnérabilité</label>
              <textarea 
                v-model="nouvelleVuln.description" 
                placeholder="ex: CVE-2021-44228 Log4j, Absence de chiffrement TLS, Injection SQL potentielle..." 
                rows="4"
                required
              ></textarea>
            </div>

            <div class="input-group">
              <label>Criticité (Impact SI)</label>
              <select v-model="nouvelleVuln.criticite" class="select-criticite">
                <option>Faible</option>
                <option>Moyen</option>
                <option>Élevé</option>
              </select>
            </div>

            <button type="submit" class="btn-primary" :disabled="store.actifs.length === 0">
              Inscrire au registre
            </button>
          </form>
        </div>
      </div>

      <div class="list-column">
        <div class="card table-card">
          <h2>📋 Failles détectées ({{ store.vulnerabilites.length }} en attente de patch/remédiation)</h2>
          
          <div v-if="store.vulnerabilites.length === 0" class="empty-state">
            Félicitations ! Aucune vulnérabilité n'est actuellement enregistrée sur le système.
          </div>

          <table v-else class="styled-table">
            <thead>
              <tr>
                <th>Actif ciblé</th>
                <th>Description du risque</th>
                <th>Criticité</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="vuln in store.vulnerabilites" :key="vuln.id_vuln">
                <td><strong>{{ vuln.nom_actif || 'Actif inconnu' }}</strong></td>
                <td class="desc-cell">{{ vuln.description }}</td>
                <td>
                  <span class="badge" :class="{
                    'bg-red': vuln.criticite === 'Élevé',
                    'bg-orange': vuln.criticite === 'Moyen',
                    'bg-blue': vuln.criticite === 'Faible'
                  }">
                    {{ vuln.criticite }}
                  </span>
                </td>
                <td>
                  <button @click="handleSupprimer(vuln.id_vuln)" class="btn-delete">
                    Résolue ✔️
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: 'Courier New', Courier, monospace; color: #0a0f0d; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 5px; color: #00ff66; text-shadow: 0 0 5px rgba(0, 255, 102, 0.2); text-transform: uppercase; letter-spacing: 1px; }
.subtitle { color: #22aa55; margin-bottom: 30px; font-size: 0.95rem; text-transform: uppercase; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.layout-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; align-items: start; }

@media (max-width: 900px) {
  .layout-grid { grid-template-columns: 1fr; }
}

.card { background: #ffffff; border: 2px solid #00ff66; padding: 24px; border-radius: 2px; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.1); }
.form-box { background: #f5fbf7; border: 2px solid #114422; box-shadow: 4px 4px 0px rgba(17, 68, 34, 0.1); }

.input-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 18px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.input-group input, .input-group select, .input-group textarea { padding: 10px 14px; border: 1px solid #114422; border-radius: 2px; background: #fff; color: #0a0f0d; font-size: 0.95rem; outline: none; font-family: inherit; }
.input-group input:focus, .input-group select:focus, .input-group textarea:focus { border-color: #00ff66; box-shadow: 0 0 8px rgba(0, 255, 102, 0.3); }

.error-text { color: #c62828; font-size: 0.8rem; margin: 5px 0 0 0; font-weight: 500; text-transform: uppercase; }
.desc-cell { max-width: 300px; line-height: 1.4; color: #0a0f0d; }

.btn-primary { background: #00ff66; color: #0a0f0d; border: none; padding: 12px; border-radius: 2px; font-weight: 600; cursor: pointer; width: 100%; transition: all 0.2s; text-transform: uppercase; letter-spacing: 1px; }
.btn-primary:hover:not(:disabled) { background: #33ff77; box-shadow: 0 0 10px rgba(0, 255, 102, 0.4); }
.btn-primary:disabled { background: #e9ecef; color: #adb5bd; border: 1px solid #dee2e6; cursor: not-allowed; }

.empty-state { text-align: center; color: #2e7d32; background-color: #e8f5e9; padding: 30px 20px; font-style: italic; border: 1px solid #2e7d32; border-radius: 2px; font-weight: 500; text-transform: uppercase; }

.styled-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.95rem; }
.styled-table th { padding: 12px 15px; background-color: #051a0d; color: #00ff66; font-weight: 700; border-bottom: 2px solid #00ff66; text-transform: uppercase; }
.styled-table td { padding: 12px 15px; border-bottom: 1px solid #114422; vertical-align: middle; }

.badge { display: inline-block; padding: 4px 10px; font-size: 0.75rem; font-weight: 700; border-radius: 2px; text-align: center; min-width: 50px; text-transform: uppercase; }
.bg-red { background: #ffebee; color: #c62828; border: 1px solid #c62828; }
.bg-orange { background: #fff3e0; color: #ef6c00; border: 1px solid #ef6c00; }
.bg-blue { background: #e3f2fd; color: #1565c0; border: 1px solid #1565c0; }

.btn-delete { background: #ffffff; border: 1px solid #114422; color: #c62828; padding: 6px 12px; font-size: 0.85rem; font-weight: 600; border-radius: 2px; cursor: pointer; transition: all 0.2s; text-transform: uppercase; font-family: inherit; }
.btn-delete:hover { background: #c62828; color: #ffffff; border-color: #c62828; }
</style>