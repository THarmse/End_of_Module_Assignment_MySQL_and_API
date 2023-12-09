const express = require('express');
const enrollmentController = require('../controllers/enrollment.controller');
const router = express.Router();

router.post('/enroll-student-in-course', enrollmentController.enrollStudentInCourse);

module.exports = router;
