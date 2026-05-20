<?php
class Database {
    private $host = "localhost";
    private $dbname = "peersync";
    private $username = "root";
    private $password = "";
    public function connect() {
        try {
            $conn = new PDO("mysql:host={$this->host};dbname={$this->dbname}",$this->username,$this->password);
            return $conn;
        } catch (PDOException $e) {
            echo "Connection failed : " . $e->getMessage();
            return null;
        }
    }
}