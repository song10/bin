class Environment:
    proxy = '''
export http_proxy=http://cache1:3128
export ftp_proxy=http://cache1:3128
export all_proxy=http://cache1:3128
export socks_proxy=http://cache1:3128
export https_proxy=http://cache1:3128
export no_proxy=http://cache1:3128
''' [1:]
    noproxy = '''
unset http_proxy
unset ftp_proxy
unset all_proxy
unset socks_proxy
unset https_proxy
unset no_proxy
''' [1:]

    gitproxy = '''
export GIT_PROXY_COMMAND=git-proxy
''' [1:]
    nogitproxy = '''
unset GIT_PROXY_COMMAND
''' [1:]

    smp = '''
unset GIT_PROXY_COMMAND
''' [1:]
    

env = Environment()
