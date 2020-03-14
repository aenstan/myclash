#docker build -t subconverter:latest
#docker run -d -p 25500:25500 aenstan/subconverter:latest
#docker build -t subweb:latest
#docker run -d -p 10086:80 --restart always aenstan/subweb:latest
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh
#echo "example.com {
 gzip
 tls admin@gmail.com
 proxy / 127.0.0.0:10086 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}
example.com {
 gzip
 tls admin@gmail.com
 proxy / 127.0.0.0:10010 {
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
