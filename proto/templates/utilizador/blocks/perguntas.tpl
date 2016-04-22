<h5 class="slab quarter-vertical-space">Perguntas ({$perguntas|@count})</h5>
{if $perguntas|@count gt 0}
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th style="width:80%"></th>
      <th style="width:20%"></th>
    </tr>
  </thead>
  <tbody>
  {foreach $perguntas as $pergunta}
    <tr>
      <td class="medium">
        <h5 class="quarter-vertical-space">
          <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$pergunta.idpergunta}">{$pergunta.titulo}</a>
        </h5>
        <small>{$pergunta.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
        <p class="quarter-vertical-space">{$pergunta.descricao|strip_tags|truncate:210:"...":false:false}</p>
      </td>
      <td class="align-center">
        {if $pergunta.pontuacao gt 0}
        <h3 class="quarter-vertical-space positive-score">{$pergunta.pontuacao}</h3>
        {elseif $pergunta.pontuacao lt 0}
        <h3 class="quarter-vertical-space negative-score">{$pergunta.pontuacao}</h3>
        {else}
        <h3 class="quarter-vertical-space">{$pergunta.pontuacao}</h3>
        {/if}
        <p class="medium">
        (
        {$pergunta.votospositivos}
        <i class="fa fa-thumbs-up"></i>
        {$pergunta.votosnegativos}
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
  <p class="condensed no-margin">Este utilizador ainda não publicou nenhuma pergunta :(</p>
</div>
{/if}