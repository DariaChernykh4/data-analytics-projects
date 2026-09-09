# Data Analytics Portfolio

A collection of coursework and self-directed projects demonstrating SQL, Python, and Tableau skills - spanning data cleaning, statistical analysis, A/B testing, classification, customer segmentation, and interactive dashboard design.

---

## Portfolio Projects

Two end-to-end projects combining SQL (BigQuery), Python, and Tableau - from raw data extraction to a published interactive dashboard.

| Project | Description | Links |
|---|---|---|
| **[E-Commerce Sales & Traffic Analytics](portfolio-projects/ecommerce-sales-traffic)** | Sales analytics for a furniture e-commerce store: $31.97M revenue, 33,538 orders across 108 countries. Statistical testing (Kruskal-Wallis) on order value by device and subscription status. | [Notebook](portfolio-projects/ecommerce-sales-traffic/ecommerce_sales_traffic.ipynb) · [Tableau Public](https://public.tableau.com/views/E-commerceSalesTrafficAnalytics/SalesPerformance?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) |
| **[A/B Testing Framework](portfolio-projects/ab-testing-framework)** | Statistical significance analysis (two-proportion z-test) for 4 conversion metrics across 4 A/B tests, broken down by country, device, channel, and continent - implemented as reusable functions, not hardcoded per metric. | [Notebook](portfolio-projects/ab-testing-framework/ab_testing.ipynb) · [Tableau Public](https://public.tableau.com/views/ABTesting_17716044091480/StatSignificance?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) |

---

## SQL Project

Four standalone BigQuery exercises covering multi-CTE aggregation with ranking, cross-table joins with percentage-of-total math, and pure window-function aggregation (with and without persisted views).

| Query | Description |
|---|---|
| **[User Acquisition & Email Engagement](sql-projects/01_user_acquisition_email_engagement.sql)** | Ranks countries by account volume and email send volume independently via `UNION ALL` + `DENSE_RANK()`, surfacing where the two rankings diverge. [Looker Studio dashboard](https://datastudio.google.com/u/0/reporting/2c6cf524-3613-4674-8228-37b69341aa2a/page/tEnnC) |
| **[Revenue by Device and Continent with Sessions](sql-projects/02_revenue_by_device_continent.sql)** | Per-continent revenue (total, mobile, desktop, % of total) joined with account/session counts |
| **[Emails Sent by Month](sql-projects/03_emails_sent_by_month_window_functions.sql)** | % of monthly email volume per account plus first/last send date - window functions only, no `GROUP BY` |
| **[Aggregation Data with View](sql-projects/04_aggregation_with_view.sql)** | Same logic as above, persisted as two chained BigQuery views |

---

## Python Projects

Four standalone Python analyses spanning EDA, experimentation, classification, and customer analytics.

| Project | Description | Links |
|---|---|---|
| **[Global Sales & Logistics Analysis](python-projects/global-sales-logistics-analysis)** | End-to-end EDA on a global retail dataset - data cleaning, outlier detection (3×IQR), feature engineering (revenue/profit/margin), and analysis across category, geography, channel, logistics, and seasonality, with a final Business Intelligence Report. | [Notebook](python-projects/global-sales-logistics-analysis/global_sales_logistics_analysis.ipynb) |
| **[A/B Test: Credit Reminder in Onboarding](python-projects/ab-test-reminder-feature)** | Full-cycle A/B test case study - sample size/power calculation, two-proportion z-test, SRM check, guardrail metrics, cohort analysis, and a data quality investigation (leakage, timeline anomalies), ending in a rollout recommendation. | [Notebook](python-projects/ab-test-reminder-feature/AB_test_analysis.ipynb) · [Report (PDF)](python-projects/ab-test-reminder-feature/AB_test_analysis.pdf) |
| **[Credit Scoring: Logistic Regression](python-projects/credit-scoring)** | Credit card approval model with business-driven metric selection (specificity over accuracy given class imbalance and cost asymmetry) and hyperparameter tuning (penalty, C) optimized for that metric. | [Notebook](python-projects/credit-scoring/credit-scoring.ipynb) |
| **[RFM Customer Segmentation](python-projects/rfm-segmentation)** | SQL + Python segmentation of email subscribers by Recency/Frequency/Monetary into Top/Middle/Lost segments, with per-segment engagement recommendations. | [Notebook](python-projects/rfm-segmentation/rfm_segmentation.ipynb) |

---

## Tableau Projects

Five standalone Tableau dashboards, each covering a different domain and chart vocabulary:

| Dashboard | Focus |
|---|---|
| **[Netflix Movies & TV Series](https://public.tableau.com/views/NetflixMoviesTVSeries/Dashboard2?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)** | 8,204 titles across 84 countries, content type mix, top genres, release trends |
| **[Sales Analytics](https://public.tableau.com/views/SalesAnalytics_17684215221180/Sales?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)** | Filterable revenue/orders/AOV KPIs, category breakdown, geographic and device distribution |
| **[Email Campaign Analytics](https://public.tableau.com/views/EmailMetrics_17684914175520/EmailMetrics?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)** | Open/click/CTOR rates, engagement trends over time, performance by country |
| **[User Session Analytics](https://public.tableau.com/views/SessionAnalytics_17683038907660/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)** | Session volume by browser/channel, geographic distribution, top countries |
| **[Period Comparison Analytics](https://public.tableau.com/views/DynamicDashboard_17685799735530/DynamicDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)** | Before/after comparison of two custom periods - revenue, ROI, CPA, RPC, funnel rates |

*(See [`tableau-projects/README.md`](tableau-projects/README.md) for direct links.)*

---

## Tech Stack

- **SQL** - Google BigQuery (CTEs, window functions, multi-table joins, views)
- **Python** - pandas, numpy, scipy, statsmodels, scikit-learn, matplotlib, seaborn
- **Tableau Public** - interactive dashboards
- **Looker Studio** - interactive dashboard
- **Google Sheets** - pivot tables, formulas, and ABC analysis

## Additional Practice

**[LeetCode Solutions](https://github.com/DariaChernykh4/leetcode-solutions)** - 20 solved SQL problems (Easy/Medium/Hard), covering joins, window functions, self-joins, and ranking - kept as a separate repo since it's ongoing practice rather than a portfolio case study.

## Author

Daria Chernykh
