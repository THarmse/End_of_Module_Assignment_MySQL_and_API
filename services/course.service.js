const db = require('./database');

exports.assignCourseToTeacher = (adminUserId, courseId, teacherUserId, callback) => {
    db.query('CALL sp_AssignCourseToTeacher(?, ?, ?, @affectedRows)', [adminUserId, courseId, teacherUserId], (error, results) => {
        if (error) {
            return callback(error, null);
        }
        db.query('SELECT @affectedRows AS affectedRows', (error, results) => {
            if (error) {
                return callback(error, null);
            }
            return callback(null, results[0]);
        });
    });
};
