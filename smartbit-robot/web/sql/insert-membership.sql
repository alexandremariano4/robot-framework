BEGIN; -- Inicia uma transação

-- Remove o registro pelo email
DELETE FROM accounts
WHERE email = 'barneco@gmail.com';

-- Insere uma nova conta e obtém o ID da conta recém-inserida
WITH new_account AS (
    INSERT INTO accounts (name, email, cpf)
    VALUES ('Barney Stinso', 'barneco@gmail.com', '30405025815')
    RETURNING id
)

-- Insere um registro na tabela memberships com o ID da conta
INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
SELECT id, 1, '4242', 99.99, true
FROM new_account;

COMMIT; -- Confirma a transação
