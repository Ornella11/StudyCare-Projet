<script setup>
import { ref, onMounted } from 'vue'

const notes = ref([])

const chargerNotes = async () => {
  const response = await fetch('http://localhost:3000/api/enseignant/notes')
  notes.value = await response.json()
}

const modifierNote = async (noteItem) => {
  await fetch(`http://localhost:3000/api/enseignant/notes/${noteItem.id_note}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ note: noteItem.note })
  })

  alert('Note mise à jour')
}

onMounted(chargerNotes)
</script>

<template>
  <div>
    <h1>Espace Enseignant - Gestion des notes</h1>

    <table border="1" cellpadding="8">
      <thead>
        <tr>
          <th>Étudiant</th>
          <th>Matière</th>
          <th>Type</th>
          <th>Date</th>
          <th>Note</th>
          <th>Action</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="n in notes" :key="n.id_note">
          <td>{{ n.prenom_etudiant }} {{ n.nom_etudiant }}</td>
          <td>{{ n.nom_matiere }}</td>
          <td>{{ n.type_evaluation }}</td>
          <td>{{ new Date(n.date_evaluation).toLocaleDateString() }}</td>
          <td>
            <input
              v-model.number="n.note"
              type="number"
              min="0"
              max="20"
            />
          </td>
          <td>
            <button @click="modifierNote(n)">
              Enregistrer
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
