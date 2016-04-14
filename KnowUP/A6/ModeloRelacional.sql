SET SCHEMA 'knowup';

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

/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

CREATE TABLE Categoria (
	idCategoria     serial      NOT NULL,
	nome            text        NOT NULL
);

ALTER TABLE Categoria ADD CONSTRAINT PK_Categoria
	PRIMARY KEY (idCategoria);
ALTER TABLE Categoria ADD CONSTRAINT UK_Categoria_Nome
	UNIQUE (nome);

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

CREATE TABLE Instituicao (
	idInstituicao   serial      NOT NULL,
	nome            text        NOT NULL,
	sigla           text        NOT NULL,
	morada          text        NULL,
	contacto        text        NULL,
	website         text        NULL
);

ALTER TABLE Instituicao ADD CONSTRAINT PK_Instituicao
	PRIMARY KEY (idInstituicao);
ALTER TABLE Instituicao ADD CONSTRAINT UK_Instituicao_Nome
	UNIQUE (nome);
ALTER TABLE Instituicao ADD CONSTRAINT UK_Instituicao_Sigla
	UNIQUE (sigla);

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

CREATE TABLE CategoriaInstituicao (
	idInstituicao   integer     NOT NULL,
	idCategoria     integer     NOT NULL
);

ALTER TABLE CategoriaInstituicao ADD CONSTRAINT PK_CategoriaInstituicao
	PRIMARY KEY (idInstituicao, idCategoria);
ALTER TABLE CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE CategoriaInstituicao ADD CONSTRAINT FK_CategoriaInstituicao_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES Instituicao(idInstituicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Utilizador                 */
/*--------------------------------------------*/

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

ALTER TABLE Utilizador ADD CONSTRAINT PK_Utilizador
	PRIMARY KEY (idUtilizador);
ALTER TABLE Utilizador ADD CONSTRAINT UK_Utilizador_Email
	UNIQUE (email);
ALTER TABLE Utilizador ADD CONSTRAINT UK_Utilizador_Username
	UNIQUE (username);
ALTER TABLE Utilizador ADD CONSTRAINT FK_Utilizador_idInstituicao
	FOREIGN KEY (idInstituicao) REFERENCES Instituicao(idInstituicao)
	ON DELETE SET NULL;

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

CREATE TABLE Administrador (
	idAdministrador        integer     NOT NULL
);

ALTER TABLE Administrador ADD CONSTRAINT PK_Administrador
	PRIMARY KEY (idAdministrador);
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_idAdministrador
	FOREIGN KEY (idAdministrador) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Moderador                  */
/*--------------------------------------------*/

CREATE TABLE Moderador (
	idModerador     integer      NOT NULL
);

ALTER TABLE Moderador ADD CONSTRAINT PK_Moderador
	PRIMARY KEY (idModerador);
ALTER TABLE Moderador ADD CONSTRAINT FK_Moderador_idModerador
	FOREIGN KEY (idModerador) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Pergunta                  */
/*--------------------------------------------*/

CREATE TABLE Pergunta (
	idPergunta      serial      NOT NULL,
	idCategoria     integer     NOT NULL,
	idAutor         integer     NOT NULL,
	titulo          text        NOT NULL,
	descricao       text        NULL,
	dataHora        timestamp   DEFAULT current_timestamp,
	ativa           boolean     DEFAULT true
);

ALTER TABLE Pergunta ADD CONSTRAINT PK_Pergunta
	PRIMARY KEY (idPergunta);
ALTER TABLE Pergunta ADD CONSTRAINT CK_Pergunta_Visualizacoes
	CHECK (visualizacoes >= 0);
ALTER TABLE Pergunta ADD CONSTRAINT FK_Pergunta_idCategoria
	FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
	ON DELETE CASCADE;
ALTER TABLE Pergunta ADD CONSTRAINT FK_Pergunta_idAutor
	FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                Contribuição                */
/*--------------------------------------------*/

CREATE TABLE Contribuicao (
	idContribuicao  serial      NOT NULL,
	idAutor         integer     NOT NULL,
	descricao       text        NOT NULL,
	dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Contribuicao ADD CONSTRAINT PK_Contribuicao
	PRIMARY KEY (idContribuicao);
ALTER TABLE Contribuicao ADD CONSTRAINT FK_Contribuicao_idAutor
	FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Resposta                  */
/*--------------------------------------------*/

CREATE TABLE Resposta (
	idResposta      integer     NOT NULL,
	idPergunta      integer     NOT NULL,
	melhorResposta  boolean     DEFAULT false
);

ALTER TABLE Resposta ADD CONSTRAINT PK_Resposta
	PRIMARY KEY (idResposta);
ALTER TABLE Resposta ADD CONSTRAINT FK_Resposta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE Resposta ADD CONSTRAINT FK_Resposta_idResposta
	FOREIGN KEY (idResposta) REFERENCES Contribuicao(idContribuicao)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*             ComentarioPergunta             */
/*--------------------------------------------*/

CREATE TABLE ComentarioPergunta (
	idComentario    integer     NOT NULL,
	idPergunta      integer     NOT NULL
);

ALTER TABLE ComentarioPergunta ADD CONSTRAINT PK_ComentarioPergunta
	PRIMARY KEY (idComentario);
ALTER TABLE ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idComentario
	FOREIGN KEY (idComentario) REFERENCES Contribuicao(idContribuicao)
	ON DELETE CASCADE;
ALTER TABLE ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*             ComentarioResposta             */
/*--------------------------------------------*/

CREATE TABLE ComentarioResposta (
	idComentario    serial      NOT NULL,
	idResposta      integer     NOT NULL
);

ALTER TABLE ComentarioResposta ADD CONSTRAINT PK_ComentarioResposta
	PRIMARY KEY (idComentario);
ALTER TABLE ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idComentario
	FOREIGN KEY (idComentario) REFERENCES Contribuicao(idContribuicao)
	ON DELETE CASCADE;
ALTER TABLE ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idResposta
	FOREIGN KEY (idResposta) REFERENCES Resposta(idResposta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                VotoPergunta                */
/*--------------------------------------------*/

CREATE TABLE VotoPergunta (
	idPergunta  integer     NOT NULL,
	idAutor     integer     NOT NULL,
	valor       integer     DEFAULT 0
);

ALTER TABLE VotoPergunta ADD CONSTRAINT PK_VotoPergunta
	PRIMARY KEY (idPergunta, idAutor);
ALTER TABLE VotoPergunta ADD CONSTRAINT CK_VotoPergunta_Valor
	CHECK (valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta)
	ON DELETE CASCADE;
ALTER TABLE VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idAutor
	FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                VotoResposta                */
/*--------------------------------------------*/

CREATE TABLE VotoResposta (
	idResposta  integer     NOT NULL,
	idAutor     integer     NOT NULL,
	valor       integer     DEFAULT 0
);

ALTER TABLE VotoResposta ADD CONSTRAINT PK_VotoResposta
	PRIMARY KEY (idResposta, idAutor);
ALTER TABLE VotoResposta ADD CONSTRAINT CK_VotoResposta_Valor
	CHECK (valor = 1 OR valor = 0 OR valor = -1);
 ALTER TABLE VotoResposta ADD CONSTRAINT FK_VotoResposta_idResposta
	FOREIGN KEY (idResposta) REFERENCES Resposta(idResposta)
	ON DELETE CASCADE;
ALTER TABLE VotoResposta ADD CONSTRAINT FK_VotoResposta_idAutor
	FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Seguidor                  */
/*--------------------------------------------*/

CREATE TABLE Seguidor (
	idSeguidor  integer     NOT NULL,
	idPergunta  integer     NOT NULL,
	dataInicio  timestamp   DEFAULT current_timestamp,
	dataAcesso  timestamp   DEFAULT current_timestamp
);

ALTER TABLE Seguidor ADD CONSTRAINT PK_Seguidor
	PRIMARY KEY (idSeguidor, idPergunta);
ALTER TABLE Seguidor ADD CONSTRAINT FK_Seguidor_idSeguidor
	FOREIGN KEY (idSeguidor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;
ALTER TABLE Seguidor ADD CONSTRAINT FK_Seguidor_idPergunta
	FOREIGN KEY (idPergunta) REFERENCES Pergunta(idPergunta)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Conversa                  */
/*--------------------------------------------*/

CREATE TABLE Conversa (
	idConversa      serial      NOT NULL,
	idUtilizador1   integer     NOT NULL,
	idUtilizador2   integer     NOT NULL,
	titulo			text        NOT NULL,
	ultimoAcesso1   timestamp   DEFAULT current_timestamp,
	ultimoAcesso2   timestamp   DEFAULT current_timestamp
);

ALTER TABLE Conversa ADD CONSTRAINT PK_Conversa
	PRIMARY KEY (idConversa);
ALTER TABLE Conversa ADD CONSTRAINT CK_Conversa_AutoresDiferentes
	CHECK (idUtilizador1 <> idUtilizador2);
ALTER TABLE Conversa ADD CONSTRAINT FK_Conversa_idUtilizador1
	FOREIGN KEY (idUtilizador1) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;
ALTER TABLE Conversa ADD CONSTRAINT FK_Conversa_idUtilizador2
	FOREIGN KEY (idUtilizador2) REFERENCES Utilizador(idUtilizador) ON DELETE CASCADE;

/*--------------------------------------------*/
/*                  Mensagem                  */
/*--------------------------------------------*/

CREATE TABLE Mensagem (
	idMensagem      serial      NOT NULL,
	idConversa      integer     NOT NULL,
	idAutor         integer     NOT NULL,
	descricao       text        NOT NULL,
	dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Mensagem ADD CONSTRAINT PK_Mensagem
	PRIMARY KEY (idMensagem);
ALTER TABLE Mensagem ADD CONSTRAINT FK_Mensagem_idConversa
	FOREIGN KEY (idConversa) REFERENCES Conversa(idConversa)
	ON DELETE CASCADE;
ALTER TABLE Mensagem ADD CONSTRAINT FK_Mensagem_idAutor
	FOREIGN KEY (idAutor) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;

/*--------------------------------------------*/
/*                   Report                   */
/*--------------------------------------------*/

CREATE TABLE Report (
	idReport        serial      NOT NULL,
	idModerador     integer     NOT NULL,
	idUtilizador    integer     NOT NULL,
	descricao       text        NOT NULL,
	dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE Report ADD CONSTRAINT PK_Report
	PRIMARY KEY (idReport);
ALTER TABLE Report ADD CONSTRAINT FK_Report_idModerador
	FOREIGN KEY (idModerador) REFERENCES Moderador(idModerador)
	ON DELETE CASCADE;
ALTER TABLE Report ADD CONSTRAINT FK_Report_idUtilizador
	FOREIGN KEY (idUtilizador) REFERENCES Utilizador(idUtilizador)
	ON DELETE CASCADE;