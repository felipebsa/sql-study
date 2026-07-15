-- 1. Serviços com valor entre R$200 e R$800 (WHERE + BETWEEN)
SELECT title, value
FROM service
WHERE value BETWEEN 200 AND 800;

-- 2. Veículos que não estão ativos
SELECT model
FROM vehicle
WHERE active = False;

-- 3. Placa + título dos serviços ainda não finalizados (INNER JOIN + WHERE)
SELECT plate, title
FROM vehicle
JOIN service ON service.vehicle_id = vehicle.vehicle_id
WHERE service.finish = False;

-- 4. Nome de todos os clientes, incluindo os sem veículo cadastrado (LEFT JOIN)
SELECT name
FROM client
LEFT JOIN vehicle ON vehicle.client_id = client.client_id;

-- 5. Total gasto por cliente, ordenado do maior para o menor (GROUP BY + ORDER BY)
SELECT client_id, SUM(value)
FROM service
GROUP BY client_id
ORDER BY SUM(value) DESC;

-- 6. Clientes com mais de 1 veículo cadastrado (JOIN + GROUP BY + HAVING)
SELECT client_id, COUNT(client_id)
FROM client
JOIN vehicle ON vehicle.client_id = client.client_id
GROUP BY client_id
HAVING COUNT(vehicle.client_id) > 1;

-- 7. Nome e CPF dos clientes que não têm nenhum veículo cadastrado (NOT IN)
SELECT name, cpf
FROM client
WHERE client_id NOT IN (SELECT client_id FROM vehicle);

-- 8. Serviços com valor abaixo da média de todas as despesas (subquery de tabela diferente)
SELECT title, value
FROM service
WHERE value < (SELECT AVG(value) FROM expense);

-- 9. Nome dos clientes que não têm nenhum serviço registrado (NOT EXISTS correlacionado)
SELECT name
FROM client
WHERE NOT EXISTS (
    SELECT 1
    FROM service
    WHERE service.client_id = client.client_id
);

-- 10. Modelo do veículo + título do serviço mais caro de cada veículo (subquery correlacionada com MAX)
SELECT model, title
FROM vehicle
JOIN service ON vehicle.vehicle_id = service.vehicle_id
WHERE service.value = (
    SELECT MAX(value)
    FROM service
    WHERE service.vehicle_id = vehicle.vehicle_id
);
