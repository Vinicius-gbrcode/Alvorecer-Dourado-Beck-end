CREATE DATABASE IF NOT EXISTS alvorecer_dourado
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE alvorecer_dourado;

CREATE TABLE IF NOT EXISTS orcamentos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    telefone VARCHAR(30) NOT NULL,
    tipo_servico VARCHAR(80) NOT NULL,
    mensagem TEXT NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS depoimentos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    texto TEXT NOT NULL,
    aprovado TINYINT(1) NOT NULL DEFAULT 1,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS servicos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    descricao TEXT NOT NULL,
    imagem VARCHAR(180) NOT NULL,
    pagina VARCHAR(120) NOT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

-- Dados iniciais correspondentes aos serviços que já aparecem no site.
INSERT INTO servicos (nome, descricao, imagem, pagina) VALUES
('Pintura Residencial', 'Quartos, salas, cozinhas e demais ambientes residenciais com preparação e acabamento cuidadoso.', 'img/pintura-residencial.png', 'servico1.html'),
('Pintura Comercial', 'Lojas, escritórios, salas comerciais e estabelecimentos que precisam de uma apresentação profissional.', 'img/pintura-comercial.png', 'servico2.html'),
('Pintura de Fachadas', 'Renovação de fachadas e áreas externas com foco em proteção, estética e acabamento.', 'img/pintura-fachada.png', 'servico3.html');

-- Depoimentos demonstrativos que já existiam visualmente no site.
-- Podem ser editados ou removidos pelo phpMyAdmin.
INSERT INTO depoimentos (nome, titulo, texto) VALUES
('Cliente 1', 'Acabamento profissional', 'A proposta visual da Alvorecer é unir organização, cuidado e um resultado bonito em cada ambiente.'),
('Cliente 2', 'Atendimento personalizado', 'Um serviço pensado para o projeto, com orientação sobre preparação, cores e acabamento.'),
('Cliente 3', 'Organização e Limpeza', 'Durante todo o serviço, a equipe manteve o ambiente organizado e protegido. O resultado ficou excelente e sem aquela bagunça comum de reformas.'),
('Cliente 4', 'Qualidade no Acabamento', 'A pintura ficou uniforme e os detalhes foram muito bem feitos. Dá para perceber o cuidado da equipe em cada parte do trabalho.'),
('Cliente 5', 'Pontualidade e Confiança', 'Desde o orçamento até a entrega, tudo foi muito bem explicado e cumprido conforme combinado. Uma empresa que passa confiança.');
