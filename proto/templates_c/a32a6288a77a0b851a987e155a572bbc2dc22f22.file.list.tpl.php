<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:31:03
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/questions/list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:11656153845708f2be53dc31-33578836%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a32a6288a77a0b851a987e155a572bbc2dc22f22' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/questions/list.tpl',
      1 => 1460205020,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '11656153845708f2be53dc31-33578836',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be5c2ad8_13466745',
  'variables' => 
  array (
    'question' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be5c2ad8_13466745')) {function content_5708f2be5c2ad8_13466745($_smarty_tpl) {?><article class="question">
  <h4 class="slab quarter-vertical-space">
  <a class="black" href="view/1"><?php echo $_smarty_tpl->tpl_vars['question']->value['title'];?>
</a>
  <?php if (!$_smarty_tpl->tpl_vars['question']->value['active']) {?>
    <span class="ink-badge black small"><i class="fa fa-check"></i>fechada</span>
  <?php }?>
</h4>
<div class="align-center quarter-padding push-right">
  <?php if ($_smarty_tpl->tpl_vars['question']->value['score']>0) {?>
    <h3 class="quarter-vertical-space positive-score">
  <?php } elseif ($_smarty_tpl->tpl_vars['question']->value['score']<0) {?>
    <h3 class="quarter-vertical-space negative-score">
  <?php } else { ?>
    <h3 class="quarter-vertical-space">
  <?php }?>
  <?php echo $_smarty_tpl->tpl_vars['question']->value['score'];?>

  </h3>
  <p class="medium">(
  <?php echo $_smarty_tpl->tpl_vars['question']->value['votosPositivos'];?>

  <i class="fa fa-thumbs-up"></i>
  <?php echo $_smarty_tpl->tpl_vars['question']->value['votosNegativos'];?>

  <i class="fa fa-thumbs-down"></i>
  )</p>
</div>
<div class="author-panel quarter-vertical-space">
  <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
  <div class="half-padding">
    <p class="no-margin">
      <a href="profile/2"><strong><?php echo $_smarty_tpl->tpl_vars['question']->value['idAutor'];?>
</strong></a>
      <span class="small">FEUP</span>
    </p>
    <p class="medium no-margin">
      <small>Terça-feira, 1 de Março de 2016</small>
      &bull;
      <span class="medium">
        <strong><?php echo $_smarty_tpl->tpl_vars['question']->value['numberAnswers'];?>
</strong>&nbsp;Respostas
      </span>
    </p>
  </div>
</div>
<?php echo $_smarty_tpl->tpl_vars['question']->value['content'];?>

<div class="button-toolbar quarter-top-padding">
  <div class="button-group small">
    <a class="ink-button black" href="reply.php#reply-form">
      <i class="fa fa-pencil"></i>&nbsp;Responder
    </a>
    <button class="ink-button black">
      <i class="fa fa-feed"></i>&nbsp;Seguir&nbsp;
      <strong><?php echo $_smarty_tpl->tpl_vars['question']->value['numberFollowers'];?>
</strong>
    </button>
  </div>
  <div class="button-group small">
    <button class="ink-button black">
      <i class="fa fa-thumbs-up"></i>&nbsp;Gosto&nbsp;
      <strong><?php echo $_smarty_tpl->tpl_vars['question']->value['votosPositivos'];?>
</strong>
    </button>
    <button class="ink-button black">
      <i class="fa fa-thumbs-down"></i>&nbsp;Não gosto&nbsp;
      <strong><?php echo $_smarty_tpl->tpl_vars['question']->value['votosNegativos'];?>
</strong>
    </button>
  </div>
</div>
</article>
<?php if (!$_smarty_tpl->tpl_vars['question']->last) {?>
  <hr>
<?php }?><?php }} ?>
