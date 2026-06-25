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
.container { max-width: 900px; margin: 0 auto; padding: 40px 20px; font-family: system-ui, sans-serif; color: #212529; }
.action-bar { display: flex; justify-content: flex-end; margin-bottom: 20px; }
.btn-pdf { background: #212529; color: #fff; border: none; padding: 12px 24px; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 0.95rem; }
.btn-pdf:hover { background: #495057; }

.report-header { position: relative; margin-bottom: 20px; }
.badge-risque { position: absolute; top: 0; right: 0; color: #fff; padding: 6px 14px; font-weight: 700; border-radius: 4px; text-transform: uppercase; font-size: 0.85rem; }
h1 { font-size: 2rem; margin: 0 0 5px 0; font-weight: 800; color: #1a1d20; }
.date { color: #6c757d; margin: 0; font-size: 0.9rem; }
hr { border: 0; border-top: 2px solid #dee2e6; margin: 25px 0; }

h2 { font-size: 1.3rem; border-left: 4px solid #212529; padding-left: 10px; margin-bottom: 20px; color: #1a1d20; }
.report-section { margin-bottom: 40px; }

.grid-info { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; background: #f8f9fa; padding: 20px; border-radius: 8px; border: 1px solid #e9ecef; }
.full-width { grid-column: 1 / -1; }

.risk-summary-box { display: flex; align-items: center; gap: 30px; background: #f8f9fa; padding: 25px; border-radius: 8px; border: 1px solid #e9ecef; }
.score-circle { display: flex; flex-direction: column; align-items: center; justify-content: center; width: 90px; height: 90px; border: 6px solid #ced4da; border-radius: 50%; background: #fff; }
.score-num { font-size: 1.8rem; font-weight: 800; line-height: 1; color: #1a1d20; }
.score-max { font-size: 0.75rem; color: #6c757d; font-weight: 600; }
.risk-text { flex: 1; }
.risk-text p { margin: 0 0 8px 0; font-size: 1.05rem; }
.risk-text .small-desc { margin: 0; font-size: 0.85rem; color: #6c757d; line-height: 1.4; }

.report-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
.report-table th { background: #212529; color: #fff; text-align: left; padding: 12px; font-size: 0.9rem; }
.report-table td { padding: 12px; border-bottom: 1px solid #dee2e6; font-size: 0.95rem; }
.font-bold { font-weight: 700; }
.text-center { text-align: center; }
.empty { color: #2e7d32; font-style: italic; background: #e8f5e9; }

.recs-list { display: flex; flex-direction: column; gap: 15px; }
.rec-card { background: #ffffff; border: 1px solid #dee2e6; border-left: 5px solid #4477ce; padding: 15px 20px; border-radius: 0 8px 8px 0; }
.rec-card h4 { margin: 0 0 6px 0; font-size: 1rem; color: #1a1d20; }
.rec-card p { margin: 0; font-size: 0.9rem; color: #495057; line-height: 1.4; }

@media print {
  nav, .no-print, .action-bar, header:not(.report-header) {
    display: none !important;
  }
  
  body, .container {
    padding: 0 !important;
    margin: 0 !important;
    max-width: 100% !important;
    background: #fff !important;
  }

  .grid-info, .risk-summary-box, .rec-card {
    background: #fff !important;
    border: 1px solid #000 !important;
  }

  .page-break {
    page-break-before: always; 
  }
}
</style>