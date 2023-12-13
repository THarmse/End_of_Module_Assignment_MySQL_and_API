const courseService = require('../services/course.service');

// Controller method to handle the assignment of multiple courses to a teacher
exports.assignCoursesToTeacher = (req, res) => {
    // Extracting adminUserId, courseIds (as an array), and teacherUserId from the request body
    const { adminUserId, courseIds, teacherUserId } = req.body;

    // Check if courseIds is provided and is an array to allow for one or multiple courses
    if (!Array.isArray(courseIds)) {
        // If courseIds is not an array, send a 400 Bad Request response
        return res.status(400).send({ message: "courseIds must be an array." });
    }

    // Join the courseIds array into a comma-separated string to pass to the stored procedure
    const courseIdsStr = courseIds.join(',');

    // Call the service function, providing the necessary parameters and a callback for handling the response
    courseService.assignCoursesToTeacher(adminUserId, courseIdsStr, teacherUserId, (error, data) => {
        if (error) {
            // If an error occurs, send a 500 Internal Server Error response with the error message
            res.status(500).send({ message: error.message });
        } else {
            // On successful assignment, send back the data received from the service layer
            res.send(data);
        }
    });
};


// Controller method to list available courses with an optional search filter
exports.listAvailableCourses = (req, res) => {
    // Extracting optional_course_search from the request body, using brackets for optional
    const { optional_course_search } = req.body;

    // Call the service function, providing the optional search term and a callback for handling the response
    courseService.listAvailableCourses(optional_course_search, (error, data) => {
        if (error) {
            // If an error occurs, send a 500 Internal Server Error response with the error message
            res.status(500).send({ message: error.message });
        } else {
            // On successful retrieval, send back the data received from the service layer
            res.send(data);
        }
    });
};


// Controller method to change the availability of a course
exports.changeCourseAvailability = (req, res) => {
    // Extracting adminUserId and courseId from the request body
    const { adminUserId, courseId, newAvailability } = req.body;

    // Call the service function, providing the necessary parameters and a callback for handling the response
    courseService.changeCourseAvailability(adminUserId, courseId, newAvailability, (error, data) => {
        if (error) {
            // If an error occurs, send a 500 Internal Server Error response with the error message
            res.status(500).send({ message: error.message });
        } else {
            // On successful change, send back the data received from the service layer
            res.send(data);
        }
    });
};

