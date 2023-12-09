-- Stored Procedure to Assign a Course to a Teacher
-- Version: 1.4
-- Date: 07 December 2023
-- Author: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_AssignCourseToTeacher`$$

-- Create the new procedure
CREATE PROCEDURE `sp_AssignCourseToTeacher`(
    IN p_AdminUserID INT, 
    IN p_CourseID INT, 
    IN p_TeacherUserID INT,
    OUT p_RowsAffected INT
)
BEGIN
    DECLARE userIsAdmin TINYINT;
    DECLARE teacherExists TINYINT;
    DECLARE courseIsAvailable TINYINT;


    -- Check if the user is an Admin
    SELECT COUNT(*) INTO userIsAdmin
    FROM users
    WHERE UserID = p_AdminUserID AND RoleID = 1; -- Admin Role ID is 1

    -- If the user is not an admin, show an error
    IF userIsAdmin = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Only Admins can assign courses.';
    END IF;

    -- Check if the teacher exists
    SELECT COUNT(*) INTO teacherExists
    FROM users
    WHERE UserID = p_TeacherUserID AND RoleID = 2; -- Teacher Role ID is 2

    -- If the teacher does not exist, show error message
    IF teacherExists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Teacher with provided UserID does not exist or is not valid.';
    END IF;

    -- Check if the course is available
    SELECT isAvailable INTO courseIsAvailable
    FROM courses
    WHERE CourseID = p_CourseID;

    -- if the course is not available, show error message
    IF courseIsAvailable = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Course is not available.';
    END IF;

    -- If all checks pass, assign the course to the teacher
    UPDATE courses
    SET TeacherID = p_TeacherUserID
    WHERE CourseID = p_CourseID;

    -- Capture the number of affected rows as OUT paratmer to return to NodeJS API
    SET p_RowsAffected = ROW_COUNT();
END$$

DELIMITER ;
