# Architecture Overview

**Layers**
- **Bronze:** raw, source-mirrored tables.
- **Silver:** cleaned/typed/standardized (addresses, opening hours, relevance).
- **Gold:** analytics-ready dims/facts (deduped businesses, geospatial features, review aggregates).

## ERD (ASCII)
\\\
[bronze_businesses] 1 -- * [bronze_locations]
[bronze_businesses] 1 -- * [bronze_opening_hours]
[bronze_businesses] 1 -- * [bronze_reviews]
[bronze_search_results] (standalone in Bronze)
\\\

## ERD (Mermaid)
\\\mermaid
erDiagram
  bronze_businesses ||--o{ bronze_locations : has
  bronze_businesses ||--o{ bronze_opening_hours : has
  bronze_businesses ||--o{ bronze_reviews : has
\\\
"@

# .gitignore
Set-Content -Path .gitignore -Value @"
# OS
.DS_Store

# DBeaver
.dbeaver/
*.dbeaver-data-sources.xml

# Python
venv/
__pycache__/
*.pyc
.ipynb_checkpoints/
