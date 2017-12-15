gulp = require 'gulp'
sass = require 'gulp-sass'
rename = require 'gulp-rename'

gulp.task 'build:sass', () ->
  gulp.src 'source/stylesheets/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('build/stylesheets/')

gulp.task 'build:jpg', () ->
  gulp.src 'lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'
  	.pipe rename({extname: '.jpg'})
    .pipe gulp.dest('build/images/')

gulp.task 'build:png', () ->
  gulp.src 'lecture/data/img/**/*.{png,PNG}'
    .pipe rename({extname: '.png'})
    .pipe gulp.dest('build/images/')

gulp.task 'build:images', ['build:jpg', 'build:png']

gulp.task 'build:pdfs', () ->
  gulp.src 'lecture/data/**/*.pdf'
    .pipe gulp.dest('build/pdfs/')

gulp.task 'build:txts', () ->
  gulp.src 'lecture/data/**/*.txt'
    .pipe gulp.dest('build/txts/')


gulp.task 'build', ['build:sass', 'build:images', 'build:pdfs', 'build:txts']
