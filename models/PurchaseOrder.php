<?php
declare(strict_types=1);

/** Data access class for PurchaseOrder. Add domain-specific queries here as the module grows. */
final class PurchaseOrder {
    public function __construct(private PDO $db) {}
}
