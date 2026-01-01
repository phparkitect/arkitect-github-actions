<?php

namespace App\Infrastructure;

use App\Domain\User;

class UserRepository
{
    private array $users = [];

    public function save(User $user): void
    {
        $this->users[] = $user;
    }

    public function findAll(): array
    {
        return $this->users;
    }
}
