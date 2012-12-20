exports.json =
	json:
		name: "rakudo"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libreadline-dev checkinstall"
		clone: "git clone https://github.com/rakudo/rakudo.git"
		checkout: """
			git reset --hard
			git co nom
			"""
		pull: "git pull --rebase"
		build: """
			rm -f *.deb *.tgz
			echo 'perl Configure.pl --prefix=/usr/local --gen-parrot --gen-nqp' > xxx
			echo 'make' >> xxx
			echo 'make install' >> xxx
			sudo checkinstall sh ./xxx
			FN0=`ls *.deb`
			cp $FN0 ~/Dropbox/Public/
			rm -f ./xxx
			"""
