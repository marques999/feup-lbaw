
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
	ORDER BY Categoria.nome ASC;;

/*--------------------------------------------*/
/* 2. LISTA DE INSTITUIÇÕES DE UMA CATEGORIA  */
/*--------------------------------------------*/

SELECT Instituicao.idInstituicao, Instituicao.sigla
	FROM Categoria
	JOIN CategoriaInstituicao USING(idCategoria)
	JOIN Instituicao USING (idInstituicao)
	WHERE Categoria.idCategoria = :idCategoria
	ORDER BY Instituicao.sigla ASC;

/*--------------------------------------------*/
/* 1. LISTAS DE RESPOSTAS A UMA PERGUNTA      */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
	Utilizador.idUtilizador,
	Utilizador.username,
	Contribuicao.descricao,
	Contribuicao.dataHora
	FROM Utilizador
	JOIN Resposta.idPergunta = Pergunta.idPergunta
	AND Respostas.idAutor = Utilizadores.idUtilizador
	WHERE Utilizador.idUtilizador = Contribuicao.idAutor;
	ORDER BY Perguntas.timestamp;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MAIS POPULARES         */
/*--------------------------------------------*/

DROP VIEW IF EXISTS PerguntasMelhorClassificadas;

CREATE VIEW PerguntasMelhorClassificadas AS
SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.username,
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
SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.username,
	Pergunta.titulo,
	Pergunta.descricao,
	calcularPontuacaoPergunta(Pergunta.idPergunta) AS pontuacao,
	Pergunta.visualizacoes,
	Pergunta.dataHora
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
ORDER BY Pergunta.visualizacoes DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR CATEGORIA        */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.username,
	Pergunta.titulo,
	Pergunta.descricao,
	calcularPontuacaoPergunta(Pergunta.idPergunta) AS pontuacao,
	Pergunta.dataHora
    FROM Pergunta
  	WHERE Pergunta.idCategoria = :idCategoria
  	ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR INSTITUICAO      */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
	Utilizador.idUtilizador,
	Utilizador.username,
	Pergunta.titulo,
	Pergunta.descricao,
	calcularPontuacaoPergunta(Pergunta.idPergunta) AS pontuacao,
	Pergunta.dataHora
    FROM Pergunta
    JOIN Instituicao ON Instituicao.idCategoria = Pergunta.idCategoria
    WHERE Instituicao.idInstituicao = :idInstituicao
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT Pergunta.titulo, Pergunta.descricao, Pergunta.dataHora
	FROM Utilizador
	JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
	WHERE Utilizador.idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 1. LISTA DE RESPOSTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT Resposta.descricao, Resposta.dataHora, Resposta.melhorResposta
   FROM knowUP.Utilizador
   JOIN knowUP.Resposta ON Utilizadores.idUtilizador = Respostas.idAutor
   WHERE Utilizadores.idUtilizador = :idUtilizador;