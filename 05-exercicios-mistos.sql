-- SEÇÃO DE REVISÃO (exercícios 1-10, revisitando o básico)

-- 1. Clientes que não estão expirados
SELECT *
FROM clients
WHERE expired = False;
 
-- 2. Veículos ativos junto com o nome do cliente dono (JOIN simples)
SELECT name, vehicles.*
FROM vehicles
JOIN clients ON vehicles.client_id = clients.client_id
WHERE active = True;
 
-- 3. Quantidade de veículos por cliente
SELECT name, clients.client_id, COUNT(vehicle_id)
FROM clients
JOIN vehicles ON clients.client_id = vehicles.client_id
GROUP BY clients.client_id, name;
 
-- 4. Serviços com valor acima de R$500, do mais caro pro mais barato
SELECT *
FROM services
WHERE value > 500
ORDER BY value DESC;
 
-- 5. Total de despesas agrupado por origem
SELECT origin, SUM(value)
FROM expenses
GROUP BY origin;
 
-- 6. Clientes com mais de 2 veículos cadastrados (GROUP BY + HAVING)
SELECT clients.*
FROM clients
JOIN vehicles ON clients.client_id = vehicles.client_id
GROUP BY clients.client_id
HAVING COUNT(vehicle_id) > 2;
 
-- 7. Serviços que ainda não foram finalizados
SELECT *
FROM services
WHERE finish = False;
 
-- 8. Valor total já gasto em serviços, por veículo
SELECT vehicles.vehicle_id, SUM(value)
FROM vehicles
JOIN services ON vehicles.vehicle_id = services.vehicle_id
GROUP BY vehicles.vehicle_id;
 
-- 9. Materiais com total_value acima da média de todos os materiais (subquery escalar)
SELECT *
FROM materials
WHERE total_value > (SELECT AVG(total_value) FROM materials);
 
-- 10. Clientes que fizeram algum serviço no último mês
SELECT clients.*
FROM clients
JOIN services ON clients.client_id = services.client_id
WHERE date_release BETWEEN '2026-06-17' AND '2026-07-17';


-- A 1. leva de 10 questões

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
