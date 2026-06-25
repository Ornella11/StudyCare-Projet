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
    <h1>Gestion de la Cartographie des Actifs 🖥️</h1>

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
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: system-ui, sans-serif; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 30px; color: #212529; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 0; margin-bottom: 20px; color: #495057; }
.layout-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; align-items: start; }

@media (max-width: 850px) {
  .layout-grid { grid-template-columns: 1fr; }
}

.card { background: #ffffff; border: 1px solid #e9ecef; padding: 24px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.01); }
.form-box { background: #f8f9fa; display: flex; flex-direction: column; }
.edit-mode { border: 2px solid #4477ce; background-color: #f1f5fd; }

.input-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
.input-group label { font-size: 0.85rem; font-weight: 600; color: #495057; }
.input-group input, .input-group select { padding: 10px 14px; border: 1px solid #dee2e6; border-radius: 6px; background: #fff; font-size: 0.95rem; outline: none; }
.input-group input:focus, .input-group select:focus { border-color: #4477ce; }

.checkbox-label { display: flex; align-items: center; gap: 8px; cursor: pointer; user-select: none; }
.font-bold { font-weight: 600; margin-top: 5px; }

.btn-primary { background: #4477ce; color: #fff; border: none; padding: 12px; border-radius: 6px; font-weight: 600; cursor: pointer; width: 100%; transition: background 0.2s; }
.btn-primary:hover { background: #2f5bb5; }
.btn-secondary { background: #ffffff; color: #495057; border: 1px solid #dee2e6; padding: 12px; border-radius: 6px; font-weight: 600; cursor: pointer; width: 100%; }
.btn-group { display: flex; gap: 10px; }

.empty-state { text-align: center; color: #6c757d; padding: 40px 20px; font-style: italic; }

.styled-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.95rem; }
.styled-table th { padding: 12px 15px; background-color: #f1f3f5; color: #495057; font-weight: 700; border-bottom: 2px solid #dee2e6; }
.styled-table td { padding: 12px 15px; border-bottom: 1px solid #e9ecef; vertical-align: middle; }

.badge { display: inline-block; padding: 4px 8px; font-size: 0.75rem; font-weight: 700; background: #e9ecef; color: #495057; border-radius: 4px; }
.bg-red { background: #ffebee; color: #c62828; }
.bg-green { background: #e8f5e9; color: #2e7d32; }

.actions-buttons { display: flex; gap: 8px; }
.btn-action { padding: 6px 12px; font-size: 0.85rem; font-weight: 600; border-radius: 6px; cursor: pointer; background: none; }
.btn-edit { border: 1px solid #4477ce; color: #4477ce; }
.btn-edit:hover { background: #eef3fc; }
.btn-delete { border: 1px solid #dee2e6; color: #e53935; }
.btn-delete:hover { background: #ffebee; border-color: #ffcdd2; }
</style>