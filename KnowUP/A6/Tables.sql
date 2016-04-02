DROP SCHEMA IF EXISTS knowUP;
CREATE SCHEMA knowUP;

/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Categoria (
	idCategoria		serial		NOT NULL,
	nome			text		NOT NULL UNIQUE,
);

ALTER TABLE knowUP.Categoria ADD CONSTRAINT PK_Categoria
	PRIMARY KEY (idCategoria);
ALTER TABLE knowUP.Categoria ADD CONSTRAINT UK_Categoria_Nome
	UNIQUE (nome);

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Instituicao (
	idInstituicao	serial		NOT NULL,
	nome			text		NOT NULL,
	sigla			text		NOT NULL,
	morada			text		NULL,
	contacto		text		NULL,
	website			text		NULL,
);

ALTER TABLE knowUP.Instituicao ADD CONSTRAINT PK_Instituicao
	PRIMARY KEY (idMensagem);
ALTER TABLE knowUP.Instituicao ADD CONSTRAINT UK_Instituicao_Nome
	UNIQUE (nome);
ALTER TABLE knowUP.Instituicao ADD CONSTRAINT UK_Instituicao_Sigla
	UNIQUE (sigla);

/*--------------------------------------------*/
/*             CategoriaInstituicao           */
/*--------------------------------------------*/

CREATE TABLE knowUP.CategoriaInstituicao (
	idCategoria		INTEGER NOT NULL,
	idInstituicao	INTEGER NOT NULL,
);

ALTER TABLE knowUP.CategoriaInstituicao ADD CONSTRAINT PK_CategoriaInstituicao
	PRIMARY KEY (idCategoria, idInstituicao);
ALTER TABLE knowUP.CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES knowUP.Categoria(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE knowUP.CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES knowUP.Instituicao(idInstituicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Utilizador                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Utilizador (
	idUtilizador 		serial		NOT NULL,
	idInstituicao		integer		NOT NULL,
	username			text		NOT NULL,
	password			text		NOT NULL,
	email				text		NOT NULL,
	primeiroNome		text		NOT NULL,
	ultimoNome			text		NOT NULL,
	localizacao			text		NULL,
	codigoPais			text		NULL,
	ultimaSessao		integer		DEFAULT 0,
	ativo				boolean		DEFAULT true,
);

ALTER TABLE knowUP.Utilizador ADD CONSTRAINT PK_Utilizador
	PRIMARY KEY (idUtilizador);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT FK_Utilizador_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES knowUP.Instituicao(idInstituicao)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT UK_Utilizador_Username
	UNIQUE (username);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT UK_Utilizador_Email
	UNIQUE (email);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT FK_Utilizador_UltimaSessao
	CHECK(ultimaSessao >= 0);

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

CREATE TABLE knowUP.Administrador (
	idAdministrador		serial		NOT NULL,
	idUtilizador		integer		NOT NULL,
);

ALTER TABLE knowUP.Administrador ADD CONSTRAINT PK_Administrador
	PRIMARY KEY (idAdministrador);
ALTER TABLE knowUP.Administrador ADD CONSTRAINT FK_Administrador_idUtilizador
	FOREIGN KEY (idUtilizador) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Administrador ADD CONSTRAINT UK_Administrador_idUtilizador
	UNIQUE (idUtilizador);

/*--------------------------------------------*/
/*                 Moderador                  */
/*--------------------------------------------*/

CREATE TABLE knowUP.Moderador (
	idModerador		serial		NOT NULL,
	idUtilizador	integer		NOT NULL,
);

ALTER TABLE knowUP.Moderador ADD CONSTRAINT PK_Moderador
	PRIMARY KEY (idModerador);
ALTER TABLE knowUP.Moderador ADD CONSTRAINT FK_Moderador_idUtilizador
	FOREIGN KEY (idUtilizador) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Moderador ADD CONSTRAINT UK_Moderador_idUtilizador
	UNIQUE (idUtilizador);

/*--------------------------------------------*/
/*                  Pergunta                  */
/*--------------------------------------------*/

CREATE TABLE knowUP.Pergunta (
	idPergunta		serial		NOT NULL,
	idCategoria		integer		NOT NULL,
	idAutor			integer		NOT NULL,
	titulo			text		NOT NULL,
	descricao		text		NULL,
	dataHora		timestamp	DEFAULT current_timestamp,
	visualizacoes	integer		DEFAULT 0 
	ativa			boolean		DEFAULT true
);

ALTER TABLE knowUP.Pergunta ADD CONSTRAINT CK_Visualizacoes
	CHECK(visualizacoes >= 0);
ALTER TABLE knowUP.Pergunta ADD CONSTRAINT PK_Pergunta
	PRIMARY KEY (idPergunta);
ALTER TABLE knowUP.Pergunta ADD CONSTRAINT FK_Pergunta_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES knowUP.Categoria(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Pergunta ADD CONSTRAINT FK_Pergunta_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                Contribuição                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Contribuicao (
	idContribuicao	serial		NOT NULL,
	idAutor 		integer 	NOT NULL,
	descricao		text		NOT NULL,
	dataHora		timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.Contribuicao ADD CONSTRAINT PK_Contribuicao
	PRIMARY KEY (idContribuicao);
ALTER TABLE knowUP.Contribuicao ADD CONSTRAINT FK_Contribuicao_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                  Resposta                  */
/*--------------------------------------------*/

CREATE TABLE knowUP.Resposta (
	idResposta		serial		NOT NULL,
	idPergunta		integer		NOT NULL,
	idContribuicao	integer 	NOT NULL,
);

ALTER TABLE knowUP.Resposta ADD CONSTRAINT PK_Resposta
	PRIMARY KEY (idResposta);
ALTER TABLE knowUP.Resposta ADD CONSTRAINT FK_Resposta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Resposta ADD CONSTRAINT FK_Resposta_idContribuicao
	FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                   Seguidor                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Seguidor (
	idSeguidor	integer		NOT NULL,
	idPergunta	integer		NOT NULL,
	dataInicio	timestamp	DEFAULT current_timestamp,
	dataAcesso	timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.Seguidor ADD CONSTRAINT PK_Seguidor
	PRIMARY KEY (idUtilizador, idPergunta);
ALTER TABLE knowUP.Seguidor ADD CONSTRAINT FK_Seguidor_idSeguidor
	FOREIGN KEY (idSeguidor) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Seguidor ADD CONSTRAINT FK_Seguidor_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*              ComentarioResposta            */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentarioResposta (
	idComentario	serial		NOT NULL,
	idResposta		integer		NOT NULL,
	idContribuicao	integer 	NOT NULL,
);

ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT PK_ComentarioResposta
	PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idResposta
	FOREIGN KEY (idResposta) REFERENCES knowUP.Respostas(idResposta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idAutor
	FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*              ComentarioPergunta            */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentarioPergunta (
	idComentario	serial		NOT NULL,
	idPergunta		integer		NOT NULL,
	idContribuicao	integer 	NOT NULL,
);

ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT PK_ComentarioPergunta
	PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idAutor
	FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                 VotoPergunta               */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotoPergunta (
	idPergunta	integer		NOT NULL,
	idAutor		integer		NOT NULL,
	valor		integer		DEFAULT 0	
);

ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT CK_Valor
	CHECK(valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT PK_VotoPergunta
	PRIMARY KEY (idPergunta, idAutor);
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 VotoResposta               */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotoResposta (
	idResposta	integer		NOT NULL,
	idAutor		integer		NOT NULL,
	valor		integer		DEFAULT 0
);

ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT CK_Valor
	CHECK(valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT PK_VotoResposta
	PRIMARY KEY (idResposta, idAutor);
ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT FK_VotoResposta_idAutor
	FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT FK_VotoResposta_idResposta
	FOREIGN KEY (idResposta) REFERENCES knowUP.Respostas(idResposta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Notificação                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Notificacao (
	idNotificacao	serial		NOT NULL,
	idPergunta		integer		NOT NULL,
	idContribuicao	integer 	NOT NULL,
);

ALTER TABLE knowUP.Notificacao ADD CONSTRAINT PK_Notificacao
	PRIMARY KEY (idNotificacao);
ALTER TABLE knowUP.Notificacao ADD CONSTRAINT FK_Notificacao_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE knowUP.Notificacao ADD CONSTRAINT FK_Notificacao_idContribuicao
	FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                   Mensagem                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Mensagem (
	idMensagem		serial		NOT NULL,
	idRemetente		integer		NOT NULL,
	idDestinatario	integer		NOT NULL,
	titulo			text		NULL,
	descricao		text		NOT NULL,
	dataHora		timestamp	DEFAULT current_timestamp
);

ALTER TABLE knowUP.Mensagem ADD CONSTRAINT PK_Mensagem
	PRIMARY KEY (idMensagem);
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT FK_Mensagem_idRemetente
	FOREIGN KEY (idRemetente) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT FK_Mensagem_idDestinatario
	FOREIGN KEY (idDestinatario) REFERENCES knowUP.Utilizador(idUtilizador)
	ON DELETE SET NULL;
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT CK_Mensagem_AutoresDiferentes
	CHECK (idRemetente != idDestinatario);