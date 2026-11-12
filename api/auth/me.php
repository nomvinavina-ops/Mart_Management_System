<?php
require_once __DIR__.'/../../config/bootstrap.php';
if(empty($_SESSION['user'])) jsonResponse(false,'Not logged in.',[],401);
jsonResponse(true,'',$_SESSION['user']);
