#!/usr/bin/env bash

# 创建目录
mkdir -p ./rocketmq/logs
mkdir -p ./rocketmq/store

# 设置目录权限
chmod -R 777 ./rocketmq/logs
chmod -R 777 ./rocketmq/store


# 下载并启动容器，且为 后台 自动启动
docker-compose up -d


# 显示 rocketmq 容器
docker ps |grep rocketmq