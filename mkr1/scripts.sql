-- Агенти ТА естрадні артисти, які мають однаковий індекс
SELECT a1.name AS agent_name, a2.name AS artist_name, a1.post_index
FROM Agency_member a1
    INNER JOIN Agency_member a2 ON a1.post_index = a2.post_index
WHERE a1.type = 'agent'
  AND a2.type = 'artist'
ORDER BY a1.post_index;

-- Витягуємо поштові індекси, які повторюються і в артистів і в агентів
SELECT  post_index
FROM Agency_member
WHERE type = 'agent'

INTERSECT

SELECT  post_index
FROM Agency_member
WHERE type = 'artist';


-- Агенти ТА естрадні артисти, які мають однаковий індекс з використанням IN
SELECT a1.name AS agent_name, a1.post_index
FROM Agency_member a1
WHERE a1.type = 'agent'
  AND a1.post_index IN (
    SELECT a2.post_index
    FROM Agency_member a2
    WHERE a2.type = 'artist'
)
ORDER BY a1.post_index;
