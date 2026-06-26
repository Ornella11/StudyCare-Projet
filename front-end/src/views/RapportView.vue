<script setup>
import { onMounted, computed } from 'vue'
import { useCyberStore } from '@/stores/cyberStores.js'

const store = useCyberStore()

onMounted(async () => {
  await store.chargerTout()
})

const recommandations = computed(() => {
  const recs = []
  
  store.vulnerabilites.forEach(v => {
    const desc = v.description.toLowerCase()
    if (desc.includes('mot de passe') || desc.includes('password')) {
      recs.push({ titre: 'Politique de Mots de Passe', texte: `Sur l'actif [${v.nom_actif}], appliquez une politique stricte (12 caractères min, caractères spéciaux) et activez le MFA (Multi-Facteur).` })
    }
    if (desc.includes('obsolète') || desc.includes('mise à jour') || desc.includes('cve')) {
      recs.push({ titre: 'Gestion des Correctifs', texte: `Le système ou logiciel sur [${v.nom_actif}] présente des failles publiques. Déployez les derniers patchs de sécurité immédiatement.` })
    }
    if (desc.includes('sauvegarde') || desc.includes('backup')) {
      recs.push({ titre: 'Stratégie de Sauvegarde', texte: `Mettez en place une règle de sauvegarde 3-2-1 (3 copies, 2 supports différents, 1 hors site) pour parer aux Ransomwares.` })
    }
  })

  if (store.stats.actifsExposes > 2) {
    recs.push({ titre: 'Chiffrement & Cloisonnement', texte: 'Plusieurs de vos actifs sont directement exposés sur Internet. Placez-les derrière un Pare-feu (Firewall) ou un VPN d\'entreprise.' })
  }

  if (recs.length === 0) {
    recs.push({ titre: 'Maintenance Préventive', texte: 'Aucune faille critique détectée. Continuez les scans de vulnérabilités réguliers et sensibilisez les collaborateurs au phishing.' })
  }
  return Array.from(new Set(recs.map(r => JSON.stringify(r)))).map(r => JSON.parse(r))
})

const exporterPDF = () => {
  window.print()
}
</script>

<template>
  <div class="container unique-print-zone">
    <div class="no-print action-bar">
      <button @click="exporterPDF" class="btn-pdf">📄 Exporter le Rapport en PDF</button>
    </div>

    <header class="report-header">
      <div class="badge-risque" :style="{ backgroundColor: store.stats.couleurRisque }">
        Risque {{ store.stats.niveauRisque }}
      </div>
      <h1>Rapport d'Audit & Risque Cyber</h1>
      <p class="date">Généré automatiquement par l'instance <strong>CyberTwin</strong></p>
    </header>

    <hr />

    <section class="report-section">
      <h2>1. Fiche descriptive de l'organisation</h2>
      <div class="grid-info">
        <p><strong>Raison Sociale :</strong> {{ store.entreprise.nom || 'Non configurée' }}</p>
        <p><strong>Secteur d'Activité :</strong> {{ store.entreprise.secteur || 'Inconnu' }}</p>
        <p><strong>Effectif Global :</strong> {{ store.entreprise.employes || 0 }} collaborateurs</p>
        <p><strong>Périmètre Serveurs :</strong> {{ store.entreprise.serveurs || 0 }} unités</p>
        <p><strong>Terminaux Utilisateurs :</strong> {{ store.entreprise.postes_clients || 0 }} postes</p>
        <p class="full-width"><strong>Services Exposés :</strong> {{ store.entreprise.services_exposes || 'Aucun service public détecté' }}</p>
      </div>
    </section>

    <section class="report-section">
      <h2>2. Évaluation Globale du Risque</h2>
      <div class="risk-summary-box">
        <div class="score-circle" :style="{ borderColor: store.stats.couleurRisque }">
          <span class="score-num">{{ store.stats.scoreRisqueGlobal || 0 }}</span>
          <span class="score-max">/ 100</span>
        </div>
        <div class="risk-text">
          <p>Le niveau de risque calculé pour cette infrastructure est jugé <strong>{{ store.stats.niveauRisque }}</strong>.</p>
          <p class="small-desc">Cette analyse prend en compte la taille du système d'information, le taux d'exposition des serveurs sur l'Internet public (actuellement <strong>{{ store.stats.actifsExposes }}</strong> actif(s) exposé(s)) ainsi que la sévérité cumulée des vulnérabilités en attente de traitement.</p>
        </div>
      </div>
    </section>

    <section class="report-section">
      <h2>3. Registre des Vulnérabilités Détectées</h2>
      <table class="report-table">
        <thead>
          <tr>
            <th>Actif Ciblé</th>
            <th>Description de la Brèche / Faille</th>
            <th>Niveau de Criticité</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="vuln in store.vulnerabilites" :key="vuln.id_vuln">
            <td><strong>{{ vuln.nom_actif }}</strong></td>
            <td>{{ vuln.description }}</td>
            <td class="font-bold" :style="{ color: vuln.criticite === 'Élevé' ? '#c62828' : vuln.criticite === 'Moyen' ? '#ef6c00' : '#1565c0' }">
              {{ vuln.criticite }}
            </td>
          </tr>
          <tr v-if="store.vulnerabilites.length === 0">
            <td colspan="3" class="text-center empty">Aucune vulnérabilité active répertoriée dans le système.</td>
          </tr>
        </tbody>
      </table>
    </section>

    <section class="report-section page-break">
      <h2>4. Plan de Remédiation & Recommandations</h2>
      <div class="recs-list">
        <div v-for="(rec, index) in recommandations" :key="index" class="rec-card">
          <h4>🛡️ {{ rec.titre }}</h4>
          <p>{{ rec.texte }}</p>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.container { max-width: 900px; margin: 0 auto; padding: 40px 20px; font-family: 'Courier New', Courier, monospace; color: #0a0f0d; }
.action-bar { display: flex; justify-content: flex-end; margin-bottom: 20px; }
.btn-pdf { background: #050a07; color: #00ff66; border: 1px solid #00ff66; padding: 12px 24px; border-radius: 2px; cursor: pointer; font-weight: 600; font-size: 0.95rem; text-transform: uppercase; letter-spacing: 1px; transition: all 0.2s; }
.btn-pdf:hover { background: #00ff66; color: #0a0f0d; box-shadow: 0 0 10px rgba(0, 255, 102, 0.4); }

.report-header { position: relative; margin-bottom: 20px; }
.badge-risque { position: absolute; top: 0; right: 0; color: #fff; padding: 6px 14px; font-weight: 700; border-radius: 2px; text-transform: uppercase; font-size: 0.85rem; }
h1 { font-size: 2rem; margin: 0 0 5px 0; font-weight: 800; color: #00ff66; text-shadow: 0 0 5px rgba(0, 255, 102, 0.2); text-transform: uppercase; letter-spacing: 1px; }
.date { color: #22aa55; margin: 0; font-size: 0.9rem; text-transform: uppercase; }
hr { border: 0; border-top: 2px solid #00ff66; margin: 25px 0; }

h2 { font-size: 1.3rem; border-left: 4px solid #00ff66; padding-left: 10px; margin-bottom: 20px; color: #0a0f0d; text-transform: uppercase; letter-spacing: 1px; }
.report-section { margin-bottom: 40px; }

.grid-info { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; background: #f5fbf7; padding: 20px; border-radius: 2px; border: 1px solid #114422; box-shadow: 3px 3px 0px rgba(17, 68, 34, 0.1); }
.full-width { grid-column: 1 / -1; }

.risk-summary-box { display: flex; align-items: center; gap: 30px; background: #f5fbf7; padding: 25px; border-radius: 2px; border: 2px solid #00ff66; box-shadow: 4px 4px 0px rgba(0, 255, 102, 0.1); }
.score-circle { display: flex; flex-direction: column; align-items: center; justify-content: center; width: 90px; height: 90px; border: 4px solid #114422; border-radius: 50%; background: #fff; }
.score-num { font-size: 1.8rem; font-weight: 800; line-height: 1; color: #0a0f0d; }
.score-max { font-size: 0.75rem; color: #22aa55; font-weight: 600; }
.risk-text { flex: 1; }
.risk-text p { margin: 0 0 8px 0; font-size: 1.05rem; font-weight: 600; text-transform: uppercase; }
.risk-text .small-desc { margin: 0; font-size: 0.85rem; color: #114422; line-height: 1.4; }

.report-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
.report-table th { background: #051a0d; color: #00ff66; text-align: left; padding: 12px; font-size: 0.9rem; text-transform: uppercase; border-bottom: 2px solid #00ff66; }
.report-table td { padding: 12px; border-bottom: 1px solid #114422; font-size: 0.95rem; }
.font-bold { font-weight: 700; }
.text-center { text-align: center; }
.empty { color: #2e7d32; font-style: italic; background: #e8f5e9; border: 1px solid #2e7d32; text-transform: uppercase; }

.recs-list { display: flex; flex-direction: column; gap: 15px; }
.rec-card { background: #ffffff; border: 1px solid #114422; border-left: 5px solid #00ff66; padding: 15px 20px; border-radius: 0 2px 2px 0; box-shadow: 3px 3px 0px rgba(17, 68, 34, 0.05); }
.rec-card h4 { margin: 0 0 6px 0; font-size: 1rem; color: #0a0f0d; text-transform: uppercase; letter-spacing: 0.5px; }
.rec-card p { margin: 0; font-size: 0.9rem; color: #0a0f0d; line-height: 1.4; }

@media print {
  nav, .no-print, .action-bar, header:not(.report-header) {
    display: none !important;
  }
  
  body, .container {
    padding: 0 !important;
    margin: 0 !important;
    max-width: 100% !important;
    background: #fff !important;
    color: #000 !important;
    font-family: 'Courier New', Courier, monospace !important;
  }

  .grid-info, .risk-summary-box, .rec-card {
    background: #fff !important;
    border: 1px solid #000 !important;
    box-shadow: none !important;
  }

  h1, .badge-risque {
    color: #000 !important;
    text-shadow: none !important;
  }

  .report-table th {
    background: #000 !important;
    color: #fff !important;
    border-bottom: 1px solid #000 !important;
  }

  .report-table td {
    border-bottom: 1px solid #000 !important;
  }

  .page-break {
    page-break-before: always; 
  }
}
</style>