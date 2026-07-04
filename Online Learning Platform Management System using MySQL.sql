-- STEP 0

CREATE DATABASE online_learning_db;

USE online_learning_db;
CREATE TABLE course_category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);
DESC course_category;

CREATE TABLE trainer (
    trainer_id INT PRIMARY KEY,
    trainer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    mobile_number VARCHAR(15) UNIQUE,
    specialization VARCHAR(100),
    joining_date DATE
);
DESC trainer;

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    mobile_number VARCHAR(15) UNIQUE,
    registration_date DATE,
    CONSTRAINT chk_gender
        CHECK (gender IN ('Male','Female','Other'))
);
DESC student;

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category_id INT,
    trainer_id INT,
    duration INT CHECK (duration > 0),
    course_fee DECIMAL(10,2) CHECK (course_fee > 0),

    CONSTRAINT fk_course_category
        FOREIGN KEY (category_id)
        REFERENCES course_category(category_id),

    CONSTRAINT fk_course_trainer
        FOREIGN KEY (trainer_id)
        REFERENCES trainer(trainer_id)
);
DESC course;

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    enrollment_status VARCHAR(20),

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    CONSTRAINT chk_enrollment_status
        CHECK (enrollment_status IN ('Active','Completed','Dropped'))
);
DESC enrollment;

CREATE TABLE assessment (
    assessment_id INT PRIMARY KEY,
    course_id INT,
    assessment_name VARCHAR(100),
    maximum_marks INT,

    CONSTRAINT fk_assessment_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    CONSTRAINT chk_maximum_marks
        CHECK (maximum_marks > 0)
);
DESC assessment;

CREATE TABLE student_assessment (
    result_id INT PRIMARY KEY,
    student_id INT,
    assessment_id INT,
    marks_obtained INT,

    CONSTRAINT fk_student_assessment_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_student_assessment_assessment
        FOREIGN KEY (assessment_id)
        REFERENCES assessment(assessment_id),

    CONSTRAINT chk_marks_obtained
        CHECK (marks_obtained >= 0)
);
DESC student_assessment;

CREATE TABLE certificate (
    certificate_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    issue_date DATE,

    CONSTRAINT fk_certificate_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_certificate_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id)
);
DESC certificate;

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    rating INT,
    comments VARCHAR(500),

    CONSTRAINT fk_feedback_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_feedback_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    CONSTRAINT chk_rating
        CHECK (rating BETWEEN 1 AND 5)
);
DESC feedback;

INSERT INTO course_category (category_id, category_name) VALUES
(1001, 'Programming'),
(1002, 'Data Analytics'),
(1003, 'Web Development'),
(1004, 'Database'),
(1005, 'Cloud Computing'),
(1006, 'Cyber Security'),
(1007, 'Artificial Intelligence'),
(1008, 'Machine Learning'),
(1009, 'Digital Marketing'),
(1010, 'Business Management');
SELECT * FROM course_category;

INSERT INTO trainer 
(trainer_id, trainer_name, email, mobile_number, specialization, joining_date)
VALUES
(1001,'Arun Kumar','arun.kumar@gmail.com','9876500001','Programming','2022-01-15'),
(1002,'Priya Sharma','priya.sharma@gmail.com','9876500002','Data Analytics','2022-02-10'),
(1003,'Rahul Verma','rahul.verma@gmail.com','9876500003','Web Development','2022-03-05'),
(1004,'Sneha Reddy','sneha.reddy@gmail.com','9876500004','Database','2022-04-12'),
(1005,'Vikram Singh','vikram.singh@gmail.com','9876500005','Cloud Computing','2022-05-20'),
(1006,'Anita Das','anita.das@gmail.com','9876500006','Cyber Security','2022-06-18'),
(1007,'Karthik Raj','karthik.raj@gmail.com','9876500007','Artificial Intelligence','2022-07-25'),
(1008,'Meena Joseph','meena.joseph@gmail.com','9876500008','Machine Learning','2022-08-08'),
(1009,'Suresh Babu','suresh.babu@gmail.com','9876500009','Digital Marketing','2022-09-14'),
(1010,'Divya Nair','divya.nair@gmail.com','9876500010','Business Management','2022-10-01'),
(1011,'Ajay Kumar','ajay.kumar@gmail.com','9876500011','Programming','2023-01-10'),
(1012,'Pooja Gupta','pooja.gupta@gmail.com','9876500012','Data Analytics','2023-02-15'),
(1013,'Ramesh Iyer','ramesh.iyer@gmail.com','9876500013','Web Development','2023-03-20'),
(1014,'Nisha Patel','nisha.patel@gmail.com','9876500014','Database','2023-04-18'),
(1015,'Deepak Rao','deepak.rao@gmail.com','9876500015','Cloud Computing','2023-05-25'),
(1016,'Kavitha S','kavitha.s@gmail.com','9876500016','Cyber Security','2023-06-30'),
(1017,'Manoj Kumar','manoj.kumar@gmail.com','9876500017','Artificial Intelligence','2023-07-12'),
(1018,'Lakshmi Devi','lakshmi.devi@gmail.com','9876500018','Machine Learning','2023-08-09'),
(1019,'Hari Prasad','hari.prasad@gmail.com','9876500019','Digital Marketing','2023-09-21'),
(1020,'Rekha Menon','rekha.menon@gmail.com','9876500020','Business Management','2023-10-05');
SELECT * FROM trainer;

INSERT INTO student
(student_id, student_name, gender, date_of_birth, email, mobile_number, registration_date)
VALUES
(1001,'Aarav Sharma','Male','2002-01-15','aarav@gmail.com','9000000001','2025-01-10'),
(1002,'Aditi Singh','Female','2003-02-20','aditi@gmail.com','9000000002','2025-01-12'),
(1003,'Akash Kumar','Male','2001-03-18','akash@gmail.com','9000000003','2025-01-15'),
(1004,'Ananya Reddy','Female','2002-04-25','ananya@gmail.com','9000000004','2025-01-18'),
(1005,'Arjun Patel','Male','2003-05-30','arjun@gmail.com','9000000005','2025-01-20'),
(1006,'Bhavya Nair','Female','2002-06-10','bhavya@gmail.com','9000000006','2025-01-22'),
(1007,'Charan Raj','Male','2001-07-05','charan@gmail.com','9000000007','2025-01-25'),
(1008,'Deepika Das','Female','2002-08-12','deepika@gmail.com','9000000008','2025-01-28'),
(1009,'Dinesh Kumar','Male','2003-09-17','dinesh@gmail.com','9000000009','2025-02-01'),
(1010,'Divya Sharma','Female','2002-10-22','divya@gmail.com','9000000010','2025-02-05'),
(1011,'Eshwar Rao','Male','2001-11-11','eshwar@gmail.com','9000000011','2025-02-08'),
(1012,'Farzana Ali','Female','2003-12-14','farzana@gmail.com','9000000012','2025-02-10'),
(1013,'Gokul Krishna','Male','2002-01-09','gokul@gmail.com','9000000013','2025-02-12'),
(1014,'Harini S','Female','2001-02-16','harini@gmail.com','9000000014','2025-02-15'),
(1015,'Harish Kumar','Male','2002-03-21','harish@gmail.com','9000000015','2025-02-18'),
(1016,'Ishwarya R','Female','2003-04-07','ishwarya@gmail.com','9000000016','2025-02-20'),
(1017,'Jagan Mohan','Male','2002-05-19','jagan@gmail.com','9000000017','2025-02-23'),
(1018,'Janani Devi','Female','2001-06-27','janani@gmail.com','9000000018','2025-02-26'),
(1019,'Karthik S','Male','2003-07-13','karthiks@gmail.com','9000000019','2025-03-01'),
(1020,'Keerthana M','Female','2002-08-08','keerthana@gmail.com','9000000020','2025-03-03'),
(1021,'Lokesh Kumar','Male','2001-09-15','lokesh@gmail.com','9000000021','2025-03-05'),
(1022,'Madhumitha P','Female','2003-10-10','madhu@gmail.com','9000000022','2025-03-08'),
(1023,'Manikandan R','Male','2002-11-22','manikandan@gmail.com','9000000023','2025-03-10'),
(1024,'Meghana T','Female','2001-12-05','meghana@gmail.com','9000000024','2025-03-12'),
(1025,'Naveen Kumar','Male','2002-01-30','naveen@gmail.com','9000000025','2025-03-15');
SELECT * FROM student;

INSERT INTO student
(student_id, student_name, gender, date_of_birth, email, mobile_number, registration_date)
VALUES
(1026,'Nithya R','Female','2003-02-11','nithya@gmail.com','9000000026','2025-03-18'),
(1027,'Prakash Kumar','Male','2002-03-16','prakash@gmail.com','9000000027','2025-03-20'),
(1028,'Preethi S','Female','2001-04-09','preethi@gmail.com','9000000028','2025-03-22'),
(1029,'Rahul M','Male','2003-05-14','rahulm@gmail.com','9000000029','2025-03-25'),
(1030,'Ramya K','Female','2002-06-19','ramya@gmail.com','9000000030','2025-03-28'),
(1031,'Rohit Sharma','Male','2001-07-23','rohit@gmail.com','9000000031','2025-04-01'),
(1032,'Sandhya P','Female','2003-08-12','sandhya@gmail.com','9000000032','2025-04-03'),
(1033,'Saravanan R','Male','2002-09-17','saravanan@gmail.com','9000000033','2025-04-05'),
(1034,'Shalini Devi','Female','2001-10-20','shalini@gmail.com','9000000034','2025-04-08'),
(1035,'Siva Kumar','Male','2003-11-11','siva@gmail.com','9000000035','2025-04-10'),
(1036,'Sneha M','Female','2002-12-15','sneha@gmail.com','9000000036','2025-04-12'),
(1037,'Srinath K','Male','2001-01-18','srinath@gmail.com','9000000037','2025-04-15'),
(1038,'Swathi R','Female','2003-02-21','swathi@gmail.com','9000000038','2025-04-18'),
(1039,'Tamilselvan P','Male','2002-03-24','tamilselvan@gmail.com','9000000039','2025-04-20'),
(1040,'Udhaya Kumar','Male','2001-04-28','udhaya@gmail.com','9000000040','2025-04-22'),
(1041,'Vaishnavi S','Female','2003-05-30','vaishnavi@gmail.com','9000000041','2025-04-25'),
(1042,'Vignesh R','Male','2002-06-08','vignesh@gmail.com','9000000042','2025-04-28'),
(1043,'Vinoth Kumar','Male','2001-07-14','vinoth@gmail.com','9000000043','2025-05-01'),
(1044,'Yamini K','Female','2003-08-18','yamini@gmail.com','9000000044','2025-05-03'),
(1045,'Yash Kumar','Male','2002-09-22','yash@gmail.com','9000000045','2025-05-05'),
(1046,'Zara Ali','Female','2001-10-10','zara@gmail.com','9000000046','2025-05-08'),
(1047,'Abhishek Raj','Male','2003-11-16','abhishek@gmail.com','9000000047','2025-05-10'),
(1048,'Bhuvana S','Female','2002-12-20','bhuvana@gmail.com','9000000048','2025-05-12'),
(1049,'Chandru M','Male','2001-01-25','chandru@gmail.com','9000000049','2025-05-15'),
(1050,'Dhivya R','Female','2003-02-28','dhivya@gmail.com','9000000050','2025-05-18');
SELECT COUNT(*) AS total_students
FROM student;

INSERT INTO course
(course_id, course_name, category_id, trainer_id, duration, course_fee)
VALUES
(1001,'Python Programming',1001,1001,90,15000.00),
(1002,'Java Programming',1001,1011,120,18000.00),
(1003,'SQL Fundamentals',1004,1004,60,12000.00),
(1004,'Advanced SQL',1004,1014,75,16000.00),
(1005,'Excel for Data Analytics',1002,1002,45,10000.00),
(1006,'Power BI',1002,1012,60,14000.00),
(1007,'Tableau',1002,1002,60,14500.00),
(1008,'HTML & CSS',1003,1003,45,9000.00),
(1009,'JavaScript',1003,1013,75,13000.00),
(1010,'React JS',1003,1003,90,17000.00),
(1011,'AWS Cloud Basics',1005,1005,90,22000.00),
(1012,'Azure Fundamentals',1005,1015,90,21000.00),
(1013,'Ethical Hacking',1006,1006,120,25000.00),
(1014,'Network Security',1006,1016,90,23000.00),
(1015,'Artificial Intelligence',1007,1007,120,30000.00),
(1016,'Machine Learning',1008,1008,120,32000.00),
(1017,'Deep Learning',1008,1018,150,35000.00),
(1018,'Digital Marketing',1009,1009,60,11000.00),
(1019,'SEO Fundamentals',1009,1019,45,9500.00),
(1020,'Business Analytics',1010,1010,90,20000.00);
SELECT * FROM course;

INSERT INTO enrollment
(enrollment_id, student_id, course_id, enrollment_date, enrollment_status)
VALUES
(1001,1001,1001,'2025-06-01','Active'),
(1002,1002,1002,'2025-06-02','Completed'),
(1003,1003,1003,'2025-06-03','Active'),
(1004,1004,1004,'2025-06-04','Dropped'),
(1005,1005,1005,'2025-06-05','Completed'),
(1006,1006,1006,'2025-06-06','Active'),
(1007,1007,1007,'2025-06-07','Completed'),
(1008,1008,1008,'2025-06-08','Active'),
(1009,1009,1009,'2025-06-09','Dropped'),
(1010,1010,1010,'2025-06-10','Completed'),
(1011,1011,1011,'2025-06-11','Active'),
(1012,1012,1012,'2025-06-12','Completed'),
(1013,1013,1013,'2025-06-13','Active'),
(1014,1014,1014,'2025-06-14','Completed'),
(1015,1015,1015,'2025-06-15','Dropped'),
(1016,1016,1016,'2025-06-16','Active'),
(1017,1017,1017,'2025-06-17','Completed'),
(1018,1018,1018,'2025-06-18','Active'),
(1019,1019,1019,'2025-06-19','Completed'),
(1020,1020,1020,'2025-06-20','Active'),
(1021,1021,1001,'2025-06-21','Completed'),
(1022,1022,1002,'2025-06-22','Active'),
(1023,1023,1003,'2025-06-23','Completed'),
(1024,1024,1004,'2025-06-24','Dropped'),
(1025,1025,1005,'2025-06-25','Active');
SELECT COUNT(*) AS total_enrollments
FROM enrollment;

INSERT INTO enrollment
(enrollment_id, student_id, course_id, enrollment_date, enrollment_status)
VALUES
(1026,1026,1006,'2025-06-26','Completed'),
(1027,1027,1007,'2025-06-27','Active'),
(1028,1028,1008,'2025-06-28','Completed'),
(1029,1029,1009,'2025-06-29','Active'),
(1030,1030,1010,'2025-06-30','Dropped'),
(1031,1031,1011,'2025-07-01','Completed'),
(1032,1032,1012,'2025-07-02','Active'),
(1033,1033,1013,'2025-07-03','Completed'),
(1034,1034,1014,'2025-07-04','Active'),
(1035,1035,1015,'2025-07-05','Completed'),
(1036,1036,1016,'2025-07-06','Dropped'),
(1037,1037,1017,'2025-07-07','Active'),
(1038,1038,1018,'2025-07-08','Completed'),
(1039,1039,1019,'2025-07-09','Active'),
(1040,1040,1020,'2025-07-10','Completed'),
(1041,1041,1001,'2025-07-11','Active'),
(1042,1042,1002,'2025-07-12','Completed'),
(1043,1043,1003,'2025-07-13','Active'),
(1044,1044,1004,'2025-07-14','Dropped'),
(1045,1045,1005,'2025-07-15','Completed'),
(1046,1046,1006,'2025-07-16','Active'),
(1047,1047,1007,'2025-07-17','Completed'),
(1048,1048,1008,'2025-07-18','Active'),
(1049,1049,1009,'2025-07-19','Completed'),
(1050,1050,1010,'2025-07-20','Active');
SELECT COUNT(*) AS total_enrollments
FROM enrollment;

INSERT INTO enrollment
(enrollment_id, student_id, course_id, enrollment_date, enrollment_status)
VALUES
(1051,1001,1011,'2025-07-21','Completed'),
(1052,1002,1012,'2025-07-22','Active'),
(1053,1003,1013,'2025-07-23','Completed'),
(1054,1004,1014,'2025-07-24','Active'),
(1055,1005,1015,'2025-07-25','Dropped'),
(1056,1006,1016,'2025-07-26','Completed'),
(1057,1007,1017,'2025-07-27','Active'),
(1058,1008,1018,'2025-07-28','Completed'),
(1059,1009,1019,'2025-07-29','Active'),
(1060,1010,1020,'2025-07-30','Completed'),
(1061,1011,1001,'2025-07-31','Active'),
(1062,1012,1002,'2025-08-01','Completed'),
(1063,1013,1003,'2025-08-02','Active'),
(1064,1014,1004,'2025-08-03','Dropped'),
(1065,1015,1005,'2025-08-04','Completed'),
(1066,1016,1006,'2025-08-05','Active'),
(1067,1017,1007,'2025-08-06','Completed'),
(1068,1018,1008,'2025-08-07','Active'),
(1069,1019,1009,'2025-08-08','Completed'),
(1070,1020,1010,'2025-08-09','Active'),
(1071,1021,1011,'2025-08-10','Completed'),
(1072,1022,1012,'2025-08-11','Active'),
(1073,1023,1013,'2025-08-12','Completed'),
(1074,1024,1014,'2025-08-13','Active'),
(1075,1025,1015,'2025-08-14','Dropped');
SELECT COUNT(*) AS total_enrollments
FROM enrollment;

INSERT INTO enrollment
(enrollment_id, student_id, course_id, enrollment_date, enrollment_status)
VALUES
(1076,1026,1016,'2025-08-15','Completed'),
(1077,1027,1017,'2025-08-16','Active'),
(1078,1028,1018,'2025-08-17','Completed'),
(1079,1029,1019,'2025-08-18','Active'),
(1080,1030,1020,'2025-08-19','Dropped'),
(1081,1031,1001,'2025-08-20','Completed'),
(1082,1032,1002,'2025-08-21','Active'),
(1083,1033,1003,'2025-08-22','Completed'),
(1084,1034,1004,'2025-08-23','Active'),
(1085,1035,1005,'2025-08-24','Completed'),
(1086,1036,1006,'2025-08-25','Dropped'),
(1087,1037,1007,'2025-08-26','Active'),
(1088,1038,1008,'2025-08-27','Completed'),
(1089,1039,1009,'2025-08-28','Active'),
(1090,1040,1010,'2025-08-29','Completed'),
(1091,1041,1011,'2025-08-30','Active'),
(1092,1042,1012,'2025-08-31','Completed'),
(1093,1043,1013,'2025-09-01','Active'),
(1094,1044,1014,'2025-09-02','Dropped'),
(1095,1045,1015,'2025-09-03','Completed'),
(1096,1046,1016,'2025-09-04','Active'),
(1097,1047,1017,'2025-09-05','Completed'),
(1098,1048,1018,'2025-09-06','Active'),
(1099,1049,1019,'2025-09-07','Completed'),
(1100,1050,1020,'2025-09-08','Active');
SELECT COUNT(*) AS total_enrollments
FROM enrollment;

INSERT INTO assessment
(assessment_id, course_id, assessment_name, maximum_marks)
VALUES
(1001,1001,'Python Basics Test',100),
(1002,1001,'Python Final Exam',100),
(1003,1002,'Java Basics Test',100),
(1004,1002,'Java Final Exam',100),
(1005,1003,'SQL Quiz 1',100),
(1006,1003,'SQL Final Exam',100),
(1007,1004,'Advanced SQL Quiz',100),
(1008,1004,'Advanced SQL Final',100),
(1009,1005,'Excel Assignment',100),
(1010,1005,'Excel Final Exam',100),
(1011,1006,'Power BI Quiz',100),
(1012,1006,'Power BI Final Exam',100),
(1013,1007,'Tableau Assignment',100),
(1014,1007,'Tableau Final Exam',100),
(1015,1008,'HTML & CSS Test',100),
(1016,1008,'HTML & CSS Final',100),
(1017,1009,'JavaScript Quiz',100),
(1018,1009,'JavaScript Final',100),
(1019,1010,'React JS Test',100),
(1020,1010,'React JS Final',100),
(1021,1011,'AWS Basics Quiz',100),
(1022,1012,'Azure Fundamentals Test',100),
(1023,1013,'Ethical Hacking Exam',100),
(1024,1014,'Network Security Exam',100),
(1025,1015,'AI Fundamentals Test',100);
SELECT COUNT(*) AS total_assessments
FROM assessment;

INSERT INTO assessment
(assessment_id, course_id, assessment_name, maximum_marks)
VALUES
(1026,1015,'AI Final Exam',100),
(1027,1016,'Machine Learning Quiz',100),
(1028,1016,'Machine Learning Final',100),
(1029,1017,'Deep Learning Quiz',100),
(1030,1017,'Deep Learning Final',100),
(1031,1018,'Digital Marketing Quiz',100),
(1032,1018,'Digital Marketing Final',100),
(1033,1019,'SEO Basics Quiz',100),
(1034,1019,'SEO Final Exam',100),
(1035,1020,'Business Analytics Quiz',100),
(1036,1020,'Business Analytics Final',100),
(1037,1001,'Python Project',100),
(1038,1002,'Java Project',100),
(1039,1003,'SQL Practical',100),
(1040,1004,'Advanced SQL Project',100),
(1041,1005,'Excel Practical',100),
(1042,1006,'Power BI Dashboard',100),
(1043,1007,'Tableau Dashboard',100),
(1044,1008,'HTML Project',100),
(1045,1009,'JavaScript Project',100),
(1046,1010,'React Project',100),
(1047,1011,'AWS Practical',100),
(1048,1012,'Azure Practical',100),
(1049,1013,'Cyber Security Lab',100),
(1050,1014,'Network Security Lab',100);
SELECT COUNT(*) AS total_assessments
FROM assessment;


INSERT INTO student_assessment
(result_id, student_id, assessment_id, marks_obtained)
VALUES
(1001,1001,1001,85),
(1002,1002,1002,90),
(1003,1003,1003,78),
(1004,1004,1004,88),
(1005,1005,1005,92),
(1006,1006,1006,75),
(1007,1007,1007,81),
(1008,1008,1008,95),
(1009,1009,1009,69),
(1010,1010,1010,87),
(1011,1011,1011,91),
(1012,1012,1012,84),
(1013,1013,1013,79),
(1014,1014,1014,93),
(1015,1015,1015,77),
(1016,1016,1016,89),
(1017,1017,1017,94),
(1018,1018,1018,82),
(1019,1019,1019,86),
(1020,1020,1020,90),
(1021,1021,1021,88),
(1022,1022,1022,83),
(1023,1023,1023,97),
(1024,1024,1024,76),
(1025,1025,1025,85);
SELECT COUNT(*) AS total_student_assessments
FROM student_assessment;

INSERT INTO student_assessment
(result_id, student_id, assessment_id, marks_obtained)
VALUES
(1026,1026,1026,91),
(1027,1027,1027,87),
(1028,1028,1028,84),
(1029,1029,1029,89),
(1030,1030,1030,76),
(1031,1031,1031,93),
(1032,1032,1032,82),
(1033,1033,1033,88),
(1034,1034,1034,79),
(1035,1035,1035,95),
(1036,1036,1036,86),
(1037,1037,1037,90),
(1038,1038,1038,81),
(1039,1039,1039,94),
(1040,1040,1040,77),
(1041,1041,1041,85),
(1042,1042,1042,92),
(1043,1043,1043,83),
(1044,1044,1044,89),
(1045,1045,1045,80),
(1046,1046,1046,96),
(1047,1047,1047,88),
(1048,1048,1048,91),
(1049,1049,1049,84),
(1050,1050,1050,93);
SELECT COUNT(*) AS total_student_assessments
FROM student_assessment;

INSERT INTO student_assessment
(result_id, student_id, assessment_id, marks_obtained)
VALUES
(1051,1001,1001,87),
(1052,1002,1002,92),
(1053,1003,1003,80),
(1054,1004,1004,89),
(1055,1005,1005,94),
(1056,1006,1006,78),
(1057,1007,1007,85),
(1058,1008,1008,97),
(1059,1009,1009,72),
(1060,1010,1010,90),
(1061,1011,1011,93),
(1062,1012,1012,86),
(1063,1013,1013,82),
(1064,1014,1014,95),
(1065,1015,1015,79),
(1066,1016,1016,91),
(1067,1017,1017,96),
(1068,1018,1018,84),
(1069,1019,1019,88),
(1070,1020,1020,92),
(1071,1021,1021,90),
(1072,1022,1022,85),
(1073,1023,1023,98),
(1074,1024,1024,81),
(1075,1025,1025,87);
SELECT COUNT(*) AS total_student_assessments
FROM student_assessment;

INSERT INTO student_assessment
(result_id, student_id, assessment_id, marks_obtained)
VALUES
(1076,1026,1026,94),
(1077,1027,1027,86),
(1078,1028,1028,89),
(1079,1029,1029,83),
(1080,1030,1030,77),
(1081,1031,1031,91),
(1082,1032,1032,84),
(1083,1033,1033,90),
(1084,1034,1034,82),
(1085,1035,1035,96),
(1086,1036,1036,88),
(1087,1037,1037,93),
(1088,1038,1038,85),
(1089,1039,1039,92),
(1090,1040,1040,80),
(1091,1041,1041,87),
(1092,1042,1042,95),
(1093,1043,1043,86),
(1094,1044,1044,90),
(1095,1045,1045,81),
(1096,1046,1046,97),
(1097,1047,1047,89),
(1098,1048,1048,94),
(1099,1049,1049,85),
(1100,1050,1050,92);
SELECT COUNT(*) AS total_student_assessments
FROM student_assessment;


INSERT INTO certificate
(certificate_id, student_id, course_id, issue_date)
VALUES
(1001,1001,1001,'2025-09-15'),
(1002,1002,1002,'2025-09-16'),
(1003,1003,1003,'2025-09-17'),
(1004,1004,1004,'2025-09-18'),
(1005,1005,1005,'2025-09-19'),
(1006,1006,1006,'2025-09-20'),
(1007,1007,1007,'2025-09-21'),
(1008,1008,1008,'2025-09-22'),
(1009,1009,1009,'2025-09-23'),
(1010,1010,1010,'2025-09-24'),
(1011,1011,1011,'2025-09-25'),
(1012,1012,1012,'2025-09-26'),
(1013,1013,1013,'2025-09-27'),
(1014,1014,1014,'2025-09-28'),
(1015,1015,1015,'2025-09-29'),
(1016,1016,1016,'2025-09-30'),
(1017,1017,1017,'2025-10-01'),
(1018,1018,1018,'2025-10-02'),
(1019,1019,1019,'2025-10-03'),
(1020,1020,1020,'2025-10-04'),
(1021,1021,1001,'2025-10-05'),
(1022,1022,1002,'2025-10-06'),
(1023,1023,1003,'2025-10-07'),
(1024,1024,1004,'2025-10-08'),
(1025,1025,1005,'2025-10-09');
SELECT COUNT(*) AS total_certificates
FROM certificate;

INSERT INTO certificate
(certificate_id, student_id, course_id, issue_date)
VALUES
(1026,1026,1006,'2025-10-10'),
(1027,1027,1007,'2025-10-11'),
(1028,1028,1008,'2025-10-12'),
(1029,1029,1009,'2025-10-13'),
(1030,1030,1010,'2025-10-14'),
(1031,1031,1011,'2025-10-15'),
(1032,1032,1012,'2025-10-16'),
(1033,1033,1013,'2025-10-17'),
(1034,1034,1014,'2025-10-18'),
(1035,1035,1015,'2025-10-19'),
(1036,1036,1016,'2025-10-20'),
(1037,1037,1017,'2025-10-21'),
(1038,1038,1018,'2025-10-22'),
(1039,1039,1019,'2025-10-23'),
(1040,1040,1020,'2025-10-24'),
(1041,1041,1001,'2025-10-25'),
(1042,1042,1002,'2025-10-26'),
(1043,1043,1003,'2025-10-27'),
(1044,1044,1004,'2025-10-28'),
(1045,1045,1005,'2025-10-29'),
(1046,1046,1006,'2025-10-30'),
(1047,1047,1007,'2025-10-31'),
(1048,1048,1008,'2025-11-01'),
(1049,1049,1009,'2025-11-02'),
(1050,1050,1010,'2025-11-03');
SELECT COUNT(*) AS total_certificates
FROM certificate;

INSERT INTO feedback
(feedback_id, student_id, course_id, rating, comments)
VALUES
(1001,1001,1001,5,'Excellent course with practical examples'),
(1002,1002,1002,4,'Very informative and useful'),
(1003,1003,1003,5,'Trainer explained concepts clearly'),
(1004,1004,1004,3,'Good course but needs more practice'),
(1005,1005,1005,4,'Well structured content'),
(1006,1006,1006,5,'Loved the hands-on sessions'),
(1007,1007,1007,4,'Easy to understand'),
(1008,1008,1008,5,'Highly recommended'),
(1009,1009,1009,3,'Can improve course materials'),
(1010,1010,1010,4,'Very helpful trainer'),
(1011,1011,1011,5,'Excellent cloud course'),
(1012,1012,1012,4,'Good practical exercises'),
(1013,1013,1013,5,'Cyber security concepts were clear'),
(1014,1014,1014,4,'Interesting learning experience'),
(1015,1015,1015,5,'AI course was outstanding'),
(1016,1016,1016,5,'Machine Learning explained well'),
(1017,1017,1017,4,'Deep Learning projects were useful'),
(1018,1018,1018,5,'Marketing strategies were practical'),
(1019,1019,1019,4,'SEO concepts were easy to follow'),
(1020,1020,1020,5,'Business Analytics course was excellent'),
(1021,1021,1001,4,'Python examples were useful'),
(1022,1022,1002,5,'Java programming was easy to learn'),
(1023,1023,1003,4,'SQL practical sessions helped a lot'),
(1024,1024,1004,5,'Advanced SQL was explained clearly'),
(1025,1025,1005,4,'Excel analytics course was good');
SELECT COUNT(*) AS total_feedback
FROM feedback;

INSERT INTO feedback
(feedback_id, student_id, course_id, rating, comments)
VALUES
(1026,1026,1006,5,'Power BI course was excellent'),
(1027,1027,1007,4,'Tableau concepts were easy'),
(1028,1028,1008,5,'HTML and CSS were explained well'),
(1029,1029,1009,4,'JavaScript examples were practical'),
(1030,1030,1010,5,'React JS projects were useful'),
(1031,1031,1011,4,'AWS fundamentals were clear'),
(1032,1032,1012,5,'Azure course exceeded expectations'),
(1033,1033,1013,4,'Ethical Hacking sessions were interesting'),
(1034,1034,1014,5,'Network Security concepts were clear'),
(1035,1035,1015,5,'Artificial Intelligence was amazing'),
(1036,1036,1016,4,'Machine Learning assignments were useful'),
(1037,1037,1017,5,'Deep Learning projects were excellent'),
(1038,1038,1018,4,'Digital Marketing examples were practical'),
(1039,1039,1019,5,'SEO course was well organized'),
(1040,1040,1020,5,'Business Analytics was informative'),
(1041,1041,1001,4,'Python trainer was supportive'),
(1042,1042,1002,5,'Java course had good examples'),
(1043,1043,1003,4,'SQL trainer explained very well'),
(1044,1044,1004,5,'Advanced SQL practicals were helpful'),
(1045,1045,1005,4,'Excel dashboard exercises were useful'),
(1046,1046,1006,5,'Power BI dashboard project was excellent'),
(1047,1047,1007,4,'Tableau visualizations were interesting'),
(1048,1048,1008,5,'Web development course was enjoyable'),
(1049,1049,1009,4,'JavaScript projects improved my skills'),
(1050,1050,1010,5,'React JS course was outstanding');
SELECT COUNT(*) AS total_feedback
FROM feedback;

SELECT student_id,
       UPPER(student_name) AS student_name_upper
FROM student;

SELECT trainer_id,
       LOWER(trainer_name) AS trainer_name_lower
FROM trainer;


SELECT course_id,
       course_name,
       LEFT(course_name, 4) AS first_four_characters
FROM course;

SELECT course_id,
       course_name,
       LENGTH(course_name) AS course_name_length
FROM course;

SELECT student_id,
       student_name,
       MONTH(registration_date) AS registration_month
FROM student;


SELECT MAX(course_fee) AS highest_course_fee
FROM course;

SELECT MIN(course_fee) AS lowest_course_fee
FROM course;

SELECT AVG(course_fee) AS average_course_fee
FROM course;

SELECT COUNT(*) AS total_students
FROM student;

SELECT COUNT(*) AS total_enrollments
FROM enrollment;

SELECT SUM(c.course_fee) AS total_revenue
FROM enrollment e
JOIN course c
ON e.course_id = c.course_id;


SELECT
    cc.category_name,
    COUNT(c.course_id) AS total_courses
FROM course_category cc
JOIN course c
ON cc.category_id = c.category_id
GROUP BY cc.category_name;

SELECT
    t.trainer_name,
    COUNT(c.course_id) AS total_courses
FROM trainer t
JOIN course c
ON t.trainer_id = c.trainer_id
GROUP BY t.trainer_name;

SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM course c
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT
    cc.category_name,
    SUM(c.course_fee) AS total_revenue
FROM course_category cc
JOIN course c
ON cc.category_id = c.category_id
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY cc.category_name;

SELECT
    t.trainer_name,
    COUNT(e.student_id) AS total_students
FROM trainer t
JOIN course c
ON t.trainer_id = c.trainer_id
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY t.trainer_name;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM course c
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 10;



SELECT
    t.trainer_name,
    COUNT(c.course_id) AS total_courses
FROM trainer t
JOIN course c
ON t.trainer_id = c.trainer_id
GROUP BY t.trainer_name
HAVING COUNT(c.course_id) > 2;

SELECT
    cc.category_name,
    SUM(c.course_fee) AS total_revenue
FROM course_category cc
JOIN course c
ON cc.category_id = c.category_id
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY cc.category_name
HAVING SUM(c.course_fee) > 100000;


SELECT
    s.student_name,
    c.course_name,
    t.trainer_name,
    e.enrollment_date
FROM enrollment e
INNER JOIN student s
    ON e.student_id = s.student_id
INNER JOIN course c
    ON e.course_id = c.course_id
INNER JOIN trainer t
    ON c.trainer_id = t.trainer_id;
    
    
    SELECT
    s.student_id,
    s.student_name,
    e.enrollment_id,
    e.course_id,
    e.enrollment_date,
    e.enrollment_status
FROM student s
LEFT JOIN enrollment e
ON s.student_id = e.student_id;
    
    
    SELECT
    s.student_id,
    s.student_name
FROM student s
LEFT JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

SELECT
    c.course_id,
    c.course_name,
    e.enrollment_id,
    e.student_id,
    e.enrollment_date,
    e.enrollment_status
FROM enrollment e
RIGHT JOIN course c
ON e.course_id = c.course_id;
    
    
    SELECT
    c.course_id,
    c.course_name
FROM enrollment e
RIGHT JOIN course c
ON e.course_id = c.course_id
WHERE e.course_id IS NULL;

SELECT
    s.student_id,
    s.student_name,
    e.enrollment_id,
    e.course_id,
    e.enrollment_date,
    e.enrollment_status
FROM student s
LEFT JOIN enrollment e
ON s.student_id = e.student_id

UNION

SELECT
    s.student_id,
    s.student_name,
    e.enrollment_id,
    e.course_id,
    e.enrollment_date,
    e.enrollment_status
FROM student s
RIGHT JOIN enrollment e
ON s.student_id = e.student_id;

ALTER TABLE student
ADD mentor_id INT;


ALTER TABLE student
ADD CONSTRAINT fk_student_mentor
FOREIGN KEY (mentor_id)
REFERENCES student(student_id);

UPDATE student SET mentor_id = 1001 WHERE student_id IN (1011,1021,1031,1041);
UPDATE student SET mentor_id = 1002 WHERE student_id IN (1012,1022,1032,1042);
UPDATE student SET mentor_id = 1003 WHERE student_id IN (1013,1023,1033,1043);
UPDATE student SET mentor_id = 1004 WHERE student_id IN (1014,1024,1034,1044);
UPDATE student SET mentor_id = 1005 WHERE student_id IN (1015,1025,1035,1045);
UPDATE student SET mentor_id = 1006 WHERE student_id IN (1016,1026,1036,1046);
UPDATE student SET mentor_id = 1007 WHERE student_id IN (1017,1027,1037,1047);
UPDATE student SET mentor_id = 1008 WHERE student_id IN (1018,1028,1038,1048);
UPDATE student SET mentor_id = 1009 WHERE student_id IN (1019,1029,1039,1049);
UPDATE student SET mentor_id = 1010 WHERE student_id IN (1020,1030,1040,1050);

SELECT
    s.student_name AS student_name,
    m.student_name AS mentor_name
FROM student s
LEFT JOIN student m
ON s.mentor_id = m.student_id;

SELECT
    t.trainer_name,
    cc.category_name
FROM trainer t
CROSS JOIN course_category cc;


SELECT
    s.student_name,
    c.course_name,
    cc.category_name,
    t.trainer_name,
    sa.marks_obtained,
    CASE
        WHEN cert.certificate_id IS NOT NULL THEN 'Issued'
        ELSE 'Not Issued'
    END AS certificate_status
FROM student s
JOIN enrollment e
    ON s.student_id = e.student_id
JOIN course c
    ON e.course_id = c.course_id
JOIN course_category cc
    ON c.category_id = cc.category_id
JOIN trainer t
    ON c.trainer_id = t.trainer_id
LEFT JOIN student_assessment sa
    ON s.student_id = sa.student_id
LEFT JOIN certificate cert
    ON s.student_id = cert.student_id
   AND c.course_id = cert.course_id;


SELECT
    s.student_id,
    s.student_name,
    sa.marks_obtained
FROM student s
JOIN student_assessment sa
ON s.student_id = sa.student_id
WHERE sa.marks_obtained >
(
    SELECT AVG(marks_obtained)
    FROM student_assessment
);

SELECT
    course_id,
    course_name,
    course_fee
FROM course
WHERE course_fee >
(
    SELECT AVG(course_fee)
    FROM course
);

SELECT
    s.student_id,
    s.student_name,
    c.course_name,
    c.course_fee
FROM student s
JOIN enrollment e
ON s.student_id = e.student_id
JOIN course c
ON e.course_id = c.course_id
WHERE c.course_fee =
(
    SELECT MAX(course_fee)
    FROM course
);

SELECT DISTINCT
    s.student_id,
    s.student_name
FROM student s
JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.course_id IN
(
    SELECT course_id
    FROM course
    WHERE course_name IN ('SQL Fundamentals', 'Python Programming')
);


SELECT
    course_id,
    course_name,
    course_fee
FROM course
WHERE course_fee > ANY
(
    SELECT course_fee
    FROM course
    WHERE category_id =
    (
        SELECT category_id
        FROM course_category
        WHERE category_name = 'Data Analytics'
    )
);

SELECT
    course_id,
    course_name,
    course_fee
FROM course
WHERE course_fee > ALL
(
    SELECT course_fee
    FROM course
    WHERE category_id =
    (
        SELECT category_id
        FROM course_category
        WHERE category_name = 'Programming'
    )
);


SELECT DISTINCT
    s.student_id,
    s.student_name
FROM student s
JOIN enrollment e
    ON s.student_id = e.student_id
WHERE e.course_id IN
(
    SELECT c.course_id
    FROM course c
    WHERE c.category_id =
    (
        SELECT category_id
        FROM
        (
            SELECT
                c.category_id,
                COUNT(*) AS total_enrollments
            FROM enrollment e
            JOIN course c
                ON e.course_id = c.course_id
            GROUP BY c.category_id
            ORDER BY total_enrollments DESC
            LIMIT 1
        ) AS top_category
    )
);


SELECT DISTINCT
    t.trainer_id,
    t.trainer_name
FROM trainer t
JOIN course c
    ON t.trainer_id = c.trainer_id
WHERE c.course_id IN
(
    SELECT course_id
    FROM
    (
        SELECT
            c.course_id,
            SUM(c.course_fee) AS revenue
        FROM course c
        JOIN enrollment e
            ON c.course_id = e.course_id
        GROUP BY c.course_id
        HAVING SUM(c.course_fee) =
        (
            SELECT MAX(revenue)
            FROM
            (
                SELECT
                    SUM(c.course_fee) AS revenue
                FROM course c
                JOIN enrollment e
                    ON c.course_id = e.course_id
                GROUP BY c.course_id
            ) AS revenue_table
        )
    ) AS highest_revenue_course
);




SELECT
    s.student_id,
    s.student_name,
    c.course_name,
    sa.marks_obtained
FROM student s
JOIN student_assessment sa
    ON s.student_id = sa.student_id
JOIN assessment a
    ON sa.assessment_id = a.assessment_id
JOIN course c
    ON a.course_id = c.course_id
WHERE sa.marks_obtained >
(
    SELECT AVG(sa2.marks_obtained)
    FROM student_assessment sa2
    JOIN assessment a2
        ON sa2.assessment_id = a2.assessment_id
    WHERE a2.course_id = a.course_id
);

SELECT
    c.course_id,
    c.course_name
FROM course c
JOIN enrollment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name, c.category_id
HAVING COUNT(e.enrollment_id) >
(
    SELECT AVG(course_enrollments)
    FROM
    (
        SELECT
            COUNT(e2.enrollment_id) AS course_enrollments
        FROM course c2
        JOIN enrollment e2
            ON c2.course_id = e2.course_id
        WHERE c2.category_id = c.category_id
        GROUP BY c2.course_id
    ) AS category_avg
);

SELECT
    s.student_id,
    s.student_name
FROM student s
WHERE EXISTS
(
    SELECT 1
    FROM enrollment e
    WHERE e.student_id = s.student_id
);

SELECT
    c.course_id,
    c.course_name
FROM course c
WHERE EXISTS
(
    SELECT 1
    FROM assessment a
    WHERE a.course_id = c.course_id
);

SELECT
    t.trainer_id,
    t.trainer_name
FROM trainer t
WHERE EXISTS
(
    SELECT 1
    FROM course c
    WHERE c.trainer_id = t.trainer_id
);

SELECT
    s.student_id,
    s.student_name
FROM student s
WHERE NOT EXISTS
(
    SELECT 1
    FROM enrollment e
    WHERE e.student_id = s.student_id
);


SELECT
    c.course_id,
    c.course_name
FROM course c
WHERE NOT EXISTS
(
    SELECT 1
    FROM enrollment e
    WHERE e.course_id = c.course_id
);

SELECT
    t.trainer_id,
    t.trainer_name
FROM trainer t
WHERE NOT EXISTS
(
    SELECT 1
    FROM course c
    WHERE c.trainer_id = t.trainer_id
);

CREATE VIEW active_students AS
SELECT DISTINCT
    s.student_id,
    s.student_name
FROM student s
JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.enrollment_status = 'Active';


CREATE VIEW certified_students AS
SELECT DISTINCT
    s.student_id,
    s.student_name
FROM student s
JOIN certificate c
ON s.student_id = c.student_id;


SELECT * FROM active_students

UNION

SELECT * FROM certified_students;


SELECT * FROM active_students

UNION ALL

SELECT * FROM certified_students;

SELECT * FROM active_students

INTERSECT

SELECT * FROM certified_students;


SELECT a.*
FROM active_students a
INNER JOIN certified_students c
ON a.student_id = c.student_id;

SELECT * FROM active_students

EXCEPT

SELECT * FROM certified_students;

SELECT a.*
FROM active_students a
LEFT JOIN certified_students c
ON a.student_id = c.student_id
WHERE c.student_id IS NULL;

CREATE VIEW student_progress_view AS
SELECT
    s.student_name,
    c.course_name,
    sa.marks_obtained,
    e.enrollment_status
FROM student s
JOIN enrollment e
    ON s.student_id = e.student_id
JOIN course c
    ON e.course_id = c.course_id
LEFT JOIN assessment a
    ON c.course_id = a.course_id
LEFT JOIN student_assessment sa
    ON s.student_id = sa.student_id
   AND a.assessment_id = sa.assessment_id;
   
   SELECT * FROM student_progress_view;
   
   CREATE VIEW course_revenue_view AS
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count,
    COUNT(e.student_id) * c.course_fee AS revenue_generated
FROM course c
LEFT JOIN enrollment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name, c.course_fee;
   
 SELECT * FROM course_revenue_view;  
 
 CREATE VIEW trainer_performance_view AS
SELECT
    t.trainer_name,
    COUNT(DISTINCT c.course_id) AS courses_handled,
    COUNT(DISTINCT e.student_id) AS students_trained
FROM trainer t
LEFT JOIN course c
    ON t.trainer_id = c.trainer_id
LEFT JOIN enrollment e
    ON c.course_id = e.course_id
GROUP BY t.trainer_id, t.trainer_name;
SELECT * FROM trainer_performance_view;
   
  CREATE INDEX idx_student_name
ON student(student_name); 
   
  SELECT *
FROM student
WHERE student_name = 'Rahul Sharma'; 

CREATE INDEX idx_student_email
ON student(email);

SELECT *
FROM student
WHERE email = 'rahul@gmail.com';
   
   
   CREATE INDEX idx_course_name
ON course(course_name);
   
SELECT *
FROM course
WHERE course_name = 'Python Programming';   
   
CREATE INDEX idx_trainer_name
ON trainer(trainer_name);   
   
 SELECT *
FROM trainer
WHERE trainer_name = 'Arun Kumar';  
   
   CREATE INDEX idx_enrollment_date
ON enrollment(enrollment_date);
   
  SELECT *
FROM enrollment
WHERE enrollment_date = '2025-06-15'; 

SHOW INDEX
FROM student;
  SHOW INDEX FROM course;
SHOW INDEX FROM trainer;
SHOW INDEX FROM enrollment; 

CREATE SYNONYM stu FOR student;

CREATE SYNONYM crs FOR course;

CREATE SYNONYM enr FOR enrollment;
   
   CREATE USER 'student1'@'localhost'
IDENTIFIED BY 'Password@123';
   
   ALTER USER 'student1'@'localhost'
IDENTIFIED BY 'NewPassword@123';

DROP USER 'student1'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON online_learning_db.*
TO 'student1'@'localhost';

REVOKE UPDATE
ON online_learning_db.*
FROM 'student1'@'localhost';
GRANT CONNECT TO student1;

   SELECT CURRENT_DATE AS today_date;
   
  SELECT CURRENT_TIMESTAMP AS current_time; 
   
   SELECT @@global.time_zone AS global_timezone,
       @@session.time_zone AS session_timezone;
   
SELECT @@session.time_zone;   

SELECT
    student_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM student;

SELECT
    student_id,
    enrollment_date,
    DATEDIFF(CURDATE(), enrollment_date) AS days_since_enrollment
FROM enrollment;

SELECT student_id, student_name
FROM student
WHERE student_name REGEXP '^A';

SELECT student_id, student_name, email
FROM student
WHERE email REGEXP '@gmail\\.com$';

SELECT course_id, course_name
FROM course
WHERE course_name REGEXP 'Fundamentals$';

SELECT
    course_id,
    course_name,
    REGEXP_REPLACE(duration, '[^0-9]', '') AS duration_number
FROM course;

SELECT
    feedback_id,
    comments,
    REGEXP_REPLACE(comments, '[^a-zA-Z0-9 ]', '') AS clean_comments
FROM feedback;

SELECT
    s.student_name,
    AVG(sa.marks_obtained) AS avg_marks
FROM student s
JOIN student_assessment sa
ON s.student_id = sa.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_marks DESC
LIMIT 10;

SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM course c
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrollments DESC
LIMIT 10;

SELECT
    t.trainer_name,
    COUNT(e.student_id) AS total_students
FROM trainer t
JOIN course c
ON t.trainer_id = c.trainer_id
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY t.trainer_id, t.trainer_name
ORDER BY total_students DESC;

SELECT
    cc.category_name,
    COUNT(e.enrollment_id) * AVG(c.course_fee) AS revenue
FROM course_category cc
JOIN course c
ON cc.category_id = c.category_id
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY cc.category_id, cc.category_name;

SELECT
    c.course_name,
    SUM(CASE WHEN e.enrollment_status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    COUNT(e.enrollment_id) AS total
FROM course c
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

 SELECT
    c.course_name,
    COUNT(ct.certificate_id) AS certificates_issued
FROM course c
LEFT JOIN certificate ct
ON c.course_id = ct.course_id
GROUP BY c.course_id, c.course_name;  
   
  SELECT
    c.course_name,
    AVG(f.rating) AS avg_rating
FROM course c
JOIN feedback f
ON c.course_id = f.course_id
GROUP BY c.course_id, c.course_name
ORDER BY avg_rating DESC; 
   
   
   
   
   SELECT
    MONTH(enrollment_date) AS month,
    COUNT(*) AS total_enrollments
FROM enrollment
GROUP BY MONTH(enrollment_date)
ORDER BY month;

SELECT
    s.student_name,
    COUNT(ct.certificate_id) AS total_certificates
FROM student s
JOIN certificate ct
ON s.student_id = ct.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(ct.certificate_id) > 1;

SELECT
    t.trainer_name,
    COUNT(DISTINCT c.course_id) AS courses_handled,
    COUNT(e.student_id) AS students_trained,
    AVG(f.rating) AS avg_feedback
FROM trainer t
JOIN course c ON t.trainer_id = c.trainer_id
JOIN enrollment e ON c.course_id = e.course_id
LEFT JOIN feedback f ON c.course_id = f.course_id
GROUP BY t.trainer_id, t.trainer_name
ORDER BY avg_feedback DESC;



