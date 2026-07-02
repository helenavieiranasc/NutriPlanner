SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `nutriplanner` DEFAULT CHARACTER SET utf8mb3 ;
USE `nutriplanner` ;

-- Table `nutriplanner`.`alimentos`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`alimentos` (
  `idalimentos` INT NOT NULL,
  `categoria` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `umidade` FLOAT NULL DEFAULT NULL,
  `energia_kcal` FLOAT NULL DEFAULT NULL,
  `energia_kj` FLOAT NULL DEFAULT NULL,
  `proteina` FLOAT NULL DEFAULT NULL,
  `lipideos` FLOAT NULL DEFAULT NULL,
  `colesterol` FLOAT NULL DEFAULT NULL,
  `carboidrato` FLOAT NULL DEFAULT NULL,
  `fibra_alimentar` FLOAT NULL DEFAULT NULL,
  `cinzas` FLOAT NULL DEFAULT NULL,
  `calcio` FLOAT NULL DEFAULT NULL,
  `magnesio` FLOAT NULL DEFAULT NULL,
  `manganes` FLOAT NULL DEFAULT NULL,
  `fosforo` FLOAT NULL DEFAULT NULL,
  `ferro` FLOAT NULL DEFAULT NULL,
  `sodio` FLOAT NULL DEFAULT NULL,
  `potassio` FLOAT NULL DEFAULT NULL,
  `cobre` FLOAT NULL DEFAULT NULL,
  `zinco` FLOAT NULL DEFAULT NULL,
  `retinol` FLOAT NULL DEFAULT NULL,
  `re` FLOAT NULL DEFAULT NULL,
  `rae` FLOAT NULL DEFAULT NULL,
  `tiamina` FLOAT NULL DEFAULT NULL,
  `riboflavina` FLOAT NULL DEFAULT NULL,
  `piridoxina` FLOAT NULL DEFAULT NULL,
  `niacina` FLOAT NULL DEFAULT NULL,
  `vitamina_c` FLOAT NULL DEFAULT NULL,
  `triptofano` FLOAT NULL DEFAULT NULL,
  `treonina` FLOAT NULL DEFAULT NULL,
  `isoleucina` FLOAT NULL DEFAULT NULL,
  `leucina` FLOAT NULL DEFAULT NULL,
  `lisina` FLOAT NULL DEFAULT NULL,
  `metionina` FLOAT NULL DEFAULT NULL,
  `cistina` FLOAT NULL DEFAULT NULL,
  `fenilalanina` FLOAT NULL DEFAULT NULL,
  `tirosina` FLOAT NULL DEFAULT NULL,
  `valina` FLOAT NULL DEFAULT NULL,
  `arginina` FLOAT NULL DEFAULT NULL,
  `histidina` FLOAT NULL DEFAULT NULL,
  `alanina` FLOAT NULL DEFAULT NULL,
  `acido_aspartico` FLOAT NULL DEFAULT NULL,
  `acido_glutamico` FLOAT NULL DEFAULT NULL,
  `glicina` FLOAT NULL DEFAULT NULL,
  `prolina` FLOAT NULL DEFAULT NULL,
  `serina` FLOAT NULL DEFAULT NULL,
  `saturados` FLOAT NULL DEFAULT NULL,
  `mono_insaturados` FLOAT NULL DEFAULT NULL,
  `poli_insaturados` FLOAT NULL DEFAULT NULL,
  `x12_0` FLOAT NULL DEFAULT NULL,
  `x14_0` FLOAT NULL DEFAULT NULL,
  `x16_0` FLOAT NULL DEFAULT NULL,
  `x18_0` FLOAT NULL DEFAULT NULL,
  `x20_0` FLOAT NULL DEFAULT NULL,
  `x22_0` FLOAT NULL DEFAULT NULL,
  `x24_0` FLOAT NULL DEFAULT NULL,
  `x14_1` FLOAT NULL DEFAULT NULL,
  `x16_1` FLOAT NULL DEFAULT NULL,
  `x18_1` FLOAT NULL DEFAULT NULL,
  `x20_1` FLOAT NULL DEFAULT NULL,
  `x18_2_n6` FLOAT NULL DEFAULT NULL,
  `x18_3_n3` FLOAT NULL DEFAULT NULL,
  `x20_4` FLOAT NULL DEFAULT NULL,
  `x20_5` FLOAT NULL DEFAULT NULL,
  `x22_5` FLOAT NULL DEFAULT NULL,
  `x22_6` FLOAT NULL DEFAULT NULL,
  `x18_1t` FLOAT NULL DEFAULT NULL,
  `x18_2t` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`idalimentos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- Table `nutriplanner`.`nutricionista`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`nutricionista` (
  `id_nutricionista` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `password` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id_nutricionista`),
  UNIQUE INDEX `id_nutricionista_UNIQUE` (`id_nutricionista` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- Table `nutriplanner`.`paciente`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`paciente` (
  `CPF` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `data_nasc` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `gravidez` CHAR(3) NOT NULL DEFAULT 'NAO',
  `etnia` VARCHAR(45) NULL DEFAULT NULL,
  `profissão` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `nutricionista_id_nutricionista` INT NOT NULL,
  PRIMARY KEY (`CPF`, `nutricionista_id_nutricionista`),
  UNIQUE INDEX `cpf_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `pacientecol_UNIQUE` (`Nome` ASC) VISIBLE,
  INDEX `fk_paciente_nutricionista1_idx` (`nutricionista_id_nutricionista` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_nutricionista1`
    FOREIGN KEY (`nutricionista_id_nutricionista`)
    REFERENCES `nutriplanner`.`nutricionista` (`id_nutricionista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- Table `nutriplanner`.`paciente_anamnese`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`paciente_anamnese` (
  `idpaciente_anamnese` INT NOT NULL AUTO_INCREMENT,
  `objetivo` ENUM('Emagrecimento', 'Manutenção', 'Hipertrofia') NOT NULL,
  `doencas_diagnosticadas` VARCHAR(200) NOT NULL,
  `medicamentos_continuos` VARCHAR(200) NOT NULL,
  `intolerancias` VARCHAR(200) NOT NULL,
  `alergias` VARCHAR(200) NOT NULL,
  `freq_intestinal` ENUM('1x ao dia (normal)', '2x ao dia', 'A cada 2 dias', 'A cada 3 dias', 'A cada 4–5 dias', 'Menos de 1x por semana') NOT NULL,
  `qualidade_sono` ENUM('Excelente (sono reparador)', 'Bom (dorme bem na maioria dos dias)', 'Regular (acorda algumas vezes, sono leve)', 'Ruim (dificuldade para dormir ou manter o sono)', 'Insônia (demora para dormir ou acorda muitas vezes)') NOT NULL,
  `peso` FLOAT NOT NULL,
  `altura` FLOAT NOT NULL,
  `circunferencia_cintura` FLOAT NOT NULL,
  `metodo_tmb` ENUM('Harris-Benedict (padrão geral)', 'Mifflin-St Jeor (pacientes com sobrepeso/obesidade)') NOT NULL,
  `nivel_atividadefisica` ENUM('Sedentário (não pratica exercícios)', 'Leve (1-2x por semana)', 'Moderado (3-4x por semana)', 'Intenso (5-6x por semana)', 'Atleta/treino diário', 'Trabalho fisicamente ativo (ex: estoquista, operario)') NOT NULL,
  `consumo_agua` ENUM('Menos de 500 ml/dia', 'Entre 500 ml e 1 L/dia', 'Entre 1 L e 1,5 L/dia', 'Entre 1,5 L e 2 L/dia', 'Entre 2 L e 3 L/dia', 'Mais de 3 L/dia') NOT NULL,
  `alcoool` ENUM('Não consome', 'Raramente (1x/mês ou menos)', 'Socialmente (2–4x/mês)', '1x por semana', '2–3x por semana', '4–5x por semana', 'Diariamente', 'Ex-consumidor') NOT NULL,
  `meta_1` VARCHAR(45) NOT NULL,
  `meta_2` VARCHAR(45) NULL DEFAULT 'Não se aplica',
  `meta_3` VARCHAR(45) NULL DEFAULT 'Não se aplica',
  `peitoral` FLOAT NOT NULL,
  `axilar_media` FLOAT NOT NULL,
  `triceps` FLOAT NOT NULL,
  `subescapular` FLOAT NOT NULL,
  `abdomen` FLOAT NOT NULL,
  `suprailiaca` FLOAT NOT NULL,
  `coxa` FLOAT NOT NULL,
  `paciente_CPF` VARCHAR(11) NOT NULL,
  `paciente_nutricionista_id_nutricionista` INT NOT NULL,
  PRIMARY KEY (`idpaciente_anamnese`, `paciente_CPF`, `paciente_nutricionista_id_nutricionista`),
  INDEX `fk_paciente_anamnese_paciente1_idx` (`paciente_CPF` ASC, `paciente_nutricionista_id_nutricionista` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_anamnese_paciente1`
    FOREIGN KEY (`paciente_CPF` , `paciente_nutricionista_id_nutricionista`)
    REFERENCES `nutriplanner`.`paciente` (`CPF` , `nutricionista_id_nutricionista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- Table `nutriplanner`.`plano_nutricional`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`plano_nutricional` (
  `idplano_nutricional` INT NOT NULL AUTO_INCREMENT,
  `paciente_cpf` VARCHAR(11) NOT NULL,
  `data_plano` VARCHAR(45) NOT NULL,
  `observacoes` TEXT NULL,
  PRIMARY KEY (`idplano_nutricional`, `paciente_cpf`, `data_plano`),
  INDEX `fk_table1_paciente_idx` (`paciente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_table1_paciente`
    FOREIGN KEY (`paciente_cpf`)
    REFERENCES `nutriplanner`.`paciente` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- Table `nutriplanner`.`refeicoes`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`refeicoes` (
  `data_refeicao` DATE NOT NULL,
  `nome_refeição` ENUM('Café da manhã', 'Lanche da manhã', 'Almoço', 'Lanche da tarde', 'Jantar', 'Ceia') NOT NULL,
  `plano_nutricional_idplano_nutricional` INT NOT NULL,
  `plano_nutricional_paciente_cpf` VARCHAR(11) NOT NULL,
  `plano_nutricional_data_plano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`data_refeicao`, `nome_refeição`, `plano_nutricional_idplano_nutricional`, `plano_nutricional_paciente_cpf`, `plano_nutricional_data_plano`),
  INDEX `fk_refeicoes_plano_nutricional1_idx` (`plano_nutricional_idplano_nutricional` ASC, `plano_nutricional_paciente_cpf` ASC, `plano_nutricional_data_plano` ASC) VISIBLE,
  CONSTRAINT `fk_refeicoes_plano_nutricional1`
    FOREIGN KEY (`plano_nutricional_idplano_nutricional` , `plano_nutricional_paciente_cpf` , `plano_nutricional_data_plano`)
    REFERENCES `nutriplanner`.`plano_nutricional` (`idplano_nutricional` , `paciente_cpf` , `data_plano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- Table `nutriplanner`.`refeiçao_alimento`
CREATE TABLE IF NOT EXISTS `nutriplanner`.`refeiçao_alimento` (
  `alimentos_idalimentos` INT NOT NULL,
  `quantidade` FLOAT NOT NULL,
  `unidade_medida` ENUM('Grama(s) (g)', 'Porção(ões) (100g)', 'Colher(es) de sopa', 'Colher(es) de chá', 'Xícara(s)', 'Unidade(s)', 'Fatia(s)', 'À vontade') NOT NULL,
  `refeicoes_data_refeicao` DATE NOT NULL,
  `refeicoes_nome_refeição` ENUM('Café da manhã', 'Lanche da manhã', 'Almoço', 'Lanche da tarde', 'Jantar', 'Ceia') NOT NULL,
  `refeicoes_plano_nutricional_idplano_nutricional` INT NOT NULL,
  `refeicoes_plano_nutricional_paciente_cpf` VARCHAR(11) NOT NULL,
  `refeicoes_plano_nutricional_data_plano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`alimentos_idalimentos`, `refeicoes_data_refeicao`, `refeicoes_nome_refeição`, `refeicoes_plano_nutricional_idplano_nutricional`, `refeicoes_plano_nutricional_paciente_cpf`, `refeicoes_plano_nutricional_data_plano`),
  INDEX `fk_refeição_alimento_alimentos1_idx` (`alimentos_idalimentos` ASC) VISIBLE,
  INDEX `fk_refeiçao_alimento_refeicoes1_idx` (`refeicoes_data_refeicao` ASC, `refeicoes_plano_nutricional_idplano_nutricional` ASC, `refeicoes_plano_nutricional_paciente_cpf` ASC, `refeicoes_plano_nutricional_data_plano` ASC) VISIBLE,
  CONSTRAINT `fk_refeição_alimento_alimentos1`
    FOREIGN KEY (`alimentos_idalimentos`)
    REFERENCES `nutriplanner`.`alimentos` (`idalimentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_refeiçao_alimento_refeicoes1`
    FOREIGN KEY (`refeicoes_data_refeicao` , `refeicoes_nome_refeição` , `refeicoes_plano_nutricional_idplano_nutricional` , `refeicoes_plano_nutricional_paciente_cpf` , `refeicoes_plano_nutricional_data_plano`)
    REFERENCES `nutriplanner`.`refeicoes` (`data_refeicao` , `nome_refeição` , `plano_nutricional_idplano_nutricional` , `plano_nutricional_paciente_cpf` , `plano_nutricional_data_plano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ALTER TABLE: índices em colunas frequentemente consultadas
ALTER TABLE `nutriplanner`.`alimentos`
  ADD INDEX `idx_alimentos_categoria` (`categoria` ASC);

ALTER TABLE `nutriplanner`.`plano_nutricional`
  ADD INDEX `idx_plano_data` (`data_plano` ASC);

-- 1. NUTRICIONISTA
INSERT INTO `nutriplanner`.`nutricionista` (`email`, `nome`, `password`)
VALUES ('nutri_teste@nutriplanner.com', 'Nutricionista Sistema', '12345678');


-- 2. PACIENTES
INSERT INTO `nutriplanner`.`paciente`
  (`CPF`, `Nome`, `data_nasc`, `sexo`, `gravidez`, `etnia`, `profissão`, `telefone`, `email`, `nutricionista_id_nutricionista`)
VALUES
  ('51508589870', 'Helena Vieira',                 '2007-04-30', 'F', 'NAO', 'Branca', 'Estudante',   '12992196585', 'hv.nasc@gmail.com',                    1),
  ('52546879835', 'Maria Clara Pastor Da Silva',   '2006-08-08', 'F', 'NAO', 'Branca', 'Estudante',   '12992608875', 'mariaclarapastorsilva@gmail.com',        1),
  ('54102542643', 'Camila Ribeiro',                '2007-03-09', 'F', 'NAO', 'Parda',  'Estudante',   '12991683528', 'camila@email.com',                      1),
  ('12345432761', 'Caio Polidoro Grilo',           '2005-05-05', 'M', 'NAO', 'Branca', 'Estudante',   '12992176784', 'caio@gmail.com',                        1),
  ('33322211100', 'Lucas Ferreira Alves',          '1995-07-12', 'M', 'NAO', 'Parda',  'Engenheiro',  '11987651234', 'lucas.ferreira@email.com',              1),
  ('44433322211', 'Ana Paula Souza',               '1989-11-25', 'F', 'NAO', 'Branca', 'Professora',  '11976543210', 'anapaula.souza@email.com',              1),
  ('55544433322', 'Rodrigo Nascimento Costa',      '2000-03-18', 'M', 'NAO', 'Parda',  'Estudante',   '11965432109', 'rodrigo.costa@email.com',               1),
  ('66655544433', 'Fernanda Lima Oliveira',        '1998-09-03', 'F', 'NAO', 'Branca', 'Nutricionista','11954321098','fernanda.lima@email.com',               1),
  ('77766655544', 'Gustavo Mendes Rocha',          '1992-01-30', 'M', 'NAO', 'Parda',  'Autônomo',    '11943210987', 'gustavo.mendes@email.com',              1),
  ('88877766655', 'Juliana Torres Pinto',          '2003-06-21', 'F', 'NAO', 'Branca', 'Estudante',   '11932109876', 'juliana.torres@email.com',              1),
  ('99988877766', 'Felipe Barbosa Martins',        '1987-12-08', 'M', 'NAO', 'Preta',  'Contador',    '11921098765', 'felipe.barbosa@email.com',              1),
  ('11100099988', 'Tatiane Carvalho Dias',         '2001-04-14', 'F', 'SIM', 'Branca', 'Vendedora',   '11910987654', 'tatiane.carvalho@email.com',            1),
  ('22211100099', 'Bruno Araújo Pereira',          '1993-08-27', 'M', 'NAO', 'Parda',  'Médico',      '11909876543', 'bruno.araujo@email.com',                1),
  ('33322200011', 'Isabela Gonçalves Freitas',     '1996-02-09', 'F', 'NAO', 'Branca', 'Advogada',    '11898765432', 'isabela.goncalves@email.com',           1);


-- 3. ANAMNESE
INSERT INTO `paciente_anamnese` (
  `objetivo`, `doencas_diagnosticadas`, `medicamentos_continuos`, `intolerancias`, `alergias`,
  `freq_intestinal`, `qualidade_sono`, `peso`, `altura`, `circunferencia_cintura`, `metodo_tmb`,
  `nivel_atividadefisica`, `consumo_agua`, `alcoool`, `meta_1`, `meta_2`, `meta_3`,
  `peitoral`, `axilar_media`, `triceps`, `subescapular`, `abdomen`, `suprailiaca`, `coxa`,
  `paciente_CPF`, `paciente_nutricionista_id_nutricionista`
) VALUES

  -- Helena Vieira
  ('Manutenção', 'Não se aplica', 'Não se aplica', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Excelente (sono reparador)', 48.0, 160.0, 58.0,
   'Harris-Benedict (padrão geral)', 'Sedentário (não pratica exercícios)', 'Entre 500 ml e 1 L/dia', 'Não consome',
   'Acompanhamento alimentar', 'Não se aplica', 'Não se aplica',
   7, 12, 14, 12, 15, 13, 20,
   '51508589870', 1),

  -- Maria Clara Pastor
  ('Emagrecimento', 'Não se aplica', 'Não se aplica', 'Lactose', 'Não se aplica',
   '1x ao dia (normal)', 'Bom (dorme bem na maioria dos dias)', 67.0, 157.0, 65.0,
   'Harris-Benedict (padrão geral)', 'Intenso (5-6x por semana)', 'Entre 2 L e 3 L/dia', 'Socialmente (2–4x/mês)',
   'Emagrecimento', 'Hipertrofia', 'Manutenção',
   7, 10, 15, 12, 15, 15, 20,
   '52546879835', 1),

  -- Camila Ribeiro
  ('Emagrecimento', 'Não se aplica', 'Não se aplica', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Bom (dorme bem na maioria dos dias)', 60.0, 165.0, 60.0,
   'Harris-Benedict (padrão geral)', 'Sedentário (não pratica exercícios)', 'Entre 500 ml e 1 L/dia', 'Raramente (1x/mês ou menos)',
   'Acompanhamento alimentar', 'Não se aplica', 'Não se aplica',
   8, 12, 15, 12, 17, 15, 22,
   '54102542643', 1),
   
   
  -- Caio Grilo
  ('Hipertrofia', 'Não se aplica', 'Não se aplica', 'Lactose', 'Não se aplica',
   '1x ao dia (normal)', 'Excelente (sono reparador)', 85.0, 185.0, 70.0,
   'Harris-Benedict (padrão geral)', 'Intenso (5-6x por semana)', 'Entre 1,5 L e 2 L/dia', 'Socialmente (2–4x/mês)',
   'Acompanhamento alimentar', 'Não se aplica', 'Não se aplica',
   6, 5, 6, 9, 10, 6, 8,
   '12345432761', 1),

  -- Lucas Ferreira
  ('Emagrecimento', 'Hipertensão', 'Losartana', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Regular (acorda algumas vezes, sono leve)', 92.0, 175.0, 95.0,
   'Harris-Benedict (padrão geral)', 'Moderado (3-4x por semana)', 'Entre 1,5 L e 2 L/dia', 'Socialmente (2–4x/mês)',
   'Emagrecimento', 'Controle da pressão', 'Não se aplica',
   18, 20, 22, 19, 25, 21, 28,
   '33322211100', 1),

  -- Ana Paula
  ('Manutenção', 'Hipotireoidismo', 'Levotiroxina', 'Glúten', 'Não se aplica',
   'A cada 2 dias', 'Bom (dorme bem na maioria dos dias)', 62.0, 163.0, 75.0,
   'Harris-Benedict (padrão geral)', 'Leve (1-2x por semana)', 'Entre 1 L e 1,5 L/dia', 'Raramente (1x/mês ou menos)',
   'Manutenção', 'Não se aplica', 'Não se aplica',
   14, 16, 18, 15, 20, 17, 24,
   '44433322211', 1),

  -- Rodrigo Nascimento
  ('Hipertrofia', 'Não se aplica', 'Não se aplica', 'Não se aplica', 'Frutos do mar',
   '1x ao dia (normal)', 'Excelente (sono reparador)', 70.0, 178.0, 72.0,
   'Harris-Benedict (padrão geral)', 'Intenso (5-6x por semana)', 'Entre 2 L e 3 L/dia', 'Não consome',
   'Hipertrofia', 'Definição muscular', 'Não se aplica',
   7, 8, 9, 10, 11, 8, 10,
   '55544433322', 1),

  -- Fernanda Lima
  ('Manutenção', 'Não se aplica', 'Não se aplica', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Bom (dorme bem na maioria dos dias)', 58.0, 168.0, 68.0,
   'Harris-Benedict (padrão geral)', 'Moderado (3-4x por semana)', 'Entre 2 L e 3 L/dia', 'Não consome',
   'Manutenção', 'Não se aplica', 'Não se aplica',
   10, 11, 13, 11, 14, 12, 16,
   '66655544433', 1),

  -- Gustavo Mendes
  ('Emagrecimento', 'Diabetes tipo 2', 'Metformina', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Regular (acorda algumas vezes, sono leve)', 105.0, 180.0, 100.0,
   'Harris-Benedict (padrão geral)', 'Sedentário (não pratica exercícios)', 'Entre 1 L e 1,5 L/dia', 'Socialmente (2–4x/mês)',
   'Emagrecimento', 'Controle glicêmico', 'Não se aplica',
   22, 24, 26, 23, 30, 25, 32,
   '77766655544', 1),

  -- Juliana Torres
  ('Emagrecimento', 'Não se aplica', 'Não se aplica', 'Lactose', 'Amendoim',
   '1x ao dia (normal)', 'Bom (dorme bem na maioria dos dias)', 72.0, 162.0, 78.0,
   'Harris-Benedict (padrão geral)', 'Leve (1-2x por semana)', 'Entre 1 L e 1,5 L/dia', 'Não consome',
   'Emagrecimento', 'Não se aplica', 'Não se aplica',
   16, 17, 19, 16, 22, 18, 25,
   '88877766655', 1),

  -- Felipe Barbosa
  ('Manutenção', 'Colesterol alto', 'Sinvastatina', 'Não se aplica', 'Não se aplica',
   'A cada 2 dias', 'Regular (acorda algumas vezes, sono leve)', 80.0, 172.0, 85.0,
   'Harris-Benedict (padrão geral)', 'Moderado (3-4x por semana)', 'Entre 1,5 L e 2 L/dia', 'Raramente (1x/mês ou menos)',
   'Controle do colesterol', 'Manutenção', 'Não se aplica',
   12, 14, 16, 13, 18, 15, 20,
   '99988877766', 1),

  -- Tatiane Carvalho (grávida)
  ('Manutenção', 'Anemia gestacional', 'Sulfato ferroso', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Regular (acorda algumas vezes, sono leve)', 68.0, 160.0, 80.0,
   'Harris-Benedict (padrão geral)', 'Leve (1-2x por semana)', 'Entre 2 L e 3 L/dia', 'Não consome',
   'Saúde gestacional', 'Controle do peso', 'Não se aplica',
   13, 14, 17, 14, 19, 16, 22,
   '11100099988', 1),

  -- Bruno Araújo
  ('Hipertrofia', 'Não se aplica', 'Não se aplica', 'Não se aplica', 'Não se aplica',
   '1x ao dia (normal)', 'Excelente (sono reparador)', 78.0, 182.0, 76.0,
   'Harris-Benedict (padrão geral)', 'Intenso (5-6x por semana)', 'Entre 2 L e 3 L/dia', 'Raramente (1x/mês ou menos)',
   'Hipertrofia', 'Performance esportiva', 'Não se aplica',
   8, 9, 10, 11, 12, 9, 11,
   '22211100099', 1),

  -- Isabela Gonçalves
  ('Emagrecimento', 'Síndrome do ovário policístico', 'Anticoncepcional', 'Não se aplica', 'Não se aplica',
   'A cada 2 dias', 'Bom (dorme bem na maioria dos dias)', 75.0, 166.0, 82.0,
   'Harris-Benedict (padrão geral)', 'Moderado (3-4x por semana)', 'Entre 1,5 L e 2 L/dia', 'Não consome',
   'Emagrecimento', 'Equilíbrio hormonal', 'Não se aplica',
   15, 16, 18, 15, 21, 17, 23,
   '33322200011', 1);


-- 4. PLANOS NUTRICIONAIS
INSERT INTO `plano_nutricional` (`idplano_nutricional`, `paciente_cpf`, `data_plano`) VALUES
  (1, '52546879835', '2023-10-01'),   -- Maria Clara
  (2, '54102542643', '2023-10-01'),   -- Camila
  (3, '51508589870', '2023-10-01'),   -- Helena
  (4, '33322211100', '2023-10-01'),   -- Lucas
  (5, '55544433322', '2023-10-01'),   -- Rodrigo
  (6, '77766655544', '2023-10-01'),   -- Gustavo
  (7, '88877766655', '2023-10-01');   -- Juliana


-- 5. REFEIÇÕES
INSERT INTO `refeicoes` (`data_refeicao`, `nome_refeição`, `plano_nutricional_idplano_nutricional`, `plano_nutricional_paciente_cpf`, `plano_nutricional_data_plano`) VALUES
  -- Plano 1 — Maria Clara
  ('2023-10-01', 'Café da manhã',   1, '52546879835', '2023-10-01'),
  ('2023-10-01', 'Lanche da manhã', 1, '52546879835', '2023-10-01'),
  ('2023-10-01', 'Almoço',          1, '52546879835', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 1, '52546879835', '2023-10-01'),
  ('2023-10-01', 'Jantar',          1, '52546879835', '2023-10-01'),
  ('2023-10-01', 'Ceia',            1, '52546879835', '2023-10-01'),

  -- Plano 2 — Camila
  ('2023-10-01', 'Café da manhã',   2, '54102542643', '2023-10-01'),
  ('2023-10-01', 'Almoço',          2, '54102542643', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 2, '54102542643', '2023-10-01'),
  ('2023-10-01', 'Jantar',          2, '54102542643', '2023-10-01'),

  -- Plano 3 — Helena (derivado do JSON)
  ('2023-10-01', 'Café da manhã',   3, '51508589870', '2023-10-01'),
  ('2023-10-01', 'Lanche da manhã', 3, '51508589870', '2023-10-01'),
  ('2023-10-01', 'Almoço',          3, '51508589870', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 3, '51508589870', '2023-10-01'),
  ('2023-10-01', 'Jantar',          3, '51508589870', '2023-10-01'),
  ('2023-10-01', 'Ceia',            3, '51508589870', '2023-10-01'),

  -- Plano 4 — Lucas
  ('2023-10-01', 'Café da manhã',   4, '33322211100', '2023-10-01'),
  ('2023-10-01', 'Almoço',          4, '33322211100', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 4, '33322211100', '2023-10-01'),
  ('2023-10-01', 'Jantar',          4, '33322211100', '2023-10-01'),

  -- Plano 5 — Rodrigo
  ('2023-10-01', 'Café da manhã',   5, '55544433322', '2023-10-01'),
  ('2023-10-01', 'Lanche da manhã', 5, '55544433322', '2023-10-01'),
  ('2023-10-01', 'Almoço',          5, '55544433322', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 5, '55544433322', '2023-10-01'),
  ('2023-10-01', 'Jantar',          5, '55544433322', '2023-10-01'),
  ('2023-10-01', 'Ceia',            5, '55544433322', '2023-10-01'),

  -- Plano 6 — Gustavo
  ('2023-10-01', 'Café da manhã',   6, '77766655544', '2023-10-01'),
  ('2023-10-01', 'Almoço',          6, '77766655544', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 6, '77766655544', '2023-10-01'),
  ('2023-10-01', 'Jantar',          6, '77766655544', '2023-10-01'),

  -- Plano 7 — Juliana
  ('2023-10-01', 'Café da manhã',   7, '88877766655', '2023-10-01'),
  ('2023-10-01', 'Almoço',          7, '88877766655', '2023-10-01'),
  ('2023-10-01', 'Lanche da tarde', 7, '88877766655', '2023-10-01'),
  ('2023-10-01', 'Jantar',          7, '88877766655', '2023-10-01');


--  PLANO 1 — MARIA CLARA 
-- Café da manhã: Pão, trigo, francês (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, trigo, francês' LIMIT 1;

-- Café da manhã: Ovo, de galinha, inteiro, frito (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, frito' LIMIT 1;

-- Café da manhã: Queijo, requeijão, cremoso (30g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 30.0, 'Grama(s) (g)', '2023-10-01', 'Café da manhã', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Queijo, requeijão, cremoso' LIMIT 1;

-- Lanche da manhã: Morango, cru (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da manhã', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Morango, cru' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (50g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 50.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Salada, de legumes, cozida no vapor (2 porções)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Salada, de legumes, cozida no vapor' LIMIT 1;

-- Almoço: Frango, peito, sem pele, grelhado (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Lanche da tarde: Iogurte, natural (50g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 50.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da tarde', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Iogurte, natural' LIMIT 1;

-- Lanche da tarde: Uva, Itália, crua (60g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 60.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da tarde', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Uva, Itália, crua' LIMIT 1;

-- Jantar: Salada, de legumes, cozida no vapor (2 porções)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Salada, de legumes, cozida no vapor' LIMIT 1;

-- Jantar: Carne, bovina, acém, moído, cozido (180g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 180.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Carne, bovina, acém, moído, cozido' LIMIT 1;

-- Ceia: Chocolate, ao leite (20g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 20.0, 'Grama(s) (g)', '2023-10-01', 'Ceia', 1, '52546879835', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Chocolate, ao leite' LIMIT 1;



--  PLANO 2 — CAMILA

-- Café da manhã: Pão, trigo, francês (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, trigo, francês' LIMIT 1;

-- Café da manhã: Queijo, minas, frescal (25g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 25.0, 'Grama(s) (g)', '2023-10-01', 'Café da manhã', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Queijo, minas, frescal' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Ovo, de galinha, inteiro, frito (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Almoço', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, frito' LIMIT 1;

-- Lanche da tarde: Torrada, pão francês (1 fatia)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Fatia(s)', '2023-10-01', 'Lanche da tarde', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Torrada, pão francês' LIMIT 1;

-- Lanche da tarde: Manteiga, sem sal (10g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 10.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da tarde', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Manteiga, sem sal' LIMIT 1;

-- Jantar: Arroz, tipo 1, cozido (50g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 50.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Jantar: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Jantar: Frango, peito, sem pele, grelhado (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 2, '54102542643', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;


--  PLANO 3 — HELENA
-- Café da manhã: Pão, aveia, forma (1 fatia)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Fatia(s)', '2023-10-01', 'Café da manhã', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, aveia, forma' LIMIT 1;

-- Café da manhã: Ovo, de galinha, inteiro, frito (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, frito' LIMIT 1;

-- Café da manhã: Tomate, com semente, cru (3 fatias)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 3.0, 'Fatia(s)', '2023-10-01', 'Café da manhã', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Tomate, com semente, cru' LIMIT 1;

-- Lanche da manhã: Iogurte, natural (1 porção 100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Lanche da manhã', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Iogurte, natural' LIMIT 1;

-- Lanche da manhã: Morango, cru (à vontade — registrado como 100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da manhã', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Morango, cru' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Carne, bovina, contra-filé de costela, grelhado (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Carne, bovina, contra-filé de costela, grelhado' LIMIT 1;

-- Almoço: Alface, americana, crua (à vontade — 80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Alface, americana, crua' LIMIT 1;

-- Lanche da tarde: Banana, maçã, crua (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Lanche da tarde', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Banana, maçã, crua' LIMIT 1;

-- Jantar: Arroz, tipo 1, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Jantar: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Jantar: Frango, peito, sem pele, grelhado (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Jantar: Cenoura, cozida (à vontade — 80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Cenoura, cozida' LIMIT 1;

-- Jantar: Batata, doce, cozida (à vontade — 100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Batata, doce, cozida' LIMIT 1;

-- Ceia: Cereal matinal, milho (50g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 50.0, 'Grama(s) (g)', '2023-10-01', 'Ceia', 3, '51508589870', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Cereal matinal, milho' LIMIT 1;


--  PLANO 4 — LUCAS FERREIRA
-- Café da manhã: Aveia, flocos, crua (40g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 40.0, 'Grama(s) (g)', '2023-10-01', 'Café da manhã', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Aveia, flocos, crua' LIMIT 1;

-- Café da manhã: Banana, maçã, crua (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Banana, maçã, crua' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Carne, bovina, patinho, sem gordura, grelhado (120g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 120.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Carne, bovina, patinho, sem gordura, grelhado' LIMIT 1;

-- Almoço: Beterraba, cozida (80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Beterraba, cozida' LIMIT 1;

-- Lanche da tarde: Maçã, Fuji, com casca, crua (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Lanche da tarde', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Maçã, Fuji, com casca, crua' LIMIT 1;

-- Jantar: Frango, peito, sem pele, grelhado (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Jantar: Lentilha, cozida (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Lentilha, cozida' LIMIT 1;

-- Jantar: Abobrinha, italiana, cozida (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 4, '33322211100', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Abobrinha, italiana, cozida' LIMIT 1;


--  PLANO 5 — RODRIGO NASCIMENTO
-- Café da manhã: Pão, aveia, forma (2 fatias)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Fatia(s)', '2023-10-01', 'Café da manhã', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, aveia, forma' LIMIT 1;

-- Café da manhã: Ovo, de galinha, inteiro, cozido (3 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 3.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, cozido/10minutos' LIMIT 1;

-- Lanche da manhã: Mamão, Formosa, cru (200g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 200.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da manhã', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Mamão, Formosa, cru' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Frango, sobrecoxa, sem pele, assada (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, sobrecoxa, sem pele, assada' LIMIT 1;

-- Almoço: Alface, americana, crua (à vontade — 80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Alface, americana, crua' LIMIT 1;

-- Lanche da tarde: Laranja, baía, crua (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Lanche da tarde', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Laranja, baía, crua' LIMIT 1;

-- Jantar: Arroz, tipo 1, cozido (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Jantar: Salmão, filé, com pele, fresco, grelhado (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Salmão, filé, com pele, fresco,  grelhado' LIMIT 1;

-- Jantar: Abobrinha, italiana, cozida (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Abobrinha, italiana, cozida' LIMIT 1;

-- Ceia: Ovo, de galinha, inteiro, cozido (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Ceia', 5, '55544433322', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, cozido/10minutos' LIMIT 1;


--  PLANO 6 — GUSTAVO MENDES
-- Café da manhã: Pão, aveia, forma (1 fatia)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Fatia(s)', '2023-10-01', 'Café da manhã', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, aveia, forma' LIMIT 1;

-- Café da manhã: Ovo, de galinha, inteiro, cozido (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, cozido/10minutos' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Frango, peito, sem pele, grelhado (120g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 120.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Almoço: Abóbora, cabotian, cozida (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Abóbora, cabotian, cozida' LIMIT 1;

-- Lanche da tarde: Maçã, Fuji, com casca, crua (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Lanche da tarde', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Maçã, Fuji, com casca, crua' LIMIT 1;

-- Jantar: Frango, peito, sem pele, grelhado (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Jantar: Lentilha, cozida (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Jantar', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Lentilha, cozida' LIMIT 1;

-- Jantar: Cenoura, cozida (80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 6, '77766655544', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Cenoura, cozida' LIMIT 1;


--  PLANO 7 — JULIANA TORRES
-- Café da manhã: Pão, trigo, francês (1 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Pão, trigo, francês' LIMIT 1;

-- Café da manhã: Ovo, de galinha, inteiro, frito (2 un)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 2.0, 'Unidade(s)', '2023-10-01', 'Café da manhã', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Ovo, de galinha, inteiro, frito' LIMIT 1;

-- Café da manhã: Mamão, Formosa, cru (150g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 150.0, 'Grama(s) (g)', '2023-10-01', 'Café da manhã', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Mamão, Formosa, cru' LIMIT 1;

-- Almoço: Arroz, tipo 1, cozido (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Arroz, tipo 1, cozido' LIMIT 1;

-- Almoço: Feijão, carioca, cozido (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Feijão, carioca, cozido' LIMIT 1;

-- Almoço: Carne, bovina, patinho, sem gordura, grelhado (120g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 120.0, 'Grama(s) (g)', '2023-10-01', 'Almoço', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Carne, bovina, patinho, sem gordura, grelhado' LIMIT 1;

-- Almoço: Salada, de legumes, cozida no vapor (1 porção)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 1.0, 'Porção(ões) (100g)', '2023-10-01', 'Almoço', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Salada, de legumes, cozida no vapor' LIMIT 1;

-- Lanche da tarde: Uva, Itália, crua (100g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 100.0, 'Grama(s) (g)', '2023-10-01', 'Lanche da tarde', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Uva, Itália, crua' LIMIT 1;

-- Jantar: Frango, peito, sem pele, grelhado (130g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 130.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Frango, peito, sem pele, grelhado' LIMIT 1;

-- Jantar: Beterraba, cozida (80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Beterraba, cozida' LIMIT 1;

-- Jantar: Cenoura, cozida (80g)
INSERT INTO `refeiçao_alimento` (`alimentos_idalimentos`,`quantidade`,`unidade_medida`,`refeicoes_data_refeicao`,`refeicoes_nome_refeição`,`refeicoes_plano_nutricional_idplano_nutricional`,`refeicoes_plano_nutricional_paciente_cpf`,`refeicoes_plano_nutricional_data_plano`)
SELECT idalimentos, 80.0, 'Grama(s) (g)', '2023-10-01', 'Jantar', 7, '88877766655', '2023-10-01'
FROM `alimentos` WHERE `descricao` = 'Cenoura, cozida' LIMIT 1;



--  VIEW 1: vw_calorias_por_refeicao
CREATE OR REPLACE VIEW `vw_calorias_por_refeicao` AS
SELECT
    pn.idplano_nutricional                                              AS plano_id,
    pn.paciente_cpf                                                     AS cpf,
    p.Nome                                                              AS nome_paciente,
    r.nome_refeição                                                     AS refeicao,
    al.descricao                                                        AS alimento,
    ra.quantidade,
    ra.unidade_medida,
    ROUND(al.energia_kcal * ra.quantidade / 100, 2)                    AS kcal,
    ROUND(al.proteina    * ra.quantidade / 100, 2)                     AS proteina_g,
    ROUND(al.carboidrato * ra.quantidade / 100, 2)                     AS carb_g,
    ROUND(al.lipideos    * ra.quantidade / 100, 2)                     AS lipideos_g,
    ROUND(al.fibra_alimentar * ra.quantidade / 100, 2)                 AS fibra_g
FROM `refeiçao_alimento` ra
JOIN `alimentos`          al ON al.idalimentos            = ra.alimentos_idalimentos
JOIN `refeicoes`          r  ON r.data_refeicao           = ra.refeicoes_data_refeicao
                             AND r.nome_refeição           = ra.refeicoes_nome_refeição
                             AND r.plano_nutricional_idplano_nutricional = ra.refeicoes_plano_nutricional_idplano_nutricional
                             AND r.plano_nutricional_paciente_cpf        = ra.refeicoes_plano_nutricional_paciente_cpf
                             AND r.plano_nutricional_data_plano          = ra.refeicoes_plano_nutricional_data_plano
JOIN `plano_nutricional`  pn ON pn.idplano_nutricional    = r.plano_nutricional_idplano_nutricional
JOIN `paciente`           p  ON p.CPF                     = pn.paciente_cpf;



-- CONSULTAS ALIMENTOS
-- Cereais — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Cereais e derivados'
ORDER BY descricao ASC;

-- Carnes — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Carnes e derivados'
ORDER BY descricao ASC;

-- Hortaliças — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Verduras, hortaliças e derivados'
ORDER BY descricao ASC;

-- Leguminosas — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Leguminosas e derivados'
ORDER BY descricao ASC;

-- Laticínios — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Leite e derivados'
ORDER BY descricao ASC;

-- Frutas — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Frutas e derivados'
ORDER BY descricao ASC;

-- Óleos e gorduras — A–Z
SELECT idalimentos, descricao, energia_kcal, proteina, carboidrato, lipideos
FROM `alimentos`
WHERE categoria = 'Gorduras e óleos'
ORDER BY descricao ASC;


--  VIEW 2: vw_pacientes_completo
CREATE OR REPLACE VIEW `vw_pacientes_completo` AS
SELECT
    p.CPF,
    p.Nome,
    p.sexo,
    p.data_nasc,
    TIMESTAMPDIFF(YEAR, p.data_nasc, CURDATE())     AS idade,
    p.etnia,
    p.profissão,
    p.telefone,
    p.email,
    a.objetivo,
    a.peso,
    a.altura,
    ROUND(a.peso / POW(a.altura / 100, 2), 2)        AS imc,
    a.nivel_atividadefisica,
    a.doencas_diagnosticadas,
    a.alergias,
    a.intolerancias,
    pn.idplano_nutricional                           AS plano_id,
    pn.data_plano,
    CASE
        WHEN pn.idplano_nutricional IS NOT NULL THEN 'Com plano'
        ELSE 'Sem plano'
    END                                              AS status_plano
FROM `paciente` p
JOIN  `paciente_anamnese`     a  ON a.paciente_CPF  = p.CPF
LEFT JOIN `plano_nutricional` pn ON pn.paciente_cpf = p.CPF;

--  VIEW 3: vw_imc_pacientes
CREATE OR REPLACE VIEW `vw_imc_pacientes` AS
SELECT
    p.CPF,
    p.Nome,
    a.peso,
    a.altura,
    ROUND(a.peso / POW(a.altura / 100, 2), 2) AS imc,
    CASE
        WHEN p.etnia = 'Amarela' THEN
            CASE
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 18.5 THEN 'Abaixo do peso'
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 23   THEN 'Peso saudável'
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 25   THEN 'Sobrepeso'
                ELSE 'Obesidade'
            END
        ELSE
            CASE
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 18.5 THEN 'Abaixo do peso'
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 25   THEN 'Peso saudável'
                WHEN ROUND(a.peso / POW(a.altura / 100, 2), 2) < 30   THEN 'Sobrepeso'
                ELSE 'Obesidade'
            END
    END AS classificacao_imc,
    a.objetivo
FROM `paciente` p
JOIN `paciente_anamnese` a ON a.paciente_CPF = p.CPF;

--  VIEW 4: vw_tmb_gasto
CREATE OR REPLACE VIEW `vw_tmb_gasto` AS
SELECT
    p.CPF,
    p.Nome,
    a.objetivo,
    a.peso,
    CASE
        WHEN p.sexo = 'F' THEN ROUND(447.593 + (9.247 * a.peso) + (3.098 * a.altura) - (4.330 * TIMESTAMPDIFF(YEAR, p.data_nasc, CURDATE())), 2)
        ELSE ROUND(88.362 + (13.397 * a.peso) + (4.799 * a.altura) - (5.677 * TIMESTAMPDIFF(YEAR, p.data_nasc, CURDATE())), 2)
    END AS tmb,
    ROUND(
        (CASE
            WHEN p.sexo = 'F' THEN (447.593 + (9.247 * a.peso) + (3.098 * a.altura) - (4.330 * TIMESTAMPDIFF(YEAR, p.data_nasc, CURDATE())))
            ELSE (88.362 + (13.397 * a.peso) + (4.799 * a.altura) - (5.677 * TIMESTAMPDIFF(YEAR, p.data_nasc, CURDATE())))
        END) *
        CASE a.nivel_atividadefisica
            WHEN 'Sedentário (não pratica exercícios)'                   THEN 1.200
            WHEN 'Leve (1-2x por semana)'                                THEN 1.375
            WHEN 'Moderado (3-4x por semana)'                            THEN 1.550
            WHEN 'Intenso (5-6x por semana)'                             THEN 1.725
            WHEN 'Atleta/treino diário'                                  THEN 1.900
            WHEN 'Trabalho fisicamente ativo (ex: estoquista, operario)' THEN 1.725
            ELSE 1.200
        END
    , 2) AS gasto_total_kcal,
    CASE a.objetivo
        WHEN 'Emagrecimento' THEN ROUND(a.peso * 1.2, 1)
        WHEN 'Manutenção'    THEN ROUND(a.peso * 0.8, 1)
        WHEN 'Hipertrofia'   THEN ROUND(a.peso * 1.6, 1)
    END AS meta_prot_min_g,
    CASE a.objetivo
        WHEN 'Emagrecimento' THEN ROUND(a.peso * 1.6, 1)
        WHEN 'Manutenção'    THEN ROUND(a.peso * 1.2, 1)
        WHEN 'Hipertrofia'   THEN ROUND(a.peso * 2.2, 1)
    END AS meta_prot_max_g
FROM `paciente` p
JOIN `paciente_anamnese` a ON a.paciente_CPF = p.CPF;

-- CONSULTAS PACIENTES
-- Todos os pacientes A–Z
SELECT CPF, Nome, idade, sexo, objetivo, status_plano
FROM `vw_pacientes_completo`
ORDER BY Nome ASC;

-- Com plano — mais recentes (data do plano)
SELECT CPF, Nome, objetivo, plano_id, data_plano
FROM `vw_pacientes_completo`
WHERE status_plano = 'Com plano'
ORDER BY data_plano DESC, Nome ASC;

-- Sem plano — A–Z
SELECT CPF, Nome, data_nasc, objetivo, email
FROM `vw_pacientes_completo`
WHERE status_plano = 'Sem plano'
ORDER BY Nome ASC;

-- Emagrecimento — A–Z
SELECT CPF, Nome, data_nasc, imc, nivel_atividadefisica, status_plano
FROM `vw_pacientes_completo`
WHERE objetivo = 'Emagrecimento'
ORDER BY Nome ASC;

-- Manutenção — A–Z
SELECT CPF, Nome, data_nasc, imc, nivel_atividadefisica, status_plano
FROM `vw_pacientes_completo`
WHERE objetivo = 'Manutenção'
ORDER BY Nome ASC;

-- Hipertrofia — A–Z
SELECT CPF, Nome, data_nasc, imc, nivel_atividadefisica, status_plano
FROM `vw_pacientes_completo`
WHERE objetivo = 'Hipertrofia'
ORDER BY Nome ASC;




--  STORED PROCEDURE 1: sp_cadastrar_paciente
DROP PROCEDURE IF EXISTS `sp_cadastrar_paciente`;

DELIMITER $$
CREATE PROCEDURE `sp_cadastrar_paciente` (
    IN  p_cpf               VARCHAR(11),
    IN  p_nome              VARCHAR(45),
    IN  p_data_nasc         DATE,
    IN  p_sexo              CHAR(1),
    IN  p_gravidez          CHAR(3),
    IN  p_etnia             VARCHAR(45),
    IN  p_profissao         VARCHAR(45),
    IN  p_telefone          VARCHAR(15),
    IN  p_email             VARCHAR(255),
    IN  p_nutricionista_id  INT,
    IN  p_objetivo          ENUM('Emagrecimento','Manutenção','Hipertrofia'),
    IN  p_doencas           VARCHAR(200),
    IN  p_medicamentos      VARCHAR(200),
    IN  p_intolerancias     VARCHAR(200),
    IN  p_alergias          VARCHAR(200),
    IN  p_freq_intestinal   ENUM('1x ao dia (normal)','2x ao dia','A cada 2 dias','A cada 3 dias','A cada 4–5 dias','Menos de 1x por semana'),
    IN  p_qualidade_sono    ENUM('Excelente (sono reparador)','Bom (dorme bem na maioria dos dias)','Regular (acorda algumas vezes, sono leve)','Ruim (dificuldade para dormir ou manter o sono)','Insônia (demora para dormir ou acorda muitas vezes)'),
    IN  p_peso              FLOAT,
    IN  p_altura            FLOAT,
    IN  p_cintura           FLOAT,
    IN  p_atividade         ENUM('Sedentário (não pratica exercícios)','Leve (1-2x por semana)','Moderado (3-4x por semana)','Intenso (5-6x por semana)','Atleta/treino diário','Trabalho fisicamente ativo (ex: estoquista, operario)'),
    IN  p_consumo_agua      ENUM('Menos de 500 ml/dia','Entre 500 ml e 1 L/dia','Entre 1 L e 1,5 L/dia','Entre 1,5 L e 2 L/dia','Entre 2 L e 3 L/dia','Mais de 3 L/dia'),
    IN  p_alcool            ENUM('Não consome','Raramente (1x/mês ou menos)','Socialmente (2–4x/mês)','1x por semana','2–3x por semana','4–5x por semana','Diariamente','Ex-consumidor'),
    IN  p_meta_1            VARCHAR(45),
    IN  p_meta_2            VARCHAR(45),
    IN  p_meta_3            VARCHAR(45),
    IN  p_peitoral          FLOAT,
    IN  p_axilar_media      FLOAT,
    IN  p_triceps           FLOAT,
    IN  p_subescapular      FLOAT,
    IN  p_abdomen           FLOAT,
    IN  p_suprailiaca       FLOAT,
    IN  p_coxa              FLOAT,
    OUT o_imc               DECIMAL(5,2),
    OUT o_classificacao_imc VARCHAR(20),
    OUT o_relacao_ca        DECIMAL(6,4),
    OUT o_classificacao_ca  VARCHAR(20),
    OUT o_tmb               DECIMAL(7,2),
    OUT o_gasto_total       DECIMAL(7,2),
    OUT o_percentual_bf     DECIMAL(5,2),
    OUT o_agua_ml           INT
)
BEGIN
    DECLARE v_idade         INT;
    DECLARE v_soma_dobras   FLOAT;
    DECLARE v_dc            FLOAT;

    INSERT INTO `paciente`
        (`CPF`, `Nome`, `data_nasc`, `sexo`, `gravidez`, `etnia`,
         `profissão`, `telefone`, `email`, `nutricionista_id_nutricionista`)
    VALUES
        (p_cpf, p_nome, p_data_nasc, p_sexo, p_gravidez, p_etnia,
         p_profissao, p_telefone, p_email, p_nutricionista_id);

    INSERT INTO `paciente_anamnese`
        (`objetivo`, `doencas_diagnosticadas`, `medicamentos_continuos`,
         `intolerancias`, `alergias`, `freq_intestinal`, `qualidade_sono`,
         `peso`, `altura`, `circunferencia_cintura`, `metodo_tmb`, `nivel_atividadefisica`,
         `consumo_agua`, `alcoool`, `meta_1`, `meta_2`, `meta_3`,
         `peitoral`, `axilar_media`, `triceps`, `subescapular`,
         `abdomen`, `suprailiaca`, `coxa`,
         `paciente_CPF`, `paciente_nutricionista_id_nutricionista`)
    VALUES
        (p_objetivo, p_doencas, p_medicamentos,
         p_intolerancias, p_alergias, p_freq_intestinal, p_qualidade_sono,
         p_peso, p_altura, p_cintura, p_atividade,
         p_consumo_agua, p_alcool, p_meta_1, p_meta_2, p_meta_3,
         p_peitoral, p_axilar_media, p_triceps, p_subescapular,
         p_abdomen, p_suprailiaca, p_coxa,
         p_cpf, p_nutricionista_id);

    SET v_idade = TIMESTAMPDIFF(YEAR, p_data_nasc, CURDATE());

    -- IMC
    SET o_imc = ROUND(p_peso / POW(p_altura / 100, 2), 2);

    IF p_etnia = 'Amarela' THEN
        SET o_classificacao_imc = CASE
            WHEN o_imc < 18.5 THEN 'Abaixo do peso'
            WHEN o_imc < 23   THEN 'Peso saudável'
            WHEN o_imc < 25   THEN 'Sobrepeso'
            ELSE 'Obesidade'
        END;
    ELSE
        SET o_classificacao_imc = CASE
            WHEN o_imc < 18.5 THEN 'Abaixo do peso'
            WHEN o_imc < 25   THEN 'Peso saudável'
            WHEN o_imc < 30   THEN 'Sobrepeso'
            ELSE 'Obesidade'
        END;
    END IF;

    SET o_relacao_ca = ROUND(p_cintura / p_altura, 4);
    SET o_classificacao_ca = CASE
        WHEN o_relacao_ca < 0.40 THEN 'Muito magro'
        WHEN o_relacao_ca < 0.50 THEN 'Saudável'
        WHEN o_relacao_ca < 0.60 THEN 'Risco aumentado'
        ELSE 'Risco alto'
    END;

    IF p_sexo = 'F' THEN
        SET o_tmb = ROUND(447.593 + (9.247 * p_peso) + (3.098 * p_altura) - (4.330 * v_idade), 2);
    ELSE
        SET o_tmb = ROUND(88.362 + (13.397 * p_peso) + (4.799 * p_altura) - (5.677 * v_idade), 2);
    END IF;

    -- GET
    SET o_gasto_total = ROUND(o_tmb *
        CASE p_atividade
            WHEN 'Sedentário (não pratica exercícios)'                   THEN 1.200
            WHEN 'Leve (1-2x por semana)'                                THEN 1.375
            WHEN 'Moderado (3-4x por semana)'                            THEN 1.550
            WHEN 'Intenso (5-6x por semana)'                             THEN 1.725
            WHEN 'Atleta/treino diário'                                  THEN 1.900
            WHEN 'Trabalho fisicamente ativo (ex: estoquista, operario)' THEN 1.725
            ELSE 1.200
        END
    , 2);

    SET v_soma_dobras = p_peitoral + p_axilar_media + p_triceps + p_subescapular + p_abdomen + p_suprailiaca + p_coxa;
    IF p_sexo = 'F' THEN
        SET v_dc = 1.0970 - (0.00046971 * v_soma_dobras) + (0.00000056 * POW(v_soma_dobras, 2)) - (0.00012828 * v_idade);
    ELSE
        SET v_dc = 1.1120 - (0.00043499 * v_soma_dobras) + (0.00000055 * POW(v_soma_dobras, 2)) - (0.00028826 * v_idade);
    END IF;
    SET o_percentual_bf = ROUND(((4.95 / v_dc) - 4.50) * 100, 2);

    SET o_agua_ml = ROUND(
        (p_peso * 35)
        + CASE p_atividade
            WHEN 'Sedentário (não pratica exercícios)'                   THEN 0
            WHEN 'Leve (1-2x por semana)'                                THEN 300
            WHEN 'Moderado (3-4x por semana)'                            THEN 500
            WHEN 'Intenso (5-6x por semana)'                             THEN 800
            WHEN 'Atleta/treino diário'                                  THEN 1000
            ELSE 1200
          END
        + CASE WHEN p_objetivo = 'Emagrecimento' THEN (p_peso * 35) * 0.10 ELSE 0 END
        + CASE p_alcool
            WHEN 'Não consome'                  THEN 0
            WHEN 'Raramente (1x/mês ou menos)'  THEN 150
            WHEN 'Socialmente (2–4x/mês)'       THEN 250
            WHEN '1x por semana'                THEN 300
            WHEN '2–3x por semana'              THEN 400
            ELSE 500
          END
    , 0);

END$$

DELIMITER ;


--  STORED PROCEDURE 2: sp_criar_plano
DROP PROCEDURE IF EXISTS `sp_criar_plano`;

DELIMITER $$

CREATE PROCEDURE `sp_criar_plano` (
    IN  p_paciente_cpf  VARCHAR(11),
    IN  p_data_plano    VARCHAR(45),
    OUT o_plano_id      INT,
    OUT o_status        VARCHAR(100)
)
BEGIN
    DECLARE v_paciente_existe INT DEFAULT 0;

    SELECT COUNT(*) INTO v_paciente_existe
    FROM `paciente`
    WHERE CPF = p_paciente_cpf;

    IF v_paciente_existe = 0 THEN
        SET o_plano_id = NULL;
        SET o_status   = 'ERRO: Paciente não encontrado para o CPF informado.';
    ELSE
        INSERT INTO `plano_nutricional` (`paciente_cpf`, `data_plano`)
        VALUES (p_paciente_cpf, p_data_plano);

        SET o_plano_id = LAST_INSERT_ID();
        SET o_status   = CONCAT('OK: Plano #', o_plano_id, ' criado para CPF ', p_paciente_cpf, ' em ', p_data_plano, '.');
    END IF;

END$$

DELIMITER ;


--  TABELA AUXILIAR: paciente_indicadores
--  Armazena indicadores pré-calculados para uso pelos triggers.
CREATE TABLE IF NOT EXISTS `nutriplanner`.`paciente_indicadores` (
    `id`                    INT         NOT NULL AUTO_INCREMENT,
    `paciente_cpf`          VARCHAR(11) NOT NULL,
    `atualizado_em`         DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `peso`                  FLOAT       NOT NULL,
    `altura`                FLOAT       NOT NULL,
    `imc`                   DECIMAL(5,2),
    `classificacao_imc`     VARCHAR(20),
    `relacao_ca`            DECIMAL(6,4),
    `classificacao_ca`      VARCHAR(20),
    `tmb`                   DECIMAL(7,2),
    `gasto_total_kcal`      DECIMAL(7,2),
    `percentual_gordura`    DECIMAL(5,2),
    `agua_recomendada_ml`   INT,
    PRIMARY KEY (`id`),
    INDEX `idx_cpf` (`paciente_cpf` ASC),
    CONSTRAINT `fk_indicadores_paciente`
        FOREIGN KEY (`paciente_cpf`)
        REFERENCES `nutriplanner`.`paciente` (`CPF`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


--  TABELA AUXILIAR: plano_totais
--  Atualizada automaticamente pelo trigger trg_atualizar_totais_plano.
CREATE TABLE IF NOT EXISTS `nutriplanner`.`plano_totais` (
    `plano_id`              INT         NOT NULL,
    `paciente_cpf`          VARCHAR(11) NOT NULL,
    `data_plano`            VARCHAR(45) NOT NULL,
    `ultima_atualizacao`    DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `total_kcal`            DECIMAL(8,2) DEFAULT 0,
    `total_proteina_g`      DECIMAL(8,2) DEFAULT 0,
    `total_carboidrato_g`   DECIMAL(8,2) DEFAULT 0,
    `total_lipideos_g`      DECIMAL(8,2) DEFAULT 0,
    `total_fibra_g`         DECIMAL(8,2) DEFAULT 0,
    PRIMARY KEY (`plano_id`),
    CONSTRAINT `fk_totais_plano`
        FOREIGN KEY (`plano_id`)
        REFERENCES `nutriplanner`.`plano_nutricional` (`idplano_nutricional`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


--  TRIGGER 1: trg_recalcular_indicadores
DROP TRIGGER IF EXISTS `trg_recalcular_indicadores`;

DELIMITER $$

CREATE TRIGGER `trg_recalcular_indicadores`
AFTER UPDATE ON `paciente_anamnese`
FOR EACH ROW
BEGIN
    DECLARE v_sexo      CHAR(1);
    DECLARE v_etnia     VARCHAR(45);
    DECLARE v_data_nasc DATE;
    DECLARE v_idade     INT;
    DECLARE v_imc       DECIMAL(5,2);
    DECLARE v_class_imc VARCHAR(20);
    DECLARE v_rca       DECIMAL(6,4);
    DECLARE v_class_ca  VARCHAR(20);
    DECLARE v_tmb       DECIMAL(7,2);
    DECLARE v_get       DECIMAL(7,2);
    DECLARE v_soma_d    FLOAT;
    DECLARE v_dc        FLOAT;
    DECLARE v_bf        DECIMAL(5,2);
    DECLARE v_agua      INT;

    IF (NEW.peso <> OLD.peso OR NEW.altura <> OLD.altura) THEN

        SELECT p.sexo, p.etnia, p.data_nasc
        INTO   v_sexo, v_etnia, v_data_nasc
        FROM   `paciente` p
        WHERE  p.CPF = NEW.paciente_CPF
        LIMIT 1;

        SET v_idade = TIMESTAMPDIFF(YEAR, v_data_nasc, CURDATE());

        SET v_imc = ROUND(NEW.peso / POW(NEW.altura / 100, 2), 2);

        IF v_etnia = 'Amarela' THEN
            SET v_class_imc = CASE
                WHEN v_imc < 18.5 THEN 'Abaixo do peso'
                WHEN v_imc < 23   THEN 'Peso saudável'
                WHEN v_imc < 25   THEN 'Sobrepeso'
                ELSE 'Obesidade'
            END;
        ELSE
            SET v_class_imc = CASE
                WHEN v_imc < 18.5 THEN 'Abaixo do peso'
                WHEN v_imc < 25   THEN 'Peso saudável'
                WHEN v_imc < 30   THEN 'Sobrepeso'
                ELSE 'Obesidade'
            END;
        END IF;

        SET v_rca = ROUND(NEW.circunferencia_cintura / NEW.altura, 4);
        SET v_class_ca = CASE
            WHEN v_rca < 0.40 THEN 'Muito magro'
            WHEN v_rca < 0.50 THEN 'Saudável'
            WHEN v_rca < 0.60 THEN 'Risco aumentado'
            ELSE 'Risco alto'
        END;

        IF v_sexo = 'F' THEN
            SET v_tmb = ROUND(447.593 + (9.247 * NEW.peso) + (3.098 * NEW.altura) - (4.330 * v_idade), 2);
        ELSE
            SET v_tmb = ROUND(88.362 + (13.397 * NEW.peso) + (4.799 * NEW.altura) - (5.677 * v_idade), 2);
        END IF;

        SET v_get = ROUND(v_tmb *
            CASE NEW.nivel_atividadefisica
                WHEN 'Sedentário (não pratica exercícios)'                   THEN 1.200
                WHEN 'Leve (1-2x por semana)'                                THEN 1.375
                WHEN 'Moderado (3-4x por semana)'                            THEN 1.550
                WHEN 'Intenso (5-6x por semana)'                             THEN 1.725
                WHEN 'Atleta/treino diário'                                  THEN 1.900
                WHEN 'Trabalho fisicamente ativo (ex: estoquista, operario)' THEN 1.725
                ELSE 1.200
            END
        , 2);

        SET v_soma_d = NEW.peitoral + NEW.axilar_media + NEW.triceps + NEW.subescapular + NEW.abdomen + NEW.suprailiaca + NEW.coxa;
        IF v_sexo = 'F' THEN
            SET v_dc = 1.0970 - (0.00046971 * v_soma_d) + (0.00000056 * POW(v_soma_d, 2)) - (0.00012828 * v_idade);
        ELSE
            SET v_dc = 1.1120 - (0.00043499 * v_soma_d) + (0.00000055 * POW(v_soma_d, 2)) - (0.00028826 * v_idade);
        END IF;
        SET v_bf = ROUND(((4.95 / v_dc) - 4.50) * 100, 2);

        SET v_agua = ROUND(
            (NEW.peso * 35)
            + CASE NEW.nivel_atividadefisica
                WHEN 'Sedentário (não pratica exercícios)'                   THEN 0
                WHEN 'Leve (1-2x por semana)'                                THEN 300
                WHEN 'Moderado (3-4x por semana)'                            THEN 500
                WHEN 'Intenso (5-6x por semana)'                             THEN 800
                WHEN 'Atleta/treino diário'                                  THEN 1000
                ELSE 1200
              END
            + CASE WHEN NEW.objetivo = 'Emagrecimento' THEN (NEW.peso * 35) * 0.10 ELSE 0 END
            + CASE NEW.alcoool
                WHEN 'Não consome'                  THEN 0
                WHEN 'Raramente (1x/mês ou menos)'  THEN 150
                WHEN 'Socialmente (2–4x/mês)'       THEN 250
                WHEN '1x por semana'                THEN 300
                WHEN '2–3x por semana'              THEN 400
                ELSE 500
              END
        , 0);

        INSERT INTO `paciente_indicadores`
            (`paciente_cpf`, `atualizado_em`, `peso`, `altura`,
             `imc`, `classificacao_imc`, `relacao_ca`, `classificacao_ca`,
             `tmb`, `gasto_total_kcal`, `percentual_gordura`, `agua_recomendada_ml`)
        VALUES
            (NEW.paciente_CPF, NOW(), NEW.peso, NEW.altura,
             v_imc, v_class_imc, v_rca, v_class_ca,
             v_tmb, v_get, v_bf, v_agua);

    END IF;
END$$

DELIMITER ;


--  TRIGGER 2: trg_atualizar_totais_plano
DROP TRIGGER IF EXISTS `trg_atualizar_totais_plano`;

DELIMITER $$

CREATE TRIGGER `trg_atualizar_totais_plano`
AFTER INSERT ON `refeiçao_alimento`
FOR EACH ROW
BEGIN
    DECLARE v_plano_id      INT;
    DECLARE v_paciente_cpf  VARCHAR(11);
    DECLARE v_data_plano    VARCHAR(45);

    SET v_plano_id     = NEW.refeicoes_plano_nutricional_idplano_nutricional;
    SET v_paciente_cpf = NEW.refeicoes_plano_nutricional_paciente_cpf;
    SET v_data_plano   = NEW.refeicoes_plano_nutricional_data_plano;

    INSERT INTO `plano_totais`
        (`plano_id`, `paciente_cpf`, `data_plano`,
         `total_kcal`, `total_proteina_g`, `total_carboidrato_g`, `total_lipideos_g`, `total_fibra_g`)
    SELECT
        v_plano_id,
        v_paciente_cpf,
        v_data_plano,
        ROUND(SUM(al.energia_kcal   * ra.quantidade / 100), 2),
        ROUND(SUM(al.proteina       * ra.quantidade / 100), 2),
        ROUND(SUM(al.carboidrato    * ra.quantidade / 100), 2),
        ROUND(SUM(al.lipideos       * ra.quantidade / 100), 2),
        ROUND(SUM(al.fibra_alimentar * ra.quantidade / 100), 2)
    FROM `refeiçao_alimento` ra
    JOIN `alimentos`          al ON al.idalimentos = ra.alimentos_idalimentos
    WHERE ra.refeicoes_plano_nutricional_idplano_nutricional = v_plano_id
      AND ra.refeicoes_plano_nutricional_paciente_cpf        = v_paciente_cpf
      AND ra.refeicoes_plano_nutricional_data_plano          = v_data_plano

    ON DUPLICATE KEY UPDATE
        `total_kcal`            = VALUES(`total_kcal`),
        `total_proteina_g`      = VALUES(`total_proteina_g`),
        `total_carboidrato_g`   = VALUES(`total_carboidrato_g`),
        `total_lipideos_g`      = VALUES(`total_lipideos_g`),
        `total_fibra_g`         = VALUES(`total_fibra_g`),
        `ultima_atualizacao`    = NOW();

END$$

DELIMITER ;


--  CONSULTA 1: Pacientes com IMC acima de 25 (sobrepeso/obesidade)
SELECT
    CPF,
    Nome,
    peso,
    altura,
    imc,
    classificacao_imc,
    objetivo
FROM `vw_imc_pacientes`
WHERE imc > 25
ORDER BY imc DESC;


--  CONSULTA 2: Total calórico diário por paciente e plano
SELECT
    plano_id,
    cpf,
    nome_paciente,
    ROUND(SUM(kcal),       1)   AS total_kcal,
    ROUND(SUM(proteina_g), 1)   AS total_proteina_g,
    ROUND(SUM(carb_g),     1)   AS total_carb_g,
    ROUND(SUM(lipideos_g), 1)   AS total_lipideos_g,
    ROUND(SUM(fibra_g),    1)   AS total_fibra_g
FROM `vw_calorias_por_refeicao`
GROUP BY plano_id, cpf, nome_paciente
ORDER BY total_kcal DESC;


--  CONSULTA 3: Consumo de proteínas vs meta (mín e máx)
SELECT
    cr.plano_id,
    cr.cpf,
    cr.nome_paciente,
    ROUND(SUM(cr.proteina_g), 1)    AS proteina_consumida_g,
    tg.meta_prot_min_g,
    tg.meta_prot_max_g,
    CASE
        WHEN SUM(cr.proteina_g) < tg.meta_prot_min_g THEN 'Abaixo da meta'
        WHEN SUM(cr.proteina_g) > tg.meta_prot_max_g THEN 'Acima da meta'
        ELSE 'Dentro da meta'
    END                             AS status_proteina
FROM `vw_calorias_por_refeicao` cr
JOIN `vw_tmb_gasto`             tg ON tg.CPF = cr.cpf
GROUP BY cr.plano_id, cr.cpf, cr.nome_paciente, tg.meta_prot_min_g, tg.meta_prot_max_g
ORDER BY cr.nome_paciente;


--  CONSULTA 4: Refeição com mais calorias por plano
SELECT
    plano_id,
    cpf,
    nome_paciente,
    refeicao,
    ROUND(SUM(kcal), 1)         AS kcal_refeicao
FROM `vw_calorias_por_refeicao`
GROUP BY plano_id, cpf, nome_paciente, refeicao
HAVING kcal_refeicao = (
    SELECT MAX(sub_total)
    FROM (
        SELECT SUM(kcal) AS sub_total
        FROM `vw_calorias_por_refeicao` sub
        WHERE sub.plano_id = vw_calorias_por_refeicao.plano_id
        GROUP BY sub.refeicao
    ) AS maximos
)
ORDER BY plano_id;


--  CONSULTA 5: Histórico de planos de um paciente ordenado por data
SELECT
    pn.idplano_nutricional      AS plano_id,
    pn.data_plano,
    p.Nome                      AS paciente,
    COUNT(DISTINCT r.nome_refeição) AS qtd_refeicoes,
    ROUND(SUM(al.energia_kcal * ra.quantidade / 100), 1) AS total_kcal_plano
FROM `plano_nutricional`  pn
JOIN `paciente`           p  ON p.CPF  = pn.paciente_cpf
JOIN `refeicoes`          r  ON r.plano_nutricional_idplano_nutricional = pn.idplano_nutricional
JOIN `refeiçao_alimento`  ra ON ra.refeicoes_plano_nutricional_idplano_nutricional = pn.idplano_nutricional
JOIN `alimentos`          al ON al.idalimentos = ra.alimentos_idalimentos
WHERE pn.paciente_cpf = '52546879835'   -- << altere o CPF aqui
GROUP BY pn.idplano_nutricional, pn.data_plano, p.Nome
ORDER BY pn.data_plano ASC;