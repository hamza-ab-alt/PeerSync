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
    public function findByEmail(string $email): ?User {
        $query = "SELECT * FROM users WHERE email = :email LIMIT 1";
        $stmt = $this->db->prepare($query);
        $stmt->execute([':email' => $email]);

        $row = $stmt->fetch();
        if (!$row) {
            return null; // Ila l-email makaynx
        }

        // N-rj3ou l-m3loumat 3la xkl Object (User Entity)
        return new User(
            $row['id'],
            $row['nom'],
            $row['prenom'],
            $row['email'],
            $row['password'],
            $row['points'],
            $row['label_role']
        );
    }
}