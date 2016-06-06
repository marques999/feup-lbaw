<div class="message hoverable">
  <a class="condensed black"
     href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
  <span class="action-buttons push-right" data-target="{$categoria.idcategoria}">
    <a class="black medium ink-tooltip edit-button"
       data-tip-text="Editar categoria"
       data-tip-where="up"
       data-tip-color="black"
       id="update-category">
    <i class="fa fa-fw fa-pencil"></i>
  </a>
  <a class="black medium ink-tooltip delete-button"
      data-tip-text="Apagar categoria"
      data-tip-where="up"
      data-tip-color="black"
      id="delete-category">
    <i class="fa fa-fw fa-close"></i>
  </a>
  </span>
  <span class="category-information push-right">
    <span>{$categoria.numeroperguntas}</span>
    <i class="fa fa-fw fa-question-circle"></i>
  </span>
</div>