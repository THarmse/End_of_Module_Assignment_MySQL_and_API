# A COMPREHENSIVE APPROACH TO API DEVELOPMENT: MYSQL STORED PROCEDURES, NODEJS, AND ROLE MANAGEMENT 
This collaborative project focuses on constructing SQL queries, developing a business logic layer with NodeJS and Stored Procedures, and implementing best practices in database connectivity and role-based access control. Set within a fictitious college scenario, it aims to meet the diverse needs of administrators, teachers, students, and courses.

----
Teddy Notes: To Add:   Detail Around API Service Role
----

# Table of Contents
- [Preparation](#preparation)
- [Run the Project](#run-the-project)
- [Function](#function)
- [Directory Structure](#directory-structure)
- [Unit Test Using Postman](#unit-test-using-postman)


## Preparation

1. Clone the repository
- Open a command prompt or terminal and run the following command\
git clone https://github.com/THarmse/End_of_Module_Assignment_MySQL_and_API.git

2. Install Dependencies
- To set up the project, run the following command to install the required npm packages\
npm install

3. Download mySQL:
- Download and install MySQL from the official website\
[MySQL Downloads](https://dev.mysql.com/downloads/)
- After installation, open a command prompt or terminal and run the following command to verify that MySQL is installed and running
mysql --version

4. Download and install Postman:
- Download and install Postman from the official website\
  [Postman Downloads](https://www.postman.com/downloads/)
- After installation, start the MySQL server 
- Open a command prompt or terminal and run the following command to verify that MySQL is installed and running\
mysql --version
- Access the Postman collection for this project using the (Guest access):https://speeding-satellite-93841.postman.co/workspace/New-Team-Workspace~e3f0516a-f347-4151-be87-1e122139d478/collection/8837553-b229f0a7-8388-46b6-bb0a-6f4a86f95679?action=share&creator=8837553

5. Update Configuration:
- Open the config file in your project.
- Update Localhost by setting the appropriate localhost configuration.
- Update Service Account by provide the correct username and password for the service account.
- Update Database Name by ensuring the database name matches your MySQL database.

## Run the Project
1. Start the Server:
Open a command prompt or terminal and run the following command to start the Node.js server\
npm start
   
----
NOTE :   @YUMI :  Pleaes add npm install and all other setup
NOTE:  Add detail to update config file to localhost,Service Account username and password and ensure db name is as per mySQL
NOTE:  Execute the stored procedures as per the CodeRepo all 5 of them
NOTE: Link to Postman collection (Guest access) https://speeding-satellite-93841.postman.co/workspace/New-Team-Workspace~e3f0516a-f347-4151-be87-1e122139d478/collection/8837553-b229f0a7-8388-46b6-bb0a-6f4a86f95679?action=share&creator=8837553
----

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
    .
    ├── config
    │   ├── db.config.js
    │   └── db.connection.js
    ├── controllers
    │   ├── course.controller.js
    │   └── enrollment.controller.js
    ├── database scripts\Create Scripts
    │   ├── sp_AssignCoursesToTeacher.sql
    │   ├── sp_ChangeCourseAvailability.sql
    │   ├── sp_EnrollStudentInCourse.sql
    │   ├── sp_ListAvailableCourses.sql
    │   └── sp_assignStudentGrade.sql
    ├── public\stylesheets
    │   └── main.css
    ├── routes
    │   ├── course.routes.js
    │   └── enrollment.routes.js
    ├── services
    │   ├── course.service.js
    │   └── enrollment.service.js
    ├── .gitattributes
    ├── .gitignore
    ├── LiverpoolApp.njsproj
    ├── LiverpoolApp.sln
    ├── README.md
    ├── Web.Debug.config
    ├── Web.config
    ├── app.js
    ├── package-lock.json
    └── package.json



## Unit test Using Postman
1. Select Collection "Liverpool - Database and API Workspace".
2. Selct certain requests to test
3. Click "Send" button to execute the request with the configured environment variables.
4. Observe the response in the "Body" section to ensure it matches the expected output.



