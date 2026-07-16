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
