SET SCHEMA 'knowup';

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
/*          Pergunta_IDX_MaisVistas           */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_MaisVistas facilita a listagem e ordenação
-- das perguntas mais vistas. Considerou-se um índice do tipo btree
-- já que esta operação se baseia na comparação de grandeza entre o
-- número de visitas às paginas das respectivas perguntas.

CREATE INDEX Pergunta_IDX_MaisVistas
ON Pergunta USING btree(visualizacoes);

/*--------------------------------------------*/
/*          Pergunta_IDX_MaisVotadas          */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_MaisVotadas facilita a listagem e ordenação
-- das perguntas com melhor classificação. Considerou-se um índice do
-- tipo btree já que esta operação se baseia na comparação de grandeza
-- entre as classificações atríbuidas às diversas perguntas existentes
-- no sistema.

CREATE INDEX Pergunta_IDX_MaisVotadas
ON Pergunta USING btree(valor);

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

CREATE INDEX Utilizador_IDX_Search
ON Utilizador USING gin(to_tsvector('english', username || ' ' || primeiroNome || ' ' || ultimoNome));

/*--------------------------------------------*/
/*            Pergunta_IDX_Pesquisa           */
/*--------------------------------------------*/

-- O índice Pergunta_IDX_Pesquisa facilita operações de pesquisa full-text
-- nos corpos e nos títulos das perguntas existentes no sistema, apresentando
-- os resultados ordenados por relevância. Considerou-se um índice do tipo gin
-- já que este tipo de pesquisa utiliza um vector de palavras e permite verificar
-- se determinada palavra ou expressão está contida no corpo ou no título de uma
-- pergunta.

CREATE INDEX Pergunta_IDX_Pesquisa
ON Pergunta USING gin(to_tsvector(titulo || ' ' || coalesce(descricao, ''));

/*--------------------------------------------*/
/*          Contribuicao_IDX_Pesquisa         */
/*--------------------------------------------*/

-- O índice Contribuicao_IDX_Pesquisa facilita operações de pesquisa full-text
-- nos corpos das contribuições às perguntas dos utilizadores, apresentando
-- os resultados ordenados por relevância. Considerou-se um índice do tipo gin
-- já que este tipo de pesquisa utiliza um vector de palavras e permite verificar
-- se determinada palavra ou expressão está contida no corpo de uma contribuição.

CREATE INDEX Contribuicao_IDX_Pesquisa
ON Contribuicao USING gin(to_tsvector(descricao));