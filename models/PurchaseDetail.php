<?php
declare(strict_types=1);

/** Data access class for PurchaseDetail. Add domain-specific queries here as the module grows. */
final class PurchaseDetail {
    public function __construct(private PDO $db) {}
}
