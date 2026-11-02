<?php
require_once __DIR__ . '/../helpers/Env.php';
require_once __DIR__ . '/../helpers/Bdd.php';

try {
    $pdo = Bdd::pdo();
} catch (PDOException $e) {
    error_log('database.php : ' . $e->getMessage());
    http_response_code(500);
    die("Erreur de connexion à la base de données.");
}
