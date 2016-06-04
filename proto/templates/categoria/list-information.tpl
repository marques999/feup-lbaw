{foreach $categorias as $categoria}
<div class="column all-25 large-33 medium-50 small-50 tiny-100">
  <div class="message hoverable">
    {strip}
    <a class="condensed black" href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">
      {$categoria.nome}
    </a>
    {/strip}
    <span class="push-right">
      <span>{$categoria.numeroperguntas}</span>
      <i class="fa fa-question-circle fa-fw"></i>
    </span>
  </div>
</div>
{/foreach}