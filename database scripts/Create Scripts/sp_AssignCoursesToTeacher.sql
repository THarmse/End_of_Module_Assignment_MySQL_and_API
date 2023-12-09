-- Stored Procedure to Assign Multiple Courses to a Teacher with Error Handling/Checks and Transaction Control to rollback
-- Version: 1.6
-- Date Updated: 09 December 2023
-- Author: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_AssignCoursesToTeacher`$$

-- Create the new procedure
CREATE PROCEDURE `sp_AssignCoursesToTeacher`(
    IN p_AdminUserID INT, 
    IN p_CourseIDs TEXT, -- Comma-separated list of Course IDs
    IN p_TeacherUserID INT,
    OUT p_RowsAffected INT
)
sp: BEGIN
    DECLARE userIsAdmin TINYINT;
    DECLARE teacherExists TINYINT;
    DECLARE currentCourseID INT;
    DECLARE courseCursor INT DEFAULT 1;
    DECLARE courseExists TINYINT;
    DECLARE done INT DEFAULT 0;
    DECLARE courseIDsCount INT DEFAULT 1;

    -- Initialize p_RowsAffected to 0
    SET p_RowsAffected = 0;

    -- Start a transaction
    START TRANSACTION;

    -- Check if the user is an Admin
    SELECT COUNT(*) INTO userIsAdmin
    FROM users
    WHERE UserID = p_AdminUserID AND RoleID = 1;

    -- If the user is not an admin, roll back and show an error
    IF userIsAdmin = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaction Rolled back: Only Admins can assign courses.';
        LEAVE sp;
    END IF;

    -- Check if the teacher exists
    SELECT COUNT(*) INTO teacherExists
    FROM users
    WHERE UserID = p_TeacherUserID AND RoleID = 2;

    -- If the teacher does not exist, roll back and show error message
    IF teacherExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaction Rolled back: Teacher with provided UserID does not exist or is not valid.';
        LEAVE sp;
    END IF;

    -- Calculate the number of course IDs in the list
    SET courseIDsCount = (CHAR_LENGTH(p_CourseIDs) - CHAR_LENGTH(REPLACE(p_CourseIDs, ',', '')) + 1);

    -- Loop through the course IDs supplied and assign them to the teacher
    WHILE courseCursor <= courseIDsCount AND done = 0 DO
        -- Extract the next CourseID from the list
        SET currentCourseID = SUBSTRING_INDEX(SUBSTRING_INDEX(p_CourseIDs, ',', courseCursor), ',', -1);

        -- Check for invalid CourseID
        IF currentCourseID REGEXP '^[0-9]+$' = 0 THEN
            SET done = 1;
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Transaction Rolled back: Invalid CourseID format. Only numbers are allowed, separated by a comma';
            LEAVE sp;
        END IF;

        -- Check if the course exists
        SELECT COUNT(*) INTO courseExists
        FROM courses
        WHERE CourseID = currentCourseID;

        -- If the course does not exist, roll back and show error message
        IF courseExists = 0 THEN
            SET done = 1;
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Transaction Rolled back: One or More courses provided, do not exist.';
            LEAVE sp;
        END IF;

        -- Assign the teacher to the course
        UPDATE courses
        SET TeacherID = p_TeacherUserID
        WHERE CourseID = currentCourseID;

        -- Increment the number of affected rows
        SET p_RowsAffected = p_RowsAffected + ROW_COUNT();

        -- Move to the next course ID
        SET courseCursor = courseCursor + 1;
    END WHILE;

    -- If no error occurred, commit the transaction
    IF done = 0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END$$

DELIMITER ;
