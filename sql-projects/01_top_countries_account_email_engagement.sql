-- Top 10 Countries by Account Registration & Email Engagement
-- Combines account-level and email-level metrics via UNION ALL, then ranks
-- countries by two independent criteria (accounts created, emails sent)
-- and keeps only rows for countries that place top-10 in either ranking.

WITH
  -- основні метрики по акаунтам
  account_metrics AS (
    SELECT
      s.date,
      ac.send_interval,
      ac.is_verified,
      ac.is_unsubscribed,
      sp.country,
      COUNT(ac.id) AS account_cnt
    FROM `DA.account` ac
    JOIN `DA.account_session` acs
      ON ac.id = acs.account_id
    JOIN `DA.session` s
      ON acs.ga_session_id = s.ga_session_id
    JOIN `DA.session_params` sp
      ON s.ga_session_id = sp.ga_session_id
    GROUP BY
      s.date, ac.send_interval, ac.is_verified, ac.is_unsubscribed,
      sp.country
  ),

  -- основні метрики по емейлам
  email_metrics AS (
    SELECT
      sp.country,
      ac.send_interval,
      ac.is_verified,
      ac.is_unsubscribed,
      DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS sent_date,
      COUNT(DISTINCT es.id_message) AS sent_msg,
      COUNT(DISTINCT eo.id_message) AS open_msg,
      COUNT(DISTINCT ev.id_message) AS visit_msg
    FROM `DA.email_sent` es
    JOIN `DA.account` ac
      ON es.id_account = ac.id
    JOIN `DA.account_session` acs
      ON ac.id = acs.account_id
    JOIN `DA.session` s
      ON acs.ga_session_id = s.ga_session_id
    JOIN `DA.session_params` sp
      ON s.ga_session_id = sp.ga_session_id
    LEFT JOIN `DA.email_open` eo
      ON es.id_message = eo.id_message
    LEFT JOIN `DA.email_visit` ev
      ON es.id_message = ev.id_message
    GROUP BY
      sp.country, ac.send_interval, ac.is_verified, ac.is_unsubscribed,
      sent_date
  ),

  -- обʼєднуємо метрики за допомогою UNION
  union_data AS (
    SELECT
      date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      account_cnt,
      0 AS sent_msg,
      0 AS open_msg,
      0 AS visit_msg
    FROM account_metrics
    UNION ALL
    SELECT
      sent_date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      0 AS account_cnt,
      sent_msg,
      open_msg,
      visit_msg
    FROM email_metrics
  ),

  -- агрегуємо метрики для акаунтів і емейлів
  aggr_data AS (
    SELECT
      date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      SUM(account_cnt) AS account_cnt,
      SUM(sent_msg) AS sent_msg,
      SUM(open_msg) AS open_msg,
      SUM(visit_msg) AS visit_msg
    FROM union_data
    GROUP BY date, country, send_interval, is_verified, is_unsubscribed
  ),

  -- загальна кількість і рейтинг створених підписників і відправлених листів в цілому по країні
  total_data_by_country AS (
    SELECT
      *,
      DENSE_RANK()
        OVER (ORDER BY total_country_account_cnt DESC)
        AS rank_total_country_account_cnt,
      DENSE_RANK()
        OVER (ORDER BY total_country_sent_cnt DESC)
        AS rank_total_country_sent_cnt
    FROM
      (
        SELECT
          *,
          SUM(account_cnt)
            OVER (PARTITION BY country) AS total_country_account_cnt,
          SUM(sent_msg) OVER (PARTITION BY country) AS total_country_sent_cnt
        FROM aggr_data
      )
  )
SELECT
  date,
  country,
  send_interval,
  is_verified,
  is_unsubscribed,
  account_cnt,
  sent_msg,
  open_msg,
  visit_msg,
  total_country_account_cnt,
  total_country_sent_cnt,
  rank_total_country_account_cnt,
  rank_total_country_sent_cnt
FROM total_data_by_country
WHERE
  rank_total_country_account_cnt BETWEEN 1 AND 10
  OR rank_total_country_sent_cnt BETWEEN 1 AND 10
ORDER BY rank_total_country_account_cnt, rank_total_country_sent_cnt, date;

-- Visualization: https://lookerstudio.google.com/reporting/2c6cf524-3613-4674-8228-37b69341aa2a
