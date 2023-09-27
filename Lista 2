-- Exercicio 1 
delimiter //
create procedure sp_ListarAutores ()
begin
	select * from Autor;
end;
//
delimiter ;
call sp_ListarAutores();
drop procedure sp_ListarAutores;

-- Exercicio 2 
DELIMITER //
create procedure sp_LivrosPorCategoria (in categoria_nome varchar(255))
begin
    select Livro.Titulo, Livro.Editora_ID, Livro.Ano_Publicacao, Livro.Numero_Paginas
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
end;
//
DELIMITER ;
call sp_LivrosPorCategoria('Romance');
call sp_LivrosPorCategoria('Ciência');
drop procedure sp_LivrosPorCategoria;

-- Exercicio 3 
delimiter //
create procedure sp_ContarLivrosPorCategoria(in categoria_nome varchar(255), out total_livros int)
begin
    select COUNT(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
end;
//
delimiter ;

CALL sp_ContarLivrosPorCategoria('História', @total);
select @total;
drop procedure sp_ContarLivrosPorCategoria;

-- Exercicio 4
delimiter //
create procedure sp_VerificarLivrosCategoria(in categoria_nome varchar(255), out possui_livros bit)
begin
    declare total_livros int;
    
    select count(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
    
    if total_livros > 0 then
        set possui_livros = 1;
    else
        set possui_livros = 0;
    end if;
end;
//
delimiter ;

call sp_VerificarLivrosCategoria('História', @possui_livros);
select @possui_livros;
drop procedure sp_VerificarLivrosCategoria;

-- Exercicio 5
delimiter //
create procedure sp_LivrosAteAno(in ano_publicacao int)
begin
    select Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID
    from Livro
    where Ano_Publicacao <= ano_publicacao;
end;
//
delimiter ;

call sp_LivrosAteAno('2005');
drop procedure sp_LivrosAteAno;

-- Exercicio6
delimiter //
create procedure sp_TitulosPorCategoria (in categoria_nome varchar(255))
begin
	select Livro.Titulo
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
end;
//
delimiter ;

call sp_TitulosPorCategoria('Ciência');
drop procedure sp_TitulosPorCategoria;

-- Exercicio7
delimiter //
create procedure sp_AdicionarLivro(	
	in p_Titulo varchar(255),
    in p_Editora_ID INT,
    in p_Ano_Publicacao int,
    in p_Numero_Paginas int,
    in p_Categoria_ID int
)

begin
    declare v_Contagem int;

    select count(*) into v_Contagem from Livro where Titulo = p_Titulo;

    if v_Contagem > 0 then
        signal sqlstate '45000'
        set message_text = 'Livro com este título já existe na tabela.';
    else
        insert into Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        values (p_Titulo, p_Editora_ID, p_Ano_Publicacao, p_Numero_Paginas, p_Categoria_ID);
    end if;
end;
//
delimiter ;

call sp_AdicionarLivro('Os males do vilão', 2, 2023, 320, 4);

-- Exercicio8
delimiter //
create procedure sp_AutorMaisAntigo()
begin
    declare AutorMaisAntigo varchar(255);
    declare DataNascimento date;

    set AutorMaisAntigo = '';
    set DataNascimento = null;

    select min(Data_Nascimento) into DataNascimento from Autor;

    select Nome into AutorMaisAntigo from Autor where Data_Nascimento = DataNascimento;

    select AutorMaisAntigo as 'Autor_Mais_Antigo';
end; 
//
delimiter ;

call sp_AutorMaisAntigo();
drop procedure sp_AutorMaisAntigo;

-- Exercicio9
delimiter //
create procedure sp_ContarLivrosPorCategoria(in categoria_nome varchar(255), out total_livros int)
begin
    select COUNT(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
end;
//
delimiter ;

-- Exercicio 10 
delimiter //
create procedure sp_LivrosESeusAutores()
begin
    select Livro.Titulo, Autor.Nome, Autor.Sobrenome
    from Livro
    inner join LivroAutor on Livro.Livro_ID = LivroAutor.Livro_ID
    inner join Autor on LivroAutor.Autor_ID = Autor.Autor_ID;
end;
//
delimiter ;

call sp_LivrosESeusAutores();
drop procedure sp_LivrosESeusAutores;
