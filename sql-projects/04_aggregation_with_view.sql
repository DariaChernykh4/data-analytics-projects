-- Aggregation Data with View
-- Same result as 03_emails_sent_by_month_window_functions.sql, but persisted
-- as two chained views so the logic is reusable without re-running window
-- functions from scratch each time.
 
-- VIEW 1: base date/session join
CREATE VIEW `Students.v_Chernykh_date_sent` AS
SELECT
  es.id_account,
  s.date,
  es.sent_date,
  es.id_message,
  DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS sent_date_new,
  DATE_TRUNC(DATE_ADD(s.date, INTERVAL es.sent_date DAY), MONTH) AS sent_month
FROM `DA.session` s
JOIN `DA.account_session` acs
  ON s.ga_session_id = acs.ga_session_id
JOIN `DA.email_sent` es
  ON acs.account_id = es.id_account;
 
-- VIEW 2: window-function aggregation on top of view 1
CREATE VIEW `Students.v_Chernykh_sent_msg_info` AS
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
FROM `Students.v_Chernykh_date_sent` AS date_sent;
 
-- MAIN QUERY: collapse to one row per account per month
SELECT
  DISTINCT sent_month,
  id_account,
  sent_msg_percent_from_this_month,
  first_sent_date,
  last_sent_date
FROM `Students.v_Chernykh_sent_msg_info`;
