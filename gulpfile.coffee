gulp = require 'gulp'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
imageResize = require 'gulp-image-resize'
imagemin    = require 'gulp-imagemin'
parcel = require 'gulp-parcel'

resizeOptions300 = {
  width : 300,
  height : 300,
  gravity : 'Center',
  crop : true,
  upscale : true,
  imageMagick : true,
}

resizeOptions200 = {
  width : 200,
  height : 200,
  gravity : 'Center',
  crop : true,
  upscale : true,
  imageMagick : true,
}

resizeOptions100 = {
  width : 100,
  height : 100,
  gravity : 'Center',
  crop : true,
  upscale : true,
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

gulp.task 'build:jpg300', () ->
  gulp.src 'lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'
    .pipe rename({extname: '.300.jpg'})
    .pipe imageResize(resizeOptions300)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:jpg200', () ->
  gulp.src 'lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'
  	.pipe rename({extname: '.200.jpg'})
    .pipe imageResize(resizeOptions200)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:jpg100', () ->
  gulp.src 'lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'
    .pipe rename({extname: '.100.jpg'})
    .pipe imageResize(resizeOptions100)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:jpg', ['build:jpg300', 'build:jpg200', 'build:jpg100']

gulp.task 'watch:jpg', ['build:jpg'], () ->
  gulp.watch ['lecture/data/img/**/*.{jpg,JPG,jpeg,JPEG}'], ['build:jpg']

gulp.task 'build:png300', () ->
  gulp.src 'lecture/data/img/**/*.{png,PNG}'
    .pipe rename({extname: '.300.png'})
    .pipe imageResize(resizeOptions300)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:png200', () ->
  gulp.src 'lecture/data/img/**/*.{png,PNG}'
    .pipe rename({extname: '.200.png'})
    .pipe imageResize(resizeOptions200)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:png100', () ->
  gulp.src 'lecture/data/img/**/*.{png,PNG}'
    .pipe rename({extname: '.100.png'})
    .pipe imageResize(resizeOptions100)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:png', ['build:png300', 'build:png200', 'build:png100']

gulp.task 'watch:png', ['build:png'], () ->
  gulp.watch ['lecture/data/img/**/*.{png,PNG}'], ['build:png']

gulp.task 'build:empty300', () ->
  gulp.src 'source/images/empty.jpg'
    .pipe rename({extname: '.300.jpg'})
    .pipe imageResize(resizeOptions300)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:empty200', () ->
  gulp.src 'source/images/empty.jpg'
    .pipe rename({extname: '.200.jpg'})
    .pipe imageResize(resizeOptions200)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:empty100', () ->
  gulp.src 'source/images/empty.jpg'
    .pipe rename({extname: '.100.jpg'})
    .pipe imageResize(resizeOptions100)
    .pipe imagemin(imageminOptions)
    .pipe gulp.dest('build/images/')

gulp.task 'build:empty', ['build:empty300', 'build:empty200', 'build:empty100']

gulp.task 'watch:empty', ['build:empty'], () ->
  gulp.watch ['source/images/empty.jpg'], ['build:empty']

gulp.task 'build:images', ['build:empty', 'build:jpg', 'build:png']

gulp.task 'watch:images', ['watch:empty', 'watch:jpg', 'watch:png']

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

gulp.task 'build:js', () ->
  gulp.src 'source/javascripts/site.js', {read:false}
    .pipe parcel(['build'])
    .pipe gulp.dest('build/javascripts/')

gulp.task 'watch:js', () ->
  gulp.src 'source/javascripts/site.js', {read:false}
    .pipe parcel(['watch'])
    .pipe gulp.dest('build/javascripts/')  

gulp.task 'build', ['build:js', 'build:sass', 'build:images', 'build:pdfs', 'build:txts']

gulp.task 'watch', ['watch:js', 'watch:sass', 'watch:images', 'watch:pdfs', 'watch:txts']

