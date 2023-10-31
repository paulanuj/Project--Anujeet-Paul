-- Database creation
CREATE DATABASE student_database;

-- Table creation
CREATE TABLE student_table (
    Student_id SERIAL PRIMARY KEY,
    Stu_name TEXT,
    Department TEXT,
    email_id TEXT,
    Phone_no NUMERIC,
    Address TEXT,
    Date_of_birth DATE,
    Gender TEXT,
    Major TEXT,
    GPA NUMERIC,
    Grade TEXT
);

-- Insert 10 sample records
INSERT INTO student_table (Stu_name, Department, email_id, Phone_no, Address, Date_of_birth, Gender, Major, GPA, Grade)
VALUES
    ('John Doe', 'Computer Science', 'john.doe@example.com', 1234567890, '123 Main St', '1998-05-15', 'Male', 'Computer Science', 3.8, 'B'),
    ('Jane Smith', 'Biology', 'jane.smith@example.com', 9876543210, '456 Elm St', '1999-03-20', 'Female', 'Biology', 4.2, 'A'),
    ('Alice Johnson', 'Mathematics', 'alice.j@example.com', 5555555555, '789 Oak Ave', '1997-11-10', 'Female', 'Mathematics', 3.5, 'B'),
    ('Bob Anderson', 'Physics', 'bob.anderson@example.com', 9998887777, '567 Willow Ln', '1996-08-25', 'Male', 'Physics', 4.0, 'B'),
    ('Eva Martinez', 'Chemistry', 'eva.martinez@example.com', 1239876543, '456 Birch Rd', '1999-01-05', 'Female', 'Chemistry', 3.9, 'A'),
    ('Michael Wilson', 'Engineering', 'michael.w@example.com', 5554443333, '321 Cedar Dr', '1998-04-30', 'Male', 'Engineering', 3.7, 'B'),
    ('Sarah Adams', 'Psychology', 'sarah.adams@example.com', 8887776666, '654 Pine St', '1997-02-18', 'Female', 'Psychology', 4.5, 'A'),
    ('David Lee', 'History', 'david.lee@example.com', 7778889999, '987 Red Rd', '1996-07-12', 'Male', 'History', 3.2, 'C'),
    ('Emily Brown', 'English', 'emily.b@example.com', 1112223333, '101 Elm St', '1999-09-01', 'Female', 'English', 4.1, 'A'),
    ('James Davis', 'Economics', 'james.davis@example.com', 5556667777, '246 Oak Ln', '1997-12-28', 'Male', 'Economics', 3.6, 'B');
	
-- Retrieve all students sorted by grade in descending order
SELECT * FROM student_table ORDER BY Grade DESC;

-- Retrieve information for all male students
SELECT * FROM student_table WHERE Gender = 'Male';

-- Retrieve information for students with GPA less than 5.0
SELECT * FROM student_table WHERE GPA < 5.0;

-- Update email and grade for a student with a specific ID (replace ID and new values)
UPDATE student_table
SET email_id = 'updated_email@example.com', Grade = 'A'
WHERE Student_id = 3; -- Replace '3' with the specific ID you want to update

Select * from student_table where Student_id = 3;

-- Retrieve names and ages of students with grade "B"
SELECT Stu_name, EXTRACT(YEAR FROM AGE(current_date, Date_of_birth)) AS Age
FROM student_table
WHERE Grade = 'B';

-- Group by Department and Gender, calculate average GPA for each combination
SELECT Department, Gender, AVG(GPA) AS Average_GPA
FROM student_table
GROUP BY Department, Gender;

-- Rename "student_table" to "student_info"
ALTER TABLE student_table RENAME TO student_info;

-- Retrieve the name of the student with the highest GPA
SELECT Stu_name
FROM student_info
WHERE GPA = (SELECT MAX(GPA) FROM student_info);


