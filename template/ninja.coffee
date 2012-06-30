exports.json =
	json:
		name : "ninja"
		template : "get.dot"
		path : "~/wrk"
		init : ""
		get : "git clone https://github.com/martine/ninja.git"
		build : """
			./bootstrap.py
			ln -f ninja ~/opt/bin/
			"""
