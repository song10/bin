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
			rm -f *.deb *.tgz
			./bootstrap.py
			sudo mkdir -p /usr/local/bin
			sudo checkinstall cp ninja /usr/local/bin/
			FN0=`ls *.deb`
			cp $FN0 ~/Dropbox/Public/
			"""
