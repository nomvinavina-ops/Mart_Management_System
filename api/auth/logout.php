<?php
require_once __DIR__.'/../../config/bootstrap.php';
require_once __DIR__.'/../../controllers/AuthController.php';
(new AuthController($pdo))->logout();
