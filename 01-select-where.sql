-- Nome e CPF de todos os clientes que não estão expirados
SELECT name, cpf 
FROM client 
WHERE expired = False;

-- Título e valor de todos os serviços já finalizados
SELECT title, value
FROM service
WHERE finish = True;

-- Placa de todos os veículos ativos
SELECT plate
FROM vehicle
WHERE active = True;

-- Título e valor dos serviços finalizados E com valor acima de 500 (AND)
SELECT title, value
FROM service
WHERE finish = True AND value > 500;

-- Título e valor dos serviços não finalizados OU com valor acima de 1000 (OR)
SELECT title, value 
FROM service 
WHERE finish = False OR value > 1000;
