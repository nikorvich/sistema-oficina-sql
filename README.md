# Sistema de Gestão para Oficina Mecânica

Banco de dados relacional projetado para suportar operações completas de uma oficina mecânica, incluindo controle de clientes, veículos, ordens de serviço, estoque e faturamento.

O foco do projeto é organizar os dados de forma consistente e garantir que todas as informações estejam conectadas de maneira confiável.

---

## ✨ Funcionalidades

- **Cadastro de clientes (PF/PJ):** Estrutura unificada com dados de contato e identificação.
- **Gestão de veículos:** Histórico completo de propriedade, características e manutenção.
- **Controle de funcionários:** Gerenciamento do corpo técnico por especialidades.
- **Fluxo de Ordem de Serviço (OS):** Controle de status, datas e execução dos serviços.
- **Gestão de estoque e peças:** Controle de entrada, saída e uso de peças vinculadas às OS.
- **Faturamento integrado:** Emissão de notas fiscais vinculadas às ordens de serviço.
- **Garantia pós-serviço:** Controle de prazos e cobertura dos serviços realizados.

---

## 📐 Modelo do Banco de Dados

### 🖼️ Diagrama de Entidade-Relacionamento (DER)

![Diagrama do Banco de Dados](assets/der.jpg)

---

### 🧩 Modelo Lógico

> [!TIP]
> **Pessoa** (**CPF_CNPJ**, nomeCompleto, CEP, complemento, logradouro, email1, email2, ddi, ddd, numero, tipoPessoa)
>
> **PessoaFisica** (**CPF_CNPJ**, dataNascimento)  
> ↳ CPF_CNPJ referencia Pessoa
>
> **PessoaJuridica** (**CPF_CNPJ**, inscricaoEstadual, contato)  
> ↳ CPF_CNPJ referencia Pessoa
>
> **Proprietario** (**idProprietario**, CPF_CNPJ, dataInicio, dataFim)  
> ↳ CPF_CNPJ referencia Pessoa
>
> **Marca** (**idMarca**, nomeMarca, descricao)
>
> **Modelo** (**idModelo**, nomeModelo, descricao, idMarca)  
> ↳ idMarca referencia Marca
>
> **Veiculo** (**Placa**, chassi, Kilometragem, anoFabricacao, anoModelo, idProprietario, idModelo)  
> ↳ idProprietario referencia Proprietario  
> ↳ idModelo referencia Modelo
>
> **Acessorio** (**idAcessorio**, descricao, placa)  
> ↳ placa referencia Veiculo
>
> **Fabricante** (**idFabricantePeca**, emailFabricantePeca, telefoneFabricantePeca)
>
> **Peca** (**idPeca**, valorUnitario, descricao, nomePeca, quantidadePeca, idFabricante, idGarantia)  
> ↳ idFabricante referencia Fabricante  
> ↳ idGarantia referencia Garantia
>
> **PecaUsadas** (**idPeca**, valorUnitario, descricao, nomePeca, quantidadePeca, idFabricante, idOS)  
> ↳ idFabricante referencia Fabricante  
> ↳ idOS referencia OrdemServico
>
> **OrdemServico** (**idOS**, dataEntrada, dataSaida, status, valorPago, placa)  
> ↳ placa referencia Veiculo
>
> **Servico** (**idServico**, descricao, precoServico, idOS, cpfFuncionario)  
> ↳ idOS referencia OrdemServico  
> ↳ cpfFuncionario referencia Funcionario
>
> **Especialidade** (**idEspecialidade**, descricao, tipoEspecialidade)
>
> **Funcionario** (**CpfFuncionario**, nomeFuncionario, emailFuncionario, telefoneFuncionario, idEspecialidade)  
> ↳ idEspecialidade referencia Especialidade
>
> **Garantia** (**idGarantia**, idServico, dataInicio, dataFim)  
> ↳ idServico referencia Servico
>
> **NotaFiscal** (**idNotaFiscal**, dataEmissao, idOs)  
> ↳ idos referencia OrdemServico

---

## 🏗️ Tecnologias

- PostgreSQL
- SQL

---

## 📂 Estrutura do projeto

```text
sistema-oficina-sql/
├── assets/
│   └── der.jpg
├── sql/
│   └── oficina.sql
└── README.md
````

---

## ▶️ Execução

```bash
git clone https://github.com/nikorvich/sistema-oficina-sql.git
cd sistema-oficina-sql

createdb oficina

psql -U postgres -d oficina -f sql/oficina.sql
```
