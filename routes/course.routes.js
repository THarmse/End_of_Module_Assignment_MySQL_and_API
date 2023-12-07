const express = require('express');
const courseController = require('../controllers/course.controller');
const router = express.Router();

router.post('/assign-course', courseController.assignCourse);

module.exports = router;
