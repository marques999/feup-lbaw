/*--------------------------------------------*/
/* CRIAR CONVERSA                             */
/*--------------------------------------------*/
INSERT INTO Conversa(idConversa, idUtilizador1, idUtilizador2, titulo)
VALUES(DEFAULT, :idRemetente, :idDestinatario, :titulo);

/*--------------------------------------------*/
/* APAGAR CONVERSA                            */
/*--------------------------------------------*/
DELETE FROM Conversa
WHERE idConversa = :idConversa
AND idUtilizador1 = :idUtilizador;

/*--------------------------------------------*/
/* LISTAR CONVERSAS DO UTILIZAODR             */
/*--------------------------------------------*/
SELECT * FROM Conversa
WHERE idUtilizador1 = :idUtilizador
OR idUtilizador2 = :idUtilizador;

/*--------------------------------------------*/
/* OBTER INFORMAÇÕES DA CONVERSA                */
/*--------------------------------------------*/
SELECT Conversa.*,
       Utilizador1.removido AS remetenteRemovido,
       Utilizador2.removido AS destinatarioRemovido
FROM Conversa
INNER JOIN Utilizador Utilizador1 ON Utilizador1.idUtilizador = Conversa.idUtilizador1
INNER JOIN Utilizador Utilizador2 ON Utilizador2.idUtilizador = Conversa.idUtilizador2
WHERE idConversa = :idConversa;

/*--------------------------------------------*/
/* OBTER MENSAGENS DA CONVERSA                */
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
/* ENVIAR MENSAGEM                            */
/*--------------------------------------------*/
INSERT INTO Mensagem(idMensagem, idConversa, idAutor, descricao)
VALUES(DEFAULT, :idConversa, :idRemetente, :descricao);