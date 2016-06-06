SET SCHEMA 'knowup';

DROP INDEX IF EXISTS Categoria_IDX_Pesquisa;
DROP INDEX IF EXISTS Contribuicao_IDX_MaisRecentes;
DROP INDEX IF EXISTS Pergunta_IDX_Lookup;
DROP INDEX IF EXISTS Pergunta_IDX_MaisRecentes;
DROP INDEX IF EXISTS Pergunta_IDX_Pesquisa;
DROP INDEX IF EXISTS Resposta_IDX_Lookup;
DROP INDEX IF EXISTS Utilizador_IDX_Pesquisa;
DROP INDEX IF EXISTS Utilizador_IDX_Username;

/*--------------------------------------------*/
/*           Categoria_IDX_Pesquisa           */
/*--------------------------------------------*/

CREATE INDEX Categoria_IDX_Pesquisa
ON Categoria USING hash(nome);

/*--------------------------------------------*/
/*      CategoriaInstituicao_IDX_Lookup       */
/*--------------------------------------------*/

CREATE INDEX CategoriaInstituicao_IDX_Lookup
ON CategoriaInstituicao USING btree(idInstituicao, idCategoria);

ALTER TABLE CategoriaInstituicao CLUSTER ON CategoriaInstituicao_IDX_Lookup;

/*--------------------------------------------*/
/*          Contribuicao_IDX_Lookup           */
/*--------------------------------------------*/

CREATE INDEX Contribuicao_IDX_Lookup
ON Contribuicao USING btree(idUtilizador, idContribuicao);

ALTER TABLE Contribuicao CLUSTER ON Contribuicao_IDX_Lookup;

/*--------------------------------------------*/
/*       Contribuicao_IDX_MaisRecentes        */
/*--------------------------------------------*/

CREATE INDEX Contribuicao_IDX_MaisRecentes
ON Contribuicao USING btree(dataHora);

/*--------------------------------------------*/
/*            Pergunta_IDX_Lookup             */
/*--------------------------------------------*/

CREATE INDEX Pergunta_IDX_Lookup
ON Pergunta USING btree(idPergunta, idUtilizador);

/*--------------------------------------------*/
/*         Pergunta_IDX_MaisRecentes          */
/*--------------------------------------------*/

CREATE INDEX Pergunta_IDX_MaisRecentes
ON Pergunta USING btree(dataHora);

/*--------------------------------------------*/
/*           Pergunta_IDX_Pesquisa            */
/*--------------------------------------------*/

CREATE INDEX Pergunta_IDX_Pesquisa
ON PerguntasPesquisa USING gin(pesquisa);

/*--------------------------------------------*/
/*            Resposta_IDX_Lookup             */
/*--------------------------------------------*/

CREATE INDEX Resposta_IDX_Lookup
ON Resposta USING btree(idResposta, idPergunta);

ALTER TABLE Resposta CLUSTER ON Resposta_IDX_Lookup;

/*--------------------------------------------*/
/*          Utilizador_IDX_Pesquisa           */
/*--------------------------------------------*/

CREATE INDEX Utilizador_IDX_Pesquisa
ON UtilizadoresPesquisa USING gin(pesquisa);

/*--------------------------------------------*/
/*          Utilizador_IDX_Username           */
/*--------------------------------------------*/

CREATE INDEX Utilizador_IDX_Username
ON Utilizador USING hash(username);