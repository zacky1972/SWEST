gulp = require 'gulp'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
imageResize = require 'gulp-image-resize'
imagemin    = require 'gulp-imagemin'

resizeOptions = {
  width : 200,
  height : 200,
  gravity : 'Center',
  crop : true,
  upscale : false,
  imageMagick : true,
}

imageminOptions = {
    optimizationLevel: 7
}

gulp.task 'build:sass', () ->
  gulp.src 'source/stylesheets/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('build/stylesheets/')

gulp.task 'watch:sass', ['build:sass'], () ->
  gulp.watch ['source/stylesheets/**/*.scss'], ['build:sass']

gulp.task 'build:jpg', () ->
  gulp.src 'lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'
  	.pipe rename({extname: '.jpg'})
    .pipe imageResize(resizeOptions)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'watch:jpg', ['build:jpg'], () ->
  gulp.watch ['lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'], ['build:jpg']

gulp.task 'build:png', () ->
  gulp.src 'lecture/data/img/**/*.{png,PNG}'
    .pipe rename({extname: '.png'})
    .pipe imageResize(resizeOptions)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'watch:png', ['build:png'], () ->
  gulp.watch ['lecture/data/img/**/*.{png,PNG}'], ['build:png']

gulp.task 'build:images', ['build:jpg', 'build:png']

gulp.task 'watch:images', ['watch:jpg', 'watch:png']

gulp.task 'build:pdfs', () ->
  gulp.src 'lecture/data/**/*.pdf'
    .pipe gulp.dest('build/pdfs/')

gulp.task 'watch:pdfs', ['build:pdfs'], () ->
  gulp.watch ['lecture/data/img/**/*.pdf'], ['build:pdfs']

gulp.task 'build:txts', () ->
  gulp.src 'lecture/data/**/*.txt'
    .pipe gulp.dest('build/txts/')

gulp.task 'watch:txts', ['build:txts'], () ->
  gulp.watch ['lecture/data/img/**/*.txt'], ['build:txts']


gulp.task 'build', ['build:sass', 'build:images', 'build:pdfs', 'build:txts']

gulp.task 'watch', ['watch:sass', 'watch:images', 'watch:pdfs', 'watch:txts']

