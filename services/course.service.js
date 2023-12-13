const db = require('../config/db.connection');

/**
 * Service function to assign one or more courses to a teacher.
 * This function executes the 'sp_AssignCoursesToTeacher' stored procedure,
 * which assigns one or more courses to a specified teacher. The courses are identified by their IDs,
 * passed as a comma-separated string. The procedure is initiated by an admin user,
 * and it returns the number of courses successfully assigned, along with a result message.
 * @param {number} adminUserId - ID of the admin user performing the course assignment
 * @param {string} courseIdsStr - Comma-separated string of course IDs to be assigned to the teacher
 * @param {number} teacherUserId - ID of the teacher to whom the courses are being assigned
 * @param {function} callback - Callback function to handle the response
 */
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


/**
 * Service function to list available courses with an optional search filter.
 * This function calls the 'sp_ListAvailableCourses' stored procedure,
 * providing a search term to filter the course names. If no search term is provided,
 * the procedure returns all courses.
 * @param {string} optional_course_search - Optional search term to filter available courses
 * @param {function} callback - Callback function to handle the response
 */
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

/**
 * Service function to change the availability of a course.
 * This function executes the 'sp_ChangeCourseAvailability' stored procedure,
 * which sets the availability of a specified course based on the given course ID and the desired availability status.
 * The procedure is invoked by an admin, identified by their user ID, and the new availability status is provided as a parameter.
 * It returns the number of rows affected and a result message indicating the outcome.
 * @param {number} adminUserId - ID of the admin user performing the operation
 * @param {number} courseId - ID of the course for which the availability is being changed
 * @param {boolean} newAvailability - New availability status to be set for the course
 * @param {function} callback - Callback function to handle the response
 */
exports.changeCourseAvailability = (adminUserId, courseId, newAvailability, callback) => {
    // Call the stored procedure with the provided adminUserId, courseId, and newAvailability
    db.query('CALL sp_ChangeCourseAvailability(?, ?, ?, @affectedRows, @resultMessage)', [adminUserId, courseId, newAvailability], (error, results) => {
        if (error) {
            // Pass any errors that occur during the stored procedure call back to the controller
            return callback(error, null);
        }

        // Retrieve the number of rows affected and result message from the stored procedure
        db.query('SELECT @affectedRows AS affectedRows, @resultMessage AS resultMessage', (error, results) => {
            if (error) {
                // If an error occurs while retrieving the outputs, pass the error back to the controller
                return callback(error, null);
            }

            // If successful, pass the result message and the number of affected rows back to the controller
            return callback(null, results[0]);
        });
    });
};
