exports.json =
	json:
		name: "node"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libssl-dev libltdl-dev systemtap-sdt-dev"
		clone: "git clone https://github.com/joyent/node.git"
		checkout: """
			git reset --hard
			git co master
			"""
		pull: "git pull --rebase"
		build: """
			mkdir -p $HOME/opt
			./configure --prefix=$HOME/opt --ninja
			#sed -i 's/#define NODE_VERSION_IS_RELEASE 0/#define NODE_VERSION_IS_RELEASE 1/' src/node_version.h
			make
			make install
			#ln -f -s ~/wrk/node/deps/npm/bin/npm-cli.js ~/opt/bin/npm
			"""
