class Environment:
    proxy = '''
unset http_proxy
unset ftp_proxy
unset all_proxy
unset socks_proxy
unset https_proxy
unset no_proxy
''' [1:]
    noproxy = proxy

    gitproxy = '''
unset GIT_PROXY_COMMAND
''' [1:]
    nogitproxy = gitproxy


env = Environment()
