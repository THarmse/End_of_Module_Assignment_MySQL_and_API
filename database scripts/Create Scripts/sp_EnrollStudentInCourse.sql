-- Stored Procedure to Enroll a Student in a Course
-- Version: 1.1
-- Date Updated: 09 December 2023
-- Author: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_EnrollStudentInCourse`$$

-- Create the new procedure
CREATE PROCEDURE `sp_EnrollStudentInCourse`(
    IN p_StudentUserID INT, 
    IN p_CourseID INT,
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
)
sp: BEGIN
    DECLARE studentRole TINYINT;
    DECLARE courseExists TINYINT;
    DECLARE alreadyEnrolled TINYINT;

    -- Initialize p_AffectedRows to 0
    SET p_AffectedRows = 0;

    -- Check if the user is a student
    SELECT COUNT(*) INTO studentRole
    FROM users
    WHERE UserID = p_StudentUserID AND RoleID = 3; -- Student Role ID is 3

    -- If the user is not a student, set result message
    IF studentRole = 0 THEN
        SET p_ResultMessage = 'Only students can enroll in courses.';
        LEAVE sp;
    END IF;

    -- Check if the course exists
    SELECT COUNT(*) INTO courseExists
    FROM courses
    WHERE CourseID = p_CourseID;

    -- If the course does not exist, set result message
    IF courseExists = 0 THEN
        SET p_ResultMessage = 'The specified course does not exist.';
        LEAVE sp;
    END IF;

    -- Check if the student is already enrolled in the course
    SELECT COUNT(*) INTO alreadyEnrolled
    FROM enrolments
    WHERE UserID = p_StudentUserID AND CourseID = p_CourseID;

    -- If the student is already enrolled, set result message
    IF alreadyEnrolled > 0 THEN
        SET p_ResultMessage = 'Student is already enrolled in this course.';
        LEAVE sp;
    END IF;

    -- Enroll the student in the course
    INSERT INTO enrolments (CourseID, UserID)
    VALUES (p_CourseID, p_StudentUserID);

    -- Set success result message
    SET p_ResultMessage = 'Student successfully enrolled in the course.';

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();

END$$

DELIMITER ;
