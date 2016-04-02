<?
  require_once(__DIR__ . '/template/header_editor.php');
  require_once(__DIR__ . '/template/navigation.php');
?>

<div class="ink-grid column-group half-top-padding">


<!-- PERGUNTA: formulário -->
<form action="actions/action_create_event.php" method="post" enctype="multipart/form-data" class="ink-form ink-formvalidator all-60 medium-60 small-100 tiny-100">
<fieldset>
<legend class="align-center">Fazer Pergunta</legend>


<!-- PERGUNTA: titulo -->
<div class="control-group column-group quarter-gutters">
  <label for="question" class="all-20 small-25 tiny-25 align-right">Pergunta:</label>
  <div class="control all-80 small-75 tiny-75">
    <input name="question" id="question" type="text" data-rules="required|text[true,true]" placeholder="Por favor escreva a sua pergunta aqui...">
  </div>
</div>


<!-- PERGUNTA: categorias -->
<div class="control-group column-group quarter-gutters">
  <label for="location" class="all-20 small-25 tiny-25 align-right">Categoria:</label>
  <div class="control append-symbol all-80 small-75 tiny-75">
    <select data-rules="required">
      <option>--> Por favor escolha uma opção...</option>
      <optgroup label="Faculdade de Ciências">
        <option>Arquitectura Paisagista</option>
        <option>Astronomia</option>
        <option>Biologia</option>
        <option>Bioquímica</option>
        <option>Ciências de Computadores</option>
        <option>Ciências de Engenharia</option>
        <option>Ciências do Ambiente</option>
        <option>Engenharia Física</option>
        <option>Engenharia de Redes</option>
        <option>Física</option>
        <option>Geologia</option>
        <option>Matemática</option>
        <option>Química</option>
      </optgroup>
      <optgroup label="Faculdade de Desporto">
        <option>Ciências do Desporto</option>
        <option>Educação Física</option>
        <option>Fisioterapia</option>
        <option>Gerontologia</option>
        <option>Gestão Desportiva</option>
      </optgroup>
      <optgroup label="Faculdade de Direito">
        <option>Ciências Forenses</option>
        <option>Criminologia</option>
        <option>Direito</option>
      </optgroup>
      <optgroup label="Faculdade de Engenharia">
        <option>Bioengenharia</option>
        <option>Engenharia Ambiente</option>
        <option>Engenharia Civil</option>
        <option>Engenharia Eletrotécnica</option>
        <option>Engenharia Informática</option>
        <option>Engenharia Industrial e Gestão</option>
        <option>Engenharia Mecânica</option>
        <option>Engenharia Metalúrgica</option>
        <option>Engenharia Química</option>
      </optgroup>
      <optgroup label="Faculdade de Farmárcia">
        <option>Ciências Farmacêuticas</option>
        <option>Química Farmacêutica</option>
        <option>Tecnologia Farmacêutica</option>
      </optgroup>
      <optgroup label="Faculdade de Letras">
        <option>Arqueologia</option>
        <option>Ciência da Informação</option>
        <option>Ciências da Comunicação</option>
        <option>Ciências da Linguagem</option>
        <option>Estudos Portugueses</option>
        <option>Filosofia</option>
        <option>Geografia</option>
        <option>História</option>
        <option>História da Arte</option>
      </optgroup>
      <optgroup label="Faculdade de Medicina">s
        <option>Anatomia</option>
        <option>Cirurgias</option>
        <option>Cuidados Paliativos</option>
        <option>Epidemologia</option>
        <option>Neurobiologia</option>
        <option>Psiquiatria</option>
      </optgroup>
    </select>
  </div>
</div>


<!-- PERGUNTA: mensagem -->
<div class="control-group column-group quarter-gutters">
  <label for="text" class="all-20 small-25 tiny-25 align-right">Mensagem:</label>
  <div class="control all-80 small-75 tiny-75">
    <textarea name="text" id="text" rows="8" cols="60">
    </textarea>
  </div>
</div>


<!-- PERGUNTA: button group -->
<div class="control-group column-group quarter-gutters">
  <div class="align-center">
    <button class="ink-button medium black" type="submit">
    <i class="fa fa-check"></i>&nbsp;Submeter
    </button>
    <button class="ink-button medium black" type="reset">
      <i class="fa fa-eraser"></i>&nbsp;Limpar
    </button>
  </div>
</div>
</fieldset>
</form>


<!-- PERGUNTA: regras -->
<div class="column-group padding all-40 small-100 tiny-100">
  <b>Normas de utilização:</b>
  <ul class="half-vertical-space">
  <li>O cuidado em identificar pontos críticos na necessidade de renovação processual prepara-nos para enfrentar situações atípicas decorrentes do sistema de participação geral.</li>
  <li>Por outro lado, a estrutura atual da organização auxilia a preparação e a composição dos procedimentos normalmente adotados.</li>
  <li>A nível organizacional, o desafiador cenário globalizado garante a contribuição de um grupo importante na determinação das novas proposições.</li>
  <li>A prática cotidiana prova que o desenvolvimento contínuo de distintas formas de atuação nos obriga à análise de alternativas às soluções ortodoxas.</li>
  </ul>
  <div class="control-group quarter-gutters">
    <div class="control required">
      <input id="terms" name="terms" type="checkbox" class="ink-button medium black" type="reset" value="" >
      <label for="terms">Aceito as normas de utilização deste serviço</label>
    </div>
  </div>
</div>
</div>

<?
  require_once(__DIR__ . '/template/footer.php');
?>