<? 
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  $user1 = array(
    "username" => "marques999",
    "primeiroNome" => "Diogo",
    "ultimoNome" => "Marques",
    "email" => "up201305642@fe.up.pt",
    "pontuacao" => 21,
    "numeroPerguntas" => 14,
    "ultimoAcesso" => "segunda-feira, 21/03/2016 19:40",
    "ativo" => true
  );
  $user2 = array(
    "username" => "admin",
    "primeiroNome" => "Administrador",
    "ultimoNome" => null,
    "email" => "hello.world@example.com",
    "pontuacao" => 21,
    "numeroPerguntas" => 14,
    "ultimoAcesso" => "quinta-feira, 24/03/2016 01:29",
    "ativo" => true
  );
  $user3 = array(
    "username" => "mellus",
    "primeiroNome" => "Pedro",
    "ultimoNome" => "Melo",
    "email" => "up201305618@fe.up.pt",
    "pontuacao" => 21,
    "numeroPerguntas" => 14,
    "ultimoAcesso" => "quarta-feira, 23/03/2016 12:14",
    "ativo" => true
  );
  $user4 = array(
    "username" => "darklord",
    "primeiroNome" => "Vitor",
    "ultimoNome" => "Esteves",
    "email" => "up201303104@fe.up.pt",
    "pontuacao" => 21,
    "numeroPerguntas" => 14,
    "ultimoAcesso" => "domingo, 20/03/2016 08:53",
    "ativo" => true
  );
  $user5 = array(
    "username" => "misterioso",
    "primeiroNome" => "Anónimo",
    "ultimoNome" => "Anonimato",
    "email" => "1b3dc02c4ab972@gmail.com",
    "pontuacao" => -13,
    "numeroPerguntas" => 1,
    "ultimoAcesso" => "domingo, 20/03/2016 08:53",
    "ativo" => false
  );
  $listaUtilizadores = array($user1, $user2, $user3, $user4, $user5); 
  $smarty->assign('titulo', 'Gerir Utilizadores');
  $smarty->assign('users', $listaUtilizadores);
  $smarty->display('admin/utilizadores.tpl');
?>