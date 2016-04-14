 <?
  include_once('../config/init.php');
  include_once('../database/categoria.php');
  $stmt = $conn->prepare("SELECT * FROM Categoria ORDER BY nome");
  $listaCategorias = array("Anatomia",
    "Arqueologia",
    "Arquitectura Paisagista",
    "Astronomia",
    "Bioengenharia",
    "Biologia",
    "Bioquímica",
    "Ciência da Informação",
    "Ciências da Comunicação",
    "Ciências da Linguagem",
    "Ciências de Computadores",
    "Ciências de Engenharia",
    "Ciências do Ambiente",
    "Ciências do Desporto",
    "Ciências Farmacêuticas",
    "Ciências Forenses",
    "Cirurgias",
    "Criminologia",
    "Cuidados Paliativos",
    "Direito",
    "Educação Física",
    "Engenharia Ambiente",
    "Engenharia Civil",
    "Engenharia de Redes",
    "Engenharia Eletrotécnica",
    "Engenharia Física",
    "Engenharia Industrial e Gestão",
    "Engenharia Informática",
    "Engenharia Mecânica",
    "Engenharia Metalúrgica",
    "Engenharia Química",
    "Epidemologia",
    "Estudos Portugueses",
    "Filosofia",
    "Física",
    "Fisioterapia",
    "Geografia",
    "Geologia",
    "Gerontologia",
    "Gestão Desportiva",
    "História da Arte",
    "História",
    "Matemática",
    "Neurobiologia",
    "Psiquiatria",
    "Química Farmacêutica",
    "Química",
    "Tecnologia Farmacêutica");
  $rowsPerColumn = count($listaCategorias) / 4;
  $smarty->assign('counter', 0);
  $smarty->assign('numberRows', $rowsPerColumn);
  $smarty->assign('categorias', $listaCategorias);
  $smarty->display('lista_categorias.tpl');
 ?>