<?php
require 'conexao.php';

header('Content-Type: application/json');

try {
  $sql = "
    SELECT o.id, o.nome_arquivo, o.data_hora, o.caminho_arquivo, c.nome AS nome_cliente 
    FROM orcamentos o 
    JOIN clientes c ON o.cliente_id = c.id 
    ORDER BY o.data_hora DESC
  ";

  $result = $conn->query($sql);

  if (!$result) {
    throw new Exception("Database query failed: " . $conn->error);
  }

  $orcamentos = [];

  while ($row = $result->fetch_assoc()) {
    $data_original = $row['data_hora']; 
    $timestamp = strtotime($data_original);
    $row['data_hora'] = date('d/m/Y H:i', $timestamp);
    $orcamentos[] = $row;
  }

  echo json_encode($orcamentos);

} catch (Exception $e) {
  http_response_code(500);
  echo json_encode([
    'error' => true,
    'message' => $e->getMessage()
  ]);
} finally {
  if (isset($conn)) {
    $conn->close();
  }
}
