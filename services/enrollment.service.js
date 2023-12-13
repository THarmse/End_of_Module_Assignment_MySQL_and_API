const db = require('../config/db.connection');

/**
 * Service function to enroll a student in a course.
 * It calls the stored procedure 'sp_EnrollStudentInCourse' with the provided student user ID and course ID.
 * A student cannot be enrolled more than once at a time. 
 * After executing the procedure, it retrieves the number of rows affected and the result message.
 * @param {number} studentUserId - ID of the student being enrolled
 * @param {number} courseId - ID of the course in which the student is being enrolled
 * @param {function} callback - Callback function to handle the response
 */
exports.enrollStudentInCourse = (studentUserId, courseId, callback) => {
    // Call the stored procedure with the provided studentUserId and courseId
    db.query('CALL sp_EnrollStudentInCourse(?, ?, @resultMessage, @affectedRows)', [studentUserId, courseId], (error, results) => {
        if (error) {
            // Pass any errors that occur during the stored procedure call back to the controller
            return callback(error, null);
        }

        // Retrieve the  number of rows affected and result message from the stored procedure
        db.query('SELECT  @affectedRows AS affectedRows, @resultMessage AS resultMessage', (error, results) => {
            if (error) {
                // If an error occurs while retrieving the outputs, pass the error back to the controller
                return callback(error, null);
            }

            // If successful, pass the result message and the number of affected rows back to the controller
            return callback(null, results[0]);
        });
    });
};

/**
 * Service function to assign a numeric grade to a student for a specific course.
 * It executes the stored procedure 'sp_AssignStudentGrade' with the given parameters.
 * @param {number} teacherId - ID of the teacher performing the grade assignment
 * @param {number} studentId - ID of the student whose grade is being assigned
 * @param {number} courseId - ID of the course for which the grade is being assigned
 * @param {number} grade - Numeric grade to be assigned to the student (0 to 100)
 * @param {function} callback - Callback function to handle the response
 */
exports.assignStudentGrade = (teacherId, studentId, courseId, grade, callback) => {
    // Call the stored procedure with the provided teacherId, studentId, courseId, and grade
    db.query('CALL sp_AssignStudentGrade(?, ?, ?, ?, @affectedRows, @resultMessage)', [teacherId, studentId, courseId, grade], (error) => {
        if (error) {
            return callback(error, null);
        }

        // Retrieve the number of rows affected and the result message from the stored procedure
        db.query('SELECT @affectedRows AS affectedRows, @resultMessage AS resultMessage', (error, results) => {
            if (error) {
                return callback(error, null);
            }

            const result = results[0];
            result.resultMessage = result.resultMessage || '';

            return callback(null, result);
        });
    });
};



