<h5 class="slab quarter-vertical-space">Respostas ({$respostas_count})</h5>
{if $respostas_count gt 0}
<table id="answers" class="ink-table alternating hover">
  <thead>
    <tr>
      <th style="width:80%">Conteúdo</th>
      <th style="width:20%">Pontuação</th>
    </tr>
  </thead>
  <tbody>
  {foreach $respostas as $resposta}
    <tr>
      <td class="medium">
        {strip}
        <h5 class="quarter-vertical-space">
          <a class="black"
             href="{$BASE_URL}pages/pergunta/view.php?id={$resposta.idpergunta}#reply-{$resposta.idresposta}">
            {$resposta.titulo}
          </a>
        </h5>
        {/strip}
        <small>
          {$resposta.datahora|date_format:"%A, %e %B %Y %H:%M"}
        </small>
        <p class="quarter-vertical-space">
        {if $resposta.descricao}
          {$resposta.descricao|strip_tags|truncate:210:"...":false:false}
        {else}
          <small>Nenhuma descrição disponível.</small>
        {/if}
        </p>
      </td>
      <td class="align-center">
        {if $resposta.pontuacao gt 0}
        <h3 class="quarter-vertical-space positive-score">{$resposta.pontuacao}</h3>
        {elseif $resposta.pontuacao lt 0}
        <h3 class="quarter-vertical-space negative-score">{$resposta.pontuacao}</h3>
        {else}
        <h3 class="quarter-vertical-space">{$resposta.pontuacao}</h3>
        {/if}
        <p class="medium">
        (
        {$resposta.votospositivos}
        <i class="fa fa-thumbs-up"></i>
        {$resposta.votosnegativos}
        <i class="fa fa-thumbs-down"></i>
        )
        </p>
      </td>
    </tr>
  {/foreach}
  </tbody>
</table>
{else}
<div class="message half-vertical-space">
  <p class="condensed no-margin">Este utilizador ainda não respondeu a nenhuma pergunta :(</p>
</div>
{/if}