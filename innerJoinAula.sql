CREATE DATABASE escolaemerson;

USE escolaemerson;

CREATE TABLE Turmas (
    turma_id INT PRIMARY KEY,
    descricao VARCHAR(255)
);

CREATE TABLE Professores (
    professor_id INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Alunos (
    aluno_id INT PRIMARY KEY,
    nome VARCHAR(255),
    idade INT,
    turma_id INT,
    FOREIGN KEY (turma_id) REFERENCES Turmas(turma_id)
);

CREATE TABLE Turma_Professor (
    turma_id INT,
    professor_id INT,
    PRIMARY KEY (turma_id, professor_id),
    FOREIGN KEY (turma_id) REFERENCES Turmas(turma_id),
    FOREIGN KEY (professor_id) REFERENCES Professores(professor_id)
);

CREATE TABLE Atividades (
    atividade_id INT PRIMARY KEY,
    descricao VARCHAR(255),
    turma_id INT,
    FOREIGN KEY (turma_id) REFERENCES Turmas(turma_id)
);

CREATE TABLE Notas (
    aluno_id INT,
    atividade_id INT,
    nota DECIMAL(5, 2),
    PRIMARY KEY (aluno_id, atividade_id),
    FOREIGN KEY (aluno_id) REFERENCES Alunos(aluno_id),
    FOREIGN KEY (atividade_id) REFERENCES Atividades(atividade_id)
);

-- Inserção de dados nas Turmas
INSERT INTO Turmas (turma_id, descricao) VALUES (1, 'Matemática 101');
INSERT INTO Turmas (turma_id, descricao) VALUES (2, 'História 101');
INSERT INTO Turmas (turma_id, descricao) VALUES (3, 'Ciências 101');

-- Inserção de dados nos Professores
INSERT INTO Professores (professor_id, nome) VALUES (1, 'Carlos Silva');
INSERT INTO Professores (professor_id, nome) VALUES (2, 'Maria Fernandes');
INSERT INTO Professores (professor_id, nome) VALUES (3, 'João Pereira');

-- Inserção de dados na tabela Turma_Professor
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (1, 1);
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (2, 2);
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (3, 3);

-- Inserção de dados nos Alunos
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (1, 'Ana Santos', 15, 1);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (2, 'Pedro Gonçalves', 16, 1);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (3, 'Lucas Andrade', 15, 2);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (4, 'Mariana Costa', 16, 3);

-- Inserção de dados nas Atividades
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (1, 'Prova de Matemática', 1);
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (2, 'Trabalho de História', 2);
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (3, 'Experimento de Ciências', 3);

-- Inserção de dados nas Notas
INSERT INTO Notas (aluno_id, atividade_id, nota) VALUES (1, 1, 9.5);
INSERT INTO Notas (aluno_id, atividade_id, nota) VALUES (2, 1, 8.0);
INSERT INTO Notas (aluno_id, atividade_id, nota) VALUES (3, 2, 7.5);


-- Listar o nome de todos os Alunos com suas respectivas Turmas
SELECT al.nome, al.aluno_id, Turmas.turma_id
FROM Alunos AS al
INNER JOIN Turmas ON Turmas.turma_id = al.turma_id;

-- Listar todos os alunos e suas notas na atividade 1, incluindo alunos sem nota
SELECT al.nome, al.aluno_id, Notas.atividade_id, Notas.nota
FROM Alunos AS al
LEFT JOIN Notas ON Notas.aluno_id = al.aluno_id AND atividade_id = 1;

-- Listar todas as notas e os nomes dos alunos correspondentes,incluindo notas sem aluno correspondente
SELECT n.nota, Alunos.aluno_id, Alunos.nome
FROM Notas AS n
RIGHT JOIN Alunos ON Alunos.aluno_id = n.aluno_id;

-- Listar o nome dos alunos, a descrição de suas turmas e os nomes de seus professores
SELECT Alunos.nome AS Nome_aluno,
    Turmas.descricao AS Descricao_turma,
    Professores.nome AS Nome_professor
FROM 
    Alunos
JOIN  
    Turmas ON Alunos.turma_id = Turmas.turma_id
JOIN 
    Turma_Professor ON Turmas.turma_id = Turma_Professor.turma_id
JOIN 
    Professores ON Turma_Professor.professor_id = Professores.professor_id;
    
 -- Listar todos os alunos e todas as turmas, mostrando onde há ou não correspondência   
   SELECT 
    Professores.nome AS Nome_Professor
FROM 
    Professores
LEFT JOIN Turma_Professor ON Professores.professor_id = Turma_Professor.professor_id
WHERE Turma_Professor.turma_id IS NULL;



