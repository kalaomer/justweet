
var gulp = require("gulp");
var gutil = require("gulp-util");
var browserify = require("browserify");
var coffee = require("coffeeify");
var source = require("vinyl-source-stream");
var path = require("path");
var del = require("del");

function createBundle(module) {
  return browserify(path.join("./src/script", module, "/index.coffee"),
    {
      extensions: [".coffee"]
    })
      .transform("coffeeify")
      .bundle()
      .on("error", function(err) {
        console.log(err);
      })
      .pipe(source(module + ".js"))
      .pipe(gulp.dest("build/js"));
}

gulp.task("copy", function() {
  return gulp.src(["manifest.json", "icon.png", "popup.html"])
    .pipe(gulp.dest("build"))
});

gulp.task("css", function() {
  gulp.src("./src/style/**/*.css")
    .pipe(gulp.dest("build/css"))
});

gulp.task("content", function() {
  return createBundle("content");
});

gulp.task("popup", function() {
  return createBundle("popup");
});

gulp.task("clean", function(cb) {
  del(["dist/**"], cb);
});

gulp.task("watch", function() {
  gulp.watch("./src/content/**/*.coffee", ["content"]);
  gulp.watch("./src/popup/**/*.coffee", ["popup"]);
  gulp.watch("./manifest.json", ["copy"]);
  gulp.watch("./css/**/*.css", ["css"]);
  gulp.watch("./*.html", ["copy"]);
});

gulp.task("build", ["clean", "content", "popup", "css", "copy"]);

gulp.task("default", ["content", "popup"]);
