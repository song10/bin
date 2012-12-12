exports.json =
	json:
		name: "node"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libssl-dev libltdl-dev systemtap-sdt-dev"
		clone: "git clone https://github.com/joyent/node.git"
		checkout: """
			git reset --hard
			git co v0.8.16-release || git co -b v0.8.16-release origin/v0.8.16-release
			"""
		pull: "git pull --rebase"
		build: """
			mkdir -p $HOME/opt2
			./configure --prefix=$HOME/opt2
			make
			make install
			"""
