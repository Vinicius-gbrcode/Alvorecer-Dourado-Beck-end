
<?php

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../conexao.php';
require_once __DIR__ . '/../enviar_email.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Método não permitido.'
    ]);
    exit;
}

$nome = trim($_POST['nome'] ?? '');
$titulo = trim($_POST['titulo'] ?? '');
$texto = trim($_POST['texto'] ?? '');

if ($nome === '' || $titulo === '' || $texto === '') {
    http_response_code(422);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Preencha todos os campos.'
    ]);
    exit;
}

if (
    mb_strlen($nome) > 120 ||
    mb_strlen($titulo) > 150 ||
    mb_strlen($texto) > 2000
) {
    http_response_code(422);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Um ou mais campos excedem o tamanho permitido.'
    ]);
    exit;
}

try {
    $sql = 'INSERT INTO depoimentos (nome, titulo, texto, aprovado)
            VALUES (:nome, :titulo, :texto, 0)';

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        ':nome' => $nome,
        ':titulo' => $titulo,
        ':texto' => $texto
    ]);

    $nomeEmail = htmlspecialchars($nome, ENT_QUOTES, 'UTF-8');
    $tituloEmail = htmlspecialchars($titulo, ENT_QUOTES, 'UTF-8');
    $textoEmail = nl2br(htmlspecialchars($texto, ENT_QUOTES, 'UTF-8'));

    $corpoEmail = "
        <h2>Novo depoimento recebido</h2>
        <p><strong>Nome:</strong> {$nomeEmail}</p>
        <p><strong>Título:</strong> {$tituloEmail}</p>
        <p><strong>Depoimento:</strong><br>{$textoEmail}</p>
        <hr>
        <p>Este depoimento está aguardando aprovação para aparecer no site.</p>
        <p>Alvorecer Dourado Pinturas.</p>
    ";

    $emailEnviado = enviarNotificacao(
        'Novo depoimento recebido - Alvorecer Dourado',
        $corpoEmail
    );

    if (!$emailEnviado) {
        error_log('Depoimento salvo, mas o e-mail de notificação falhou.');
    }

    echo json_encode([
        'sucesso' => true,
        'mensagem' => 'Depoimento recebido! Ele será exibido após aprovação.',
        'email_enviado' => $emailEnviado
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Erro ao salvar o depoimento. Tente novamente.'
    ]);
}