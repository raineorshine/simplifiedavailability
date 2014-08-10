gulp = 				 require('gulp')
gutil = 			 require('gulp-util')
coffee = 			 require('gulp-coffee')
http = 				 require('http')
runSequence =  require('run-sequence')
sass = 				 require('gulp-ruby-sass')
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
markdown =     require('gulp-markdown')
header =     	 require('gulp-header')
lr =           require('tiny-lr')
notify =       require('gulp-notify')

server = lr()

config =
	http_port: 9594
	# dest_app: './app'
	livereload_port: '35729'

	readme: 'README.md'

	# views
	src_views: 'views/**/*'

	# styles
	src_sass: 'src/styles/*.sass'
	watch_sass: 'src/styles/**/*.sass'
	dest_css: 'public/styles'

	# scripts
	src_client_coffee: 'src/client/**/*.coffee'
	src_server_coffee: 'src/server/**/*.coffee'
	dest_clientjs: 'public/scripts'
	dest_serverjs: 'app'
	# js_concat_target: 'main.js'

	# plugins
	# src_plugins: 'src/assets/scripts/plugins/*.js'
	# dest_plugins: 'dist/assets/scripts'
	# plugins_concat: 'plugins.js'

	# images
	src_img: 'src/public/images/**/*.*'
	dest_img: 'app/public/images'


# sass task
gulp.task 'styles', ->
	gulp.src(config.src_sass)
		.pipe(sass(style: 'expanded', noCache: true))
		.on('error', notify.onError(Error))
		# .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 7', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
		.pipe(gulp.dest(config.dest_css))
		.pipe(rename(suffix: '.min'))
		.pipe(minifycss())
		.pipe(gulp.dest(config.dest_css))
		.pipe livereload(server)
		.pipe(notify('sass compiled & minified'))

# compile server-side js, concat, & minify js
gulp.task 'clientjs', ->
	# ".jshintrc"
	gulp.src(config.src_client_coffee)
		.pipe(coffee().on('error', gutil.log))
		# .pipe(jshint())
		# .pipe(jshint.reporter('default'))
		# .pipe(concat(config.js_concat_target))
		.pipe(gulp.dest(config.dest_clientjs))
		# .pipe(rename(suffix: '.min'))
		# .pipe(uglify())
		# .pipe(gulp.dest(config.dest_app))
		.pipe livereload(server)

gulp.task 'serverjs', ->
	# ".jshintrc"
	gulp.src(config.src_server_coffee)
		.pipe(coffee().on('error', gutil.log))
		# .pipe(jshint())
		# .pipe(jshint.reporter('default'))
		# .pipe(concat(config.js_concat_target))
		.pipe(gulp.dest(config.dest_serverjs))
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
		# .pipe(gulp.dest(config.dest_views))
		.pipe livereload(server)


# clean '.dist/'
gulp.task 'clean', ->
	gulp.src([config.dest_clientjs, config.dest_serverjs, config.dest_css], read: false)
	.pipe clean()


# site launcher
gulp.task 'open', ->
	return
	# gulp.src(config.startpage)
	# 	.pipe open(config.startpage,
	# 	url: 'http://localhost:' + config.http_port
	# )

gulp.task 'readme', ->
	gulp.src(config.readme)
		.pipe(markdown())
		.pipe(header('<meta charset="UTF-8">'))
		.pipe(header('<link rel="stylesheet" href="markdown.css">'))
		.pipe gulp.dest './'

# default task -- run 'gulp' from cli
gulp.task 'default', (callback) ->

	runSequence 'clean', [
		# 'plugins'
		'clientjs'
		'serverjs'
		'styles'
		'images'
		'views'
		'readme'
	], 'open', callback

	server.listen config.livereload_port
	# http.createServer(ecstatic(root: 'dist/')).listen config.http_port

	gulp.watch(config.watch_sass, ['styles'])._watcher.on 'all', livereload
	# gulp.watch(config.src_plugins, ['plugins'])._watcher.on 'all', livereload
	gulp.watch(config.src_client_coffee, ['clientjs'])._watcher.on 'all', livereload
	gulp.watch(config.src_server_coffee, ['serverjs'])._watcher.on 'all', livereload
	gulp.watch(config.src_views, ['views'])._watcher.on 'all', livereload
	gulp.watch(config.src_img, ['images'])._watcher.on 'all', livereload

	gulp.watch(config.readme, ['readme'])

