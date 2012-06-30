nopt = require("nopt")
fs = require("fs")
dot = require("dot")

print = console.log

try
	d4 = require("d4").json

merge = (o1, o2) ->
	o3 = {}
	for attr of o1
		o3[attr] = o1[attr]
	for attr of o2
		o3[attr] = o2[attr]
	o3

knownOpts =
	template: [ String, null ]
	init: Boolean
	force: Boolean
	strip: Boolean

opt = nopt(knownOpts)
opt = merge(d4, opt)
unless opt.template
	print "no template given, abort!"
	process.exit 1
else
	unless fs.existsSync(opt.template)
		unless ("/" isnt opt.template.charAt(0)) and fs.existsSync(__dirname + opt.template)
			print "template \"%s\" not found, abort!", opt.template
			process.exit 1

if 0 is opt.argv.remain.length
	print "no data given, abort!"
	process.exit 1

temp = fs.readFileSync(opt.template, "utf-8")
dot.templateSettings.strip = opt.strip
fn = dot.template(temp)
for x in opt.argv.remain
	do (x) ->
		json = require(x).json
		json = merge(opt, json)
		json._ = fs: fs
		render = fn(json)
		print render
