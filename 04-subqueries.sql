-- Serviços cujo valor é maior que a média de todos os valores de serviço (subquery escalar)
SELECT value
FROM service
WHERE value > (SELECT AVG(value) FROM service);

-- Nome e CPF dos clientes que têm pelo menos um veículo cadastrado (subquery de lista, com IN)
SELECT name, cpf 
FROM client 
WHERE client_id IN (SELECT client_id FROM vehicle);

-- Placa de todos os veículos que têm pelo menos um serviço registrado (subquery correlacionada, com EXISTS)
SELECT plate
FROM vehicle
WHERE EXISTS (
    SELECT 1
    FROM service
    WHERE vehicle.vehicle_id = service.vehicle_id
);
