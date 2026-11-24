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
$telefone = trim($_POST['telefone'] ?? '');
$tipoServico = trim($_POST['tipo_servico'] ?? '');
$mensagem = trim($_POST['mensagem'] ?? '');

if ($nome === '' || $telefone === '' || $tipoServico === '' || $mensagem === '') {
    http_response_code(422);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Preencha todos os campos.'
    ]);
    exit;
}

if (
    mb_strlen($nome) > 120 ||
    mb_strlen($telefone) > 30 ||
    mb_strlen($tipoServico) > 80
) {
    http_response_code(422);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Um ou mais campos excedem o tamanho permitido.'
    ]);
    exit;
}

try {
    $sql = 'INSERT INTO orcamentos
            (nome, telefone, tipo_servico, mensagem)
            VALUES (:nome, :telefone, :tipo_servico, :mensagem)';

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        ':nome' => $nome,
        ':telefone' => $telefone,
        ':tipo_servico' => $tipoServico,
        ':mensagem' => $mensagem
    ]);

    $nomeEmail = htmlspecialchars($nome, ENT_QUOTES, 'UTF-8');
    $telefoneEmail = htmlspecialchars($telefone, ENT_QUOTES, 'UTF-8');
    $servicoEmail = htmlspecialchars($tipoServico, ENT_QUOTES, 'UTF-8');
    $mensagemEmail = nl2br(htmlspecialchars($mensagem, ENT_QUOTES, 'UTF-8'));

    $corpoEmail = "
        <h2>Novo pedido de orçamento</h2>
        <p><strong>Nome:</strong> {$nomeEmail}</p>
        <p><strong>Telefone:</strong> {$telefoneEmail}</p>
        <p><strong>Serviço:</strong> {$servicoEmail}</p>
        <p><strong>Mensagem:</strong><br>{$mensagemEmail}</p>
        <hr>
        <p>Enviado pelo site Alvorecer Dourado Pinturas.</p>
    ";

    $emailEnviado = enviarNotificacao(
        'Novo pedido de orçamento - Alvorecer Dourado',
        $corpoEmail
    );

    if (!$emailEnviado) {
        error_log('Orçamento salvo, mas o e-mail de notificação falhou.');
    }

    echo json_encode([
        'sucesso' => true,
        'mensagem' => 'Solicitação enviada com sucesso! Entraremos em contato.',
        'email_enviado' => $emailEnviado
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Erro ao salvar o orçamento. Tente novamente.'
    ]);
}