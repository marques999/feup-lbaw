DROP VIEW IF EXISTS knowUP.CategoriasPorInstituicao;
CREATE VIEW knowUP.CategoriasPorInstituicao AS
	SELECT Instituicao.sigla, Categoria.idCategoria, Categoria.nome
	FROM knowup.Instituicao
	JOIN knowup.CategoriaInstituicao USING (idInstituicao)
	JOIN knowup.Categoria USING (idCategoria)
	ORDER BY Instituicao.sigla, Categoria.nome;

DROP VIEW IF EXISTS knowUP.MembrosInstituicao;
CREATE OR REPLACE VIEW knowUP.MembrosInstituicao AS
	SELECT Instituicao.idInstituicao,
		Instituicao.nome,
		Instituicao.sigla,
		Instituicao.morada,
		Instituicao.contacto,
		Instituicao.website,
		COALESCE(count(Utilizador.idUtilizador), 0) AS count
	FROM knowUP.Instituicao
	LEFT JOIN knowUP.Utilizador USING(idInstituicao)
	GROUP BY Instituicao.idInstituicao;