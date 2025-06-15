SELECT
  H.hacker_id,
  H.name,
  SUM(MaxScores.max_score_per_challenge) AS total_score
FROM Hackers AS H
JOIN (
  SELECT
    S.hacker_id,
    S.challenge_id,
    MAX(S.score) AS max_score_per_challenge
  FROM Submissions AS S
  GROUP BY
    S.hacker_id,
    S.challenge_id
) AS MaxScores
  ON H.hacker_id = MaxScores.hacker_id
GROUP BY
  H.hacker_id,
  H.name
HAVING
  total_score > 0
ORDER BY
  total_score DESC,
  H.hacker_id ASC;
