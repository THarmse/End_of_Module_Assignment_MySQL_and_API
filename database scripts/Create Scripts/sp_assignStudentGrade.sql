-- Stored Procedure to Update Student's Pass/Fail Grade Status
-- Version: 1.0
-- Date Updated: 12 December 2023
-- Author: Yumi 
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_AssignStudentGrade`$$

-- Create the new procedure
CREATE PROCEDURE `sp_AssignStudentGrade`(
    IN p_TeacherID INT, 
    IN p_StudentID INT,
    IN p_PassStatus BOOLEAN,
    OUT p_AffectedRows INT
)
sp:BEGIN
    DECLARE teacherIsTeacher INT;
    DECLARE studentExists INT;

    -- Initialize p_AffectedRows
    SET p_AffectedRows = 0;

    -- Check if the user is a teacher
    SELECT COUNT(*) INTO teacherIsTeacher
    FROM users
    WHERE UserID = p_TeacherID AND RoleID = 2; --  Teacher Role ID is 2

    -- If the user is not a teacher, raise an error
    IF teacherIsTeacher = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Error: Only teachers can update student grades.';
        LEAVE sp;
    END IF;

    -- Check if the student exists
    SELECT COUNT(*) INTO studentExists
    FROM users
    WHERE UserID = p_StudentID AND RoleID = 3; -- Student Role ID is 3

    -- If the student does not exist, raise an error
    IF studentExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Error: Student does not exist.';
        LEAVE sp;
    END IF;

    -- Update the student status
    UPDATE enrolments
    SET Mark = p_PassStatus
    WHERE UserID = p_StudentID;

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();

    -- In case no rows are affected, raise an error
    IF p_AffectedRows = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Error: No update performed.';
    END IF;
END$$

DELIMITER ;
