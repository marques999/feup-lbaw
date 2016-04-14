SET SCHEMA 'knowup';

DROP INDEX IF EXISTS CategoriaInstituicao_IDX_Lookup;
DROP INDEX IF EXISTS Resposta_IDX_Lookup;
DROP INDEX IF EXISTS Contribuicao_IDX_Pesquisa;
DROP INDEX IF EXISTS Pergunta_IDX_Pesquisa;
DROP INDEX IF EXISTS Utilizador_IDX_Pesquisa;
DROP INDEX IF EXISTS Contribuicao_IDX_MaisRecentes;
DROP INDEX IF EXISTS Pergunta_IDX_MaisRecentes;
DROP INDEX IF EXISTS Categoria_IDX_Pesquisa
DROP INDEX IF EXISTS Utilizador_IDX_Username;

/*--------------------------------------------*/
/*          Utilizador_IDX_Username           */
/*--------------------------------------------*/

CREATE INDEX Utilizador_IDX_Username
ON Utilizador USING hash(username);

/*--------------------------------------------*/
/*           Categoria_IDX_Pesquisa           */
/*--------------------------------------------*/

CREATE INDEX Categoria_IDX_Pesquisa
ON Categoria USING hash(nome);

/*--------------------------------------------*/
/*         Pergunta_IDX_MaisRecentes          */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_MaisRecentes facilita a listagem e ordenação
-- das perguntas mais recentes. Considerou-se um índice do tipo btree
-- já que esta operação se baseia na comparação de grandeza entre as
-- datas de publicação das perguntas.

CREATE INDEX Pergunta_IDX_MaisRecentes
ON Pergunta USING btree(dataHora);

/*--------------------------------------------*/
/*       Contribuicao_IDX_MaisRecentes        */
/*--------------------------------------------*/

-- O índice Contribuicao_IDX_MaisRecentes facilita a listagem e ordenação
-- das contribuições mais recentes. Considerou-se um índice do tipo btree
-- já que esta operação se baseia na comparação de grandeza entre as datas
-- de publicação das contribuições.

CREATE INDEX Contribuicao_IDX_MaisRecentes
ON Contribuicao USING btree(dataHora);

/*--------------------------------------------*/
/*          Utilizador_IDX_Pesquisa           */
/*--------------------------------------------*/

-- O índice Utilizador_IDX_Pesquisa facilita operações de pesquisa full-text
-- sobre os utilizadores (username, primeiro nome, último nome), apresentando
-- os resultados ordenados por relevância. Considerou-se um índice do tipo gin
-- já que este tipo de pesquisa utiliza um vector de palavras e permite verificar
-- se os termos de pesquisa introduzidos pelo utilizador estão contidos numa das
-- três colunas apresentadas em cima.

CREATE INDEX Utilizador_IDX_Pesquisa
ON Utilizador USING gin(to_tsvector('english', username || ' ' || primeiroNome || ' ' || ultimoNome));

/*--------------------------------------------*/
/*           Pergunta_IDX_Pesquisa            */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_Pesquisa facilita operações de pesquisa full-text
-- nos corpos e nos títulos das perguntas existentes no sistema, apresentando
-- os resultados ordenados por relevância. Considerou-se um índice do tipo gin
-- já que este tipo de pesquisa utiliza um vector de palavras e permite verificar
-- se determinada palavra ou expressão está contida no corpo ou no título de uma
-- pergunta.

CREATE INDEX Pergunta_IDX_Pesquisa
ON Pergunta USING gin(to_tsvector('english', titulo || ' ' || coalesce(descricao, '')));

/*--------------------------------------------*/
/*         Contribuicao_IDX_Pesquisa          */
/*--------------------------------------------*/

-- O índice Contribuicao_IDX_Pesquisa facilita operações de pesquisa full-text
-- nos corpos das contribuições às perguntas dos utilizadores, apresentando
-- os resultados ordenados por relevância. Considerou-se um índice do tipo gin
-- já que este tipo de pesquisa utiliza um vector de palavras e permite verificar
-- se determinada palavra ou expressão está contida no corpo de uma contribuição.

CREATE INDEX Contribuicao_IDX_Pesquisa
ON Contribuicao USING gin(to_tsvector('english', descricao));

/*--------------------------------------------*/
/*            Resposta_IDX_Lookup             */
/*--------------------------------------------*/

CREATE INDEX Resposta_IDX_Lookup
ON Resposta USING hash(idPergunta, idResposta);

/*--------------------------------------------*/
/*      CategoriaInstituicao_IDX_Lookup       */
/*--------------------------------------------*/

CREATE INDEX CategoriaInstituicao_IDX_Lookup
ON CategoriaInstituicao USING hash(idInstituicao, idCategoria);