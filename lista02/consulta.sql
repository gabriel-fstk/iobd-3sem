-- Insira no mínimo 3 tuplas em cada tabela
-- **seeder.sql (inserted 5 datas)

-- Adicione a coluna data_nascimento na tabela de usuários. Além disso, coloque uma cláusula CHECK permitindo somente anos de nascimento >= 1900

ALTER TABLE usuario ADD COLUMN data_nascimento date CHECK (EXTRACT(YEAR FROM data_nascimento) >= 1900);

UPDATE usuario SET data_nascimento = '1987-03-11' WHERE id = 1;
UPDATE usuario SET data_nascimento = '1983-11-17' WHERE id = 2;
UPDATE usuario SET data_nascimento = '1984-06-20' WHERE id = 3;
UPDATE usuario SET data_nascimento = '1989-05-05' WHERE id = 4;
UPDATE usuario SET data_nascimento = '1981-08-09' WHERE id = 5;

-- Retorne os nomes dos usuários e suas datas de nascimento formatadas em dia/mes/ano. Para testar será preciso inserir ou atualizar as datas de nascimento de alguns usuários

SELECT usuario.nome, to_char(usuario.data_nascimento, 'DD/MM/YYYY')
FROM usuario;

-- Delete usuários sem nome
-- **Por padrão a coluna 'nome' não aceita que seja null

-- Torne a coluna nome da tabela usuários obrigatória

-- Retorne os títulos de todos os álbuns em maiúsculo

SELECT upper(album.titulo)
FROM album;

-- Retorne somente os títulos dos 2 primeiros álbuns cadastrados

SELECT album.titulo
FROM album
ORDER BY album.id asc
LIMIT 2;

-- Retorne o nome e o email de todos os usuários separados por ponto-e-vírgula

SELECT concat_ws(';', usuario.nome, usuario.email)
FROM usuario; 

-- Retorne músicas com duração entre 100 (200) e 200 (250) segundos

SELECT musica.id, musica.titulo
FROM musica 
WHERE musica.duracao BETWEEN 200 AND  250;

-- Retorne músicas que não possuem duração entre 100 e 200 segundos

SELECT musica.id, musica.titulo
FROM musica 
WHERE musica.duracao NOT BETWEEN 200 AND 250;