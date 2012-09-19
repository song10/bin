exports.json =
	json:
		name: "virtualbox"
		template: "do.dot"
		path: "~/wrk"
		init: ""
		get: ""
		build: """
			grep /etc/apt/sources.list -e virtualbox > /dev/null
			if test 0 -ne $?; then
				echo 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' | sudo tee -a /etc/apt/sources.list > /dev/null
				sudo wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
				sudo apt-get update
			fi
			sudo apt-get -y install virtualbox-4.2 dkms
			"""
