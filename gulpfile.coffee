gulp = require 'gulp'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
imageResize = require 'gulp-image-resize'
imagemin = require 'gulp-imagemin'
parcel = require 'gulp-parcel'
rev = require 'gulp-rev'
revReplace = require 'gulp-rev-replace'
revDel = require 'rev-del'
sequence = require 'run-sequence'
del = require 'del'
vinylPaths = require 'vinyl-paths'

# filesInStream = require 'gulp-filesinstream'
# chalk = require 'chalk'

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

gulp.task 'build:images', ['build:empty', 'build:jpg', 'build:png']

gulp.task 'build:pdfs', () ->
  gulp.src 'lecture/data/**/*.pdf'
    .pipe gulp.dest('build/pdfs/')

gulp.task 'build:txts', () ->
  gulp.src 'lecture/data/**/*.txt'
    .pipe gulp.dest('build/txts/')

gulp.task 'build:js', () ->
  gulp.src 'source/javascripts/site.js', {read:false}
    .pipe parcel()
    .pipe gulp.dest('build/javascripts/')

gulp.task 'build', ['build:js', 'build:sass', 'build:images', 'build:pdfs', 'build:txts']


gulp.task 'watch', ['build'], () ->
  gulp.watch [
    'source/stylesheets/**/*.scss',
    # 'lecture/data/img/**/*',
    'source/javascripts/site.js'
    ], ['build']

gulp.task 'rev', () ->
  gulp.src ['build/**/*.+(js|css|png|gif|jpg|jpeg|svg|woff|ico)', '!build/**/*-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]*.+(js|css|png|gif|jpg|jpeg|svg|woff|ico)']
    .pipe rev()
    .pipe gulp.dest 'build/'
    .pipe rev.manifest('manifest.json')
    .pipe revDel({ dest: 'build/'})
    .pipe gulp.dest('build/')

gulp.task 'rev:replace', () ->
  manifest = gulp.src 'build/manifest.json'
  gulp.src 'build/**/*.+(html|css|js)'
    .pipe revReplace(manifest: manifest)
    .pipe gulp.dest('build/')

gulp.task 'rev:clean', () ->
  gulp.src ['build/**/*.+(js|css|png|gif|jpg|jpeg|svg|woff|ico)', '!build/**/*-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]*.+(js|css|png|gif|jpg|jpeg|svg|woff|ico)']
    .pipe(vinylPaths(del))

gulp.task 'parcel', () ->
  gulp.src 'build/**/*.html', {read:false}
    .pipe parcel()
    .pipe gulp.dest('build/')

gulp.task 'post', () -> 
  sequence 'rev', 'rev:replace', 'rev:clean'

