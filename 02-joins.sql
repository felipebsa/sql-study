-- Placa do veículo + nome do dono (INNER JOIN: só traz veículos com cliente vinculado)
SELECT vehicle.plate, client.name 
FROM vehicle 
JOIN client ON vehicle.client_id = client.client_id;

-- Título do serviço + modelo do veículo (INNER JOIN entre service e vehicle)
SELECT title, model
FROM service
JOIN vehicle ON service.vehicle_id = vehicle.vehicle_id;

-- Todos os veículos (placa) + título do serviço, mesmo sem serviço registrado (LEFT JOIN)
SELECT title, plate
FROM vehicle
LEFT JOIN service ON vehicle.vehicle_id = service.vehicle_id;
