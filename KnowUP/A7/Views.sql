DROP VIEW IF EXISTS knowUP.CategoriasPorInstituicao;
CREATE VIEW knowUP.CategoriasPorInstituicao AS
	SELECT  Instituicao.sigla,
			Categoria.idCategoria,
			Categoria.nome
	FROM knowup.Instituicao
	JOIN knowup.CategoriaInstituicao USING (idInstituicao)
	JOIN knowup.Categoria USING (idCategoria)
	ORDER BY Instituicao.sigla, Categoria.nome;

DROP VIEW IF EXISTS knowUP.VistaInstituicao;
CREATE OR REPLACE VIEW knowUP.MembrosInstituicao AS
	SELECT Instituicao.idInstituicao,
		   Instituicao.nome,
	       Instituicao.sigla,
		   Instituicao.morada,
		   Instituicao.contacto,
		   Instituicao.website,
		   COALESCE(count(Utilizador.idUtilizador), 0) AS numeroUtilizadores,
		   COALESCE(count(Pergunta.idPergunta), 0) AS numeroPerguntas,
		   COALESCE(sum(Pergunta.visualizacoes), 0) AS numeroVisualizacoes
	FROM knowUP.Instituicao
	LEFT JOIN knowUP.Utilizador USING(idInstituicao),
	LEFT JOIN knowUP.CategoriaInstituicao USING (idInstituicao),
	LEFT JOIN knowUP.Pergunta USING (idCategoria),
	GROUP BY Instituicao.idInstituicao;

/*--------------------------------------------*/
/* 1. LISTAS DE PERGUNTAS POR CATEGORIA      */
/*--------------------------------------------*/
DROP VIEW IF EXISTS knowUP.PerguntasPorCategoria;
CREATE VIEW knowUP.PerguntasPorCategoria AS
SELECT Perguntas.idCategoria, Perguntas.texto, Categorias.nome
   FROM knowUP.Perguntas
   JOIN knowUP.Categorias ON Perguntas.idCategoria = Categorias.idCategoria
   ORDER BY Perguntas.idCategoria;

/*--------------------------------------------*/
/* 1. LISTAS DE RESPOSTAS A UMA PERGUNTA      */
/*--------------------------------------------*/
DROP VIEW IF EXISTS knowUP.NumeroRespostas;
CREATE VIEW knowUP.NumeroRespostas AS
SELECT Pergunta.idPergunta, Utilizadores.username, Respostas.titulo, Respostas.descricao
	FROM knowUP.Respostas, knowUP.Perguntas, knowUP.Utilizadores
	WHERE Perguntas.idPergunta = resposta.idPergunta
	AND Respostas.idAutor = Utilizadores.idUtilizador
	ORDER BY Perguntas.timestamp;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MAIS POPULARES          */
/*--------------------------------------------*/
DROP VIEW IF EXISTS knowUP.PerguntasPopulares;
CREATE VIEW knowUP.PerguntasPopulares AS
SELECT Perguntas.idPergunta, Perguntas.titulo, Perguntas.descricao, (contribuicao.votospositivos + contribuicao.votosnegativos) as pontuacao
	FROM knowUP.Perguntas, knowUP.Utilizadores
	WHERE pergunta.perguntaid = contribuicao.contribuicaoid
	ORDER BY contribuicao.votospositivos + contribuicao.votosnegativos DESC;

DROP VIEW IF EXISTS knowUP.RespostasMembro;
CREATE VIEW knowUP.RespostasMembro AS
SELECT Resposta.descricao, Resposta.dataHora, Resposta.melhorResposta
   FROM knowUP.Utilizador
   JOIN knowUP.Resposta ON Utilizadores.idUtilizador = Respostas.idAutor
   WHERE Utilizadores.idUtilizador = :idUtilizador;

DROP VIEW IF EXISTS PerguntasMembro;
CREATE VIEW PerguntasMembro AS
SELECT Pergunta.titulo, Pergunta.descricao, Pergunta.dataHora
	FROM Utilizador
	JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
	WHERE Utilizador.idUtilizador = :idUtilizador;


/*--------------------------------------------
/* LISTA DAS PERGUNTAS MAIS VISTAS
/*--------------------------------------------*/
DROP VIEW IF EXISTS knowUP.PerguntasMaisVistas;
CREATE VIEW knowUP.PerguntasMaisVistas AS
SELECT Perguntas.idPergunta, Perguntas.titulo, Perguntas.descricao, Perguntas.visualizacoes
	FROM knowUP.Perguntas
	ORDER BY Perguntas.visualizacoes;