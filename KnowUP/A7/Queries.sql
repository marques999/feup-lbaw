SET SCHEMA 'knowup';

/*--------------------------------------------*/
/* LISTAR CATEGORIAS DE UMA INSTITUIÇÃO       */
/*--------------------------------------------*/

SELECT Categoria.idCategoria, Categoria.nome
  FROM Instituicao
  JOIN CategoriaInstituicao USING(idInstituicao)
  JOIN Categoria USING(idCategoria)
  WHERE idInstituicao = :idInstituicao
  ORDER BY nome ASC;

/*--------------------------------------------*/
/* LISTAR INSTITUIÇÕES DE UMA CATEGORIA       */
/*--------------------------------------------*/

SELECT Instituicao.idInstituicao, Instituicao.sigla
  FROM Categoria
  JOIN CategoriaInstituicao USING(idCategoria)
  JOIN Instituicao USING(idInstituicao)
  WHERE idCategoria = :idCategoria
  ORDER BY sigla ASC;

/*--------------------------------------------*/
/* VER PERGUNTA                               */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Pergunta.idCategoria,
       Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeutilizador,
       Utilizador.removido,
       Instituicao.sigla,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao
  FROM Pergunta
  JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
  JOIN Instituicao USING(idInstituicao)
  LEFT JOIN (SELECT idPergunta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoPergunta
    WHERE idPergunta = :idPergunta
    GROUP BY idPergunta)
    AS TabelaVotos
    USING (idPergunta)
  LEFT JOIN (SELECT idPergunta, COUNT(*)
    FROM Seguidor
    WHERE idPergunta = :idPergunta
    GROUP BY idPergunta)
    AS TabelaSeguidores
    USING (idPergunta)
  WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* LISTAR RESPOSTAS A UMA PERGUNTA            */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Instituicao.sigla,
       Contribuicao.descricao,
       Contribuicao.dataHora,
       COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
       Resposta.melhorResposta
  FROM Resposta
  JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
  JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
  JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
  LEFT JOIN (SELECT idResposta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoResposta
    GROUP BY idResposta)
    AS TabelaVotos
    USING (idResposta)
  LEFT JOIN (SELECT idResposta, COUNT(*)
    FROM ComentarioResposta
    GROUP BY idResposta)
    AS TabelaComentarios
    USING (idResposta)
  WHERE Resposta.idPergunta = :idPergunta
  ORDER BY Resposta.idResposta DESC;

/*--------------------------------------------*/
/* LISTAR PERGUNTAS POR CATEGORIA             */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
  FROM Pergunta
  LEFT JOIN VotoPergunta USING(idPergunta)
  LEFT JOIN (SELECT idPergunta, COUNT(*)
    FROM Resposta
    GROUP BY idPergunta)
    AS TabelaRespostas
    USING (idPergunta)
  JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
  WHERE Pergunta.idCategoria = :idCategoria
  GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
  ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* LISTAR PERGUNTAS POR INSTITUIÇÃO           */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
  FROM CategoriaInstituicao
  JOIN Pergunta USING(idCategoria)
  JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
  LEFT JOIN VotoPergunta USING(idPergunta)
  LEFT JOIN (SELECT idPergunta, COUNT(*)
    FROM Resposta
    GROUP BY idPergunta)
    AS TabelaRespostas
    USING (idPergunta)
  WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
  GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
  ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* LISTAR PERGUNTAS POR AUTOR                 */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
  FROM Utilizador
  JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
  LEFT JOIN VotoPergunta USING(idPergunta)
  WHERE Utilizador.idUtilizador = :idUtilizador
  GROUP BY Pergunta.idPergunta
  ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* LISTAR RESPOSTAS POR AUTOR                 */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
       Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.ativa,
       Contribuicao.descricao,
       Contribuicao.dataHora,
       Resposta.melhorResposta,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
  FROM Contribuicao
  JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
  JOIN Pergunta ON Pergunta.idPergunta = Resposta.idPergunta
  JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
  LEFT JOIN VotoResposta USING(idResposta)
  WHERE Contribuicao.idAutor = :idUtilizador
  GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
  ORDER BY Contribuicao.dataHora DESC;

/*--------------------------------------------*/
/* PESQUISAR PERGUNTAS                        */
/*--------------------------------------------*/

SELECT QueryPrincipal.idPergunta,
       QueryPrincipal.idUtilizador,
       QueryPrincipal.nomeUtilizador,
       QueryPrincipal.titulo,
       QueryPrincipal.dataHora,
       QueryPrincipal.ativa,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
       ts_headline('portuguese', QueryPrincipal.conteudo, query) AS descricao,
       QueryPrincipal.rank
  FROM (SELECT PerguntasPesquisa.*, query, ts_rank_cd(pesquisa, query) AS rank
    FROM PerguntasPesquisa, plainto_tsquery('portuguese', :queryString) AS query
    WHERE query @@ pesquisa
    ORDER BY rank DESC) AS QueryPrincipal
  LEFT JOIN (SELECT idPergunta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoPergunta
    GROUP BY idPergunta)
    AS TabelaVotos
    USING (idPergunta)
  LEFT JOIN (SELECT idPergunta, COUNT(*)
    FROM Resposta
    GROUP BY idPergunta)
    AS TabelaRespostas
    USING (idPergunta);

/*--------------------------------------------*/
/* PESQUISAR UTILIZADORES                     */
/*--------------------------------------------*/

SELECT UtilizadoresPesquisa.idUtilizador,
       UtilizadoresPesquisa.username,
       UtilizadoresPesquisa.nomeUtilizador,
       UtilizadoresPesquisa.email,
       ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
  FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
  WHERE query @@ pesquisa
  ORDER BY rank DESC;

/*--------------------------------------------*/
/* LISTAR COMENTÁRIOS DE UMA PERGUNTA         */
/*--------------------------------------------*/

SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       Contribuicao.dataHora
  FROM ComentarioPergunta
  JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
  JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
  WHERE ComentarioPergunta.idPergunta = :idPergunta
  ORDER BY ComentarioPergunta.idComentario;

/*--------------------------------------------*/
/* LISTAR COMENTÁRIOS DE UMA RESPOSTA         */
/*--------------------------------------------*/

SELECT ComentarioResposta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       Contribuicao.dataHora
  FROM ComentarioResposta
  JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
  JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
  WHERE ComentarioResposta.idResposta = :idResposta
  ORDER BY ComentarioResposta.idComentario;

/*--------------------------------------------*/
/* LISTAR CATEGORIAS RELACIONADAS             */
/*--------------------------------------------*/

SELECT Categorias.idCategoria, Categorias.nome
  FROM Categoria
  JOIN CategoriaInstituicao CI1 USING(idCategoria)
  JOIN CategoriaInstituicao CI2 USING(idInstituicao)
  JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
  WHERE Categoria.idCategoria = :idCategoria
  AND Categorias.idCategoria <> Categoria.idCategoria
  GROUP BY Categorias.idCategoria;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES ACTIVOS                */
/*--------------------------------------------*/

SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
  FROM Utilizador
  LEFT JOIN Instituicao USING(idInstituicao)
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
  WHERE Utilizador.ativo AND NOT Utilizador.removido
  AND Utilizador.idUtilizador <> 1
  ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES BANIDOS                */
/*--------------------------------------------*/

SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
  FROM Utilizador
  LEFT JOIN Instituicao USING(idInstituicao)
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
  WHERE NOT Utilizador.ativo AND NOT Utilizador.removido
  AND Utilizador.idUtilizador <> 1
  ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES REMOVIDOS              */
/*--------------------------------------------*/

SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
  FROM Utilizador
  NATURAL LEFT JOIN Instituicao
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
  LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
  WHERE Utilizador.removido
  AND Utilizador.idUtilizador <> 1
  ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTAR CONVERSAS DE UM UTILIZADOR          */
/*--------------------------------------------*/

SELECT Conversa.idConversa,
       Conversa.titulo,
       (CASE WHEN :idUtilizador = idUtilizador1 THEN ultimoAcesso1 ELSE ultimoAcesso2 END)
       AS ultimoacesso,
       Utilizador.idUtilizador AS iddestinatario,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomedestinatario,
       Instituicao.sigla,
       (SELECT COUNT(*) FROM Mensagem WHERE Mensagem.idConversa = Conversa.idConversa)
       AS numeromensagens,
       AutorMensagem.username AS nomeautor,
       Mensagem1.idAutor,
       Mensagem1.descricao,
       Mensagem1.dataHora
  FROM Conversa
  JOIN Utilizador ON Utilizador.idUtilizador = (CASE WHEN :idUtilizador = idUtilizador1
  THEN idUtilizador2 ELSE idUtilizador1 END)
  JOIN Mensagem Mensagem1 ON Mensagem1.idConversa = Conversa.idConversa
  LEFT OUTER JOIN Mensagem Mensagem2 ON (Mensagem2.idConversa = Conversa.idConversa
  AND Mensagem1.dataHora < Mensagem2.dataHora OR Mensagem1.dataHora = Mensagem2.dataHora
  AND Mensagem1.idMensagem < Mensagem2.idMensagem)
  JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem1.idAutor
  JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
  WHERE (idUtilizador1 = :idUtilizador OR idUtilizador2 = :idUtilizador)
  AND Mensagem2.idMensagem IS NULL;

/*--------------------------------------------*/
/* LISTAR MENSAGENS DE UMA CONVERSA           */
/*--------------------------------------------*/

SELECT Mensagem.idMensagem,
       Mensagem.descricao,
       Mensagem.dataHora,
       Conversa.titulo,
       Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeautor,
       Instituicao.sigla
  FROM Mensagem
  NATURAL JOIN Conversa
  JOIN Utilizador ON Utilizador.idUtilizador = Mensagem.idAutor
  NATURAL JOIN Instituicao
  WHERE Mensagem.idConversa = :idConversa;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES COM MAIS PERGUNTAS     */
/*--------------------------------------------*/

SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(Pergunta.idPergunta) AS ultimaPergunta,
       MAX(Pergunta.dataHora) AS dataHora,
       COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
  FROM Pergunta
  LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
  GROUP BY Utilizador.idUtilizador
  ORDER BY numeroPerguntas DESC, dataHora DESC;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES COM MAIS RESPOSTAS     */
/*--------------------------------------------*/

SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       MAX(Contribuicao.idContribuicao) AS ultimaResposta,
       MAX(Contribuicao.dataHora) AS dataHora,
       COALESCE(COUNT(Resposta.idResposta), 0) AS numeroRespostas
  FROM Resposta
  LEFT JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
  LEFT JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
  GROUP BY Utilizador.idUtilizador
  ORDER BY numeroRespostas DESC, dataHora DESC;

/*--------------------------------------------*/
/* LISTAR CATEGORIAS COM MAIS RESPOSTAS       */
/*--------------------------------------------*/

SELECT Categoria.idCategoria,
       Categoria.nome,
       Pergunta.idPergunta,
       MAX(Pergunta.dataHora),
       COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
 FROM Categoria
 NATURAL JOIN Pergunta
 GROUP BY Categoria.idCategoria, Pergunta.idPergunta
 ORDER BY numeroPerguntas DESC, Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* LISTAR INSTITUIÇÕES COM MAIS RESPOSTAS     */
/*--------------------------------------------*/

SELECT Instituicao.idInstituicao,
       Instituicao.sigla,
       MAX(Pergunta.idPergunta) AS ultimaPergunta,
       MAX(Pergunta.dataHora) AS dataHora,
       COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
 FROM CategoriaInstituicao
 NATURAL JOIN Pergunta
 NATURAL JOIN Instituicao
 GROUP BY Instituicao.idInstituicao
 ORDER BY numeroPerguntas DESC, dataHora DESC;