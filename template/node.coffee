exports.json =
	json:
		name: "node"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libssl-dev libltdl-dev systemtap-sdt-dev"
		get: "git clone https://github.com/joyent/node.git"
		build: """
			./configure --prefix=$HOME/opt --ninja
			sed -i 's/#define NODE_VERSION_IS_RELEASE 0/#define NODE_VERSION_IS_RELEASE 1/' src/node_version.h
			make
			make install
			#ln -f -s ~/wrk/node/deps/npm/bin/npm-cli.js ~/opt/bin/npm
			"""
