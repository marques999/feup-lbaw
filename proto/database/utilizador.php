<?
function utilizador_isAdministrator($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Administrador WHERE idAdministrador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return ($result && is_array($result) && $result['idadministrador'] == $idUtilizador);
}
function utilizador_isModerator($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Moderador WHERE idModerador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return ($result && is_array($result) && $result['idmoderador'] == $idUtilizador);
}
function utilizador_validateLogin($username, $password) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Utilizador WHERE username = :username');
  $stmt->bindParam(':username', $username, PDO::PARAM_STR);
  $stmt->execute();
  $result = $stmt->fetch();
  if ($result && is_array($result)) {
    $generatedHash = $result['password'];
    if (validate_password($password, $generatedHash)) {
        return $result['idutilizador'];
    }
  }
  return 0;
}
function utilizador_delete($idUtilizador) {
  global $db;
  $stmt = $db->prepare('UPDATE Utilizador SET removido = TRUE WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_ban($idUtilizador) {
  global $db;
  $stmt = $db->prepare('UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_fetchInstituicao($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT idInstituicao, sigla
    FROM Utilizador
    LEFT JOIN Instituicao USING (idInstituicao)
    WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function utilizador_fetchThreads($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Conversa.idConversa,
      Conversa.titulo,
      (CASE WHEN :idUtilizador = idUtilizador1 THEN ultimoAcesso1 ELSE ultimoAcesso2 END) AS ultimoacesso,
      Utilizador.idUtilizador AS iddestinatario,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomedestinatario,
      Instituicao.sigla,
      (SELECT COUNT(*) FROM Mensagem WHERE Mensagem.idConversa = Conversa.idConversa) AS numeromensagens,
      Mensagem1.idAutor AS idautor,
      AutorMensagem.username AS nomeautor,
      AutorMensagem.removido,
      Mensagem1.descricao,
      Mensagem1.dataHora
    FROM Conversa
    JOIN Utilizador ON Utilizador.idUtilizador = (CASE WHEN :idUtilizador = idUtilizador1
    THEN idUtilizador2 ELSE idUtilizador1 END)
    JOIN Mensagem Mensagem1 ON Mensagem1.idConversa = Conversa.idConversa
    LEFT OUTER JOIN Mensagem Mensagem2 ON (Mensagem2.idConversa = Conversa.idConversa
    AND Mensagem1.dataHora < Mensagem2.dataHora OR Mensagem1.dataHora = Mensagem2.dataHora
    AND Mensagem1.idMensagem < Mensagem2.idMensagem)
    JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem1.idAutor
    JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
    WHERE (idUtilizador1 = :idUtilizador OR idUtilizador2 = :idUtilizador)
    AND Mensagem2.idMensagem IS NULL");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
  }
function utilizador_getById($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' '  || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.idInstituicao,
      Instituicao.sigla,
      Instituicao.website,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.dataRegisto,
      Utilizador.ultimaSessao,
      Utilizador.ativo,
      Utilizador.removido,
    (SELECT COUNT(*) FROM Pergunta
    WHERE Pergunta.idAutor = idUtilizador) AS numeroperguntas,
    (SELECT COUNT(*) FROM Resposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    AND Contribuicao.idAutor = idUtilizador) AS numerorespostas
    FROM Utilizador
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE Utilizador.idUtilizador = :idUtilizador;");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function resposta_listByAuthor($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT Resposta.idResposta,
      Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.ativa,
      Contribuicao.descricao,
      Contribuicao.dataHora,
      Resposta.melhorResposta,
      COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
    FROM Contribuicao
    JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    JOIN Pergunta ON Pergunta.idPergunta = Resposta.idPergunta
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    LEFT JOIN VotoResposta USING(idResposta)
    WHERE Contribuicao.idAutor = :idUtilizador
    GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
    ORDER BY Contribuicao.dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function utilizador_listarActivos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
    FROM Utilizador
    NATURAL LEFT JOIN Instituicao
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Pergunta
      GROUP BY idAutor)
      AS TabelaPerguntas
      USING(idUtilizador)
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Resposta
      JOIN Contribuicao
      ON Contribuicao.idContribuicao = Resposta.idResposta
      GROUP BY idAutor)
      AS TabelaRespostas
      USING(idUtilizador)
    WHERE Utilizador.ativo AND NOT Utilizador.removido
    AND Utilizador.idUtilizador <> 1
    ORDER BY Utilizador.idUtilizador");
  return $stmt->fetchAll();
}
function utilizador_listarBanidos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
    FROM Utilizador
    NATURAL LEFT JOIN Instituicao
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Pergunta
      GROUP BY idAutor)
      AS TabelaPerguntas
      USING(idUtilizador)
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Resposta
      JOIN Contribuicao
      ON Contribuicao.idContribuicao = Resposta.idResposta
      GROUP BY idAutor)
      AS TabelaRespostas
      USING(idUtilizador)
    WHERE NOT Utilizador.ativo AND NOT Utilizador.removido
    AND Utilizador.idUtilizador <> 1
    ORDER BY Utilizador.idUtilizador");
  return $stmt->fetchAll();
}
function utilizador_getAvatar($idUtilizador) {
  $avatarLocation = glob("../../images/avatars/{$idUtilizador}.{jpg,jpeg,gif,png}", GLOB_BRACE);
  return $avatarLocation != false ? $avatarLocation[0] : "holder.js/200x200/auto/ink";
}
function utilizador_listarRemovidos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
    FROM Utilizador
    NATURAL LEFT JOIN Instituicao
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Pergunta
      GROUP BY idAutor)
      AS TabelaPerguntas
      USING(idUtilizador)
    LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
      FROM Resposta
      JOIN Contribuicao
      ON Contribuicao.idContribuicao = Resposta.idResposta
      GROUP BY idAutor)
      AS TabelaRespostas
      USING(idUtilizador)
    WHERE Utilizador.removido
    AND Utilizador.idUtilizador <> 1
    ORDER BY Utilizador.idUtilizador");
  return $stmt->fetchAll();
}
$countries = array(
  'af'=>'Afghanistan',
  'al'=>'Albania',
  'dz'=>'Algeria',
  'as'=>'American Samoa',
  'ad'=>'Andorra',
  'ao'=>'Angola',
  'ai'=>'Anguilla',
  'ag'=>'Antigua and Barbuda',
  'ar'=>'Argentina',
  'am'=>'Armenia',
  'aw'=>'Aruba',
  'au'=>'Australia',
  'at'=>'Austria',
  'az'=>'Azerbaijan',
  'bs'=>'Bahamas',
  'bh'=>'Bahrain',
  'bd'=>'Bangladesh',
  'bb'=>'Barbados',
  'by'=>'Belarus',
  'be'=>'Belgium',
  'bz'=>'Belize',
  'bj'=>'Benin',
  'bm'=>'Bermuda',
  'bt'=>'Bhutan',
  'bo'=>'Bolivia',
  'ba'=>'Bosnia and Herzegovina',
  'bw'=>'Botswana',
  'bv'=>'Bouvet Island',
  'br'=>'Brazil',
  'io'=>'British Indian Ocean Territory',
  'bn'=>'Brunei Darussalam',
  'bg'=>'Bulgaria',
  'bf'=>'Burkina Faso',
  'bi'=>'Burundi',
  'kh'=>'Cambodia',
  'cm'=>'Cameroon',
  'ca'=>'Canada',
  'cv'=>'Cape Verde',
  'ky'=>'Cayman Islands',
  'cf'=>'Central African Republic',
  'td'=>'Chad',
  'cl'=>'Chile',
  'cn'=>'China',
  'co'=>'Colombia',
  'km'=>'Comoros',
  'cg'=>'Congo',
  'cd'=>'Congo, the Democratic Republic of the',
  'ck'=>'Cook Islands',
  'cr'=>'Costa Rica',
  'ci'=>'Côte d\'Ivoire',
  'hr'=>'Croatia',
  'cu'=>'Cuba',
  'cw'=>'Curaçao',
  'cy'=>'Cyprus',
  'cz'=>'Czech Republic',
  'dk'=>'Denmark',
  'dj'=>'Djibouti',
  'dm'=>'Dominica',
  'do'=>'Dominican Republic',
  'ec'=>'Ecuador',
  'eg'=>'Egypt',
  'sv'=>'El Salvador',
  'gq'=>'Equatorial Guinea',
  'er'=>'Eritrea',
  'ee'=>'Estonia',
  'et'=>'Ethiopia',
  'fk'=>'Falkland Islands',
  'fo'=>'Faroe Islands',
  'fj'=>'Fiji',
  'fi'=>'Finland',
  'fr'=>'France',
  'gf'=>'French Guiana',
  'pf'=>'French Polynesia',
  'tf'=>'French Southern Territories',
  'ga'=>'Gabon',
  'gm'=>'Gambia',
  'ge'=>'Georgia',
  'de'=>'Germany',
  'gh'=>'Ghana',
  'gi'=>'Gibraltar',
  'gr'=>'Greece',
  'gl'=>'Greenland',
  'gd'=>'Grenada',
  'gp'=>'Guadeloupe',
  'gu'=>'Guam',
  'gt'=>'Guatemala',
  'gg'=>'Guernsey',
  'gn'=>'Guinea',
  'gw'=>'Guinea-Bissau',
  'gy'=>'Guyana',
  'ht'=>'Haiti',
  'hm'=>'Heard Island and McDonald Islands',
  'va'=>'Holy See',
  'hn'=>'Honduras',
  'hk'=>'Hong Kong',
  'hu'=>'Hungary',
  'is'=>'Iceland',
  'in'=>'India',
  'id'=>'Indonesia',
  'ir'=>'Iran',
  'iq'=>'Iraq',
  'ie'=>'Ireland',
  'im'=>'Isle of Man',
  'il'=>'Israel',
  'it'=>'Italy',
  'jm'=>'Jamaica',
  'jp'=>'Japan',
  'je'=>'Jersey',
  'jo'=>'Jordan',
  'kz'=>'Kazakhstan',
  'ke'=>'Kenya',
  'ki'=>'Kiribati',
  'kw'=>'Kuwait',
  'kg'=>'Kyrgyzstan',
  'la'=>'Laos',
  'lv'=>'Latvia',
  'lb'=>'Lebanon',
  'ls'=>'Lesotho',
  'lr'=>'Liberia',
  'ly'=>'Libya',
  'li'=>'Liechtenstein',
  'lt'=>'Lithuania',
  'lu'=>'Luxembourg',
  'mo'=>'Macao',
  'mk'=>'Macedonia F.Y.R',
  'mg'=>'Madagascar',
  'mw'=>'Malawi',
  'my'=>'Malaysia',
  'mv'=>'Maldives',
  'ml'=>'Mali',
  'mt'=>'Malta',
  'mh'=>'Marshall Islands',
  'mq'=>'Martinique',
  'mr'=>'Mauritania',
  'mu'=>'Mauritius',
  'yt'=>'Mayotte',
  'mx'=>'Mexico',
  'fm'=>'Micronesia',
  'md'=>'Moldova',
  'mc'=>'Monaco',
  'mn'=>'Mongolia',
  'me'=>'Montenegro',
  'ms'=>'Montserrat',
  'ma'=>'Morocco',
  'mz'=>'Mozambique',
  'mm'=>'Myanmar',
  'na'=>'Namibia',
  'nr'=>'Nauru',
  'np'=>'Nepal',
  'nl'=>'Netherlands',
  'nc'=>'New Caledonia',
  'nz'=>'New Zealand',
  'ni'=>'Nicaragua',
  'ne'=>'Niger',
  'bg'=>'Nigeria',
  'nu'=>'Niue',
  'nf'=>'Norfolk Island',
  'kp'=>'North Korea',
  'mp'=>'Northern Mariana Islands',
  'no'=>'Norway',
  'om'=>'Oman',
  'pk'=>'Pakistan',
  'pw'=>'Palau',
  'ps'=>'Palestine',
  'pa'=>'Panama',
  'pg'=>'Papua New Guinea',
  'py'=>'Paraguay',
  'pe'=>'Peru',
  'ph'=>'Philippines',
  'pn'=>'Pitcairn',
  'pl'=>'Poland',
  'pt'=>'Portugal',
  'pr'=>'Puerto Rico',
  'qa'=>'Qatar',
  're'=>'Réunion',
  'ro'=>'Romania',
  'ru'=>'Russian Federation',
  'rw'=>'Rwanda',
  'sh'=>'Saint Helena',
  'kn'=>'Saint Kitts and Nevis',
  'lc'=>'Saint Lucia',
  'mf'=>'Saint Martin',
  'pm'=>'Saint Pierre and Miquelon',
  'vc'=>'Saint Vincent and the Grenadines',
  'ws'=>'Samoa',
  'sm'=>'San Marino',
  'st'=>'São Tome and Príncipe',
  'sa'=>'Saudi Arabia',
  'sn'=>'Senegal',
  'rs'=>'Serbia',
  'sc'=>'Seychelles',
  'sl'=>'Sierra Leone',
  'sg'=>'Singapore',
  'sx'=>'Sint Maarten',
  'sk'=>'Slovakia',
  'si'=>'Slovenia',
  'sb'=>'Solomon Islands',
  'so'=>'Somalia',
  'za'=>'South Africa',
  'gs'=>'South Georgia and the South Sandwich Islands',
  'kr'=>'South Korea',
  'ss'=>'South Sudan',
  'es'=>'Spain',
  'lk'=>'Sri Lanka',
  'sd'=>'Sudan',
  'sr'=>'Suriname',
  'sz'=>'Swaziland',
  'se'=>'Sweden',
  'ch'=>'Switzerland',
  'sy'=>'Syrian Arab Republic',
  'tw'=>'Taiwan',
  'tj'=>'Tajikistan',
  'tz'=>'Tanzania',
  'th'=>'Thailand',
  'tl'=>'Timor-Leste',
  'tg'=>'Togo',
  'tk'=>'Tokelau',
  'to'=>'Tonga',
  'tt'=>'Trinidad and Tobago',
  'tn'=>'Tunisia',
  'tr'=>'Turkey',
  'tm'=>'Turkmenistan',
  'tc'=>'Turks and Caicos Islands',
  'tv'=>'Tuvalu',
  'ug'=>'Uganda',
  'ua'=>'Ukraine',
  'ae'=>'United Arab Emirates',
  'gb'=>'United Kingdom',
  'us'=>'United States',
  'uy'=>'Uruguay',
  'uz'=>'Uzbekistan',
  'vu'=>'Vanuatu',
  've'=>'Venezuela',
  'vn'=>'Viet Nam',
  'vg'=>'Virgin Islands, British',
  'vi'=>'Virgin Islands, U.S.',
  'wf'=>'Wallis and Futuna',
  'eh'=>'Western Sahara',
  'ye'=>'Yemen',
  'zm'=>'Zambia',
  'zw'=>'Zimbabwe');
  function utilizador_getCountry($id) {
    global $countries;
    return $countries[$id];
  }
?>