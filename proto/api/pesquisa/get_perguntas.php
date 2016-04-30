<?
  include_once('../../config/init.php');
  include_once('../../database/pesquisa.php');

  try {
    echo pergunta_pesquisar(
      safe_trim($_GET, 'query'),
      safe_trim($_GET, 'filter'),
      safe_trim($_GET, 'sort'),
      safe_trim($_GET, 'order')
    );
  }
  catch (PDOException $e) {
    http_response_code(400);
  }
?>