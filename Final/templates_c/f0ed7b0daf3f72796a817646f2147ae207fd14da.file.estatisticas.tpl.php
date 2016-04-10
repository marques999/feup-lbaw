<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:39:40
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/estatisticas.tpl" */ ?>
<?php /*%%SmartyHeaderCode:20278424570913b6164054-93930354%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f0ed7b0daf3f72796a817646f2147ae207fd14da' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/estatisticas.tpl',
      1 => 1460212753,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20278424570913b6164054-93930354',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_570913b6247542_89758906',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_570913b6247542_89758906')) {function content_570913b6247542_89758906($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('admin/header-chart.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('admin/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<!-- MAIS PERGUNTAS -->
<div class="column-group half-gutters">
<div class="column all-33 medium-50 small-100 tiny-100">
  <h4 class="align-center condensed">Mais perguntas (esta semana)</h4>
  <canvas id="myChart" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Perguntas</th>
        <th style="width:40%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">marques999</a>
        </td>
        <td>20</td>
        <td>
          <small>18/03/2016 12:37</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">darklord</a>
        </td>
        <td>7</td>
        <td>
          <small>20/03/2016 14:42</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">mellus</a>
        </td>
        <td>5</td>
        <td>
          <small>17/03/2016 08:14</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">admin</a>
        </td>
        <td>3</td>
        <td>
          <small>15/03/2016 02:20</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>1</td>
        <td>
          <small>15/03/2016 21:19</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- MAIS RESPOSTAS -->
<div class="column all-33 medium-50 small-100 tiny-100">
  <h4 class="align-center condensed">Mais respostas (esta semana)</h4>
  <canvas id="myChart2" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Respostas</th>
        <th style="width:40%">Última Resposta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">mellus</a>
        </td>
        <td>9</td>
        <td>
          <small>20/03/2016 15:59</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>5</td>
        <td>
          <small>17/03/2016 11:31</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">darklord</a>
        </td>
        <td>4</td>
        <td>
          <small>15/03/2016 03:02</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">marques999</a>
        </td>
        <td>2</td>
        <td>
          <small>16/03/2016 23:40</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">admin</a>
        </td>
        <td>2</td>
        <td>
          <small>19/03/2016 21:08</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- MAIS ACTIVOS -->
<div class="column all-33 medium-100 small-100 tiny-100">
  <h4 class="align-center condensed">Mais activos (esta semana)</h4>
  <canvas id="myChart3" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Sessões</th>
        <th style="width:40%">Última Sessão</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>41</td>
        <td>
          <small>20/03/2016 23:59</small>
        </td>
      </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">marques999</a>
      </td>
      <td>20</td>
      <td>
        <small>19/03/2016 07:54</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">darklord</a>
      </td>
      <td>7</td>
      <td>
        <small>18/03/2016 14:22</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">mellus</a>
      </td>
      <td>5</td>
      <td>
        <small>16/03/2016 19:02</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">admin</a>
      </td>
      <td>3</td>
      <td>
        <small>18/03/2016 11:46</small>
      </td>
    </tr>
  </tbody>
  </table>
</div>


<!-- CATEGORIAS POPULARES -->
<div class="column all-50 small-100 tiny-100 half-vertical-space">
  <h4 class="align-center condensed">Categorias populares</h4>
  <canvas id="myChart4" width="400" height="200"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:35%">Categoria</th>
        <th style="width:15%">#Perguntas</th>
        <th style="width:40%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Geografia</a>
        </td>
        <td>24</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 10:10</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Neurobiologia</a>
        </td>
        <td>13</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 12:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Política</a>
        </td>
        <td>8</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>terça-feira, 15/03/2016 18:48</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Matemática</a>
        </td>
        <td>4</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quinta-feira, 17/03/2016 13:07</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Engenharia Informática</a>
        </td>
        <td>3</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quarta-feira, 16/03/2016 20:28</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- INSTITUIÇÕES POPULARES -->
<div class="column all-50 small-100 tiny-100 half-vertical-space">
  <h4 class="align-center condensed">Instituições populares</h4>
  <canvas id="myChart5" width="400" height="200"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:30%">Instituição</th>
        <th style="width:20%">#Perguntas</th>
        <th style="width:50%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FDUP</a>
        </td>
        <td>95</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>domingo, 20/03/2016 02:29</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FMUP</a>
        </td>
        <td>91</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sexta-feira, 18/03/2016 17:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FLUP</a>
        </td>
        <td>83</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 11:32</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FEUP</a>
        </td>
        <td>75</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>segunda-feira, 21/03/2016 17:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FCUP</a>
        </td>
        <td>67</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quarta-feira, 16/03/2016 12:24</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer-empty.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
