DELIMITER //

CREATE PROCEDURE `changeCourseAvailablity` (
    IN p_AdminUserID INT,
    IN p_CourseID INT
)
BEGIN
    DECLARE userIsAdmin INT;
    DECLARE courseIsAvailable INT;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO userIsAdmin
    FROM users
    WHERE UserID = p_AdminUserID AND RoleID = 1; -- Admin Role ID is 1
    
    -- Ensure the user is an admin
    IF userIsAdmin = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only Admin can change course availability';
    END IF;

    -- Check the availability of a course
    SELECT isAvailable INTO courseIsAvailable
    FROM courses
    WHERE CourseID = p_CourseID;

    -- If the user is an admin and the course is unavailable, enable the availability of a course
    IF userIsAdmin = 1 AND courseIsAvailable = 0 THEN
        UPDATE courses
        SET isAvailable = 1
        WHERE CourseID = p_CourseID;
        
        SELECT 'Course availability enabled' AS Result;

    -- If the user is an admin and the course is available, disable the availability of a course
    ELSEIF userIsAdmin = 1 AND courseIsAvailable = 1 THEN
        UPDATE courses
        SET isAvailable = 0
        WHERE CourseID = p_CourseID;
        
        SELECT 'Course availability disabled' AS Result;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid operation';
    END IF;
END //

DELIMITER ;
