<script setup>
import { ref, onMounted } from 'vue'

const etudiants = ref([])
const enseignants = ref([])
const modules = ref([])
const matieres = ref([])
const notes = ref([])

const nouveauModule = ref({
  nom_module: '',
  semestre: 1,
})

const nouvelleMatiere = ref({
  nom_matiere: '',
  id_module: '',
  id_enseignant: '',
  coefficient: 1
})

const nouvelleNote = ref({
  id_etudiant: '',
  id_matiere: '',
  note: '',
  type_evaluation: 'Contrôle',
  date_evaluation: ''
})

const chargerDonnees = async () => {
  etudiants.value = await fetch('http://localhost:3000/api/admin/etudiants').then(r => r.json())
  enseignants.value = await fetch('http://localhost:3000/api/admin/enseignants').then(r => r.json())
  modules.value = await fetch('http://localhost:3000/api/admin/modules').then(r => r.json())
  matieres.value = await fetch('http://localhost:3000/api/admin/matieres').then(r => r.json())
  notes.value = await fetch('http://localhost:3000/api/admin/notes').then(r => r.json())
}

const ajouterModule = async () => {
  const response = await fetch('http://localhost:3000/api/admin/modules', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      nom_module: nouveauModule.value.nom_module,
      semestre: Number(nouveauModule.value.semestre),
    })
  })

  const data = await response.json()
  console.log('AJOUT MODULE:', data)

  if (!response.ok) {
    alert(data.message || 'Erreur ajout module')
    return
  }

  await chargerDonnees()
}
const supprimerModule = async (idModule) => {
  await fetch(`http://localhost:3000/api/admin/modules/${idModule}`, {
    method: 'DELETE'
  })

  await chargerDonnees()
}

const ajouterMatiere = async () => {
  const response = await fetch('http://localhost:3000/api/admin/matieres', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      nom_matiere: nouvelleMatiere.value.nom_matiere,
      id_module: Number(nouvelleMatiere.value.id_module),
      id_enseignant: Number(nouvelleMatiere.value.id_enseignant),
      coefficient: Number(nouvelleMatiere.value.coefficient)
    })
  })

  const data = await response.json()
  console.log('AJOUT MATIERE:', data)

  if (!response.ok) {
    alert(data.message || 'Erreur ajout matière')
    return
  }

  await chargerDonnees()
}

const supprimerMatiere = async (idMatiere) => {
  await fetch(`http://localhost:3000/api/admin/matieres/${idMatiere}`, {
    method: 'DELETE'
  })

  await chargerDonnees()
}

const ajouterNote = async () => {
  const response = await fetch('http://localhost:3000/api/admin/notes', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      id_etudiant: Number(nouvelleNote.value.id_etudiant),
      id_matiere: Number(nouvelleNote.value.id_matiere),
      note: Number(nouvelleNote.value.note),
      type_evaluation: nouvelleNote.value.type_evaluation,
      date_evaluation: nouvelleNote.value.date_evaluation
    })
  })

  const data = await response.json()
  console.log('AJOUT NOTE:', data)

  if (!response.ok) {
    alert(data.message || 'Erreur ajout note')
    return
  }

  await chargerDonnees()
}

const modifierNote = async (n) => {
  await fetch(`http://localhost:3000/api/admin/notes/${n.id_note}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ note: Number(n.note) })
  })

  await chargerDonnees()
}

const supprimerNote = async (idNote) => {
  await fetch(`http://localhost:3000/api/admin/notes/${idNote}`, {
    method: 'DELETE'
  })

  await chargerDonnees()
}

onMounted(chargerDonnees)
</script>

<template>
  <div>
    <h1>Administration StudyCare</h1>

    <h2>Ajouter un module</h2>
    <form @submit.prevent="ajouterModule">
      <input v-model="nouveauModule.nom_module" placeholder="Nom du module" required />
      <input v-model="nouveauModule.semestre" type="number" min="1" max="2" placeholder="Semestre" required />
      <button>Ajouter module</button>
    </form>

    <h2>Modules</h2>
    <ul>
      <li v-for="module in modules" :key="module.id_module">
        {{ module.nom_module }} - Semestre {{ module.semestre }}
        <button @click="supprimerModule(module.id_module)">Supprimer</button>
      </li>
    </ul>

    <h2>Ajouter une matière</h2>
    <form @submit.prevent="ajouterMatiere">
      <input v-model="nouvelleMatiere.nom_matiere" placeholder="Nom matière" required />

      <select v-model="nouvelleMatiere.id_module" required>
        <option value="">Choisir un module</option>
        <option
          v-for="module in modules"
          :key="module.id_module"
          :value="module.id_module"
        >
          {{ module.nom_module }}
        </option>
      </select>

      <select v-model="nouvelleMatiere.id_enseignant" required>
        <option value="">Choisir un enseignant</option>
        <option
          v-for="enseignant in enseignants"
          :key="enseignant.id_enseignant"
          :value="enseignant.id_enseignant"
        >
          {{ enseignant.prenom }} {{ enseignant.nom }}
        </option>
      </select>

      <input v-model="nouvelleMatiere.coefficient" type="number" placeholder="Coefficient" required />
      <button>Ajouter matière</button>
    </form>

    <h2>Matières</h2>
    <ul>
      <li v-for="matiere in matieres" :key="matiere.id_matiere">
        {{ matiere.nom_matiere }} -
        {{ matiere.nom_module }} -
        coef {{ matiere.coefficient }} -
        {{ matiere.prenom_enseignant }} {{ matiere.nom_enseignant }}

        <button @click="supprimerMatiere(matiere.id_matiere)">Supprimer</button>
      </li>
    </ul>

    <h2>Ajouter une note</h2>
    <form @submit.prevent="ajouterNote">
      <select v-model="nouvelleNote.id_etudiant" required>
        <option value="">Choisir un étudiant</option>
        <option
          v-for="etudiant in etudiants"
          :key="etudiant.id_etudiant"
          :value="etudiant.id_etudiant"
        >
          {{ etudiant.prenom }} {{ etudiant.nom }}
        </option>
      </select>

      <select v-model="nouvelleNote.id_matiere" required>
        <option value="">Choisir une matière</option>
        <option
          v-for="matiere in matieres"
          :key="matiere.id_matiere"
          :value="matiere.id_matiere"
        >
          {{ matiere.nom_matiere }}
        </option>
      </select>

      <input v-model="nouvelleNote.note" type="number" min="0" max="20" placeholder="Note" required />
      <input v-model="nouvelleNote.type_evaluation" placeholder="Type évaluation" required />
      <input v-model="nouvelleNote.date_evaluation" type="date" required />

      <button>Ajouter note</button>
    </form>

    <h2>Notes</h2>
    <table border="1" cellpadding="8">
      <thead>
        <tr>
          <th>Étudiant</th>
          <th>Matière</th>
          <th>Date</th>
          <th>Note</th>
          <th>Actions</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="n in notes" :key="n.id_note">
          <td>{{ n.prenom_etudiant }} {{ n.nom_etudiant }}</td>
          <td>{{ n.nom_matiere }}</td>
          <td>{{ new Date(n.date_evaluation).toLocaleDateString() }}</td>
          <td>
            <input v-model.number="n.note" type="number" min="0" max="20" />
          </td>
          <td>
            <button @click="modifierNote(n)">Modifier</button>
            <button @click="supprimerNote(n.id_note)">Supprimer</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
