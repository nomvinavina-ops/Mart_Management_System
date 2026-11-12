<?php
declare(strict_types=1);

/** Data access class for SaleDetail. Add domain-specific queries here as the module grows. */
final class SaleDetail {
    public function __construct(private PDO $db) {}
}
