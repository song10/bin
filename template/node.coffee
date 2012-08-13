exports.json =
    json:
        name: "node"
        template: "get.dot"
        path: "~/wrk"
        init: "sudo apt-get install -y libssl-dev libltdl-dev"
        get: "git clone https://github.com/joyent/node.git"
        build: """
            ./configure --prefix=$HOME/opt
            make
            make install
			#ln -f -s ~/wrk/node/deps/npm/bin/npm-cli.js ~/opt/bin/npm
            """
