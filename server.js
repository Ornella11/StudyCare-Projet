const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const jwt = require('jsonwebtoken');
 
const app = express();
app.use(cors());
app.use(express.json());
 
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'cybershield'
});
 
db.connect(err => {
  if (err) throw err;
  console.log('Connecté à la base de données MySQL CyberShield');
});
 
const SECRET_KEY = 'votre_cle_secrete_super_secure';
 
// --- MIDDLEWARE DE VÉRIFICATION JWT ---
const verifierToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
 
  if (!token) return res.status(401).json({ message: 'Accès refusé, token manquant' });
 
  jwt.verify(token, SECRET_KEY, (err, user) => {
    if (err) return res.status(403).json({ message: 'Token invalide ou expiré' });
    req.user = user;
    next();
  });
};
 
// --- AUTHENTIFICATION ---
app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;
 
  db.query('SELECT * FROM utilisateurs WHERE email = ?', [email], (err, results) => {
    if (err) return res.status(500).json(err);
    if (results.length === 0) return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
 
    const utilisateur = results[0];
 
    // Comparaison basique en texte clair (à remplacer par bcrypt.compare si haché)
    if (password !== utilisateur.mot_de_passe) {
      return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
    }
 
    const token = jwt.sign(
      { id_user: utilisateur.id_user, role: utilisateur.role },
      SECRET_KEY,
      { expiresIn: '24h' }
    );
 
    res.json({
      token,
      user: {
        id: utilisateur.id_user,
        nom: utilisateur.nom_complet,
        email: utilisateur.email,
        role: utilisateur.role
      }
    });
  });
});
 
// --- ENTREPRISE ---
app.get('/api/entreprise', (req, res) => {
  db.query('SELECT * FROM entreprise LIMIT 1', (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results[0] || {});
  });
});
 
app.put('/api/entreprise', verifierToken, (req, res) => {
  const { nom, secteur, employes, serveurs, postes_clients, services_exposes } = req.body;
  db.query(
    'UPDATE entreprise SET nom=?, secteur=?, employes=?, serveurs=?, postes_clients=?, services_exposes=? WHERE id=1',
    [nom, secteur, employes, serveurs, postes_clients, services_exposes],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Entreprise mise à jour' });
    }
  );
});
 
// --- ACTIFS (CRUD SÉCURISÉ) ---
app.get('/api/actifs', verifierToken, (req, res) => {
  db.query('SELECT * FROM actifs', (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results);
  });
});
 
app.post('/api/actifs', verifierToken, (req, res) => {
  const { nom_actif, type_actif, exposition_internet } = req.body;
  db.query('INSERT INTO actifs (nom_actif, type_actif, exposition_internet) VALUES (?, ?, ?)',
    [nom_actif, type_actif, exposition_internet], (err, result) => {
      if (err) return res.status(500).json(err);
      res.json({ id_actif: result.insertId, nom_actif, type_actif, exposition_internet });
  });
});
 
app.put('/api/actifs/:id', verifierToken, (req, res) => {
  const { nom_actif, type_actif, exposition_internet } = req.body;
  db.query('UPDATE actifs SET nom_actif=?, type_actif=?, exposition_internet=? WHERE id_actif=?',
    [nom_actif, type_actif, exposition_internet, req.params.id], (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Actif mis à jour' });
  });
});
 
app.delete('/api/actifs/:id', verifierToken, (req, res) => {
  db.query('DELETE FROM actifs WHERE id_actif=?', [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: 'Actif supprimé' });
  });
});
 
// --- VULNÉRABILITÉS (SÉCURISÉ) ---
app.get('/api/vulnerabilites', verifierToken, (req, res) => {
  db.query('SELECT v.*, a.nom_actif FROM vulnerabilites v JOIN actifs a ON v.id_actif = a.id_actif', (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results);
  });
});
 
app.post('/api/vulnerabilites', verifierToken, (req, res) => {
  const { id_actif, description, criticite } = req.body;
  db.query('INSERT INTO vulnerabilites (id_actif, description, criticite) VALUES (?, ?, ?)',
    [id_actif, description, criticite], (err, result) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Vulnérabilité ajoutée' });
  });
});
 
app.delete('/api/vulnerabilites/:id', verifierToken, (req, res) => {
  db.query('DELETE FROM vulnerabilites WHERE id_vuln=?', [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: 'Vulnérabilité supprimée' });
  });
});
 
// --- STATS & MOTEUR DE RISQUE ---
app.get('/api/dashboard/stats', (req, res) => {
  db.query('SELECT COUNT(*) as totalActifs FROM actifs', (err, actRes) => {
    if (err) return res.status(500).json(err);
    db.query('SELECT * FROM vulnerabilites', (err, vulnRes) => {
      if (err) return res.status(500).json(err);
      db.query('SELECT COUNT(*) as totalExpo FROM actifs WHERE exposition_internet = 1', (err, expoRes) => {
        if (err) return res.status(500).json(err);
 
        const totalActifs = actRes[0].totalActifs;
        const totalVulns = vulnRes.length;
        const totalExposes = expoRes[0].totalExpo;
 
        let scorePoints = (totalActifs * 1) + (totalExposes * 3);
        vulnRes.forEach(v => {
          if (v.criticite === 'Élevé') scorePoints += 5;
          if (v.criticite === 'Moyen') scorePoints += 3;
          if (v.criticite === 'Faible') scorePoints += 1;
        });
 
        let niveauRisque = 'Faible';
        if (scorePoints > 10 && scorePoints <= 25) niveauRisque = 'Moyen';
        if (scorePoints > 25) niveauRisque = 'Élevé';
 
        res.json({
          totalActifs,
          totalVulnerabilites: totalVulns,
          scoreRisqueGlobal: scorePoints,
          niveauRisque
        });
      });
    });
  });
});
 
app.listen(3000, () => console.log('Serveur CyberShield écoute sur le port 3000'));