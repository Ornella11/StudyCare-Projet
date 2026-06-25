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
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: system-ui, sans-serif; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 5px; color: #212529; }
.subtitle { color: #6c757d; margin-bottom: 30px; font-size: 0.95rem; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #495057; }
.layout-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; align-items: start; }

@media (max-width: 900px) {
  .layout-grid { grid-template-columns: 1fr; }
}

.card { background: #ffffff; border: 1px solid #e9ecef; padding: 24px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.01); }
.form-box { background: #f8f9fa; }

.input-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 18px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #495057; }
.input-group input, .input-group select, .input-group textarea { padding: 10px 14px; border: 1px solid #dee2e6; border-radius: 6px; background: #fff; font-size: 0.95rem; outline: none; font-family: inherit; }
.input-group input:focus, .input-group select:focus, .input-group textarea:focus { border-color: #4477ce; }

.error-text { color: #e53935; font-size: 0.8rem; margin: 5px 0 0 0; font-weight: 500; }
.desc-cell { max-width: 300px; line-height: 1.4; color: #495057; }

.btn-primary { background: #4477ce; color: #fff; border: none; padding: 12px; border-radius: 6px; font-weight: 600; cursor: pointer; width: 100%; transition: background 0.2s; }
.btn-primary:hover:not(:disabled) { background: #2f5bb5; }
.btn-primary:disabled { background: #ced4da; cursor: not-allowed; }

.empty-state { text-align: center; color: #2e7d32; background-color: #e8f5e9; padding: 30px 20px; font-style: italic; border-radius: 8px; font-weight: 500; }

.styled-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.95rem; }
.styled-table th { padding: 12px 15px; background-color: #f1f3f5; color: #495057; font-weight: 700; border-bottom: 2px solid #dee2e6; }
.styled-table td { padding: 12px 15px; border-bottom: 1px solid #e9ecef; vertical-align: middle; }

.badge { display: inline-block; padding: 4px 10px; font-size: 0.75rem; font-weight: 700; border-radius: 4px; text-align: center; min-width: 50px; }
.bg-red { background: #ffebee; color: #c62828; }
.bg-orange { background: #fff3e0; color: #ef6c00; }
.bg-blue { background: #e3f2fd; color: #1565c0; }

.btn-delete { background: #ffffff; border: 1px solid #ced4da; color: #2e7d32; padding: 6px 12px; font-size: 0.85rem; font-weight: 600; border-radius: 6px; cursor: pointer; transition: all 0.2s; }
.btn-delete:hover { background: #e8f5e9; border-color: #a5d6a7; }
</style>