# Global Sales & Logistics Analysis

End-to-end exploratory data analysis of a global B2B trading company's sales operations, covering data cleaning, KPI calculation, and analysis across product category, geography, sales channel, and logistics - culminating in a full Business Intelligence Report with strategic recommendations.

**Complementary dashboard (Google Sheets):** [Global Sales & Operational Performance Dashboard (2010–2017)](https://docs.google.com/spreadsheets/d/1p9B08QEAdZ0xZxZwLlxchlRnZvdR0lO7X_ocXFI69uU/edit?usp=sharing) - the same dataset rebuilt as a pivot-table-driven Sheets dashboard for a business-user-friendly view alongside the deeper Python analysis below. It covers the same KPIs (1,248 orders, $1.6B revenue, 29.63% margin, 45 countries) plus a few things the Python notebook doesn't do:
- **ABC analysis** - product categories classified into A/B/C tiers by cumulative profit and revenue contribution (Cosmetics, Office Supplies, and Household alone make up ~61% of total profit)
- **An interactive choropleth world map** for country/region profit, with expandable region - sub-region - country drill-down
- Pivot-table breakdowns by category, country/region, sales channel, shipping delay, month/year, and weekday, each paired with charts

Both projects use the same three source tables (events/products/countries) but analyze them with different tool skillsets - Python/pandas for statistical depth (correlations, seasonality scoring, outlier detection) and Sheets for pivot tables, drill-downs, and mapping.

## Dataset

Three linked tables covering multi-year global sales:
- `events.csv` - individual sales transactions (order/ship dates, units sold, unit price/cost, sales channel, priority)
- `products.csv` - product category reference
- `countries.csv` - country, region, and sub-region reference (ISO codes)

## Tools Used

Python (pandas, matplotlib, seaborn) - data cleaning, KPI engineering, exploratory analysis, and visualization.

## Methodology

1. **Data cleaning** - documented missing-value strategy (dropped rows missing `country_code` or `units_sold`, ~6.3% combined, since neither can be reliably imputed), fixed known data-entry artifacts (Namibia's `NA` alpha-2 code read as null, missing Antarctica region), normalized categorical text fields, checked for duplicates and logical anomalies (e.g. ship date earlier than order date), and flagged outliers using the 3×IQR rule
2. **Feature engineering** - calculated `revenue`, `total_cost`, `profit`, and `profit_margin` per transaction
3. **Analysis** - sales by product category, geographic performance (region/sub-region/country), sales channel comparison, shipping logistics, shipping-speed-vs-profit correlation, time dynamics (yearly/quarterly/monthly), day-of-week patterns, and seasonality scoring
4. **Synthesis** - a final Business Intelligence Report tying every section together into prioritized strategic recommendations

## Key Insights

**Scale:** $1.59B total revenue, $473.7M profit (29.63% margin), 1,246 orders across 45 countries. The $1.28M average order value points to a B2B, bulk-transaction business rather than individual consumer sales.

**Product portfolio is highly imbalanced:** Office Supplies drives the most revenue ($378.7M) but only a 19.4% margin - most of that revenue is eaten by costs. Clothes, by contrast, is the most efficient category at a 67.2% margin. Cosmetics isn't the top earner but is the most profitable in absolute terms ($88.0M).

**Extreme geographic concentration - the single biggest structural risk:** Europe generates 94.7% of all profit; Asia contributes just 5.3%, and no other region is represented at all. The top 10 most profitable countries are small European markets (Andorra, Ukraine, Malta, San Marino) rather than major economies - a fragile, high-risk revenue base.

**Sales channels are balanced but flat:** Online (49.7%) and Offline (50.3%) split profit almost evenly, but order volume shows no growth from 2010–2017 (fluctuating 70–95 orders/year) - the business isn't acquiring new demand.

**Shipping speed barely matters for profit:** average shipping takes 23–27 days (Hungary worst at 32.6 days), but the correlation between shipping interval and profit is essentially zero (r = 0.0607). Slow shipping is an operational/customer-experience problem, not a profit driver.

**Time patterns:** 2012 was the peak year; profit and order volume have shown no stable growth since. Friday is the strongest day for profit (largely driven by Cosmetics); Household sales unexpectedly collapse on Tuesdays. Three categories (Clothes, Fruits, Baby Food) show real seasonality; the other nine are stable year-round.

## Strategic Recommendations

1. **Diversify geography** - near-total dependence on Europe (94.7% of profit) is a survival-level risk; prioritize expansion into the Americas, Africa, or broader Asia
2. **Rebalance the product portfolio** - shift marketing investment toward high-margin categories (Clothes, Cereal, Cosmetics) and address the cost structure behind low-margin, high-revenue categories (Office Supplies, Meat)
3. **Fix logistics in the slowest markets** - Eastern Europe and Hungary specifically need faster shipping partners, especially ahead of seasonal peaks (4-6 week inventory pre-positioning given the ~25-day shipping baseline)
4. **Invest in customer acquisition** - the channel mix is healthy, but flat order volume over 7 years means growth has to come from new demand, not channel shifting

## Repository Contents

- Python/Jupyter notebook - full EDA pipeline, from raw data to final BI report
- `data/` - source CSV files (events, products, countries)
