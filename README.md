# A COMPREHENSIVE APPROACH TO API DEVELOPMENT: MYSQL STORED PROCEDURES, NODEJS, AND ROLE MANAGEMENT 
This collaborative project focuses on constructing SQL queries, developing a business logic layer with NodeJS and Stored Procedures, and implementing best practices in database connectivity and role-based access control. Set within a fictitious college scenario, it aims to meet the diverse needs of administrators, teachers, students, and courses.

# Table of Contents
- [Set Up](#set-up)
- [Run the Project](#run-the-project)
- [Function](#function)
- [Unit Test Using Postman](#unit-test-using-postman)
- [Directory Structure](#directory-structure)


## Set up

1. Clone the repository
- Open a command prompt or terminal and run the following command\
git clone https://github.com/THarmse/End_of_Module_Assignment_MySQL_and_API.git

2. Install Node.JS and Project Dependencies
- Ensure Node.JS is installed https://nodejs.org/en/download
- To set up the project, run the following command to install the required npm packages\
npm install

3. Update Configuration:
- Open db.config.js located under config folder
- Update host, user, password, database if it is not the following.
    host: "localhost",
    user: "API",
    password: "MyPassword@123",
    database: "mydb"

4. Download mySQL:
- Download and install MySQL from the official website\
[MySQL Downloads](https://dev.mysql.com/downloads/)
- After installation, open a command prompt or terminal and run the following command to verify that MySQL is installed and running
mysql --version

## Database Import
1. The Database dumps are located in the "database scripts/Database Import/Dumps" folder
2. Import these dumps for "mydb" as the database name
3. The Stored Procedures are part of the database dumps, but alternatively, the below can be used

## Database Stored Procedures (Optional, if Database Import was not used)
1. Open files in the "database scripts/Create Scripts" folder
   sp_AssignCoursesToTeacher.sql
   sp_assignStudentGrade.sql
   sp_ChangeCourseAvailability.sql
   sp_EnrollStudentInCourse.sql
   sp_ListAvailableCourses.sql
2. Execute these scripts in MySQL Workbench (They will automatically use 'mydb' and drop/recreate the procedures)


## Create Service Account
1. Open api_to_mysql_ServiceAccount.sql from the "database scripts/Create Scripts" folder
2. Execute this script in MySQL Workbench to create the "API" Service Account
3. Ensure that db.config.js is in line with this script Username/Password, should you opt to change the password [Set Up](#set-up)
  
## Run the API
1. Start the API:
Open a command prompt or terminal from the location where the project is stored on your laptop and run the following command to start the Node.js API
node app.js
2. Alternatively, run from Visual Studio by, typing node app.js in the Developer Powershell
3. Note: No front end will be shown as this is an API and Views have been removed/excluded. 

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
    *   Teachers can fail or pass a student.
* Access Control:
    * Access control is implemented to ensure only authorized users can perform specific actions. For example, only teachers can pass/fail a student.

## Unit test Using Postman
1. Download and install Postman from the official website\
  [Postman Downloads](https://www.postman.com/downloads/)
2. After installation, Run the API (if not already running)
3. Note: it should indicate "Successfully connected to the database."
4. Access the Postman collection for this project using the (Guest access)\
   https://speeding-satellite-93841.postman.co/workspace/New-Team-Workspace~e3f0516a-f347-4151-be87-1e122139d478/collection/8837553-b229f0a7-8388-46b6-bb0a-6f4a86f95679?action=share&creator=8837553
   Alternatively, the collection can be imported as stored in the repository, under testing/Liverpool - Database and API.postman_collection.json
6. In Postman, Select Collection "Liverpool - Database and API Workspace".
7. Select a requests to test
8. Click "Send" button to execute the request with the configured environment variables.
9. Observe the response in the "Body" section to ensure it matches the expected output.

## Directory Structure
    .
    ├── config
    │   ├── db.config.js
    │   └── db.connection.js
    ├── controllers
    │   ├── course.controller.js
    │   └── enrollment.controller.js
    ├── database scripts
    │   ├──Create Scripts
    │   │   ├── api_to_mysql_ServiceAccount.sql
    │   │   ├── sp_AssignCoursesToTeacher.sql
    │   │   ├── sp_ChangeCourseAvailability.sql
    │   │   ├── sp_EnrollStudentInCourse.sql
    │   │   ├── sp_ListAvailableCourses.sql
    │   │   └── sp_assignStudentGrade.sql
    ├── public
    │   ├──stylesheets
    │   │   └── main.css
    ├── routes
    │   ├── course.routes.js
    │   └── enrollment.routes.js
    ├── services
    │   ├── course.service.js
    │   └── enrollment.service.js
    ├── testing
    │   ├── Liverpool - Database and API.postman_collection.json
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
