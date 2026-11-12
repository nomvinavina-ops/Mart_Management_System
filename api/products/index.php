<?php
require_once __DIR__.'/../../config/bootstrap.php';
require_once __DIR__.'/../../controllers/ProductController.php';
$c=new ProductController($pdo);
switch($_SERVER['REQUEST_METHOD']){
    case 'GET': $c->list(); break;
    case 'POST': $c->create(); break;
    case 'PUT': $c->update(); break;
    case 'DELETE': $c->delete(); break;
    default: jsonResponse(false,'Method not allowed.',[],405);
}
