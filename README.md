# Sistema de Gestão para Oficina Mecânica

Banco de dados relacional projetado para suportar operações completas de uma oficina mecânica, incluindo controle de clientes, veículos, ordens de serviço, estoque e faturamento.

O foco do projeto está em integridade referencial, normalização (até 3FN) e rastreabilidade operacional, simulando um ambiente real de gestão automotiva.

## ✨ Funcionalidades

* Cadastro de clientes (PF/PJ) com estrutura unificada e validação de identidade
* Gestão de veículos com histórico de propriedade e manutenção
* Controle de funcionários e especialidades técnicas
* Fluxo completo de Ordem de Serviço (OS) com status e execução de serviços
* Gestão de estoque de peças com rastreamento de consumo por OS
* Faturamento integrado com nota fiscal vinculada à OS
* Histórico operacional completo para auditoria e rastreabilidade

## 📐 Modelagem e arquitetura de dados

![Diagrama Entidade-Relacionamento](assets/der.jpg)

Projeto estruturado com modelagem relacional consistente e foco em escalabilidade lógica.
### Conceitos aplicados
* Normalização até 3ª Forma Normal (3FN)
* Especialização de entidades (Pessoa → PessoaFisica / PessoaJuridica)
* Resolução de relacionamentos N:M via tabelas associativas
* Histórico de propriedade de veículos

## 🏗️ Implementação (PostgreSQL)

Implementado em PostgreSQL, utilizando recursos nativos de integridade e consistência.

### Principais recursos utilizados
* PRIMARY KEY e FOREIGN KEY para integridade referencial
* NOT NULL para obrigatoriedade de domínio
* CHECK para validação de regras de negócio
* SERIAL para chaves primárias autoincrementais

## 📋 Dicionário de dados (resumo)

| Tabela | Função |
| :--- | :--- |
| Pessoa | Entidade base (PF/PJ) |
| PessoaFisica | Extensão com CPF |
| PessoaJuridica | Extensão com CNPJ |
| Veiculo | Registro de veículos |
| Proprietario | Histórico de posse |
| OrdemServico | Núcleo operacional |
| Servico | Catálogo de serviços |
| Peca | Estoque de peças |
| PecaUsadas | Consumo por OS |
| Funcionario | Corpo técnico |
| Especialidade | Segmentação técnica |
| NotaFiscal | Registro fiscal |
| Garantia | Regras de pós-venda |
| Fabricante | Origem de peças |

## 🚀 Tecnologias

* PostgreSQL
* SQL (DDL / DML)

## 📂 Estrutura do projeto

```text
sistema-oficina-sql/
├── assets/
│   └── der.png
├── sql/
│   └── oficina.sql
└── README.md
````

## ▶️ Execução

1. **Clonar repositório**

```bash
git clone https://github.com/nikorvich/sistema-oficina-sql.git
cd sistema-oficina-sql
```

2. **Criar banco de dados**

```bash
createdb oficina
# Ou via psql:
psql -U postgres -c "CREATE DATABASE oficina;"
```

3. **Executar script**

```bash
psql -U postgres -d oficina -f sql/oficina.sql
```
