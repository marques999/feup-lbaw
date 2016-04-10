{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
{include file='common/page-fullscreen.tpl'}
{include file='common/sidebar-hub.tpl'}
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <div class="column-group quarter-gutters message half-bottom-space">
    <div class="column all-75 medium-65 quarter-padding-padding">
      <h4 class="quarter-vertical-space slab">{$instituicao.nome}</h4>
      <p><i class="fa fa-institution"></i>
        {$instituicao.sigla|upper}
      </p>
      <p class="medium quarter-vertical-space">
        <strong>Morada:</strong>
        <addr>{$instituicao.morada}</addr>
      </p>
      <p class="medium quarter-vertical-space">
        <strong>Telefone:</strong>
        {$instituicao.contacto}
      </p>
    </div>
      <div class="column all-25 medium-35 quarter-padding">
      <img src="{$BASE_DIR}images/hub/{$instituicao.sigla}.jpg" alt="">
    </div>
  </div>
  {foreach $questions as $question}
    {include file='questions/list.tpl'}
  {/foreach}
</div>
{include file='common/footer.tpl'}