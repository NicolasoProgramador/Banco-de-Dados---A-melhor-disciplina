a) Criar a tabela nomes:

sql
CREATE TABLE nomes (
    nome VARCHAR(50)
);

INSERT INTO nomes (nome) VALUES
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');



b) Converter todos os nomes para maiúsculas:

sql
SELECT UPPER(nome) AS nome_maiusculo FROM nomes;



c) Determinar o tamanho de cada nome:

sql
SELECT nome, LENGTH(nome) AS tamanho FROM nomes;



d) Adicionar "Sr." e "Sra." antes dos nomes masculinos e femininos:

sql
SELECT
    CASE
        WHEN nome LIKE 'João%' THEN 'Sr. ' || nome
        ELSE 'Sra. ' || nome
    END AS nome_com_tratamento
FROM nomes;



### Funções Numéricas:

a) Criar a tabela produtos:

sql
CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade) VALUES
    ('Produto A', 10.99, 5),
    ('Produto B', 5.49, 0),
    ('Produto C', 15.99, -2);



b) Arredondar os preços para 2 casas decimais:

sql
SELECT produto, ROUND(preco, 2) AS preco_arredondado FROM produtos;



c) Exibir o valor absoluto das quantidades:

sql
SELECT produto, ABS(quantidade) AS quantidade_absoluta FROM produtos;



d) Calcular a média dos preços dos produtos:

sql
SELECT AVG(preco) AS media_precos FROM produtos;



### Funções de Data:

a) Criar a tabela eventos:

sql
CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento) VALUES
    ('2023-10-01'),
    ('2023-10-05'),
    ('2023-10-10');



b) Inserir a data e hora atual em uma nova linha:

sql
INSERT INTO eventos (data_evento) VALUES (NOW());



c) Calcular o número de dias entre duas datas:

sql
SELECT
    data_evento,
    DATEDIFF(data_evento, '2023-10-01') AS dias_entre_datas
FROM eventos;



d) Exibir o nome do dia da semana de cada evento:

sql
SELECT
    data_evento,
    DAYNAME(data_evento) AS nome_dia_semana
FROM eventos;



### Funções de Controle de Fluxo:

a) Usar a função IF() para determinar se um produto está "Em estoque" ou "Fora de estoque" baseado na quantidade:

sql
SELECT
    produto,
    IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque
FROM produtos;



b) Usar a função CASE para classificar os produtos em categorias de preço:

sql
SELECT
    produto,
    CASE
        WHEN preco < 10.0 THEN 'Barato'
        WHEN preco >= 10.0 AND preco < 20.0 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_preco
FROM produtos;



### Função Personalizada:

a) Crie uma função que retorne o fatorial de um número:

sql
DELIMITER //
CREATE PROCEDURE calcular_fatorial(IN numero INT, OUT resultado INT)
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE fatorial INT DEFAULT 1;
  
  WHILE i <= numero DO
    SET fatorial = fatorial * i;
    SET i = i + 1;
  END WHILE;
  
  SET resultado = fatorial;
END;
//
DELIMITER ;



b) Crie uma função que calcule o exponencial de um número:

sql
CREATE OR REPLACE FUNCTION f_exponencial(base NUMERIC, expoente NUMERIC)
RETURNS NUMERIC AS
BEGIN
  RETURN POWER(base, expoente);
END;



c) Crie uma função que verifique se uma palavra é um palíndromo:

sei fazer nao
