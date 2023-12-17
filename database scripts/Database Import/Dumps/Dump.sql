CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `CourseID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(45) DEFAULT NULL,
  `TeacherID` int DEFAULT '0',
  `isAvailable` tinyint DEFAULT '0',
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Data structures',3,0),(2,'Databases',5,1),(3,'Machine learning',0,0),(4,'Network security',0,0),(5,'Computer graphics',3,1),(6,'Computer programming I',3,1),(7,'Game development',3,0),(8,'Computer algorithms',0,0),(9,'Computer programming II',3,0),(10,'Project management',0,0);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrolments`
--

DROP TABLE IF EXISTS `enrolments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrolments` (
  `EnrolmentID` int NOT NULL AUTO_INCREMENT,
  `Mark` tinyint DEFAULT NULL,
  `CourseID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`EnrolmentID`,`CourseID`,`UserID`),
  KEY `fk_Enrolments_Courses_idx` (`CourseID`),
  KEY `fk_Enrolments_Users1_idx` (`UserID`),
  CONSTRAINT `fk_Enrolments_Courses` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  CONSTRAINT `fk_Enrolments_Users1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolments`
--

LOCK TABLES `enrolments` WRITE;
/*!40000 ALTER TABLE `enrolments` DISABLE KEYS */;
INSERT INTO `enrolments` VALUES (12,85,1,16),(13,NULL,5,10),(14,NULL,9,10),(15,NULL,10,10),(16,NULL,6,10);
/*!40000 ALTER TABLE `enrolments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `Role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Teacher'),(3,'Student');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `RoleID` int NOT NULL,
  PRIMARY KEY (`UserID`,`RoleID`),
  KEY `fk_Users_Roles1_idx` (`RoleID`),
  CONSTRAINT `fk_Users_Roles1` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Clark Taylor',1),(2,'Natalie Armstrong',1),(3,'Max Barrett',2),(4,'Alisa Barnes',2),(5,'Catherine Nelson',2),(6,'Ted Casey',2),(7,'Dainton Henderson',2),(8,'Sarah Howard',2),(9,'Carina Higgins',2),(10,'Nicholas Ross',3),(11,'Adrianna Hall',3),(12,'Kelvin Murray',3),(13,'Kate Wilson',3),(14,'Marcus Johnson',3),(15,'Valeria Cooper',3),(16,'James Riley',3),(17,'Bruce Stewart',3),(18,'Alexia Barrett',3),(19,'Adam Perkins',3),(20,'Sam Foster',3),(21,'Charlotte Howard',3),(22,'Violet West',3),(23,'Brianna Brooks',3),(24,'Rubie Roberts',3),(25,'Jessica Perkins',3),(26,'Anna Roberts',3),(27,'Sabrina Crawford',3),(28,'Luke Murphy',3),(29,'Miley Cunningham',3),(30,'Julia Scott',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AssignCoursesToTeacher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AssignCoursesToTeacher`(
    IN p_AdminUserID INT, 
    IN p_CourseIDs TEXT, -- Has to be Comma-separated list of Course IDs to be submitted from API/Postman
    IN p_TeacherUserID INT,
    OUT p_RowsAffected INT,
    OUT p_ResultMessage VARCHAR(255)
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

    -- If the user is not an admin, roll back and set result message
    IF userIsAdmin = 0 THEN
        ROLLBACK;
        SET p_RowsAffected = 0;
        SET p_ResultMessage = 'Transaction Error: Only Admins can assign courses.';
        LEAVE sp;
    END IF;

    -- Check if the teacher exists
    SELECT COUNT(*) INTO teacherExists
    FROM users
    WHERE UserID = p_TeacherUserID AND RoleID = 2;

    -- If the teacher does not exist, roll back and set result message
    IF teacherExists = 0 THEN
        ROLLBACK;
        SET p_RowsAffected = 0;
        SET p_ResultMessage = 'Transaction Error: Teacher with provided UserID does not exist or is not valid.';
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
            SET p_RowsAffected = 0;
            SET p_ResultMessage = 'Transaction Error: Invalid CourseID format. Only numbers are allowed, separated by a comma';
            LEAVE sp;
        END IF;

        -- Check if the course exists
        SELECT COUNT(*) INTO courseExists
        FROM courses
        WHERE CourseID = currentCourseID;

        -- If the course does not exist, roll back and set result message
        IF courseExists = 0 THEN
            SET done = 1;
            ROLLBACK;
            SET p_RowsAffected = 0;
            SET p_ResultMessage = 'Transaction Rolled back: One or More courses provided, do not exist.';
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

    -- If no error occurred, commit the transaction and set success message
    IF done = 0 THEN
        COMMIT;
        SET p_ResultMessage = 'Success: Courses successfully assigned to the teacher.';
    ELSE
        ROLLBACK;
        -- Error message is already set in the respective conditional blocks above for each check
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AssignStudentGrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AssignStudentGrade`(
    IN p_TeacherID INT, 
    IN p_StudentID INT,
    IN p_CourseID INT,
    IN p_Grade TINYINT,         
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ChangeCourseAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ChangeCourseAvailability`(
    IN p_AdminUserID INT, 
    IN p_CourseID INT,
    IN p_NewAvailability TINYINT,  
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
)
sp:BEGIN
    DECLARE userIsAdmin INT;
    DECLARE courseExists INT;

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
    
        -- Validate new availability (must be 0 or 1 as TinyInt is used and not boolean in db)
    IF p_NewAvailability NOT IN (0, 1) THEN
        SET p_ResultMessage = 'Transaction Error: Invalid availability value. Must be 0 or 1.';
        LEAVE sp;
    END IF;

    -- Update the availability of the course
    UPDATE courses
    SET isAvailable = p_NewAvailability
    WHERE CourseID = p_CourseID;

    -- Set success result message based on the new availability
    IF p_NewAvailability = 1 THEN
        SET p_ResultMessage = 'Success: Course availability enabled.';
    ELSE
        SET p_ResultMessage = 'Success: Course availability disabled.';
    END IF;

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EnrollStudentInCourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EnrollStudentInCourse`(
    IN p_StudentUserID INT, 
    IN p_CourseID INT,
    OUT p_ResultMessage VARCHAR(255),
    OUT p_AffectedRows INT
)
sp: BEGIN
    DECLARE studentRole TINYINT;
    DECLARE courseExists TINYINT;
    DECLARE courseAvailable TINYINT;
    DECLARE alreadyEnrolled TINYINT;

    -- Initialize p_AffectedRows to 0
    SET p_AffectedRows = 0;

    -- Check if the user is a student
    SELECT COUNT(*) INTO studentRole
    FROM users
    WHERE UserID = p_StudentUserID AND RoleID = 3; -- Student Role ID is 3

    -- If the user is not a student, set result message
    IF studentRole = 0 THEN
        SET p_ResultMessage = 'Transaction Error: Only students can enroll in courses.';
        LEAVE sp;
    END IF;

    -- Check if the course exists
    SELECT COUNT(*) INTO courseExists
    FROM courses
    WHERE CourseID = p_CourseID;

    -- If the course does not exist, set result message
    IF courseExists = 0 THEN
        SET p_ResultMessage = 'Transaction Error: The specified course does not exist.';
        LEAVE sp;
    END IF;
    
        -- Check if the course is available for enrollment
    SELECT COUNT(*) INTO courseAvailable
    FROM courses
    WHERE CourseID = p_CourseID and isAvailable = 1;

    -- If the course is valid but not available for enrollment, set result message
    IF courseAvailable = 0 THEN
        SET p_ResultMessage = 'Transaction Error: The specified course is not available for enrollment.';
        LEAVE sp;
    END IF;

    -- Check if the student is already enrolled in the course
    SELECT COUNT(*) INTO alreadyEnrolled
    FROM enrolments
    WHERE UserID = p_StudentUserID AND CourseID = p_CourseID;

    -- If the student is already enrolled, set result message
    IF alreadyEnrolled > 0 THEN
        SET p_ResultMessage = 'Transaction Error: Student is already enrolled in this course.';
        LEAVE sp;
    END IF;

    -- Enroll the student in the course
    INSERT INTO enrolments (CourseID, UserID)
    VALUES (p_CourseID, p_StudentUserID);

    -- Set success result message
    SET p_ResultMessage = 'Success: Student successfully enrolled in the course.';

    -- Capture the number of affected rows
    SET p_AffectedRows = ROW_COUNT();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListAvailableCourses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ListAvailableCourses`(
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
        SET p_ResultMessage = 'Transaction Error: Only students can use this function.';
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-17 21:29:40
