# 一键部署 docker-compose

# 一键部署

```shell
git clone 
cd rocketmq-docker-compose

chmod +x  start.sh

./start.sh

```

///////////////////////////////////如果没起来再看看下面的能不能帮到你/////////////////////////////////

## 设置目录权限

```shell
chmod 777 rocketmq-docker-compose

// 不能设置权限777的同学可以设置如下 
chown 3000:3000 ./rocketmq-docker-compose/rocketmq/logs 
chown 3000:3000 ./rocketmq-docker-compose/rocketmq/store
```

## 坑1：修改brokerIP1

如果你的微服务没有放入docker或者rocketmq容器中，不能用IP直接访问。 请修改broker-a.conf、broker-b.conf、broker-a-s.conf、broker-b-s.conf
的brokerIP为宿主机IP，并去掉#。

否则会报如下错误： com.alibaba.rocketmq.remoting.exception.RemotingConnectException: connect to <172.0.0.120:10909> failed

## 运行 & 停止

```shell

docker-compose up -d // 后台启动
docker-compose down // 停止容器 + 删除镜像

```

## 查看日志

```shell
docker-compose logs -f

```

## 进入单个容器查看日志

```shell
// 容器列表，查找容器id
docker ps -a

// 进入单个容器 
docker exec -it f1b089616dd0 /bin/bash
```

## 坑2 ： Docker 配置网络 - 使用 bridge 网络, 设置内核转发

集群启动后，集群各节点不能互相通信，需要设置linux内核转发
https://blog.csdn.net/qq_16605855/article/details/79476615
默认情况下，从容器发送到默认网桥的流量，并不会被转发到外部。要开启转发，需要改变两个设置。这些不是 Docker 命令，并且它们会影响 Docker 主机的内核。

```shell
// 配置 Linux 内核来允许 IP 转发
sysctl net.ipv4.conf.all.forwarding=1

// 改变 iptables 的政策，FORWARD 政策从 DROP 变为 ACCEPT
sudo iptables -P FORWARD ACCEPT

```

这些设置在重新启动时失效，因此可能需要将它们添加到启动脚本中。

## 各节点端口

节点 宿主机端口:容器内端口 rmqnamesrv-a 9876:9876 rmqnamesrv-b 9877:9876 rmqbroker-a 10911:10911 rmqbroker-a-s 10912:10911
rmqbroker-b 10913:10911 rmqbroker-b-s 10914:10911 rmqconsole 6080:8080

rmqconsole: http://宿主机IP:6080








