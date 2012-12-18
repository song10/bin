exports.json =
	json:
		name : "ninja"
		template : "get.dot"
		path : "~/wrk"
		init : "sudo apt-get install -y checkinstall"
		clone : "git clone https://github.com/martine/ninja.git"
		checkout: """
			git reset --hard
			git co master
			"""
		pull: "git pull --rebase"
		build : """
			./bootstrap.py
			sudo mkdir -p /usr/local/bin
			sudo checkinstall cp ninja /usr/local/bin/
			cp *.deb ~/Dropbox/Public/
			"""
