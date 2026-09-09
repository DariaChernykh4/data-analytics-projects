-- Emails Sent by Month (window functions only, no GROUP BY)
-- 1. % of emails sent to each account within a month, out of all emails sent that month
-- 2. First and last send date per account per month
 
SELECT
  DISTINCT sent_month,
  id_account,
  sent_msg_percent_from_this_month,
  first_sent_date,
  last_sent_date
FROM
(
  SELECT
    sent_month,
    id_account,
    id_message,
    sent_date_new,
    COUNT(id_message) OVER (PARTITION BY id_account, sent_month)
      / COUNT(id_message) OVER (PARTITION BY sent_month) * 100
      AS sent_msg_percent_from_this_month,
    MIN(sent_date_new) OVER (PARTITION BY id_account, sent_month) AS first_sent_date,
    MAX(sent_date_new) OVER (PARTITION BY id_account, sent_month) AS last_sent_date
  FROM
  (
    SELECT
      es.id_account,
      s.date,
      es.sent_date,
      es.id_message,
      DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS sent_date_new,
      DATE(
        EXTRACT(YEAR FROM DATE_ADD(s.date, INTERVAL es.sent_date DAY)),
        EXTRACT(MONTH FROM DATE_ADD(s.date, INTERVAL es.sent_date DAY)),
        1
      ) AS sent_month
    FROM `DA.session` s
    JOIN `DA.account_session` acs
      ON s.ga_session_id = acs.ga_session_id
    JOIN `DA.email_sent` es
      ON acs.account_id = es.id_account
  ) date_sent
) sent_msg_info;
