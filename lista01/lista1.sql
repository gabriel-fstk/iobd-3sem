1)
instapoble=# select usuario.nome, conta.nome_usuario FROM usuario inner join conta on (usuario.id = conta.usuario_id) ORDER BY usuario.nome;

1) 
instapoble=# SELECT usuario.nome, STRING_AGG(conta.nome_usuario, ',') AS contas FROM usuario inner join conta on (usuario.id = conta.usuario_id) GROUP by USUARIO.nome;

2) instapoble=# SELECT publicacao.id, publicacao.texto, arquivo_principal, arquivo.arquivo FROM publicacao left join arquivo on (publicacao.id = arquivo.publicacao_id);

3) 
instapoble=# SELECT publicacao.id, publicacao.texto, STRING_AGG(comentario.texto, ',') FROM publicacao left join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id, publicacao.texto;

4) SELECT publicacao.id, publicacao.texto, STRING_AGG(comentario.texto, ',') FROM publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id, publicacao.texto;

5) instapoble=# SELECT usuario.nome, count(*) as qtde FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) GROUP BY usuario.id, usuario.nome;

6) instapoble=# SELECT usuario.id, usuario.nome, count(*) as qtde from usuario inner join conta on (usuario.id = conta.usuario_id) inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by usuario.id, usuario.nome;


7) instapoble=# select publicacao.id, publicacao.texto, count(*) from publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id having count(*) = (select count(*) from publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id ORDER BY count(*) DESC LIMIT 1);

8) instapoble=# SELECT publicacao.id, publicacao.texto from publicacao left join comentario on (publicacao.id = comentario.publicacao_id) where comentario.id is null;

instapoble=# SELECT publicacao.id, publicacao.texto from publicacao where publicacao.id not in (select comentario.publicacao_id from comentario);

9) instapoble=# select usuario.id, usuario.nome, count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id, usuario.nome having count(*) = 1;

10) instapoble=# select usuario.id, usuario.nome, count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id, usuario.nome having count(*) > 1;


11)instapoble=# SELECT publicacao.id, publicacao.texto from publicacao left join arquivo on (publicacao.id = arquivo.publicacao_id) where arquivo.publicacao_id is null; 

instapoble=# SELECT publicacao.id, publicacao.texto from publicacao where id not in (select arquivo.publicacao_id from arquivo);


instapoble=# SELECT publicacao.id, publicacao.texto from publicacao
EXCEPT
SELECT publicacao.id, publicacao.texto from publicacao inner join arquivo on (publicacao.id = arquivo.publicacao_id);


/*
https://pgexercises.com/questions/basic/selectall.html

https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true

https://judge.beecrowd.com/pt/login?redirect=%2Fpt
*/

12) SELECT conta_publicacao.publicacao_id, count(*) from conta inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by conta_publicacao.publicacao_id having count(*) > 1;


-- 13) Retornar usuários e suas respectivas contas que não criaram nenhuma publicação

SELECT 
    usuario.id, usuario.nome, conta.id, conta.nome_usuario 
    FROM usuario 
    LEFT JOIN conta
        ON usuario.id = conta.usuario_id
    LEFT JOIN conta_publicacao
        ON conta.id = conta_publicacao.conta_id
    WHERE conta_publicacao.conta_id IS NULL;

-- 14) Retornar usuários que possuem só publicações sem comentários
SELECT 
    usuario.id, usuario.nome, conta.id, conta.nome_usuario, publicacao.id AS pubID, comentario.texto
    FROM usuario 
    INNER JOIN conta
        ON usuario.id = conta.usuario_id
    INNER JOIN conta_publicacao
        ON conta.id = conta_publicacao.conta_id
    INNER JOIN publicacao
        ON conta_publicacao.publicacao_id = publicacao.id
    LEFT JOIN comentario
        ON publicacao.id = comentario.publicacao_id
    WHERE comentario.publicacao_id IS NULL
    GROUP BY usuario.id,conta.id, comentario.texto, publicacao.id;

SELECT 
    usuario.id, usuario.nome, conta.id, conta.nome_usuario, publicacao.id AS pubID, comentario.texto
    FROM usuario 
    LEFT JOIN conta
        ON usuario.id = conta.usuario_id
    LEFT JOIN conta_publicacao
        ON conta.id = conta_publicacao.conta_id
    RIGHT JOIN publicacao
        ON conta_publicacao.publicacao_id = publicacao.id
    LEFT JOIN comentario
        ON publicacao.id = comentario.publicacao_id
    WHERE comentario.publicacao_id IS NULL
    GROUP BY usuario.id,conta.id, comentario.texto, publicacao.id;

-- 15) Retornar a conta que mais realizou comentários
-- TODO: utiliza subselect para mostrar contas com mesmo número de comentários; utilizar HAVING count() = SUBSELECT

SELECT 
    conta.id, conta.nome_usuario, count(conta.id) AS total_comentarios
FROM conta
LEFT JOIN comentario
    ON conta.id = comentario.conta_id
GROUP BY conta.id, comentario.conta_id
ORDER BY total_comentarios DESC
LIMIT 1;

-- 16) Retornar o nome do usuário e o nome da conta da última conta criada

SELECT
    usuario.id, usuario.nome, conta.nome_usuario, conta.data_hora_criacao
FROM usuario 
LEFT JOIN conta
    ON usuario.id = conta.usuario_id
ORDER BY conta.data_hora_criacao DESC
LIMIT 1;

-- 17) Retornar usuário(s) que possue(m) a maior quantidade de contas

SELECT
    usuario.id, usuario.nome, count(conta.usuario_id) AS total_de_contas
FROM usuario
LEFT JOIN conta
    ON usuario.id = conta.usuario_id
GROUP BY usuario.id, conta.usuario_id
ORDER BY total_de_contas DESC;

-- Tratando igualdade com view e having (infelizmente utiliza subselect)

CREATE VIEW biggest_qts_accounts_view AS 
    SELECT count(*) AS total_contas
    FROM usuario 
    INNER JOIN conta
        ON usuario.id = conta.usuario_id
    GROUP BY usuario.id
    ORDER BY count(*) desc 
    LIMIT 1;

SELECT
    usuario.id, usuario.nome, count(*) AS total_de_contas
FROM usuario
LEFT JOIN conta
    ON usuario.id = conta.usuario_id
GROUP BY usuario.id
HAVING count(*) = (
    SELECT * 
    FROM biggest_qts_accounts_view
    )
ORDER BY usuario.id;

-- 18) Retornar usuário(s) que possue(m) a menor quantidade de contas

SELECT
    usuario.id, usuario.nome, count(conta.usuario_id) AS total_de_contas
FROM usuario
LEFT JOIN conta
    ON usuario.id = conta.usuario_id
GROUP BY usuario.id, conta.usuario_id
ORDER BY total_de_contas ASC;

-- 19) Retornar comentários realizados durante a última semana (últimos 7 dias)

SELECT *
FROM comentario 
WHERE comentario.data_hora > CURRENT_DATE - INTERVAL '7 days';


-- 20) Retornar as contas do(s) usuário(s) mais velho(s)
-- EXTRACT (YEAR FROM ...) // estrair somente idade

SELECT 
    conta.id, conta.nome_usuario, AGE(usuario.data_nascimento) AS data_nascimento
FROM conta
LEFT JOIN usuario
    ON conta.usuario_id = usuario.id
ORDER BY data_nascimento DESC;

-- 21) Listar nos primeiros resultados usuários sem conta acima dos usuários com conta

SELECT
    usuario.id, usuario.nome, conta.nome_usuario
FROM usuario 
LEFT JOIN conta
    ON usuario.id = conta.usuario_id
ORDER BY conta.usuario_id DESC;

-- 22) Quantidade total de comentários dado um intervalo de datas

SELECT 
    COUNT(*) AS total_comentarios
FROM comentario
WHERE comentario.data_hora 
    BETWEEN '2024-02-28' AND '2024-03-20';

-- 23) Selecione publicações que tenham mais de um arquivo (fora o obrigatório)

SELECT 
    publicacao.id, arquivo.publicacao_id, COUNT(*) AS total_arquivos
FROM publicacao
LEFT JOIN arquivo
    ON publicacao.id = arquivo.publicacao_id
GROUP BY publicacao.id, arquivo.publicacao_id
HAVING COUNT(*) > 1;

-- 24) Publicação com maior texto (maior número de caracteres)

SELECT
    publicacao.id, publicacao.texto
FROM publicacao
ORDER BY LENGTH(publicacao.texto) DESC
LIMIT 1;


-- 25) Publicações com maior número de caracteres (nesta questão cuidar a questão do empate, ou seja, 2 ou mais publicações terem o texto com o mesma quantidade de caracteres)

SELECT
    publicacao.id, publicacao.texto, LENGTH(publicacao.texto) as num_caracteres
FROM publicacao
WHERE LENGTH(publicacao.texto) = (
    SELECT LENGTH(publicacao.texto)
    FROM publicacao
    ORDER BY LENGTH(publicacao.texto) DESC
    LIMIT 1
);

-- 26) Usuário que mais publicou em um dado intervalo de tempo
-- skipped until 33

-- 33) Formatar o retorno da data e hora

SELECT
    usuario.id, usuario.nome, to_char(data_nascimento, 'DD/MM/YYYY')
FROM usuario;
