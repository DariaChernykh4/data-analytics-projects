# Data Analytics Portfolio

A collection of coursework projects demonstrating SQL, Python, and Tableau skills - built as part of a data analytics course portfolio, spanning data cleaning, statistical analysis, and interactive dashboard design.

---

## Portfolio Projects

Two end-to-end projects combining SQL (BigQuery), Python, and Tableau - from raw data extraction to a published interactive dashboard.

| Project | Description | Links |
|---|---|---|
| **[E-Commerce Sales & Traffic Analytics](portfolio-projects/ecommerce-sales-traffic)** | Sales analytics for a furniture e-commerce store: $31.97M revenue, 33,538 orders across 108 countries. Statistical testing (Kruskal-Wallis) on order value by device and subscription status. | [Notebook](portfolio-projects/ecommerce-sales-traffic/E_Commerce_Sales_%26_Traffic.ipynb) · [Tableau Public](https://public.tableau.com/views/E-commerceSalesTrafficAnalytics/SalesPerformance?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) |
| **[A/B Testing Framework](portfolio-projects/ab-testing-framework)** | Statistical significance analysis (two-proportion z-test) for 4 conversion metrics across 4 A/B tests, broken down by country, device, channel, and continent - implemented as reusable functions, not hardcoded per metric. | [Notebook](portfolio-projects/ab-testing-framework/A_B_Testing.ipynb) · [Tableau Public](https://public.tableau.com/views/ABTesting_17716044091480/StatSignificance?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) |

---

## SQL Project

**[Top Countries by Account Registration & Email Engagement](sql-project)**

A BigQuery query joining account, session, and email event data to rank countries by account volume and email send volume independently - surfacing where the two rankings diverge (e.g. Singapore's disproportionately high emails-per-account ratio).

- [SQL query](sql-project/top_countries_email_engagement.sql)
- [Findings & interpretation](sql-project/findings.md)
- [Looker Studio dashboard](https://lookerstudio.google.com/reporting/2c6cf524-3613-4674-8228-37b69341aa2a)

---

## Python Project

**[Global Sales & Logistics Analysis](python-project)**

End-to-end EDA on a global retail dataset (events, products, countries) - data cleaning with documented missing-value strategy, outlier detection (3×IQR), feature engineering (revenue/profit/margin), and analysis across product category, geography, sales channel, shipping logistics, and seasonality. Includes a final Business Intelligence Report synthesizing findings.

- [Notebook](python-project/Global_Sales_Logistics_Analysis.ipynb)

---

## Tableau Projects

Three standalone Tableau dashboards, each covering a different domain and chart vocabulary:

| Dashboard | Focus |
|---|---|
| **[Email Campaign Analytics](https://public.tableau.com/app/profile/.66217699/viz/EmailMetrics)** | Open/click/CTOR rates, engagement trends over time, performance by country |
| **[Session Analytics](https://public.tableau.com/app/profile/.66217699/viz/SessionAnalytics)** | Session volume by browser/channel, geographic distribution, top countries |
| **[Netflix Movies & TV Series](https://public.tableau.com/app/profile/.66217699/viz/NetflixMoviesTVSeries)** | Content duration and country distribution for a public streaming-catalog dataset |

*(See [`tableau-projects/README.md`](tableau-projects/README.md) for direct links.)*

---

## Tech Stack

- **SQL** - Google BigQuery (CTEs, window functions, multi-table joins)
- **Python** - pandas, numpy, scipy, statsmodels, matplotlib, seaborn
- **Tableau** / **Looker Studio** - interactive dashboards

## Author

Daria Chernykh
