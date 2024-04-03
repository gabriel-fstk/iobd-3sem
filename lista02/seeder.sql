INSERT INTO usuario (nome, email, senha) VALUES 
('John Doe', 'john@example.com', 'password123'),
('Jane Smith', 'jane@example.com', 'password456'),
('Michael Johnson', 'michael@example.com', 'pass1234'),
('Emily Davis', 'emily@example.com', 'abc123'),
('Christopher Wilson', 'chris@example.com', 'wilson789');

INSERT INTO artista (nome, nome_artistico) VALUES 
('Taylor Swift', 'Taylor Swift'),
('Adele', 'Adele'),
('Drake', 'Drake'),
('Rihanna', 'Rihanna'),
('Kanye West', 'Kanye West');

INSERT INTO album (titulo, data_lancamento, artista_id) VALUES 
('1989', '2014-10-27', 5),
('25', '2015-11-20', 4),
('Views', '2016-04-29', 2),
('Anti', '2016-01-28', 3),
('My Beautiful Dark Twisted Fantasy', '2010-11-22', 1);

-- INSERT INTO playlist (nome, data_hora, usuario_id) VALUES 
-- ('Driving Tunes', CURRENT_TIMESTAMP, 3),
-- ('Relaxation', CURRENT_TIMESTAMP, 4),
-- ('Party Hits', CURRENT_TIMESTAMP, 5),
-- ('Focus Mix', CURRENT_TIMESTAMP, 1),
-- ('Study Beats', CURRENT_TIMESTAMP, 2);

INSERT INTO playlist (nome, data_hora, usuario_id) VALUES 
('Driving Tunes', TIMESTAMP '2024-03-15 10:00:00' + (random() * INTERVAL '30 days'), 3),
('Relaxation', TIMESTAMP '2024-03-15 10:00:00' + (random() * INTERVAL '30 days'), 4),
('Party Hits', TIMESTAMP '2024-03-15 10:00:00' + (random() * INTERVAL '30 days'), 5),
('Focus Mix', TIMESTAMP '2024-03-15 10:00:00' + (random() * INTERVAL '30 days'), 1),
('Study Beats', TIMESTAMP '2024-03-15 10:00:00' + (random() * INTERVAL '30 days'), 2);


INSERT INTO musica (titulo, duracao, album_id) VALUES 
('Shake It Off', 219, 1),
('Hello', 295, 3),
('Hotline Bling', 267, 4),
('Work', 221, 2),
('Stronger', 311, 5);

INSERT INTO playlist_musica (playlist_id, musica_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
