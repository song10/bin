exports.json =
	json:
		name : "ninja"
		template : "get.dot"
		path : "~/wrk"
		init : "" #"sudo apt-get install -y re2c"
		clone : "git clone https://github.com/martine/ninja.git"
		checkout: """
			git reset --hard
			git co master
			"""
		pull: "git pull --rebase"
		build : """
			./bootstrap.py
			ln -f -s ~/wrk/ninja/ninja ~/opt/bin/
			"""
