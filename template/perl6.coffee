exports.json =
	json:
		name: "rakudo"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libreadline-dev"
		clone: "git clone https://github.com/rakudo/rakudo.git"
		checkout: """
			git reset --hard
			git co nom
			"""
		pull: "git pull --rebase"
		build: """
			perl Configure.pl --gen-parrot --gen-nqp
			make
			make install
			ln -f -s `pwd`/install/bin/perl6 ~/opt/bin/
			"""
