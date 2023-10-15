
DECLARE cursor_livros CURSOR FOR SELECT titulo, ano_publicacao FROM Livro;

OPEN cursor_livros;

FETCH cursor_livros INTO v_titulo, v_ano_publicacao;

DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE v_titulo VARCHAR(255);
DECLARE v_ano_publicacao int;
CLOSE cursor_livros;



DECLARE cursor_livros CURSOR FOR
SELECT titulo, ano_publicacao FROM livro;

OPEN cursor_livros;

fetch_loop: LOOP
    FETCH cursor_livros INTO v_titulo, v_ano_publicacao;

    IF done THEN
        LEAVE fetch_loop;

    END IF;

END LOOP fetch_loop;

CLOSE cursor_livros;

