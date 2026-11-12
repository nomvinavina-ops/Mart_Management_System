<?php
require_once __DIR__.'/../../config/bootstrap.php';
require_once __DIR__.'/../../controllers/InventoryController.php';
(new InventoryController($pdo))->list();
