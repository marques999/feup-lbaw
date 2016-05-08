/*------------------------------------------------*/
/* SQL801: OBTER UTILIZADORES COM MAIS PERGUNTAS  */
/*------------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(Pergunta.idPergunta) AS ultimaPergunta,
       to_char(MAX(Pergunta.dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
       COALESCE(COUNT(Pergunta.idPergunta), 0) AS count
FROM Pergunta
LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
GROUP BY idUtilizador
HAVING MAX(dataHora) > current_date - interval '1 year';
ORDER BY count DESC, dataHora DESC 
LIMIT 5;

/*------------------------------------------------*/
/* SQL802: OBTER UTILIZADORES COM MAIS RESPOSTAS  */
/*------------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(Contribuicao.idContribuicao) AS ultimaResposta,
       to_char(MAX(Contribuicao.dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
       COALESCE(COUNT(Resposta.idResposta), 0) AS count
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
NATURAL JOIN Utilizador
GROUP BY Utilizador.idUtilizador
HAVING MAX(dataHora) > current_date - interval '1 year';
ORDER BY count DESC, dataHora DESC
LIMIT 5;

/*------------------------------------------------*/
/* SQL803: OBTER CATEGORIAS MAIS POPULARES        */
/*------------------------------------------------*/
SELECT Categoria.*,
      MAX(idPergunta) as ultimaPergunta,
      to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
      COALESCE(COUNT(idPergunta), 0) AS count
FROM Categoria
JOIN Pergunta USING(idCategoria)
GROUP BY idCategoria, idPergunta
HAVING MAX(dataHora) > current_date - interval '1 year';
ORDER BY count DESC, dataHora DESC 
LIMIT 5;

/*------------------------------------------------*/
/* SQL804: OBTER INSTITUIÇÕES MAIS POPULARES      */
/*------------------------------------------------*/
SELECT Instituicao.idInstituicao,
       Instituicao.sigla,
       upper(Instituicao.sigla),
       MAX(idPergunta) AS ultimaPergunta,
       to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
       COALESCE(COUNT(idPergunta), 0) AS count
FROM CategoriaInstituicao
NATURAL JOIN Pergunta
NATURAL JOIN Instituicao
GROUP BY Instituicao.idInstituicao
HAVING MAX(dataHora) > current_date - interval '1 year';
ORDER BY count DESC, dataHora DESC
LIMIT 5;