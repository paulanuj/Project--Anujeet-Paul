--Create the StudentInfo with columns STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS.

CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(50),
    ADDRESS VARCHAR(100)
);

--Create the CourseInfo with columns COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR NAME.

CREATE TABLE CourseInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

--Create EnrollmentInfo with columns ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS (Enrolled/Not Enrolled). The FOREIGN KEY constraint in the EnrollmentInfo table references the STU_ID column in the StudentInfo table and the COURSE_ID column in the CoursesInfo table.

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(15),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CourseInfo(COURSE_ID)
);

-- Sample data for StudentInfo

INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    (1, 'John Doe', '1990-05-15', '555-555-5555', 'john.doe@example.com', '123 Main St'),
    (2, 'Jane Smith', '1995-08-20', '555-555-5556', 'jane.smith@example.com', '456 Elm St'),
    (3, 'Alice Johnson', '1998-04-10', '555-555-5557', 'alice.johnson@example.com', '789 Oak St'),
    (4, 'Bob Anderson', '2000-12-03', '555-555-5558', 'bob.anderson@example.com', '101 Pine St');

-- Sample data for CourseInfo

INSERT INTO CourseInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    (101, 'Math 101', 'Professor Johnson'),
    (102, 'History 101', 'Professor Smith'),
    (103, 'Science 101', 'Professor Brown'),
    (104, 'English 101', 'Professor Wilson');

-- Sample data for EnrollmentInfo

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1, 1, 101, 'Enrolled'),
    (2, 1, 102, 'Enrolled'),
    (3, 2, 101, 'Enrolled'),
    (4, 1, 103, 'Enrolled'),
    (5, 2, 103, 'Not Enrolled'),
    (6, 3, 101, 'Enrolled'),
    (7, 3, 104, 'Enrolled'),
    (8, 4, 104, 'Enrolled');
	

--query to retrieve the student details, such as student name, contact information and enrollment status

SELECT s.STU_NAME, s.PHONE_NO, e.ENROLL_STATUS
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
Group by s.STU_NAME, s.PHONE_NO, e.ENROLL_STATUS;

--query to retrieve a list of courses in which a specific student is enrolled.

SELECT c.COURSE_NAME
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.STU_ID = 1
AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;


--query to retrieve course information, including course name, instructor information

SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CourseInfo;

--query to retrieve course information for a specific course 

SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CourseInfo
WHERE COURSE_ID = 101;

--query to retrieve course information for multiple courses

SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CourseInfo
WHERE COURSE_ID IN (101, 102);

--query to retrieve the number of students enrolled in each course

SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CourseInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

--query to retrieve the list of students enrolled in a specific course

SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.COURSE_ID = 101
AND e.ENROLL_STATUS = 'Enrolled';

--query to retrieve the count of enrolled students for each instructor

SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CourseInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

--query to retrieve the list of students who are enrolled in multiple courses.

SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_NAME
HAVING COUNT(e.STU_ID) > 1;

--query to retrieve the courses that have the highest number of enrolled students

SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CourseInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY Enrolled_Students DESC;
