-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 16/05/2025 às 20:24
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `vidracaria`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `tipo` enum('pf','pj') NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `cnpj` varchar(18) DEFAULT NULL,
  `telefone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `endereco` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `tipo`, `nome`, `cpf`, `cnpj`, `telefone`, `email`, `cep`, `endereco`, `numero`, `complemento`, `cidade`, `estado`, `criado_em`) VALUES
(4, 'pf', 'Karen Utino Sartori', '12312312312', NULL, '11981199876', 'karensartori@gmail.com', '13484666', 'Avenida Libertino Pizani', '107', 'apto', 'Limeira', 'SP', '2025-05-01 22:51:54'),
(5, 'pj', 'Empresa BlaBla', NULL, '12', '12', 'empresa@gmail.com', '13607720', 'Rua Apparecido Orlando Cabrini', '2', '', 'Araras', 'SP', '2025-05-01 22:53:38');

-- --------------------------------------------------------

--
-- Estrutura para tabela `materiais`
--

CREATE TABLE `materiais` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `peso_kg_m` decimal(10,3) DEFAULT 0.000,
  `peso_kg_aluminio` decimal(10,2) DEFAULT NULL,
  `tipo` enum('aluminio','vidro','fechadura','kit') DEFAULT 'aluminio'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `materiais`
--

INSERT INTO `materiais` (`id`, `nome`, `peso_kg_m`, `peso_kg_aluminio`, `tipo`) VALUES
(1, 'Trilho de Cima', 0.840, 130.00, 'aluminio'),
(2, 'Capa', 0.259, 130.00, 'aluminio'),
(3, 'Trilho de Baixo', 0.394, 130.00, 'aluminio'),
(4, 'Click', 0.100, 130.00, 'aluminio'),
(5, 'Mata-junta', 0.394, 130.00, 'aluminio'),
(8, 'Guarda po', 0.177, 130.00, 'aluminio'),
(9, 'Perfil U', 0.186, 130.00, 'aluminio'),
(10, 'Tubo 4020P', 1.055, 130.00, 'aluminio'),
(11, 'Cantoneira', 0.131, 130.00, 'aluminio'),
(12, 'Perfil U 10', 0.268, 130.00, 'aluminio'),
(13, 'Fechadura contra parede	', NULL, 240.00, 'fechadura'),
(14, 'Bate- Fecha	', NULL, 100.00, 'fechadura'),
(15, 'Vidro Temperado 8mm', NULL, 300.00, 'vidro'),
(16, 'Fechadura Vidro Vidro', NULL, 240.00, 'fechadura'),
(17, 'Vidro Temperado 10mm', NULL, 410.00, 'vidro'),
(18, 'Fechadura Porta Abrir', NULL, 500.00, 'fechadura'),
(19, 'Kit Basculante', NULL, 250.00, 'kit'),
(20, 'Trilho de Cima 10mm', 1.272, 130.00, 'aluminio'),
(21, 'Capa 10mm', 0.434, 130.00, 'aluminio'),
(22, 'Trilho de Baixo 10mm', 0.268, 130.00, 'aluminio'),
(23, 'Click 10mm', 0.092, 130.00, 'aluminio'),
(24, 'Guarda po 10mm', 0.200, 130.00, 'aluminio'),
(25, 'Perfil U 10mm', 0.268, 130.00, 'aluminio'),
(26, 'Mata-junta 10mm', 0.276, 130.00, 'aluminio'),
(27, 'Vidro Incolor', NULL, 240.00, 'vidro'),
(28, 'Kit de 1000 a 1300', NULL, 250.00, 'kit'),
(29, 'Kit de 1330 a 1600', NULL, 270.00, 'kit'),
(30, 'Kit de 1800', NULL, 300.00, 'kit'),
(31, 'Kit de 2000', NULL, 320.00, 'kit'),
(32, 'Kit de Canto 900', NULL, 320.00, 'kit'),
(33, 'Kit de Canto 1000', NULL, 340.00, 'kit'),
(34, 'Kit de Canto 1200', NULL, 390.00, 'kit'),
(35, 'Roldanas', NULL, 290.00, 'fechadura'),
(36, 'Trilho de cima Stanley', 1.516, 130.00, 'aluminio'),
(37, 'Trilho de Baixo Stanley', 0.547, 130.00, 'aluminio'),
(39, 'Guarda po Stanley', 0.233, 130.00, 'aluminio'),
(40, 'Perfil U Stanley', 0.186, 130.00, 'aluminio'),
(41, 'Perfil U 10 Stanley', 0.268, 130.00, 'aluminio'),
(43, 'Vidro Stanley', 0.000, 450.00, 'vidro');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orcamentos`
--

CREATE TABLE `orcamentos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `data_hora` datetime NOT NULL,
  `caminho_arquivo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `foto`) VALUES
(1, 'CORRER POR TRAS', 'fotos/correr_por_tras.jpg'),
(2, '08MM 02 FOLHAS', 'fotos/08mm_2folhas.jpg'),
(3, '08MM 04 FOLHAS', 'fotos/08mm_4folhas.jpg'),
(4, 'PORTA ABRIR 8MM', 'fotos/porta_abrir_8mm.jpg'),
(5, 'PORTA ABRIR 10MM', 'fotos/porta_abrir_10mm.jpg'),
(6, 'BASCULANTE', 'fotos/basculante.jpg'),
(7, '10MM 02 FOLHAS', 'fotos/10mm_2folhas.jpg'),
(8, '10MM 04 FOLHAS', 'fotos/10mm_4folhas.jpg'),
(9, 'BOX', 'fotos/box.jpg'),
(10, 'Stanley', 'fotos/stanley.jpg');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto_materiais`
--

CREATE TABLE `produto_materiais` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `quantidade` decimal(10,2) DEFAULT 1.00,
  `tipo_calculo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto_materiais`
--

INSERT INTO `produto_materiais` (`id`, `produto_id`, `material_id`, `quantidade`, `tipo_calculo`) VALUES
(1, 1, 1, 1.00, 'largura*2'),
(2, 1, 2, 1.00, 'largura*2'),
(3, 1, 3, 1.00, 'largura*2'),
(4, 1, 4, 1.00, 'largura*2'),
(6, 2, 1, 1.00, 'largura'),
(7, 2, 3, 1.00, 'largura'),
(8, 1, 9, 1.00, 'altura'),
(9, 1, 10, 1.00, 'altura'),
(10, 1, 12, 1.00, 'altura'),
(11, 2, 2, 1.00, 'largura'),
(12, 2, 4, 1.00, 'largura'),
(13, 2, 8, 1.00, 'altura'),
(14, 2, 9, 1.00, 'altura'),
(15, 2, 12, 1.00, 'altura'),
(16, 3, 1, 1.00, 'largura'),
(17, 3, 2, 1.00, 'largura'),
(18, 3, 3, 1.00, 'largura'),
(19, 3, 4, 1.00, 'largura'),
(20, 3, 5, 1.00, 'altura'),
(21, 3, 8, 1.00, 'altura*2'),
(22, 3, 9, 1.00, 'altura*2'),
(23, 1, 13, 1.00, NULL),
(24, 1, 14, 1.00, NULL),
(25, 1, 15, 1.00, 'altura*largura'),
(26, 2, 13, 1.00, NULL),
(27, 2, 14, 1.00, NULL),
(28, 2, 15, 1.00, 'altura*largura'),
(29, 3, 16, 1.00, NULL),
(30, 3, 14, 1.00, NULL),
(31, 3, 15, 1.00, 'altura*largura'),
(32, 4, 18, 1.00, NULL),
(33, 4, 15, 1.00, 'altura*largura'),
(34, 5, 18, 1.00, NULL),
(35, 5, 17, 1.00, 'altura*largura'),
(36, 6, 19, 1.00, NULL),
(37, 6, 15, 1.00, 'altura*largura'),
(38, 7, 20, 1.00, 'largura'),
(39, 7, 21, 1.00, 'largura'),
(40, 7, 22, 1.00, 'largura'),
(41, 7, 23, 1.00, 'largura'),
(44, 7, 24, 1.00, 'altura'),
(47, 7, 25, 1.00, 'altura*2'),
(48, 7, 13, 1.00, NULL),
(49, 7, 14, 1.00, NULL),
(50, 7, 17, 1.00, NULL),
(51, 8, 20, 1.00, 'largura'),
(52, 8, 21, 1.00, 'largura'),
(53, 8, 22, 1.00, 'largura'),
(54, 8, 23, 1.00, 'largura'),
(55, 8, 26, 1.00, 'altura'),
(56, 8, 24, 1.00, 'altura*2'),
(57, 8, 25, 1.00, 'altura*2'),
(58, 8, 13, 1.00, NULL),
(59, 8, 14, 1.00, NULL),
(60, 8, 17, 1.00, 'altura*largura'),
(61, 9, 27, 1.00, 'largura'),
(62, 9, 28, 1.00, NULL),
(63, 9, 29, 1.00, NULL),
(64, 9, 30, 1.00, NULL),
(65, 9, 31, 1.00, NULL),
(66, 9, 32, 1.00, NULL),
(67, 9, 33, 1.00, NULL),
(68, 9, 34, 1.00, NULL),
(69, 10, 36, 1.00, '6.4'),
(70, 10, 37, 1.00, '6.4'),
(71, 10, 39, 1.00, 'altura*3'),
(72, 10, 40, 1.00, '6'),
(73, 10, 41, 1.00, 'altura'),
(74, 10, 43, 1.00, 'altura*largura'),
(75, 10, 13, 1.00, NULL),
(76, 10, 35, 1.00, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `materiais`
--
ALTER TABLE `materiais`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `orcamentos`
--
ALTER TABLE `orcamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produto_materiais`
--
ALTER TABLE `produto_materiais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`),
  ADD KEY `material_id` (`material_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `materiais`
--
ALTER TABLE `materiais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de tabela `orcamentos`
--
ALTER TABLE `orcamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `produto_materiais`
--
ALTER TABLE `produto_materiais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `orcamentos`
--
ALTER TABLE `orcamentos`
  ADD CONSTRAINT `orcamentos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);

--
-- Restrições para tabelas `produto_materiais`
--
ALTER TABLE `produto_materiais`
  ADD CONSTRAINT `produto_materiais_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`),
  ADD CONSTRAINT `produto_materiais_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materiais` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
