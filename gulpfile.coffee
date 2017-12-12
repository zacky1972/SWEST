gulp = require 'gulp'
sass = require 'gulp-sass'

gulp.task 'build:sass', () ->
  gulp.src 'source/stylesheets/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('build/stylesheets/')

gulp.task 'build:images', () ->
  gulp.src 'lecture/data/img/**/*'
    .pipe gulp.dest('build/images/')

gulp.task 'build:pdfs', () ->
  gulp.src 'lecture/data/**/*.pdf'
    .pipe gulp.dest('build/pdfs/')

gulp.task 'build:txts', () ->
  gulp.src 'lecture/data/**/*.txt'
    .pipe gulp.dest('build/txts/')


gulp.task 'build', ['build:sass', 'build:images', 'build:pdfs', 'build:txts']
