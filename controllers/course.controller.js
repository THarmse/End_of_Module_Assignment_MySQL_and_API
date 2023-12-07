const courseService = require('../services/course.service');

exports.assignCourse = (req, res) => {
    const { adminUserId, courseId, teacherUserId } = req.body;
    courseService.assignCourseToTeacher(adminUserId, courseId, teacherUserId, (error, data) => {
        if (error) {
            res.status(500).send({ message: error.message });
        } else {
            res.send(data);
        }
    });
};
