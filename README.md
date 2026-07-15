# SQL Study — PostgreSQL puro

Estudo prático de SQL puro (PostgreSQL) — JOINs, GROUP BY, HAVING e subqueries — usando o schema real do meu sistema em produção ([Nippon Detail & Custom](https://nippon-detail.netlify.app)), como complemento ao uso diário de SQLAlchemy no dia a dia como backend developer.

## Contexto

Trabalho com FastAPI + SQLAlchemy, onde o ORM abstrai a maior parte do SQL. Esse repositório é um exercício ativo de escrever queries manualmente, sem o ORM, pra entender de fato o que acontece por trás — e conseguir explicar isso em entrevistas técnicas.

## Schema utilizado

```sql
client   (client_id, name, cpf, expired)
vehicle  (vehicle_id, client_id, model, plate, active)
service  (service_id, vehicle_id, client_id, title, value, finish, date_release)
material (material_id, name, quantity, value, total_value)
expense  (expense_id, name, value, date, origin)
```

## Conteúdo

- [01 - SELECT e WHERE](./01-select-where.sql)
- [02 - JOINs (INNER e LEFT)](./02-joins.sql)
- [03 - GROUP BY e HAVING](./03-group-by-having.sql)
- [04 - Subqueries](./04-subqueries.sql)

## Conceitos cobertos

- `SELECT` / `WHERE` (filtros com `AND`, `OR`)
- `INNER JOIN` vs `LEFT JOIN`
- `GROUP BY` com funções de agregação (`COUNT`, `SUM`, `AVG`)
- `HAVING` (filtro pós-agregação)
- Subqueries: escalar, com `IN`, e correlacionada (`EXISTS`)
