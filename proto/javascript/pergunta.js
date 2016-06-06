var refreshStatus = [];
var userVote = 0;
var answerCommentCount = [];
var answerContent = [];
var answerFormEnabled = [];
var lastCommentId = [];

var userFollowsQuestion = false;
var questionRefreshStatus = false;
var questionCommentCount = 0;
var questionCommentId = -1;

$(function()
{
  var answerEditButton = $(".answer-action-buttons .edit-button");
  var questionVotePositive = $(".question-vote-buttons .vote-positive");
  var questionVoteNegative = $(".question-vote-buttons .vote-negative");
  var questionFollowButton = $(".question-action-buttons .follow-button");

  if (questionVotePositive.hasClass('active'))
  {
    userVote = 1;
  }
  else if (questionVoteNegative.hasClass('active'))
  {
    userVote = -1;
  }

  if (questionFollowButton.hasClass('active'))
  {
    userFollowsQuestion = true;
  }

  questionVotePositive.click(function()
  {
    registarVotoPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      1);
  });

  questionVoteNegative.click(function()
  {
    registarVotoPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      -1);
  });

  answerEditButton.click(function()
  {
    editarResposta(
      $(this),
      $(this.parentNode.parentNode.parentNode));
  });

  questionFollowButton.click(function()
  {
    followPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id);
  });

  $("#answers .show-comments").click(function()
  {
    fetchAnswerComments(
      $(this).data('id'),
      $(this));
  });

  $(".reply-buttons .vote-positive").click(function()
  {
    registarVotoResposta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
       1);
  });

  $(".reply-buttons .vote-negative").click(function()
  {
    registarVotoResposta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      -1);
  });

  $('.question-comments-form').submit(function(event)
  {
    submeterComentarioPergunta($(this));
    event.preventDefault();
  });

  $('.answer-comments-form').submit(function(event)
  {
    submeterComentarioResposta($(this));
    event.preventDefault();
  });
});


var answerForm = '<form action="../../actions/resposta/update.php" method="POST" class="ink-form ink-formvalidator">' +
    '<input type="hidden" name="idPergunta" id="idPergunta" value="{idpergunta}">' +
    '<input type="hidden" name="idResposta" id="idResposta" value="{idresposta}">' +
    '<div class="control-group column-group quarter-gutters">'+
      '<div class="control">' +
        '<textarea name="resposta" id="resposta" rows="8" cols="60">{descricao}</textarea>'+
      '</div></div>' +
    '<div class="control-group column-group quarter-gutters">' +
      '<div class="push-right">'+
        '<button class="ink-button submit-button green" type="submit">'+
          '<i class="fa fa-check"></i>\n'+
          '<span>Submeter</span>'+
        '</button><button class="ink-button cancel-button red" type="reset">'+
          '<i class="fa fa-close"></i>\n'+
          '<span>Cancelar</span>'+
        '</button></div></div></form>';

function anularEdicao(parentElement)
{
  var nodeId = parentElement.get(0).id;
  var answerBox = parentElement.find('.answer-content');
  
  if (answerFormEnabled[nodeId]) {

    answerBox.stop(!0, !0).fadeOut(200, function() {

      if (ckeditorInstance != null) {
        ckeditorInstance.destroy();
        ckeditorInstance = null;
      }
    
      answerBox.html(answerContent[nodeId]).fadeIn(200);
      answerContent[nodeId] = null;
      answerFormEnabled[nodeId] = false;
    });
  }
};

function editarResposta(domElement, parentElement)
{
  var nodeId = parentElement.get(0).id;
  var answerBox = parentElement.find('.answer-content');
  
  if (answerFormEnabled[nodeId]) {
    anularEdicao(parentElement);
  }
  else if (ckeditorInstance != null) {
    alert('Por favor termine a edição da resposta anterior antes de editar outra resposta!');
  }
  else {
    
    var myContent = {};
    var nodeQuestion = $('.question-section').get(0).id;
    var previousContent = answerBox.html();
    
    myContent['idpergunta'] = nodeQuestion.substring(nodeQuestion.indexOf('-') + 1, nodeQuestion.length);
    myContent['idresposta'] = nodeId.substring(nodeId.indexOf('-') + 1, nodeId.length);
    myContent['descricao'] = previousContent; 
    answerContent[nodeId] = previousContent;
   
    answerBox.stop(!0, !0).fadeOut(200, function()
    {
      answerBox.html(nano(answerForm, myContent)).fadeIn(200);
      
      answerBox.find('.cancel-button').click(function()
      {
        anularEdicao(parentElement);
      });
  
      ckeditorInstance = CKEDITOR.replace('resposta');
      answerFormEnabled[nodeId] = true;
    });
    
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
  }
};

var ckeditorInstance = null;

function submeterComentarioPergunta(commentsForm)
{
  var thisId = commentsForm.find($("input[name=idPergunta]")).val();

  $.post("../../api/pergunta/insert_comment.php", commentsForm.serialize(), function(jsonResult)
  {
    if (+jsonResult)
    {
      questionRefreshStatus = false;
      refreshQuestionComments(thisId, commentsForm);
    }
  });
};

function submeterComentarioResposta(commentsForm)
{
  var thisId = commentsForm.find($("input[name=idResposta]")).val();

  $.post("../../api/resposta/insert_comment.php", commentsForm.serialize(), function(jsonResult)
  {
    if (+jsonResult)
    {
      refreshStatus[thisId] = false;
      refreshAnswerComments(thisId, commentsForm);
    }
  });
};

var loadingCommentText = '<i class="fa fa-spinner fa-spin fa-fw"></i>';
var loadingVoteText = '<i class="fa fa-refresh fa-spin fa-fw"></i>';
var positiveVoteText = '<i class="fa fa-thumbs-up fa-fw"></i>\n' +
                       '<span>{labelpositive}&nbsp;</span>\n' +
                       '<strong>{votospositivos}</strong>';
var negativeVoteText = '<i class="fa fa-thumbs-down fa-fw"></i>\n' +
                       '<span>{labelnegative}&nbsp;</span>\n' +
                       '<strong>{votosnegativos}</strong>';
var followButtonText = '<i class="fa fa-feed fa-fw"></i>\n' +
                       '<span>Follow&nbsp;</span>\n' +
                       '<strong>{count}</strong>';
var unfollowButtonText = '<i class="fa fa-check fa-fw"></i>\n' +
                         '<span>Following&nbsp;</span>\n' +
                         '<strong>{count}</strong>';
var commentWrapperNoAuthor = '<div class="column half-vertical-space">\n' +
                             '<img class="push-left all-5 img-circle quarter-right-space" ' +
                             'src="../../pages/avatar.php?id={idutilizador}&thumbnail=yes" alt="">\n' +
                             '{nomeutilizador}\n' +
                             '<small>{datahora}</small>\n' +
                             '<p class="fw-medium">{descricao}</p></div>';
var commentWrapper = '<div class="column half-vertical-space">\n' +
                     '<img class="push-left all-5 img-circle quarter-right-space" ' +
                     'src="../../pages/avatar.php?id={idutilizador}&thumbnail=yes" alt="">\n' +
                     '<a href="../utilizador/profile.php?id={idutilizador}">{nomeutilizador}</a>\n' +
                     '<small>{datahora}</small>\n' +
                     '<p class="fw-medium">{descricao}</p></div>';

function registarVotoPergunta(domElement, nodeId, valor)
{
  var domParent = domElement.parent();
  var strongTag = domElement.find('strong');
  var previousCount = strongTag.text();

  $.ajax(
  {
    type: 'POST',
    url: '../../api/pergunta/insert_vote.php',
    data:
    {
      idPergunta: nodeId.substring(nodeId.indexOf('-') + 1, nodeId.length),
      votoUtilizador: valor
    },
    beforeSend: function()
    {
      strongTag.html(loadingVoteText);
    },
    success: function(jsonString)
    {
      if (jsonString !== undefined && jsonString !== 'false')
      {
        var jsonObject = JSON.parse(jsonString);
        var positiveButton =  domParent.find('.vote-positive');
        var negativeButton = domParent.find('.vote-negative');

        jsonObject['labelpositive'] = 'Gosto';
        jsonObject['labelnegative'] = 'Não gosto';

        if (valor == userVote)
        {
          positiveButton.removeClass('active');
          negativeButton.removeClass('active');
          userVote = 0;
        }
        else
        {
          if (valor == 1)
          {
            jsonObject['labelpositive'] = 'Gostei';
            positiveButton.addClass('active');
            negativeButton.removeClass('active');
          }
          else if (valor == -1)
          {
            jsonObject['labelnegative'] = 'Não gostei';
            positiveButton.removeClass('active');
            negativeButton.addClass('active');
          }

          userVote = valor;
        }

        positiveButton.html(nano(positiveVoteText, jsonObject));
        negativeButton.html(nano(negativeVoteText, jsonObject));
      }
      else
      {
        strongTag.text(previousCount);
      }
    },
    error: function()
    {
      strongTag.text(previousCount);
    }
  });
};

function registarVotoResposta(domElement, nodeId, valor)
{
  var domParent = domElement.parent();
  var strongTag = domElement.find('strong');
  var previousCount = strongTag.text();

  $.ajax(
  {
    type: 'POST',
    url: '../../api/resposta/insert_vote.php',
    data:
    {
      idResposta: nodeId.substring(nodeId.indexOf('-') + 1, nodeId.length),
      votoUtilizador: valor
    },
    beforeSend: function()
    {
      strongTag.html(loadingVoteText);
    },
    success: function(jsonString)
    {
      if (jsonString !== undefined && jsonString !== 'false')
      {
        var jsonObject = JSON.parse(jsonString);
        var positiveButton =  domParent.find('.vote-positive');
        var negativeButton = domParent.find('.vote-negative');

        jsonObject['labelpositive'] = 'Gosto';
        jsonObject['labelnegative'] = 'Não gosto';

        if (valor == userVote)
        {
          positiveButton.removeClass('active');
          negativeButton.removeClass('active');
          userVote = 0;
        }
        else
        {
          if (valor == 1)
          {
            jsonObject['labelpositive'] = 'Gostei';
            positiveButton.addClass('active');
            negativeButton.removeClass('active');
          }
          else if (valor == -1)
          {
            jsonObject['labelnegative'] = 'Não gostei';
            positiveButton.removeClass('active');
            negativeButton.addClass('active');
          }

          userVote = valor;
        }

        positiveButton.html(nano(positiveVoteText, jsonObject));
        negativeButton.html(nano(negativeVoteText, jsonObject));
      }
      else
      {
        strongTag.text(previousCount);
      }
    },
    error: function()
    {
      strongTag.text(previousCount);
    }
  });
};

function followPergunta(domElement, nodeId)
{
  if (userFollowsQuestion)
  {
    return __unfollowPergunta(domElement, nodeId);
  }
  else
  {
    return __followPergunta(domElement, nodeId);
  }
}

function __followPergunta(domElement, nodeId)
{
  var strongTag = domElement.find('strong');
  var previousCount = strongTag.text();

  $.ajax(
  {
    type: 'POST',
    url: '../../api/pergunta/follow.php',
    data:
    {
      idPergunta: nodeId.substring(nodeId.indexOf('-') + 1, nodeId.length)
    },
    beforeSend: function()
    {
      strongTag.html(loadingVoteText);
    },
    success: function(jsonString)
    {
      if (jsonString)
      {
        domElement.html(nano(unfollowButtonText, JSON.parse(jsonString))).addClass('active');
        userFollowsQuestion = true;
      }
      else
      {
        strongTag.text(previousCount);
      }
    },
    error: function()
    {
      strongTag.text(previousCount);
    }
  });
}

function __unfollowPergunta(domElement, nodeId)
{
  var strongTag = domElement.find('strong');
  var previousCount = strongTag.text();

  $.ajax(
  {
    type: 'POST',
    url: '../../api/pergunta/unfollow.php',
    data:
    {
      idPergunta: nodeId.substring(nodeId.indexOf('-') + 1, nodeId.length)
    },
    beforeSend: function()
    {
      strongTag.html(loadingVoteText);
    },
    success: function(jsonString)
    {
      if (jsonString)
      {
        domElement.html(nano(followButtonText, JSON.parse(jsonString))).removeClass('active');
        userFollowsQuestion = false;
      }
      else
      {
        strongTag.text(previousCount);
      }
    },
    error: function()
    {
      strongTag.text(previousCount);
    }
  });
}

function insertComment(domElement, jsonObject)
{
  domElement.append(nano(
    jsonObject.removido ? commentWrapperNoAuthor : commentWrapper,
    jsonObject)
  );
};

function getAnswerTarget(answerId)
{
  return '#reply' + answerId + '-comments';
}

function fetchQuestionComments(thisId, currentNode)
{
  if (refreshStatus[thisId])
  {
    return;
  }

  parentNode = null;
  nodeContent = null;

  $.ajax(
  {
    type: 'POST',
    url: '../../api/pergunta/get_comments.php',
    data:
    {
      idPergunta: thisId,
      ultimoComentario: questionCommentId
    },
    beforeSend: function()
    {
      parentNode = currentNode.parent().append(loadingCommentText);
      nodeContent = currentNode.detach();
    },
    success: function(jsonString)
    {
      parentNode.children().last().remove();
      parentNode.append(nodeContent);

      if (jsonString)
      {
        var jsonObject = JSON.parse(jsonString);

        if (questionCommentId == -1 && jsonObject.length > 0)
        {
          domElement.find('small').remove();
        }

        printQuestionComments(thisId, jsonObject);
      }
    }
  });
};

function fetchAnswerComments(thisId, currentNode)
{
  if (refreshStatus[thisId])
  {
    return;
  }

  var parentNode = null;
  var nodeContent = null;
  var emptyComments = (lastCommentId[thisId] == undefined);
  var domElement = $(getAnswerTarget(thisId));

  if (emptyComments)
  {
    refreshStatus[thisId] = false;
    answerCommentCount[thisId] = 0;
    lastCommentId[thisId] = -1;
  }

  $.ajax(
  {
    type: 'POST',
    url: '../../api/resposta/get_comments.php',
    data:
    {
      idResposta: thisId,
      ultimoComentario: lastCommentId[thisId]
    },
    beforeSend: function()
    {
      parentNode = currentNode.parent().append(loadingCommentText);
      nodeContent = currentNode.detach();
    },
    success: function(jsonString)
    {
      parentNode.children().last().remove();
      parentNode.append(nodeContent);

      if (jsonString)
      {
        var jsonObject = JSON.parse(jsonString);

        if (emptyComments && jsonObject.length > 0)
        {
          domElement.find('small').remove();
        }

        printAnswerComments(thisId, JSON.parse(jsonString));
      }
    }
  });
};

function refreshQuestionComments(thisId, currentNode)
{
  var buttonTag = currentNode.find('button#submit');
  var commentsTag = currentNode.parent().parent().find('#show-comments strong');

  $.ajax(
  {
    type: 'POST',
    url: '../../api/pergunta/get_comments.php',
    data:
    {
      idPergunta: thisId,
      ultimoComentario: questionCommentId
    },
    beforeSend: function()
    {
      buttonTag.html(loadingCommentText);
    },
    success: function(jsonString)
    {
      buttonTag.html('Submeter');

      if (jsonString)
      {
        printQuestionComments(thisId, JSON.parse(jsonString));
        commentsTag.text(questionCommentCount);
      }
    }
  });
};

function refreshAnswerComments(thisId, currentNode)
{
  var buttonTag = currentNode.find('button#submit');
  var commentsTag = currentNode.parent().parent().find('.show-comments strong');

  $.ajax(
  {
    type: 'POST',
    url: '../../api/resposta/get_comments.php',
    data:
    {
      idResposta: thisId,
      ultimoComentario: lastCommentId[thisId]
    },
    beforeSend: function()
    {
      buttonTag.html(loadingCommentText);
    },
    success: function(jsonString)
    {
      buttonTag.html('Submeter');

      if (jsonString)
      {
        printAnswerComments(thisId, JSON.parse(jsonString));
        commentsTag.text(answerCommentCount[thisId]);
      }
    }
  });
};

function printAnswerComments(idResposta, jsonObject)
{
  if (jsonObject.length < 1)
  {
    refreshStatus[idResposta] = true;
  }

  if (refreshStatus[idResposta])
  {
    return;
  }

  var domElement = $(getAnswerTarget(idResposta));

  if (domElement.is(":visible"))
  {
    for (var i = 0; i < jsonObject.length; i++)
    {
      insertComment(domElement, jsonObject[i]);
      answerCommentCount[idResposta]++;
    }

    lastCommentId[idResposta] = jsonObject[jsonObject.length - 1]['idcontribuicao'];
    refreshStatus[idResposta] = true;
  }
};

function printQuestionComments(idPergunta, jsonObject)
{
  if (jsonObject.length < 1)
  {
    questionRefreshStatus = true;
  }

  if (questionRefreshStatus)
  {
    return;
  }

  var domElement = $('#question-comments');

  if (questionCommentId == -1)
  {
    domElement.children().not(':first').remove();
  }

  for (var i = 0; i < jsonObject.length; i++)
  {
    insertComment(domElement, jsonObject[i]);
    questionCommentCount++;
  }

  questionCommentId = jsonObject[jsonObject.length - 1]['idcontribuicao'];
  questionRefreshStatus = true;
};