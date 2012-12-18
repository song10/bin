exports.json =
	json:
		name: "node"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libssl-dev libltdl-dev systemtap-sdt-dev checkinstall"
		clone: "git clone https://github.com/joyent/node.git"
		checkout: """
			git reset --hard
			git co master
			"""
		pull: "git pull --rebase"
		build: """
			rm -f *.deb *.tgz
			./configure --ninja
			make
			sudo checkinstall make install
			cp *.deb ~/Dropbox/Public/
			"""
