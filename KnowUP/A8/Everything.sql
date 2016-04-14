DROP SCHEMA IF EXISTS knowup CASCADE;
CREATE SCHEMA knowup;
SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*                    Tables                  */
/*--------------------------------------------*/

DROP TABLE IF EXISTS Report;
DROP TABLE IF EXISTS Mensagem;
DROP TABLE IF EXISTS Conversa;
DROP TABLE IF EXISTS Seguidor;
DROP TABLE IF EXISTS VotoResposta;
DROP TABLE IF EXISTS VotoPergunta;
DROP TABLE IF EXISTS ComentarioResposta;
DROP TABLE IF EXISTS ComentarioPergunta;
DROP TABLE IF EXISTS Resposta;
DROP TABLE IF EXISTS Contribuicao;
DROP TABLE IF EXISTS Pergunta;
DROP TABLE IF EXISTS Moderador;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS Utilizador;
DROP TABLE IF EXISTS CategoriaInstituicao;
DROP TABLE IF EXISTS Instituicao;
DROP TABLE IF EXISTS Categoria;

CREATE TABLE Categoria (
    idCategoria     serial      NOT NULL,
    nome            text        NOT NULL
);

ALTER TABLE Categoria ADD CONSTRAINT PK_Categoria PRIMARY KEY (idCategoria);
ALTER TABLE Categoria ADD CONSTRAINT UK_Categoria_Nome UNIQUE (nome);

CREATE TABLE Instituicao (
    idInstituicao   serial      NOT NULL,
    nome            text        NOT NULL,
    sigla           text        NOT NULL,
    morada          text        NULL,
    contacto        text        NULL,
    website         text        NULL
);

ALTER TABLE Instituicao ADD CONSTRAINT PK_Instituicao PRIMARY KEY (idInstituicao);
ALTER TABLE Instituicao ADD CONSTRAINT UK_Instituicao_Nome UNIQUE (nome);
ALTER TABLE Instituicao ADD CONSTRAINT UK_Instituicao_Sigla UNIQUE (sigla);

CREATE TABLE CategoriaInstituicao (
    idInstituicao   integer     NOT NULL,
    idCategoria     integer     NOT NULL
);

ALTER TABLE CategoriaInstituicao ADD CONSTRAINT PK_CategoriaInstituicao PRIMARY KEY (idInstituicao, idCategoria);
ALTER TABLE CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria) ON DELETE CASCADE;
ALTER TABLE CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idInstituicao FOREIGN KEY (idInstituicao) REFERENCES Instituicao(idInstituicao) ON DELETE CASCADE;

CREATE TABLE Utilizador (
    idUtilizador    serial      NOT NULL,
    idInstituicao   integer     NULL,
    username        text        NOT NULL,
    password        text        NOT NULL,
    email           text        NOT NULL,
    primeiroNome    text        NOT NULL,
    ultimoNome      text        NOT NULL,
    localidade      text        NULL,
    codigoPais      text        NULL,
    dataRegisto     timestamp   DEFAULT current_timestamp,
    ultimaSessao    timestamp   DEFAULT current_timestamp,
    removido        boolean     DEFAULT false,
    ativo           boolean     DEFAULT true
);

ALTER TABLE Utilizador ADD CONSTRAINT PK_Utilizador PRIMARY KEY (idUtilizador);
ALTER TABLE Utilizador ADD CONSTRAINT UK_Utilizador_Email UNIQUE (email);
ALTER TABLE Utilizador ADD CONSTRAINT UK_Utilizador_Username UNIQUE (username);
ALTER TABLE Utilizador ADD CONSTRAINT FK_Utilizador_idInstituicao FOREIGN KEY (idInstituicao) REFERENCES Instituicao(idInstituicao) ON DELETE SET NULL;

CREATE TABLE Administrador (
    idAdministrador        integer     NOT NULL
);

ALTER TABLE Administrador ADD CONSTRAINT PK_Administrador PRIMARY KEY (idAdministrador);
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_idAdministrador FOREIGN KEY (idAdministrador) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Moderador (
    idModerador     integer      NOT NULL
);

ALTER TABLE Moderador ADD CONSTRAINT PK_Moderador PRIMARY KEY (idModerador);
ALTER TABLE Moderador ADD CONSTRAINT FK_Moderador_idModerador FOREIGN KEY (idModerador) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Pergunta (
    idPergunta      serial      NOT NULL,
    idCategoria     integer     NOT NULL,
    idAutor         integer     NOT NULL,
    titulo          text        NOT NULL,
    descricao       text        NULL,
    dataHora        timestamp   DEFAULT current_timestamp,
    ativa           boolean     DEFAULT true
);

ALTER TABLE Pergunta ADD CONSTRAINT PK_Pergunta PRIMARY KEY (idPergunta);
ALTER TABLE Pergunta ADD CONSTRAINT FK_Pergunta_idCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria) ON DELETE CASCADE;
ALTER TABLE Pergunta ADD CONSTRAINT FK_Pergunta_idAutor FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Contribuicao (
    idContribuicao  serial      NOT NULL,
    idAutor         integer     NOT NULL,
    descricao       text        NOT NULL,
    dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Contribuicao ADD CONSTRAINT PK_Contribuicao PRIMARY KEY (idContribuicao);
ALTER TABLE Contribuicao ADD CONSTRAINT FK_Contribuicao_idAutor FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Resposta (
    idResposta      integer     NOT NULL,
    idPergunta      integer     NOT NULL,
    melhorResposta  boolean     DEFAULT false
);

ALTER TABLE Resposta ADD CONSTRAINT PK_Resposta PRIMARY KEY (idResposta);
ALTER TABLE Resposta ADD CONSTRAINT FK_Resposta_idPergunta FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta) ON DELETE CASCADE;
ALTER TABLE Resposta ADD CONSTRAINT FK_Resposta_idResposta FOREIGN KEY (idResposta) REFERENCES Contribuicao(idContribuicao) ON DELETE CASCADE;

CREATE TABLE ComentarioPergunta (
    idComentario    integer     NOT NULL,
    idPergunta      integer     NOT NULL
);

ALTER TABLE ComentarioPergunta ADD CONSTRAINT PK_ComentarioPergunta PRIMARY KEY (idComentario);
ALTER TABLE ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idComentario FOREIGN KEY (idComentario) REFERENCES Contribuicao(idContribuicao) ON DELETE CASCADE;
ALTER TABLE ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idPergunta FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta) ON DELETE CASCADE;

CREATE TABLE ComentarioResposta (
    idComentario    serial      NOT NULL,
    idResposta      integer     NOT NULL
);

ALTER TABLE ComentarioResposta ADD CONSTRAINT PK_ComentarioResposta PRIMARY KEY (idComentario);
ALTER TABLE ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idComentario FOREIGN KEY (idComentario) REFERENCES Contribuicao(idContribuicao) ON DELETE CASCADE;
ALTER TABLE ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idResposta FOREIGN KEY (idResposta) REFERENCES Resposta(idResposta) ON DELETE CASCADE;

CREATE TABLE VotoPergunta (
    idPergunta  integer     NOT NULL,
    idAutor     integer     NOT NULL,
    valor       integer     DEFAULT 0
);

ALTER TABLE VotoPergunta ADD CONSTRAINT PK_VotoPergunta PRIMARY KEY (idPergunta, idAutor);
ALTER TABLE VotoPergunta ADD CONSTRAINT CK_VotoPergunta_Valor CHECK (valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idPergunta FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta) ON DELETE CASCADE;
ALTER TABLE VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idAutor FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE VotoResposta (
    idResposta  integer     NOT NULL,
    idAutor     integer     NOT NULL,
    valor       integer     DEFAULT 0
);

ALTER TABLE VotoResposta ADD CONSTRAINT PK_VotoResposta PRIMARY KEY (idResposta, idAutor);
ALTER TABLE VotoResposta ADD CONSTRAINT CK_VotoResposta_Valor CHECK (valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE VotoResposta ADD CONSTRAINT FK_VotoResposta_idResposta FOREIGN KEY (idResposta) REFERENCES Resposta(idResposta) ON DELETE CASCADE;
ALTER TABLE VotoResposta ADD CONSTRAINT FK_VotoResposta_idAutor FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Seguidor (
    idSeguidor  integer     NOT NULL,
    idPergunta  integer     NOT NULL,
    dataInicio  timestamp   DEFAULT current_timestamp,
    dataAcesso  timestamp   DEFAULT current_timestamp
);

ALTER TABLE Seguidor ADD CONSTRAINT PK_Seguidor PRIMARY KEY (idSeguidor, idPergunta);
ALTER TABLE Seguidor ADD CONSTRAINT FK_Seguidor_idSeguidor FOREIGN KEY (idSeguidor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;
ALTER TABLE Seguidor ADD CONSTRAINT FK_Seguidor_idPergunta FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta) ON DELETE CASCADE;

CREATE TABLE Conversa (
    idConversa      serial      NOT NULL,
    idUtilizador1   integer     NOT NULL,
    idUtilizador2   integer     NOT NULL,
    titulo          text        NOT NULL,
    ultimoAcesso1   timestamp   DEFAULT current_timestamp,
    ultimoAcesso2   timestamp   DEFAULT current_timestamp
);

ALTER TABLE Conversa ADD CONSTRAINT PK_Conversa PRIMARY KEY (idConversa);
ALTER TABLE Conversa ADD CONSTRAINT CK_Conversa_AutoresDiferentes CHECK (idUtilizador1 <> idUtilizador2);
ALTER TABLE Conversa ADD CONSTRAINT FK_Conversa_idUtilizador1 FOREIGN KEY (idUtilizador1) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;
ALTER TABLE Conversa ADD CONSTRAINT FK_Conversa_idUtilizador2 FOREIGN KEY (idUtilizador2) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Mensagem (
    idMensagem      serial      NOT NULL,
    idConversa      integer     NOT NULL,
    idAutor         integer     NOT NULL,
    descricao       text        NOT NULL,
    dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Mensagem ADD CONSTRAINT PK_Mensagem PRIMARY KEY (idMensagem);
ALTER TABLE Mensagem ADD CONSTRAINT FK_Mensagem_idConversa FOREIGN KEY (idConversa) REFERENCES Conversa(idConversa) ON DELETE CASCADE;
ALTER TABLE Mensagem ADD CONSTRAINT FK_Mensagem_idAutor FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

CREATE TABLE Report (
    idReport        serial      NOT NULL,
    idModerador     integer     NOT NULL,
    idUtilizador    integer     NOT NULL,
    descricao       text        NOT NULL,
    dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Report ADD CONSTRAINT PK_Report PRIMARY KEY (idReport);
ALTER TABLE Report ADD CONSTRAINT FK_Report_idModerador FOREIGN KEY (idModerador) REFERENCES Moderador(idModerador) ON DELETE CASCADE;
ALTER TABLE Report ADD CONSTRAINT FK_Report_idUtilizador FOREIGN KEY (idUtilizador) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

/*--------------------------------------------*/
/*                   Indices                  */
/*--------------------------------------------*/

DROP INDEX IF EXISTS Contribuicao_IDX_Pesquisa;
DROP INDEX IF EXISTS Pergunta_IDX_Pesquisa;
DROP INDEX IF EXISTS Utilizador_IDX_Pesquisa;
DROP INDEX IF EXISTS Contribuicao_IDX_MaisRecentes;
DROP INDEX IF EXISTS Pergunta_IDX_MaisRecentes;

CREATE INDEX Pergunta_IDX_MaisRecentes ON Pergunta USING btree(dataHora);
CREATE INDEX Contribuicao_IDX_MaisRecentes ON Contribuicao USING btree(dataHora);
CREATE INDEX Utilizador_IDX_Pesquisa ON Utilizador USING gin(to_tsvector('english', username || ' ' || primeiroNome || ' ' || ultimoNome));
CREATE INDEX Pergunta_IDX_Pesquisa ON Pergunta USING gin(to_tsvector('english', titulo || ' ' || coalesce(descricao, '')));
CREATE INDEX Contribuicao_IDX_Pesquisa ON Contribuicao USING gin(to_tsvector('english', descricao));

/*--------------------------------------------*/
/*                    Data                    */
/*--------------------------------------------*/

DELETE FROM Report;
DELETE FROM Mensagem;
DELETE FROM Conversa;
DELETE FROM Seguidor;
DELETE FROM VotoResposta;
DELETE FROM VotoPergunta;
DELETE FROM ComentarioResposta;
DELETE FROM ComentarioPergunta;
DELETE FROM Resposta;
DELETE FROM Contribuicao;
DELETE FROM Pergunta;
DELETE FROM Moderador;
DELETE FROM Administrador;
DELETE FROM Utilizador;
DELETE FROM CategoriaInstituicao;
DELETE FROM Instituicao;
DELETE FROM Categoria;

INSERT INTO Categoria VALUES(1, 'Bioengenharia');
INSERT INTO Categoria VALUES(2, 'Engenharia Ambiente');
INSERT INTO Categoria VALUES(3, 'Engenharia Civil');
INSERT INTO Categoria VALUES(4, 'Engenharia Electrotécnica');
INSERT INTO Categoria VALUES(5, 'Engenharia Informática');
INSERT INTO Categoria VALUES(6, 'Engenharia Industrial');
INSERT INTO Categoria VALUES(7, 'Engenharia Mecânica');
INSERT INTO Categoria VALUES(8, 'Engenharia Metalúrgica');
INSERT INTO Categoria VALUES(9, 'Engenharia Química');
INSERT INTO Categoria VALUES(10, 'Criminologia');
INSERT INTO Categoria VALUES(11, 'Direito');
INSERT INTO Categoria VALUES(12, 'Ciências Forenses');
INSERT INTO Categoria VALUES(13, 'Anatomia');
INSERT INTO Categoria VALUES(14, 'Imunologia');
INSERT INTO Categoria VALUES(15, 'Genética');
INSERT INTO Categoria VALUES(16, 'Psicologia');
INSERT INTO Categoria VALUES(17, 'Medicina Dentária');
INSERT INTO Categoria VALUES(18, 'Medicina Veterinária');
INSERT INTO Categoria VALUES(19, 'Biologia Molecular');
INSERT INTO Categoria VALUES(20, 'Bioquímica');
INSERT INTO Categoria VALUES(21, 'Farmacologia');
INSERT INTO Categoria VALUES(22, 'Atletismo');
INSERT INTO Categoria VALUES(23, 'Basquetebol');
INSERT INTO Categoria VALUES(24, 'Futebol');
INSERT INTO Categoria VALUES(25, 'Gestão Desportiva');
INSERT INTO Categoria VALUES(26, 'Ginástica');
INSERT INTO Categoria VALUES(27, 'Ténis');
INSERT INTO Categoria VALUES(28, 'Agronomia');
INSERT INTO Categoria VALUES(29, 'Astronomia');
INSERT INTO Categoria VALUES(30, 'Física');
INSERT INTO Categoria VALUES(31, 'Geologia');
INSERT INTO Categoria VALUES(32, 'Matemática');
INSERT INTO Categoria VALUES(33, 'Química');
INSERT INTO Categoria VALUES(34, 'Contabilidade');
INSERT INTO Categoria VALUES(35, 'Economia');
INSERT INTO Categoria VALUES(36, 'Finanças');
INSERT INTO Categoria VALUES(37, 'Gestão');
INSERT INTO Categoria VALUES(38, 'Cinema');
INSERT INTO Categoria VALUES(39, 'Design');
INSERT INTO Categoria VALUES(40, 'Escultura');
INSERT INTO Categoria VALUES(41, 'Fotografia');
INSERT INTO Categoria VALUES(42, 'Pintura');
INSERT INTO Categoria VALUES(43, 'Arqueologia');
INSERT INTO Categoria VALUES(44, 'Filosofia');
INSERT INTO Categoria VALUES(45, 'Geografia');
INSERT INTO Categoria VALUES(46, 'História');
INSERT INTO Categoria VALUES(47, 'Inglês');
INSERT INTO Categoria VALUES(48, 'Jornalismo');
INSERT INTO Categoria VALUES(49, 'Linguística');
INSERT INTO Categoria VALUES(50, 'Multimédia');
INSERT INTO Categoria VALUES(51, 'Português');
INSERT INTO Categoria VALUES(52, 'Sociologia');
INSERT INTO Categoria VALUES(53, 'Arquitectura');
INSERT INTO Categoria VALUES(54, 'Arquitectura Paisagista');
INSERT INTO Categoria VALUES(55, 'Património');
INSERT INTO Categoria VALUES(56, 'Nutrição');

INSERT INTO Instituicao VALUES(1, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt');
INSERT INTO Instituicao VALUES(2, 'Faculdade de Arquitectura da Universidade do Porto', 'faup', 'Via Panorâmica Edgar Cardoso s/n, 4150-755 PORTO', '22 605 7100', 'https://sigarra.up.pt/faup/pt');
INSERT INTO Instituicao VALUES(3, 'Faculdade de Belas Artes da Universidade do Porto', 'fbaup', 'Avenida Rodrigues de Freitas 265, 4049-021 PORTO', '22 519 2400', 'https://sigarra.up.pt/fbaup/pt');
INSERT INTO Instituicao VALUES(4, 'Faculdade de Ciências da Nutrição e da Alimentação da Universidade do Porto', 'fcnaup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 507 4320', 'https://sigarra.up.pt/fcnaup/pt');
INSERT INTO Instituicao VALUES(5, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt');
INSERT INTO Instituicao VALUES(6, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt');
INSERT INTO Instituicao VALUES(7, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt');
INSERT INTO Instituicao VALUES(8, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt');
INSERT INTO Instituicao VALUES(9, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt');
INSERT INTO Instituicao VALUES(10, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt');
INSERT INTO Instituicao VALUES(11, 'Faculdade de Medicina Dentária da Universidade do Porto', 'fmdup', 'Rua Dr. Manuel Pereira da Silva s/n, 4200-393 PORTO', '22 090 1100', 'https://sigarra.up.pt/fmdup/pt');
INSERT INTO Instituicao VALUES(12, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Professor Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt');
INSERT INTO Instituicao VALUES(13, 'Faculdade de Psicologia e de Ciências da Educação da Universidade do Porto', 'fpceup', 'Rua Alfredo Allen 525, 4200-135 PORTO', '22 607 9700', 'https://sigarra.up.pt/fpceup/pt');
INSERT INTO Instituicao VALUES(14, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt');

INSERT INTO CategoriaInstituicao VALUES(1, 13);
INSERT INTO CategoriaInstituicao VALUES(1, 22);
INSERT INTO CategoriaInstituicao VALUES(1, 23);
INSERT INTO CategoriaInstituicao VALUES(1, 24);
INSERT INTO CategoriaInstituicao VALUES(1, 25);
INSERT INTO CategoriaInstituicao VALUES(1, 26);
INSERT INTO CategoriaInstituicao VALUES(1, 27);
INSERT INTO CategoriaInstituicao VALUES(1, 56);
INSERT INTO CategoriaInstituicao VALUES(2, 53);
INSERT INTO CategoriaInstituicao VALUES(2, 54);
INSERT INTO CategoriaInstituicao VALUES(2, 55);
INSERT INTO CategoriaInstituicao VALUES(3, 38);
INSERT INTO CategoriaInstituicao VALUES(3, 39);
INSERT INTO CategoriaInstituicao VALUES(3, 40);
INSERT INTO CategoriaInstituicao VALUES(3, 41);
INSERT INTO CategoriaInstituicao VALUES(3, 42);
INSERT INTO CategoriaInstituicao VALUES(3, 48);
INSERT INTO CategoriaInstituicao VALUES(3, 50);
INSERT INTO CategoriaInstituicao VALUES(4, 56);
INSERT INTO CategoriaInstituicao VALUES(5, 2);
INSERT INTO CategoriaInstituicao VALUES(5, 5);
INSERT INTO CategoriaInstituicao VALUES(5, 12);
INSERT INTO CategoriaInstituicao VALUES(5, 15);
INSERT INTO CategoriaInstituicao VALUES(5, 19);
INSERT INTO CategoriaInstituicao VALUES(5, 28);
INSERT INTO CategoriaInstituicao VALUES(5, 29);
INSERT INTO CategoriaInstituicao VALUES(5, 30);
INSERT INTO CategoriaInstituicao VALUES(5, 31);
INSERT INTO CategoriaInstituicao VALUES(5, 32);
INSERT INTO CategoriaInstituicao VALUES(5, 33);
INSERT INTO CategoriaInstituicao VALUES(5, 45);
INSERT INTO CategoriaInstituicao VALUES(5, 50);
INSERT INTO CategoriaInstituicao VALUES(5, 54);
INSERT INTO CategoriaInstituicao VALUES(6, 10);
INSERT INTO CategoriaInstituicao VALUES(6, 11);
INSERT INTO CategoriaInstituicao VALUES(7, 32);
INSERT INTO CategoriaInstituicao VALUES(7, 34);
INSERT INTO CategoriaInstituicao VALUES(7, 35);
INSERT INTO CategoriaInstituicao VALUES(7, 36);
INSERT INTO CategoriaInstituicao VALUES(7, 37);
INSERT INTO CategoriaInstituicao VALUES(8, 1);
INSERT INTO CategoriaInstituicao VALUES(8, 2);
INSERT INTO CategoriaInstituicao VALUES(8, 3);
INSERT INTO CategoriaInstituicao VALUES(8, 4);
INSERT INTO CategoriaInstituicao VALUES(8, 5);
INSERT INTO CategoriaInstituicao VALUES(8, 6);
INSERT INTO CategoriaInstituicao VALUES(8, 7);
INSERT INTO CategoriaInstituicao VALUES(8, 8);
INSERT INTO CategoriaInstituicao VALUES(8, 9);
INSERT INTO CategoriaInstituicao VALUES(8, 30);
INSERT INTO CategoriaInstituicao VALUES(8, 32);
INSERT INTO CategoriaInstituicao VALUES(8, 33);
INSERT INTO CategoriaInstituicao VALUES(8, 50);
INSERT INTO CategoriaInstituicao VALUES(9, 12);
INSERT INTO CategoriaInstituicao VALUES(9, 14);
INSERT INTO CategoriaInstituicao VALUES(9, 19);
INSERT INTO CategoriaInstituicao VALUES(9, 20);
INSERT INTO CategoriaInstituicao VALUES(9, 21);
INSERT INTO CategoriaInstituicao VALUES(10, 38);
INSERT INTO CategoriaInstituicao VALUES(10, 39);
INSERT INTO CategoriaInstituicao VALUES(10, 43);
INSERT INTO CategoriaInstituicao VALUES(10, 44);
INSERT INTO CategoriaInstituicao VALUES(10, 45);
INSERT INTO CategoriaInstituicao VALUES(10, 46);
INSERT INTO CategoriaInstituicao VALUES(10, 47);
INSERT INTO CategoriaInstituicao VALUES(10, 48);
INSERT INTO CategoriaInstituicao VALUES(10, 49);
INSERT INTO CategoriaInstituicao VALUES(10, 50);
INSERT INTO CategoriaInstituicao VALUES(10, 51);
INSERT INTO CategoriaInstituicao VALUES(10, 52);
INSERT INTO CategoriaInstituicao VALUES(10, 55);
INSERT INTO CategoriaInstituicao VALUES(11, 12);
INSERT INTO CategoriaInstituicao VALUES(11, 13);
INSERT INTO CategoriaInstituicao VALUES(11, 17);
INSERT INTO CategoriaInstituicao VALUES(12, 12);
INSERT INTO CategoriaInstituicao VALUES(12, 13);
INSERT INTO CategoriaInstituicao VALUES(12, 14);
INSERT INTO CategoriaInstituicao VALUES(12, 15);
INSERT INTO CategoriaInstituicao VALUES(12, 16);
INSERT INTO CategoriaInstituicao VALUES(12, 17);
INSERT INTO CategoriaInstituicao VALUES(12, 19);
INSERT INTO CategoriaInstituicao VALUES(12, 20);
INSERT INTO CategoriaInstituicao VALUES(12, 21);
INSERT INTO CategoriaInstituicao VALUES(13, 12);
INSERT INTO CategoriaInstituicao VALUES(13, 16);
INSERT INTO CategoriaInstituicao VALUES(13, 40);
INSERT INTO CategoriaInstituicao VALUES(13, 44);
INSERT INTO CategoriaInstituicao VALUES(13, 52);
INSERT INTO CategoriaInstituicao VALUES(14, 1);
INSERT INTO CategoriaInstituicao VALUES(14, 12);
INSERT INTO CategoriaInstituicao VALUES(14, 13);
INSERT INTO CategoriaInstituicao VALUES(14, 14);
INSERT INTO CategoriaInstituicao VALUES(14, 15);
INSERT INTO CategoriaInstituicao VALUES(14, 16);
INSERT INTO CategoriaInstituicao VALUES(14, 17);
INSERT INTO CategoriaInstituicao VALUES(14, 18);
INSERT INTO CategoriaInstituicao VALUES(14, 19);
INSERT INTO CategoriaInstituicao VALUES(14, 20);
INSERT INTO CategoriaInstituicao VALUES(14, 21);

INSERT INTO Utilizador VALUES(1, NULL, 'admin', 'seguranca1234', 'contact@knowup.pt', 'Administrador', 'NULL', 'Porto', 'pt', '2014-10-23 12:30:04', '2016-06-11 14:38:55', false, true);
INSERT INTO Utilizador VALUES(2, 8, 'marques999', '14191091', 'up201305642@fe.up.pt', 'Diogo', 'Marques', 'Valongo', 'pt', '2015-01-21 12:30:04', '2016-06-15 04:48:42', false, true);
INSERT INTO Utilizador VALUES(3, 8, 'mellus', 'werther', 'up201305618@fe.up.pt', 'Pedro', 'Melo', 'Penafiel', 'pt', '2015-03-02 12:30:04', '2016-06-17 17:16:18', false, true);
INSERT INTO Utilizador VALUES(4, 8, 'darklord', 'soutroll1', 'up201303104@fe.up.pt', 'Vitor', 'Esteves', 'Mirandela', 'pt', '2015-04-13 12:30:04', '2016-06-16 12:41:25', false, true);
INSERT INTO Utilizador VALUES(5, 3, 'picasso', 'xaguarelax', 'pintobem@guernica.es', 'Pablo', 'Picasso', 'Málaga', 'es', '2015-04-21 14:40:23', '2016-06-17 20:36:21', false, true);
INSERT INTO Utilizador VALUES(6, 9, 'penicilina', 'cur4tud0', 'tratamento@eficaz.co.uk', 'Alexander', 'Fleming', 'Lochfield', 'uk', '2015-06-12 14:43:49', '2016-06-10 15:23:03', true, true);
INSERT INTO Utilizador VALUES(7, 7, 'marchista', '18capital67', 'tustaum@karlmail.de', 'Karl', 'Marx', 'Trier', 'de', '2015-07-12 14:46:02', '2016-06-15 19:50:34', false, true);
INSERT INTO Utilizador VALUES(8, 14, 'bolinhas', 'purr9876', 'whiskas_saquetas@neko.jp', 'Gato', 'Preto', 'Saitama', 'jp', '2015-08-14 14:49:33', '2016-06-14 15:23:49', false, true);

INSERT INTO Administrador VALUES(1);

INSERT INTO Moderador VALUES(2);
INSERT INTO Moderador VALUES(3);
INSERT INTO Moderador VALUES(5);

INSERT INTO Pergunta VALUES(1, 54, 8, 'Qual o tamanho dos vários tipos principais de folhas em pixels?', 'Necessito de saber o tamanho exacto, em pixeis dos tamanhos de folhas A3, A4 e A5 para saber qual a mais adequada para o meu projeto de desenho', '2016-03-21 14:30:07', false);
INSERT INTO Pergunta VALUES(2, 12, 4, 'O que fazer no final do curso?', 'Bom dia, gostaria de saber se terminar o meu curso com média superior a 18 poderia ir trabalhar para o CSI em Miami?', '2016-04-10 16:45:22', true);
INSERT INTO Pergunta VALUES(3, 55, 2, 'O que fazer quando tudo o resto falha?', '<p>O meu projeto de ordenamento do território em Valongo estava a correr sobre rodas, até que me deparei com um grave problema:</p><p>A migração da pecuária, especialmente gado bovino, está a destruir o parque da escola preparatória de Valongo.</p><p>As crianças foram contaminadas devido ao contacto com os dejectos que os animais amontoavam no escorrega.</p><p>Gostaria assim de perguntar aos estudantes de direito que acção legal poderia tomar contra os pastores locais.', '2015-09-23 16:45:22', true);
INSERT INTO Pergunta VALUES(4, 17, 6, 'Qual o numero de dentes de um ser humano adulto?', NULL, '2015-11-10 19:44:32', false);
INSERT INTO Pergunta VALUES(5, 28, 2, 'Como faço para mudar de curso?', 'Gostaria de saber quais os requisitos para mudar para o curso de Agronomia. Estou desapontado com a minha escolha e gostaria de mudar', '2015-09-25 04:23:54', true);
INSERT INTO Pergunta VALUES(6, 13, 3, 'Dor de cabeça: Ibuprofeno ou paracetamol?', 'Ultimamente tenho tido dores de cabeça enquanto estudo e gostaria de saber se deveria tomar ibuprofeno ou paracetamol', '2015-09-25 14:56:43', false);
INSERT INTO Pergunta VALUES(7, 5, 7, 'O que significa ASCII?', NULL, '2016-01-10 19:44:32', true);
INSERT INTO Pergunta VALUES(8, 42, 5, 'Lápis normal ou lápis de cera?', 'Quero saber qual o mais adequado para uma pintura rupestre de Penafiel. Obrigado!', '2015-12-24 19:43:32', false);
INSERT INTO Pergunta VALUES(9, 38, 8, 'Alguma ideia para uma curta metragem?', 'Need help! Please answer fast...', '2016-03-23 17:43:52', true);
INSERT INTO Pergunta VALUES(10, 24, 7, 'Tópicos externos', 'Boa noite, queria saber se é permitido discutir assuntos futebolísticos dentro da comunidade não relacionados diretamente com a faculdade...', '2016-03-24 19:40:10', false);

INSERT INTO Contribuicao VALUES(1, 7, '1 cm equivale a 28,34 pixels. Sendo assim, 1 mm equivale a 2,83 pixels. Confira abaixo o tamanho da Folha A4, em pixels: <br> Folha A4: <br> 2480 px de largura <br> 3508 px de altura <br> <br> Folha A3: <br> 3508 px de largura <br> 4960 px de altura <br> <br> Folha A5: <br> 1754 px de largura <br> 2480 px de altura', '2016-03-21 14:35:33');
INSERT INTO Contribuicao VALUES(2, 8, 'Muito obrigado, rápido e esclarecedor como sempre!', '2016-03-21 14:49:33');
INSERT INTO Contribuicao VALUES(3, 5, 'Um humano adulto tem normalmente 32 dentes, dezesseis na mandíbula e dezesseis na maxila.', '2015-11-10 20:42:45');
INSERT INTO Contribuicao VALUES(4, 5, 'Na minha opinião devias tomar paracetamol.', '2015-09-25 14:58:01');
INSERT INTO Contribuicao VALUES(5, 2, 'Eu acho que devia ser ibuprofeno, também é anti-inflamatório!','2015-09-25 15:02:13');
INSERT INTO Contribuicao VALUES(6, 5, 'Se a dor for leve, apesar de constante, penso que o mais aconselhado seria paracetamol, pois é menos prejudicial à saude @marques999', '2015-09-25 15:05:46');
INSERT INTO Contribuicao VALUES(7, 2, 'Sim, de certa forma tens razão, ainda que ele possa ter uma inflamação. Eu diria ibuprofeno pois também é anti-inflamatório. Se não tomar muitas vezes nao há problemas @darklord', '2015-09-25 15:26:53');
INSERT INTO Contribuicao VALUES(8, 5, 'A dor é muito forte? @mellus', '2015-09-25 15:30:22');
INSERT INTO Contribuicao VALUES(9, 6, 'Não, só que como é persistente perturba-me o estudo', '2015-09-25 18:20:10');
INSERT INTO Contribuicao VALUES(10, 5, 'Então o paracetamol é o mais indicado devido à falta de outros sintomas @mellus @marques999', '2015-09-25 19:41:21');
INSERT INTO Contribuicao VALUES(11, 6, 'Muito obrigado! PS: Qual é a farmácia mais próxima do S.João?', '2015-09-25 20:36:41');
INSERT INTO Contribuicao VALUES(12, 2, 'Vai ao Amial, há uma aberta de certeza.', '2015-09-25 20:40:12');
INSERT INTO Contribuicao VALUES(13, 5, '<blockquote>ASCII (acrónimo para <em>American Standard Code for Information Interchange</em>, que em português significa "código padrão americano para intercâmbio de informação", mas comumente utilizamos a sigla em inglês para referencia direta) é uma codificação de caracteres de sete bits baseada no alfabeto inglês.</blockquote><p>Fonte: <a href="http://pt.stackoverflow.com/tags/ascii/info">Wikipédia</a></p>', '2016-01-10 21:14:22');
INSERT INTO Contribuicao VALUES(14, 6, 'Preciso de fazer algum <em>include<em> para usar no meu codigo em C++?','2016-01-11 09:54:09');
INSERT INTO Contribuicao VALUES(15, 8, 'Tendo em conta a minha experiência em uso de todo o tipo de lápis, aconselho cera para ambientes rurais, e normal para ambientes urbanos. Cabe agora a ti descobrir que paisagem queres pintar exatamente.', '2015-12-24 22:22:22');
INSERT INTO Contribuicao VALUES(16, 5, '<em>Star Wars</em> é sempre um bom tema...', '2016-03-24 19:43:32');
INSERT INTO Contribuicao VALUES(17, 3, 'Papel cor-de-rosa dava um bom nome. Em relação ao tema, aproveitando a ideia do @darklord eu diria uma comédia romântica com bonecos do <em>Star Wars</em>. Deve ser incrivel!!!', '2016-03-24 20:11:52');
INSERT INTO Contribuicao VALUES(18, 2, 'Desde que cumpra as normas deste website, sim é permitido.', '2016-04-10 19:43:32');
INSERT INTO Contribuicao VALUES(19, 7, 'Obrigado, tentarei sempre seguir as regras!', '2016-04-10 20:41:14');

INSERT INTO Resposta VALUES(1, 1, true);
INSERT INTO Resposta VALUES(3, 4, true);
INSERT INTO Resposta VALUES(4, 6, false);
INSERT INTO Resposta VALUES(5, 6, false);
INSERT INTO Resposta VALUES(6, 6, false);
INSERT INTO Resposta VALUES(7, 6, false);
INSERT INTO Resposta VALUES(10, 6, true);
INSERT INTO Resposta VALUES(13, 7, false);
INSERT INTO Resposta VALUES(14, 7, false);
INSERT INTO Resposta VALUES(15, 8, true);
INSERT INTO Resposta VALUES(16, 9, false);
INSERT INTO Resposta VALUES(17, 9, false);
INSERT INTO Resposta VALUES(18, 10, false);

INSERT INTO Seguidor VALUES(8, 1, '2016-03-21 14:30:07', '2016-04-01 17:10:08');
INSERT INTO Seguidor VALUES(7, 1, '2016-03-21 14:35:33', '2016-03-22 09:14:59');
INSERT INTO Seguidor VALUES(4, 2, '2016-04-10 16:45:22', '2016-04-15 08:08:38');
INSERT INTO Seguidor VALUES(2, 3, '2015-09-23 16:45:22', '2016-02-24 12:18:05');
INSERT INTO Seguidor VALUES(6, 4, '2015-11-10 19:44:32', '2016-01-02 19:38:22');
INSERT INTO Seguidor VALUES(5, 4, '2015-11-10 20:42:45', '2016-04-07 05:22:32');
INSERT INTO Seguidor VALUES(2, 5, '2015-09-25 04:23:54', '2016-02-24 07:52:20');
INSERT INTO Seguidor VALUES(3, 6, '2015-09-25 14:56:43', '2015-12-24 02:32:12');
INSERT INTO Seguidor VALUES(5, 6, '2015-09-25 15:05:46', '2016-04-25 18:26:44');
INSERT INTO Seguidor VALUES(2, 6, '2015-09-25 15:26:53', '2016-02-24 22:42:54');
INSERT INTO Seguidor VALUES(7, 7, '2016-01-10 19:44:32', '2016-06-09 15:32:47');
INSERT INTO Seguidor VALUES(5, 7, '2016-01-10 21:14:22', '2016-04-01 23:02:30');
INSERT INTO Seguidor VALUES(6, 7, '2016-01-11 09:54:09', '2016-01-12 18:38:10');
INSERT INTO Seguidor VALUES(5, 8, '2015-12-24 19:43:32', '2016-05-23 20:56:57');
INSERT INTO Seguidor VALUES(8, 8, '2015-12-24 22:22:22', '2016-04-30 11:24:37');
INSERT INTO Seguidor VALUES(8, 9, '2016-03-23 17:43:52', '2016-04-17 16:00:51');
INSERT INTO Seguidor VALUES(5, 9, '2016-03-24 19:43:32', '2016-04-12 04:44:26');
INSERT INTO Seguidor VALUES(3, 9, '2016-03-24 20:11:41', '2016-03-28 10:12:19');
INSERT INTO Seguidor VALUES(7, 10, '2016-03-24 19:40:10', '2016-06-09 04:22:36');
INSERT INTO Seguidor VALUES(2, 10, '2016-04-10 19:43:32', '2016-02-24 17:20:53');

INSERT INTO ComentarioPergunta VALUES(8, 6);
INSERT INTO ComentarioPergunta VALUES(9, 6);

INSERT INTO ComentarioResposta VALUES(2, 1);
INSERT INTO ComentarioResposta VALUES(11, 10);
INSERT INTO ComentarioResposta VALUES(12, 10);
INSERT INTO ComentarioResposta VALUES(19, 10);

INSERT INTO VotoPergunta VALUES(1, 4, 1);
INSERT INTO VotoPergunta VALUES(1, 5, 1);
INSERT INTO VotoPergunta VALUES(1, 8, 1);
INSERT INTO VotoPergunta VALUES(3, 2, -1);
INSERT INTO VotoPergunta VALUES(3, 3, -1);
INSERT INTO VotoPergunta VALUES(3, 4, -1);
INSERT INTO VotoPergunta VALUES(3, 5, -1);
INSERT INTO VotoPergunta VALUES(3, 6, -1);
INSERT INTO VotoPergunta VALUES(3, 7, -1);
INSERT INTO VotoPergunta VALUES(3, 8, -1);
INSERT INTO VotoPergunta VALUES(4, 2, -1);
INSERT INTO VotoPergunta VALUES(4, 3, 1);
INSERT INTO VotoPergunta VALUES(4, 4, 1);
INSERT INTO VotoPergunta VALUES(4, 7, 1);
INSERT INTO VotoPergunta VALUES(4, 8, -1);
INSERT INTO VotoPergunta VALUES(5, 3, -1);
INSERT INTO VotoPergunta VALUES(5, 4, -1);
INSERT INTO VotoPergunta VALUES(5, 7, -1);
INSERT INTO VotoPergunta VALUES(5, 8, 1);
INSERT INTO VotoPergunta VALUES(6, 2, 1);
INSERT INTO VotoPergunta VALUES(6, 3, 1);
INSERT INTO VotoPergunta VALUES(6, 4, 1);
INSERT INTO VotoPergunta VALUES(6, 5, 1);
INSERT INTO VotoPergunta VALUES(6, 6, -1);
INSERT INTO VotoPergunta VALUES(6, 8, 1);
INSERT INTO VotoPergunta VALUES(7, 2, -1);
INSERT INTO VotoPergunta VALUES(7, 3, -1);
INSERT INTO VotoPergunta VALUES(7, 5, 1);
INSERT INTO VotoPergunta VALUES(7, 7, 1);
INSERT INTO VotoPergunta VALUES(7, 8, -1);
INSERT INTO VotoPergunta VALUES(8, 3, 1);
INSERT INTO VotoPergunta VALUES(8, 8, 1);
INSERT INTO VotoPergunta VALUES(9, 2, 1);
INSERT INTO VotoPergunta VALUES(9, 3, 1);
INSERT INTO VotoPergunta VALUES(9, 4, 1);
INSERT INTO VotoPergunta VALUES(9, 6, 1);
INSERT INTO VotoPergunta VALUES(9, 8, 1);
INSERT INTO VotoPergunta VALUES(10, 2, 1);

INSERT INTO VotoResposta VALUES(1, 2, -1);
INSERT INTO VotoResposta VALUES(1, 4, -1);
INSERT INTO VotoResposta VALUES(1, 8, 1);
INSERT INTO VotoResposta VALUES(3, 3, 1);
INSERT INTO VotoResposta VALUES(3, 6, 1);
INSERT INTO VotoResposta VALUES(5, 3, 1);
INSERT INTO VotoResposta VALUES(5, 4, 1);
INSERT INTO VotoResposta VALUES(5, 8, 1);
INSERT INTO VotoResposta VALUES(6, 3, 1);
INSERT INTO VotoResposta VALUES(6, 7, 1);
INSERT INTO VotoResposta VALUES(7, 3, 1);
INSERT INTO VotoResposta VALUES(7, 5, 1);
INSERT INTO VotoResposta VALUES(10, 2, 1);
INSERT INTO VotoResposta VALUES(10, 3, 1);
INSERT INTO VotoResposta VALUES(10, 4, 1);
INSERT INTO VotoResposta VALUES(10, 6, 1);
INSERT INTO VotoResposta VALUES(10, 7, 1);
INSERT INTO VotoResposta VALUES(13, 6, 1);
INSERT INTO VotoResposta VALUES(13, 7, 1);
INSERT INTO VotoResposta VALUES(14, 2, -1);
INSERT INTO VotoResposta VALUES(14, 3, -1);
INSERT INTO VotoResposta VALUES(14, 4, -1);
INSERT INTO VotoResposta VALUES(14, 5, -1);
INSERT INTO VotoResposta VALUES(14, 7, -1);
INSERT INTO VotoResposta VALUES(15, 5, 1);
INSERT INTO VotoResposta VALUES(16, 2, 1);
INSERT INTO VotoResposta VALUES(16, 3, 1);
INSERT INTO VotoResposta VALUES(16, 4, -1);
INSERT INTO VotoResposta VALUES(16, 7, -1);
INSERT INTO VotoResposta VALUES(16, 8, -1);
INSERT INTO VotoResposta VALUES(17, 2, 1);
INSERT INTO VotoResposta VALUES(17, 4, 1);
INSERT INTO VotoResposta VALUES(17, 5, 1);
INSERT INTO VotoResposta VALUES(17, 8, -1);
INSERT INTO VotoResposta VALUES(18, 6, 1);
INSERT INTO VotoResposta VALUES(18, 7, 1);

INSERT INTO Conversa VALUES(1, 3, 2, 'URGENTE', '2015-11-09 14:49:43', '2016-04-06 23:59:11');
INSERT INTO Conversa VALUES(2, 3, 4, 'URGENTE TAMBÉM', '2015-11-09 15:13:08', '2015-11-09 15:15:23');
INSERT INTO Conversa VALUES(3, 5, 7, 'Pintura', '2015-12-21 10:23:27', '2015-12-21 11:36:52');
INSERT INTO Conversa VALUES(4, 8, 2, 'Parabéns!!!', '2016-04-07 09:52:17', '2016-04-07 09:52:49');
INSERT INTO Conversa VALUES(5, 3, 2, 'PARABÉNS!!!!!', '2016-04-07 09:54:12', '2016-04-07 09:53:44');
INSERT INTO Conversa VALUES(6, 6, 4, 'presente de aniversário', '2016-04-07 12:30:06', '2016-05-21 11:34:50');

INSERT INTO Mensagem VALUES(1, 1, 3, 'Olá! Por acaso não sabes se na papelaria vendem papel cor-de-rosa às riscas?', '2015-11-09 14:49:43');
INSERT INTO Mensagem VALUES(2, 1, 2, 'Não te sei dizer, mas acho que o @darklord chegou a ir lá comprar. Porque não lhe perguntas?', '2015-11-09 14:52:01');
INSERT INTO Mensagem VALUES(3, 2, 3, 'Boas darklord, o @marques999 disse-me que tinhas comprado um papel rosa às riscas na papelaria da faculdade. É verdade? Quanto custou?', '2015-11-09 14:58:33');
INSERT INTO Mensagem VALUES(4, 2, 4, 'Custa 19,99 patacas. Melhor cena da faculdade. Melhores desenhos da minha vida x)', '2015-11-09 15:07:58');
INSERT INTO Mensagem VALUES(5, 2, 3, 'Brigado :-D. Vou já comprar!!!', '2015-11-09 15:13:08');
INSERT INTO Mensagem VALUES(6, 3, 5, 'Hola! Fiz aqui uns rabiscos da tua cara, ficaram mesmo à patrão. Queres passar aqui em casa para os ver?', '2015-12-21 07:49:12');
INSERT INTO Mensagem VALUES(7, 3, 7,'Guten Tag meu camarada. Achas que isso dá para vender?', '2015-12-21 08:30:15');
INSERT INTO Mensagem VALUES(8, 3, 5, 'Não sei, mas estão bem guapos. Queres passar por aqui ou não?', '2015-12-21 08:31:23');
INSERT INTO Mensagem VALUES(9, 3, 7, 'A caminho camarada. Faz mais que é para dar a toda a gente.', '2015-12-21 10:22:59');

INSERT INTO Mensagem VALUES(10, 4, 8, 'Feliz aniversário! Diverte-te muito!', '2016-04-07 09:42:35');
INSERT INTO Mensagem VALUES(11, 5, 3, 'Parabéns @marques999, estás a ficar velho rapaz!', '2016-04-07 09:45:26');
INSERT INTO Mensagem VALUES(12, 6, 6, 'Olha @darklord, que prenda é que devo levar para o aniversário do @marques999?', '2016-04-07 09:50:47');
INSERT INTO Mensagem VALUES(13, 4, 2, 'Obrigado Gato Preto! :D Logo à noite há bolo de morango se quiseres...', '2016-04-07 09:52:19');
INSERT INTO Mensagem VALUES(14, 5, 2, 'Obrigado Pedro Melo! :D Logo à noite há bolo de morango se quiseres...', '2016-04-07 09:53:44');
INSERT INTO Mensagem VALUES(15, 6, 4, 'Tenho aqui um papel cor-de-rosa todo bonito, acho que ele vai gostar x)', '2016-04-07 11:25:31');

INSERT INTO Report VALUES(1, 5, 7, 'O utilizador estava a tentar erguer uma estátua de Lenin num comentário recorrendo a tracinhos e pontos.', '2015-12-24 15:45:41');
INSERT INTO Report VALUES(2, 5, 4, 'O utilizador estava a ser demasiado awesome.', '2016-03-04 21:57:21');
INSERT INTO Report VALUES(3, 2, 3, 'O utilizador foi apanhado numa rede de tráfico de enciclopédias.', '2016-03-21 15:43:09');
INSERT INTO Report VALUES(4, 3, 6, 'O utilizador estava a tentar pintar como Bob Ross mas esqueceu-se de acrescentar roupa aos personagens...', '2016-04-11 12:10:22');

/*--------------------------------------------*/
/*                 Funções                    */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION registarVotoPergunta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoPergunta$
BEGIN
    IF ($3 = 0) THEN
        RETURN FALSE;
    END IF;
    IF EXISTS(SELECT 1 FROM VotoPergunta WHERE idPergunta = $1 AND idAutor = $2) THEN
        UPDATE VotoPergunta
        SET valor = $3 WHERE (idPergunta = $1 AND idAutor = $2);
        RETURN TRUE;
    ELSE
        INSERT INTO VotoPergunta(idPergunta, idAutor, valor)
        VALUES ($1, $2, $3);
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;

$registarVotoPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION registarVotoResposta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoResposta$
BEGIN
    IF ($3 = 0) THEN
        RETURN FALSE;
    END IF;
    IF EXISTS(SELECT 1 FROM VotoResposta WHERE idResposta = $1 AND idAutor = $2) THEN
        UPDATE VotoResposta
        SET valor = $3 WHERE (idResposta = $1 AND idAutor = $2);
        RETURN TRUE;
    ELSE
        INSERT INTO VotoResposta(idResposta, idAutor, valor)
        VALUES ($1, $2, $3);
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;

$registarVotoResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcularPontuacaoPergunta(INTEGER)
RETURNS TABLE(votosPositivos BIGINT, votosNegativos BIGINT, pontuacao BIGINT)
AS $calcularPontuacaoPergunta$
BEGIN
    RETURN QUERY (SELECT TabelaVotos.*, TabelaVotos.votosPositivos - TabelaVotos.votosNegativos FROM
        (SELECT
        COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
        COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos
    FROM VotoPergunta WHERE idPergunta = $1) AS TabelaVotos);
END;

$calcularPontuacaoPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcularPontuacaoResposta(INTEGER)
RETURNS TABLE(votosPositivos BIGINT, votosNegativos BIGINT, pontuacao BIGINT)
AS $calcularPontuacaoResposta$
BEGIN
    RETURN QUERY (SELECT TabelaVotos.*, TabelaVotos.votosPositivos + TabelaVotos.votosNegativos FROM
        (SELECT
        COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
        COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos
    FROM VotoResposta WHERE idResposta = $1) AS TabelaVotos);
END;

$calcularPontuacaoResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION numeroComentariosPergunta(INTEGER)
RETURNS INTEGER AS $numeroComentariosPergunta$
BEGIN
    RETURN (SELECT COALESCE((SELECT COUNT(*) FROM ComentarioPergunta WHERE idPergunta = $1), 0));
END;

$numeroComentariosPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION numeroComentariosResposta(INTEGER)
RETURNS INTEGER AS $numeroComentariosResposta$
BEGIN
    RETURN (SELECT COALESCE((SELECT COUNT(*) FROM ComentarioResposta WHERE idResposta = $1), 0));
END;

$numeroComentariosResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION numeroSeguidores(INTEGER)
RETURNS INTEGER AS $numeroSeguidores$
BEGIN
    RETURN (SELECT COALESCE((SELECT COUNT(*) FROM Seguidor WHERE idPergunta = $1), 0));
END;

$numeroSeguidores$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION visitarPergunta(integer, integer)
RETURNS VOID AS $visitarPergunta$
BEGIN
    UPDATE Seguidor
    SET dataAcesso = now()
    WHERE idPergunta = $1 AND idSeguidor = $2;
    RETURN;
END;

$visitarPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION lerMensagens(integer, integer)
RETURNS VOID AS $lerMensagens$
BEGIN
    UPDATE Conversa
    SET ultimoAcesso1 = now()
    WHERE idConversa = $1 AND idUtilizador1 = $2;
    UPDATE Conversa
    SET ultimoAcesso2 = now()
    WHERE idConversa = $1 AND idUtilizador2 = $2;
    RETURN;
END;

$lerMensagens$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*                  Triggers                  */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION votarPropriaPergunta() RETURNS trigger AS $votarPropriaPergunta$
DECLARE
    AutorPergunta integer;
BEGIN
    SELECT Pergunta.idAutor INTO AutorPergunta
    FROM Pergunta WHERE Pergunta.idPergunta = NEW.idPergunta;
    IF (AutorPergunta = NEW.idAutor) THEN
        RAISE EXCEPTION 'não pode classificar as suas próprias perguntas!';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$votarPropriaPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_votarPropriaPergunta
    BEFORE INSERT ON VotoPergunta
    FOR EACH ROW
    EXECUTE PROCEDURE votarPropriaPergunta();

CREATE OR REPLACE FUNCTION votarPropriaResposta()
RETURNS TRIGGER AS $votarPropriaResposta$
DECLARE
    AutorResposta integer;
BEGIN
    SELECT Contribuicao.idAutor INTO AutorResposta
    FROM Resposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    WHERE Resposta.idResposta = NEW.idResposta;
    IF (AutorResposta = NEW.idAutor) THEN
        RAISE EXCEPTION 'não pode classificar as suas próprias respostas!';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$votarPropriaResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_votarPropriaResposta
    BEFORE INSERT ON VotoResposta
    FOR EACH ROW
    EXECUTE PROCEDURE votarPropriaResposta();

CREATE OR REPLACE FUNCTION responderPergunta()
RETURNS TRIGGER AS $responderPergunta$
DECLARE
    AutorPergunta INTEGER;
    AutorResposta INTEGER;
    PerguntaActiva BOOLEAN;
BEGIN
    SELECT Pergunta.ativa INTO PerguntaActiva
    FROM Pergunta WHERE NEW.idPergunta = Pergunta.idPergunta
    LIMIT 1;
    IF (NOT PerguntaActiva) THEN
        RAISE EXCEPTION 'não pode responder a uma pergunta fechada!';
        RETURN NULL;
    END IF;
    SELECT Pergunta.idAutor INTO AutorPergunta
    FROM Pergunta WHERE Pergunta.idPergunta = NEW.idPergunta
    LIMIT 1;
    SELECT Contribuicao.idAutor INTO AutorResposta
    FROM Contribuicao WHERE Contribuicao.idContribuicao = NEW.idResposta
    LIMIT 1;
    IF (AutorResposta = AutorPergunta) THEN
        RAISE EXCEPTION 'não pode responder às suas próprias perguntas!';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$responderPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_responderPergunta
    BEFORE INSERT ON Resposta
    FOR EACH ROW
    EXECUTE PROCEDURE responderPergunta();

CREATE OR REPLACE FUNCTION melhorResposta()
RETURNS TRIGGER AS $melhorResposta$
BEGIN
    IF EXISTS (SELECT 1 FROM Resposta WHERE Resposta.melhorResposta AND Resposta.idPergunta = NEW.idPergunta) THEN
        UPDATE Resposta SET melhorResposta = FALSE
        WHERE Resposta.melhorResposta AND Resposta.idPergunta = NEW.idPergunta;
    END IF;
    RETURN NEW;
END;

$melhorResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_melhorResposta
    BEFORE UPDATE OF melhorResposta ON Resposta
    FOR EACH ROW
    WHEN (NEW.melhorResposta AND NOT OLD.melhorResposta)
    EXECUTE PROCEDURE melhorResposta();

CREATE OR REPLACE FUNCTION overlapAdministrador()
RETURNS TRIGGER AS $overlapAdministrador$
BEGIN
    IF EXISTS (SELECT 1 FROM Moderador WHERE Moderador.idModerador = NEW.idAdministrador) THEN
        DELETE FROM Moderador WHERE Moderador.idModerador = NEW.idAdministrador;
    END IF;
    RETURN NEW;
END;

$overlapAdministrador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_overlapAdministrador
    BEFORE INSERT OR UPDATE ON Administrador
    FOR EACH ROW
    EXECUTE PROCEDURE overlapAdministrador();

CREATE OR REPLACE FUNCTION overlapModerador()
RETURNS TRIGGER AS $overlapModerador$
BEGIN
    IF EXISTS (SELECT 1 FROM Administrador WHERE Administrador.idAdministrador = NEW.idModerador) THEN
        DELETE FROM Administrador WHERE Administrador.idAdministrador = NEW.idModerador;
    END IF;
    RETURN NEW;
END;

$overlapModerador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_overlapModerador
    BEFORE INSERT OR UPDATE ON Moderador
    FOR EACH ROW
    EXECUTE PROCEDURE overlapModerador();

CREATE OR REPLACE FUNCTION autofollowPergunta()
RETURNS TRIGGER AS $autofollowPergunta$
BEGIN
    INSERT INTO Seguidor(idSeguidor, idPergunta, dataInicio, dataAcesso)
    VALUES(NEW.idAutor, NEW.idPergunta, NEW.dataHora, NEW.dataHora);
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowPergunta
    AFTER INSERT ON Pergunta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowPergunta();

CREATE OR REPLACE FUNCTION autofollowResposta()
RETURNS TRIGGER AS $autofollowResposta$
BEGIN
    INSERT INTO Seguidor
    SELECT Contribuicao.idAutor, NEW.idPergunta, Contribuicao.dataHora, Contribuicao.dataHora
    FROM Contribuicao
    WHERE Contribuicao.idContribuicao = NEW.idResposta
    LIMIT 1;
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowResposta
    AFTER INSERT ON Resposta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowResposta();

CREATE OR REPLACE FUNCTION autofollowComentario()
RETURNS TRIGGER AS $autofollowComentario$
BEGIN
    INSERT INTO Seguidor
    SELECT Contribuicao.idAutor, NEW.idPergunta, Contribuicao.dataHora, Contribuicao.dataHora
    FROM Contribuicao
    WHERE Contribuicao.idContribuicao = NEW.idPergunta
    LIMIT 1;
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowComentario$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowComentario
    AFTER INSERT ON ComentarioPergunta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowComentario();

    DROP VIEW IF EXISTS PerguntasMaisVistas;
DROP VIEW IF EXISTS PerguntasMelhorClassificadas;

/*--------------------------------------------*/
/*                    Views                   */
/*--------------------------------------------*/

CREATE VIEW PerguntasMelhorClassificadas AS
SELECT * FROM (SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Pergunta.titulo,
    Pergunta.descricao,
    Pergunta.dataHora,
    Pergunta.ativa
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor)
AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta)
ORDER BY pontuacao DESC;