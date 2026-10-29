CREATE DATABASE IF NOT EXISTS bd_cursos_livres
character set utf8mb4; 
use bd_cursos_livres; 

create table aluno( 
id_aluno int primary key, 
nome varchar (120) not null,
cpf char(11) not null, 
email varchar (150),
data_nascimento date,

constraint uq_aluno_cpf unique (cpf)
);  

create table instrutor(
id_instrutor int primary key, 
name varchar (50) not null, 
email varchar (50) not null, 
especialidade varchar (150) not null
);


CREATE TABLE curso (
    id_curso int primary key,
    nome VARCHAR(150) not null,
    carga_horaria int not null default 40,
    valor DECIMAL(10,2) NOT NULL,

    constraint chk_curso_carga
        check (carga_horaria > 0),

    constraint chk_curso_valor
        check (valor >= 0)
);

create table turma (
    id_turma int primary key,
    id_curso int not null,
    id_instrutor int not null,
    data_inicio date not null,
    quantidade_vagas int not null default 40,

    constraint chk_turma_vagas
        check (quantidade_vagas > 0),

    constraint fk_turma_curso
        foreign key (id_curso)
        references curso(id_curso)
        on delete restrict
        on update cascade,

    constraint fk_turma_instrutor
        foreign key (id_instrutor)
        references instrutor(id_instrutor)
        on delete restrict
        on update cascade
);

create table matricula(
id_matricula int primary key,  
data_matricula date not null, 
situacao varchar (20) not null default 'ativa', 
id_aluno int not null,
id_turma int not null, 

constraint fk_matricula_aluno 
foreign key (id_aluno)
references aluno(id_aluno)
on delete restrict 
on update cascade,

constraint fk_matricula_turma 
foreign key (id_turma)
references turma(id_turma)
on delete restrict 
on update cascade 
);



use bd_cursos_livres;

alter table aluno
add column telefone varchar(20);

alter table aluno
modify column telefone varchar(25);

alter table aluno
rename column telefone to telefone_contato;

alter table curso
add column descricao text;

alter table curso
add column modalidade varchar(20) not null default 'Presencial';

alter table curso
add constraint chk_curso_modalidade
check (modalidade in ('Presencial', 'Online', 'Hibrido'));

alter table turma
add column observacao varchar(255);

alter table turma
drop column observacao;

rename table instrutor to professor;

show tables;

describe aluno;
describe curso;
describe turma;
describe matricula;
describe professor;

show create table aluno;
show create table curso;
show create table turma;
show create table matricula;
show create table professor;
