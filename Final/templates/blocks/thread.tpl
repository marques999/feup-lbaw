<tr>
  <td class="fw-700">
    <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
    <div class="half-vertical-padding all-50">
      <p class="no-margin">
        <a href="{$BASE_DIR}pages/users/thread.php?id={$destinatario.idUtilizador}#last-message">{$remetente.primeiroNome} {$destinatario.ultimoNome}</a>
      </p>
      <note class="medium">{$destinatario.nomeInstituicao}</note>
    </div>
  </td>
  <td class="align-center fw-700">6</td>
  <td class="medium">
    <b>{$conversa.titulo}<span class="ink-badge black">1</span></b>
      <p class="quarter-vertical-space">{$conversa.descricao|nl2br}</p>
  </td>
  <td class="fw-700">
      <i class="fa fa-user"></i>
      <a href="view_profile.php">{$ultimaMensagem.username}</a>
      <p><small>{$ultimaMensagem.dataHora}</small></p>
  </td>
</tr>