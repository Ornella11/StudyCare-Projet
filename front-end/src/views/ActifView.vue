<script setup>
import { ref, onMounted } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'

const store = useCyberStore()

const nouvelActif = ref({ nom_actif: '', type_actif: 'Serveur Web', exposition_internet: 0 })
const actifEnEdition = ref(null) 

onMounted(async () => {
  await store.chargerTout()
})

const handleAjouter = async () => {
  if (!nouvelActif.value.nom_actif.trim()) return
  await store.ajouterActif(nouvelActif.value)
  nouvelActif.value = { nom_actif: '', type_actif: 'Serveur Web', exposition_internet: 0 }
}

const initEdition = (actif) => {
  actifEnEdition.value = { ...actif }
}

const handleModifier = async () => {
  if (!actifEnEdition.value.nom_actif.trim()) return
  
  await fetch(`http://localhost:3000/api/actifs/${actifEnEdition.value.id_actif}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem('user_token')}`
    },
    body: JSON.stringify(actifEnEdition.value)
  })
  
  await store.chargerTout() 
  actifEnEdition.value = null 
}

const handleSupprimer = async (id) => {
  if (confirm("Êtes-vous sûr de vouloir supprimer cet actif ? Cela effacera également ses vulnérabilités associées.")) {
    await store.supprimerActif(id)
  }
}
</script>

<template>
  <div class="container">
    <h1>Gestion des Actifs 🖥️</h1>

    <div class="layout-grid">
      <div class="form-column">
        <div v-if="actifEnEdition" class="card form-box edit-mode">
          <h2>✏️ Modifier l'Actif</h2>
          <form @submit.prevent="handleModifier">
            <div class="input-group">
              <label>Nom de l'actif</label>
              <input v-model="actifEnEdition.nom_actif" required />
            </div>
            <div class="input-group">
              <label>Type d'équipement</label>
              <select v-model="actifEnEdition.type_actif">
                <option>Serveur Web</option>
                <option>Base de données</option>
                <option>Poste utilisateur</option>
                <option>Routeur</option>
                <option>Pare-feu</option>
                <option>Application métier</option>
              </select>
            </div>
            <div class="input-group font-bold">
              <label class="checkbox-label">
                <input type="checkbox" v-model="actifEnEdition.exposition_internet" :true-value="1" :false-value="0" />
                Exposé sur Internet
              </label>
            </div>
            <div class="btn-group">
              <button type="submit" class="btn-primary">Enregistrer</button>
              <button type="button" @click="actifEnEdition = null" class="btn-secondary">Annuler</button>
            </div>
          </form>
        </div>

        <div v-else class="card form-box">
          <h2>➕ Ajouter un Actif</h2>
          <form @submit.prevent="handleAjouter">
            <div class="input-group">
              <label>Nom de l'actif</label>
              <input v-model="nouvelActif.nom_actif" placeholder="ex: Serveur Exchange, NAS Principal..." required />
            </div>
            <div class="input-group">
              <label>Type d'équipement</label>
              <select v-model="nouvelActif.type_actif">
                <option>Serveur Web</option>
                <option>Base de données</option>
                <option>Poste utilisateur</option>
                <option>Routeur</option>
                <option>Pare-feu</option>
                <option>Application métier</option>
              </select>
            </div>
            <div class="input-group font-bold">
              <label class="checkbox-label">
                <input type="checkbox" v-model="nouvelActif.exposition_internet" :true-value="1" :false-value="0" />
                Exposé sur Internet
              </label>
            </div>
            <button type="submit" class="btn-primary">Ajouter à l'inventaire</button>
          </form>
        </div>
      </div>

      <div class="list-column">
        <div class="card table-card">
          <h2>📋 Inventaire Actuel ({{ store.actifs.length }} actifs répertoriés)</h2>
          
          <div v-if="store.actifs.length === 0" class="empty-state">
            Aucun actif dans la base de données. Utilisez le formulaire pour en créer un.
          </div>

          <table v-else class="styled-table">
            <thead>
              <tr>
                <th>Nom de l'Actif</th>
                <th>Type</th>
                <th>Exposition</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="actif in store.actifs" :key="actif.id_actif">
                <td><strong>{{ actif.nom_actif }}</strong></td>
                <td><span class="badge">{{ actif.type_actif }}</span></td>
                <td>
                  <span v-if="actif.exposition_internet === 1" class="badge bg-red">🌐 Public</span>
                  <span v-else class="badge bg-green">🔒 Interne</span>
                </td>
                <td>
                  <div class="actions-buttons">
                    <button @click="initEdition(actif)" class="btn-action btn-edit">Modifier</button>
                    <button @click="handleSupprimer(actif.id_actif)" class="btn-action btn-delete">Supprimer</button>
                  </div>
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
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 30px; color: #00ff66; text-shadow: 0 0 5px rgba(0, 255, 102, 0.2); text-transform: uppercase; letter-spacing: 1px; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.layout-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; align-items: start; }

@media (max-width: 850px) {
  .layout-grid { grid-template-columns: 1fr; }
}

.card { background: #ffffff; border: 2px solid #00ff66; padding: 24px; border-radius: 2px; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.1); }
.form-box { background: #f5fbf7; border: 2px solid #114422; display: flex; flex-direction: column; box-shadow: 4px 4px 0px rgba(17, 68, 34, 0.1); }
.edit-mode { border: 2px solid #00ff66; background-color: #ffffff; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.2); }

.input-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.input-group input, .input-group select { padding: 10px 14px; border: 1px solid #114422; border-radius: 2px; background: #fff; color: #0a0f0d; font-family: inherit; font-size: 0.95rem; outline: none; }
.input-group input:focus, .input-group select:focus { border-color: #00ff66; box-shadow: 0 0 8px rgba(0, 255, 102, 0.3); }

.checkbox-label { display: flex; align-items: center; gap: 8px; cursor: pointer; user-select: none; text-transform: uppercase; font-size: 0.85rem; color: #0a0f0d; }
.font-bold { font-weight: 600; margin-top: 5px; }

.btn-primary { background: #00ff66; color: #0a0f0d; border: none; padding: 12px; border-radius: 2px; font-weight: 600; cursor: pointer; width: 100%; transition: all 0.2s; text-transform: uppercase; letter-spacing: 1px; }
.btn-primary:hover { background: #33ff77; box-shadow: 0 0 10px rgba(0, 255, 102, 0.4); }
.btn-secondary { background: #ffffff; color: #0a0f0d; border: 1px solid #114422; padding: 12px; border-radius: 2px; font-weight: 600; cursor: pointer; width: 100%; text-transform: uppercase; transition: all 0.2s; }
.btn-secondary:hover { background: #051a0d; color: #00ff66; }
.btn-group { display: flex; gap: 10px; }

.empty-state { text-align: center; color: #22aa55; padding: 40px 20px; font-style: italic; }

.styled-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.95rem; }
.styled-table th { padding: 12px 15px; background-color: #051a0d; color: #00ff66; font-weight: 700; border-bottom: 2px solid #00ff66; text-transform: uppercase; }
.styled-table td { padding: 12px 15px; border-bottom: 1px solid #114422; vertical-align: middle; }

.badge { display: inline-block; padding: 4px 8px; font-size: 0.75rem; font-weight: 700; background: #e8f5e9; color: #2e7d32; border: 1px solid #2e7d32; border-radius: 2px; text-transform: uppercase; }
.bg-red { background: #ffebee; color: #c62828; border: 1px solid #c62828; }
.bg-green { background: #e8f5e9; color: #2e7d32; border: 1px solid #2e7d32; }

.actions-buttons { display: flex; gap: 8px; }
.btn-action { padding: 6px 12px; font-size: 0.85rem; font-weight: 600; border-radius: 2px; cursor: pointer; background: none; text-transform: uppercase; font-family: inherit; }
.btn-edit { border: 1px solid #00ff66; color: #051a0d; background: rgba(0, 255, 102, 0.05); }
.btn-edit:hover { background: #00ff66; color: #0a0f0d; }
.btn-delete { border: 1px solid #dee2e6; color: #c62828; border-color: #c62828; background: rgba(198, 40, 40, 0.05); }
.btn-delete:hover { background: #c62828; color: #ffffff; }
</style>