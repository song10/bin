#!/usr/bin/env node
//(function () {
var nopt = require('nopt')
var fs = require('fs')
var dot = require('dot')
//var path = require('path')

var print = console.log

try { var d4 = require('d4.json') } catch(e) {}

var merge = function (obj1, obj2) {
	var obj3 = {}
	for (var attrname in obj1) { obj3[attrname] = obj1[attrname] }
	for (var attrname in obj2) { obj3[attrname] = obj2[attrname] }
	return obj3
}

var knownOpts = {
	"template" : [String, null],
	"init" : Boolean,
	"force": Boolean,
	"strip": Boolean
	}
var opt = nopt(knownOpts)
//console.log(opt)

//require('jquery').extend(opt, d4)
opt = merge(d4, opt)

if (! opt.template) {
	print('no template given, abort!')
	process.exit(1)
} else {
	if (!fs.existsSync(opt.template)) {
		if (('/' != opt.template.charAt(0)) && fs.existsSync(__dirname + opt.template))
			opt.template = __dirname + opt.template
		else {
			print('template "%s" not found, abort!', opt.template)
			process.exit(1)
		}
	}
}

if (0 == opt.argv.remain.length) {
	print('no data given, abort!')
	process.exit(1)
}

var temp = fs.readFileSync(opt.template,'utf-8')

dot.templateSettings.strip = opt.strip
var fn = dot.template(temp)

opt.argv.remain.forEach(function(x) {
	var json = require(x)
	json = merge(opt, json)
	json._ = {"fs":fs}
	var render = fn(json)

	print(render)
})
//}).call(this)
