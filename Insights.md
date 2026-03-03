This document consolidates AI-assisted insights generated across SQL, Python, and Power BI layers of the AI-Assisted Dashboard for Safety Signal Monitoring project.
AI tools were used to assist in summarizing analytical findings and highlight observed trends. Final interpretation remained analyst-driven.

SQL Insights
- High Adverse Event Frequency: Certain drugs consistently showed higher counts of reported adverse events.
- Serious Adverse Events: Keywords such as death, hospitalization, life-threatening revealed a concentrated subset of drugs with serious safety concerns.
- Rx vs OTC Risk: Prescription-only (Rx) drugs demonstrated a higher volume of adverse event reporting compared to OTC drugs.
- Pregnancy Category Signals: Drugs in categories D and X showed elevated risk signals, aligning with regulatory expectations.
- Rating Correlation: Lower user ratings (<4) were associated with a higher frequency of serious adverse events.

Python Insights
- Data Integrity: Missing values were identified in key fields (side effects, ratings, pregnancy category).
- Column Cleaning: Unnamed and redundant columns were removed, reducing - dataset from 135 to 17 relevant fields.
- Seriousness Flag: A binary flag was engineered to identify adverse events containing critical terms (death, stroke, seizure).
- Rating Transformation: Ratings were standardized into numeric format for downstream SQL analysis.
- Prepared Dataset: A clean CSV (drug_safety_clean.csv) was generated for reproducible analysis.

Power BI Insights
- Dataset Composition: KPI cards highlighted total drugs, Rx vs OTC distribution.
- Adverse Effect Availability: Clustered column chart showed Rx drugs had more adverse effect reporting compared to OTC.
- User Ratings: Average ratings were lower for Rx drugs, suggesting perception of higher risk.
- Pregnancy Risk Distribution: Donut chart revealed significant representation in higher-risk categories (D, X).
- Interactive Exploration: Slicers enabled filtering by prescription type and pregnancy category for focused analysis.

Consolidated Observations
- Safety Signals: A small subset of drugs accounted for most serious adverse events.
- Regulatory Alignment: Pregnancy risk categories matched expected safety concerns.
- User Perception vs Clinical Risk: Lower ratings aligned with higher adverse event reporting, though ratings are perception-based.
- AI Role: AI tools assisted in summarizing patterns and drafting insights, but final interpretation remained analyst-driven.
