gulp = require 'gulp'
sass = require 'gulp-sass'

gulp.task 'build:sass', () ->
  gulp.src 'source/stylesheets/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('build/stylesheets/')

gulp.task 'build:images', () ->
  gulp.src 'lecture/data/img/**/*'
    .pipe gulp.dest('build/images/')

gulp.task 'build', ['build:sass', 'build:images']
