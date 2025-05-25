<?php
$servidor = "sql303.infinityfree.com";
$usuario = "if0_39076415";
$senha = "gks0ftware";
$banco = "if0_39076415_vidracaria";

$conn = new mysqli($servidor, $usuario, $senha, $banco);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}
?>
