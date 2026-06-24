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

<style scoped>
div {
  max-width: 1100px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: system-ui, -apple-system, sans-serif;
  color: #212529;
}

h1 {
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 30px;
  color: #212529;
}

table {
  width: 100%;
  border-collapse: collapse;
  background-color: #ffffff;
  border: 1px solid #e9ecef;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.01);
}

th {
  background-color: #f8f9fa;
  color: #495057;
  font-weight: 600;
  font-size: 0.9rem;
  text-align: left;
  padding: 16px 20px;
  border-bottom: 2px solid #dee2e6;
}

td {
  padding: 16px 20px;
  font-size: 0.95rem;
  color: #212529;
  border-bottom: 1px solid #e9ecef;
  vertical-align: middle;
}

tr:last-child td {
  border-bottom: none;
}

tr:hover td {
  background-color: #fdfdfd;
}

input[type="number"] {
  width: 70px;
  padding: 8px 10px;
  font-size: 0.95rem;
  font-weight: 600;
  border: 1px solid #dee2e6;
  border-radius: 6px;
  text-align: center;
  outline: none;
  background-color: #ffffff;
  transition: border-color 0.2s;
}

input[type="number"]:focus {
  border-color: #4477ce;
  box-shadow: 0 0 0 3px rgba(68, 119, 206, 0.1);
}

button {
  padding: 8px 16px;
  font-size: 0.9rem;
  font-weight: 600;
  color: #ffffff;
  background-color: #4477ce;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s;
}

button:hover {
  background-color: #335ca3;
}

button:active {
  transform: scale(0.98);
}
</style>