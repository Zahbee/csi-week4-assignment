SELECT
  H.hacker_id,
  H.name
FROM Hackers AS H
JOIN (
  SELECT
    S.hacker_id,
    COUNT(DISTINCT C.challenge_id) AS full_score_challenges_count
  FROM Submissions AS S
  JOIN Challenges AS C
    ON S.challenge_id = C.challenge_id
  JOIN Difficulty AS D
    ON C.difficulty_level = D.difficulty_level
  WHERE
    S.score = D.score
  GROUP BY
    S.hacker_id
  HAVING
    COUNT(DISTINCT C.challenge_id) > 1
) AS FullScoreHackers
  ON H.hacker_id = FullScoreHackers.hacker_id
ORDER BY
  FullScoreHackers.full_score_challenges_count DESC,
  H.hacker_id ASC;
