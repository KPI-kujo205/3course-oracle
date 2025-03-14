-- INNER JOIN
SELECT c.name AS client_name, r.name AS region_name
FROM clients c
INNER JOIN regions r ON c.region_id = r.id;

-- LEFT JOIN
SELECT i.name AS item_name, s.name AS supplier_name
FROM items i
LEFT OUTER JOIN suppliers s ON i.supplier_id = s.id;

-- RIGHT OUTER JOIN
SELECT c.name AS category_name, i.name AS item_name
FROM categories c
RIGHT OUTER JOIN item_categories ic ON c.id = ic.category_id
RIGHT OUTER JOIN items i ON ic.item_id = i.id;

-- FULL OUTER JOIN
SELECT c.name AS client_name, o.id AS order_id
FROM clients c
FULL OUTER JOIN orders o ON c.id = o.client_id;


-- CROSS JOIN
SELECT c.name AS client_name, s.name AS supplier_name
FROM clients c
CROSS JOIN suppliers s;

-- INNER JOIN
SELECT c1.name AS client1_name, c2.name AS client2_name, r.name AS region_name
FROM clients c1
INNER JOIN clients c2 ON c1.region_id = c2.region_id AND c1.id != c2.id
INNER JOIN regions r ON c1.region_id = r.id;
