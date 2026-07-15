-- Quantidade de serviços feitos por cada cliente
SELECT client_id, COUNT(service_id)
FROM service
GROUP BY client_id;

-- Valor médio dos serviços por veículo
SELECT vehicle_id, AVG(value)
FROM service
GROUP BY vehicle_id;

-- Soma total gasta por cliente, filtrando só quem gastou mais de R$500 (HAVING)
SELECT client_id, SUM(value)
FROM service
GROUP BY client_id
HAVING SUM(value) > 500;

-- Nome do cliente + quantidade de veículos cadastrados (JOIN + GROUP BY)
SELECT client.name, COUNT(vehicle_id) 
FROM vehicle 
JOIN client ON vehicle.client_id = client.client_id 
GROUP BY client.name;
