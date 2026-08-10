-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/08/2026 às 21:32
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `cm_confecc`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `expedicao`
--

CREATE TABLE `expedicao` (
  `id_expedicao` int(11) NOT NULL,
  `data_envio` date DEFAULT NULL,
  `destinatario` varchar(40) NOT NULL,
  `motorista` varchar(40) NOT NULL,
  `nota_fiscal` varchar(50) DEFAULT NULL,
  `id_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lote`
--

CREATE TABLE `lote` (
  `id_lote` int(11) NOT NULL,
  `data` date NOT NULL,
  `qtd_pares` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `lote`
--

INSERT INTO `lote` (`id_lote`, `data`, `qtd_pares`, `id_pedido`) VALUES
(1, '2024-05-01', 50, 1),
(2, '2024-05-02', 30, 2),
(3, '2024-05-03', 40, 3),
(4, '2024-05-03', 25, 4),
(5, '2024-05-04', 60, 5),
(6, '2024-05-05', 35, 6),
(7, '2024-05-01', 500, 1),
(8, '2024-05-02', 680, 2),
(9, '2024-05-03', 450, 3),
(10, '2024-05-03', 710, 4),
(11, '2024-05-04', 430, 5),
(12, '2024-05-05', 590, 6),
(13, '2024-05-05', 640, 7),
(14, '2024-05-06', 480, 8),
(15, '2024-05-07', 730, 9),
(16, '2024-05-07', 510, 10),
(17, '2024-05-08', 660, 11),
(18, '2024-05-09', 410, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `lote_materia_prima`
--

CREATE TABLE `lote_materia_prima` (
  `id_lote` int(11) NOT NULL,
  `id_recebimento` int(11) NOT NULL,
  `qtd_usada` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `lote_materia_prima`
--

INSERT INTO `lote_materia_prima` (`id_lote`, `id_recebimento`, `qtd_usada`) VALUES
(1, 1, 150.50),
(2, 2, 210.00),
(3, 3, 135.25),
(4, 4, 245.00),
(5, 5, 120.80),
(6, 6, 180.00),
(7, 7, 200.00),
(8, 8, 160.40),
(9, 9, 225.10),
(10, 10, 155.00),
(11, 11, 195.75),
(12, 12, 130.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `marca`
--

INSERT INTO `marca` (`id_marca`, `nome`) VALUES
(1, 'PUMA'),
(2, 'OÜS'),
(3, 'Mormaii'),
(4, 'Skechers');

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentacao`
--

CREATE TABLE `movimentacao` (
  `id_movimento` int(11) NOT NULL,
  `etapa` varchar(20) NOT NULL,
  `data` date NOT NULL,
  `qualidade` varchar(20) DEFAULT NULL,
  `revisor` varchar(20) DEFAULT NULL,
  `distribuidor` varchar(20) DEFAULT NULL,
  `cor_po` int(10) DEFAULT NULL,
  `id_lote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `cliente` varchar(20) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `prazo_entrega` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `cliente`, `id_produto`, `prazo_entrega`) VALUES
(1, 'Azteca Calçados', 1, '2024-05-10'),
(2, 'Azteca Calçados', 2, '2024-05-12'),
(3, 'I9 Calçados', 3, '2024-05-15'),
(4, 'I9 Calçados', 5, '2024-05-10'),
(5, 'I9 Calçados', 6, '2024-05-12'),
(6, 'Kauã Calçados', 7, '2024-05-18'),
(7, 'Kauã Calçados', 9, '2024-05-11'),
(8, 'Kauã Calçados', 10, '2024-05-14'),
(9, 'Econis', 11, '2024-05-20'),
(10, 'Econis', 13, '2024-05-15'),
(11, 'Econis', 14, '2024-05-16'),
(12, 'San Diego', 15, '2024-05-22');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `id_marca` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome`, `modelo`, `id_marca`) VALUES
(1, 'Puma Suede Classic XXI', '385378-01', 1),
(2, 'Puma Carina Street', '389390-01', 1),
(3, 'Puma Caven 2.0', '392290-01', 1),
(4, 'Puma Smash v2', '365215-01', 1),
(5, 'ÖUS Imigrante Essencial', '150001', 2),
(6, 'ÖUS Fluente GTX', '150100', 2),
(7, 'ÖUS Söusa Imperial', '100201', 2),
(8, 'ÖUS Phibo 1123', '120015', 2),
(9, 'Mormaii Urban One', '203366', 3),
(10, 'Mormaii Sky', '208012', 3),
(11, 'Mormaii Pace', '204107', 3),
(12, 'Mormaii Flexxer', '201100', 3),
(13, 'Skechers Go Walk Joy', '15611', 4),
(14, 'Skechers Go Run Consistent', '220035', 4),
(15, 'Skechers Max Cushioning Premier', '220068', 4),
(16, 'Skechers Uno - Stand On Air', '73690', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `recebimento`
--

CREATE TABLE `recebimento` (
  `id_recebimento` int(11) NOT NULL,
  `data` date NOT NULL,
  `remetente` varchar(100) NOT NULL,
  `cod_recebedor` varchar(20) DEFAULT NULL,
  `motorista` varchar(100) DEFAULT NULL,
  `nota_fiscal` varchar(50) DEFAULT NULL,
  `materia_prima` varchar(100) NOT NULL,
  `qtd_recebida` decimal(10,2) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(12,2) GENERATED ALWAYS AS (`qtd_recebida` * `valor_unitario`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `recebimento`
--

INSERT INTO `recebimento` (`id_recebimento`, `data`, `remetente`, `cod_recebedor`, `motorista`, `nota_fiscal`, `materia_prima`, `qtd_recebida`, `valor_unitario`) VALUES
(1, '2026-08-12', 'Couro Norte', 'FUNC-01', 'Jorge Almeida', '45210', 'Couro sintético', 60.00, 13.00),
(2, '2026-10-12', 'Tecidos duRei', 'FUNC-02', 'Marcos Vieira', '45333', 'Malha laminada', 100.00, 12.00),
(3, '2025-02-22', 'Couro Sul Ltda', 'FUNC-03', 'Paulo Ferreira', '45489', 'Couro legítimo', 90.00, 16.00),
(4, '2025-02-24', 'Aviamentos MG', 'FUNC-04', 'Ricardo Souza', '45602', 'Cadarço', 500.00, 65.00),
(5, '2025-02-26', 'Solados Brasil', 'FUNC-01', 'Jorge Almeida', '45711', 'Sola de borracha', 220.00, 56.00),
(6, '2025-03-01', 'Couro Sul Ltda', 'FUNC-02', 'Marcos Vieira', '45820', 'Couro sintético', 180.00, 43.00),
(7, '2026-08-12', 'Couro Norte', 'FUNC-03', 'Paulo Ferreira', '45933', 'Couro legítimo', 233.00, 34.00),
(8, '2026-10-12', 'Tecidos duRei', 'FUNC-04', 'Ricardo Souza', '46045', 'Cadarço', 200.00, 32.00),
(9, '2025-02-22', 'Couro Sul Ltda', 'FUNC-01', 'Jorge Almeida', '46158', 'Sola de borracha', 345.00, 56.00),
(10, '2025-02-24', 'Aviamentos MG', 'FUNC-02', 'Marcos Vieira', '46271', 'Couro sintético', 334.00, 24.00),
(11, '2025-02-26', 'Solados Brasil', 'FUNC-03', 'Paulo Ferreira', '46384', 'Couro sintético', 76.00, 56.00),
(12, '2025-03-01', 'Couro Sul Ltda', 'FUNC-04', 'Ricardo Souza', '46497', 'Malha laminada', 432.00, 43.00);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `expedicao`
--
ALTER TABLE `expedicao`
  ADD PRIMARY KEY (`id_expedicao`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Índices de tabela `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`id_lote`),
  ADD KEY `lote_ibfk_1` (`id_pedido`);

--
-- Índices de tabela `lote_materia_prima`
--
ALTER TABLE `lote_materia_prima`
  ADD PRIMARY KEY (`id_lote`,`id_recebimento`),
  ADD KEY `id_recebimento` (`id_recebimento`);

--
-- Índices de tabela `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`);

--
-- Índices de tabela `movimentacao`
--
ALTER TABLE `movimentacao`
  ADD PRIMARY KEY (`id_movimento`),
  ADD KEY `id_lote` (`id_lote`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_produto` (`id_produto`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`),
  ADD KEY `id_marca` (`id_marca`);

--
-- Índices de tabela `recebimento`
--
ALTER TABLE `recebimento`
  ADD PRIMARY KEY (`id_recebimento`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `expedicao`
--
ALTER TABLE `expedicao`
  MODIFY `id_expedicao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lote`
--
ALTER TABLE `lote`
  MODIFY `id_lote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `movimentacao`
--
ALTER TABLE `movimentacao`
  MODIFY `id_movimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `recebimento`
--
ALTER TABLE `recebimento`
  MODIFY `id_recebimento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `expedicao`
--
ALTER TABLE `expedicao`
  ADD CONSTRAINT `expedicao_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);

--
-- Restrições para tabelas `lote`
--
ALTER TABLE `lote`
  ADD CONSTRAINT `lote_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);

--
-- Restrições para tabelas `lote_materia_prima`
--
ALTER TABLE `lote_materia_prima`
  ADD CONSTRAINT `lote_materia_prima_ibfk_1` FOREIGN KEY (`id_lote`) REFERENCES `lote` (`id_lote`),
  ADD CONSTRAINT `lote_materia_prima_ibfk_2` FOREIGN KEY (`id_recebimento`) REFERENCES `recebimento` (`id_recebimento`);

--
-- Restrições para tabelas `movimentacao`
--
ALTER TABLE `movimentacao`
  ADD CONSTRAINT `movimentacao_ibfk_1` FOREIGN KEY (`id_lote`) REFERENCES `lote` (`id_lote`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

--
-- Restrições para tabelas `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
