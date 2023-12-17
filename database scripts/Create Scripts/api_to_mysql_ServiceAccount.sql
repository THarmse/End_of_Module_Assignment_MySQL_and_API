-- Script to create a user account to be used by the API service with specific permissions
-- Version: 1.0
-- Date Updated: 17 December 2023
-- Author: Theodor Harmse
-- Group: Group C

USE `mydb`;

-- Create the 'API' user with a specified password  (Ensure to update in db.config.js afterwads)
CREATE USER 'API'@'localhost' IDENTIFIED BY 'MyPassword@123';

-- Grant EXECUTE privilege for each stored procedure in the 'mydb' database
GRANT EXECUTE ON PROCEDURE mydb.sp_EnrollStudentInCourse TO 'API'@'localhost';
GRANT EXECUTE ON PROCEDURE mydb.sp_ListAvailableCourses TO 'API'@'localhost';
GRANT EXECUTE ON PROCEDURE mydb.sp_AssignStudentGrade TO 'API'@'localhost';
GRANT EXECUTE ON PROCEDURE mydb.sp_AssignCoursesToTeacher TO 'API'@'localhost';
GRANT EXECUTE ON PROCEDURE mydb.sp_ChangeCourseAvailability TO 'API'@'localhost';

-- Flush privileges to ensure changes take effect
FLUSH PRIVILEGES;
