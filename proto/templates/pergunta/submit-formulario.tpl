<div class="control-group gutters">
  <label for="titulo" class="condensed">
    <strong>Pergunta</strong>
  </label>
  <div class="control medium">
    {if $FORM_VALUES.titulo}
     <input name="titulo" id="titulo"
            type="text" data-rules="required|text[true,true]"
            value="{$FORM_VALUES.titulo}"
            placeholder="Por favor escreva a sua pergunta aqui...">
    {elseif $pergunta.titulo}
    <input name="titulo" id="titulo"
           type="text" data-rules="required|text[true,true]"
           value="{$pergunta.titulo}"
           placeholder="Por favor escreva a sua pergunta aqui...">
    {else}
    <input name="titulo" id="titulo"
           type="text" data-rules="required|text[true,true]"
           placeholder="Por favor escreva a sua pergunta aqui...">
    {/if}
  </div>
</div>
<div class="control-group gutters">
  <label for="categoria" class="condensed">
    <strong>Categoria</strong>
  </label>
  <div class="control medium append-symbol">
    <select name="categoria" id="categoria" data-rules="required">
      {foreach $select as $this}
        <optgroup label="{$this.sigla|upper}">
        {foreach $this.json as $categoria}
          {if $categoria.idcategoria eq $FORM_VALUES.idcategoria}
          <option label="{$categoria.nome}" value="{$categoria.idcategoria}" selected>{$categoria.nome}</option>
          {else if ($categoria.idcategoria eq $idCategoria) or ($categoria.idcategoria eq $pergunta.idcategoria)}
          <option label="{$categoria.nome}" value="{$categoria.idcategoria}" selected>{$categoria.nome}</option>
          {else}
          <option label="{$categoria.nome}" value="{$categoria.idcategoria}">{$categoria.nome}</option>
          {/if}
        {/foreach}
        </optgroup>
      {/foreach}
    </select>
  </div>
</div>
<div class="control-group gutters">
  <label for="descricao" class="condensed">
    <strong>Descrição</strong>
  </label>
  <div class="control medium">
    {strip}
    <textarea name="descricao" id="descricao" rows="8" cols="60">
      {if $FORM_VALUES.descricao}
        {$FORM_VALUES.descricao}
      {elseif $pergunta.descricao}
        {$pergunta.descricao}
      {/if}
    </textarea>
    {/strip}
  </div>
</div>
<div class="control-group push-right">
  <div class="button-group">
    <button class="ink-button medium green" type="submit">
      <i class="fa fa-check"></i>
      <span>Submeter</span>
    </button>
    <button class="ink-button medium red" onclick="history.go(-1)" type="reset">
      <i class="fa fa-close"></i>
      <span>Cancelar</span>
    </button>
  </div>
</div>