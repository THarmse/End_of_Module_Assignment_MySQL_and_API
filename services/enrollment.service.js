const db = require('./database');

// Service function to enroll a student in a course
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
