const db = require('./database');

// Service function to assign multiple courses to a teacher
exports.assignCoursesToTeacher = (adminUserId, courseIdsStr, teacherUserId, callback) => {
    // Call the stored procedure with the provided adminUserId, courseIdsStr, and teacherUserId
    db.query('CALL sp_AssignCoursesToTeacher(?, ?, ?, @affectedRows, @resultMessage)', [adminUserId, courseIdsStr, teacherUserId], (error, results) => {
        if (error) {
            // Pass any errors that occur during the stored procedure call back to the controller
            return callback(error, null);
        }

        // Retrieve the number of rows affected by the stored procedure
        db.query('SELECT @affectedRows AS affectedRows, @resultMessage AS resultMessage', (error, results) => {
            if (error) {
                // If an error occurs while retrieving the affected rows, pass the error back to the controller
                return callback(error, null);
            }

            // If successful, pass the result (number of affected rows) back to the controller
            return callback(null, results[0]);
        });
    });
};


// Service function to list available courses with an optional search filter
exports.listAvailableCourses = (optional_course_search, callback) => {
    // Call the stored procedure with the provided search term
    db.query('CALL sp_ListAvailableCourses(?)', [optional_course_search], (error, results) => {
        if (error) {
            // Pass any errors that occur during the stored procedure call back to the controller
            return callback(error, null);
        }

        // If successful, pass the results back to the controller
        // Assuming the results are in the first element of the results array
        return callback(null, results[0]);
    });
};
