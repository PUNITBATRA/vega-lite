#!/usr/bin/env node
// Log Vl Tree

'use strict';

var helpText =
  'Compile a Vega-Lite spec to Vega.\n\n' +
  'Usage: vl2vg [vega_lite_json_file]\n\n';

// import required libraries
var fs = require('fs'),
    vl = require('../build/vega-lite'),
    compactStringify = require('json-stringify-pretty-compact');

// arguments
var args = require('yargs')
  .usage(helpText)
  .demand(0)
  .boolean('p').alias('p', 'pretty')
  .describe('p', 'Output human readable/pretty spec.')
  .argv;

// input file
var specFile = args._[0] || '/dev/stdin';

// load spec, compile vg spec
fs.readFile(specFile, 'utf8', function(err, text) {
  if (err) throw err;
  var spec = JSON.parse(text);
  compile(spec);
});

function compile(vlSpec) {
  var result =  vl.myCompile(vlSpec);

  // TODO: deal with error
  var vgSpec = result;
  if (args.p) {
    process.stdout.write(compactStringify(vgSpec) + '\n');
  } else {
    process.stdout.write(JSON.stringify(vgSpec) + '\n');
  }
}