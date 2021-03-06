SET SCHEMA 'knowup';

DELETE FROM Report;
DELETE FROM Mensagem;
DELETE FROM Conversa;
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

INSERT INTO Categoria VALUES(DEFAULT, 'Bioengenharia');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Ambiente');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Civil');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Electrotécnica');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Informática');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Industrial');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Mecânica');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Metalúrgica');
INSERT INTO Categoria VALUES(DEFAULT, 'Engenharia Química');
INSERT INTO Categoria VALUES(DEFAULT, 'Criminologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Direito');
INSERT INTO Categoria VALUES(DEFAULT, 'Ciências Forenses');
INSERT INTO Categoria VALUES(DEFAULT, 'Anatomia');
INSERT INTO Categoria VALUES(DEFAULT, 'Imunologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Genética');
INSERT INTO Categoria VALUES(DEFAULT, 'Psicologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Medicina Dentária');
INSERT INTO Categoria VALUES(DEFAULT, 'Medicina Veterinária');
INSERT INTO Categoria VALUES(DEFAULT, 'Biologia Molecular');
INSERT INTO Categoria VALUES(DEFAULT, 'Bioquímica');
INSERT INTO Categoria VALUES(DEFAULT, 'Farmacologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Atletismo');
INSERT INTO Categoria VALUES(DEFAULT, 'Basquetebol');
INSERT INTO Categoria VALUES(DEFAULT, 'Futebol');
INSERT INTO Categoria VALUES(DEFAULT, 'Gestão Desportiva');
INSERT INTO Categoria VALUES(DEFAULT, 'Ginástica');
INSERT INTO Categoria VALUES(DEFAULT, 'Ténis');
INSERT INTO Categoria VALUES(DEFAULT, 'Agronomia');
INSERT INTO Categoria VALUES(DEFAULT, 'Astronomia');
INSERT INTO Categoria VALUES(DEFAULT, 'Física');
INSERT INTO Categoria VALUES(DEFAULT, 'Geologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Matemática');
INSERT INTO Categoria VALUES(DEFAULT, 'Química');
INSERT INTO Categoria VALUES(DEFAULT, 'Contabilidade');
INSERT INTO Categoria VALUES(DEFAULT, 'Economia');
INSERT INTO Categoria VALUES(DEFAULT, 'Finanças');
INSERT INTO Categoria VALUES(DEFAULT, 'Gestão');
INSERT INTO Categoria VALUES(DEFAULT, 'Cinema');
INSERT INTO Categoria VALUES(DEFAULT, 'Design');
INSERT INTO Categoria VALUES(DEFAULT, 'Escultura');
INSERT INTO Categoria VALUES(DEFAULT, 'Fotografia');
INSERT INTO Categoria VALUES(DEFAULT, 'Pintura');
INSERT INTO Categoria VALUES(DEFAULT, 'Arqueologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Filosofia');
INSERT INTO Categoria VALUES(DEFAULT, 'Geografia');
INSERT INTO Categoria VALUES(DEFAULT, 'História');
INSERT INTO Categoria VALUES(DEFAULT, 'Inglês');
INSERT INTO Categoria VALUES(DEFAULT, 'Jornalismo');
INSERT INTO Categoria VALUES(DEFAULT, 'Linguística');
INSERT INTO Categoria VALUES(DEFAULT, 'Multimédia');
INSERT INTO Categoria VALUES(DEFAULT, 'Português');
INSERT INTO Categoria VALUES(DEFAULT, 'Sociologia');
INSERT INTO Categoria VALUES(DEFAULT, 'Arquitectura');
INSERT INTO Categoria VALUES(DEFAULT, 'Arquitectura Paisagista');
INSERT INTO Categoria VALUES(DEFAULT, 'Património');
INSERT INTO Categoria VALUES(DEFAULT, 'Nutrição');

/*--------------------------------------------*/
/*                 Instituicao                */
/*--------------------------------------------*/

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Arquitectura da Universidade do Porto', 'faup', 'Via Panorâmica Edgar Cardoso s/n, 4150-755 PORTO', '22 605 7100', 'https://sigarra.up.pt/faup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Belas Artes da Universidade do Porto', 'fbaup', 'Avenida Rodrigues de Freitas 265, 4049-021 PORTO', '22 519 2400', 'https://sigarra.up.pt/fbaup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Ciências da Nutrição da Universidade do Porto', 'fcnaup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 507 4320', 'https://sigarra.up.pt/fcnaup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Medicina Dentária da Universidade do Porto', 'fmdup', 'Rua Dr. Manuel Pereira da Silva s/n, 4200-393 PORTO', '22 090 1100', 'https://sigarra.up.pt/fmdup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Professor Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Faculdade de Psicologia da Universidade do Porto', 'fpceup', 'Rua Alfredo Allen 525, 4200-135 PORTO', '22 607 9700', 'https://sigarra.up.pt/fpceup/pt');

INSERT INTO Instituicao
VALUES(DEFAULT, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt');

/*--------------------------------------------*/
/*            CategoriaInstituicao            */
/*--------------------------------------------*/

INSERT INTO CategoriaInstituicao VALUES(1, 13);
INSERT INTO CategoriaInstituicao VALUES(1, 22);
INSERT INTO CategoriaInstituicao VALUES(1, 23);
INSERT INTO CategoriaInstituicao VALUES(1, 24);
INSERT INTO CategoriaInstituicao VALUES(1, 25);
INSERT INTO CategoriaInstituicao VALUES(1, 26);
INSERT INTO CategoriaInstituicao VALUES(1, 27);
INSERT INTO CategoriaInstituicao VALUES(1, 56);
INSERT INTO CategoriaInstituicao VALUES(2, 53);
INSERT INTO CategoriaInstituicao VALUES(2, 54);
INSERT INTO CategoriaInstituicao VALUES(2, 55);
INSERT INTO CategoriaInstituicao VALUES(3, 38);
INSERT INTO CategoriaInstituicao VALUES(3, 39);
INSERT INTO CategoriaInstituicao VALUES(3, 40);
INSERT INTO CategoriaInstituicao VALUES(3, 41);
INSERT INTO CategoriaInstituicao VALUES(3, 42);
INSERT INTO CategoriaInstituicao VALUES(3, 48);
INSERT INTO CategoriaInstituicao VALUES(3, 50);
INSERT INTO CategoriaInstituicao VALUES(4, 56);
INSERT INTO CategoriaInstituicao VALUES(5, 2);
INSERT INTO CategoriaInstituicao VALUES(5, 5);
INSERT INTO CategoriaInstituicao VALUES(5, 12);
INSERT INTO CategoriaInstituicao VALUES(5, 15);
INSERT INTO CategoriaInstituicao VALUES(5, 19);
INSERT INTO CategoriaInstituicao VALUES(5, 28);
INSERT INTO CategoriaInstituicao VALUES(5, 29);
INSERT INTO CategoriaInstituicao VALUES(5, 30);
INSERT INTO CategoriaInstituicao VALUES(5, 31);
INSERT INTO CategoriaInstituicao VALUES(5, 32);
INSERT INTO CategoriaInstituicao VALUES(5, 33);
INSERT INTO CategoriaInstituicao VALUES(5, 45);
INSERT INTO CategoriaInstituicao VALUES(5, 50);
INSERT INTO CategoriaInstituicao VALUES(5, 54);
INSERT INTO CategoriaInstituicao VALUES(6, 10);
INSERT INTO CategoriaInstituicao VALUES(6, 11);
INSERT INTO CategoriaInstituicao VALUES(7, 32);
INSERT INTO CategoriaInstituicao VALUES(7, 34);
INSERT INTO CategoriaInstituicao VALUES(7, 35);
INSERT INTO CategoriaInstituicao VALUES(7, 36);
INSERT INTO CategoriaInstituicao VALUES(7, 37);
INSERT INTO CategoriaInstituicao VALUES(8, 1);
INSERT INTO CategoriaInstituicao VALUES(8, 2);
INSERT INTO CategoriaInstituicao VALUES(8, 3);
INSERT INTO CategoriaInstituicao VALUES(8, 4);
INSERT INTO CategoriaInstituicao VALUES(8, 5);
INSERT INTO CategoriaInstituicao VALUES(8, 6);
INSERT INTO CategoriaInstituicao VALUES(8, 7);
INSERT INTO CategoriaInstituicao VALUES(8, 8);
INSERT INTO CategoriaInstituicao VALUES(8, 9);
INSERT INTO CategoriaInstituicao VALUES(8, 30);
INSERT INTO CategoriaInstituicao VALUES(8, 32);
INSERT INTO CategoriaInstituicao VALUES(8, 33);
INSERT INTO CategoriaInstituicao VALUES(8, 50);
INSERT INTO CategoriaInstituicao VALUES(9, 12);
INSERT INTO CategoriaInstituicao VALUES(9, 14);
INSERT INTO CategoriaInstituicao VALUES(9, 19);
INSERT INTO CategoriaInstituicao VALUES(9, 20);
INSERT INTO CategoriaInstituicao VALUES(9, 21);
INSERT INTO CategoriaInstituicao VALUES(10, 38);
INSERT INTO CategoriaInstituicao VALUES(10, 39);
INSERT INTO CategoriaInstituicao VALUES(10, 43);
INSERT INTO CategoriaInstituicao VALUES(10, 44);
INSERT INTO CategoriaInstituicao VALUES(10, 45);
INSERT INTO CategoriaInstituicao VALUES(10, 46);
INSERT INTO CategoriaInstituicao VALUES(10, 47);
INSERT INTO CategoriaInstituicao VALUES(10, 48);
INSERT INTO CategoriaInstituicao VALUES(10, 49);
INSERT INTO CategoriaInstituicao VALUES(10, 50);
INSERT INTO CategoriaInstituicao VALUES(10, 51);
INSERT INTO CategoriaInstituicao VALUES(10, 52);
INSERT INTO CategoriaInstituicao VALUES(10, 55);
INSERT INTO CategoriaInstituicao VALUES(11, 12);
INSERT INTO CategoriaInstituicao VALUES(11, 13);
INSERT INTO CategoriaInstituicao VALUES(11, 17);
INSERT INTO CategoriaInstituicao VALUES(12, 12);
INSERT INTO CategoriaInstituicao VALUES(12, 13);
INSERT INTO CategoriaInstituicao VALUES(12, 14);
INSERT INTO CategoriaInstituicao VALUES(12, 15);
INSERT INTO CategoriaInstituicao VALUES(12, 16);
INSERT INTO CategoriaInstituicao VALUES(12, 17);
INSERT INTO CategoriaInstituicao VALUES(12, 19);
INSERT INTO CategoriaInstituicao VALUES(12, 20);
INSERT INTO CategoriaInstituicao VALUES(12, 21);
INSERT INTO CategoriaInstituicao VALUES(13, 12);
INSERT INTO CategoriaInstituicao VALUES(13, 16);
INSERT INTO CategoriaInstituicao VALUES(13, 40);
INSERT INTO CategoriaInstituicao VALUES(13, 44);
INSERT INTO CategoriaInstituicao VALUES(13, 52);
INSERT INTO CategoriaInstituicao VALUES(14, 1);
INSERT INTO CategoriaInstituicao VALUES(14, 12);
INSERT INTO CategoriaInstituicao VALUES(14, 13);
INSERT INTO CategoriaInstituicao VALUES(14, 14);
INSERT INTO CategoriaInstituicao VALUES(14, 15);
INSERT INTO CategoriaInstituicao VALUES(14, 16);
INSERT INTO CategoriaInstituicao VALUES(14, 17);
INSERT INTO CategoriaInstituicao VALUES(14, 18);
INSERT INTO CategoriaInstituicao VALUES(14, 19);
INSERT INTO CategoriaInstituicao VALUES(14, 20);
INSERT INTO CategoriaInstituicao VALUES(14, 21);

/*--------------------------------------------*/
/*                 Utilizador                 */
/*--------------------------------------------*/

INSERT INTO Utilizador
VALUES(DEFAULT, NULL, 'admin', 'sha256:1000:a+aUpABRPlfNbMrZgC2TEMVLwtgsCLHK:9VrWVXP5aBhAevcWp35nOtT3t5UHJRT5', 'contact@knowup.pt', 'Administrador', 'NULL', 'Porto', 'pt', '2014-10-23 12:30:04', '2016-06-11 14:38:55', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 8, 'marques999', 'sha256:1000:Kpw6+2DYXw4SFQvvNvgXjysCqOs1kq+f:yAceSX/yPhOr0Enew4wgaYLAIVO4eUqU', 'up201305642@fe.up.pt', 'Diogo', 'Marques', 'Valongo', 'pt', '2015-01-21 12:30:04', '2016-06-15 04:48:42', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 8, 'mellus', 'sha256:1000:xjMS3TbYhnnDoN9B3qqaKoqx6l7DBecU:aKGUgRCliXXrC3OmnqYxcwJE7uNJBR71', 'up201305618@fe.up.pt', 'Pedro', 'Melo', 'Penafiel', 'pt', '2015-03-02 12:30:04', '2016-06-17 17:16:18', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 8, 'darklord', 'sha256:1000:M+zlJQqe+At8Z4FZ0oM9keIgBKUtOtkV:X4a6Sco/rGYdTj7LPZ4KjgApGC8lZ8S1', 'up201303104@fe.up.pt', 'Vitor', 'Esteves', 'Mirandela', 'pt', '2015-04-13 12:30:04', '2016-06-16 12:41:25', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 3, 'picasso', 'sha256:1000:zgIniOQBL4Zem0iLuSCNZPxMEE1eGYlM:LquP5YcQpRi5H8Tck2MZ/ssIlmSw69yW', 'pintobem@guernica.es', 'Pablo', 'Picasso', 'Málaga', 'es', '2015-04-21 14:40:23', '2016-06-17 20:36:21', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 9, 'penicilina', 'sha256:1000:af+XRndMgIOqxZsOy7Nj9e4f3B7gCBBv:hDZE1AuUV7eitE6t9Tqb1MwXKcGF3ByA', 'tratamento@eficaz.co.uk', 'Alexander', 'Fleming', 'Lochfield', 'uk', '2015-06-12 14:43:49', '2016-06-10 15:23:03', true, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 7, 'marchista', 'sha256:1000:LiaqY0Q0kQ0wbsgQLM5dVkCZHKrMoHSv:fKIjU2OeSR5HVISf6bMelA4ioTebav2c', 'tustaum@karlmail.de', 'Karl', 'Marx', 'Trier', 'de', '2015-07-12 14:46:02', '2016-06-15 19:50:34', false, true);

INSERT INTO Utilizador
VALUES(DEFAULT, 14, 'bolinhas', 'sha256:1000:ek1CDTMlxkdVJaIn7Oaf0IjudkE51qpc:nN7DzvWz5iyvitgwWWKpwBeITkIHZO0Y', 'whiskas_saquetas@neko.jp', 'Gato', 'Preto', 'Saitama', 'jp', '2015-08-14 14:49:33', '2016-06-14 15:23:49', false, true);

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

INSERT INTO Pergunta
VALUES(DEFAULT, 54, 8, 'Qual o tamanho dos vários tipos principais de folhas em pixels?', 'Necessito de saber o tamanho exacto, em <em>pixels</em>, dos tamanhos de folhas A3, A4 e A5. Tenho um projeto de desenho em curso e queria saber qual a mais adequada.', '2015-11-04 12:30:07', false, 0, 1);

INSERT INTO Pergunta
VALUES(DEFAULT, 12, 4, 'O que fazer no final do curso?', 'Bom dia, gostaria de saber se depois de terminar o meu curso com média superior a 18 poderia ir trabalhar para o CSI em Miami?', '2016-01-03 22:45:13', true, 1, 0);

INSERT INTO Pergunta
VALUES(DEFAULT, 55, 2, 'O que fazer quando tudo o resto falha?', 'O meu projeto de ordenamento do território em Valongo estava a correr sobre rodas, até que me deparei com um <strong>grave problema</strong>:<br>A migração da pecuária, especialmente gado bovino, está a destruir o parque da escola preparatória de Valongo.<br>As crianças foram contaminadas devido ao contacto com os dejectos que os animais amontoavam no escorrega.<br>Gostaria assim de perguntar aos estudantes de direito que acção legal poderia tomar contra os pastores locais.', '2016-03-22 16:45:41', true, -6, 0);

INSERT INTO Pergunta
VALUES(DEFAULT, 17, 6, 'Qual o numero de dentes de um ser humano adulto?', NULL, '2016-04-15 19:44:32', false, 2, 1);

INSERT INTO Pergunta
VALUES(DEFAULT, 28, 2, 'Como faço para mudar de curso?', 'Gostaria de saber quais os requisitos para mudar para o curso de Agronomia. Estou desapontado com a minha escolha e gostaria de mudar', '2016-05-05 04:23:54', true, -2, 0);

INSERT INTO Pergunta
VALUES(DEFAULT, 13, 3, 'Dor de cabeça: Ibuprofeno ou paracetamol?', 'Ultimamente tenho tido dores de cabeça enquanto estudo e gostaria de saber se deveria tomar ibuprofeno ou paracetamol.', '2016-05-15 14:56:43', false, 4, 5);

INSERT INTO Pergunta
VALUES(DEFAULT, 5, 7, 'O que significa ASCII?', 'Estou a aprender a programar em C e muitos tutoriais referem esse termo que eu desconheço. O que poderá ser?', '2016-05-28 19:44:32', true, -1, 4);

INSERT INTO Pergunta
VALUES(DEFAULT, 42, 5, 'Lápis normal ou lápis de cera?', 'Quero saber qual o mais adequado para uma pintura rupestre de Penafiel. Obrigado!', '2016-05-31 07:15:29', false, 2, 1);

INSERT INTO Pergunta
VALUES(DEFAULT, 38, 8, 'Alguma ideia para uma curta metragem?', 'Preciso de ajuda urgente! Por favor respondam rápido, é para um trabalho que tenho de entregar amanhã...', '2016-06-03 22:45:22', true, 4, 2);

INSERT INTO Pergunta
VALUES(DEFAULT, 24, 7, 'Tópicos externos', 'Boa noite, queria saber se é permitido discutir assuntos futebolísticos dentro da comunidade não relacionados diretamente com a faculdade.', '2016-06-04 12:30:07', false, 1, 1);

INSERT INTO Pergunta
VALUES(DEFAULT, 23, 1, 'Como se joga basquetebol?', 'Há anos que tenho feito esta pergunta, não me consegui convencer com nenhuma resposta até ao momento...', '2016-06-05 00:26:06.924639', true, 0, 2);

INSERT INTO Pergunta
VALUES(DEFAULT, 24, 2, 'Como se joga futebol?', 'Há anos que tenho feito esta pergunta, não me consegui convencer com nenhuma resposta até ao momento...', '2016-06-05 00:29:49.051084', true, -1, 0);

INSERT INTO Pergunta
VALUES(DEFAULT, 51, 3, 'Sabes quem eu sou?', NULL, '2016-06-05 23:48:44.672975', true, 0, 1);

/*--------------------------------------------*/
/*                Contribuiçao                */
/*--------------------------------------------*/

INSERT INTO Contribuicao
VALUES(1, 7, '1 cm equivale a 28,34 pixels. Sendo assim, 1 mm equivale a 2,83 pixels. Confira abaixo o tamanho da Folha A4, em pixels:<br>Folha A4:<br>2480 px de largura<br>3508 px de altura<br><br>Folha A3:<br>3508 px de largura<br>4960 px de altura<br><br>Folha A5:<br>1754 px de largura <br>2480 px de altura', '2016-03-21 14:35:33');

INSERT INTO Contribuicao
VALUES(2, 8, 'Muito obrigado, rápido e esclarecedor como sempre!', '2016-03-21 14:49:33');

INSERT INTO Contribuicao
VALUES(3, 5, '<p>Um humano adulto tem normalmente 32 dentes, dezesseis na mandíbula e dezesseis na maxila.</p>', '2015-11-10 20:42:45');

INSERT INTO Contribuicao
VALUES(4, 5, '<p>Na minha opinião devias tomar paracetamol.</p>', '2016-05-11 14:58:01');

INSERT INTO Contribuicao
VALUES(5, 2, '<p>Eu acho que devia ser ibuprofeno, também é anti-inflamatório!</p>', '2016-05-11 15:02:13');

INSERT INTO Contribuicao
VALUES(6, 5, '<p>Se a dor for leve, apesar de constante, penso que o mais aconselhado seria paracetamol, pois é menos prejudicial à saude @marques999</p>', '2016-05-11 15:05:46');

INSERT INTO Contribuicao
VALUES(7, 2, '<p>Sim, de certa forma tens razão, ainda que ele possa ter uma inflamação. Eu diria ibuprofeno pois também é anti-inflamatório. Se não tomar muitas vezes nao há problemas @penicilina</p>', '2016-05-11 15:26:53');

INSERT INTO Contribuicao
VALUES(8, 5, 'A dor é muito forte? @mellus', '2016-05-11 15:30:22');

INSERT INTO Contribuicao
VALUES(9, 3, 'Não, só que como é persistente perturba-me o estudo', '2016-05-11 15:21:10');

INSERT INTO Contribuicao
VALUES(10, 5, 'Então o paracetamol é o mais indicado devido à falta de outros sintomas @mellus @marques999', '2016-05-11 19:41:21');

INSERT INTO Contribuicao
VALUES(11, 6, 'Muito obrigado! PS: Qual é a farmácia mais próxima do S.João?', '2016-05-11 20:36:41');

INSERT INTO Contribuicao
VALUES(12, 2, 'Vai ao Amial, há uma aberta de certeza.', '2016-05-11 20:40:12');

INSERT INTO Contribuicao
VALUES(13, 5, '<blockquote>ASCII (acrónimo para <em>American Standard Code for Information Interchange</em>, que em português significa "código padrão americano para intercâmbio de informação", mas comumente utilizamos a sigla em inglês para referencia direta) é uma codificação de caracteres de sete bits baseada no alfabeto inglês.</blockquote><p>Fonte: <a href="http://pt.stackoverflow.com/tags/ascii/info">Wikipédia</a></p>', '2016-05-29 21:14:22');

INSERT INTO Contribuicao
VALUES(14, 6, '<p>Preciso de fazer algum <em>include</em> para usar no meu c&oacute;digo em C++?</p>', '2016-06-01 09:54:09');

INSERT INTO Contribuicao
VALUES(15, 8, '<p>Tendo em conta a minha experiência em uso de todo o tipo de lápis, aconselho cera para ambientes rurais, e normal para ambientes urbanos. Cabe agora a ti descobrir que paisagem queres pintar exatamente.</p>', '2015-12-24 22:22:22');

INSERT INTO Contribuicao
VALUES(16, 5, '<p><em>Star Wars</em> &eacute; sempre um bom tema...</p>', '2016-03-24 19:43:32');

INSERT INTO Contribuicao
VALUES(17, 3, '<p>Papel cor-de-rosa dava um bom nome. Em rela&ccedil;&atilde;o ao tema, aproveitando a ideia do @darklord eu diria uma com&eacute;dia rom&acirc;ntica com bonecos do <em>Star Wars</em>. Deve ser incrivel!!!</p>', '2016-03-24 20:11:52');

INSERT INTO Contribuicao
VALUES(18, 2, '<p>Desde que cumpra as normas deste website, sim &eacute; permitido.</p>', '2016-04-10 19:43:32');

INSERT INTO Contribuicao
VALUES(19, 7, 'Obrigado, tentarei sempre seguir as regras!', '2016-04-10 20:41:14');

INSERT INTO Contribuicao
VALUES(20, 2, '<p>Finalmente consigo&nbsp;<strong>editar respostas</strong> aqui no site...</p>', '2016-06-02 17:54:08.109931');

INSERT INTO Contribuicao
VALUES(21, 4, '<p>Eu sei!</p>', '2016-06-05 13:31:01.720051');

INSERT INTO Contribuicao
VALUES(22, 4, '<p>Queres saber a resposta?</p>', '2016-06-05 13:31:33.773765');

INSERT INTO Contribuicao
VALUES(23, 2, '<h3>Manel????</h3>', '2016-06-06 00:10:13.991778');

/*--------------------------------------------*/
/*                  Resposta                  */
/*--------------------------------------------*/

INSERT INTO Resposta VALUES(1, 1, true);
INSERT INTO Resposta VALUES(3, 4, true);
INSERT INTO Resposta VALUES(4, 6, false);
INSERT INTO Resposta VALUES(5, 6, false);
INSERT INTO Resposta VALUES(6, 6, false);
INSERT INTO Resposta VALUES(7, 6, false);
INSERT INTO Resposta VALUES(10, 6, true);
INSERT INTO Resposta VALUES(13, 7, false);
INSERT INTO Resposta VALUES(14, 7, false);
INSERT INTO Resposta VALUES(15, 8, true);
INSERT INTO Resposta VALUES(16, 9, false);
INSERT INTO Resposta VALUES(17, 9, false);
INSERT INTO Resposta VALUES(18, 10, false);
INSERT INTO Resposta VALUES(20, 7, false);
INSERT INTO Resposta VALUES(21, 11, true);
INSERT INTO Resposta VALUES(22, 11, false);
INSERT INTO Resposta VALUES(23, 13, true);

/*--------------------------------------------*/
/*                  Seguidor                  */
/*--------------------------------------------*/

INSERT INTO Seguidor VALUES(7, 1, '2016-03-21 14:35:33', '2016-03-22 09:14:59');
INSERT INTO Seguidor VALUES(8, 1, '2016-03-21 14:30:07', '2016-04-01 17:10:08');
INSERT INTO Seguidor VALUES(2, 2, '2016-06-01 13:21:41', '2016-06-06 14:40:41');
INSERT INTO Seguidor VALUES(4, 2, '2016-06-05 18:36:46', '2016-06-05 18:36:46');
INSERT INTO Seguidor VALUES(8, 2, '2016-03-21 14:49:33', '2016-03-21 14:49:33');
INSERT INTO Seguidor VALUES(2, 3, '2015-09-23 16:45:22', '2016-02-24 12:18:05');
INSERT INTO Seguidor VALUES(5, 3, '2015-11-10 20:42:45', '2015-11-10 20:42:45');
INSERT INTO Seguidor VALUES(5, 4, '2015-11-10 20:42:45', '2016-04-07 05:22:32');
INSERT INTO Seguidor VALUES(6, 4, '2015-11-10 19:44:32', '2016-01-02 19:38:22');
INSERT INTO Seguidor VALUES(2, 5, '2015-09-25 04:23:54', '2016-02-24 07:52:20');
INSERT INTO Seguidor VALUES(2, 6, '2015-09-25 15:26:53', '2016-02-24 22:42:54');
INSERT INTO Seguidor VALUES(3, 6, '2015-09-25 14:56:43', '2015-12-24 02:32:12');
INSERT INTO Seguidor VALUES(5, 6, '2015-09-25 15:05:46', '2016-04-25 18:26:44');
INSERT INTO Seguidor VALUES(2, 7, '2016-06-06 13:54:30', '2016-06-06 14:27:20');
INSERT INTO Seguidor VALUES(5, 7, '2016-01-10 21:14:22', '2016-04-01 23:02:30');
INSERT INTO Seguidor VALUES(6, 7, '2016-01-11 09:54:09', '2016-01-12 18:38:10');
INSERT INTO Seguidor VALUES(7, 7, '2016-01-10 19:44:32', '2016-06-09 15:32:47');
INSERT INTO Seguidor VALUES(5, 8, '2015-12-24 19:43:32', '2016-05-23 20:56:57');
INSERT INTO Seguidor VALUES(8, 8, '2015-12-24 22:22:22', '2016-04-30 11:24:37');
INSERT INTO Seguidor VALUES(3, 9, '2016-03-24 20:11:41', '2016-03-28 10:12:19');
INSERT INTO Seguidor VALUES(5, 9, '2016-03-24 19:43:32', '2016-04-12 04:44:26');
INSERT INTO Seguidor VALUES(8, 9, '2016-03-23 17:43:52', '2016-04-17 16:00:51');
INSERT INTO Seguidor VALUES(2, 10, '2016-04-10 19:43:32', '2016-02-24 17:20:53');
INSERT INTO Seguidor VALUES(7, 10, '2016-03-24 19:40:10', '2016-06-09 04:22:36');
INSERT INTO Seguidor VALUES(2, 11, '2016-06-06 14:26:04', '2016-06-06 14:27:01');
INSERT INTO Seguidor VALUES(1, 11, '2016-06-05 00:26:06', '2016-06-05 00:26:06');
INSERT INTO Seguidor VALUES(3, 12, '2016-06-05 23:48:44', '2016-06-05 23:49:02');
INSERT INTO Seguidor VALUES(8, 13, '2015-12-24 22:22:22', '2015-12-24 22:22:22');
INSERT INTO Seguidor VALUES(2, 13, '2016-06-06 11:38:10', '2016-06-06 14:27:23');

/*--------------------------------------------*/
/*             ComentarioPergunta             */
/*--------------------------------------------*/

INSERT INTO ComentarioPergunta VALUES(8, 6);
INSERT INTO ComentarioPergunta VALUES(9, 6);

/*--------------------------------------------*/
/*             ComentarioResposta             */
/*--------------------------------------------*/

INSERT INTO ComentarioResposta VALUES(2, 1);
INSERT INTO ComentarioResposta VALUES(11, 10);
INSERT INTO ComentarioResposta VALUES(12, 10);
INSERT INTO ComentarioResposta VALUES(19, 18);

/*--------------------------------------------*/
/*                VotoPergunta                */
/*--------------------------------------------*/

INSERT INTO VotoPergunta VALUES(1, 4, 1);
INSERT INTO VotoPergunta VALUES(1, 5, 1);
INSERT INTO VotoPergunta VALUES(1, 8, 1);
INSERT INTO VotoPergunta VALUES(2, 2, 1);
INSERT INTO VotoPergunta VALUES(3, 3, -1);
INSERT INTO VotoPergunta VALUES(3, 4, -1);
INSERT INTO VotoPergunta VALUES(3, 5, -1);
INSERT INTO VotoPergunta VALUES(3, 6, -1);
INSERT INTO VotoPergunta VALUES(3, 7, -1);
INSERT INTO VotoPergunta VALUES(3, 8, -1);
INSERT INTO VotoPergunta VALUES(4, 2, -1);
INSERT INTO VotoPergunta VALUES(4, 3, 1);
INSERT INTO VotoPergunta VALUES(4, 4, 1);
INSERT INTO VotoPergunta VALUES(4, 7, 1);
INSERT INTO VotoPergunta VALUES(4, 8, -1);
INSERT INTO VotoPergunta VALUES(5, 3, -1);
INSERT INTO VotoPergunta VALUES(5, 4, -1);
INSERT INTO VotoPergunta VALUES(5, 7, -1);
INSERT INTO VotoPergunta VALUES(5, 8, 1);
INSERT INTO VotoPergunta VALUES(6, 2, 1);
INSERT INTO VotoPergunta VALUES(6, 3, 1);
INSERT INTO VotoPergunta VALUES(6, 4, 1);
INSERT INTO VotoPergunta VALUES(6, 5, 1);
INSERT INTO VotoPergunta VALUES(6, 6, -1);
INSERT INTO VotoPergunta VALUES(6, 8, 1);
INSERT INTO VotoPergunta VALUES(7, 2, -1);
INSERT INTO VotoPergunta VALUES(7, 3, -1);
INSERT INTO VotoPergunta VALUES(7, 5, 1);
INSERT INTO VotoPergunta VALUES(7, 7, 1);
INSERT INTO VotoPergunta VALUES(7, 8, -1);
INSERT INTO VotoPergunta VALUES(8, 3, 1);
INSERT INTO VotoPergunta VALUES(8, 8, 1);
INSERT INTO VotoPergunta VALUES(9, 2, 1);
INSERT INTO VotoPergunta VALUES(9, 3, 1);
INSERT INTO VotoPergunta VALUES(9, 4, 1);
INSERT INTO VotoPergunta VALUES(9, 6, 1);
INSERT INTO VotoPergunta VALUES(9, 8, 1);
INSERT INTO VotoPergunta VALUES(10, 2, 1);
INSERT INTO VotoPergunta VALUES(12, 3, -1);
INSERT INTO VotoPergunta VALUES(13, 3, -1);
INSERT INTO VotoPergunta VALUES(13, 2, 1);

/*--------------------------------------------*/
/*                VotoResposta                */
/*--------------------------------------------*/

INSERT INTO VotoResposta VALUES(1, 2, -1);
INSERT INTO VotoResposta VALUES(1, 4, -1);
INSERT INTO VotoResposta VALUES(1, 8, 1);
INSERT INTO VotoResposta VALUES(3, 3, -1);
INSERT INTO VotoResposta VALUES(3, 6, 1);
INSERT INTO VotoResposta VALUES(5, 3, 1);
INSERT INTO VotoResposta VALUES(5, 4, -1);
INSERT INTO VotoResposta VALUES(5, 8, 1);
INSERT INTO VotoResposta VALUES(6, 3, 1);
INSERT INTO VotoResposta VALUES(6, 7, -1);
INSERT INTO VotoResposta VALUES(7, 3, 1);
INSERT INTO VotoResposta VALUES(7, 5, 1);
INSERT INTO VotoResposta VALUES(10, 2, -1);
INSERT INTO VotoResposta VALUES(10, 3, 1);
INSERT INTO VotoResposta VALUES(10, 4, 1);
INSERT INTO VotoResposta VALUES(10, 6, -1);
INSERT INTO VotoResposta VALUES(10, 7, -1);
INSERT INTO VotoResposta VALUES(13, 6, 1);
INSERT INTO VotoResposta VALUES(13, 7, 1);
INSERT INTO VotoResposta VALUES(14, 2, -1);
INSERT INTO VotoResposta VALUES(14, 3, -1);
INSERT INTO VotoResposta VALUES(14, 4, -1);
INSERT INTO VotoResposta VALUES(14, 5, -1);
INSERT INTO VotoResposta VALUES(14, 7, -1);
INSERT INTO VotoResposta VALUES(15, 5, 1);
INSERT INTO VotoResposta VALUES(16, 2, -1);
INSERT INTO VotoResposta VALUES(16, 3, 1);
INSERT INTO VotoResposta VALUES(16, 4, -1);
INSERT INTO VotoResposta VALUES(16, 7, -1);
INSERT INTO VotoResposta VALUES(16, 8, -1);
INSERT INTO VotoResposta VALUES(17, 2, 1);
INSERT INTO VotoResposta VALUES(17, 4, 1);
INSERT INTO VotoResposta VALUES(17, 5, 1);
INSERT INTO VotoResposta VALUES(17, 8, -1);
INSERT INTO VotoResposta VALUES(18, 6, 1);
INSERT INTO VotoResposta VALUES(18, 7, 1);

/*--------------------------------------------*/
/*                  Conversa                  */
/*--------------------------------------------*/

INSERT INTO Conversa
VALUES(DEFAULT, 3, 2, 'URGENTE', '2015-11-09 14:49:43', '2016-04-06 23:59:11');

INSERT INTO Conversa
VALUES(DEFAULT, 3, 4, 'URGENTE TAMBÉM', '2015-11-09 15:13:08', '2015-11-09 15:15:23');

INSERT INTO Conversa
VALUES(DEFAULT, 5, 7, 'Pintura', '2015-12-21 10:23:27', '2015-12-21 11:36:52');

INSERT INTO Conversa
VALUES(DEFAULT, 8, 2, 'Parabéns!!!', '2016-04-07 09:52:17', '2016-04-07 09:52:49');

INSERT INTO Conversa
VALUES(DEFAULT, 3, 2, 'PARABÉNS!!!!!', '2016-04-07 09:54:12', '2016-04-07 09:53:44');

INSERT INTO Conversa
VALUES(DEFAULT, 6, 4, 'presente de aniversário', '2016-04-07 12:30:06', '2016-04-11 11:34:50');

INSERT INTO Conversa
VALUES(DEFAULT, 4, 7, 'Marx, o verdadeiro?', '2016-05-21 19:42:11', '2016-05-21 11:34:50');

/*--------------------------------------------*/
/*                  Mensagem                  */
/*--------------------------------------------*/

INSERT INTO Mensagem
VALUES(DEFAULT, 1, 3, 'Olá! Por acaso não sabes se na papelaria vendem papel cor-de-rosa às riscas?', '2015-11-09 14:49:43');

INSERT INTO Mensagem
VALUES(DEFAULT, 1, 2, 'Não te sei dizer, mas acho que o @darklord chegou a ir lá comprar. Porque não lhe perguntas?', '2015-11-09 14:52:01');

INSERT INTO Mensagem
VALUES(DEFAULT, 2, 3, 'Boas darklord, o @marques999 disse-me que tinhas comprado um papel rosa às riscas na papelaria da faculdade. É verdade? Quanto custou?', '2015-11-09 14:58:33');

INSERT INTO Mensagem
VALUES(DEFAULT, 2, 4, 'Custa 19,99 patacas. Melhor cena da faculdade. Melhores desenhos da minha vida x)', '2015-11-09 15:07:58');

INSERT INTO Mensagem
VALUES(DEFAULT, 2, 3, 'Brigado :-D. Vou já comprar!!!', '2015-11-09 15:13:08');

INSERT INTO Mensagem
VALUES(DEFAULT, 3, 5, 'Hola! Fiz aqui uns rabiscos da tua cara, ficaram mesmo à patrão. Queres passar aqui em casa para os ver?', '2015-12-21 07:49:12');

INSERT INTO Mensagem
VALUES(DEFAULT, 3, 7,'Guten Tag meu camarada. Achas que isso dá para vender?', '2015-12-21 08:30:15');

INSERT INTO Mensagem
VALUES(DEFAULT, 3, 5, 'Não sei, mas estão bem guapos. Queres passar por aqui ou não?', '2015-12-21 08:31:23');

INSERT INTO Mensagem
VALUES(DEFAULT, 3, 7, 'A caminho camarada. Faz mais que é para dar a toda a gente.', '2015-12-21 10:22:59');

INSERT INTO Mensagem
VALUES(DEFAULT, 4, 8, 'Feliz aniversário! Diverte-te muito!', '2016-04-07 09:42:35');

INSERT INTO Mensagem
VALUES(DEFAULT, 5, 3, 'Parabéns @marques999, estás a ficar velho rapaz!', '2016-04-07 09:45:26');

INSERT INTO Mensagem
VALUES(DEFAULT, 6, 6, 'Olha @darklord, que prenda é que devo levar para o aniversário do @marques999?', '2016-04-07 09:50:47');

INSERT INTO Mensagem
VALUES(DEFAULT, 4, 2, 'Obrigado Gato Preto! :D Logo à noite há bolo de morango se quiseres...', '2016-04-07 09:52:19');

INSERT INTO Mensagem
VALUES(DEFAULT, 5, 2, 'Obrigado Pedro Melo! :D Logo à noite há bolo de morango se quiseres...', '2016-04-07 09:53:44');

INSERT INTO Mensagem
VALUES(DEFAULT, 6, 4, 'Tenho aqui um papel cor-de-rosa todo bonito, acho que ele vai gostar x)', '2016-04-07 11:25:31');

INSERT INTO Mensagem
VALUES(DEFAULT, 7, 3, 'Gostava de saber quem na realidade você é...', '2016-04-07 11:25:31');

/*--------------------------------------------*/
/*                   Report                   */
/*--------------------------------------------*/

INSERT INTO Report
VALUES(DEFAULT, 5, 7, 'O utilizador estava a tentar erguer uma estátua de Lenin num comentário recorrendo a tracinhos e pontos.', '2015-12-24 15:45:41');

INSERT INTO Report
VALUES(DEFAULT, 5, 4, 'O utilizador estava a ser demasiado awesome.', '2016-03-04 21:57:21');

INSERT INTO Report
VALUES(DEFAULT, 2, 3, 'O utilizador foi apanhado numa rede de tráfico de enciclopédias.', '2016-03-21 15:43:09');

INSERT INTO Report
VALUES(DEFAULT, 3, 6, 'O utilizador estava a tentar pintar como Bob Ross mas esqueceu-se de acrescentar roupa aos personagens...', '2016-04-11 12:10:22');