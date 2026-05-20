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
