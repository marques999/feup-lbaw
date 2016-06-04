<input type="hidden" id="idInstituicao" name="idInstituicao" value="{$instituicao.idinstituicao}">
<div class="control-group required column-group half-gutters">
  <label for="nome" class="all-15 align-right">Nome:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="nome" name="nome" value="{$instituicao.nome}" data-rules="required|text[true,false]">
    <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>
<div class="control-group required column-group half-gutters">
  <label for="sigla" class="all-15 align-right">Sigla:</label>
  <div class="control all-30">
    <input type="text" id="sigla" name="sigla" value="{$instituicao.sigla}" data-rules="required|alpha">
  </div>
  <label for="contacto" class="all-10 align-right">Contacto:</label>
  <div class="control all-45">
    <input type="text" id="contacto" name="contacto" value="{$instituicao.contacto}" data-rules="required|phone[PT]">
  </div>
</div>
<div class="control-group required column-group half-gutters">
  <label for="morada" class="all-15 align-right">Morada:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="morada" name="morada" value="{$instituicao.morada}" data-rules="required|text[true,true]">
    <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>
<div class="control-group required column-group half-gutters">
  <label for="website" class="all-15 align-right">Website:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="website" name="website" value="{$instituicao.website}" data-rules="required|url[true]">
    <i class="fa fa-globe"></i>
    </span>
  </div>
</div>
<div class="column control align-center all-100">
  <button class="ink-button" type="submit">Submeter</button>
  <button class="ink-button" onclick="history.go(-1)" type="reset">Cancelar</button>
</div>