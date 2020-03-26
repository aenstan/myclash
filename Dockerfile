#打包镜像
docker run -d -p 25500:25500 --restart always --name subconverter aenstan/subconverter:update
docker run -d -p 10086:80 --restart always --name subweb aenstan/subweb:update
docker run -d -p 8002:8002 --restart always --name myurls aenstan/myurls:update
docker run -d -p 6379:6379 --restart always --name myurls-redis redis:5
#安装docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
#安装docker-compose
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#安装caddy
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh
#配置caddyfile
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
 tls admin@gmail.com
 proxy / 35.221.195.132:8002 {
    transparent
    header_downstream Access-Control-Allow-Origin "*"
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
#重启caddy
/etc/init.d/caddy restart
#查看caddy启动日志
tail -f /tmp/caddy.log
#修改配置文件
FROM tindy2013/subconverter:latest
COPY base/ /base/
EXPOSE 25500
