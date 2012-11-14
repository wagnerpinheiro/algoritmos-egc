-- Sript Criacao Controle Internacao - EC8

/** Esquema de relacoes 
paciente( prontuario(PK),nome_pac,end_pac,dt_nascto_pac,fone_pac, sexo_pac, tp_sangue_pac, cpf_responsavel)
quarto( num_quarto(PK), local_quarto, capacidade_leitos, tp_quarto)
leito( num_leito(PK), num_quarto(PK)(FK), tipo_leito )
medico( crm(PK) , nome_mdedico, sexo_medico, fone_medico, end_medico,celular_medico,tipo_medico)
internacao( num_internacao(PK), motivo, dt_entrada, dt_alta, dt_saida, num_leito(FK),num_quarto(FK),prontuario (FK),
crm_responsavel (FK))
orientacao_residente( crm_residente(PK)(FK), crm_efetivo(FK),dt_inicio ,dt_termino)
doencas_pre_existentes( cod_doenca(PK),nome_doenca, descricao_doenca)
doencas_paciente ( cod_doenca(PK), prontuario_paciente, dt_inicio_doenca )
*****/
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
ALTER SESSION SET NLS_LANGUAGE = PORTUGUESE;
SELECT SESSIONTIMEZONE, CURRENT_TIMESTAMP FROM DUAL;

/* TABELA PACIENTE*/
DROP TABLE paciente CASCADE CONSTRAINTS;
CREATE TABLE paciente(
prontuario INTEGER PRIMARY KEY,
nome_pac VARCHAR2(40) NOT NULL,
end_pac VARCHAR2(40) NOT NULL,
dt_nascto_pac DATE NOT NULL,
fone_pac VARCHAR2(10),
sexo_pac CHAR(1) NOT NULL,
tp_sangue_pac CHAR(3) NOT NULL);

--3a
ALTER TABLE paciente ADD cpf_responsavel VARCHAR2(12) NOT NULL ;

--2d
alter table paciente add check ( sexo_pac in ('M', 'F')) ;
--2a
DROP SEQUENCE pac_seq ;
CREATE SEQUENCE pac_seq start with 5000 ;

/*POPULANDO PACIENTE*/
INSERT INTO paciente VALUES(pac_seq.nextval,'VALTER GARCIA','AV. AMALIA FRANCO 100','20/02/1949','1151524630','M','AB','123584878');
INSERT INTO paciente VALUES(pac_seq.nextval,'MARIA LUCIEIDE','AV SARAH VELOSO 645','15/10/1975','1145652311','F','O+','27958498');
INSERT INTO paciente VALUES(pac_seq.nextval,'ADRIANO ROMAGNOLO','AV C. COSTA 445','25/12/1972','1137895278','M','B','38658776');
INSERT INTO paciente VALUES(pac_seq.nextval,'WAGNER DINIZ','PRAÇA IDALINO ANDREOLO 98','30/07/1985','1136985266','M','AB-','555444119');
INSERT INTO paciente VALUES(pac_seq.nextval,'CAIO CESAR','AV C. COSTA 445','02/05/2004','1137895278','M','A','85658558');
INSERT INTO paciente VALUES(pac_seq.nextval,'RITA CAMACHO','RUA COSTA LARGA, 447','02/05/1984','1137855278','F','A','85533558');

select * from paciente ;

/* TABELA QUARTO*/

DROP TABLE  quarto CASCADE constraints;
CREATE TABLE quarto(
num_quarto INTEGER PRIMARY KEY,
local_quarto VARCHAR2(20) NOT NULL,
capacidade_leitos INTEGER NOT NULL,
tp_quarto VARCHAR2(12) NOT NULL);

--2D
alter table quarto ADD CHECK ( tp_quarto IN ('ENFERMARIA', 'UTI', 'CTI',  'PADRAO'));

/*POPULANDO QUARTO*/
INSERT INTO quarto VALUES(101,'1 ANDAR',2,'ENFERMARIA');
INSERT INTO quarto VALUES(201,'2 ANDAR',4,'UTI');
INSERT INTO quarto VALUES(301,'3 ANDAR',4,'CTI');
INSERT INTO quarto VALUES(401,'4 ANDAR',1,'PADRAO');
INSERT INTO quarto VALUES(402,'4 ANDAR',2,'PADRAO');

select * from quarto ;

/* TABELA LEITO*/
DROP TABLE  leito CASCADE constraints;
CREATE TABLE leito(
num_leito INTEGER ,
num_quarto INTEGER NOT NULL,
tipo_leito VARCHAR2(10) NOT NULL,
PRIMARY KEY ( num_leito, num_quarto),
FOREIGN KEY (num_quarto) REFERENCES quarto(num_quarto) ON DELETE CASCADE);

--2D
alter table leito ADD CHECK ( tipo_leito IN ('SIMPLES', 'MECANICO', 'ELETRONICO'));


/* INSERINDO DADOS NA TABELA LEITO*/
INSERT INTO leito VALUES(1,101,'SIMPLES');
INSERT INTO leito VALUES(2,101,'MECANICO');
INSERT INTO leito VALUES(1,201, 'ELETRONICO');
INSERT INTO leito VALUES(2,201, 'MECANICO');
INSERT INTO leito VALUES(3,101,'ELETRONICO');
INSERT INTO leito VALUES(1, 401, 'SIMPLES');
INSERT INTO leito VALUES(1,402, 'SIMPLES');
INSERT INTO leito VALUES(2, 401, 'SIMPLES');
INSERT INTO leito VALUES(2,402, 'SIMPLES');

select * from leito ;

/* TABELA MEDICO*/
DROP TABLE  medico CASCADE CONSTRAINTS ;
CREATE TABLE medico(
crm INTEGER PRIMARY KEY,
nome_medico VARCHAR2(30) NOT NULL,
sexo_medico CHAR(1) NOT NULL check ( sexo_medico in ('M', 'F')),
fone_medico VARCHAR2(10) NOT NULL,
end_medico VARCHAR2(30) NOT NULL,
celular_medico VARCHAR2(10),
tipo_medico VARCHAR2(11) NOT NULL) ;

alter table medico add check (tipo_medico in ('EFETIVO', 'RESIDENTE')) ;
alter table medico modify celular_medico not null ;

/*INSERINDO DADOS NA TABELA MEDICO*/

INSERT INTO medico VALUES(1234,'ANTONIO SOUZA','M','1132259952','RUA DOS MILAGRES 100','1199115555','EFETIVO');
INSERT INTO medico VALUES(2235,'JOAO PERES','M','1133345999','RUA DOS INICIANTES 200','1188885455','RESIDENTE');
INSERT INTO medico VALUES(3236,'JOSE TEIXEIRA','M','1147859952','AV INTERLAGOS 1000','1188886666','EFETIVO');
INSERT INTO medico VALUES(4237,'ANA CASTRO','F','1147859952','RUA ANTONIO AGU','1177788555','RESIDENTE');
INSERT INTO medico VALUES(5238,'TADASHI KOBAIASH','M','1155556666','RUA VOLUNTARIOS DA PATRIA,500','1199785566','EFETIVO');
INSERT INTO medico VALUES(6239,'JOANA SANTOS','F','1166859952','RUA TURIASSU , 156','1177885566','RESIDENTE');
INSERT INTO medico VALUES(7240,'FERNANDA DE ABREU','F','1149859967','RUA DOS PINHEIROS,700','1185486666','EFETIVO');
INSERT INTO medico VALUES(8241,'FUAD TUFIK','M','1136859767','RUA RUBI,100','1166486666','EFETIVO');
INSERT INTO medico VALUES(9242,'IRENE GARCIA','M','1155859752','AV AMALIA FRANCO , 600','1179885526','RESIDENTE');
INSERT INTO medico VALUES(7243,'SUELLEN RAMOS','F','1136859759','RUA VALMIR ALENCAR, 965','1174515526','RESIDENTE');

select * from medico ;

/*  TABELA INTERNACAO*/
DROP TABLE  internacao CASCADE CONSTRAINTS ;
CREATE TABLE internacao(
num_internacao integer PRIMARY KEY,
motivo VARCHAR2(40) NOT NULL,
dt_hora_internacao TIMESTAMP NOT NULL,
dt_hora_alta TIMESTAMP,
dt_hora_saida TIMESTAMP,
num_leito INTEGER NOT NULL,
num_quarto INTEGER NOT NULL,
prontuario INTEGER NOT NULL,
crm_responsavel INTEGER NOT NULL,
FOREIGN KEY (num_leito , num_quarto) REFERENCES leito ON DELETE CASCADE ,
FOREIGN KEY (prontuario) REFERENCES paciente(prontuario) ON DELETE CASCADE,
FOREIGN KEY (crm_responsavel) REFERENCES medico ON DELETE CASCADE);

--2a
DROP SEQUENCE internacao_seq ;
create SEQUENCE internacao_seq START WITH 3000 ;

/* POPULANDO INTERNACAO */
INSERT INTO internacao VALUES
(internacao_seq.nextval,'DORES FORTES NO PEITO', current_timestamp - 50, current_timestamp - 47 , current_timestamp - 47, 1,101,5003,1234);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'PARTO EM ANDAMENTO',current_timestamp - 45,current_timestamp - 43,current_timestamp - 43,1,401,5005,5238);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'INFECÇÃO NA URINA',current_timestamp - 40, current_timestamp - 39, current_timestamp - 39,1,402,5002,2235); -- erro gatilho OK medico residente
INSERT INTO internacao VALUES
(internacao_seq.nextval,'FRATURA EXPOSTA',current_timestamp - 30, current_timestamp - 20, current_timestamp - 20, 2,101, 5001,7240);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'MANCHAS VERMELHAS NA PELE',current_timestamp - 20,current_timestamp - 19 ,current_timestamp - 19, 2,201,5004,3236);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'PARADA CARDIACA',current_timestamp - 10,current_timestamp - 5 ,current_timestamp - 5,3,101, 5001,1234);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'PRE NATAL',current_timestamp - 5,current_timestamp - 4,current_timestamp - 4, 1,101,5001,5238);
INSERT INTO internacao VALUES
(internacao_seq.nextval,'LUXAÇÃO NO BRAÇO',current_timestamp - 1, current_timestamp - 1, current_timestamp - 1,1,401,5004,8241);

select * from internacao ;


/* orientacao do residente */
DROP TABLE orientacao_residente CASCADE CONSTRAINTS ;
CREATE TABLE orientacao_residente
( crm_residente INTEGER NOT NULL REFERENCES MEDICO ,
crm_efetivo INTEGER NOT NULL  REFERENCES MEDICO ,
dt_inicio DATE,
dt_termino DATE ,
PRIMARY KEY ( crm_residente)) ;
DESCRIBE orientacao_residente ;

INSERT INTO orientacao_residente  VALUES (2235, 1234, SYSDATE - 200, SYSDATE );
INSERT INTO orientacao_residente  VALUES (4237, 3236, SYSDATE - 200, SYSDATE );

/*4- Acrescente uma nova tabela de Doenças Pre-existentes com os seguintes atributos :
Código, Nome, Descrição. Relacione com o Paciente ( especifique você mesmo a cardinalidade) e resolva este relacionamento. 
No relacionamento inclua o atributo Data de Início.
***********************************
TABELA DOENCAS PRE-EXISTENTES */
DROP TABLE  doencas_pre_existentes CASCADE CONSTRAINTS;
CREATE TABLE doencas_pre_existentes(
cod_doenca CHAR(5) PRIMARY KEY,
nome_doenca VARCHAR(30) NOT NULL,
descricao_doenca VARCHAR(100) NOT NULL);

/*POPULANDO DOENCAS PRE EXISTENTE*/
INSERT INTO doencas_pre_existentes VALUES('DIAB2','DIABETES TIPO 2','DOENCA QUE AFETA O PANCREAS ACARRETANDO NA DIMINUICAO DA INSULINA');
INSERT INTO doencas_pre_existentes VALUES('RINIA','RINITE ALERGICA','ALERGIA PROVOCADA POR ACAROS, POEIRA, PRODUTOS QUIMICOS');
INSERT INTO doencas_pre_existentes VALUES('HIPT','HIPERTENSAO', 'PRESSAO ALTA' );
INSERT INTO doencas_pre_existentes VALUES('GLAUC','GLAUCOMA','DEGENERACAO DA VISAO');

select * from doencas_pre_existentes ;

/*TABELA DE RELACIONAMENTO DOENCAS PRE EXISTENTES COM PACIENTE*/
DROP TABLE  doencas_paciente CASCADE CONSTRAINTS;
CREATE TABLE doencas_paciente(
cod_doenca CHAR(5) NOT NULL,
prontuario_paciente INTEGER NOT NULL,
dt_inicio DATE,
FOREIGN KEY (cod_doenca) REFERENCES doencas_pre_existentes(cod_doenca) ON DELETE CASCADE,
FOREIGN KEY (prontuario_paciente) REFERENCES paciente(prontuario) ON DELETE CASCADE);

/*POPULANDO doencas_paciente*/
INSERT INTO doencas_paciente VALUES('DIAB2',5003,'01/02/1987');
INSERT INTO doencas_paciente VALUES('RINIA',5003,'08/10/1990');
INSERT INTO doencas_paciente VALUES('HIPT',5004,'15/05/2000');
INSERT INTO doencas_paciente VALUES('GLAUC',5004,'02/03/1991');
INSERT INTO doencas_paciente VALUES('RINIA',5004,'28/07/2005');
INSERT INTO doencas_paciente VALUES('HIPT',5001,'07/03/2007');
INSERT INTO doencas_paciente VALUES('RINIA',5002,'10/04/1989');

select * from doencas_paciente ;

/* TABELA MEDICAMENTO */
DROP TABLE  medicamento CASCADE constraints;
CREATE TABLE medicamento(
cod_medicamento integer PRIMARY KEY,
nome_medicamento VARCHAR2(30) NOT NULL,
nome_popular VARCHAR2(30) NOT NULL,
dosagem NUMERIC(5,2) NOT NULL,
tipo VARCHAR2(30) NOT NULL,
estoque INTEGER NOT NULL,
principio_ativo VARCHAR2(30) NOT NULL,
tarja VARCHAR2(20) NOT NULL);

DROP SEQUENCE medicamento_seq ;
create SEQUENCE medicamento_seq START WITH 1;

INSERT INTO medicamento VALUES(medicamento_seq.nextval,'CAPOBAL','CAPOBAL',12.5,'CARDIACO',5,'CAPTOPRIL','VERMELHA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'BALUROL','BALUROL',400,'ANTI-INFECCIOSO URINARIO',20,'ACIDO PIPEMIDICO','S/TARJA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'NIMESUBAL','NIMESUBAL',100,'ANTI-INFLAMATORIO',20,'NIMESULIDA','S/TARJA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'NOVALGINA','NOVALGINA',85,'ANALGESICO',30,'DIPIRONA SODICA','VERMELHA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'RIVOTRIL','RIVOTRIL',2.5,'CALMANTE ANTI-EPILETICO',20,'CLONAZEPAM','PRETA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'DICLOFENACO RESINATO','CATAFLAM',100,'ANTI-INFLAMATORIO',10,'DICLOFENACO RESINATO','S/TARJA');
INSERT INTO medicamento VALUES(medicamento_seq.nextval,'ASPIRINA', 'ASPIRINA',500,'ANALGESICO',14,'ACIDO ACETILSALICILICO','S/TARJA');
select * from medicamento ;

alter table medicamento rename column tipo to tipo_medcto ;

/*CRIANDO A TABELA PRESCRICAO*/
DROP TABLE  prescricao CASCADE constraints;
CREATE TABLE prescricao(
num_prescricao integer primary key,
dt_hora_prescricao timestamp not null,
cod_medicamento INTEGER NOT NULL,
num_internacao INTEGER NOT NULL,
intervalo VARCHAR2(10),
dose_prescrita VARCHAR2(10),
dt_ini_aplicacao Timestamp,
dt_termino_aplicacao timestamp,
FOREIGN KEY (cod_medicamento) REFERENCES medicamento(cod_medicamento) ON DELETE CASCADE,
FOREIGN KEY (num_internacao) REFERENCES internacao(num_internacao) ON DELETE CASCADE ,
unique ( dt_hora_prescricao, cod_medicamento, num_internacao));

create sequence prescricao_seq start with 1000 ;

/*INSERINDO DADOS NA TABELA PRESCRICAO*/
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -20, 1,3000,'Cada 2hs','12mg',current_timestamp-20, current_timestamp-17);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -19,1,3001,'Cada 4hs','20mg', current_timestamp-19, current_timestamp-14);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -17,2,3002,'cada 6hs','10mg',current_timestamp-17, current_timestamp-10);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -12,4,3003,'Cada 2hs','15mg',current_timestamp-10, current_timestamp-7);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -10,5,3003,'Cada 6hs','50mg',current_timestamp-10, current_timestamp-7);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp -2,3,3005,'Cada 12hs','25mg',current_timestamp-1, current_timestamp+3);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp ,4,3005,'Cada 8hs','5mg',current_timestamp, current_timestamp+5);
INSERT INTO prescricao VALUES(prescricao_seq.nextval, current_timestamp ,4,3007,'Cada 8hs','5mg',current_timestamp, current_timestamp+5);

select * from prescricao ;

/*5- Escreva a sentença em SQL (SELECT) para responder às seguintes consultas :
a)	Mostre o nome e a data de nascimento de todos os pacientes do sexo feminino;
b)	Mostre todos os dados das médicas efetivas especializadas em Endocrinologia;
c)	Mostre o número da internação, a data hora da entrada e da alta e o motivo para as internações que não foram motivadas por fratura neste mês;
d)	Repita a consulta c) acima para as internações que duraram mais de uma semana;
e)	Monte uma lista com todos os dados dos leitos incluindo o quarto ordenado pela localização do quarto;
f)	Mostre todos os dados da internação juntamente com o nome do médico responsável e sua especialidade;
g)	repita a consulta e) acima incluindo o nome e sexo do paciente ordenado pela data da internação;
h)	repita a consulta f) acima incluindo o tipo do leito e o tipo do quarto para as internações que não foram realizadas em Enfermaria;
i)	Mostre o nome dos médicos residentes, nome do médico orientador e o período de orientação ordenado pelo nome do orientador;
j)	Mostre o nome, sexo e data de nascimento dos pacientes que tenham como doença pré-existente hipertensão e diabetes tipo 2;
k)	repita a consulta j) acima para os pacientes que ficaram internados no mês passado pelo motivo de crise hiperglicemica ou crise hipertensa
*/


/*
-- Selects com funcoes de grupo
-- funcoes de agregacao

-- l - Contagem, soma, maximo, minimo, de medicamento
select count(*), sum(estoque), avg(estoque), max(estoque), min(estoque)
from medicamento  ;

-- m -- numero de internacoes no mes passado
select count(*)
from internacao i 
where extract(month from i.dt_hora_internacao) = extract ( month from sysdate) -1 ;

-- n -- por paciente, join
select nome_pac AS Paciente, count(*)
from paciente p, internacao i
where i.prontuario = p.prontuario
GROUP BY nome_pac ;

-- o -- por medico e motivo, que já tiveram alta
select m.nome_medico, i.motivo, count(*)
from medico m, internacao i
where m.crm = i.crm_responsavel
and i.dt_hora_alta is not null
GROUP BY m.nome_medico, i.motivo
order by 1;

-- p - pacientes com mais de 5 dias internados este ano - clausula HAVING
select p.nome_pac, sum(to_number(extract( day from (i.dt_hora_saida - i.dt_hora_internacao)))) As Total_dias
from internacao i, paciente p
where i.prontuario = p.prontuario
and extract ( year from i.dt_hora_internacao) = extract ( year from current_date)
GROUP BY p.nome_pac
having sum(to_number(extract( day from (i.dt_hora_saida - i.dt_hora_internacao)))) > 5 ;

-- Consultas aninhadas - Sub-consultas (subquery)
-- q - remedio com maior estoque
select nome_medicamento
from medicamento where estoque = ( select max(estoque) from medicamento) ;

-- r -- paciente que ficou mais vezes internado este ano
select nome_pac AS Paciente, count(*)
from paciente p, internacao i
where i.prontuario = p.prontuario
and extract(year from i.dt_hora_internacao) = extract ( year from sysdate) 
GROUP BY nome_pac 
having count(*) =  
(
select max (contagem) from 
(select count(*) as contagem
from internacao
where extract(year from dt_hora_internacao) = extract(year from sysdate) 
GROUP BY prontuario) maiorcontagem );

-- s - Outer join - leito nunca ocupado por internacao
select l.num_leito, l.num_quarto, i.num_leito, i.num_quarto
from leito l left outer join internacao i
on ( l.num_leito = i.num_leito and l.num_quarto = i.num_quarto) ;

select l.num_leito, l.num_quarto, i.num_leito, i.num_quarto
from leito l left outer join internacao i
on ( l.num_leito = i.num_leito and l.num_quarto = i.num_quarto) 
where i.num_leito is null ;*/

/*******************************************************
--LISTA 2 - C O N S U L T A S    A D I C I O N A I S
********************************************************/
/*5- Escreva a sentença em SQL (SELECT) para responder às seguintes consultas :
t)Mostre o número de internações por leito e quarto neste ano : Leito-Quarto-Qtde Internações
u)Mostre a contagem de medicamentos prescritos por paciente : Nome Paciente - Qtde Medicamentos
v)Mostre o nome dos médicos responsáveis que tiveram mais de 5 internações motivadas por fratura
 (qualquer tipo) nos últimos 40 dias.
x)Mostre todos os dados do paciente mais idoso que ficou internado;
y)Mostre todos os dados da internação mais longa (durou mais tempo);
z)Mostre os leitos-quartos que nunca ficaram ocupados por internação de parto (use OUTER JOIN);
w)Mostre o médico efetivo que nunca orientou residente (use OUTER JOIN).