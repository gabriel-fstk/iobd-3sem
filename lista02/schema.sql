-- psql -U postgres

DROP DATABASE IF EXISTS instapoble;

CREATE DATABASE spotipobre;

\c spotipobre;

CREATE TABLE usuario (
    id serial primary key,
    nome varchar(100) not null,
    email varchar(100) not null,
    senha varchar(100) not null
);

CREATE TABLE artista (
    id serial primary key,
    nome varchar(100) not null,
    nome_artistico varchar(60) not null
);

CREATE TABLE album (
    id serial primary key,
    titulo text not null,
    data_lancamento date,
    artista_id int not null
        references artista (id)
);

CREATE TABLE playlist (
    id serial primary key,
    nome varchar(100) not null,
    data_hora timestamp default current_timestamp,
    usuario_id int not null 
        references usuario (id)
);

CREATE TABLE musica (
    id serial primary key,
    titulo text not null,
    duracao int not null CHECK (duracao > 0),
    album_id int not null
        references album (id)
);

CREATE TABLE playlist_musica (
    playlist_id int references playlist (id),
    musica_id int references musica (id)

);