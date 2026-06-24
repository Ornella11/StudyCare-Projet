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

h2 {
  font-size: 1.3rem;
  font-weight: 600;
  margin-top: 40px;
  margin-bottom: 20px;
  color: #212529;
}

form {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 15px;
  background-color: #f8f9fa;
  padding: 24px;
  border-radius: 12px;
  border: 1px solid #e9ecef;
  margin-bottom: 40px;
  align-items: end;
}

form input {
  width: 100%;
  padding: 10px 14px;
  font-size: 0.95rem;
  border: 1px solid #dee2e6;
  border-radius: 8px;
  outline: none;
  background-color: #ffffff;
  box-sizing: border-box;
  transition: border-color 0.2s, box-shadow 0.2s;
}

form input:focus {
  border-color: #4477ce;
  box-shadow: 0 0 0 3px rgba(68, 119, 206, 0.1);
}

form input[type="number"] {
  width: 100%;
  text-align: left;
}

form button[type="submit"] {
  padding: 11px 20px;
  font-size: 0.95rem;
  font-weight: 600;
  color: #ffffff;
  background-color: #d97736;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
  width: 100%;
}

form button[type="submit"]:hover {
  background-color: #c2652b;
}

form button[type="submit"]:active {
  transform: scale(0.98);
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

td input[type="number"] {
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

td input[type="number"]:focus {
  border-color: #4477ce;
  box-shadow: 0 0 0 3px rgba(68, 119, 206, 0.1);
}

td button {
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

td button:hover {
  background-color: #335ca3;
}

td button:active {
  transform: scale(0.98);
}
</style>