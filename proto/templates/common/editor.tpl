<script type="text/javascript" src="{$BASE_URL}ckeditor/ckeditor.js"></script>
{literal}
<script>
$(function() {
  CKEDITOR.editorConfig = function(config) {
    config.language = 'pt';
    config.height = 400;
    config.toolbarGroups = [
      {name: 'clipboard', groups: ['clipboard', 'undo']},
      {name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing']},
      {name: 'basicstyles', groups: ['basicstyles', 'cleanup']},
      {name: 'links', groups: ['links']},
      {name: 'insert', groups: ['insert']},
      {name: 'forms', groups: ['forms']},
      {name: 'tools', groups: ['tools']},
      {name: 'document', groups: ['mode', 'document', 'doctools']},
      {name: 'others', groups: ['others']},
      {name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph']},
      {name: 'styles', groups: ['styles']},
      {name: 'colors', groups: ['colors']},
      {name: 'about', groups: ['about']}
    ];
    config.extraPlugins = 'blockquote';
    config.removeButtons = 'Underline,Subscript,Superscript,PasteFromWord,PasteText,About,Outdent,Indent,Maximize,Source,Anchor,Scayt';
  };
  CKEDITOR.replace('descricao');
});
</script>
{/literal}