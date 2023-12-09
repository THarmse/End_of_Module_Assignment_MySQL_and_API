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
