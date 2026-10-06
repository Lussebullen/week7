-- One-to-One relationship example
CREATE table Users (
    id serial primary key,
    name varchar(50) not null,
    email varchar(50) not null,
    created_at timestamp default current_timestamp
);

CREATE table Profiles (
    id serial primary key,
	user_id int,
    foreign key (user_id) references Users(id),
    bio varchar(100)
);
-- populate tables with data
INSERT INTO Users (name, email) VALUES ('Alice', 'alice@example.com');
INSERT INTO Users (name, email) VALUES ('Kalle', 'kalle@example.com');
INSERT INTO Users (name, email) VALUES ('Alice', 'alice@example.com');
INSERT INTO Users (name, email) VALUES ('Bob', 'bob@example.com');
INSERT INTO Users (name, email) VALUES ('Charlie', 'charlie@example.com');
INSERT INTO Users (name, email) VALUES ('David', 'david@example.com');
INSERT INTO Users (name, email) VALUES ('Eve', 'eve@example.com');
INSERT INTO Users (name, email) VALUES ('Frank', 'frank@example.com');

INSERT INTO Profiles (user_id, bio) VALUES (1, 'Loves programming and databases');
INSERT INTO Profiles (user_id, bio) VALUES (2, 'Loves hiking and nature');
INSERT INTO Profiles (user_id, bio) VALUES (3, 'Enjoys reading and writing');
INSERT INTO Profiles (user_id, bio) VALUES (4, 'Passionate about music and art');
INSERT INTO Profiles (user_id, bio) VALUES (5, 'Interested in technology and innovation');
INSERT INTO Profiles (user_id, bio) VALUES (6, 'Fascinated by history and culture');
INSERT INTO Profiles (user_id, bio) VALUES (7, 'Loves cooking and baking');
INSERT INTO Profiles (user_id, bio) VALUES (8, 'Enjoys traveling and exploring new places');


SELECT Users.name, Profiles.bio
FROM Users
JOIN Profiles ON Users.id = Profiles.user_id;

-- Authors and Books example (one-to-many relationship)
CREATE TABLE Authors (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

CREATE TABLE Books (
    id SERIAL PRIMARY KEY,
    title varchar(100) NOT NULL,
    author_id int,
    FOREIGN KEY (author_id) REFERENCES Authors(id)
);

-- Populate tables with data
INSERT INTO Authors (name) VALUES ('J.K. Rowling');
INSERT INTO Authors (name) VALUES ('George R.R. Martin');
INSERT INTO Authors (name) VALUES ('J.R.R. Tolkien');

INSERT INTO Books (title, author_id) VALUES ('Harry Potter and the Sorcerer''s Stone', 1);
INSERT INTO Books (title, author_id) VALUES ('Fantastic beasts', 1);
INSERT INTO Books (title, author_id) VALUES ('A Game of Thrones', 2);
INSERT INTO Books (title, author_id) VALUES ('The Hobbit', 3);


SELECT Authors.name, Books.title 
FROM Authors
LEFT JOIN Books ON Authors.id = Books.author_id
ORDER BY Authors.name;

-- Student and courses example (many-to-many relationship)
CREATE TABLE Students (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

CREATE TABLE Courses (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

CREATE TABLE Student_Courses (
    student_id int,
    course_id int,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

-- Randomize 5 students
INSERT INTO Students (name) VALUES ('Alice');
INSERT INTO Students (name) VALUES ('Bob');
INSERT INTO Students (name) VALUES ('Charlie');
INSERT INTO Students (name) VALUES ('David');
INSERT INTO Students (name) VALUES ('Eve');

-- Randomize 3 courses
INSERT INTO Courses (name) VALUES ('Mathematics');
INSERT INTO Courses (name) VALUES ('Physics');
INSERT INTO Courses (name) VALUES ('Chemistry');

-- Randomize student-course relationships
INSERT INTO Student_Courses (student_id, course_id) VALUES (1, 1); 
INSERT INTO Student_Courses (student_id, course_id) VALUES (1, 2);
INSERT INTO Student_Courses (student_id, course_id) VALUES (2, 1);
INSERT INTO Student_Courses (student_id, course_id) VALUES (2, 3);
INSERT INTO Student_Courses (student_id, course_id) VALUES (3, 2);

SELECT Students.name, Courses.name
FROM Students
JOIN Student_Courses ON Students.id = Student_Courses.student_id
JOIN Courses ON Courses.id = Student_Courses.course_id;

-- Drop tables (order is important due to foreign key constraints)
drop table books
drop table authors
drop table profiles
drop table users
drop table student_courses
drop table students
drop table courses
