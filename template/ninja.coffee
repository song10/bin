exports.json =
    json:
        name : "ninja"
        template : "get.dot"
        path : "~/wrk"
        init : "sudo apt-get install -y re2c"
        get : "git clone https://github.com/martine/ninja.git"
        build : """
            ./bootstrap.py
            ln -f -s ~/wrk/ninja/ninja ~/opt/bin/
            """
