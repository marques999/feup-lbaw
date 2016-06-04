<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  try {
    echo pergunta_pesquisar(
      safe_trimAll($_GET, 'query'),
      safe_trimAll($_GET, 'filter'),
      safe_trimAll($_GET, 'sort'),
      safe_trimAll($_GET, 'order')
    );
  }
  catch (PDOException $e) {
    http_response_code(400);
  }
?>