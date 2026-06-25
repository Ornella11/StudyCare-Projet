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
  console.log('Connecté à la base de données MySQL CyberShield 🛡️');
});
 
const SECRET_KEY = 'votre_cle_secrete_super_secure';
 
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
 
app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;
 
  db.query('SELECT * FROM utilisateurs WHERE email = ?', [email], (err, results) => {
    if (err) return res.status(500).json(err);
    if (results.length === 0) return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
 
    const utilisateur = results[0];
 
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
 
app.post('/api/risk/calculate', verifierToken, (req, res) => {
  db.query('SELECT * FROM entreprise LIMIT 1', (err, entRes) => {
    if (err) return res.status(500).json(err);
    const entreprise = entRes[0] || { serveurs: 0, postes_clients: 0 };
 
    db.query('SELECT * FROM actifs', (err, actRes) => {
      if (err) return res.status(500).json(err);
      
      db.query('SELECT * FROM vulnerabilites', (err, vulnRes) => {
        if (err) return res.status(500).json(err);
 
        const totalActifs = actRes.length;
        const totalVulns = vulnRes.length;
        const actifsExposes = actRes.filter(a => a.exposition_internet === 1).length;
 
        let scoreVuln = 0;
        let scoreExposition = 0;
        let scoreTailleSI = 0;
 
        vulnRes.forEach(v => {
          if (v.criticite === 'Faible') scoreVuln += 2;
          else if (v.criticite === 'Moyen') scoreVuln += 5;
          else if (v.criticite === 'Élevé') scoreVuln += 10;
        });
        if (scoreVuln > 50) scoreVuln = 50;
 
        if (totalActifs > 0) {
          const ratioExposition = actifsExposes / totalActifs;
          scoreExposition = Math.round(ratioExposition * 30);
        }
 
        const totalEquipements = (entreprise.serveurs || 0) + (entreprise.postes_clients || 0);
        if (totalEquipements > 100) scoreTailleSI = 20;
        else if (totalEquipements > 50) scoreTailleSI = 15;
        else if (totalEquipements > 10) scoreTailleSI = 10;
        else scoreTailleSI = 5;
 
        const scoreGlobal = scoreVuln + scoreExposition + scoreTailleSI;
 
        let niveauRisque = 'Faible';
        let couleurRisque = '#2e7d32'; 
 
        if (scoreGlobal > 65) {
          niveauRisque = 'Élevé';
          couleurRisque = '#c62828';
        } else if (scoreGlobal >= 35) {
          niveauRisque = 'Moyen';
          couleurRisque = '#ef6c00'; 
        }
 
        res.json({
          totalActifs,
          totalVulnerabilites: totalVulns,
          actifsExposes,
          scoreRisqueGlobal: scoreGlobal,
          niveauRisque,
          couleurRisque,
          details: {
            pointsVuln: scoreVuln,
            pointsExpo: scoreExposition,
            pointsSI: scoreTailleSI
          }
        });
      });
    });
  });
});
 
app.listen(3000, () => console.log('Serveur CyberShield opérationnel sur le port 3000 🚀'));