<script setup>
import { ref, onMounted } from 'vue'

const notes = ref([])

const nouvelleNote = ref({
  id_etudiant: '',
  id_matiere: '',
  note: '',
  type_evaluation: 'Contrôle',
  date_evaluation: ''
})

const chargerNotes = async () => {
  const response = await fetch('http://localhost:3000/api/enseignant/notes')
  notes.value = await response.json()
}

const ajouterNote = async () => {
  const response = await fetch('http://localhost:3000/api/enseignant/notes', {
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
  console.log('Réponse ajout note:', data)

  if (!response.ok) {
    alert(data.message || 'Erreur ajout note')
    return
  }

  nouvelleNote.value = {
    id_etudiant: '',
    id_matiere: '',
    note: '',
    type_evaluation: 'Contrôle',
    date_evaluation: ''
  }

  await chargerNotes()
}

const modifierNote = async (n) => {
  await fetch(`http://localhost:3000/api/enseignant/notes/${n.id_note}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ note: Number(n.note) })
  })

  alert('Note modifiée')
  await chargerNotes()
}

const supprimerNote = async (idNote) => {
  await fetch(`http://localhost:3000/api/enseignant/notes/${idNote}`, {
    method: 'DELETE'
  })

  await chargerNotes()
}

onMounted(chargerNotes)
</script>

<template>
  <div>
    <h1>Gestion des notes</h1>

    <h2>Ajouter une note</h2>

    <form @submit.prevent="ajouterNote">
      <input v-model="nouvelleNote.id_etudiant" placeholder="ID étudiant" required />
      <input v-model="nouvelleNote.id_matiere" placeholder="ID matière" required />
      <input v-model="nouvelleNote.note" type="number" min="0" max="20" placeholder="Note" required />
      <input v-model="nouvelleNote.type_evaluation" placeholder="Type évaluation" required />
      <input v-model="nouvelleNote.date_evaluation" type="date" required />

      <button type="submit">Ajouter</button>
    </form>

    <h2>Liste des notes</h2>

    <table border="1" cellpadding="8">
      <thead>
        <tr>
          <th>Étudiant</th>
          <th>Matière</th>
          <th>Type</th>
          <th>Date</th>
          <th>Note</th>
          <th>Actions</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="n in notes" :key="n.id_note">
          <td>{{ n.prenom_etudiant }} {{ n.nom_etudiant }}</td>
          <td>{{ n.nom_matiere }}</td>
          <td>{{ n.type_evaluation }}</td>
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
