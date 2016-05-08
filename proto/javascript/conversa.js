/*
 * $(document.ready)
 */
$(function(){
  $('a.quote-button').click(function(){
    CKEDITOR.instances.descricao.insertHtml('<blockquote>' +
      $(this).parent().parent().prev().text() + '</blockquote>');
  });
});