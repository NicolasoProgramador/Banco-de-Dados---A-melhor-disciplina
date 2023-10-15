CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255),
    genero VARCHAR(100),
    resumo TEXT,
    ano_publicacao INT
);



-- Exercicio 1 

DELIMITER $$

CREATE FUNCTION total_livros_por_genero(genero_param VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total_livros INT DEFAULT 0;
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE curso CURSOR FOR SELECT id FROM livros WHERE genero = genero_param;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH curso INTO livro_id;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total_livros = total_livros + 1;
    END LOOP;

    CLOSE curso;

    RETURN total_livros;
END$$

DELIMITER ;

-- Exercicio 2 

CREATE FUNCTION listar_livros_por_autor(primeiro_nome_autor VARCHAR(255), ultimo_nome_autor VARCHAR(255)) RETURNS TEXT
BEGIN
    DECLARE lista_de_livros TEXT DEFAULT '';
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    DECLARE titulo_livro VARCHAR(255);

 SELECT id INTO autor_id
    FROM Autor
   
    WHERE primeiro_nome = primeiro_nome_autor AND ultimo_nome = ultimo_nome_autor;
DECLARE cur_livros CURSOR FOR
        SELECT Livro.titulo
        FROM Livro
        INNER JOIN Livro_Autor ON Livro.id = Livro_Autor.livro_id
        WHERE Livro_Autor.autor_id = autor_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_livros;

    read_livros: LOOP
        FETCH cur_livros INTO titulo_livro;
        IF done = 1 THEN
            LEAVE read_livros;
        END IF;

        SET lista_de_livros = CONCAT(lista_de_livros, titulo_livro, ', ');
    END LOOP;

    CLOSE cur_livros;

    RETURN lista_de_livros;
END$$

DELIMITER ;
-- Exercicio 3

CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE resumo_atual TEXT;
    DECLARE cur CURSOR FOR SELECT id, resumo FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO livro_id, resumo_atual;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        
        -- Adicione a frase ao final do resumo
        SET resumo_atual = CONCAT(resumo_atual, ' Este é um excelente livro!');
        
        -- Atualize o resumo na tabela
        UPDATE Livro SET resumo = resumo_atual WHERE id = livro_id;
    END LOOP;
    
    CLOSE cur;
END$$

DELIMITER ;

-- Exercicio 4 

CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE editora_id INT;
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE media DECIMAL(10, 2);

    DECLARE cur_editoras CURSOR FOR SELECT id FROM Editora;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET total_editoras = 0;

    SET total_livros = 0;
    SET total_editoras = 0;

    OPEN cur_editoras;

    read_editoras: LOOP
        FETCH cur_editoras INTO editora_id;
        IF total_editoras = 0 THEN
            LEAVE read_editoras;
        END IF;

        DECLARE cur_livros CURSOR FOR SELECT COUNT(*) FROM Livro WHERE editora_id = editora_id;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET total_livros = 0;

        OPEN cur_livros;
        FETCH cur_livros INTO total_livros;
        CLOSE cur_livros;

        SET media = media + (total_livros / total_editoras);
    END LOOP;

    CLOSE cur_editoras;

    RETURN media;
END$$

DELIMITER ;

-- Exercicio 5 

DELIMITER $$

CREATE FUNCTION autores_sem_livros() RETURNS TEXT
BEGIN
    DECLARE lista_autores_sem_livros TEXT DEFAULT '';
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    DECLARE autor_nome VARCHAR(255);

    DECLARE cur_autores CURSOR FOR
        SELECT id, CONCAT(primeiro_nome, ' ', ultimo_nome) AS nome_autor
        FROM Autor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_autores;

    read_autores: LOOP
        FETCH cur_autores INTO autor_id, autor_nome;
        IF done = 1 THEN
            LEAVE read_autores;
        END IF;

        -- Verifique se o autor não tem livros associados
        IF (SELECT COUNT(*) FROM Livro_Autor WHERE autor_id = autor_id) = 0 THEN
            SET lista_autores_sem_livros = CONCAT(lista_autores_sem_livros, autor_nome, ', ');
        END IF;
    END LOOP;

    CLOSE cur_autores;

    RETURN lista_autores_sem_livros;
END$$

DELIMITER ;

-- professor foi dficil em perdi meu domingo inteiro fazendo a lista kkkkkk mas é isso valeu professor tmj 
