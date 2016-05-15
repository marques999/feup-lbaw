/*------------------------------------------------*/
/* SQL801: OBTER UTILIZADORES DENUNCIADOS         */
/*------------------------------------------------*/
SELECT Report.idReport,
       Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Report.descricao,
       Report.dataHora
FROM Report
NATURAL JOIN Utilizador;

/*------------------------------------------------*/
/* SQL802: OBTER UTILIZADORES COM MAIS PERGUNTAS  */
/*------------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(idPergunta) AS ultimaPergunta,
       MAX(dataHora) AS dataHora,
       COALESCE(COUNT(idPergunta), 0) AS count
FROM Pergunta
NATURAL JOIN Utilizador
GROUP BY Utilizador.idUtilizador
ORDER BY count DESC, dataHora DESC LIMIT 5;

-- possíveis filtros de listagem
HAVING MAX(dataHora) > current_date - interval '1 day'   -- mostrar estatísticas das últimas 24 horas
HAVING MAX(dataHora) > current_date - interval '7 days'  -- mostrar estatísticas dos últimos 7 dias
HAVING MAX(dataHora) > current_date - interval '1 month' -- mostrar estatísticas dos últimos 30 dias
HAVING MAX(dataHora) > current_date - interval '6 month' -- mostrar estatísticas dos últimos 6 meses
HAVING MAX(dataHora) > current_date - interval '1 year'  -- mostrar estatísticas dos últimos 12 meses

/*------------------------------------------------*/
/* SQL803: OBTER UTILIZADORES COM MAIS RESPOSTAS  */
/*------------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(Contribuicao.idContribuicao) AS ultimaResposta,
       MAX(Contribuicao.dataHora) AS dataHora,
       COALESCE(COUNT(Resposta.idResposta), 0) AS count
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
NATURAL JOIN Utilizador
GROUP BY Utilizador.idUtilizador
ORDER BY count DESC, dataHora DESC LIMIT 5;.

-- possíveis filtros de listagem
HAVING MAX(dataHora) > current_date - interval '1 day'   -- mostrar estatísticas das últimas 24 horas
HAVING MAX(dataHora) > current_date - interval '7 days'  -- mostrar estatísticas dos últimos 7 dias
HAVING MAX(dataHora) > current_date - interval '1 month' -- mostrar estatísticas dos últimos 30 dias
HAVING MAX(dataHora) > current_date - interval '6 month' -- mostrar estatísticas dos últimos 6 meses
HAVING MAX(dataHora) > current_date - interval '1 year'  -- mostrar estatísticas dos últimos 12 meses

/*------------------------------------------------*/
/* SQL804: OBTER CATEGORIAS MAIS POPULARES        */
/*------------------------------------------------*/
SELECT Categoria.*,
      MAX(idPergunta) as ultimaPergunta,
      to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
      COALESCE(COUNT(idPergunta), 0) AS count
FROM Categoria
NATURAL JOIN Pergunta
GROUP BY idCategoria, idPergunta
ORDER BY count DESC, dataHora DESC LIMIT 5;

-- possíveis filtros de listagem
HAVING MAX(dataHora) > current_date - interval '1 day'   -- mostrar estatísticas das últimas 24 horas
HAVING MAX(dataHora) > current_date - interval '7 days'  -- mostrar estatísticas dos últimos 7 dias
HAVING MAX(dataHora) > current_date - interval '1 month' -- mostrar estatísticas dos últimos 30 dias
HAVING MAX(dataHora) > current_date - interval '6 month' -- mostrar estatísticas dos últimos 6 meses
HAVING MAX(dataHora) > current_date - interval '1 year'  -- mostrar estatísticas dos últimos 12 meses

/*------------------------------------------------*/
/* SQL805: OBTER INSTITUIÇÕES MAIS POPULARES      */
/*------------------------------------------------*/
SELECT Instituicao.idInstituicao,
       Instituicao.sigla,
       MAX(idPergunta) AS ultimaPergunta,
       to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
       COALESCE(COUNT(idPergunta), 0) AS count
FROM CategoriaInstituicao
NATURAL JOIN Pergunta
NATURAL JOIN Instituicao
GROUP BY Instituicao.idInstituicao
ORDER BY COUNT DESC, dataHora DESC LIMIT 5;

-- possíveis filtros de listagem
HAVING MAX(dataHora) > current_date - interval '1 day'   -- mostrar estatísticas das últimas 24 horas
HAVING MAX(dataHora) > current_date - interval '7 days'  -- mostrar estatísticas dos últimos 7 dias
HAVING MAX(dataHora) > current_date - interval '1 month' -- mostrar estatísticas dos últimos 30 dias
HAVING MAX(dataHora) > current_date - interval '6 month' -- mostrar estatísticas dos últimos 6 meses
HAVING MAX(dataHora) > current_date - interval '1 year'  -- mostrar estatísticas dos últimos 12 meses

/*--------------------------------------------*/
/* SQL806: OBTER UTILIZADORES                 */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
       COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
FROM Utilizador
LEFT JOIN Pergunta USING(idUtilizador)
LEFT JOIN Contribuicao USING(idUtilizador)
LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
LEFT JOIN Instituicao USING(idInstituicao)
AND idUtilizador <> 1
GROUP BY idUtilizador, sigla
ORDER BY idUtilizador;