BEGIN TRANSACTION;
CREATE TABLE "VotosPerguntas" (
	`idPergunta`		INTEGER NOT NULL,
	`idUtilizador`		INTEGER NOT NULL,
	`valor`				INTEGER DEFAULT 1 CHECK(valor = - 1 OR valor = 1),
	PRIMARY KEY(idPergunta, idUtilizador),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "VotosRespostas" (
	`idResposta`		INTEGER NOT NULL,
	`idUtilizador`		INTEGER NOT NULL,
	`valor`				INTEGER DEFAULT 1 CHECK(valor = - 1 OR valor = 1),
	PRIMARY KEY(idResposta, idUtilizador),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas(idResposta),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "Utilizadores" (
	`idUtilizador` 		INTEGER PRIMARY KEY AUTOINCREMENT,
	`idInstituicao`		INTEGER NOT NULL,
	`username`			TEXT NOT NULL UNIQUE,
	`password`			TEXT,
	`email`				TEXT NOT NULL UNIQUE,
	`primeiroNome`		TEXT,
	`ultimoNome`		TEXT,
	`ultimaSessao`		INTEGER DEFAULT 0 CHECK(ultimaSessao >= 0),
	`ativo`				INTEGER DEFAULT 1 CHECK(ativo = 0 OR ativo = 1),
	FOREIGN KEY(`idInstituicao`) REFERENCES Instituicoes(idInstituicao)
);
CREATE TABLE "Administradores" (
	`idAdministrador`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idUtilizador`		INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "Moderadores" (
	`idModerador`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idUtilizador`		INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "Seguidores" (
	`idUtilizador`		INTEGER NOT NULL,
	`idPergunta`		INTEGER NOT NULL,
	`dataInicio`		INTEGER DEFAULT 0 CHECK(dataInicio >= 0),
	`dataAcesso`		INTEGER DEFAULT 0 CHECK(dataAcesso >= 0),
	PRIMARY KEY(idUtilizador, idPergunta),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta)
);
CREATE TABLE "Respostas" (
	`idResposta`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idPergunta`		INTEGER NOT NULL,
	`idAutor`			INTEGER NOT NULL,
	`descricao`			TEXT NOT NULL,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora > 0),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "Perguntas" (
	`idPergunta`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idCategoria`		INTEGER NOT NULL,
	`idAutor`			INTEGER NOT NULL,
	`titulo`			TEXT NOT NULL,
	`descricao`			TEXT,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora >= 0),
	`numVisualizacoes`	INTEGER DEFAULT 0 CHECK(numVisualizacoes >= 0),
	`numRespostas`		INTEGER DEFAULT 0 CHECK(numRespostas >= 0),
	`votosPositivos`	INTEGER DEFAULT 0 CHECK(votosPositivos >= 0),
	`votosNegativos`	INTEGER DEFAULT 0 CHECK(votosNegativos >= 0),
	`ativa`				INTEGER DEFAULT 1 CHECK(ativa = 0 OR ativa = 1),
	FOREIGN KEY(`idCategoria`) REFERENCES Categorias(idCategoria),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE `Notificacoes` (
	`idNotificacao`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idPergunta`		INTEGER NOT NULL,
	`idAutor`			INTEGER NOT NULL,
	`descricao`			TEXT NOT NULL,
	`tipo`				INTEGER NOT NULL,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora >= 0),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "Mensagens" (
	`idMensagem`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idConversa`		INTEGER NOT NULL,
	`idUtilizador`		INTEGER NOT NULL,
	`titulo`			TEXT,
	`mensagem`			TEXT NOT NULL,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora >= 0),
	FOREIGN KEY(`idConversa`) REFERENCES Conversas(idConversa),
	FOREIGN KEY(`idUtilizador`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "MelhoresRespostas" (
	`idPergunta`		INTEGER NOT NULL,
	`idResposta`		INTEGER NOT NULL,
	PRIMARY KEY(idPergunta, idResposta),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas(idResposta)
);
CREATE TABLE "Instituicoes" (
	`idInstituicao`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`numPerguntas`		INTEGER DEFAULT 0 CHECK(numPerguntas >= 0),
	`name`				TEXT NOT NULL UNIQUE,
	`sigla`				TEXT NOT NULL UNIQUE,
	`morada`			TEXT,
	`contacto`			INTEGER,
	`website`			TEXT
);
CREATE TABLE "Conversas" (
	`idUtilizador1`		INTEGER NOT NULL,
	`idUtilizador2`		INTEGER NOT NULL,
	`ultimaMensagem`	INTEGER NOT NULL,
	PRIMARY KEY(idUtilizador1, idUtilizador2),
	FOREIGN KEY(`idUtilizador1`) REFERENCES Utilizadores(idUtilizador),
	FOREIGN KEY(`idUtilizador2`) REFERENCES Utilizadores(idUtilizador),
	FOREIGN KEY(`ultimaMensagem`) REFERENCES Mensagens(idMensagem)
);
CREATE TABLE "ComentariosRespostas" (
	`idCR`				INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idResposta`		INTEGER NOT NULL,
	`idAutor`			INTEGER NOT NULL,
	`descricao`			TEXT NOT NULL,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora >= 0),
	FOREIGN KEY(`idResposta`) REFERENCES Respostas(idResposta),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "ComentariosPerguntas" (
	`idCP`				INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`idPergunta`		INTEGER NOT NULL,
	`idAutor`			INTEGER NOT NULL,
	`descricao`			TEXT NOT NULL,
	`dataHora`			INTEGER DEFAULT 0 CHECK(dataHora >= 0),
	FOREIGN KEY(`idPergunta`) REFERENCES Perguntas(idPergunta),
	FOREIGN KEY(`idAutor`) REFERENCES Utilizadores(idUtilizador)
);
CREATE TABLE "CategoriasInstituicao" (
	`idCategoria`		INTEGER NOT NULL,
	`idInstituicao`		INTEGER NOT NULL,
	PRIMARY KEY(idCategoria, idInstituicao),
	FOREIGN KEY(`idCategoria`) REFERENCES Categorias(idCategoria),
	FOREIGN KEY(`idInstituicao`) REFERENCES Instituicoes(idInstituicao)
);
CREATE TABLE "Categorias" (
	`idCategoria`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`numPerguntas`		INTEGER DEFAULT 0 CHECK(numPerguntas >= 0),
	`nome`				TEXT NOT NULL UNIQUE
);
INSERT INTO `Instituicoes` VALUES (1,NULL,'Faculdade de Engenharia da Universidade do Porto','FEUP',NULL,NULL,'https://sigarra.up.pt/feup/pt/web_page.inicial');
INSERT INTO `Instituicoes` VALUES (2,NULL,'Faculdade de Economia da Universidade do Porto','FEP',NULL,NULL,'https://sigarra.up.pt/fep/pt/web_page.inicial');
INSERT INTO `Instituicoes` VALUES (3,NULL,'Faculdade de Medicina','FMUP',NULL,NULL,'https://sigarra.up.pt/fmup/pt/web_page.inicial');
INSERT INTO `Instituicoes` VALUES (4,NULL,'Faculdade de Desporto da Universidade do Porto','FADEUP',NULL,NULL,'https://sigarra.up.pt/fadeup/pt/web_page.inicial');
INSERT INTO `Instituicoes` VALUES (5,NULL,'Faculdade de Direito da Universidade do Porto','FDUP',NULL,NULL,'https://sigarra.up.pt/fdup/pt/web_page.inicial');
INSERT INTO `Instituicoes` VALUES (6,NULL,'Faculdade de Ciências da Universidade do Porto','FCUP',NULL,NULL,'https://sigarra.up.pt/fcup/pt/web_page.inicial');
COMMIT;