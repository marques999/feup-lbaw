<thead>
  <th>Conversa</th>
  <th>Mensagens</th>
  <th>Última Mensagem</th>
  <th style="width:20%">Autor</th>
</thead>
<tbody>
{foreach $conversas as $conversa}
  {include file='conversa/list-message.tpl'}
{/foreach}
</tbody>