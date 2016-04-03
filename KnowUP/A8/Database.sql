/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

INSERT INTO Categoria VALUES (1, 'Bioengenharia');
INSERT INTO Categoria VALUES (2, 'Engenharia Ambiente');
INSERT INTO Categoria VALUES (3, 'Engenharia Civil');
INSERT INTO Categoria VALUES (4, 'Engenharia Eletrotécnica');
INSERT INTO Categoria VALUES (5, 'Engenharia Informática');
INSERT INTO Categoria VALUES (6, 'Engenharia Industrial e Gestão');
INSERT INTO Categoria VALUES (7, 'Engenharia Mecânica');
INSERT INTO Categoria VALUES (8, 'Engenharia Metalúrgica');
INSERT INTO Categoria VALUES (9, 'Engenharia Química');
INSERT INTO Categoria VALUES (10, 'Criminologia');
INSERT INTO Categoria VALUES (11, 'Direito');
INSERT INTO Categoria VALUES (12, 'Ciências Forenses');

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

INSERT INTO Instituicao
VALUES (1, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (2, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (3, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (4, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (5, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (6, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (7, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (8, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Prof. Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt/web_page.inicial');

INSERT INTO Instituicao
VALUES (9, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt/web_page.inicial');

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

INSERT INTO CategoriaInstituicao VALUES (7, 5);
INSERT INTO CategoriaInstituicao VALUES (8, 5);
INSERT INTO CategoriaInstituicao VALUES (9, 5);
INSERT INTO CategoriaInstituicao VALUES (6, 5);
INSERT INTO CategoriaInstituicao VALUES (5, 5);
INSERT INTO CategoriaInstituicao VALUES (4, 5);
INSERT INTO CategoriaInstituicao VALUES (3, 5);
INSERT INTO CategoriaInstituicao VALUES (2, 5);
INSERT INTO CategoriaInstituicao VALUES (1, 5);
INSERT INTO CategoriaInstituicao VALUES (10, 3);
INSERT INTO CategoriaInstituicao VALUES (11, 3);
INSERT INTO CategoriaInstituicao VALUES (12, 3);
INSERT INTO CategoriaInstituicao VALUES (12, 6);

/*--------------------------------------------*/
/*                 Utilizador                 */
/*--------------------------------------------*/

INSERT INTO Utilizador
VALUES (1, NULL, 'admin', 'seguranca101', 'contact@knowup.pt', 'Administrador', 'NULL', 'Porto', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (2, 5, 'marques999', '14191091', 'up201305642@fe.up.pt', 'Diogo', 'Marques', 'Valongo', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (6, 5, 'mellus', 'abcdefg', 'up201305618@fe.up.pt', 'Pedro', 'Melo', 'Penafiel', 'pt', true, '2016-04-02 12:30:04.255597');

INSERT INTO Utilizador
VALUES (4, 5, 'darklord', 'naosei', 'tambemnaosei@gmail.com', 'Vitor', 'Esteves', 'Mirandela', 'pt', true, '2016-04-02 12:30:04.255597');

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

INSERT INTO Administrador VALUES(1, 1);

/*--------------------------------------------*/
/*                 Moderador                  */
/*--------------------------------------------*/

INSERT INTO Moderador VALUES(1, 1);
INSERT INTO Moderador VALUES(2, 2);

/*--------------------------------------------*/
/*                  Pergunta                  */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                Contribuição                */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                  Resposta                  */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                  Seguidor                  */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*             ComentarioPergunta             */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*             ComentarioResposta             */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                VotoPergunta                */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                VotoResposta                */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                 Notificação                */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                  Mensagem                  */
/*--------------------------------------------*/