
DROP VIEW IF EXISTS VistaInstituicao;
CREATE OR REPLACE VIEW VistaInstituicao AS
	SELECT Instituicao.idInstituicao,
		   Instituicao.nome,
	       Instituicao.sigla,
		   Instituicao.morada,
		   Instituicao.contacto,
		   Instituicao.website,
		   COALESCE(count(Utilizador.idUtilizador), 0) AS numeroUtilizadores,
		   COALESCE(count(Pergunta.idPergunta), 0) AS numeroPerguntas,
		   COALESCE(sum(Pergunta.visualizacoes), 0) AS numeroVisualizacoes
	FROM Instituicao
	LEFT JOIN Utilizador USING(idInstituicao),
	LEFT JOIN CategoriaInstituicao USING (idInstituicao),
	LEFT JOIN Pergunta USING (idCategoria),
	GROUP BY Instituicao.idInstituicao;

/*--------------------------------------------*/
/* 1. LISTA DE CATEGORIAS DE UMA INSTITUIÇÂO  */
/*--------------------------------------------*/

SELECT Categoria.idCategoria, Categoria.nome
	FROM Instituicao
	JOIN CategoriaInstituicao USING (idInstituicao)
	JOIN Categoria USING (idCategoria)
	WHERE Instituicao.idInstituicao = :idInstituicao
	ORDER BY Categoria.nome ASC;

/*--------------------------------------------*/
/* 2. LISTA DE INSTITUIÇÕES DE UMA CATEGORIA  */
/*--------------------------------------------*/

SELECT Instituicao.idInstituicao, Instituicao.sigla
	FROM Categoria
	JOIN CategoriaInstituicao USING(idCategoria)
	JOIN Instituicao USING (idInstituicao)
	WHERE Categoria.idCategoria = :idCategoria
	ORDER BY Instituicao.sigla ASC;

/* */
/* LISTAR PERGUNTA */
/**/

SELECT * FROM (SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.username,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
	Pergunta.titulo,
	Pergunta.descricao,
	Pergunta.visualizacoes,
	Pergunta.dataHora,
	numeroComentariosPergunta(Pergunta.idPergunta) AS numeroComentarios
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
WHERE Pergunta.idPergunta = :idPergunta) AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta);

-- FALTAM SEGUIDORES EM TODAS!

/*--------------------------------------------*/
/* 1. LISTAS DE RESPOSTAS A UMA PERGUNTA      */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
	Utilizador.idUtilizador,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
	Utilizador.username,
	Instituicao.sigla,
	Contribuicao.descricao,
	Contribuicao.dataHora,
	numeroComentariosResposta(Resposta.idResposta) AS numeroComentarios,
	FROM Pergunta
	JOIN Resposta USING(idPergunta)
	JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
	JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
	JOIN Instituicao USING(idInstituicao)
	WHERE Pergunta.idPergunta = :idPergunta
	ORDER BY Contribuicao.dataHora;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MAIS POPULARES         */
/*--------------------------------------------*/

DROP VIEW IF EXISTS PerguntasMelhorClassificadas;

CREATE VIEW PerguntasMelhorClassificadas AS
SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
	Pergunta.titulo,
	Pergunta.descricao,
	calcularPontuacaoPergunta(Pergunta.idPergunta) AS pontuacao,
	Pergunta.dataHora
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
ORDER BY pontuacao DESC;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MAIS VISTAS            */
/*--------------------------------------------*/

DROP VIEW IF EXISTS PerguntasMaisVistas;

CREATE VIEW PerguntasMaisVistas AS
SELECT * FROM (SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
	Pergunta.titulo,
	Pergunta.descricao,
	Pergunta.visualizacoes,
	Pergunta.dataHora
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
ORDER BY Pergunta.visualizacoes DESC) AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta);

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR CATEGORIA        */
/*--------------------------------------------*/

SELECT * FROM (SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
	Utilizador.username,
	Pergunta.titulo,
	Pergunta.descricao,
	Pergunta.dataHora
    FROM Pergunta
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
  	WHERE Pergunta.idCategoria = :idCategoria
  	ORDER BY Pergunta.dataHora DESC) AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta);

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR INSTITUICAO      */
/*--------------------------------------------*/

SELECT * FROM (SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome,
	Utilizador.username,
	Pergunta.titulo,
	Pergunta.descricao,
	Pergunta.dataHora
    FROM InstituicaoCategoria
    JOIN Pergunta USING(InstituicaoCategoria.idCategoria)
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    WHERE InstituicaoCategoria.idInstituicao = :idInstituicao
    ORDER BY Pergunta.dataHora DESC) AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta);

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT * FROM (SELECT Pergunta.idPergunta,
		Pergunta.titulo,
		Pergunta.descricao,
		Pergunta.dataHora
	FROM Utilizador
	JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
	WHERE Utilizador.idUtilizador = :idUtilizador) AS QueryPrincipal, calcularPontuacaoPergunta(QueryPrincipal.idPergunta);

/*--------------------------------------------*/
/* 1. LISTA DE RESPOSTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT * FROM (SELECT Resposta.idResposta,
		Resposta.idPergunta,
		Contribuicao.descricao,
		Contribuicao.dataHora,
		Resposta.melhorResposta
  	FROM Utilizador
  	JOIN Contribuicao ON Contribuicao.idAutor = Utilizador.idUtilizador
  	JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
  	WHERE Utilizador.idUtilizador = :idUtilizador) AS QueryPrincipal, calcularPontuacaoResposta(QueryPrincipal.idResposta);