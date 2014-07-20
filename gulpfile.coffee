gulp = 				 require('gulp')
gutil = 			 require('gulp-util')
coffee = 			 require('gulp-coffee')
http = 				 require('http')
runSequence =  require('run-sequence')
sass = 				 require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
minifycss =    require('gulp-minify-css')
jshint =       require('gulp-jshint')
rename =       require('gulp-rename')
uglify =       require('gulp-uglify')
clean =        require('gulp-clean')
concat =       require('gulp-concat')
imagemin =     require('gulp-imagemin')
cache =        require('gulp-cache')
open =         require('gulp-open')
livereload =   require('gulp-livereload')
embedlr =      require('gulp-embedlr')
# ecstatic =     require('ecstatic')
lr =           require('tiny-lr')

server = lr()

config =
	http_port: 9594
	dest_app: './app'
	# livereload_port: '35729'

	# markup
	src_views: 'src/views/**/*'
	dest_views: 'app/views'

	# styles
	src_sass: 'src/public/styles/**/*.scss'
	dest_css: 'app/public/styles'

	# scripts
	src_coffee: 'src/**/*.coffee'
	js_concat_target: 'main.js'

	# plugins
	# src_plugins: 'src/assets/scripts/plugins/*.js'
	# dest_plugins: 'dist/assets/scripts'
	# plugins_concat: 'plugins.js'

	# images
	src_img: 'src/public/images/**/*.*'
	dest_img: 'dist/assets/images'


# sass task
gulp.task 'styles', ->
	gulp.src(config.src_sass)
		.pipe(sass(style: 'expanded'))
		.pipe(autoprefixer('last 2 version', 'safari 5', 'ie 7', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
		.pipe(gulp.dest(config.dest_css))
		.pipe(rename(suffix: '.min'))
		.pipe(minifycss())
		.pipe(gulp.dest(config.dest_css))
		.pipe livereload(server)


# compile server-side js, concat, & minify js
gulp.task 'scripts', ->
	# ".jshintrc"
	gulp.src(config.src_coffee)
		.pipe(coffee().on('error', gutil.log))
		# .pipe(jshint())
		# .pipe(jshint.reporter('default'))
		# .pipe(concat(config.js_concat_target))
		.pipe(gulp.dest(config.dest_app))
		# .pipe(rename(suffix: '.min'))
		# .pipe(uglify())
		# .pipe(gulp.dest(config.dest_app))
		.pipe livereload(server)


# # concat & minify plugins
# gulp.task 'plugins', ->
# 	# ".jshintrc"
# 	gulp.src(config.src_plugins)
# 		.pipe(jshint())
# 		.pipe(jshint.reporter('default'))
# 		.pipe(concat(config.plugins_concat))
# 		.pipe(gulp.dest(config.dest_plugins))
# 		.pipe(rename(suffix: '.min'))
# 		.pipe(uglify())
# 		.pipe(gulp.dest(config.dest_app))
# 		.pipe livereload(server)


# minify images
gulp.task 'images', ->
	gulp.src(config.src_img)
		.pipe(imagemin())
		.pipe gulp.dest(config.dest_img)


# watch html
gulp.task 'views', ->
	gulp.src(config.src_views)
		# .pipe(embedlr())
		.pipe(gulp.dest(config.dest_views))
		.pipe livereload(server)


# clean '.dist/'
gulp.task 'clean', ->
	gulp.src(['./app'], read: false)
	.pipe clean()


# site launcher
gulp.task 'open', ->
	return
	# gulp.src(config.startpage)
	# 	.pipe open(config.startpage,
	# 	url: 'http://localhost:' + config.http_port
	# )


# default task -- run 'gulp' from cli
gulp.task 'default', (callback) ->

	runSequence 'clean', [
		# 'plugins'
		'scripts'
		'styles'
		'images'
		'views'
	], 'open', callback

	server.listen config.livereload_port
	# http.createServer(ecstatic(root: 'dist/')).listen config.http_port

	gulp.watch(config.src_sass, ['styles'])._watcher.on 'all', livereload
	# gulp.watch(config.src_plugins, ['plugins'])._watcher.on 'all', livereload
	gulp.watch(config.src_coffee, ['scripts'])._watcher.on 'all', livereload
	gulp.watch(config.src_views, ['views'])._watcher.on 'all', livereload
	gulp.watch(config.src_img, ['images'])._watcher.on 'all', livereload

