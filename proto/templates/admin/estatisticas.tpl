{extends file='admin/common/pagina_estatisticas.tpl'}
{block name=content}
<div class="column-group half-gutters">
  <div class="column all-33 medium-50 small-100 tiny-100">
    <h4 class="align-center condensed">Mais perguntas (esta semana)</h4>
    <canvas id="myChart" width="500" height="400">
    </canvas>
    <table class="ink-table quarter-vertical-space alternating hover">
      <thead>
        <tr>
          <th style="width:40%">Utilizador</th>
          <th style="width:20%">#Perguntas</th>
          <th style="width:40%">Última Pergunta</th>
        </tr>
      </thead>
      <tbody id="tabela-perguntas" class="align-center">
      </tbody>
    </table>
  </div>
  <div class="column all-33 medium-50 small-100 tiny-100">
    <h4 class="align-center condensed">Mais respostas (esta semana)</h4>
    <canvas id="myChart2" width="500" height="400">
    </canvas>
    <table class="ink-table quarter-vertical-space alternating hover">
      <thead>
        <tr>
          <th style="width:40%">Utilizador</th>
          <th style="width:20%">#Respostas</th>
          <th style="width:40%">Última Resposta</th>
        </tr>
      </thead>
      <tbody id="tabela-respostas" class="align-center">
      </tbody>
    </table>
  </div>
  <div class="column all-33 medium-100 small-100 tiny-100">
    <h4 class="align-center condensed">Menos activos (esta semana)</h4>
    <canvas id="myChart3" width="500" height="400">
    </canvas>
    <table class="ink-table quarter-vertical-space alternating hover">
      <thead>
        <tr>
          <th style="width:40%">Utilizador</th>
          <th style="width:20%">#Sessões</th>
          <th style="width:40%">Última Sessão</th>
        </tr>
      </thead>
      <tbody id="tabela-utilizadores" class="align-center">
      </tbody>
    </table>
  </div>
  <div class="column all-50 small-100 tiny-100 half-vertical-space">
    <h4 class="align-center condensed">Categorias populares</h4>
    <canvas id="myChart4" width="400" height="200">
    </canvas>
    <table class="ink-table quarter-vertical-space alternating hover">
      <thead>
        <tr>
          <th style="width:35%">Categoria</th>
          <th style="width:15%">#Perguntas</th>
          <th style="width:40%">Última Pergunta</th>
        </tr>
      </thead>
      <tbody id="tabela-categorias" class="align-center">
      </tbody>
    </table>
  </div>
  <div class="column all-50 small-100 tiny-100 half-vertical-space">
    <h4 class="align-center condensed">Instituições populares</h4>
    <canvas id="myChart5" width="400" height="200">
    </canvas>
    <table class="ink-table quarter-vertical-space alternating hover">
      <thead>
        <tr>
          <th style="width:30%">Instituição</th>
          <th style="width:20%">#Perguntas</th>
          <th style="width:50%">Última Pergunta</th>
        </tr>
      </thead>
      <tbody id="tabela-instituicoes" class="align-center">
      </tbody>
    </table>
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/estatisticas.js"></script>
{/block}