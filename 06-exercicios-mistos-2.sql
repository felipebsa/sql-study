-- 1. Nome e modelo dos clientes com veículos ativos (JOIN simples)
SELECT name, model
FROM clients
JOIN vehicles ON clients.client_id = vehicles.client_id;

-- 2. Quantidade de serviços por veículo (COUNT + GROUP BY)
SELECT vehicles.vehicle_id, COUNT(services.*)
FROM vehicles
JOIN services ON vehicles.vehicle_id = services.vehicle_id
GROUP BY vehicles.vehicle_id;

-- 3. Clientes expirados que têm pelo menos um veículo (WHERE + subquery IN)
SELECT name
FROM clients
WHERE expired = True AND client_id IN (
    SELECT client_id FROM vehicles
);

-- 4. Soma de todas as despesas de origem "Variável" (usando LIKE pra evitar problema de acento)
SELECT SUM(value)
FROM expenses
WHERE origin LIKE 'V%';

-- 5. Veículos que nunca tiveram nenhum serviço registrado (LEFT JOIN + IS NULL)
SELECT model, plate
FROM vehicles
LEFT JOIN services ON vehicles.vehicle_id = services.vehicle_id
WHERE services.vehicle_id IS NULL;

-- 6. Os 3 serviços mais caros de toda a tabela (ORDER BY + LIMIT)
SELECT title, value
FROM services
ORDER BY value DESC
LIMIT 3;

-- 7. Quantidade de serviços não finalizados por cliente
SELECT client_id, COUNT(*)
FROM services
WHERE finish = False
GROUP BY client_id;

-- 8. Nome do material mais caro (duas formas: LIMIT e subquery escalar com MAX)
SELECT name
FROM materials
ORDER BY value DESC
LIMIT 1;

SELECT name
FROM materials
WHERE value = (SELECT MAX(value) FROM materials);

-- 9. Nome, CPF e contagem de veículos por cliente, incluindo clientes sem veículo (LEFT JOIN + COUNT)
SELECT name, cpf, COUNT(vehicle_id) AS veiculos_registrados
FROM clients
LEFT JOIN vehicles ON clients.client_id = vehicles.client_id
GROUP BY name, cpf;

-- 10. Modelo dos veículos de clientes não expirados com serviço acima de R$400 (EXISTS duplo, evita duplicatas)
SELECT model
FROM vehicles
WHERE EXISTS (
    SELECT 1
    FROM clients
    WHERE vehicles.client_id = clients.client_id AND expired = False
)
AND EXISTS (
    SELECT 1
    FROM services
    WHERE vehicles.vehicle_id = services.vehicle_id AND value > 400
);

-- outra leva de 10

-- 1. Nome do cliente e quantidade de veículos ATIVOS (filtro antes do agrupamento)
SELECT name, COUNT(vehicle_id) AS total_vehicle
FROM clients
JOIN vehicles ON clients.client_id = vehicles.client_id 
WHERE vehicles.active = True
GROUP BY name;

-- 2. Serviços feitos em junho de 2026 (BETWEEN com datas)
SELECT title, value, date_release
FROM services
WHERE date_release BETWEEN '2026-06-01' AND '2026-06-30';

-- 3. Clientes que gastaram mais que a média de gasto POR SERVIÇO (não é a média de totais por cliente,
--    isso exigiria subquery no FROM, conceito ainda não estudado — anotar como próximo passo)
SELECT name
FROM clients
JOIN services ON clients.client_id = services.client_id
GROUP BY name
HAVING SUM(value) > (SELECT AVG(value) FROM services);

-- 4. Valor total gasto em serviço por veículo, incluindo veículos sem serviço (LEFT JOIN + SUM)
SELECT model, plate, SUM(value) AS total_value
FROM vehicles
LEFT JOIN services ON vehicles.vehicle_id = services.vehicle_id
GROUP BY model, plate;

-- 5. Top 3 clientes que mais gastaram no total (GROUP BY + ORDER BY SUM + LIMIT)
SELECT name, cpf
FROM clients
JOIN services ON clients.client_id = services.client_id
GROUP BY name, cpf
ORDER BY SUM(value) DESC
LIMIT 3;

-- 6. Quantidade de serviços por mês (DATE_TRUNC)
SELECT COUNT(service_id), DATE_TRUNC('month', date_release) AS mes
FROM services
GROUP BY DATE_TRUNC('month', date_release)
ORDER BY mes ASC;

-- 7. Clientes com mais de um veículo ATIVO (EXISTS simples, cuidado: não conta quantidade aqui)
SELECT name
FROM clients
WHERE EXISTS (
    SELECT 1
    FROM vehicles
    WHERE vehicles.client_id = clients.client_id AND active = True
);

-- 8. Título do serviço mais barato de cada cliente (subquery correlacionada com MIN)
SELECT title
FROM services
JOIN clients ON clients.client_id = services.client_id
WHERE value = (
    SELECT MIN(value)
    FROM services
    WHERE clients.client_id = services.client_id
);

-- 9. Diferença entre total gasto em serviços e total gasto em despesas (duas subqueries escalares)
SELECT (SELECT SUM(value) FROM services) - (SELECT SUM(value) FROM expenses) AS diferenca;

-- 10. Nome, modelo e título de serviços finalizados, só de clientes não expirados e veículos ativos (JOIN triplo)
SELECT name, model, title
FROM clients
JOIN vehicles ON clients.client_id = vehicles.client_id
JOIN services ON vehicles.vehicle_id = services.vehicle_id
WHERE clients.expired = False AND vehicles.active = True AND services.finish = True
GROUP BY name, model, title;
