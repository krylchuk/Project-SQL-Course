USE sql_course;

INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Abbie', 'Chaves', 'abbichaves@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Robert', 'Berton', 'robertberton@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Karla', 'Morrison', 'karlamorrison@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES('David', 'Browning', 'davidbrowning@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Ariana', 'Jones', 'arianajones@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Frank', 'Lampard', 'franklampard@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Lionel', 'Messi', 'lionelmessi@example.com');
INSERT INTO students (students_first_name, students_last_name, students_email) 
VALUES ('Henry', 'Devids', 'henrydevids@example.com');


INSERT INTO professors (professors_first_name, professors_last_name, professors_email) 
VALUES ('Joaquin', 'Rosa', 'joaquinrosa@example.com');
INSERT INTO professors (professors_first_name, professors_last_name, professors_email) 
VALUES ('Carlos', 'Colina', 'carlosc0lina@example.com');
INSERT INTO professors (professors_first_name, professors_last_name, professors_email) 
VALUES ('Asier', 'Korta', 'asierkorta@example.com');
INSERT INTO professors (professors_first_name, professors_last_name, professors_email) 
VALUES ('Victoria', 'Ernesto', 'victoriaernesto@example.com');
INSERT INTO professors (professors_first_name, professors_last_name, professors_email) 
VALUES ('Daniel', 'Vazques', 'danielvazques@example.com');


INSERT INTO courses (courses_name, courses_professor_id) 
VALUES ('Javascript', 1);
INSERT INTO courses (courses_name, courses_professor_id) 
VALUES ('Python', 2);
INSERT INTO courses (courses_name, courses_professor_id) 
VALUES ('Go', 3);
INSERT INTO courses (courses_name, courses_professor_id) 
VALUES ('Java', 4);
INSERT INTO courses (courses_name, courses_professor_id) 
VALUES ('Kotlin', 5);


INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (1, 1, 8), (1, 2, 9), (1, 3, 9), (1, 4, 8), (1, 5, 10);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (2, 1, 8), (2, 2, 9), (2, 3, 9), (2, 4, 7), (2, 5, 7);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (3, 1, 10), (3, 2, 9), (3, 3, 8), (3, 4, 10), (3, 5, 9);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (4, 1, 7), (4, 2, 8), (4, 3, 9), (4, 4, 8), (4, 5, 7);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (5, 1, 9), (5, 2, 7), (5, 3, 9), (5, 4, 9), (5, 5, 10);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (6, 1, 9), (6, 2, 9), (6, 3, 7), (6, 4, 8), (6, 5, 9);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (7, 1, 10), (7, 2, 9), (7, 3, 8), (7, 4, 10), (7, 5, 9);
INSERT INTO grades (grades_student_id, grades_course_id, grades_value) 
VALUES (8, 1, 8), (8, 2, 7), (8, 3, 9), (8, 4, 7), (8, 5, 8);


-- The average grade that is given by each professor

SELECT 
	P.professors_first_name AS "Professor's first name", 
    P.professors_last_name AS "Professor's last name", 
    AVG(G.grades_value) AS 'Average Grade'
FROM professors P
JOIN courses C 
ON P.professors_id = C.courses_professor_id
JOIN grades G 
ON C.courses_id = G.grades_course_id
GROUP BY P.professors_id;


-- The top grades for each student

SELECT 
	S.students_first_name AS "Student's first name", 
	S.students_last_name AS "Student's last name",  
    MAX(G.grades_value) AS 'Highest Grade'
FROM students S
JOIN grades G 
ON S.students_id = G.grades_student_id
GROUP BY S.students_id;


-- Sort students by the courses that they are enrolled in

SELECT 
	S.students_first_name AS "Student's first name", 
	S.students_last_name AS "Student's last name", 
	C.courses_name AS 'Course'
FROM students S
JOIN grades G 
ON S.students_id = G.grades_student_id
JOIN courses C 
ON G.grades_course_id = C.courses_id
ORDER BY C.courses_name, S.students_last_name;


-- Create a summary report of courses and their average grades, sorted by the most challenging course (course with the lowest average grade) to the easiest course

SELECT 
	C.courses_name AS 'Course', 
    AVG(G.grades_value) AS 'Average Grade'
FROM courses C
JOIN grades G 
ON C.courses_id = G.grades_course_id
GROUP BY C.courses_id
ORDER BY `Average Grade` ASC;



-- Finding which student and professor have the most courses in common

SELECT 
	S.students_first_name AS "Student's First Name", 
    S.students_last_name AS "Student's Last Name", 
	P.professors_first_name AS "Professor's First Name", 
    P.professors_last_name AS "Professor's Last Name",
	COUNT(*) AS shared_courses
FROM students S
JOIN grades G 
ON S.students_id = G.grades_student_id
JOIN courses C 
ON G.grades_course_id = C.courses_id
JOIN professors P 
ON C.courses_professor_id = P.professors_id
GROUP BY S.students_id, P.professors_id
ORDER BY shared_courses DESC
LIMIT 1;





