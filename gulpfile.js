var gulp = require('gulp');
var coffee = require('coffee-gulp');

gulp.task('default', function() {
    // place code for your default task here
});

gulp.task('coffee', function() {
    gulp.src('public/static/js/views/*.coffee')
        .pipe(coffee({
            bare: true
        }).on('error', gutil.log))
        .pipe(gulp.dest('public/static/js/'));
});


// var gulp = require('gulp');
// var concat = require('gulp-concat');
// var uglify = require('gulp-uglify');
// var less = require('gulp-less');

// var paths = {
//   scripts: ['static/js/*.js', '!client/external/**/*.coffee']
// };

// gulp.task('default', function() {
//   // place code for your default task here
// });

// gulp.task('scripts-cafe', function() {
//   // Minify and copy all JavaScript (except vendor scripts)
//   return gulp.src(['static/js/admin/jquery-2.0.3.min.js', 'static/js/cafe/foundation.min.js'])
//     .pipe(uglify())
//     .pipe(concat('cafe.min.js'))
//     .pipe(gulp.dest('static/js/'));
// });

// gulp.task('scripts-admin', function() {
//   // Minify and copy all JavaScript (except vendor scripts)
//   return gulp.src(['static/js/admin/jquery-2.0.3.min.js',
//           'static/js/admin/jquery-ui-1.10.3.custom.min.js',
//           'static/js/admin/jquery.ui.touch-punch.min.js',
//           'static/js/admin/bootstrap.min.js',
//           'static/js/admin/jquery.tagsinput.js',
//       ])
//     .pipe(uglify())
//     .pipe(concat('admin.min.js'))
//     .pipe(gulp.dest('static/js/'));
// });

// gulp.task('less', function() {
//     return gulp.src(['static/less/*.less' ])
//         .pipe(less())
//         .pipe(concat('cafe.css'))
//         .pipe(gulp.dest('static/css/'))
// });

gulp.task('watch', function() {
    gulp.watch('public/static/js/*.coffee', ['coffee']);
});