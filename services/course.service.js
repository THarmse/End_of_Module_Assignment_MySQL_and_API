const db = require('./database');

// Service function to assign multiple courses to a teacher
exports.assignCoursesToTeacher = (adminUserId, courseIdsStr, teacherUserId, callback) => {
    // Call the stored procedure with the provided adminUserId, courseIdsStr, and teacherUserId
    db.query('CALL sp_AssignCoursesToTeacher(?, ?, ?, @affectedRows)', [adminUserId, courseIdsStr, teacherUserId], (error, results) => {
        if (error) {
            // Pass any errors that occur during the stored procedure call back to the controller
            return callback(error, null);
        }

        // Retrieve the number of rows affected by the stored procedure
        db.query('SELECT @affectedRows AS affectedRows', (error, results) => {
            if (error) {
                // If an error occurs while retrieving the affected rows, pass the error back to the controller
                return callback(error, null);
            }

            // If successful, pass the result (number of affected rows) back to the controller
            return callback(null, results[0]);
        });
    });
};
