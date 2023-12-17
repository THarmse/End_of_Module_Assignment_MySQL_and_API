-- Stored Procedure to List All Available Courses with Course Titles and Teacher Names
-- Version: 1.2
-- Date Updated: 17 December 2023
-- Author: Theodor Harmse
-- Group: Group C

USE `mydb`;

DELIMITER $$

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `sp_ListAvailableCourses`$$

-- Create the new procedure with an optional search parameter 
CREATE PROCEDURE `sp_ListAvailableCourses`(
	IN p_StudentUserID INT,
	IN optional_course_search VARCHAR(255),    
    OUT p_ResultMessage VARCHAR(255))
    
sp: BEGIN
    DECLARE studentRole TINYINT;

  -- Check if the user is a student
    SELECT COUNT(*) INTO studentRole
    FROM users
    WHERE UserID = p_StudentUserID AND RoleID = 3; -- Student Role ID is 3

    -- If the user is not a student, set result message
    IF studentRole = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Only students use this function.';
        LEAVE sp;
    END IF;

    -- If course search term is provided, filter courses based on the term; otherwise, list all available courses
    IF optional_course_search IS NULL OR optional_course_search = '' THEN
        SELECT 
            c.CourseID AS Course_ID, 
            c.Title AS Course_Name, 
            IFNULL(CONCAT(u.Name), 'TBD - To Be Determined') AS Teacher_Name -- Assuming a valid approach - Course can be avaialble, but teacher not yet assigned. Else, use INNER JOIN
        FROM courses c
        LEFT JOIN users u ON c.TeacherID = u.UserID
        WHERE c.isAvailable = 1;
    ELSE
        SELECT 
            c.CourseID AS Course_ID, 
            c.Title AS Course_Name, 
            IFNULL(CONCAT(u.Name), 'TBD - To Be Determined') AS Teacher_Name -- Assuming a valid approach - Course can be avaialble, but teacher not yet assigned. Else, use INNER JOIN
        FROM courses c
        LEFT JOIN users u ON c.TeacherID = u.UserID
        WHERE c.isAvailable = 1 AND (c.Title LIKE CONCAT('%', optional_course_search, '%'));
    END IF;

END$$

DELIMITER ;
