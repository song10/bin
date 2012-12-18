exports.json =
	json:
		name: "node"
		template: "get.dot"
		path: "~/wrk"
		init: "sudo apt-get install -y libssl-dev libltdl-dev systemtap-sdt-dev checkinstall"
		clone: "git clone https://github.com/joyent/node.git"
		checkout: """
			git reset --hard
			git co v0.8.16-release || git co -b v0.8.16-release origin/v0.8.16-release
			"""
		pull: "git pull --rebase"
		build: """
			./configure
			make
			sudo checkinstall make install
			FN0=`ls *.deb`
			EN="${FN0##*.}"
			FN="${FN0%.*}"
			cp $FN0 ~/Dropbox/Public/${FN}_v0_8.$EN
			"""
