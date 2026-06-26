<script setup>
import { ref, onMounted } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'

const store = useCyberStore()

const nouvelActif = ref({ nom_actif: '', type_actif: 'Serveur Web', exposition_internet: 0 })
const nouvelleVuln = ref({ id_actif: '', description: '', criticite: 'Moyen' })

onMounted(() => store.chargerTout())

const submitActif = async () => {
  await store.ajouterActif(nouvelActif.value)
  nouvelActif.value = { nom_actif: '', type_actif: 'Serveur Web', exposition_internet: 0 }
}

const submitVuln = async () => {
  await store.ajouterVuln(nouvelleVuln.value)
  nouvelleVuln.value = { id_actif: '', description: '', criticite: 'Moyen' }
}
</script>

<template>
<div class="container">
<h1>Inventaire & Gestion des Risques</h1>

    <div class="layout-grid">
<div>
<h2>Ajouter un Actif</h2>
<form @submit.prevent="submitActif" class="form-box">
<input v-model="nouvelActif.nom_actif" placeholder="Nom de l'actif (ex: BDD Client)" required />
<select v-model="nouvelActif.type_actif">
<option>Serveur Web</option>
<option>Base de données</option>
<option>Poste utilisateur</option>
<option>Routeur</option>
<option>Pare-feu</option>
<option>Application métier</option>
</select>
<label class="checkbox-label">
<input type="checkbox" v-model="nouvelActif.exposition_internet" :true-value="1" :false-value="0" />
            Exposé sur Internet
</label>
<button type="submit" class="btn-submit">Ajouter l'actif</button>
</form>

        <h2>Liste des Actifs Informatiques</h2>
<div class="list-wrapper">
<div v-for="a in store.actifs" :key="a.id_actif" class="item-card">
<div>
<strong>{{ a.nom_actif }}</strong> <br />
<span class="badge">{{ a.type_actif }}</span>
<span v-if="a.exposition_internet" class="badge bg-red">🌐 Exposé</span>
</div>
<button @click="store.supprimerActif(a.id_actif)" class="btn-delete">Supprimer</button>
</div>
</div>
</div>

      <div>
<h2>Déclarer une Vulnérabilité</h2>
<form @submit.prevent="submitVuln" class="form-box">
<select v-model="nouvelleVuln.id_actif" required>
<option value="">Sélectionner l'actif concerné</option>
<option v-for="a in store.actifs" :key="a.id_actif" :value="a.id_actif">{{ a.nom_actif }}</option>
</select>
<input v-model="nouvelleVuln.description" placeholder="Description de la faille (ex: Mot de passe faible)" required />
<select v-model="nouvelleVuln.criticite">
<option>Faible</option>
<option>Moyen</option>
<option>Élevé</option>
</select>
<button type="submit" class="btn-submit btn-orange">Associer la vulnérabilité</button>
</form>

        <h2>Vulnérabilités Actives</h2>
<div class="list-wrapper">
<div v-for="v in store.vulnerabilites" :key="v.id_vuln" class="item-card">
<div>
<strong>{{ v.description }}</strong> <br />
<small>Sur l'actif : {{ v.nom_actif }}</small> <br />
<span class="badge" :class="'crit-' + v.criticite.toLowerCase()">Critique : {{ v.criticite }}</span>
</div>
<button @click="store.supprimerVuln(v.id_vuln)" class="btn-delete">Corriger (Supprimer)</button>
</div>
</div>
</div>
</div>
</div>
</template>

<style scoped>
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; font-family: 'Courier New', Courier, monospace; color: #0a0f0d; }
h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 35px; color: #00ff66; text-shadow: 0 0 5px rgba(0, 255, 102, 0.2); text-transform: uppercase; letter-spacing: 1px; }
h2 { font-size: 1.2rem; font-weight: 700; margin-top: 30px; margin-bottom: 15px; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.layout-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(500px, 1fr)); gap: 40px; }
.form-box { background: #f5fbf7; border: 2px solid #114422; padding: 20px; border-radius: 2px; display: flex; flex-direction: column; gap: 12px; margin-bottom: 20px; box-shadow: 4px 4px 0px rgba(17, 68, 34, 0.1); }
.form-box input, .form-box select { padding: 10px 14px; font-size: 0.95rem; border: 1px solid #114422; border-radius: 2px; background: #fff; color: #0a0f0d; font-family: inherit; outline: none; }
.form-box input:focus, .form-box select:focus { border-color: #00ff66; box-shadow: 0 0 8px rgba(0, 255, 102, 0.3); }
.checkbox-label { display: flex; align-items: center; gap: 8px; font-size: 0.9rem; font-weight: 600; cursor: pointer; text-transform: uppercase; color: #0a0f0d; }
.btn-submit { background: #00ff66; color: #0a0f0d; border: none; padding: 12px; border-radius: 2px; font-weight: 600; cursor: pointer; text-transform: uppercase; letter-spacing: 1px; transition: all 0.2s; }
.btn-submit:hover { background: #33ff77; box-shadow: 0 0 10px rgba(0, 255, 102, 0.4); }
.btn-orange { background: #ef6c00; color: #fff; }
.btn-orange:hover { background: #f57c00; box-shadow: 0 0 10px rgba(239, 108, 0, 0.4); }
.list-wrapper { border: 2px solid #00ff66; border-radius: 2px; overflow: hidden; background: #fff; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.1); }
.item-card { display: flex; justify-content: space-between; align-items: center; padding: 15px 20px; border-bottom: 1px solid #114422; background: #fff; }
.item-card:last-child { border-bottom: none; }
.badge { display: inline-block; padding: 4px 8px; font-size: 0.75rem; font-weight: 700; background: #e8f5e9; border-radius: 2px; margin-top: 6px; margin-right: 5px; text-transform: uppercase; }
.bg-red { background: #ffebee; color: #c62828; border: 1px solid #c62828; }
.crit-faible { background: #e8f5e9; color: #2e7d32; border: 1px solid #2e7d32; }
.crit-moyen { background: #fff3e0; color: #ef6c00; border: 1px solid #ef6c00; }
.crit-élevé { background: #ffebee; color: #c62828; border: 1px solid #c62828; }
.btn-delete { background: none; border: 1px solid #114422; color: #c62828; padding: 6px 12px; border-radius: 2px; cursor: pointer; font-size: 0.85rem; font-weight: 600; text-transform: uppercase; font-family: inherit; transition: all 0.2s; }
.btn-delete:hover { background: #c62828; color: #ffffff; border-color: #c62828; }
</style>
