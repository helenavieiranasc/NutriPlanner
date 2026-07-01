# NutriPlanner
<img src="https://github.com/user-attachments/assets/81dddbe8-708c-489d-8969-f7457b6666c2" align="right" width="150">

**"Mais tempo para cuidar e menos para calcular!"**

Sistema de planejamento nutricional automatizado projetado para maximizar a eficiência de nutricionistas. A plataforma centraliza a gestão de pacientes e a criação de planos alimentares personalizados, automatizando cálculos antropométricos complexos e tarefas administrativas.

## 🛠️ Funcionalidades

- [x] **Gestão de Pacientes:** Cadastro completo com anamnese, hábitos, dobras cutâneas e metas.
- [x] **Cálculos Automáticos:** IMC, relação cintura-altura, TMB (Harris-Benedict e Mifflin-St Jeor), gasto energético total, percentual de gordura, macro e micronutrientes e hidratação.
- [x] **Base de Dados TACO:** Tabela oficial brasileira de composição de alimentos (597 alimentos, 69 colunas nutricionais) integrada ao banco de dados.
- [x] **Planos Alimentares:** Criação, visualização e edição de dietas personalizadas por refeição.
- [x] **Persistência em MySQL:** Cadastro, cálculos e planos gravados em banco relacional via DAO.
- [x] **Interface Web:** Front-end completo em HTML/CSS/JS com cadastro de pacientes, dashboard, lista/busca, base de alimentos e montagem de planos.

## 🏗️ Arquitetura do Projeto

O NutriPlanner é dividido em duas partes que hoje rodam **de forma independente**:

| Módulo | Descrição | Status |
|---|---|---|
| **Backend (Python + MySQL)** | Sistema de cadastro, cálculos e persistência, rodando via terminal | Funcional, integrado ao MySQL |
| **Frontend (HTML/CSS/JS)** | Interface web completa (landing page, login, dashboard, cadastro/edição/consulta de pacientes, base TACO, montagem de plano, configurações) | Funcional (exceto a funcionalidade de edição de pacientes), ainda **não integrado** ao backend/banco - usa `localStorage` do navegador como persistência própria |

A integração entre as duas pontas (API/back-end servindo o front-end web) é o próximo passo do projeto.

> [!WARNING]
> **Rodando o front-end localmente:** o menu lateral (`containersidebar.html`) é injetado via `fetch()`, e o navegador bloqueia esse tipo de requisição quando o arquivo é aberto direto (`file://`). Por isso, para testar localmente, abra a pasta com um servidor local, como a extensão **Live Server** do VS Code. Ao publicar no **GitHub Pages**, isso funciona normalmente, já que o site passa a ser servido via HTTP.

### Estrutura do repositório

O repositório mantém a **primeira versão** do projeto (protótipo inicial, com persistência em JSON) preservada em sua pasta original, e as versões mais novas foram adicionadas em pastas separadas, com outros nomes, para não sobrescrever o histórico:

```
/
├── index.html                        → entrada do site (GitHub Pages)
├── pages/, css/, js/, imagens/,
│   tabela_alimentos/                  → demais arquivos do front-end web
├── nutriplanner_json/                       → versão 1 (protótipo, JSON)
├── nutriplanner_mysql/                  → versão atual (backend Python + MySQL)
├── diagrama_er.mwb             → diagrama ER (MySQL Workbench)
├── script.sql                → script de criação do banco (DDL, DML, views, procedures, triggers)
├── documentação.pdf 
├── LICENSE
└── README.md
```

### Backend — estrutura de pastas

```
NutriPlanner/
├── main.py                  → ponto de entrada
├── db/
│   ├── conexoes.py          → ConexaoDB (Singleton de conexão com o MySQL)
│   └── dao.py                → Data Access Object (SELECT/INSERT/UPDATE/DELETE)
├── models/
│   ├── pacientes.py          → SistemaCadastro (Singleton) e Paciente
│   ├── planos.py              → lógica de planos nutricionais
│   └── refeições.py           → lógica de refeições
├── services/
│   ├── calculos.py            → Strategy (classificação de IMC), Factory (cálculo de TMB), Facade (calcular_tudo)
│   └── alimentos.py           → TacoMySQL (fonte de alimentos via banco)
├── utils/
│   ├── constantes.py          → textos padronizados (métodos de TMB, níveis de atividade etc.)
│   └── helpers.py
└── tabela_TACO/                → CSVs de apoio (TACO, aminoácidos, ácidos graxos)
```

### Frontend — estrutura de pastas

```
Nutriplanner web/
├── pages/          → todas as telas (.html): index, home, cadastrarpaciente,
│                     editarpaciente, listapacientes, verpaciente, basealimentos,
│                     criarplano, selecionarpaciente, configuracoes
├── css/            → uma folha de estilo por tela + variables.css (cores/fontes globais)
├── js/
│   ├── dashboard.js      → menu lateral, navegação, autenticação, delegação de eventos
│   └── formularios.js    → sistema de tags removíveis (doenças, alergias etc.)
├── imagens/         → logo, ícones, gráficos estáticos
└── tabela_alimentos/
    └── taco_completo.csv → base TACO lida via JS (Papa Parse) enquanto não há API
```

## 🧩 Design Patterns e princípios SOLID aplicados

| Padrão | Onde | Para quê |
|---|---|---|
| **Singleton** | `ConexaoDB` (db/conexoes.py), `SistemaCadastro` (models/pacientes.py) | Garante uma única instância de conexão com o banco e do sistema de cadastro, evitando conflito de dados |
| **DAO (Data Access Object)** | `db/dao.py` | Isola todo o SQL (SELECT/INSERT/UPDATE/DELETE) da regra de negócio |
| **Strategy** | Classificação de IMC (`services/calculos.py`) | Cada critério de classificação (padrão, etnia amarela etc.) é uma classe própria, sem alterar as existentes ao adicionar uma nova |
| **Factory Method** | Cálculo de TMB (`CalculadoraTMBFactory`) | Isola a escolha da fórmula (Harris-Benedict/Mifflin, por sexo) em vez de if/elif espalhados |
| **Facade** | `FacadeCalculos.calcular_tudo(paciente)` | Centraliza os ~14 cálculos do sistema (IMC, TMB, gasto total, macros, micros, hidratação) em um único ponto de entrada |
| **Observer → Trigger MySQL** | Banco de dados (Triggers) | O banco atua como *Subject* e as Triggers como *Observers*, recalculando tabelas auxiliares automaticamente a cada INSERT/UPDATE (ainda não foi integrado) |
| **OCP (Open/Closed)** | `FonteDadosAlimentos` → `TacoMySQL` | Trocar a fonte de alimentos (CSV → MySQL) não exige alterar quem consome os dados, só implementar uma nova classe |
| **Centralização de constantes** | `utils/constantes.py` | Elimina strings duplicadas/erros de digitação (métodos de TMB, níveis de atividade, objetivos etc.) |

> O projeto evoluiu de uma versão inicial com persistência em **JSON** para persistência em **MySQL** via DAO - o padrão Observer permanece conceitualmente no papel das Triggers do banco (ainda não integrado).

## 🗄️ Banco de Dados

Modelagem relacional (MySQL Workbench) com as tabelas principais:

- `nutricionista`, `paciente`, `paciente_anamnese` (relação 1:N, permitindo acompanhar a evolução do paciente ao longo de várias consultas)
- `plano_nutricional`, `refeicoes`, `refeicao_alimento` (tabela associativa para resolver a relação N:N entre refeições e alimentos)
- `alimentos` — base TACO completa, com colunas nutricionais (energia, macro e micronutrientes, minerais, vitaminas)

O diagrama ER (`diagrama_nutriplanner.mwb`) e o script de criação do banco (`script_nutriplanner.sql`, com DDL, DML, índices, views, procedures e triggers) estão disponíveis no repositório.

### Views

| View | Para quê |
|---|---|
| `vw_calorias_por_refeicao` | Calorias, proteínas, carboidratos, lipídeos e fibras de cada refeição de cada plano |
| `vw_pacientes_completo` | Junta paciente + anamnese e indica se já existe um plano nutricional vinculado |
| `vw_imc_pacientes` | Calcula o IMC de cada paciente e já retorna a classificação (abaixo do peso, peso saudável, sobrepeso, obesidade) |
| `vw_tmb_gasto` | Calcula TMB, gasto calórico total e meta de proteína (mín./máx.) de cada paciente |

### Stored Procedures

- **`sp_cadastrar_paciente`** — cadastra paciente e anamnese em uma única chamada, já calculando IMC, percentual de gordura, TMB, gasto calórico total e hidratação recomendada.
- **`sp_criar_plano`** — cria um plano nutricional novo para um paciente, validando antes se ele existe no banco.

### Triggers

- **`trg_recalcular_indicadores`** — ao atualizar peso/altura na anamnese, recalcula automaticamente IMC, TMB, percentual de gordura e água recomendada.
- **`trg_atualizar_totais_plano`** — ao adicionar um alimento em uma refeição, atualiza automaticamente os totais de calorias, proteínas, carboidratos, lipídeos e fibras do plano.

### Consultas e otimização

- **Joins/Left Joins** unindo paciente, plano nutricional, refeição e alimento, e uma **subconsulta** para encontrar a refeição mais calórica de cada plano.
- **Funções de agregação** (`SUM`, `COUNT`, `MAX`, `GROUP BY`, `HAVING`) para totais de calorias/macros por plano e para a refeição mais calórica de cada paciente.
- **Índices** nas colunas mais consultadas: categoria dos alimentos, data do plano nutricional e CPF do paciente.

### Importando a tabela TACO no banco

> [!WARNING]
> Em alguns computadores, ao rodar o script completo do zero, a tabela `alimentos` fica vazia. Nesse caso, importe o CSV manualmente pelo MySQL Workbench **logo após criar as tabelas e ANTES de rodar os INSERTs das demais tabelas**:

1. Clique com o botão direito na tabela `alimentos` (ou use o ícone de import/export acima do Result Grid) e abra o **Table Data Import Wizard**.
2. Em **File Path**, selecione o arquivo `tabela_TACO/taco_completo.csv` no seu computador.
3. Em "Select destination table and additional options", marque **Use existing table** e escolha `nutriplanner.alimentos`.
4. Clique em **Next** até o assistente concluir a importação com sucesso.

## 💻 Tecnologias

- **Python** - lógica de negócio e cálculos
- **MySQL** - persistência de dados
- **HTML, CSS e JavaScript** - interface web
- **Bootstrap 5** - componentes de UI (modais, grid responsivo de 12 colunas, formulários)
- **Figma** - design das telas
- **GitHub** - versionamento
- **Trello** - organização das sprints e backlog

## ▶️ Como rodar

**Backend:**
1. Crie o banco rodando `script_nutriplanner.sql` no MySQL Workbench (importe a TACO manualmente se a tabela `alimentos` ficar vazia - ver tutorial acima).
2. Instale as dependências (`mysql-connector-python`, `questionary`, `pandas`).
3. Rode `python main.py` dentro da pasta do backend.

**Frontend (web):**
- Localmente: abra a pasta com o **Live Server** (não abra o `index.html` direto pelo navegador).
- Publicado: acesse pelo GitHub Pages, já que o `index.html` está na raiz do repositório.

## 📄 Documentação do Projeto

Para entender os requisitos, diagramas e a arquitetura de software utilizada no **NutriPlanner**, acesse o documento oficial:

* [📘 Plano de Engenharia de Software (Google Docs)](https://docs.google.com/document/d/1l-GdPIIDl-W8tGCfsSoiRTonw4uRM11LRHYu2qgVRyY/edit?usp=sharing)

## 👥 Equipe

- [Helena Vieira](https://github.com/helenavieiranasc)
- [Camila Ribeiro](https://github.com/camilaribeirox)
- [Maria Clara Pastor](https://github.com/mariaclarapastorsilva)
