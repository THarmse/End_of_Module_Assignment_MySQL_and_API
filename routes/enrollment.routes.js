const express = require('express');
const enrollmentController = require('../controllers/enrollment.controller');
const router = express.Router();

router.post('/enroll-student-in-course', enrollmentController.enrollStudentInCourse);
router.post('/assign-student-grade', enrollmentController.assignStudentGrade);



module.exports = router;
