
CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximmo NUMERIC(8,2),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE hr.cargos IS 'tabela com o cargo e salario minimo e maximo';
COMMENT ON COLUMN hr.cargos.id_cargo IS 'chave primaria, codigo do cargo';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'o menor sal�rio';
COMMENT ON COLUMN hr.cargos.salario_maximmo IS 'o maior s�lario';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao_ INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao_)
);
COMMENT ON TABLE hr.regioes IS 'cotem a regiao';
COMMENT ON COLUMN hr.regioes.id_regiao_ IS 'chave pr�maria da tabela regi�es, cont�m codigo da regi�o';
COMMENT ON COLUMN hr.regioes.nome IS 'nome da regi�o';


CREATE UNIQUE INDEX regioes_idx
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                _id_pais_ CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT id_pais PRIMARY KEY (_id_pais_)
);
COMMENT ON TABLE hr.paises IS 'detalha qual o pa�s, qual � sua sigla e em que regiao est�';
COMMENT ON COLUMN hr.paises._id_pais_ IS 'chave pr�maria da tabela pa�ses, sigla do pa�s';
COMMENT ON COLUMN hr.paises.nome IS 'nome do pais';
COMMENT ON COLUMN hr.paises.id_regiao IS 'chave estregereira da tabela regi�es do c�digo das regi�es';


CREATE UNIQUE INDEX paises_idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cidade VARCHAR(50),
                CEP VARCHAR(12),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE hr.localizacoes IS 'tem os detalhes da localiza��o de escrit�rios e facilidades da empresa, n�o clientes.';
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'chave pr�maria da tabela localiza�oes, cont�m o c�digo da localiza��o';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'o endere�o (rua, bairro e numero)';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'a ciddade';
COMMENT ON COLUMN hr.localizacoes.CEP IS 'o cep da localiza��o';
COMMENT ON COLUMN hr.localizacoes.uf IS 'a unidade federal da localiza��o';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'chave estrangeira para a tabela pa�ses, tem o c�digo do pa�s';


CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departamentos IS 'tem o c�digo do departamento, seu nome, a localiza��o e quem o gerencia';
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'chave pr�maria da tabela departamentos, cont�m o c�digo do departamento';
COMMENT ON COLUMN hr.departamentos.nome IS 'nome do departamentento';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'chave estrangeira para a tabela localiza��es, tem o c�digo da localiza�ao';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'chave prim�ria da tabela empregados, com a identifica��o do empregado';


CREATE UNIQUE INDEX departamentos_idx
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_carg0 VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER NOT NULL,
                id_surpevisor INTEGER NOT NULL,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE hr.empregados IS 'tem o c�digo do empregado, nome, email, telefone, quando foi contratado, cargo, sal�rio, comiss�o, departamento, e o surpevisor';
COMMENT ON COLUMN hr.empregados.id_empregado IS 'chave prim�ria da tabela empregados, com a identifica��o do empregado';
COMMENT ON COLUMN hr.empregados.nome IS 'nome do empregado';
COMMENT ON COLUMN hr.empregados.email IS 'email do empregado antes de @';
COMMENT ON COLUMN hr.empregados.telefone IS 'n�mero de telefone, com o dodigo do pa�s e estado';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'quando o empregado iniciou no cargo atual';
COMMENT ON COLUMN hr.empregados.id_carg0 IS 'chave estrangeira da tabela cargos, idenetifica os cargos';
COMMENT ON COLUMN hr.empregados.salario IS 's�lario do empragado';
COMMENT ON COLUMN hr.empregados.comissao IS 'quanto o empregado ganhou de comiss�o, apenas dsponivel para o departamento de vendas';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'chave estrangeira, cont�m c�digo do departamento';
COMMENT ON COLUMN hr.empregados.id_surpevisor IS 'o surpervisor direto do empregdo (auto-relacionamento)';


CREATE UNIQUE INDEX email
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inical DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                d_departamento INTEGER NOT NULL,
                CONSTRAINT data_inicial PRIMARY KEY (id_empregado, data_inical)
);
COMMENT ON TABLE hr.historico_cargos IS 'cont�m o c�digo do empregado, quando ele come�ou, quando teminou no cargo e em qual departamento';
COMMENT ON COLUMN hr.historico_cargos.id_empregado IS 'chave prim�ria da tabela empregados, com a identifica��o do empregado';
COMMENT ON COLUMN hr.historico_cargos.data_inical IS 'chave prim�ria composta, cont�m quando iniciou o cargo';
COMMENT ON COLUMN hr.historico_cargos.data_final IS 'quando o empregado deixou o cargo';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'chave estrangeira para cargos, indentica o cargo';
COMMENT ON COLUMN hr.historico_cargos.d_departamento IS 'chave estrageira para departamentos, tem c�digo do departamento';


ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_carg0)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.paises ADD CONSTRAINT paises_regioes_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao_)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT localizacoes_paises_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (_id_pais_)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT departamentos_localizacoes_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (d_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_surpevisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;