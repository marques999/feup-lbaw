DROP SCHEMA IF EXISTS knowUP;
CREATE SCHEMA knowUP;

DROP TABLE IF EXISTS knowUP.Mensagem;
DROP TABLE IF EXISTS knowUP.Notificacao;
DROP TABLE IF EXISTS knowUP.VotoResposta;
DROP TABLE IF EXISTS knowUP.VotoPergunta;
DROP TABLE IF EXISTS knowUP.ComentarioResposta;
DROP TABLE IF EXISTS knowUP.ComentarioPergunta;
DROP TABLE IF EXISTS knowUP.Seguidor;
DROP TABLE IF EXISTS knowUP.Resposta;
DROP TABLE IF EXISTS knowUP.Contribuicao;
DROP TABLE IF EXISTS knowUP.Pergunta;
DROP TABLE IF EXISTS knowUP.Moderador;
DROP TABLE IF EXISTS knowUP.Administrador;
DROP TABLE IF EXISTS knowUP.Utilizador;
DROP TABLE IF EXISTS knowUP.CategoriaInstituicao;
DROP TABLE IF EXISTS knowUP.Instituicao;
DROP TABLE IF EXISTS knowUP.Categoria;

/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Categoria (
    idCategoria     serial      NOT NULL,
    nome            text        NOT NULL
);

ALTER TABLE knowUP.Categoria ADD CONSTRAINT PK_Categoria
    PRIMARY KEY (idCategoria);
ALTER TABLE knowUP.Categoria ADD CONSTRAINT UK_Categoria_Nome
    UNIQUE (nome);

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Instituicao (
    idInstituicao   serial      NOT NULL,
    nome            text        NOT NULL,
    sigla           text        NOT NULL,
    morada          text        NULL,
    contacto        text        NULL,
    website         text        NULL
);

ALTER TABLE knowUP.Instituicao ADD CONSTRAINT PK_Instituicao
    PRIMARY KEY (idMensagem);
ALTER TABLE knowUP.Instituicao ADD CONSTRAINT UK_Instituicao_Nome
    UNIQUE (nome);
ALTER TABLE knowUP.Instituicao ADD CONSTRAINT UK_Instituicao_Sigla
    UNIQUE (sigla);

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

CREATE TABLE knowUP.CategoriaInstituicao (
    idCategoria     integer     NOT NULL,
    idInstituicao   integer     NOT NULL
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
/*                 Utilizador                 */
/*--------------------------------------------*/

CREATE TABLE knowUP.Utilizador (
    idUtilizador    serial      NOT NULL,
    idInstituicao   integer     NULL,
    username        text        NOT NULL,
    password        text        NOT NULL,
    email           text        NOT NULL,
    primeiroNome    text        NOT NULL,
    ultimoNome      text        NOT NULL,
    localizacao     text        NULL,
    codigoPais      text        NULL,
    ultimaSessao    timestamp   DEFAULT current_timestamp,
    ativo           boolean     DEFAULT true
);

ALTER TABLE knowUP.Utilizador ADD CONSTRAINT PK_Utilizador
    PRIMARY KEY (idUtilizador);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT UK_Utilizador_Email
    UNIQUE (email);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT UK_Utilizador_Username
    UNIQUE (username);
ALTER TABLE knowUP.Utilizador ADD CONSTRAINT FK_Utilizador_idInstituicao
    FOREIGN KEY (idInstituicao) REFERENCES knowUP.Instituicao(idInstituicao)
    ON DELETE SET NULL;

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

CREATE TABLE knowUP.Administrador (
    idAdministrador     serial      NOT NULL,
    idUtilizador        integer     NOT NULL
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
    idModerador     serial      NOT NULL,
    idUtilizador    integer     NOT NULL
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
    idPergunta      serial      NOT NULL,
    idCategoria     integer     NOT NULL,
    idAutor         integer     NOT NULL,
    titulo          text        NOT NULL,
    descricao       text        NULL,
    dataHora        timestamp   DEFAULT current_timestamp,
    visualizacoes   integer     DEFAULT 0,
    ativa           boolean     DEFAULT true
);

ALTER TABLE knowUP.Pergunta ADD CONSTRAINT PK_Pergunta
    PRIMARY KEY (idPergunta);
ALTER TABLE knowUP.Pergunta ADD CONSTRAINT CK_Pergunta_Visualizacoes
    CHECK (visualizacoes >= 0);
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
    idContribuicao  serial      NOT NULL,
    idAutor         integer     NOT NULL,
    descricao       text        NOT NULL,
    dataHora        timestamp   DEFAULT current_timestamp
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
    idResposta      serial      NOT NULL,
    idPergunta      integer     NOT NULL,
    idContribuicao  integer     NOT NULL
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
/*                  Seguidor                  */
/*--------------------------------------------*/

CREATE TABLE knowUP.Seguidor (
    idSeguidor  integer     NOT NULL,
    idPergunta  integer     NOT NULL,
    dataInicio  timestamp   DEFAULT current_timestamp,
    dataAcesso  timestamp   DEFAULT current_timestamp
);

ALTER TABLE knowUP.Seguidor ADD CONSTRAINT PK_Seguidor
    PRIMARY KEY (idSeguidor, idPergunta);
ALTER TABLE knowUP.Seguidor ADD CONSTRAINT FK_Seguidor_idSeguidor
    FOREIGN KEY (idSeguidor) REFERENCES knowUP.Utilizador(idUtilizador)
    ON DELETE CASCADE;
ALTER TABLE knowUP.Seguidor ADD CONSTRAINT FK_Seguidor_idPergunta
    FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
    ON DELETE CASCADE;

/*--------------------------------------------*/
/*             ComentarioPergunta             */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentarioPergunta (
    idComentario    serial      NOT NULL,
    idPergunta      integer     NOT NULL,
    idContribuicao  integer     NOT NULL
);

ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT PK_ComentarioPergunta
    PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idPergunta
    FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
    ON DELETE CASCADE;
ALTER TABLE knowUP.ComentarioPergunta ADD CONSTRAINT FK_ComentarioPergunta_idContribuicao
    FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
    ON DELETE SET NULL;

/*--------------------------------------------*/
/*             ComentarioResposta             */
/*--------------------------------------------*/

CREATE TABLE knowUP.ComentarioResposta (
    idComentario    serial      NOT NULL,
    idResposta      integer     NOT NULL,
    idContribuicao  integer     NOT NULL
);

ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT PK_ComentarioResposta
    PRIMARY KEY (idComentario);
ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idResposta
    FOREIGN KEY (idResposta) REFERENCES knowUP.Resposta(idResposta)
    ON DELETE CASCADE;
ALTER TABLE knowUP.ComentarioResposta ADD CONSTRAINT FK_ComentarioResposta_idContribuicao
    FOREIGN KEY (idContribuicao) REFERENCES knowUP.Contribuicao(idContribuicao)
    ON DELETE SET NULL;

/*--------------------------------------------*/
/*                VotoPergunta                */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotoPergunta (
    idPergunta  integer     NOT NULL,
    idAutor     integer     NOT NULL,
    valor       integer     DEFAULT 0
);

ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT PK_VotoPergunta
    PRIMARY KEY (idPergunta, idAutor);
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT CK_VotoPergunta_Valor
    CHECK (valor = 1 OR valor = 0 OR valor = -1);
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idPergunta
    FOREIGN KEY (idPergunta) REFERENCES knowUP.Pergunta(idPergunta)
    ON DELETE CASCADE;
ALTER TABLE knowUP.VotoPergunta ADD CONSTRAINT FK_VotoPergunta_idAutor
    FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
    ON DELETE CASCADE;

/*--------------------------------------------*/
/*                VotoResposta                */
/*--------------------------------------------*/

CREATE TABLE knowUP.VotoResposta (
    idResposta  integer     NOT NULL,
    idAutor     integer     NOT NULL,
    valor       integer     DEFAULT 0
);

ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT PK_VotoResposta
    PRIMARY KEY (idResposta, idAutor);
ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT CK_VotoResposta_Valor
    CHECK (valor = 1 OR valor = 0 OR valor = -1);
 ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT FK_VotoResposta_idResposta
    FOREIGN KEY (idResposta) REFERENCES knowUP.Resposta(idResposta)
    ON DELETE CASCADE;
ALTER TABLE knowUP.VotoResposta ADD CONSTRAINT FK_VotoResposta_idAutor
    FOREIGN KEY (idAutor) REFERENCES knowUP.Utilizador(idUtilizador)
    ON DELETE CASCADE;

/*--------------------------------------------*/
/*                 Notificação                */
/*--------------------------------------------*/

CREATE TABLE knowUP.Notificacao (
    idNotificacao   serial      NOT NULL,
    idPergunta      integer     NOT NULL,
    idContribuicao  integer     NOT NULL
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
/*                  Mensagem                  */
/*--------------------------------------------*/

CREATE TABLE knowUP.Mensagem (
    idMensagem      serial      NOT NULL,
    idRemetente     integer     NOT NULL,
    idDestinatario  integer     NOT NULL,
    titulo          text        NULL,
    descricao       text        NOT NULL,
    dataHora        timestamp   DEFAULT current_timestamp
);

ALTER TABLE knowUP.Mensagem ADD CONSTRAINT PK_Mensagem
    PRIMARY KEY (idMensagem);
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT CK_Mensagem_AutoresDiferentes
    CHECK (idRemetente != idDestinatario);
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT FK_Mensagem_idRemetente
    FOREIGN KEY (idRemetente) REFERENCES knowUP.Utilizador(idUtilizador)
    ON DELETE SET NULL;
ALTER TABLE knowUP.Mensagem ADD CONSTRAINT FK_Mensagem_idDestinatario
    FOREIGN KEY (idDestinatario) REFERENCES knowUP.Utilizador(idUtilizador)
    ON DELETE SET NULL;

/*--------------------------------------------*/
/*                    Views                   */
/*--------------------------------------------*/

DROP VIEW IF EXISTS knowUP.CategoriasPorInstituicao;
CREATE VIEW knowUP.CategoriasPorInstituicao AS
	SELECT Instituicao.sigla, Categoria.idCategoria, Categoria.nome
	FROM knowup.Instituicao
	JOIN knowup.CategoriaInstituicao USING (idInstituicao)
	JOIN knowup.Categoria USING (idCategoria)
	ORDER BY Instituicao.sigla, Categoria.nome;

DROP VIEW IF EXISTS knowUP.MembrosInstituicao;
CREATE OR REPLACE VIEW knowUP.MembrosInstituicao AS
	SELECT Instituicao.idInstituicao,
		Instituicao.nome,
		Instituicao.sigla,
		Instituicao.morada,
		Instituicao.contacto,
		Instituicao.website,
		COALESCE(count(Utilizador.idUtilizador), 0) AS count
	FROM knowUP.Instituicao
	LEFT JOIN knowUP.Utilizador USING(idInstituicao)
	GROUP BY Instituicao.idInstituicao;

/*--------------------------------------------*/
/*                Procedimentos               */
/*--------------------------------------------*/

CREATE FUNCTION knowUP.apagarVoto() RETURNS trigger AS $decrementVotes$
	BEGIN
		IF new.valor = 1
			THEN UPDATE knowUP.Perguntas SET
				votosPositivos = votosPositivos - 1,
				pontuacao = pontuacao - 1
			WHERE new.contribuicaoID = contribuicaoID;
		ELSE IF new.valor = -1
			THEN UPDATE knowUP.Perguntas SET
				votosNegativos = votosNegativos - 1,
				pontuacao = pontuacao + 1
			WHERE new.contribuicaoID = contribuicaoID;
		END IF;
		return new;
	END;
$decrementVotes$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*                  Triggers                  */
/*--------------------------------------------*/

CREATE TRIGGER incrementarVotosPergunta
	AFTER INSERT ON knowUP.VotosPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.incrementVotes();
CREATE TRIGGER incrementarVotosResposta
	AFTER INSERT ON knowUP.incrementVotes();
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.incrementVotes();

CREATE TRIGGER decrementarVotosPergunta
	BEFORE DELETE ON knowUP.VotosPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.decrementVotes();
CREATE TRIGGER decrementarVotosResposta
	BEFORE DELETE ON knowUP.VotosResposta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.decrementVotes();

/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

INSERT INTO Categoria VALUES (1, 'Bioengenharia');
INSERT INTO Categoria VALUES (2, 'Engenharia Ambiente');
INSERT INTO Categoria VALUES (3, 'Engenharia Civil');
INSERT INTO Categoria VALUES (4, 'Engenharia Eletrotécnica');
INSERT INTO Categoria VALUES (5, 'Engenharia Informática');
INSERT INTO Categoria VALUES (6, 'Engenharia Industrial e Gestão');
INSERT INTO Categoria VALUES (7, 'Engenharia Mecânica');
INSERT INTO Categoria VALUES (8, 'Engenharia Metalúrgica');
INSERT INTO Categoria VALUES (9, 'Engenharia Química');
INSERT INTO Categoria VALUES (10, 'Criminologia');
INSERT INTO Categoria VALUES (11, 'Direito');
INSERT INTO Categoria VALUES (12, 'Ciências Forenses');

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

INSERT INTO Instituicao
VALUES (1, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (2, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (3, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (4, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (5, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (6, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (7, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (8, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Prof. Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (9, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt/web_page.inicial');

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

INSERT INTO CategoriaInstituicao VALUES (7, 5);
INSERT INTO CategoriaInstituicao VALUES (8, 5);
INSERT INTO CategoriaInstituicao VALUES (9, 5);
INSERT INTO CategoriaInstituicao VALUES (6, 5);
INSERT INTO CategoriaInstituicao VALUES (5, 5);
INSERT INTO CategoriaInstituicao VALUES (4, 5);
INSERT INTO CategoriaInstituicao VALUES (3, 5);
INSERT INTO CategoriaInstituicao VALUES (2, 5);
INSERT INTO CategoriaInstituicao VALUES (1, 5);
INSERT INTO CategoriaInstituicao VALUES (10, 3);
INSERT INTO CategoriaInstituicao VALUES (11, 3);
INSERT INTO CategoriaInstituicao VALUES (12, 3);
INSERT INTO CategoriaInstituicao VALUES (12, 6);

/*--------------------------------------------*/
/*                 Utilizador                 */
/*--------------------------------------------*/

INSERT INTO Utilizador
VALUES (1, NULL, 'admin', 'seguranca101', 'contact@knowup.pt', 'Administrador', 'NULL', 'Porto', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (2, 5, 'marques999', '14191091', 'up201305642@fe.up.pt', 'Diogo', 'Marques', 'Valongo', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (6, 5, 'mellus', 'abcdefg', 'up201305618@fe.up.pt', 'Pedro', 'Melo', 'Penafiel', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (4, 5, 'darklord', 'naosei', 'tambemnaosei@gmail.com', 'Vitor', 'Esteves', 'Mirandela', 'pt', true, '2016-04-02 12:30:04.255597');

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

INSERT INTO Administrador VALUES(1, 1);

/*--------------------------------------------*/
/*                 Moderador                  */
/*--------------------------------------------*/

INSERT INTO Moderador VALUES(1, 1);
INSERT INTO Moderador VALUES(2, 2);