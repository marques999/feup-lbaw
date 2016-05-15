/*-----------------------------------------------*/
/* SQL101: VERIFICAR PERMISSÕES DE ADMINISTRADOR */
/*-----------------------------------------------*/
SELECT * FROM Administrador WHERE idAdministrador = :idUtilizador;

/*-----------------------------------------------*/
/* SQL102: VERIFICAR PERMISSÕES DE MODERADOR     */
/*-----------------------------------------------*/
SELECT * FROM Moderador WHERE idModerador = :idUtilizador;

/*--------------------------------------------*/
/* SQL103: OBTER INFORMAÇÕES DO UTILIZADOR    */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome,
       Utilizador.ultimoNome,
       Utilizador.primeiroNome || ' '  || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Instituicao.idInstituicao,
       Instituicao.sigla,
       Instituicao.website,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.dataRegisto,
       Utilizador.ultimaSessao,
       Utilizador.ativo,
       Utilizador.removido
FROM Utilizador
LEFT JOIN Instituicao USING(idInstituicao)
WHERE idUtilizador = :idUtilizador
GROUP BY idUtilizador, Instituicao.idInstituicao;

/*--------------------------------------------*/
/* SQL104: LISTAR REPORTS POR MODERADOR       */
/*--------------------------------------------*/
SELECT Report.idReport,
       Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Report.descricao,
       Report.dataHora
FROM Report
NATURAL JOIN Utilizador
WHERE Report.idModerador = :idModerador;

/*--------------------------------------------*/
/* SQL105: DENUNCIAR UTILIZADOR               */
/*--------------------------------------------*/
INSERT INTO Report(idReport, idModerador, idUtilizador, descricao)
VALUES(DEFAULT, :idModerador, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* SQL106: REGISTAR UTILIZADOR                */
/*--------------------------------------------*/
INSERT INTO Utilizador(idUtilizador, idInstituicao, username, password, email, primeiroNome, ultimoNome)
VALUES(DEFAULT, :idInstituicao, :username, :password, :email, :primeiroNome, :ultimoNome);

/*--------------------------------------------*/
/* SQL107: EDITAR PERFIL                      */
/*--------------------------------------------*/
UPDATE Utilizador
SET idInstituicao = :idInstituicao,
    email = :email,
    primeiroNome = :primeiroNome,
    ultimoNome = :ultimoNome,
    localidade = :localidade,
    codigoPais = :codigoPais
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL108: ALTERAR PASSWORD                   */
/*--------------------------------------------*/
UPDATE Utilizador
SET password = :password
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL109: BANIR UTILIZADOR                   */
/*--------------------------------------------*/
UPDATE Utilizador
SET ativo = FALSE
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL110: APAGAR UTILIZADOR                  */
/*--------------------------------------------*/
UPDATE Utilizador
SET removido = TRUE
WHERE idUtilizador = :idUtilizador;