CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

-- Criação das tabelas
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

-- EXERCICIO 1 

DELIMITER //
CREATE TRIGGER cliente_insert_audit
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
  INSERT INTO Auditoria (mensagem,data_hora)
  VALUES('Novo cliente inserido', NOW());
END;
//
DELIMITER ;

-- EXERCICIO 2

DELIMITER //
CREATE TRIGGER cliente_before_delete_audit
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
  INSERT INTO Auditoria (mensagem,data_hora)
  VALUES('TENTATIVA DE EXCLUSAO DO CARA', NOW());
END;
//
DELIMITER ;

-- EXERCICIO 3 

DELIMITER //
CREATE TRIGGER cliente_insert_audit
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
IF OLD.nome <> NEW.nome THEN
   INSERT INTO Auditoria (mensagem,data_hora)
   VALUES(
       CONCAT('Nome do cliente atualizado de "', OLD.name, '" para "', NEW.nome, ' "'),
       NOW()
       );
       END IF ;
	END;
//
DELIMITER ;

-- EXERCICIO 4

DELIMITER //
CREATE TRIGGER cliente_prevenir_nome_vazio
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
 IF NEW.nome IS NULL OR NEW.nome = '' THEN 
 SET NEW.nome = OLD.nome;
 INSERT INTO Auditoria (mensagem,data_hora)
 VALUES ('Tentativa  de update de name para vazio ou nulo', NOW());
END IF;
END;
//
DELIMITER ;

-- EXERCICIO 5

DELIMITER //
CREATE TRIGGER pedido_insert_decrement_stock
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
  DECLARE produto_stock INT;
  SET produto_stock = (SELECT estoque FROM produtos WHERE id = NEW.produto_id);
  IF produto_stock > 0 THEN
    UPDATE produtos
    SET estoque = estoque - 1
    WHERE id = NEW.produto_id;
    IF produto_stock - 1 < 5 THEN
      INSERT INTO Auditoria (mensagem, data_hora)
      VALUES ('Estoque do produto ID ' + CAST(NEW.produto_id AS CHAR) + ' abaixo de 5 unidades', NOW());
    END IF;
  END IF;
END;
//
DELIMITER ;
