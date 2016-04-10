SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*                  DeleteAll                 */
/*--------------------------------------------*/

DELETE FROM Report;
DELETE FROM Mensagem;
DELETE FROM Notificacao;
DELETE FROM Seguidor;
DELETE FROM VotoResposta;
DELETE FROM VotoPergunta;
DELETE FROM ComentarioResposta;
DELETE FROM ComentarioPergunta;
DELETE FROM Resposta;
DELETE FROM Contribuicao;
DELETE FROM Pergunta;
DELETE FROM Moderador;
DELETE FROM Administrador;
DELETE FROM Utilizador;
DELETE FROM CategoriaInstituicao;
DELETE FROM Instituicao;
DELETE FROM Categoria;

/*--------------------------------------------*/
/*                  Categoria                 */
/*--------------------------------------------*/

INSERT INTO Categoria VALUES (1, 'Bioengenharia');
INSERT INTO Categoria VALUES (2, 'Engenharia Ambiente');
INSERT INTO Categoria VALUES (3, 'Engenharia Civil');
INSERT INTO Categoria VALUES (4, 'Engenharia Electrotécnica');
INSERT INTO Categoria VALUES (5, 'Engenharia Informática');
INSERT INTO Categoria VALUES (6, 'Engenharia Industrial');
INSERT INTO Categoria VALUES (7, 'Engenharia Mecânica');
INSERT INTO Categoria VALUES (8, 'Engenharia Metalúrgica');
INSERT INTO Categoria VALUES (9, 'Engenharia Química');
INSERT INTO Categoria VALUES (10, 'Criminologia');
INSERT INTO Categoria VALUES (11, 'Direito');
INSERT INTO Categoria VALUES (12, 'Ciências Forenses');
INSERT INTO Categoria VALUES (13, 'Anatomia');
INSERT INTO Categoria VALUES (14, 'Imunologia');
INSERT INTO Categoria VALUES (15, 'Genética');
INSERT INTO Categoria VALUES (16, 'Psicologia');
INSERT INTO Categoria VALUES (17, 'Medicina Dentária');
INSERT INTO Categoria VALUES (18, 'Medicina Veterinária');
INSERT INTO Categoria VALUES (19, 'Biologia Molecular');
INSERT INTO Categoria VALUES (20, 'Bioquímica');
INSERT INTO Categoria VALUES (21, 'Farmacologia');
INSERT INTO Categoria VALUES (22, 'Atletismo');
INSERT INTO Categoria VALUES (23, 'Basquetebol');
INSERT INTO Categoria VALUES (24, 'Futebol');
INSERT INTO Categoria VALUES (25, 'Gestão Desportiva');
INSERT INTO Categoria VALUES (26, 'Ginástica');
INSERT INTO Categoria VALUES (27, 'Ténis');
INSERT INTO Categoria VALUES (28, 'Agronomia');
INSERT INTO Categoria VALUES (29, 'Astronomia');
INSERT INTO Categoria VALUES (30, 'Física');
INSERT INTO Categoria VALUES (31, 'Geologia');
INSERT INTO Categoria VALUES (32, 'Matemática');
INSERT INTO Categoria VALUES (33, 'Química');
INSERT INTO Categoria VALUES (34, 'Contabilidade');
INSERT INTO Categoria VALUES (35, 'Economia');
INSERT INTO Categoria VALUES (36, 'Finanças');
INSERT INTO Categoria VALUES (37, 'Gestão');
INSERT INTO Categoria VALUES (38, 'Cinema');
INSERT INTO Categoria VALUES (39, 'Design');
INSERT INTO Categoria VALUES (40, 'Escultura');
INSERT INTO Categoria VALUES (41, 'Fotografia');
INSERT INTO Categoria VALUES (42, 'Pintura');
INSERT INTO Categoria VALUES (43, 'Arqueologia');
INSERT INTO Categoria VALUES (44, 'Filosofia');
INSERT INTO Categoria VALUES (45, 'Geografia');
INSERT INTO Categoria VALUES (46, 'História');
INSERT INTO Categoria VALUES (47, 'Inglês');
INSERT INTO Categoria VALUES (48, 'Jornalismo');
INSERT INTO Categoria VALUES (49, 'Linguística');
INSERT INTO Categoria VALUES (50, 'Multimédia');
INSERT INTO Categoria VALUES (51, 'Português');
INSERT INTO Categoria VALUES (52, 'Sociologia');
INSERT INTO Categoria VALUES (53, 'Arquitectura');
INSERT INTO Categoria VALUES (54, 'Arquitectura Paisagista');
INSERT INTO Categoria VALUES (55, 'Património');
INSERT INTO Categoria VALUES (56, 'Nutrição');

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

INSERT INTO Instituicao
VALUES (1, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt');

INSERT INTO Instituicao
VALUES (2, 'Faculdade de Arquitectura da Universidade do Porto', 'faup', 'Via Panorâmica Edgar Cardoso s/n, 4150-755 PORTO', '22 605 7100', 'https://sigarra.up.pt/faup/pt');

INSERT INTO Instituicao
VALUES (3, 'Faculdade de Belas Artes da Universidade do Porto', 'fbaup', 'Avenida Rodrigues de Freitas 265, 4049-021 PORTO', '22 519 2400', 'https://sigarra.up.pt/fbaup/pt');

INSERT INTO Instituicao
VALUES (4, 'Faculdade de Ciências da Nutrição e da Alimentação da Universidade do Porto', 'fcnaup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 507 4320', 'https://sigarra.up.pt/fcnaup/pt');

INSERT INTO Instituicao
VALUES (5, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt');

INSERT INTO Instituicao
VALUES (6, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt');

INSERT INTO Instituicao
VALUES (7, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt');

INSERT INTO Instituicao
VALUES (8, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt');

INSERT INTO Instituicao
VALUES (9, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt');

INSERT INTO Instituicao
VALUES (10, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt');

INSERT INTO Instituicao
VALUES (11, 'Faculdade de Medicina Dentária da Universidade do Porto', 'fmdup', 'Rua Dr. Manuel Pereira da Silva s/n, 4200-393 PORTO', '22 090 1100', 'https://sigarra.up.pt/fmdup/pt');

INSERT INTO Instituicao
VALUES (12, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Prof. Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt');

INSERT INTO Instituicao
VALUES (13, 'Faculdade de Psicologia e de Ciências da Educação da Universidade do Porto', 'fpceup', 'Rua Alfredo Allen 525, 4200-135 PORTO', '22 607 9700', 'https://sigarra.up.pt/fpceup/pt');

INSERT INTO Instituicao
VALUES (14, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt');

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

INSERT INTO CategoriaInstituicao VALUES (1, 13); /* Anatomia */
INSERT INTO CategoriaInstituicao VALUES (1, 22); /* Atletismo */
INSERT INTO CategoriaInstituicao VALUES (1, 23); /* Basquetebol */
INSERT INTO CategoriaInstituicao VALUES (1, 24); /* Futebol */
INSERT INTO CategoriaInstituicao VALUES (1, 25); /* Gestão Desportiva */
INSERT INTO CategoriaInstituicao VALUES (1, 26); /* Ginástica */
INSERT INTO CategoriaInstituicao VALUES (1, 27); /* Ténis */
INSERT INTO CategoriaInstituicao VALUES (1, 56); /* Nutrição */

INSERT INTO CategoriaInstituicao VALUES (2, 53); /* Arquitectura */
INSERT INTO CategoriaInstituicao VALUES (2, 54); /* Arquitectura Paisagista */
INSERT INTO CategoriaInstituicao VALUES (2, 55); /* Património */

INSERT INTO CategoriaInstituicao VALUES (3, 38); /* Cinema */
INSERT INTO CategoriaInstituicao VALUES (3, 39); /* Design */
INSERT INTO CategoriaInstituicao VALUES (3, 40); /* Escultura */
INSERT INTO CategoriaInstituicao VALUES (3, 41); /* Fotografia */
INSERT INTO CategoriaInstituicao VALUES (3, 42); /* Pintura */
INSERT INTO CategoriaInstituicao VALUES (3, 48); /* Jornalismo */
INSERT INTO CategoriaInstituicao VALUES (3, 50); /* Multimédia */

INSERT INTO CategoriaInstituicao VALUES (4, 56); /* Nutrição */

INSERT INTO CategoriaInstituicao VALUES (5, 2); /* Engenharia Ambiente */
INSERT INTO CategoriaInstituicao VALUES (5, 5); /* Engenharia Informática */
INSERT INTO CategoriaInstituicao VALUES (5, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (5, 15); /* Genética */
INSERT INTO CategoriaInstituicao VALUES (5, 19); /* Biologia Molecular */
INSERT INTO CategoriaInstituicao VALUES (5, 28); /* Agronomia */
INSERT INTO CategoriaInstituicao VALUES (5, 29); /* Astronomia */
INSERT INTO CategoriaInstituicao VALUES (5, 30); /* Física */
INSERT INTO CategoriaInstituicao VALUES (5, 31); /* Geologia */
INSERT INTO CategoriaInstituicao VALUES (5, 32); /* Matemática */
INSERT INTO CategoriaInstituicao VALUES (5, 33); /* Química */
INSERT INTO CategoriaInstituicao VALUES (5, 45); /* Geografia */
INSERT INTO CategoriaInstituicao VALUES (5, 50); /* Multimédia */
INSERT INTO CategoriaInstituicao VALUES (5, 54); /* Arquitectura Paisagista */

INSERT INTO CategoriaInstituicao VALUES (6, 10); /* Criminologia */
INSERT INTO CategoriaInstituicao VALUES (6, 11); /* Direito */

INSERT INTO CategoriaInstituicao VALUES (7, 32); /* Matemática */
INSERT INTO CategoriaInstituicao VALUES (7, 34); /* Contabilidade */
INSERT INTO CategoriaInstituicao VALUES (7, 35); /* Economia */
INSERT INTO CategoriaInstituicao VALUES (7, 36); /* Finanças */
INSERT INTO CategoriaInstituicao VALUES (7, 37); /* Gestão */

INSERT INTO CategoriaInstituicao VALUES (8, 1); /* Bioengenharia */
INSERT INTO CategoriaInstituicao VALUES (8, 2); /* Engenharia Ambiente */
INSERT INTO CategoriaInstituicao VALUES (8, 3); /* Engenharia Civil */
INSERT INTO CategoriaInstituicao VALUES (8, 4); /* Engenharia Electrotécnica */
INSERT INTO CategoriaInstituicao VALUES (8, 5); /* Engenharia Informática */
INSERT INTO CategoriaInstituicao VALUES (8, 6); /* Engenharia Industrial */
INSERT INTO CategoriaInstituicao VALUES (8, 7); /* Engenharia Mecânica */
INSERT INTO CategoriaInstituicao VALUES (8, 8); /* Engenharia Metalúrgica */
INSERT INTO CategoriaInstituicao VALUES (8, 9); /* Engenharia Química */
INSERT INTO CategoriaInstituicao VALUES (8, 30); /* Física */
INSERT INTO CategoriaInstituicao VALUES (8, 32); /* Matemática */
INSERT INTO CategoriaInstituicao VALUES (8, 33); /* Química */
INSERT INTO CategoriaInstituicao VALUES (8, 50); /* Multimédia */

INSERT INTO CategoriaInstituicao VALUES (9, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (9, 14); /* Imunologia */
INSERT INTO CategoriaInstituicao VALUES (9, 19); /* Biologia Molecular */
INSERT INTO CategoriaInstituicao VALUES (9, 20); /* Bioquímica */
INSERT INTO CategoriaInstituicao VALUES (9, 21); /* Farmacologia */

INSERT INTO CategoriaInstituicao VALUES (10, 38); /* Cinema */
INSERT INTO CategoriaInstituicao VALUES (10, 39); /* Design */
INSERT INTO CategoriaInstituicao VALUES (10, 43); /* Arqueologia */
INSERT INTO CategoriaInstituicao VALUES (10, 44); /* Filosofia */
INSERT INTO CategoriaInstituicao VALUES (10, 45); /* Geografia */
INSERT INTO CategoriaInstituicao VALUES (10, 46); /* História */
INSERT INTO CategoriaInstituicao VALUES (10, 47); /* Inglês */
INSERT INTO CategoriaInstituicao VALUES (10, 48); /* Jornalismo */
INSERT INTO CategoriaInstituicao VALUES (10, 49); /* Linguística */
INSERT INTO CategoriaInstituicao VALUES (10, 50); /* Multimédia */
INSERT INTO CategoriaInstituicao VALUES (10, 51); /* Português */
INSERT INTO CategoriaInstituicao VALUES (10, 52); /* Sociologia */
INSERT INTO CategoriaInstituicao VALUES (10, 55); /* Património */

INSERT INTO CategoriaInstituicao VALUES (11, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (11, 13); /* Anatomia */
INSERT INTO CategoriaInstituicao VALUES (11, 17); /* Medicina Dentária */

INSERT INTO CategoriaInstituicao VALUES (12, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (12, 13); /* Anatomia */
INSERT INTO CategoriaInstituicao VALUES (12, 14); /* Imunologia */
INSERT INTO CategoriaInstituicao VALUES (12, 15); /* Genética */
INSERT INTO CategoriaInstituicao VALUES (12, 16); /* Psicologia */
INSERT INTO CategoriaInstituicao VALUES (12, 17); /* Medicina Dentária */
INSERT INTO CategoriaInstituicao VALUES (12, 19); /* Biologia Molecular */
INSERT INTO CategoriaInstituicao VALUES (12, 20); /* Bioquímica */
INSERT INTO CategoriaInstituicao VALUES (12, 21); /* Farmacologia */

INSERT INTO CategoriaInstituicao VALUES (13, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (13, 16); /* Psicologia */
INSERT INTO CategoriaInstituicao VALUES (13, 40); /* Escultura */
INSERT INTO CategoriaInstituicao VALUES (13, 44); /* Filosofia */
INSERT INTO CategoriaInstituicao VALUES (13, 52); /* Sociologia */

INSERT INTO CategoriaInstituicao VALUES (14, 1); /* Bioengenharia */
INSERT INTO CategoriaInstituicao VALUES (14, 12); /* Ciências Forenses */
INSERT INTO CategoriaInstituicao VALUES (14, 13); /* Anatomia */
INSERT INTO CategoriaInstituicao VALUES (14, 14); /* Imunologia */
INSERT INTO CategoriaInstituicao VALUES (14, 15); /* Genética */
INSERT INTO CategoriaInstituicao VALUES (14, 16); /* Psicologia */
INSERT INTO CategoriaInstituicao VALUES (14, 17); /* Medicina Dentária */
INSERT INTO CategoriaInstituicao VALUES (14, 18); /* Medicina Veterinária */
INSERT INTO CategoriaInstituicao VALUES (14, 19); /* Biologia Molecular */
INSERT INTO CategoriaInstituicao VALUES (14, 20); /* Bioquímica */
INSERT INTO CategoriaInstituicao VALUES (14, 21); /* Farmacologia */

/*--------------------------------------------*/
/*                 Utilizador                 */
/*--------------------------------------------*/

INSERT INTO Utilizador
VALUES (1, NULL, 'admin', 'seguranca101', 'contact@knowup.pt', 'Administrador', 'NULL', 'Porto', 'pt', true, '2016-04-02 12:30:04');

INSERT INTO Utilizador
VALUES (2, 8, 'marques999', '14191091', 'up201305642@fe.up.pt', 'Diogo', 'Marques', 'Valongo', 'pt', true, '2016-04-02 12:30:04');

INSERT INTO Utilizador
VALUES (3, 8, 'mellus', 'abcdefg', 'up201305618@fe.up.pt', 'Pedro', 'Melo', 'Penafiel', 'pt', true, '2016-04-02 12:30:04');

INSERT INTO Utilizador
VALUES (4, 8, 'darklord', 'naosei', 'tambemnaosei@gmail.com', 'Vitor', 'Esteves', 'Mirandela', 'pt', true, '2016-04-02 12:30:04');

INSERT INTO Utilizador
VALUES (5, 3, 'picasso', 'xaguarelax', 'pintobem@guernica.es', 'Pablo', 'Picasso', 'Málaga', 'es', true, '2016-04-05 14:40:23');

INSERT INTO Utilizador
VALUES (6, 9, 'penicilina', 'cur4tud0', 'tratamento@eficaz.com', 'Alexander', 'Fleming', 'de', true, '2016-04-05 14:43:49');

INSERT INTO Utilizador
VALUES (7, 7, 'marchista', '18capital67', 'tustaum@karlmail.de', 'Karl', 'Marx', 'de', true, '2016-04-05 14:46:02');

INSERT INTO Utilizador
VALUES (8, 14, 'bolinhas', 'purr9876', 'whiskas_saquetas@neko.jp', 'Gato', 'Preto', 'jp', true, '2016-04-05 14:49:33');

/*--------------------------------------------*/
/*                Administrador               */
/*--------------------------------------------*/

INSERT INTO Administrador VALUES(1);

/*--------------------------------------------*/
/*                 Moderador                  */
/*--------------------------------------------*/

INSERT INTO Moderador VALUES(2);
INSERT INTO Moderador VALUES(3);
INSERT INTO Moderador VALUES(5);

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

INSERT INTO VotoPergunta VALUES(4, 2, 1);
INSERT INTO VotoPergunta VALUES(8, 3, -1);
INSERT INTO VotoPergunta VALUES(3, 4, 1);
INSERT INTO VotoPergunta VALUES(7, 3, -1);
INSERT INTO VotoPergunta VALUES(6, 5, -1);
INSERT INTO VotoPergunta VALUES(1, 2, 1);
INSERT INTO VotoPergunta VALUES(9, 6, 1);
INSERT INTO VotoPergunta VALUES(4, 3, 1);
INSERT INTO VotoPergunta VALUES(7, 7, -1);
INSERT INTO VotoPergunta VALUES(2, 4, 1);
INSERT INTO VotoPergunta VALUES(1, 8, 1);
INSERT INTO VotoPergunta VALUES(5, 3, -1);
INSERT INTO VotoPergunta VALUES(10, 8, 1);
INSERT INTO VotoPergunta VALUES(2, 7, -1);
INSERT INTO VotoPergunta VALUES(9, 2, 1);
INSERT INTO VotoPergunta VALUES(3, 3, 1);
INSERT INTO VotoPergunta VALUES(10, 6, 1);
INSERT INTO VotoPergunta VALUES(9, 3, 1);
INSERT INTO VotoPergunta VALUES(5, 8, 1);
INSERT INTO VotoPergunta VALUES(4, 7, -1);
INSERT INTO VotoPergunta VALUES(2, 3, 1);
INSERT INTO VotoPergunta VALUES(6, 3, 1);
INSERT INTO VotoPergunta VALUES(10, 4, 1);
INSERT INTO VotoPergunta VALUES(1, 7, 1);
INSERT INTO VotoPergunta VALUES(1, 3, -1);
INSERT INTO VotoPergunta VALUES(1, 5, 1);
INSERT INTO VotoPergunta VALUES(8, 8, 1);
INSERT INTO VotoPergunta VALUES(7, 5, -1);
INSERT INTO VotoPergunta VALUES(5, 4, 1);
INSERT INTO VotoPergunta VALUES(6, 8, 1);
INSERT INTO VotoPergunta VALUES(10, 3, 1);
INSERT INTO VotoPergunta VALUES(4, 8, 1);
INSERT INTO VotoPergunta VALUES(7, 8, -1);
INSERT INTO VotoPergunta VALUES(7, 2, -1);

/*--------------------------------------------*/
/*                VotoResposta                */
/*--------------------------------------------*/

INSERT INTO VotoResposta VALUES(3, autor, 1);
INSERT INTO VotoResposta VALUES(8, autor, -1);
INSERT INTO VotoResposta VALUES(5, autor, 1);
INSERT INTO VotoResposta VALUES(1, autor, 1);
INSERT INTO VotoResposta VALUES(9, autor, 1);
INSERT INTO VotoResposta VALUES(10, autor, -1);
INSERT INTO VotoResposta VALUES(11, autor, -1);
INSERT INTO VotoResposta VALUES(7, autor, -1);
INSERT INTO VotoResposta VALUES(14, autor, 1);
INSERT INTO VotoResposta VALUES(2, autor, 1);
INSERT INTO VotoResposta VALUES(4, autor, 1);
INSERT INTO VotoResposta VALUES(13, autor, 1);
INSERT INTO VotoResposta VALUES(12, autor, -1);
INSERT INTO VotoResposta VALUES(15, autor, 1);
INSERT INTO VotoResposta VALUES(6, autor, 1);
INSERT INTO VotoResposta VALUES(1, autor, 1);
INSERT INTO VotoResposta VALUES(3, autor, 1);
INSERT INTO VotoResposta VALUES(3, autor, -1);
INSERT INTO VotoResposta VALUES(3, autor, 1);
INSERT INTO VotoResposta VALUES(10, autor, 1);
INSERT INTO VotoResposta VALUES(13, autor, 1);
INSERT INTO VotoResposta VALUES(7, autor, -1);
INSERT INTO VotoResposta VALUES(14, autor, 1);
INSERT INTO VotoResposta VALUES(2, autor, 1);
INSERT INTO VotoResposta VALUES(10, autor, 1);
INSERT INTO VotoResposta VALUES(9, autor, 1);
INSERT INTO VotoResposta VALUES(9, autor, 1);
INSERT INTO VotoResposta VALUES(10, autor, -1);
INSERT INTO VotoResposta VALUES(10, autor, 1);
INSERT INTO VotoResposta VALUES(13, autor, 1);
INSERT INTO VotoResposta VALUES(13, autor, 1);
INSERT INTO VotoResposta VALUES(2 autor, -1);
INSERT INTO VotoResposta VALUES(2, autor, -1);
INSERT INTO VotoResposta VALUES(13, autor, 1);
INSERT INTO VotoResposta VALUES(12, autor, -1);
INSERT INTO VotoResposta VALUES(2 autor, 1);
INSERT INTO VotoResposta VALUES(2 autor, 1);

/*--------------------------------------------*/
/*                 Notificação                */
/*--------------------------------------------*/

/*--------------------------------------------*/
/*                  Mensagem                  */
/*--------------------------------------------*/

INSERT INTO Mensagem
VALUES(1, 3, 2, 'URGENTE', 'Olá! Por acaso não sabes se na papelaria vendem papel cor-de-rosa às riscas?', '2015-11-09 14:49:33');

INSERT INTO Mensagem
VALUES(2, 5, 7, 'Pintura', 'Hola! Fiz aqui uns rabiscos da tua cara mesmo à maneira. Queres passar aqui em casa para os ver?', '2015-12-21 07:49:33');

INSERT INTO Mensagem
VALUES(3, 7, 5, 'Re: Pintura', 'Guten Tag meu camarada. Achas que isso dá para vender?', '2015-12-21 08:30:15');

INSERT INTO Mensagem
VALUES(4, 2, 3, 'Re: URGENTE', 'Não te sei dizer, mas acho que o darklord chegou a ir lá comprar. Porque não lhe perguntas?', '2015-11-09 14:52:33');

INSERT INTO Mensagem
VALUES(5, 3, 4, 'URGENTE TAMBÉM', 'Boas darklord o marques disse-me que tinhas comprado um papel rosa às riscas na papelaria da faculdade. É verdade? Quanto custou?' ,'2015-11-09 14:58:33');

INSERT INTO Mensagem
VALUES(6, 5, 7, 'Re: Pintura', 'Não sei, mas estão bem guapos. Queres passar por aqui ou não?', '2015-12-21 08:31:15');

INSERT INTO Mensagem
VALUES(7, 7, 5, 'Re: Pintura', 'A caminho camarada. Faz mais que é para dar a toda a gente.', '2015-12-21 10:22:59');

INSERT INTO Mensagem
VALUES(8, 4, 3, 'Re: URGENTE TAMBÉM', 'Custa 19,99 patacas. Melhor cena da faculdade. Melhores desenhos da minha vida x)', '2015-11-09 15:00:33');

INSERT INTO Mensagem
VALUES(9, 2, 3, 'Re: URGENTE', 'Brigado :-D. Vou já comprar!!!', '2015-11-09 15:03:33');

INSERT INTO Mensagem
VALUES(10, 8, 2, 'Parabens!!!', 'Feliz aniversário! Diverte-te muito!', '2016-04-07 09:45:33');

INSERT INTO Mensagem
VALUES(11, 2, 8, 'Re: Parabens!!!', 'Obrigado Gato Preto! :D Logo à noite há bolo de morango se quiseres', '2016-04-07 09:52:33');

INSERT INTO Mensagem
VALUES(12, 3, 2, 'PARABENS!!!!!', 'Parabéns Marques, tás a ficar velho rapaz', '2016-04-07 09:45:33');

INSERT INTO Mensagem
VALUES(13, 2, 3, 'Re: PARABENS!!!!!', 'Obrigado Pedro Melo! :D Logo à noite há bolo de morango se quiseres', '2016-04-07 09:52:44');

INSERT INTO Mensagem
VALUES(14, 6, 4, 'presente de aniversário', 'Olha darklord, que prenda é que devo levar para o aniversário do Marques?', '2016-04-07 09:50:33');

INSERT INTO Mensagem
VALUES(15, 4, 6, 'Re: presente de aniversário', 'Tenho aqui um papel cor-de-rosa todo bonito do qual penso que ele gosta x)', '2016-04-07 09:51:33');

/*--------------------------------------------*/
/*                   Report                   */
/*--------------------------------------------*/

INSERT INTO Report
VALUES(1, 2, 7, "WHAT", '2015-12-24 15:43:09');

INSERT INTO Report
VALUES(2, 3, 7, "WHAT", '2015-12-24 15:45:22');

INSERT INTO Report
VALUES(3, 5, 7, "WHAT", '2015-12-24 15:45:41');

INSERT INTO Report
VALUES(4, 5, 4, "WHAT", '2016-03-04 21:57:23');