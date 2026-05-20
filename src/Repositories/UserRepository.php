PHP
<?php
// src/Repositories/UserRepository.php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../Entities/user.php';

class UserRepository {
    private PDO $db;
    public function __construct() {
        // N-khdmo b la classe Database li saubti
        $database = new Database();
        $this->db = $database->connect();
    }