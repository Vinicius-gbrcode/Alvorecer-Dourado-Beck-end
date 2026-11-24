<?php
header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/../conexao.php';

try {
    $stmt = $pdo->query('SELECT id, nome, descricao, imagem, pagina FROM servicos WHERE ativo = 1 ORDER BY id');
    echo json_encode($stmt->fetchAll(), JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['erro' => 'Não foi possível carregar os serviços.']);
}
