DELIMITER //

CREATE PROCEDURE `UpdateStudentStatus` (
    IN p_TeacherID INT,
    IN p_StudentID INT,
    IN p_PassStatus BOOLEAN
)
BEGIN
    DECLARE teacherIsTeacher INT;
    DECLARE studentExists INT;

    -- Check if the user is a teacher
    SELECT COUNT(*) INTO teacherIsTeacher
    FROM users
    WHERE UserID = p_TeacherID AND RoleID = 2;
    
    -- Ensure the user is a teacher
    IF teacherIsTeacher = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only Teachers can update student status';
    END IF;

    -- Check if the student exists
    SELECT COUNT(*) INTO studentExists
    FROM users
    WHERE UserID = p_StudentID AND RoleID = 3;

    -- If the student does not exist, raise an error
    IF studentExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Update the student status
    UPDATE enrolments
    SET Mark = p_PassStatus
    WHERE UserID = p_StudentID;

    IF p_PassStatus THEN
        SELECT 'Student passed' AS Result;
    ELSE
        SELECT 'Student failed' AS Result;
    END IF;

END //

DELIMITER ;
