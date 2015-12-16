var gulp = require('gulp'),
    imagemin = require('gulp-imagemin'),
    pngquant = require('imagemin-pngquant')
    minifyHTML = require('gulp-minify-html'),
    autoprefixer = require('gulp-autoprefixer'),
    jpegtran = require('imagemin-jpegtran'),
    gifsicle = require('imagemin-gifsicle'),
    optipng = require('imagemin-optipng'),
    uglifycss = require('gulp-uglifycss');

gulp.task('default', ['compress_images','compress_html','compress_css']);

gulp.task('compress_images', function () {
  return gulp.src('images/**')
      .pipe(imagemin({
          progressive: true,
          svgoPlugins: [{removeViewBox: false}],
          use: [pngquant(), jpegtran(), optipng(), gifsicle()]
      }))
      .pipe(gulp.dest('images/'));
});

gulp.task('compress_html', function () {
    return gulp.src('**/*.html')
    .pipe(minifyHTML({
      quotes: true
    }))
    .pipe(gulp.dest('.'));
});

gulp.task('compress_css', function () {
    return gulp.src('css/main.css')
    .pipe(autoprefixer())
    .pipe(uglifycss({"max-line-len": 80}))
    .pipe(gulp.dest('css/'));
});
