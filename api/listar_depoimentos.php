<?php
header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/../conexao.php';

try {
    $stmt = $pdo->query('SELECT id, nome, titulo, texto FROM depoimentos WHERE aprovado = 1 ORDER BY criado_em DESC, id DESC');
    echo json_encode($stmt->fetchAll(), JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['erro' => 'Não foi possível carregar os depoimentos.']);
}
