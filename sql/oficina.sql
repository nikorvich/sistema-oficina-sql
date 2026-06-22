-- Tabela Pessoa (superclasse)
CREATE TABLE Pessoa (
    CPF_CNPJ VARCHAR(20) PRIMARY KEY,
    nomeCompleto VARCHAR(100) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    complemento VARCHAR(100) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    email1 VARCHAR(100) NOT NULL,
    email2 VARCHAR(100) NOT NULL,
    ddi VARCHAR(3),
    ddd VARCHAR(3),
    numero VARCHAR(15),
    tipoPessoa VARCHAR(20) CHECK (tipoPessoa IN ('Fisica', 'Juridica'))
);

-- Subtipos de Pessoa
CREATE TABLE PessoaFisica (
    CPF_CNPJ VARCHAR(20) PRIMARY KEY,
    dataNascimento DATE NOT NULL,
    FOREIGN KEY (CPF_CNPJ) REFERENCES Pessoa(CPF_CNPJ)
);

CREATE TABLE PessoaJuridica (
    CPF_CNPJ VARCHAR(20) PRIMARY KEY,
    inscricaoEstadual VARCHAR(20) NOT NULL,
    contato VARCHAR(100),
    FOREIGN KEY (CPF_CNPJ) REFERENCES Pessoa(CPF_CNPJ)
);

-- Proprietário
CREATE TABLE Proprietario (
    idProprietario SERIAL PRIMARY KEY,
    CPF_CNPJ VARCHAR(20) NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    FOREIGN KEY (CPF_CNPJ) REFERENCES Pessoa(CPF_CNPJ)
);

-- Marca
CREATE TABLE Marca (
    idMarca SERIAL PRIMARY KEY,
    nomeMarca VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL
);

-- Modelo
CREATE TABLE Modelo (
    idModelo SERIAL PRIMARY KEY,
    nomeModelo VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    idMarca INT NOT NULL,
    FOREIGN KEY (idMarca) REFERENCES Marca(idMarca)
);

-- Veículo
CREATE TABLE Veiculo (
    Placa VARCHAR(10) PRIMARY KEY,
    chassi VARCHAR(100),
    Kilometragem INT NOT NULL,
    anoFabricacao INT NOT NULL,
    anoModelo INT NOT NULL,
    idProprietario INT NOT NULL,
    idModelo INT NOT NULL,
    FOREIGN KEY (idProprietario) REFERENCES Proprietario(idProprietario),
    FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

-- Acessório
CREATE TABLE Acessorio (
    idAcessorio SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    placa VARCHAR(10) NOT NULL,
    FOREIGN KEY (placa) REFERENCES Veiculo(Placa)
);

-- Fabricante
CREATE TABLE Fabricante (
    idFabricantePeca SERIAL PRIMARY KEY,
    emailFabricantePeca VARCHAR(100) NOT NULL,
    telefoneFabricantePeca VARCHAR(60) NOT NULL
);

-- Especialidade
CREATE TABLE Especialidade (
    idEspecialidade SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    tipoEspecialidade VARCHAR(100) NOT NULL
);

-- Funcionário
CREATE TABLE Funcionario (
    CpfFuncionario VARCHAR(12) PRIMARY KEY,
    nomeFuncionario VARCHAR(100) NOT NULL,
    emailFuncionario VARCHAR(100) NOT NULL,
    telefoneFuncionario VARCHAR(15) NOT NULL,
    idEspecialidade INT,
    FOREIGN KEY (idEspecialidade) REFERENCES Especialidade(idEspecialidade)
);

-- Ordem de Serviço
CREATE TABLE OrdemServico (
    idOS SERIAL PRIMARY KEY,
    dataEntrada DATE NOT NULL,
    dataSaida DATE NOT NULL,
    status VARCHAR(100) NOT NULL,
    valorPago MONEY NOT NULL,
    placa VARCHAR(10) NOT NULL,
    FOREIGN KEY (placa) REFERENCES Veiculo(Placa)
);

-- Serviço
CREATE TABLE Servico (
    idServico SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    precoServico MONEY NOT NULL,
    idOS INT NOT NULL,
    cpfFuncionario VARCHAR(12),
    FOREIGN KEY (idOS) REFERENCES OrdemServico(idOS),
    FOREIGN KEY (cpfFuncionario) REFERENCES Funcionario(CpfFuncionario)
);

-- Garantia
CREATE TABLE Garantia (
    idGarantia SERIAL PRIMARY KEY,
    idServico INT NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- Peça
CREATE TABLE Peca (
    idPeca SERIAL PRIMARY KEY,
    valorUnitario MONEY NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    nomePeca VARCHAR(100) NOT NULL,
    quantidadePeca INT NOT NULL,
    idFabricante INT NOT NULL,
    idGarantia INT,
    FOREIGN KEY (idFabricante) REFERENCES Fabricante(idFabricantePeca),
    FOREIGN KEY (idGarantia) REFERENCES Garantia(idGarantia)
);

-- Peça Usada
CREATE TABLE PecaUsadas (
    idPeca SERIAL PRIMARY KEY,
    valorUnitario MONEY NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    nomePeca VARCHAR(100) NOT NULL,
    quantidadePeca INT NOT NULL,
    idFabricante INT NOT NULL,
    idOS INT NOT NULL,
    FOREIGN KEY (idFabricante) REFERENCES Fabricante(idFabricantePeca),
    FOREIGN KEY (idOS) REFERENCES OrdemServico(idOS)
);

-- Nota Fiscal
CREATE TABLE NotaFiscal (
    idNotaFiscal SERIAL PRIMARY KEY,
    dataEmissao DATE NOT NULL,
    idOS INT NOT NULL,
    FOREIGN KEY (idOS) REFERENCES OrdemServico(idOS)
);
