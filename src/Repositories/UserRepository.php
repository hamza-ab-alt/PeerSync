PHP
<?php
// src/Repositories/UserRepository.php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../Entities/user.php';

class UserRepository {
    private PDO $db;