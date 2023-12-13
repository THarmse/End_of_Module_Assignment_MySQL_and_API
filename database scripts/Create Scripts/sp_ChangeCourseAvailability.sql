-- Stored Procedure to Change Course Availability
-- Version: 1.0
-- Date Updated: 13 December 2023
-- Author: Yumi
-- Peer Review: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_ChangeCourseAvailability`$$

-- Create the new procedure
CREATE PROCEDURE `sp_ChangeCourseAvailability`(
    IN p_AdminUserID INT, 
    IN p_CourseID INT,
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
)
sp:BEGIN
    DECLARE userIsAdmin INT;
    DECLARE courseExists INT;
    DECLARE courseIsAvailable INT;

    -- Initialize p_ResultMessage and p_AffectedRows
    SET p_ResultMessage = '';
    SET p_AffectedRows = 0;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO userIsAdmin
    FROM users
    WHERE UserID = p_AdminUserID AND RoleID = 1; -- Admin Role ID is 1

    -- If the user is not an admin, set result message and exit
    IF userIsAdmin = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Only admins can change course availability.';
        LEAVE sp;
    END IF;

    -- Check if the course exists
    SELECT COUNT(*) INTO courseExists
    FROM courses
    WHERE CourseID = p_CourseID;

    -- If the course does not exist, set result message and exit
    IF courseExists = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Course does not exist.';
        LEAVE sp;
    END IF;

    -- Check the current availability of the course
    SELECT isAvailable INTO courseIsAvailable
    FROM courses
    WHERE CourseID = p_CourseID;

    -- Toggle the availability of the course
    UPDATE courses
    SET isAvailable = NOT courseIsAvailable
    WHERE CourseID = p_CourseID;

    -- Set success result message
    IF NOT courseIsAvailable THEN
        SET p_ResultMessage = 'Success: Course availability enabled.';
    ELSE
        SET p_ResultMessage = 'Success: Course availability disabled.';
    END IF;

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();
END$$

DELIMITER ;
