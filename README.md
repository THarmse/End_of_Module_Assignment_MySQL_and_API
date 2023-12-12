# LiverpoolApp


Teddy Notes: To Add:   Detail Around API Service Role

# LiverpoolApp
University of Liverpool - End of Module Assignment

# Table of Contents
- [Download the Code](#download-the-code)
- [Steps to Import Database Structure and Dummy Data](#steps-to-import-database-structure-and-dummy-data)
- [Function](#function)
- [Directory Structure](#directory-structure)
- [Unit test](#unit-test)


## Download the Code
1. Clone the repository using the following command  
git clone https://github.com/THarmse/End_of_Module_Assignment_MySQL_and_API.git


## Steps to Import Database Structure and Dummy Data
1. Download the database_dump.zip file and unzip it in a folder.
2. Open MySQL Workbench and navigate to “Data Import” under the “Server” menu.
3. In “Data Import,” select “Import from dump project folder” and navigate to the folder where you unzipped the files.
4. Click on the “Load folder content” button and ensure that the “mydb” database is selected.
5. Click the “Start import” button, and you should see the database in your “Schemas” list. If you don’t see the database, try refreshing the database connection.



## Function
* Enable/Disable Course Availability (Admins):
* Admins should be able to enable or disable the availability of a course.
* Assign Courses to Teachers (Admins):
* Admins should be able to assign one or more courses to a teacher.
* Browse and List Available Courses (Students):
* Students can browse and list all available courses, including the course title and the teacher's name.
* Enroll in a Course (Students):
* Students can enroll in a course. Enrollments should prevent students from enrolling in a course more than once at each time.
* Fail or Pass a Student (Teachers):
* Teachers can fail or pass a student.
* Access Control:
* Access control is implemented to ensure only authorized users can perform specific actions. For example, only teachers can pass/fail a student.

## Directory Structure


## Unit test
