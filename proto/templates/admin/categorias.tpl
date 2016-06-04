{extends file='admin/common/pagina.tpl'}
{block name=content}
<div class="column-group half-gutters">
{include file='common/messages.tpl'}
{foreach $categorias as $categoria}
<div class="column all-25 large-33 medium-50 small-50 tiny-100">
  <div class="message hoverable">
    <a class="condensed black" href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
    <span class="action-buttons push-right" data-target="{$categoria.idcategoria}">
      <a class="black medium ink-tooltip edit-button"
         data-tip-text="Editar categoria"
         data-tip-where="up"
         data-tip-color="black"
         id="update-category">
      <i class="fa fa-pencil fa-fw"></i>
    </a>
    <a class="black medium ink-tooltip delete-button"
        data-tip-text="Apagar categoria"
        data-tip-where="up"
        data-tip-color="black"
        id="delete-category">
      <i class="fa fa-close fa-fw"></i>
    </a>
    </span>
    <span class="category-information push-right">
      <span>{$categoria.numeroperguntas}</span>
      <i class="fa fa-question-circle fa-fw"></i>
    </span>
  </div>
</div>
{/foreach}
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/admin-categoria.js"></script>
{/block}