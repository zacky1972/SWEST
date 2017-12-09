gulp = require 'gulp'
sass = require 'gulp-sass'

gulp.task 'build:sass', () ->
  gulp.src 'source/stylesheets/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('build/stylesheets/')