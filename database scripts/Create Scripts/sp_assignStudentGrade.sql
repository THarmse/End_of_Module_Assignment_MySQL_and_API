-- Stored Procedure to Update Student's Pass/Fail Grade Status
-- Version: 1.0
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
    IN p_PassStatus BOOLEAN,
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
)
sp:BEGIN
    DECLARE teacherIsTeacher INT;
    DECLARE studentExists INT;

    -- Initialize p_ResultMessage and p_AffectedRows
    SET p_ResultMessage = '';
    SET p_AffectedRows = 0;

    -- Check if the user is a teacher
    SELECT COUNT(*) INTO teacherIsTeacher
    FROM users
    WHERE UserID = p_TeacherID AND RoleID = 2; --  Teacher Role ID is 2

    -- If the user is not a teacher, set result message and exit
    IF teacherIsTeacher = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Only teachers can update student grades.';
        LEAVE sp;
    END IF;

    -- Check if the student exists
    SELECT COUNT(*) INTO studentExists
    FROM users
    WHERE UserID = p_StudentID AND RoleID = 3; -- Student Role ID is 3

    -- If the student does not exist, set result message and exit
    IF studentExists = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Student does not exist.';
        LEAVE sp;
    END IF;

    -- Update the student status
    UPDATE enrolments
    SET Mark = p_PassStatus
    WHERE UserID = p_StudentID;

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();

    -- Set success result message
    IF p_PassStatus THEN
        SET p_ResultMessage = 'Success: Student status updated to passed.';
    ELSE
        SET p_ResultMessage = 'Success: Student status updated to failed.';
    END IF;

END$$

DELIMITER ;
