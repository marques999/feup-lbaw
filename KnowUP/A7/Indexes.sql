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

-- O índice Categoria_IDX_Pesquisa facilita operações de pesquisa sobre
-- as categorias de perguntas existentes. Os resultados serão ordenados
-- por ordem alfabética. Considerou-se um índice do tipo hash, já que
-- esta operação se baseia num critério de igualdade.

CREATE INDEX Categoria_IDX_Pesquisa
ON Categoria USING hash(nome);

/*--------------------------------------------*/
/*       Contribuicao_IDX_MaisRecentes        */
/*--------------------------------------------*/

-- O índice Contribuicao_IDX_MaisRecentes facilita a listagem e ordenação
-- das contribuições mais recentes. Considerou-se um índice do tipo btree
-- já que esta operação se baseia na comparação de grandeza entre as datas
-- de publicação das contribuições e a data corrente.

CREATE INDEX Contribuicao_IDX_MaisRecentes
ON Contribuicao USING btree(dataHora);

/*--------------------------------------------*/
/*            Pergunta_IDX_Lookup             */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_Lookup traduz a relação pergunta <=> autor.
-- Considerou-se um índice do tipo btree já que se trata de um índice
-- composto entre uma chave primária e uma chave externa da mesma tabela.

CREATE INDEX Pergunta_IDX_Lookup
ON Pergunta USING btree(idPergunta, idAutor);

/*--------------------------------------------*/
/*         Pergunta_IDX_MaisRecentes          */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_MaisRecentes facilita a listagem e ordenação
-- das perguntas mais recentes. Considerou-se um índice do tipo btree
-- já que esta operação se baseia na comparação de grandeza entre as
-- datas de publicação das perguntas e a data corrente.

CREATE INDEX Pergunta_IDX_MaisRecentes
ON Pergunta USING btree(dataHora);

/*--------------------------------------------*/
/*           Pergunta_IDX_Pesquisa            */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_Pesquisa facilita operações de pesquisa
-- full-text nos corpos, nos títulos e nas respostas das perguntas
-- existentes no sistema, apresentando os resultados ordenados por
-- relevância. Considerou-se um índice do tipo gin já que este tipo
-- de pesquisa recorre a vectores de palavras e permite verificar se
-- determinada palavra ou expressão está contida num dos três campos
-- acima apresentados.

CREATE INDEX Pergunta_IDX_Pesquisa
ON PerguntasPesquisa USING gin(pesquisa);

/*--------------------------------------------*/
/*            Resposta_IDX_Lookup             */
/*--------------------------------------------*/

-- O índice Resposta_IDX_Lookup traduz a relação respostas <=> pergunta.
-- Considerou-se um índice do tipo btree já que se trata de um índice
-- composto entre uma chave primária e uma chave externa da mesma tabela.

CREATE INDEX Resposta_IDX_Lookup
ON Resposta USING btree(idResposta, idPergunta);

/*--------------------------------------------*/
/*          Utilizador_IDX_Pesquisa           */
/*--------------------------------------------*/

-- O índice Utilizador_IDX_Pesquisa facilita operações de pesquisa full-text
-- sobre os utilizadores (nos campos username, primeiro nome, último nome,
-- endereço de e-mail), apresentando os resultados ordenados por relevância.
-- Considerou-se um índice do tipo gin, já que este tipo de pesquisa recorre
-- a vectores de palavras para verificar se os termos de pesquisa introduzidos
-- pelo utilizador estão contidos numa dos quatro campos apresentados em cima.

CREATE INDEX Utilizador_IDX_Pesquisa
ON UtilizadoresPesquisa USING gin(pesquisa);

/*--------------------------------------------*/
/*          Utilizador_IDX_Username           */
/*--------------------------------------------*/

-- O índice Utilizador_IDX_Username facilita a autenticação dos utilizadores
-- através da combinação username/palavra-passe. Considerou-se um índice do
-- tipo hash já que esta operação se baseia num critério de igualdade.

CREATE INDEX Utilizador_IDX_Username
ON Utilizador USING hash(username);