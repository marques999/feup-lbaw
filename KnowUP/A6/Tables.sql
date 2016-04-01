DROP SCHEMA IF EXISTS knowUP;
CREATE SCHEMA knowUP;

/*--------------------------------------------*/
/*                VotosPerguntas              */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotosPerguntas (
	idPergunta	integer		NOT NULL,
	idAutor		integer		NOT NULL,
	valor		integer		DEFAULT 0	CHECK(valor = 1 OR valor = -1)
);

ALTER TABLE knowUP.VotosPerguntas ADD CONSTRAINT PK_VotosPerguntas
	PRIMARY KEY (idPergunta, idAutor);
ALTER TABLE knowUP.VotosPerguntas ADD CONSTRAINT FK_VotosPerguntas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.VotosPerguntas ADD CONSTRAINT FK_VotosPerguntas_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Perguntas(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                VotosRespostas              */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotosRespostas (
	idResposta	integer		NOT NULL,
	idAutor		integer		NOT NULL,
	valor		integer		DEFAULT 0	CHECK(valor = 1 OR valor = -1)
);

ALTER TABLE knowUP.VotosRespostas ADD CONSTRAINT PK_VotosRespostas
	PRIMARY KEY (idResposta, idAutor);
ALTER TABLE knowUP.VotosRespostas ADD CONSTRAINT FK_VotosRespostas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.VotosRespostas ADD CONSTRAINT FK_VotosRespostas_idResposta
	FOREIGN KEY (idResposta) REFERENCES knowUP.Respostas(idResposta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Utilizadores               */
/*--------------------------------------------*/

CREATE TABLE knowUP.Utilizadores (
	idUtilizador 		SERIAL		NOT NULL,
	idInstituicao		integer		NOT NULL,
	username			text		NOT NULL,
	password			text		NULL,
	email				text		NOT NULL,
	primeiroNome		text		NULL,
	ultimoNome			text		NULL,
	localizacao			text		NULL,
	codigoPais			text		NULL,
	ultimaSessao		integer		DEFAULT 0,
	ativo				boolean		DEFAULT true,
	CONSTRAINT UK_Utilizadores_Username		UNIQUE (username),
	CONSTRAINT UK_Utilizadores_Email		UNIQUE (email)
);

ALTER TABLE knowUP.Utilizadores ADD CONSTRAINT PK_Utilizadores
	PRIMARY KEY (idUtilizador);
ALTER TABLE knowUP.Utilizadores ADD CONSTRAINT FK_Utilizadores_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES knowUP.Instituicoes(idInstituicao)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Utilizadores ADD CONSTRAINT FK_Utilizadores_UltimaSessao
	CHECK(ultimaSessao >= 0);

/*--------------------------------------------*/
/*               Administradores              */
/*--------------------------------------------*/

CREATE TABLE knowUP.Administradores (
	idAdministrador		serial		NOT NULL,
	idUtilizador		integer		NOT NULL,
	CONSTRAINT UK_Administradores_idUtilizador	UNIQUE (idUtilizador)
);

ALTER TABLE knowUP.Administradores ADD CONSTRAINT PK_Administradores
	PRIMARY KEY (idAdministrador);
ALTER TABLE knowUP.Administradores ADD CONSTRAINT FK_Administradores_idUtilizador
	FOREIGN KEY (idUtilizador) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Moderadores                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Moderadores (
	idModerador		serial		NOT NULL,
	idUtilizador	integer		NOT NULL,
	CONSTRAINT UK_Moderadores_idUtilizador	UNIQUE (idUtilizador)
);

ALTER TABLE knowUP.Moderadores ADD CONSTRAINT PK_Moderadores
	PRIMARY KEY (idModerador);
ALTER TABLE knowUP.Moderadores ADD CONSTRAINT FK_Moderadores_idUtilizador
	FOREIGN KEY (idUtilizador) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Seguidores                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Seguidores (
	idSeguidor	integer		NOT NULL,
	idPergunta	integer		NOT NULL,
	dataInicio	integer		DEFAULT 0	CHECK(dataInicio >= 0),
	dataAcesso	integer		DEFAULT 0	CHECK(dataAcesso >= 0)
);

ALTER TABLE knowUP.Seguidores ADD CONSTRAINT PK_Seguidores
	PRIMARY KEY (idUtilizador, idPergunta);
ALTER TABLE knowUP.Seguidores ADD CONSTRAINT FK_Seguidores_idSeguidor
	FOREIGN KEY (idSeguidor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Seguidores ADD CONSTRAINT FK_Seguidores_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Perguntas(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Respostas                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Respostas (
	idResposta	serial		NOT NULL,
	idPergunta	integer		NOT NULL,
	idAutor		integer		NOT NULL,
	descricao	text		NOT NULL,
	dataHora	timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.Respostas ADD CONSTRAINT PK_Respostas
	PRIMARY KEY (idResposta);
ALTER TABLE knowUP.Respostas ADD CONSTRAINT FK_Respostas_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Perguntas(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Respostas ADD CONSTRAINT FK_Respostas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                  Perguntas                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Perguntas (
	idPergunta		serial		NOT NULL,
	idCategoria		integer		NOT NULL,
	idAutor			integer		NOT NULL,
	titulo			text		NOT NULL,
	descricao		text		NULL,
	dataHora		timestamp	DEFAULT current_timestamp,
	visualizacoes	integer		DEFAULT 0 CHECK(numVisualizacoes >= 0),
	ativa			boolean		DEFAULT true
);

ALTER TABLE knowUP.Perguntas ADD CONSTRAINT PK_Perguntas
	PRIMARY KEY (idPergunta);
ALTER TABLE knowUP.Perguntas ADD CONSTRAINT FK_Perguntas_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES knowUP.Categorias(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Perguntas ADD CONSTRAINT FK_Perguntas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                 Notificações               */
/*--------------------------------------------*/

CREATE TABLE knowUP.Notificacoes (
	idNotificacao	serial				NOT NULL,
	idPergunta		integer				NOT NULL,
	idAutor			integer				NOT NULL,
	descricao		text				NOT NULL,
	tipo			TipoContribuicao	NOT NULL,
	dataHora		timestamp			DEFAULT current_timestamp
);

ALTER TABLE knowUP.Notificacoes ADD CONSTRAINT PK_Notificacoes
	PRIMARY KEY (idNotificacao);
ALTER TABLE knowUP.Notificacoes ADD CONSTRAINT FK_Notificacoes_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Perguntas(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Notificacoes ADD CONSTRAINT FK_Notificacoes_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                   Mensagens                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Mensagens (
	idMensagem		serial		NOT NULL,
	idRemetente		integer		NOT NULL,
	idDestinatario	integer		NOT NULL,
	titulo			text		NULL,
	mensagem		text		NOT NULL,
	dataHora		timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.Mensagens ADD CONSTRAINT PK_Mensagens
	PRIMARY KEY (idMensagem);
ALTER TABLE knowUP.Mensagens ADD CONSTRAINT FK_Mensagens_idRemetente
	FOREIGN KEY (idRemetente) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Mensagens ADD CONSTRAINT FK_Mensagens_idDestinatario
	FOREIGN KEY (idDestinatario) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Mensagens ADD CONSTRAINT CK_Mensagens_AutoresDiferentes
	CHECK (idRemetente != idDestinatario);

/*--------------------------------------------*/
/*                 Instituições               */
/*--------------------------------------------*/

CREATE TABLE knowUP.Instituicoes (
	idInstituicao	serial		NOT NULL,
	nome			text		NOT NULL,
	sigla			text		NOT NULL,
	morada			text		NULL,
	contacto		text		NULL,
	website			text		NULL,
	CONSTRAINT UK_Instituicoes_Nome		UNIQUE (nome),
	CONSTRAINT UK_Instituicoes_Sigla	UNIQUE (sigla)
);

ALTER TABLE knowUP.Instituicoes ADD CONSTRAINT PK_Instituicoes
	PRIMARY KEY (idMensagem);

/*--------------------------------------------*/
/*             ComentariosRespostas           */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentariosRespostas (
	idComentario	serial		NOT NULL,
	idResposta		integer		NOT NULL,
	idAutor			integer		NOT NULL,
	descricao		text		NOT NULL,
	dataHora		timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.ComentariosRespostas ADD CONSTRAINT PK_ComentariosRespostas
	PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentariosRespostas ADD CONSTRAINT FK_ComentariosRespostas_idResposta
	FOREIGN KEY (idResposta) REFERENCES knowUP.Respostas(idResposta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.ComentariosRespostas ADD CONSTRAINT FK_ComentariosRespostas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*             ComentariosPerguntas           */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentariosPerguntas (
	idComentario	serial		NOT NULL,
	idPergunta		integer		NOT NULL,
	idAutor			integer		NOT NULL,
	descricao		text		NOT NULL,
	dataHora		timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.ComentariosPerguntas ADD CONSTRAINT PK_ComentariosPerguntas
	PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentariosPerguntas ADD CONSTRAINT FK_ComentariosPerguntas_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Perguntas(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.ComentariosPerguntas ADD CONSTRAINT FK_ComentariosPerguntas_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizadores(idUtilizador)
	ON DELETE SET NULL;
	
/*--------------------------------------------*/
/*            CategoriasInstituicao           */
/*--------------------------------------------*/

CREATE TABLE knowUP.CategoriasInstituicao (
	idCategoria		INTEGER NOT NULL,
	idInstituicao	INTEGER NOT NULL,
);

ALTER TABLE knowUP.CategoriasInstituicao ADD CONSTRAINT PK_CategoriasInstituicao
	PRIMARY KEY (idCategoria, idInstituicao);
ALTER TABLE knowUP.CategoriasInstituicao ADD CONSTRAINT FK_CategoriasInstituicao_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES knowUP.Categorias(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE knowUP.CategoriasInstituicao ADD CONSTRAINT FK_CategoriasInstituicao_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES knowUP.Instituicoes(idInstituicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Categorias                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Categorias (
	idCategoria		serial		NOT NULL,
	nome			text		NOT NULL UNIQUE,
	CONSTRAINT UK_Categorias_Nome	UNIQUE (nome)
);

ALTER TABLE knowUP.Categorias ADD CONSTRAINT PK_Categorias
	PRIMARY KEY (idCategoria);