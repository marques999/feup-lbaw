/*------------------------------------------------*/
/* SQL201: OBTER PERGUNTAS                        */
/*------------------------------------------------*/
SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       Pergunta.pontuacao,
       Pergunta.respostas
FROM Pergunta
NATURAL JOIN Utilizador;

/*
 * possíveis filtros de pesquisa
 */
WHERE dataHora > current_date - interval '1 day'   -- perguntas publicadas nas últimas 24 horas
WHERE dataHora > current_date - interval '2 days'  -- perguntas publicadas nas últimas 48 horas
WHERE dataHora > current_date - interval '7 days'  -- perguntas publicadas nos últimos 7 dias
WHERE dataHora > current_date - interval '1 month' -- perguntas publicadas nos últimos 30 dias
WHERE dataHora > current_date - interval '1 year'  -- perguntas publicadas nos últimos 12 meses

/*
 * possíveis critérios de ordenação
 */
ORDER BY titulo                  -- ordenar por título (ASC/desc)
ORDER BY dataHora                -- ordenar por data de publicação (asc/DESC)
ORDER BY pontuacao               -- ordenar por pontuação (asc/DESC)
ORDER BY numeroRespostas         -- ordenar por número de respostas (asc/DESC)

/*------------------------------------------------*/
/* SQL202: OBTER UTILIZADORES                     */
/*------------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email
FROM Utilizador;

/*
 * possíveis filtros de pesquisa
 */
WHERE ativo AND NOT removido       -- mostrar apenas utilizadores ativos
WHERE NOT ativo AND NOT removido   -- mostrar apenas utilizadores banidos
WHERE removido                     -- mostrar apenas utilizadores inativos

/*
 * possíveis critérios de ordenação
 */
ORDER BY idUtilizador              -- ordenar por identificador (ASC/desc)
ORDER BY username                  -- ordenar por username (ASC/desc)
ORDER BY email                     -- ordenar por endereço de email (ASC/desc)
ORDER BY nomeUtilizador            -- ordenar por nome completo (ASC/desc)
ORDER BY dataRegisto               -- ordenar por data de registo (asc/DESC)

/*------------------------------------------------*/
/* SQL203: PESQUISAR PERGUNTAS                    */
/*------------------------------------------------*/
SELECT PerguntasPesquisa.idPergunta,
       PerguntasPesquisa.idUtilizador,
       PerguntasPesquisa.nomeUtilizador,
       PerguntasPesquisa.removido,
       PerguntasPesquisa.titulo,
       PerguntasPesquisa.dataHora,
       PerguntasPesquisa.ativa,
       PerguntasPesquisa.pontuacao,
       PerguntasPesquisa.respostas,
       ts_rank_cd(pesquisa, query) AS rank,
       ts_headline('portuguese', conteudo, query) AS descricao
FROM PerguntasPesquisa, plainto_tsquery('portuguese', :stringPesquisa) AS query
WHERE query @@ pesquisa;

/*
 * possíveis filtros de pesquisa
 */
AND dataHora > current_date - interval '1 day'   -- perguntas publicadas nas últimas 24 horas
AND dataHora > current_date - interval '2 days'  -- perguntas publicadas nas últimas 48 horas
AND dataHora > current_date - interval '7 days'  -- perguntas publicadas nos últimos 7 dias
AND dataHora > current_date - interval '1 month' -- perguntas publicadas nos últimos 30 dias
AND dataHora > current_date - interval '1 year'  -- perguntas publicadas nos últimos 12 meses

/*
 * possíveis critérios de ordenação
 */
ORDER BY rank                    -- ordenar por relevância (ASC/desc)
ORDER BY titulo                  -- ordenar por título (ASC/desc)
ORDER BY dataHora                -- ordenar por data de publicação (asc/DESC)
ORDER BY pontuacao               -- ordenar por pontuação (asc/DESC)
ORDER BY numeroRespostas         -- ordenar por número de respostas (asc/DESC)

/*------------------------------------------------*/
/* SQL204: PESQUISAR UTILIZADORES                 */
/*------------------------------------------------*/
SELECT UtilizadoresPesquisa.idUtilizador,
       UtilizadoresPesquisa.username,
       UtilizadoresPesquisa.nomeUtilizador,
       UtilizadoresPesquisa.email,
       ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
WHERE query @@ pesquisa;

/*
 * possíveis filtros de pesquisa
 */
AND ativo AND NOT removido       -- mostrar apenas utilizadores ativos
AND NOT ativo AND NOT removido   -- mostrar apenas utilizadores banidos
AND removido                     -- mostrar apenas utilizadores inativos

/*
 * possíveis critérios de ordenação
 */
ORDER BY rank                    -- ordenar por relevância (ASC/desc)
ORDER BY username                -- ordenar por username (ASC/desc)
ORDER BY email                   -- ordenar por endereço de e-mail (ASC/desc)
ORDER BY nomeUtilizador          -- ordenar por nome completo (ASC/desc)
ORDER BY dataRegisto             -- ordenar por data de registo (asc/DESC)