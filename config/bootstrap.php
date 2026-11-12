<?php
declare(strict_types=1);

session_start();
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/database.php';

function jsonResponse(bool $success, string $message = '', array $data = [], int $status = 200): never {
    http_response_code($status);
    echo json_encode([
        'success' => $success,
        'message' => $message,
        'data' => $data
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

function requestData(): array {
    $raw = file_get_contents('php://input');
    $json = json_decode($raw ?: '', true);
    if (is_array($json)) return $json;
    return $_POST ?: [];
}

function requireLogin(): array {
    if (empty($_SESSION['user'])) {
        jsonResponse(false, 'Authentication required.', [], 401);
    }
    return $_SESSION['user'];
}

function requireRole(array $roles): array {
    $user = requireLogin();
    if (!in_array($user['role_name'], $roles, true)) {
        jsonResponse(false, 'You do not have permission for this action.', [], 403);
    }
    return $user;
}
