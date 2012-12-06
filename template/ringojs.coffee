exports.json =
	json:
		name: "ringojs"
		template: "get.dot"
		path: "~/wrk"
		init: """
			sudo apt-get -y install ant ivy default-jdk
			mkdir -p ~/.ant/lib
			cp /usr/share/java/ivy.jar ~/.ant/lib/
			"""
		clone: "git clone git://github.com/ringo/ringojs.git"
		checkout: """
			git reset --hard
			git co master
			"""
		pull: "git pull --rebase"
		build: """
			ant update
			ant jar
			ant docs
			ln -f -s ~/wrk/ringojs/bin/ringo ~/opt/bin/ringo
			"""
