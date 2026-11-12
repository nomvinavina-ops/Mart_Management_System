<?php
require_once __DIR__.'/../../config/bootstrap.php';
require_once __DIR__.'/../../controllers/POSController.php';
(new POSController($pdo))->createSale();
