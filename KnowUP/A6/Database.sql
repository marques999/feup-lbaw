BEGIN TRANSACTION;
CREATE TABLE `Moderadores` (
	`idModerador`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idUtilizador`	INTEGER UNIQUE,
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUser)
);
CREATE TABLE `Mensagens` (
	`idThread`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idAutor`	INTEGER NOT NULL,
	`content`	TEXT NOT NULL,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUser)
);
CREATE TABLE "Administradores" (
	`idAdministrador`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idUtilizador`	INTEGER UNIQUE,
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
INSERT INTO "Administradores" VALUES(1,1);
CREATE TABLE "VotosRespostas" (
	`idResposta`	INTEGER NOT NULL UNIQUE,
	`idUtilizador`	INTEGER NOT NULL,
	`score`	INTEGER DEFAULT 1 CHECK(score = - 1 OR score = 1),
	PRIMARY KEY(idResposta,idUtilizador),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas ( idResposta ),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores ( idUtilizador )
);
CREATE TABLE "VotosPerguntas" (
	`idPergunta`	INTEGER NOT NULL,
	`idUtilizador`	INTEGER NOT NULL,
	`score`	INTEGER DEFAULT 1 CHECK(score = - 1 OR score = 1),
	PRIMARY KEY(idPergunta,idUtilizador),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas ( idPergunta ),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores ( idUtilizador )
);
CREATE TABLE "Threads" (
	`idUtilizador1`	INTEGER,
	`idUtilizador2`	INTEGER,
	`lastMessage`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(idUtilizador1,idUtilizador2),
	FOREIGN KEY(`idUtilizador1`) REFERENCES Utilizadores ( idUtilizador ),
	FOREIGN KEY(`idUtilizador2`) REFERENCES Utilizadores ( idUtilizador ),
	FOREIGN KEY(`lastMessage`) REFERENCES Mensagens ( idMensagem )
);
CREATE TABLE "Respostas" (
	`idResposta`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idPergunta`	INTEGER NOT NULL,
	`idAutor`	INTEGER NOT NULL,
	`content`	TEXT NOT NULL,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp > 0),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas ( idPergunta ),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores ( idUtilizador )
);
INSERT INTO "Respostas" VALUES(1,0,0,'',NULL);
CREATE TABLE "Followers" (
	`idMembro`	INTEGER,
	`idPergunta`	INTEGER,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	PRIMARY KEY(idMembro,idPergunta),
	FOREIGN KEY(`idMembro`) REFERENCES Utilizadores ( idUtilizador ),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas ( idPergunta )
);
CREATE TABLE "ComentariosRespostas" (
	`idCR`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idResposta`	INTEGER NOT NULL,
	`idAutor`	INTEGER NOT NULL,
	`content`	TEXT NOT NULL,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas ( idResposta ),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores ( idUtilizador )
);
CREATE TABLE "ComentariosPerguntas" (
	`idCP`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idPergunta`	INTEGER NOT NULL,
	`idAutor`	INTEGER NOT NULL,
	`content`	TEXT NOT NULL,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas ( idPergunta ),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores ( idUtilizador )
);
CREATE TABLE `Categorias` (
	`idCategoria`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idBest`	INTEGER,
	`nome`	TEXT NOT NULL UNIQUE,
	FOREIGN KEY(`idBest`) REFERENCES Perguntas(idPergunta)
);
CREATE TABLE "Faculdades" (
	`idFaculdade`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL UNIQUE,
	`shorthand`	TEXT NOT NULL UNIQUE,
	`address`	TEXT,
	`website`	TEXT
);
INSERT INTO "Faculdades" VALUES(1,'Faculdade de Engenharia da Universidade do Porto','FEUP',NULL,'https://sigarra.up.pt/feup/pt/web_page.inicial');
INSERT INTO "Faculdades" VALUES(2,'Faculdade de Economia da Universidade do Porto','FEP',NULL,'https://sigarra.up.pt/fep/pt/web_page.inicial');
INSERT INTO "Faculdades" VALUES(3,'Faculdade de Medicina','FMUP',NULL,'https://sigarra.up.pt/fmup/pt/web_page.inicial');
INSERT INTO "Faculdades" VALUES(4,'Faculdade de Desporto da Universidade do Porto','FADEUP',NULL,'https://sigarra.up.pt/fadeup/pt/web_page.inicial');
INSERT INTO "Faculdades" VALUES(5,'Faculdade de Direito da Universidade do Porto','FDUP',NULL,'https://sigarra.up.pt/fdup/pt/web_page.inicial');
INSERT INTO "Faculdades" VALUES(6,'Faculdade de Ciências da Universidade do Porto','FCUP',NULL,'https://sigarra.up.pt/fcup/pt/web_page.inicial');
CREATE TABLE `CategoriasFaculdade` (
	`idCategoria`	INTEGER NOT NULL,
	`idFaculdade`	INTEGER NOT NULL,
	PRIMARY KEY(idCategoria,idFaculdade),
	FOREIGN KEY(`idCategoria`) REFERENCES Categorias(idCategoria),
	FOREIGN KEY(`idFaculdade`) REFERENCES Faculdades(idFaculdade)
);
CREATE TABLE "Utilizadores" (
	`idUtilizador`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idFaculdade`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL UNIQUE,
	`avatar`	TEXT NOT NULL UNIQUE,
	`email`	TEXT NOT NULL UNIQUE,
	`firstName`	TEXT,
	`lastName`	TEXT,
	`lastSession`	INTEGER DEFAULT 0 CHECK(lastSession >= 0),
	`active`	INTEGER DEFAULT 1 CHECK(active = 0 OR active = 1),
	FOREIGN KEY(`idFaculdade`) REFERENCES Faculdades ( idFaculdade )
);
INSERT INTO "Utilizadores" VALUES(1,1,'marques999','','xmarques999@hotmail.com','Diogo','Marques',0,1);
CREATE TABLE "Perguntas" (
	`idPergunta`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`idCategoria`	INTEGER NOT NULL,
	`idAutor`	INTEGER NOT NULL,
	`title`	TEXT NOT NULL,
	`content`	TEXT,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	`active`	INTEGER DEFAULT 1 CHECK(active = 0 OR active = 1),
	FOREIGN KEY(`idCategoria`) REFERENCES Categorias ( idCategoria ),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores ( idUser )
);
CREATE TABLE `MelhoresRespostas` (
	`idPergunta`	INTEGER,
	`idResposta`	INTEGER,
	`timestamp`	INTEGER DEFAULT 0 CHECK(timestamp >= 0),
	PRIMARY KEY(idPergunta,idResposta),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas (idPergunta),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas (idResposta)
);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('Administradores',1);
INSERT INTO "sqlite_sequence" VALUES('Respostas',1);
INSERT INTO "sqlite_sequence" VALUES('ComentariosRespostas',0);
INSERT INTO "sqlite_sequence" VALUES('ComentariosPerguntas',0);
INSERT INTO "sqlite_sequence" VALUES('Faculdades',6);
INSERT INTO "sqlite_sequence" VALUES('Utilizadores',1);
INSERT INTO "sqlite_sequence" VALUES('Perguntas',0);
CREATE VIEW usersView
AS SELECT Utilizadores.* FROM Utilizadores
left outer join Administradores 
       on Administradores.idUtilizador = Utilizadores.idUtilizador
 left outer join Moderadores 
       on Moderadores.idUtilizador = Utilizadores.idUtilizador;
COMMIT;
