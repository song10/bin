exports.json =
	json:
		name: "ringojs"
		template: "get.dot"
		path: "~/wrk"
		init: """
			sudo apt-get -y install ant ivy default-jdk cdbs
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
			ant update jar docs
			#ant package
			ant dpkg
			mv ../ringojs_*.deb ~/Dropbox/Public/
			rm -f ../ringojs*.changes ../ringojs-*.deb
			"""
