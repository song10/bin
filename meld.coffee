fs = require "fs"
dot = require "dot"
nopt = require "nopt"
path = require "path"

print = console.log
isTemplateExisted = (pathname, direcotry=__dirname) ->
  if not pathname
    return false

  if fs.existsSync pathname
    return true

  if '/' isnt pathname.charAt(0)
    nextpath = direcotry + '/' + pathname
    if fs.existsSync(nextpath)
      return nextpath

  return false

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

opt = nopt knownOpts
opt = merge d4, opt
dot.templateSettings.strip = opt.strip

if 0 is opt.argv.remain.length
  print "no data given, abort!"
  process.exit 1

tempD4 = null
fnD4 = null
if opt.template
  if isTemplateExisted opt.template
    tempD4 = fs.readFileSync opt.template, "utf-8"
    fnD4 = dot.template temp
  else
    print "template \"%s\" not found, abort!", opt.template
    process.exit 1

for x in opt.argv.remain
    temp = tempD4
    fn = fnD4
  do (x) ->
    json = require(x).json
    json = merge opt, json
    template = json.json.template
    if template and (rz = isTemplateExisted template, path.dirname x)
      if 'string' is typeof(rz)
        template = rz
      temp = fs.readFileSync template, "utf-8"
      fn = dot.template temp
    if not temp
      print "no template given for %s, abort!" % x
      return
    json._ = fs: fs
    render = fn json
    print render
