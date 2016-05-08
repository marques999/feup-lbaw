var refreshStatus = [];
var answerCommentCount = [];
var lastCommentId = [];

var userFollowsQuestion = false;
var questionRefreshStatus = false;
var questionCommentCount = 0;
var questionCommentId = -1;

/*
 * $(document.ready)
 */
$(function() {
  $("#answers a.ink-toggle").click(function() {
    fetchAnswerComments(
      $(this).data('id'),
      $(this));
  });
  $(".question-action-buttons .follow-button").click(function() {
    followPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id);
  });
  $(".question-vote-buttons .vote-positive").click(function() {
    registarVotoPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      1);
  });
  $(".question-vote-buttons .vote-negative").click(function() {
    registarVotoPergunta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      -1);
  });
  $(".reply-buttons .vote-positive").click(function() {
    registarVotoResposta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
       1);
  });
  $(".reply-buttons .vote-negative").click(function() {
    registarVotoResposta(
      $(this),
      $(this.parentNode.parentNode.parentNode).get(0).id,
      -1);
  });
  $('.question-comments-form').submit(function(event) {
    submeterComentarioPergunta($(this));
    event.preventDefault();
  });
  $('.answer-comments-form').submit(function(event) {
    submeterComentarioResposta($(this));
    event.preventDefault();
  });
});

/*
 * submeterComentarioPergunta(commentsForm)
 */
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
}

/*
 * submeterComentarioResposta(commentsForm)
 */
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

/*
 * fetchVotosPergunta(thisId, domElement)
 */
function fetchVotosPergunta(thisId, domElement)
{
  $.post("../../api/pergunta/get_votes.php",
  {
    idPergunta: thisId
  },
  function(jsonString)
  {
    var jsonObject = JSON.parse(jsonString);
    domElement.find('.vote-positive strong').text(jsonObject['votospositivos']);
    domElement.find('.vote-negative strong').text(jsonObject['votosnegativos']);
  });
};

/*
 * fetchVotosPergunta(thisId, domElement)
 */
function fetchVotosResposta(thisId, domElement)
{
  $.post("../../api/resposta/get_votes.php",
  {
    idResposta: thisId
  },
  function(jsonString)
  {
    var jsonObject = JSON.parse(jsonString);
    domParent.find('.vote-positive strong').text(jsonObject['votospositivos']);
    domParent.find('.vote-negative strong').text(jsonObject['votosnegativos']);
  });
};

/*
 * registarVotoPergunta(domElement, nodeId, valor)
 */
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
      strongTag.html('<i class="fa fa-refresh fa-spin fa-fw"></i>');
    },
    success: function(jsonString)
    {
      if (jsonString !== undefined && jsonString !== 'false')
      {
        var jsonObject = JSON.parse(jsonString);
        var positiveButton =  domParent.find('.vote-positive');
        var negativeButton = domParent.find('.vote-negative');

        if (valor == 1)
        {
          positiveButton.html(nano('<i class="fa fa-thumbs-up fa-fw"></i>\n<span>Gostei&nbsp;</span>\n<strong>{votospositivos}</strong>', jsonObject));
          negativeButton.html(nano('<i class="fa fa-thumbs-down fa-fw"></i>\n<span>Não gosto&nbsp;</span>\n<strong>{votosnegativos}</strong>', jsonObject));
        }
        else if (valor == -1)
        {
          positiveButton.html(nano('<i class="fa fa-thumbs-up fa-fw"></i>\n<span>Gosto&nbsp;</span>\n<strong>{votospositivos}</strong>', jsonObject));
          negativeButton.html(nano('<i class="fa fa-thumbs-down fa-fw"></i>\n<span>Não gostei&nbsp;</span>\n<strong>{votosnegativos}</strong>', jsonObject));
        }
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

/*
 * registarVotoResposta(domElement, nodeId, valor)
 */
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
      strongTag.html('<i class="fa fa-refresh fa-spin fa-fw"></i>');
    },
    success: function(jsonString)
    {
      if (jsonString !== undefined && jsonString !== 'false')
      {
        var jsonObject = JSON.parse(jsonString);
        var positiveButton =  domParent.find('.vote-positive');
        var negativeButton = domParent.find('.vote-negative');

        if (valor == 1)
        {
          positiveButton.html(nano('<i class="fa fa-thumbs-up fa-fw"></i>\n<span>Gostei&nbsp;</span>\n<strong>{votospositivos}</strong>', jsonObject));
          negativeButton.html(nano('<i class="fa fa-thumbs-down fa-fw"></i>\n<span>Não gosto&nbsp;</span>\n<strong>{votosnegativos}</strong>', jsonObject));
        }
        else if (valor == -1)
        {
          positiveButton.html(nano('<i class="fa fa-thumbs-up fa-fw"></i>\n<span>Gosto&nbsp;</span>\n<strong>{votospositivos}</strong>', jsonObject));
          negativeButton.html(nano('<i class="fa fa-thumbs-down fa-fw"></i>\n<span>Não gostei&nbsp;</span>\n<strong>{votosnegativos}</strong>', jsonObject));
        }
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
  if (domElement.hasClass('active'))
  {
    return __unfollowPergunta(domElement, nodeId);
  }
  else
  {
    return __followPergunta(domElement, nodeId);
  }
}

function __updateFollow(booleanValue)
{
  userFollowsQuestion = booleanValue;
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
      strongTag.html('<i class="fa fa-refresh fa-spin fa-fw"></i>');
    },
    success: function(jsonString)
    {
      if (jsonString)
      {
        domElement.html(nano('<i class="fa fa-check fa-fw"></i>\n<span>Following&nbsp;</span>\n<strong>{count}</strong>', JSON.parse(jsonString)));
        domElement.addClass('active');
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
      strongTag.html('<i class="fa fa-refresh fa-spin fa-fw"></i>');
    },
    success: function(jsonString)
    {
      if (jsonString)
      {
        domElement.html(nano('<i class="fa fa-feed fa-fw"></i>\n<span>Follow&nbsp;</span>\n<strong>{count}</strong>', JSON.parse(jsonString)));
        domElement.removeClass('active');
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

/*
 * insertComment(domElement, jsonObject)
 */
function insertComment(domElement, jsonObject) {
  if (jsonObject.removido) {
    domElement.append(nano('<div class="column half-vertical-space"><img class="push-left all-5 img-circle quarter-right-space" src="../../images/avatars/{idutilizador}_small.png" alt="">{nomeutilizador}\n<small>{datahora}</small><p class="fw-medium">{descricao}</p></div>', jsonObject));
  }
  else {
    domElement.append(nano('<div class="column half-vertical-space"><img class="push-left all-5 img-circle quarter-right-space" src="../../images/avatars/{idutilizador}_small.png" alt=""><a href="../utilizador/profile.php?id={idutilizador}">{nomeutilizador}</a>\n<small>{datahora}</small><p class="fw-medium">{descricao}</p></div>', jsonObject));
  }
};

/*
 * getAnswerTarget(answerId)
 */
function getAnswerTarget(answerId) {
  return '#reply' + answerId + '-comments';
}

/*
 * fetchQuestionComments(idPergunta)
 */
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
      parentNode = currentNode.parent().append('<i class="fa fa-spinner fa-spin fa-fw"></i>');
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

/*
 * fetchAnswerComments(idResposta)
 */
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
      parentNode = currentNode.parent().append('<i class="fa fa-spinner fa-spin fa-fw"></i>');
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

/*
 * refreshQuestionComments(thisId, currentNode)
 */
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
      buttonTag.html('<i class="fa fa-spinner fa-spin fa-fw"></i>');
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

/*
 * refreshAnswerComments(thisId, currentNode)
 */
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
      buttonTag.html('<i class="fa fa-spinner fa-spin fa-fw"></i>');
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

/*
 * printAnswerComments(idResposta, jsonObject)
 */
function printAnswerComments(idResposta, jsonObject) {

  if (jsonObject.length < 1) {
    refreshStatus[idResposta] = true;
  }

  if (refreshStatus[idResposta]) {
    return;
  }

  var domElement = $(getAnswerTarget(idResposta));

  if (domElement.is(":visible")) {

    for (var i = 0; i < jsonObject.length; i++) {
      insertComment(domElement, jsonObject[i]);
      answerCommentCount[idResposta]++;
    }

    lastCommentId[idResposta] = jsonObject[jsonObject.length - 1].idcomentario;
    refreshStatus[idResposta] = true;
  }
};

/*
 * printQuestionComments(idPegunta, jsonObject)
 */
function printQuestionComments(idPergunta, jsonObject) {

  if (jsonObject.length < 1) {
    questionRefreshStatus = true;
  }

  if (questionRefreshStatus) {
    return;
  }

  var domElement = $('#question-comments');

  if (questionCommentId == -1) {
    domElement.children().not(':first').remove();
  }

  for (var i = 0; i < jsonObject.length; i++) {
    insertComment(domElement, jsonObject[i]);
    questionCommentCount++;
  }

  questionCommentId = jsonObject[jsonObject.length - 1].idcomentario;
  questionRefreshStatus = true;
};