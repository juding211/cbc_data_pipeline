# CBC Data Pipeline

## Pourquoi ce projet? / Why I built this?

Je n'avais jamais vu de données d'analyses sanguines en dehors 
de mes propres bilans médicaux. Pour le KPI, j'ai choisi l'anémie — 
pas parce que j'y connaissais quelque chose, mais parce que c'était 
la seule pathologie que je connaissais de nom. Le reste, c'était 
beaucoup de recherches pour comprendre ce que WBC et MCV signifient vraiment.


*I had never seen blood test data outside of my own medical checkups.

When I had to pick a KPI, I went with anemia — not because I'm an 
expert, but because it was the one condition I'd actually heard of. 
Turns out it's also the only one you can directly confirm from CBC 
values alone, so it worked out.

The rest was a lot of googling what WBC and MCV actually mean.*

---

## Sources de données / Data Sources

J'ai utilisé deux jeux de données Kaggle représentant deux automates différents :

- **CBC Test Dataset** — 500 patients, 21 indicateurs CBC  
  → [Kaggle](https://www.kaggle.com/datasets/ahmedelsayedtaha/complete-blood-count-cbc-test)

- **MIMIC-III Hematology** — 100 patients en USI, 1445 mesures, 13 indicateurs CBC  
  → [Kaggle](https://www.kaggle.com/datasets/ashlingovindasamy/hematology-complete-blood-count-dataset-mimic-iii)

Les deux sources utilisent des conventions de nommage différentes, ce qui m'a permis de simuler une problématique réelle de normalisation multi-sources.

*Both sources use different column naming conventions, allowing me to simulate a real multi-source normalization challenge.*

---

## Stack technique / Tech Stack

| Outil | Rôle |
|---|---|
| Python (pandas) | Nettoyage et standardisation des données |
| MySQL | Conception du schéma et requêtes KPI |
| R | Analyse statistique *(en cours)* |
| Power BI | Visualisation *(en cours)* |
| GitHub | Versioning et documentation |

---

## Pipeline
Kaggle API
↓
Collecte des données brutes (2 sources)
↓
Nettoyage (valeurs manquantes, doublons)
↓
Standardisation des noms de colonnes
↓
Chargement dans MySQL (4 tables normalisées)
↓
Requêtes KPI
↓
Visualisation Power BI (en cours)

---

## Décisions de nettoyage / Cleaning Decisions

- Colonnes avec **>90% de valeurs manquantes** supprimées  
  *(Note : ce seuil peut exclure des données structurellement manquantes — NMAR)*
- Colonne **Hemoglobin** dupliquée dans MIMIC-III : version avec 0% de manquants conservée
- Colonnes communes aux deux sources standardisées ; indicateurs spécifiques à chaque source conservés tels quels

---

## Schéma de base de données / Database Schema

4 tables dans la base `cbc_pipeline` :

- **data_a** — patients CBC généraux (500 lignes)
- **patient** — informations patients MIMIC-III (100 lignes)
- **cbc_results** — mesures CBC MIMIC-III (1445 lignes)
- **diagnosis** — diagnostics par visite (1445 lignes)

---

## KPI

**KPI 1 — Top 10 diagnostics les plus fréquents**  
Identification des pathologies les plus représentées dans le dataset MIMIC-III.

**KPI 2 — Indicateurs CBC chez les patients anémiques**  
L'anémie est la seule pathologie directement mesurable par CBC (Hemoglobin, RBC, Hematocrit, MCV, MCHC, RDW). Les 17 patients diagnostiqués "Anemia NOS" présentent des valeurs d'hémoglobine entre 7.98 et 12.53 g/dL, en dessous du seuil normal, ce qui valide la cohérence clinique des données.

---

## Gouvernance des données / Data Governance

- Données anonymisées à la source (MIMIC-III : dates décalées pour protection des patients)
- Fichiers sensibles exclus du versioning via `.gitignore`
- Critères de nettoyage documentés

*See `docs/data_governance.md` for details.*
