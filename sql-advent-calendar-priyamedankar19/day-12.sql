-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH CTE1 AS (
  SELECT user_id, user_name, COUNT(*) AS msg_count, DATE(sent_at) AS msg_day
  FROM npn_users JOIN npn_messages ON user_id = sender_id
  GROUP BY user_id, user_name, DATE(sent_at)
),
CTE2 AS (
  SELECT user_id, user_name, RANK() OVER(PARTITION BY msg_day ORDER BY msg_count DESC) AS ranked_users
  FROM CTE1
)
SELECT user_id, user_name FROM CTE2
WHERE ranked_users = 1
