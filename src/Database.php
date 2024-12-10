<?php

namespace App;

use PDO;

class Database
{
    private $connection;
    private $statement;

    public function __construct()
    {

        $dbConfig = require base_path('src/config/database.php');

        $dsn = sprintf(
            'mysql:host=%s;port=%s;dbname=%s;charset=%s',
            $dbConfig['host'],     // 127.0.0.1
            $dbConfig['port'],     // 3306
            $dbConfig['dbname'],   // aleksandar_scandi
            $dbConfig['charset']   // utf8mb4
        );

        try {
            // Create PDO connection with user and password
            $this->connection = new PDO(
                $dsn,
                $dbConfig['user'],        // aleksandar_scandi
                $dbConfig['password'],    // 6v!6W9ym3
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                ]
            );
        } catch (\PDOException $e) {
            // Handle connection errors
            dd('Connection failed: ' . $e->getMessage());
        }
    }


    public function query($query, $params = []): static
    {
        $this->statement = $this->connection->prepare($query);
        $this->statement->execute($params);

        return $this;
    }

    public function get()
    {
        return $this->statement->fetchAll();
    }

    public function fetch()
    {
        return $this->statement->fetch();
    }

    public function fetchOrFail()
    {
        $result = $this->fetch();

        if (!$result) {
            abort();
        }

        return $result;
    }

    public function fetchColumn()
    {
        return $this->statement->fetchColumn();
    }

    public function getLastInsertId()
    {
        return $this->connection->lastInsertId();
    }

    public function beginTransaction()
    {
        return $this->connection->beginTransaction();
    }

    public function commit()
    {
        return $this->connection->commit();
    }

    public function rollback()
    {
        return $this->connection->rollBack();
    }
}