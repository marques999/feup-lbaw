/*--------------------------------------------*/
/* SQL701: LISTAR CONVERSAS                   */
/*--------------------------------------------*/
SELECT Conversa.idConversa,
       Conversa.titulo,
       (CASE WHEN :idUtilizador = idUtilizador1 THEN ultimoAcesso1 ELSE ultimoAcesso2 END) AS ultimoAcesso,
       Utilizador.idUtilizador AS idDestinatario,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeDestinatario,
       Instituicao.sigla,
       (SELECT COUNT(*) FROM Mensagem WHERE Mensagem.idConversa = Conversa.idConversa) AS numeroMensagens,
       Mensagem1.idAutor AS idAutor,
       AutorMensagem.username AS nomeAutor,
       AutorMensagem.removido,
       Mensagem1.descricao,
       Mensagem1.dataHora
FROM Conversa
JOIN Utilizador
  ON Utilizador.idUtilizador = (CASE WHEN :idUtilizador = idUtilizador1
  THEN idUtilizador2 ELSE idUtilizador1 END)
JOIN Mensagem Mensagem1 ON Mensagem1.idConversa = Conversa.idConversa
LEFT OUTER JOIN Mensagem Mensagem2
  ON (Mensagem2.idConversa = Conversa.idConversa
  AND Mensagem1.dataHora < Mensagem2.dataHora
  OR Mensagem1.dataHora = Mensagem2.dataHora
  AND Mensagem1.idMensagem < Mensagem2.idMensagem)
JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem1.idAutor
JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
WHERE (idUtilizador1 = :idUtilizador
  OR idUtilizador2 = :idUtilizador)
  AND Mensagem2.idMensagem IS NULL
ORDER BY Mensagem1.dataHora DESC;

/*--------------------------------------------*/
/* SQL702: OBTER INFORMAÇÕES DA CONVERSA      */
/*--------------------------------------------*/
SELECT Conversa.*,
       Utilizador1.removido AS remetenteRemovido,
       Utilizador2.removido AS destinatarioRemovido
FROM Conversa
INNER JOIN Utilizador Utilizador1 ON Utilizador1.idUtilizador = Conversa.idUtilizador1
INNER JOIN Utilizador Utilizador2 ON Utilizador2.idUtilizador = Conversa.idUtilizador2
WHERE idConversa = :idConversa;

/*--------------------------------------------*/
/* SQL703: OBTER MENSAGENS DA CONVERSA        */
/*--------------------------------------------*/
SELECT Mensagem.idMensagem,
       Mensagem.descricao,
       Mensagem.dataHora,
       Instituicao.sigla,
       Utilizador.idUtilizador,
       Utilizador.removido,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador
FROM Mensagem
INNER JOIN Utilizador ON Utilizador.idUtilizador = Mensagem.idAutor
LEFT JOIN Instituicao USING (idInstituicao)
WHERE idConversa = :idConversa;

/*--------------------------------------------*/
/* SQL704: CRIAR CONVERSA                     */
/*--------------------------------------------*/
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
WITH NovaConversa AS (
  INSERT INTO Conversa(idConversa, idUtilizador1, idUtilizador2, titulo)
  VALUES(DEFAULT, :idRemetente, :idDestinatario, :titulo) RETURNING idConversa
) INSERT INTO Mensagem(idConversa, idAutor, descricao)
  SELECT idConversa, :idRemetente, :descricao
  FROM NovaConversa;
COMMIT;

/*--------------------------------------------*/
/* SQL705: ENVIAR MENSAGEM                    */
/*--------------------------------------------*/
INSERT INTO Mensagem(idMensagem, idConversa, idAutor, descricao)
VALUES(DEFAULT, :idConversa, :idRemetente, :descricao);

/*--------------------------------------------*/
/* SQL706: APAGAR CONVERSA                    */
/*--------------------------------------------*/
DELETE FROM Conversa
WHERE idConversa = :idConversa
AND idUtilizador1 = :idUtilizador;

/*--------------------------------------------*/
/* SQL707: VERIFICAR AUTOR                    */
/*--------------------------------------------*/
SELECT idConversa FROM Conversa
WHERE idConversa = :idConversa
AND idUtilizador1 = :idUtilizador;