-- Stored Procedure to Update Student's Grade
-- Version: 1.2
-- Date Updated: 12 December 2023
-- Author: Yumi 
-- Peer Review: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_AssignStudentGrade`$$

-- Create the new procedure
CREATE PROCEDURE `sp_AssignStudentGrade`(
    IN p_TeacherID INT, 
    IN p_StudentID INT,
    IN p_CourseID INT,
    IN p_Grade TINYINT,  
    OUT p_AffectedRows INT,
    OUT p_ResultMessage VARCHAR(255)

)
sp:BEGIN
    DECLARE teacherIsTeacher INT;
    DECLARE studentEnrolled INT;

    -- Initialize p_ResultMessage and p_AffectedRows
    SET p_ResultMessage = '';
    SET p_AffectedRows = 0;

    -- Check if the user is a teacher
    SELECT COUNT(*) INTO teacherIsTeacher
    FROM users
    WHERE UserID = p_TeacherID AND RoleID = 2; -- Teacher Role ID is 2

    -- If the user is not a teacher, set result message and exit
    IF teacherIsTeacher = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Only teachers can update student grades.';
        LEAVE sp;
    END IF;

    -- Check if the student is enrolled in the specified course
    SELECT COUNT(*) INTO studentEnrolled
    FROM enrolments
    WHERE UserID = p_StudentID AND CourseID = p_CourseID;

    -- If the student is not enrolled in the course, set result message and exit
    IF studentEnrolled = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Student is not enrolled in the specified course.';
        LEAVE sp;
    END IF;

    -- Validate grade (must be between 0 and 100)
    IF p_Grade < 0 OR p_Grade > 100 THEN
        SET p_ResultMessage = 'Transaction Error: Invalid grade. Must be between 0 and 100.';
        LEAVE sp;
    END IF;

    -- Update the student's grade for the specified course
    UPDATE enrolments
    SET Mark = p_Grade
    WHERE UserID = p_StudentID AND CourseID = p_CourseID;

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();

    -- Set success result message
    SET p_ResultMessage = CONCAT('Success: Student`s grade updated to ', p_Grade, '.');

END$$

DELIMITER ;
