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
        get: "git clone git://github.com/ringo/ringojs.git"
        build: """
            ant update
            ant jar
            ant docs
            ln -f -s ~/wrk/ringojs/bin/ringo ~/opt/bin/ringo
            """
