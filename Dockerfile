#docker build -t subconverter:latest
#docker run -d -p 25500:25500 --restart always --name subconverter aenstan/subconverter:0.4.4
#docker build -t subweb:latest
#docker run -d -p 10086:80 --restart always --name subweb aenstan/subweb:latest
#docker run -d -p 8001:8001 --name bitly --restart always careywong/bitly:latest -token xxxxxxxxxxxxxxxxxxxxx
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh
echo "api.aenstan.xyz {
 gzip
 tls aenstan@qq.com
 proxy / 35.221.195.132:25500 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}
s.aenstan.xyz {
 gzip
 tls aenstan@qq.com
 proxy / 35.221.195.132:8001 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}
sub.aenstan.xyz {
 gzip
 tls aenstan@qq.com
 proxy / 35.221.195.132:10086 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}" > /usr/local/caddy/Caddyfile
#/etc/init.d/caddy restart
#tail -f /tmp/caddy.log
FROM tindy2013/subconverter:latest
COPY replacements/ /base/
EXPOSE 25500
