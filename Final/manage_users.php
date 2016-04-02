<?
  $pageLink = "manage_users.php";
  $pageTitle = "Gerir Utilizadores";
  $headerTitle = "Utilizadores Activos";
  $headerCount = 4;
  include('templates/header_admin.php');
  include('templates/manage_title.php');

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
  $users = array($user1, $user2, $user3, $user4, $user5);
?>


<!-- LISTA DE UTILIZADORES ACTIVOS -->
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th>Username</th>
      <th>E-mail</th>
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th>Atividade</th>
    </tr>
  </thead>
  <tbody class="align-center">
    <?foreach($users as $user) {
      if (!$user["ativo"]) {
        continue;
      }
    ?>
    <tr>
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html"><?="{$user["primeiroNome"]} {$user["ultimoNome"]}"?></a>
        <small>(<?=$user["username"]?>)</small>
      </td>
      <td>
        <small><?=$user["email"]?></small>
      </td>
      <td class="medium fw-700 positive-score"><?=$user["pontuacao"]?></td>
      <td class="medium"><?=$user["numeroPerguntas"]?></td>
      <td>
        <small><?=$user["ultimoAcesso"]?></small>
      </td>
    </tr>
   <?}?>
  </tbody>
</table>


<!-- LISTA DE UTILIZADORES BANIDOS -->
<div class="top-space">
<?
  $headerTitle = "Utilizadores Banidos";
  $headerCount = 1;
  include('templates/manage_title.php');
?>
</div>


<!-- LISTA DE UTILIZADORES BANIDOS -->
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th>Username</th>
      <th>E-mail</th>
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th style="width:25%">Acções</th>
    </tr>
  </thead>
  <tbody>
    <?foreach($users as $user) {
      if ($user["ativo"]) {
        continue;
      }
    ?>
    <tr class="align-center">
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html"><?="{$user["primeiroNome"]} {$user["ultimoNome"]}"?></a>
        <small>(<?=$user["username"]?>)</small>
      </td>
      <td>
        <small><?=$user["email"]?></small>
      </td>
      <td class="medium fw-700 negative-score"><?=$user["pontuacao"]?></td>
      <td class="medium"><?=$user["numeroPerguntas"]?></td>
      <td>
        <small>
          <button class="ink-button">
            <i class="fa fa-check"></i>
            <span>Activar</span>
          </button>
        </small>
        <small>
          <button class="ink-button">
            <i class="fa fa-user-times"></i>
            <span>Apagar</span>
          </button>
        </small>
      </td>
    </tr>
    <?}?>
  </tbody>
</table>
</div>
<?
  include('templates/footer_empty.php');
?>