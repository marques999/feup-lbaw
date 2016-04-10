<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:17:02
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/sidebar-subject.php" */ ?>
<?php /*%%SmartyHeaderCode:2244939965708f2be5198d0-63345043%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '833605271083368ec8a05f0f91ae68a082eaae5d' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/sidebar-subject.php',
      1 => 1459601131,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2244939965708f2be5198d0-63345043',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be522e11_92855699',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be522e11_92855699')) {function content_5708f2be522e11_92855699($_smarty_tpl) {?><!-- LIST_QUESTIONS: painel lateral -->
<div class="column all-20 medium-25 small-100 tiny-100">
<nav class="ink-navigation medium vertical-padding">


<!-- LIST_QUESTIONS: instituições -->
<h5 class="slab half-vertical-space">
  <i class="fa fa-institution"></i>&nbsp;Instituições
</h5>
<ul class="menu vertical white">
  <li><a href="hub/feup">FCUP</a></li>
  <li><a href="hub/feup">FEUP</a></li>
</ul>


<!-- LIST_QUESTIONS: categorias relacionadas -->
<h5 class="slab half-vertical-space">
  <i class="fa fa-exchange"></i>&nbsp;Relacionadas
</h5>
<ul class="menu vertical white">
  <li><a href="subject/1">Ciência da Informação</a></li>
  <li><a href="subject/1">Ciências de Computadores</a></li>
  <li><a href="subject/1">Engenharia Física</a></li>
  <li><a href="subject/1">Matemática</a></li>
</ul>


<!-- LIST_QUESTIONS: ordenação -->
<h5 class="slab half-vertical-space">
  <i class="fa fa-line-chart"></i>&nbsp;Populares
</h5>
<ul class="menu vertical white">
  <li class="active"><a href="#">Neste momento</a></li>
  <li><a href="#">Últimas 24h</a></li>
  <li><a href="#">Últimas 48h</a></li>
  <li><a href="#">Última semana</a></li>
  <li><a href="#">Último mês</a></li>
</ul>


<!-- LIST_QUESTIONS: gestão da página -->
<h5 class="slab half-vertical-space">
  <i class="fa fa-cog"></i>&nbsp;Gestão
</h5>
<ul class="menu vertical white">
  <li><a href="ask_question.php">Nova pergunta</a></li>
  <li><a href="#">
    <sup><strong>(Admin)</strong></sup>
    Editar subject
  </a></li>
  <li><a href="#">
    <sup><strong>(Admin)</strong></sup>
    Apagar subject</a></li>
</ul>
</nav>
</div><?php }} ?>
