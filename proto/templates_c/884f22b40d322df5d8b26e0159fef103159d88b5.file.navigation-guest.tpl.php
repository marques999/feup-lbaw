<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:17:02
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/navigation-guest.tpl" */ ?>
<?php /*%%SmartyHeaderCode:8618583345708f2be4d0386-19067041%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '884f22b40d322df5d8b26e0159fef103159d88b5' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/navigation-guest.tpl',
      1 => 1460202149,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '8618583345708f2be4d0386-19067041',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'BASE_DIR' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be4df643_20572260',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be4df643_20572260')) {function content_5708f2be4df643_20572260($_smarty_tpl) {?><!-- NAVEGAÇÃO -->
<body class="ink-drawer">
<header id="header-container">
<nav id="header-menu" class="ink-navigation">


<!-- NAVEGAÇÃO RESPONSIVE (tiny/small) -->
<ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
  <li id="nav-drawer" class="hide-all show-tiny show-small">
    <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
  </li>
  <li id="nav-notifications" class="disabled medium">
    <a href="#"><i class="fa fa-bell-o"></i>0</a>
  </li>
  <li id="nav-messages" class="disabled medium">
    <a href="#"><i class="fa fa-envelope-o"></i>0</a>
  </li>
  <li id="nav-profile" class="medium">
    <a href="user_login.php"><i class="fa fa-user"></i>Visitante</a>
  </li>
</ul>


<!-- NAVEGAÇÃO RESPONSIVE (medium/large/xlarge) -->
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li id="nav-home" class="no-margin">
    <a href="index.php">
      <img src="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
/images/assets/header-256px.png" alt="">
    </a>
  </li>
  <form action="list_results.php" class="ink-form ink-search all-20 medium">
    <div class="control-group">
      <div class="control append-button" role="search">
        <span><input type="text" name="name" id="name"></span>
        <button class="ink-button"><i class="fa fa-search"></i></button>
      </div>
    </div>
  </form>
  <li id="nav-ask">
    <a href="message_guest.php">
      <i class="fa fa-comment-o"></i>
      Perguntar</a>
  </li>
  <li id="nav-answer">
    <a href="message_guest.php">
      <i class="fa fa-pencil-square-o"></i>
      Responder
    </a>
  </li>
  <li id="nav-notifications" class="disabled">
    <a href="#">
      <i class="fa fa-bell-o"></i>
      Notificações
    </a>
  </li>
  <li id="nav-profile">
    <a href="user_login.php">
      <i class="fa fa-user"></i>
      Visitante
    </a>
  </li>
</ul>
</nav>
</header><?php }} ?>
