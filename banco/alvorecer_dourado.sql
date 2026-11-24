-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 24/11/2026 às 23:30
-- Versão do servidor: 10.11.16-MariaDB
-- Versão do PHP: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `alvorecer_dourado`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `depoimentos`
--

CREATE TABLE `depoimentos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `texto` text NOT NULL,
  `aprovado` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `depoimentos`
--

INSERT INTO `depoimentos` (`id`, `nome`, `titulo`, `texto`, `aprovado`, `criado_em`) VALUES
(1, 'João', 'Acabamento profissional', 'A proposta visual da Alvorecer é unir organização, cuidado e um resultado bonito em cada ambiente.', 1, '2026-11-24 13:10:15'),
(2, 'Eduarda', 'Atendimento personalizado', 'Um serviço pensado para o projeto, com orientação sobre preparação, cores e acabamento.', 1, '2026-11-24 13:10:15'),
(3, 'Vinicius', 'Organização e Limpeza', 'Durante todo o serviço, a equipe manteve o ambiente organizado e protegido. O resultado ficou excelente e sem aquela bagunça comum de reformas.', 1, '2026-11-24 13:10:15'),
(4, 'Diego', 'Qualidade no Acabamento', 'A pintura ficou uniforme e os detalhes foram muito bem feitos. Dá para perceber o cuidado da equipe em cada parte do trabalho.', 1, '2026-11-24 13:10:15'),
(5, 'Erick', 'Pontualidade e Confiança', 'Desde o orçamento até a entrega, tudo foi muito bem explicado e cumprido conforme combinado. Uma empresa que passa confiança.', 1, '2026-11-24 13:10:15'),
(6, 'Teste', 'TESTE', 'TESTE DE COMENTARIO.', 1, '2026-11-24 17:22:25'),
(7, 'TESTE 2', 'TESTE 2', 'Testando pela 2 vez', 1, '2026-11-24 18:27:39');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orcamentos`
--

CREATE TABLE `orcamentos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `telefone` varchar(30) NOT NULL,
  `tipo_servico` varchar(80) NOT NULL,
  `mensagem` text NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `orcamentos`
--

INSERT INTO `orcamentos` (`id`, `nome`, `telefone`, `tipo_servico`, `mensagem`, `criado_em`) VALUES
(2, 'TESTE', '49988235454', 'Pintura Residencial', 'TESTE', '2026-11-24 18:10:15'),
(3, 'TESTE 2', '49988238448', 'Pintura Residencial', 'TESTE2', '2026-11-24 18:10:54'),
(4, 'TESTE', '49988238448', 'Pintura Comercial', 'TESTE 2', '2026-11-24 18:13:46');

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `descricao` text NOT NULL,
  `imagem` varchar(180) NOT NULL,
  `pagina` varchar(120) NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`id`, `nome`, `descricao`, `imagem`, `pagina`, `ativo`) VALUES
(1, 'Pintura Residencial', 'Quartos, salas, cozinhas e demais ambientes residenciais com preparação e acabamento cuidadoso.', 'img/pintura-residencial.png', 'servico1.html', 1),
(2, 'Pintura Comercial', 'Lojas, escritórios, salas comerciais e estabelecimentos que precisam de uma apresentação profissional.', 'img/pintura-comercial.png', 'servico2.html', 1),
(3, 'Pintura de Fachadas', 'Renovação de fachadas e áreas externas com foco em proteção, estética e acabamento.', 'img/pintura-fachada.png', 'servico3.html', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `depoimentos`
--
ALTER TABLE `depoimentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `orcamentos`
--
ALTER TABLE `orcamentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `depoimentos`
--
ALTER TABLE `depoimentos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `orcamentos`
--
ALTER TABLE `orcamentos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
