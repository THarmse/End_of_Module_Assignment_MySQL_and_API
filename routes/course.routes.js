const express = require('express');
const courseController = require('../controllers/course.controller');
const router = express.Router();

router.post('/assign-courses-to-teacher', courseController.assignCoursesToTeacher);
router.post('/list-available-courses', courseController.listAvailableCourses);

module.exports = router;