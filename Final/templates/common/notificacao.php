<?
  $tiposContribuicao = array(
    'nova resposta!'
    'novo comentário!',
    'novo comentario!'
    'melhor resposta',
  );
  $accoesContribuicao = array(
    'respondeu:',
    'comentou:',
    'comentou:',
    'seleccionou a melhor resposta:'
  );
  $linksContribuicao = array(
    'ver resposta',
    'ver pergunta',
    'ver resposta',
    'ver resposta'
  );
  $tipoContribuicao = $tiposContribuicao[$contribuicao->getTipo()];
  $accaoContribuicao = $accaoContribuicao[$contribuicao->getTipo()];
  $linkContribuicao = $linksContribuicao[$contribuicao->getTipo()];
?>
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="<?=$pergunta->getPage()?>"><?=$pergunta->getTitulo()?></a><span class="ink-badge black">$tipoContribuicao</span></b>
    <p class="quarter-vertical-space">
      <strong><?=$contribuicao->getAutor()?> respondeu:</strong>
      <?=$contribuicao->getDescricao()?>
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php"><?=$pergunta->getAutor()?></a>
    <p><small><?=$contribuicao->getData()?></small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>