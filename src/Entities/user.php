<?php
// src/Entities/user.php

class User {
    private int $id;
    private string $nom;
    private string $prenom;
    private string $email;
    private string $password;
    private int $points;
    private string $label_role;
    public function __construct(int $id, string $nom, string $prenom, string $email, string $password, int $points, string $label_role) {
        $this->id = $id;
        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->email = $email;
        $this->password = $password;
        $this->points = $points;
        $this->label_role = $label_role;
    }
    public function getId(): ?int { return $this->id; }
    public function getNom(): string { return $this->nom; }
    public function getPrenom(): string { return $this->prenom; }
    public function getEmail(): string { return $this->email; }
    public function getPassword(): string { return $this->password; }
    public function getPoints(): int { return $this->points; }
    public function getLabelRole(): string { return $this->label_role; }
}
