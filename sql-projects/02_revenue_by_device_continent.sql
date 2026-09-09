-- Revenue by Device and Continent with Sessions
-- Output columns: Continent, Revenue, Revenue from Mobile, Revenue from Desktop,
-- % Revenue from Total, Account Count, Verified Account, Session Count
 
WITH revenue_usd AS (
    SELECT
      sp.continent,
      ROUND(SUM(p.price)) AS revenue,
      ROUND(SUM(CASE WHEN device = 'mobile' THEN p.price END)) AS revenue_from_mobile,
      ROUND(SUM(CASE WHEN device = 'desktop' THEN p.price END)) AS revenue_from_desktop
    FROM `DA.order` o
    JOIN `DA.product` p
      ON o.item_id = p.item_id
    JOIN `DA.session_params` sp
      ON o.ga_session_id = sp.ga_session_id
    GROUP BY sp.continent
  ),
 
  total AS (
    SELECT
      continent,
      revenue,
      SUM(revenue) OVER () AS total_revenue
    FROM revenue_usd
  ),
 
  registrations AS (
    SELECT
      sp.continent,
      COUNT(DISTINCT acs.account_id) AS account_count,
      COUNT(sp.ga_session_id) AS session_count,
      COUNT(DISTINCT CASE WHEN ac.is_verified = 1 THEN ac.id END) AS verified_account
    FROM `DA.session_params` sp
    LEFT JOIN `DA.account_session` acs
      ON sp.ga_session_id = acs.ga_session_id
    LEFT JOIN `DA.account` ac
      ON acs.account_id = ac.id
    GROUP BY sp.continent
  )
 
SELECT
  revenue_usd.continent,
  revenue,
  revenue_from_mobile,
  revenue_from_desktop,
  ROUND(revenue / total_revenue * 100) AS revenue_from_total_percent,
  account_count,
  verified_account,
  session_count
FROM revenue_usd
JOIN total
  ON revenue_usd.continent = total.continent
LEFT JOIN registrations
  ON revenue_usd.continent = registrations.continent
WHERE NOT revenue_usd.continent = '(not set)';
