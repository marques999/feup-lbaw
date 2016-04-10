<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:37:42
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/header-chart.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1457785403570913b626af72-70648427%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ee06882bc030a549ae87c43e2bafd5e32097d1cc' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/header-chart.tpl',
      1 => 1460212591,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1457785403570913b626af72-70648427',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'BASE_URL' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_570913b62d8941_58945760',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_570913b62d8941_58945760')) {function content_570913b62d8941_58945760($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&A</title>
<link rel="shortcut icon" href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
images/favicon.ico">
<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/font-roboto.css">
<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/ink.css">
<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/main.css">
<script type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/chart.min.js"></script>
<script type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/chartHelper.js"></script>
<script type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/jquery-2.1.4.min.js"></script>
<script>
var schoolDatabase = {
  "FEUP" : [ 69, 86, 91, 103, 46, 75 ],
  "FCUP" : [ 62, 98, 21, 50,  90, 67 ],
  "FMUP" : [ 70, 45, 27, 15,  32, 91 ],
  "FLUP" : [ 50, 87, 66, 55,  69, 83 ],
  "FDUP" : [ 105, 39, 17, 28, 65, 95 ]
};
var subjectDatabase = {
  "Política" : [ 7, 24, 15, 16, 25, 8],
  "Matemática" : [ 20, 12, 22, 11, 24, 4],
  "Neurobiologia" : [ 6, 23, 10, 4, 8, 13],
  "Engenharia Informática" : [ 26, 6, 15, 24, 14, 3],
  "Geografia" : [15, 3, 18, 26, 11, 24]
}
var userDatabase = [
  {
    username: "marques999",
    numberAnswers: 2,
    numberQuestions: 4,
    numberLogins: 20
  },
  {
    username: "miserioso",
    numberAnswers: 1,
    numberQuestions: 5,
    numberLogins: 41
  },
  {
    username: "mellus",
    numberAnswers: 9,
    numberQuestions: 3,
    numberLogins: 5
  },
  {
    username: "darklord",
    numberAnswers: 4,
    numberQuestions: 2,
    numberLogins: 7
  },
  {
    username: "admin",
    numberAnswers: 2,
    numberQuestions: 1,
    numberLogins: 3
  }
];

$(function() {
  var myPieChart1 = generateQuestionsChart("myChart", userDatabase);
  var myPieChart2 = generateAnswersChart("myChart2", userDatabase);
  var myPieChart3 = generateLoginChat("myChart3", userDatabase);
  var myPieChart4 = generateLineChart("myChart4", subjectDatabase);
  var myPieChart5 = generateLineChart("myChart5", schoolDatabase);
  var pillsDate = $("#pills-date li");
  pillsDate.click(function(){
    pillsDate.removeClass("active");
    $(this).addClass("active");
  });
});
</script>
</head><?php }} ?>
