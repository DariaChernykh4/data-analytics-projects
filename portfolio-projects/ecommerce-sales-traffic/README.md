# E-Commerce Sales & Traffic Analytics

Comprehensive sales analytics report for an e-commerce furniture store, built using SQL, Python, and Tableau. The analysis explores customer behavior, revenue dynamics, and business performance across geography, product categories, traffic channels, and user segments to derive actionable business insights.

**[View Interactive Dashboard (Tableau Public)](https://public.tableau.com/views/E-commerceSalesTrafficAnalytics/SalesPerformance?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

## Dataset

Extracted from Google BigQuery (DA dataset), covering **91 days of sales activity** (Nov 1, 2020 - Jan 31, 2021). Session-level data joined across 6 tables: sessions, session parameters, accounts, orders, and products.

## Tools Used

- **SQL + Google BigQuery** - data extraction and table joins
- **Python** (pandas, matplotlib, seaborn, scipy) - data cleaning, exploratory analysis, statistical testing
- **Tableau Public** - interactive dashboard

## Statistical Tests

All tests use a two-sided alternative hypothesis (α = 0.05):

| Test | Method | Question | p-value | Result |
|---|---|---|---|---|
| Registered vs Guest order value | Mann-Whitney U | Do registered and guest users spend differently? | < 0.05 | **Significant**, but not practically meaningful - guests spend $26.90 more on average ($955 vs $929) |
| Daily sessions by traffic channel | Kruskal-Wallis | Do session counts differ across channels? | < 0.05 | **Significant** - Organic Search leads with 1,352 sessions/day |
| Organic traffic share: Europe vs Americas | Chi-square | Does organic share differ by continent? | 0.776 | **Not significant** - 35.6% vs 35.5%, virtually identical |
| Subscribed vs Unsubscribed order value | Mann-Whitney U | Does subscription status affect spend? | 0.168 | **Not significant** |
| Order value by device type | Kruskal-Wallis | Does device type affect order value? | 0.123 | **Not significant** |

**Correlations (Pearson):**
- Daily sessions vs daily revenue: **r = 0.931** (very strong) - revenue growth is driven primarily by traffic volume, not average order value
- Revenue across continents: r ≈ 0.67-0.69 (moderate, all significant) - all continents follow the same seasonal pattern
- Revenue across traffic channels: strongest pair is Organic Search vs Paid Search (r = 0.808)
- Revenue across top 5 categories: r = 0.51-0.67 - customers tend to browse and buy across multiple furniture categories at once

## Key Insights

**Revenue & Growth**
- **$31.97M** in revenue from **33,538 orders** across **108 countries** in 91 days
- December 2020 was the strongest month ($12.4M), 28% higher than November and January, driven by holiday shopping
- Revenue is strongly driven by traffic volume (r = 0.931) rather than changes in average order value

**Geography**
- Americas generate **55.25%** of revenue, with the US alone accounting for **43.61%** - a more extreme concentration than the classic 80/20 Pareto rule (13.9% of countries = 80% of revenue)
- India and Canada are strong secondary markets with growth potential

**Products**
- Top 3 categories (Sofas & armchairs, Chairs, Beds) account for **60.86%** of all revenue
- Category preferences are consistent across all countries and devices - no regional or device-specific product trends

**Users & Conversion**
- Only **9.59%** of sessions result in a purchase
- Registered users convert at nearly the same rate as guests (9.95% vs 9.56%) - registration provides no measurable lift
- **83%** of registered users remain subscribed to the mailing list, but subscription status does not significantly affect order value

**Traffic & Devices**
- **Organic Search** is the top channel (35.76% of revenue, 1,352 sessions/day)
- **Desktop dominates** with 59% of sales despite mobile representing 38.73% - consistent with high-consideration furniture purchases
- All channels and devices peaked simultaneously in mid-December, confirming a store-wide seasonal event

## Business Recommendations

1. **Reduce geographic concentration risk** - invest in localized marketing for India and Canada, which already show strong organic demand
2. **Improve conversion rate** - at 9.59%, test checkout flow simplification, exit-intent popups, and abandoned cart recovery emails
3. **Add registration incentives** - registered users convert only 0.39% higher than guests; introduce loyalty points or exclusive discounts
4. **Capitalize on the December peak** - start promotions earlier (late November) and extend into January
5. **Invest further in organic search / SEO** - the #1 revenue channel at 35.76%
6. **Fix UTM tracking** - 6.26% of revenue comes from Undefined traffic, likely missing UTM parameters
7. **Improve mobile experience** - mobile already drives 38.73% of sales; UX investment here can capture more conversions

## Repository Contents

- SQL queries for data extraction from BigQuery
- Python/Jupyter notebook with EDA, visualizations, and statistical testing
- Tableau Public interactive dashboard:
![Sales Performance](portfolio-projects/ecommerce-sales-traffic/e-commerce_sales_performance.png)
![Traffic & Sessions](portfolio-projects/ecommerce-sales-traffic/e-commerce_traffic&sessions.png)
