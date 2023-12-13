const enrollmentService = require('../services/enrollment.service');

// Controller method to handle student enrollment in a course
exports.enrollStudentInCourse = (req, res) => {
    // Extracting studentUserId and courseId from the request body
    const { studentUserId, courseId } = req.body;

    // Call the service function, providing the necessary parameters and a callback for handling the response
    enrollmentService.enrollStudentInCourse(studentUserId, courseId, (error, data) => {
        if (error) {
            // If an error occurs, send a 500 Internal Server Error response with the error message
            res.status(500).send({ message: error.message });
        } else {
            // On successful enrollment, send back the data received from the service layer
            res.send(data);
        }
    });
};

/**
 * Controller method to handle the assignment of a numeric grade to a student for a specific course.
 * It extracts the teacher's ID, student's ID, course ID, and grade from the request body
 * and passes these parameters to the service layer.
 */
exports.assignStudentGrade = (req, res) => {
    // Extracting teacherId, studentId, courseId, and grade from the request body
    const { teacherId, studentId, courseId, grade } = req.body;

    // Call the service function to assign a numeric grade to a student for the specified course
    enrollmentService.assignStudentGrade(teacherId, studentId, courseId, grade, (error, data) => {
        if (error) {
            // If an error occurs during the procedure call, respond with a 500 Internal Server Error
            res.status(500).send({ message: error.message });
        } else {
            // On successful grade assignment, send back the data received from the service layer
            res.send(data);
        }
    });
};
