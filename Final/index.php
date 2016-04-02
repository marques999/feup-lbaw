<?
  require_once (__DIR__ . '/vendor/autoload.php');
 
  $__BASE__ = "/~up201305642/knowup";

  use Respect\Rest\Router;
  use Respect\Rest\Routable;
  use Respect\Rest\Request;

  $r3 = new Router($__BASE__);

  $r3->get('/', function() {
    require_once('views/homepage.php');
  });

  $r3->get('/view/*', function($idPergunta) {
    require_once(__DIR__ . "/views/pergunta.php");
  });

  $r3->get('/hub/*', function($nomeInstituicao) {
    require_once(__DIR__ . "/views/instituicao.php");
  });

  $r3->get('/profile/*', function($idUtilizador) {
    require_once(__DIR__ . "/views/perfil.php");
  });

  $r3->get('/category/*', function($idCategoria) {
    require_once(__DIR__ . "/views/categoria.php");
  });

  $r3->get('/flags/*', function($imageName) {
    header('Content-type: image/png');
    return fopen("img/flags/{$imageName}.png", 'r');
  });
?>