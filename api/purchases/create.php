<?php
require_once __DIR__.'/../../config/bootstrap.php';
require_once __DIR__.'/../../controllers/PurchaseController.php';
(new PurchaseController($pdo))->create();
