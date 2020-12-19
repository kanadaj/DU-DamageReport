const gulp = require('gulp');
const luaminify = require('gulp-luaminify');
const concat = require('gulp-concat');
const replace = require('gulp-replace');
const exec = require('gulp-exec');
const log = require('fancy-log');
const watch = require('gulp-watch');
 
const slots = [
    "slot1:type=core",
    "slot2:type=databank",
    "slot3:type=screen",
    "slot4:type=screen",
    "slot5:type=screen",
    "slot6:type=screen",
    "slot7:type=screen",
    "slot8:type=screen",
    "slot9:type=screen",
    "slot10:type=screen"
];

// Bundles to build. The order of files and bundles matters!
const bundles = [
    {
        output: "DamageReport.lua",
        files: [
            "src/Utility.lua",
            "src/Init.lua",
            "src/Databank.lua",
            "src/Parameters.lua",
            "src/Variables.lua",
            "src/DamageReport.lua",
            "src/TouchScreen.lua",
            "src/Render.lua",
            "src/Main.lua"
        ]
    }
]

function Build(bundle){
    return () => gulp.src(bundle.files)
        .pipe(concat(bundle.output))
        .pipe(gulp.dest('build'))
}

function Bundle(){
    return gulp.src(bundles.map(x => "build/" + x.output))
        .pipe(concat('bundle.lua'))
        .pipe(gulp.dest('build/bundle'))
}

function Compile(){
    var bundleSteps = bundles.map(Build);
    return gulp.series(gulp.parallel.apply(gulp, bundleSteps), Bundle);
}

function Wrap(){
    var options = {
      continueOnError: false, // default = false, true means don't emit error event
      pipeStdout: false, // default = false, true means stdout is written to file.contents
    };
    var reportOptions = {
        err: true, // default = true, false means don't write err
        stderr: true, // default = true, false means don't write stderr
        stdout: true // default = true, false means don't write stdout
    };
    return gulp.src(['gulpfile.js'])
        .pipe(exec(file => `lua wrap.lua --name "DU Damage Report" --handle-errors build/bundle/bundle.lua dist/DamageReport.conf --slots ${slots.join(" ")}`, options))
        //.pipe(exec(file => `lua wrap.lua --name "DU Damage Report" --handle-errors build/bundle/bundle.lua dist/DamageReport.conf`, options))
        .pipe(exec.reporter(reportOptions))
}

function CompileAndWrap(){
    return gulp.series(Compile(), Wrap);
}

function Watch(){
    for(var bundle of bundles){
        watch(bundle.files, CompileAndWrap());
    }
}

exports.default = CompileAndWrap();
exports.watch = Watch;